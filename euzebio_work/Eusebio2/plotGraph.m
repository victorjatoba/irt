options = ['b- ';'b-.';'g- ';'g-.';'r- ';'r-.';'m- ';'m-.';'c- ';'c-.';'k- ';'k-.'];
indLeg = 0;
index = 0;

% figure
% hold on

legendas = [];


aucs = zeros(1,11);
predict1 = cell(1,10+1);
predict2 = cell(1,10+1);
count = zeros(1,11);


load('evals10-10000.mat', 'evals');


for grupo=[1:10]
    
    idAlunos = unique(evals{grupo}(:,1));%indice de alunos por posicao nos dados
    idQuestoes = unique(evals{grupo}(:,2));%indice de questoes por ID

    evalsPositivo = zeros(length(idQuestoes),length(idAlunos));
    evalsNegativo = zeros(length(idQuestoes),length(idAlunos));
    for i=1:size(evals{grupo},1)
        u = find(idAlunos==evals{grupo}(i,1));
        q = find(idQuestoes==evals{grupo}(i,2));
        if evals{grupo}(i,3)
            evalsPositivo(q,u) = 1;
        else
            evalsNegativo(q,u) = 1;
        end
    end
    
for turns=[1:10]
for Alat=[2:11]

    arquivo = strcat('thetas-grupo-', num2str(grupo), 'Alat-', num2str(Alat), '-turn-', num2str(turns), '.mat');
    
    fid = fopen(arquivo);
    if fid < 0
        continue;
    end
    fclose(fid);
    
    load(arquivo);
    
    
    x = thetaObj*thetaUser';
    f1 = 1./(1+exp(-x));
    f2 = .2 + (1-.2)*1./(1+exp(-x));

    count(Alat-1) = count(Alat-1) + 1;

    auc = (sum(sum(evalsPositivo.*(x>0))) + sum(sum(evalsNegativo.*(x<=0))))/size(evals{grupo},1);
%     auc = (sum(sum(evalsPositivo.*(f>0.5))) + sum(sum(evalsNegativo.*(f<=0.5))))/size(evals{grupo},1);
    aucs(Alat-1) = aucs(Alat-1) + auc;
    
    predictPerUser = sum((evalsPositivo + evalsNegativo).*(x>0))   +  (mean(evals{grupo}(:,3))*180 - mean(x(:)>0)*180);
    predictPerUser1 = sum((evalsPositivo + evalsNegativo).*f1);
    predictPerUser2 = sum((evalsPositivo + evalsNegativo).*f2);
    
%     predictPerUser = mean(evals{grupo}(:,3))*180;

    predict1{Alat-1} = [predict1{Alat-1} (abs(predictPerUser1 - sum(evalsPositivo))).^2];
    predict2{Alat-1} = [predict2{Alat-1} (abs(predictPerUser2 - sum(evalsPositivo))).^2];

    
%     indLeg = indLeg + 1;
%     plot(aucPlot,options(index+1,:));    
%     legendas{indLeg} = arquivo;
%     index = mod(index+1,size(options,1));

end
end
    x = rand(length(idQuestoes),length(idAlunos));
    rateQ = sum(evalsNegativo,2)./(sum(evalsNegativo,2) + sum(evalsPositivo,2));
    rateA = sum(evalsNegativo,1)./(sum(evalsNegativo,1) + sum(evalsPositivo,1));
    rate = rateQ*rateA>0.295;
%     rate = rateQ*ones(1,length(idAlunos))>0.5;
%     rate = ones(length(idQuestoes),1)*rateA>0.5;

    count(11) = count(11) + 1;

    auc = (sum(sum(evalsPositivo.*(x>rate))) + sum(sum(evalsNegativo.*(x<=rate))))/size(evals{grupo},1);
    
    
    
    aucs(11) = aucs(11) + auc;
    predictPerUser = mean(evals{grupo}(:,3))*180;
    predict1{11} = [predict1{11} (abs(predictPerUser - sum(evalsPositivo)))];
end

maxSize = 0;
for Alat=1:11
    maxSize = max(maxSize,length(predict1{Alat}));
end

data = NaN(maxSize,10);

for Alat=1:10
    data(1:length(predict1{Alat}),Alat) = predict1{Alat}';
end

boxplot(data)


%plot(1:10,aucs(1:end-1)./count(1:end-1)) 


% legend(legendas)