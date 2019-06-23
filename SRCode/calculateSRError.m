function recError = calculateSRError(dictionary,allfeats,paramSR)
%% Calculate the sparse reconstruction errors.
allfeats = normVector(allfeats);%ÿ�й�һ��
dictionary = normVector(dictionary);%ÿ�й�һ��

paramSR.L = length(allfeats(:,1)); %����ά��                               

beta = mexLasso(allfeats, dictionary, paramSR);%����ϡ��ϵ��
beta = full(beta);%ϡ�����ת��Ϊȫ����

recError = sum((allfeats - dictionary*beta(1:size(dictionary,2),:)).^2); 

recError = (recError -   min(recError(:)))/(max(recError(:)) - min(recError(:)));