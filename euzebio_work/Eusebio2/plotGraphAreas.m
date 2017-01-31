options = ['b- ';'b-.';'g- ';'g-.';'r- ';'r-.';'m- ';'m-.';'c- ';'c-.';'k- ';'k-.'];
indLeg = 0;
index = 0;

% figure
% hold on

legendas = [];

load('evals10-10000.mat', 'evals');
load('areaItens.mat');
areas = unique([COD_AREA(:, 2)]);

aucs = zeros(1,numel(areas));
predict = cell(1,numel(areas));
count = zeros(1,numel(areas));

for a=[1:4] %areas
    for grupo=[1:10]
        
        questoesArea = unique([COD_AREA{find(strcmp(COD_AREA(:, 2),areas(a))), 1}]');
        evalsDoGrupo = evals{grupo}(ismember(evals{grupo}(:,2),questoesArea),:);
        idQuestoes = unique(evalsDoGrupo(:,2));
        idAlunos = unique(evalsDoGrupo(:,1));%indice de alunos por posicao nos dados
        
        evalsPositivo = zeros(length(idQuestoes),length(idAlunos));
        evalsNegativo = zeros(length(idQuestoes),length(idAlunos));
        for i=1:size(evalsDoGrupo,1)
            u = find(idAlunos==evalsDoGrupo(i,1));
            q = find(idQuestoes==evalsDoGrupo(i,2));
            if evalsDoGrupo(i,3)
                evalsPositivo(q,u) = 1;
            else
                evalsNegativo(q,u) = 1;
            end
        end
        
        for turns=[1:10]
            
            arquivo = strcat('area-theta-grupo-', num2str(grupo), '-', areas{a}(2:3), '-turn-', num2str(turns), '.mat');
            
            fid = fopen(arquivo);
            if fid < 0
                continue;
            end
            fclose(fid);
            
            load(arquivo);
            
            
            x = thetaObj*thetaUser';
            %     f = .2 + (1-.2)*1./(1+exp(-x));
            
            count(a) = count(a) + 1;
            
            auc = (sum(sum(evalsPositivo.*(x>0))) + sum(sum(evalsNegativo.*(x<=0))))/size(evalsDoGrupo,1);
            %     auc = (sum(sum(evalsPositivo.*(f>0.5))) + sum(sum(evalsNegativo.*(f<=0.5))))/size(evals{grupo},1);
            aucs(a) = aucs(a) + auc;
            
            %predictPerUser = sum((evalsPositivo + evalsNegativo).*(x>0))   +  (mean(evalsDoGrupo(:,3))*180 - mean(x(:)>0)*180);
            %     predictPerUser = mean(evals{grupo}(:,3))*180;
            %predict{a} = [predict{a} (abs(predictPerUser - sum(evalsPositivo)))];
            
            
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
    
        count(numel(areas)) = count(numel(areas)) + 1;
    
        auc = (sum(sum(evalsPositivo.*(x>rate))) + sum(sum(evalsNegativo.*(x<=rate))))/size(evalsDoGrupo,1);
    
end
%
% maxSize = 0;
% for a=1:numel(areas)
%     maxSize = max(maxSize,length(predict{a}));
% end
%
% data = NaN(maxSize,numel(areas));
%
% for a=1:numel(areas)
%     data(1:length(predict{a}),a) = predict{a}';
% end

%boxplot(data)

bar(1:4,aucs(1:end)./count(1:end))
%plot(1:10,aucs(1:end-1)./count(1:end-1))


% legend(legendas)