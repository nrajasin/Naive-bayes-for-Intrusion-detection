%loadARFF('NSL/KDDTrain+.arff')
clc
clear all
close all

%## paths
WEKA_HOME = 'C:\Program Files\Weka-3-8';
javaaddpath([WEKA_HOME '\weka.jar']);
%fName = [NSL KDD train];
fName = ['NSL\KDDTrain+.arff'];

%## read file
loader = weka.core.converters.ArffLoader();
loader.setFile( java.io.File(fName) );
D = loader.getDataSet();
D.setClassIndex( D.numAttributes()-1 );

%## dataset
relationName = char(D.relationName);
numAttr = D.numAttributes;
numInst = D.numInstances;

%## attributes
%# attribute names
attributeNames = arrayfun(@(k) char(D.attribute(k).name), 0:numAttr-1, 'Uni',false);

%# attribute types
types = {'numeric' 'nominal' 'string' 'date' 'relational'};
attributeTypes = arrayfun(@(k) D.attribute(k-1).type, 1:numAttr);
attributeTypes = types(attributeTypes+1);

%# nominal attribute values
nominalValues = cell(numAttr,1);
for i=1:numAttr
    if strcmpi(attributeTypes{i},'nominal')
        nominalValues{i} = arrayfun(@(k) char(D.attribute(i-1).value(k-1)), 1:D.attribute(i-1).numValues, 'Uni',false);
    end
end

%## instances
data = zeros(numInst,numAttr);
len=length(D.attributeToDoubleArray(1));

for i=1:numAttr
    newdata=D.attributeToDoubleArray(i-1);
    for j=1:len
        if newdata(j)<1
            newdata(j)=round(newdata(j));
        end
    end
    data(:,i) = newdata;
end

%[ discdata,discvalues,discscheme ] = cacc(data);
%3-nom,5-num,6-num,12-nom,23-num,24-num,25-num,26-num,31-num,32-num,33-num,35-num
[ DiscreData,DiscretizationSet ] = CACC_Discretization( data, 3 );

data=DiscreData;

Trainingdata(:,1)=data(:,3);
Trainingdata(:,2)=data(:,5);
Trainingdata(:,3)=data(:,6);
Trainingdata(:,4)=data(:,12);
Trainingdata(:,5)=data(:,23);
Trainingdata(:,6)=data(:,24);
Trainingdata(:,7)=data(:,25);
Trainingdata(:,8)=data(:,26);
Trainingdata(:,9)=data(:,31);
Trainingdata(:,10)=data(:,32);
Trainingdata(:,11)=data(:,33);
Trainingdata(:,12)=data(:,35);

Traininglabels=data(:,42);



save('training.mat','Trainingdata','Traininglabels')
% % ## visualize data
% parallelcoords(data(:,1:end-1), ...
%     'Group',nominalValues{end}(data(:,end)+1), ...
%     'Labels',attributeNames(1:end-1))
% title(relationName)