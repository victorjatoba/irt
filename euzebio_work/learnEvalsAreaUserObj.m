Alat = 1+1;
lambda = 0;

%numEvalPerIteration = 500;
numTurnos = 10;
numLearnStep = 50000;
rateEvaluate = 100;

load('evals10-10000.mat', 'evals');
load('areaItens.mat');
areas = unique([COD_AREA(:, 2)]);

for grupo=1:10
    thetaMax = sqrt(1e300/Alat);
    
    for a=1:numel(areas)
        aucPlot = [];
        questoesArea = unique([COD_AREA{find(strcmp(COD_AREA(:, 2),areas(a))), 1}]');
        evalsDoGrupo = evals{grupo}(ismember(evals{grupo}(:,2),questoesArea),:);
        idQuestoes = unique(evalsDoGrupo(:,2));
        idAlunos = unique(evalsDoGrupo(:,1));%indice de alunos por posicao nos dados
        
        erroPlot = [];
        thetaMax = sqrt(1e300/Alat);
        numEvalPerIteration = length(evalsDoGrupo);
        
        
        for turns=1:numTurnos
            
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
            
            thetaUser = -1+2*rand(numel(idAlunos),Alat);
            thetaUser(:, Alat) = -1;
            thetaObj = rand(numel(idQuestoes),Alat);
            
            
            alpha = 1000;
            aucPlot = [];
            erroPlot = [];
            alphaPlot = [];
            
            threshold = 20;
            
            iterations = 0;
            while iterations<numLearnStep && (length(aucPlot)<threshold || (max(aucPlot(end-threshold+1:end)) - min(aucPlot(end-threshold+1:end)))>0.001)
                iterations = iterations + 1;
                if mod(iterations,rateEvaluate) == 0
                    x = thetaObj*thetaUser';
                    f = 1./(1+exp(-x));
                    logF = max(log(f),-1e300);
                    log1menosF = max(log(1-f),-1e300);
                    erro = sum(sum(evalsPositivo.*logF)) + sum(sum(evalsNegativo.*log1menosF));  %nao inclui lambda
                    
                    auc = sum(sum(evalsPositivo.*(f>.5))) + sum(sum(evalsNegativo.*(f<=.5)));
                    if isnan(erro)
                        disp('debug 1')
                        break;
                    end
                    
                    
                    aucPlot = [aucPlot auc/size(evalsDoGrupo,1)];
                    erroPlot = [erroPlot erro/size(evalsDoGrupo,1)];
                    disp(['auc = ' num2str(auc/size(evalsDoGrupo,1))]);
                    disp(['loglikelihood = ' num2str(erro/size(evalsDoGrupo, 1))]);
                    
                    if length(erroPlot) > 1 && erroPlot(end) < erroPlot(end-1)
                        alpha = alpha/2;
                    end
                    alphaPlot = [alphaPlot alpha];
                end
                
                
                x = thetaObj*thetaUser';
                expSigmaPositivo = exp(-x)./(1+exp(-x));
                expSigmaNegativo = exp(x)./(1+exp(x));
                
                deltaUser = (evalsPositivo.*expSigmaPositivo)'*thetaObj - (evalsNegativo.*expSigmaNegativo)'*thetaObj;
                deltaObj = (evalsPositivo.*expSigmaPositivo)*thetaUser - (evalsNegativo.*expSigmaNegativo)*thetaUser;
                
                deltaUser = deltaUser/numEvalPerIteration;
                deltaObj = deltaObj/numEvalPerIteration;
                
                if any(any(isnan(deltaUser))) || any(any(isnan(deltaObj)))
                    disp('debug 2')
                    break;
                end
                
                thetaUser = max(min(thetaUser + alpha*deltaUser,thetaMax),-thetaMax);
                thetaUser(:,Alat) = -1;
                
                
                thetaObj = max(min(thetaObj + alpha*deltaObj,thetaMax),-thetaMax);
                thetaObj(:,1:Alat-1) = max(thetaObj(:,1:Alat-1),0);
                
            end
            
            save(strcat('area-theta-grupo-', num2str(grupo), '-', areas{a}(2:3), '-turn-', num2str(turns), '.mat'), 'a','alphaPlot', 'Alat', 'grupo', 'thetaObj', 'thetaUser', 'aucPlot', 'erroPlot', 'idQuestoes');
        end
    end
end