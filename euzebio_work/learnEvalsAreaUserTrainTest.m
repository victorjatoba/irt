Alat=1+1;
lambda = 0;

%numEvalPerIteration = 500;
numTurnos = 10;
numLearnStep = 50000;
rateEvaluate = 100;

load('evals10-10000.mat', 'evals');
load('areaItens.mat');
areas = unique([COD_AREA(:, 2)]);

for grupo1=1:10
    
    for a=1:numel(areas)
        thetaMax = sqrt(1e300/Alat);
        
        for turns=1:numTurnos
            
            ind = randsample([1:grupo1-1 grupo1+1:10], 1);
            grupo2 = ind(1);
            
            %[grupo1 turns]
            
            load(strcat('area-theta-grupo-', num2str(grupo1), '-', areas{a}(2:3), '-turn-', num2str(turns), '.mat'), 'a', 'thetaObj');
            
            questoesArea = unique([COD_AREA{find(strcmp(COD_AREA(:, 2),areas(a))), 1}]');
            
            idAlunos = unique(evals{grupo2}(:,1));%indice de alunos por posicao nos dados
            idQuestoes = unique(evals{grupo1}(:, 2));
            idQuestoes = idQuestoes(ismember(idQuestoes, questoesArea));
            
            idQuestoesTrain = sort(randsample(idQuestoes, round(numel(idQuestoes)/2)));
            idQuestoesTest = questoesArea(~ismember(idQuestoes, idQuestoesTrain));
            
            evalsTrain = evals{grupo2}(ismember(evals{grupo2}(:,2),idQuestoesTrain),:);
            evalsTest = evals{grupo2}(ismember(evals{grupo2}(:,2),idQuestoesTest),:);
            
            numEvalPerIteration = length(evalsTrain);
            
            evalsPositivo = zeros(length(idQuestoes),length(idAlunos));
            evalsNegativo = zeros(length(idQuestoes),length(idAlunos));
            for i=1:size(evalsTrain,1)
                u = find(idAlunos==evalsTrain(i,1));
                q = find(idQuestoes==evalsTrain(i,2));
                if evalsTrain(i,3)
                    evalsPositivo(q,u) = 1;
                else
                    evalsNegativo(q,u) = 1;
                end
            end
            
            thetaUser = -1+2*rand(numel(idAlunos),Alat);
            thetaUser(:, Alat) = -1;
            %thetaObj = rand(numel(idQuestoes),Alat);
            
            
            alpha = 1000;
            aucPlot = [];
            erroPlot = [];
            alphaPlot = [];
            
            
            iterations = 0;
            while iterations<numLearnStep && (length(aucPlot)<10 || (max(aucPlot(end-9:end)) - min(aucPlot(end-9:end)))>0.001)
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
                    
                    
                    aucPlot = [aucPlot auc/size(evalsTrain,1)];
                    erroPlot = [erroPlot erro/size(evalsTrain,1)];
                    disp(['auc = ' num2str(auc/size(evalsTrain,1))]);
                    disp(['loglikelihood = ' num2str(erro/size(evalsTrain, 1))]);
                    
                    if length(erroPlot) > 1 && erroPlot(end) < erroPlot(end-1)
                        alpha = alpha/2;
                    end
                    alphaPlot = [alphaPlot alpha];
                end
                
                
                x = thetaObj*thetaUser';
                expSigmaPositivo = exp(-x)./(1+exp(-x));
                expSigmaNegativo = exp(x)./(1+exp(x));
                
                deltaUser = (evalsPositivo.*expSigmaPositivo)'*thetaObj - (evalsNegativo.*expSigmaNegativo)'*thetaObj;
                %deltaObj = (evalsPositivo.*expSigmaPositivo)*thetaUser - (evalsNegativo.*expSigmaNegativo)*thetaUser;
                
                deltaUser = deltaUser/numEvalPerIteration;
                %deltaObj = deltaObj/numEvalPerIteration;
                
                if any(any(isnan(deltaUser)))
                    disp('debug 2')
                    break;
                end
                
                thetaUser = max(min(thetaUser + alpha*deltaUser,thetaMax),-thetaMax);
                thetaUser(:,Alat) = -1;
                
                
                %thetaObj = max(min(thetaObj + alpha*deltaObj,thetaMax),-thetaMax);
                %thetaObj(:,1:Alat-1) = max(thetaObj(:,1:Alat-1),0);
                
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            evalsPositivo = zeros(length(idQuestoes),length(idAlunos));
            evalsNegativo = zeros(length(idQuestoes),length(idAlunos));
            for i=1:size(evalsTest,1)
                u = find(idAlunos==evalsTest(i,1));
                q = find(idQuestoes==evalsTest(i,2));
                if evalsTest(i,3)
                    evalsPositivo(q,u) = 1;
                else
                    evalsNegativo(q,u) = 1;
                end
            end
            
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
            
            auc = auc/size(evalsTest,1);
            erro = erro/size(evalsTest, 1);
            disp(['aucTransferido = ' num2str(auc)]);
            disp(['loglikelihoodTransferido = ' num2str(erro)]);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            save(strcat('test-area-users-grupo1-', num2str(grupo1),'-Alat-', num2str(Alat),'-', areas{a}(2:3), '-turn-', num2str(turns), '-grupo2-', num2str(grupo2), '.mat'), 'Alat', 'grupo1', 'grupo2', 'thetaObj', 'thetaUser', 'auc', 'erro', 'idQuestoes');
        end
    end
end