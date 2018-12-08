%loadARFF('NSL/KDDTrain+.arff')
clc
clear all
close all

%## paths
WEKA_HOME = 'C:\Program Files\Weka-3-8';
javaaddpath([WEKA_HOME '\weka.jar']);
%fName = ['iris.arff'];
fName = ['NSL\KDDTest+.arff'];

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
for i=1:numAttr
    data(:,i) = D.attributeToDoubleArray(i-1);
end


% data = zeros(numInst,numAttr);
% len=length(D.attributeToDoubleArray(1));
% for i=1:numAttr
%     newdata=D.attributeToDoubleArray(i-1);
%     for j=1:len
%         if newdata(j)<1
%             newdata(j)=round(newdata(j));
%         end
%     end
%     data(:,i) = newdata;
% end
%3-nom,5-num,6-num,12-nom,23-num,24-num,25-num,26-num,31-num,32-num,33-num,35-num
[ DiscreData,DiscretizationSet ] = CACC_Discretization( data, 3 );
data=DiscreData;

Testingdata(:,1)=data(:,3);
Testingdata(:,2)=data(:,5);
Testingdata(:,3)=data(:,6);
Testingdata(:,4)=data(:,12);
Testingdata(:,5)=data(:,23);
Testingdata(:,6)=data(:,24);
Testingdata(:,7)=data(:,25);
Testingdata(:,8)=data(:,26);
Testingdata(:,9)=data(:,31);
Testingdata(:,10)=data(:,32);
Testingdata(:,11)=data(:,33);
Testingdata(:,12)=data(:,35);

Testinglabels=data(:,42);



save('testing.mat','Testingdata','Testinglabels')
% % ## visualize data
% parallelcoords(data(:,1:end-1), ...
%     'Group',nominalValues{end}(data(:,end)+1), ...
%     'Labels',attributeNames(1:end-1))
% title(relationName)