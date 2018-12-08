load training.mat;
load testing.mat;


Mdl = fitcnb(Trainingdata,Traininglabels,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'));

 CVMdl = crossval(Mdl);
Loss = kfoldLoss(CVMdl)

testlabel = predict(Mdl ,Testingdata);
CP = classperf(Testinglabels, testlabel);
Test_error =CP.ErrorRate