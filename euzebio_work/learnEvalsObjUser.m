valuesAlat = [1:5]+1;
valuesAlat = [5:6];
lambda = 0;

%numEvalPerIteration = 500;
numTurnos = 10;
numLearnStep = 50000;
rateEvaluate = 100;

load('evals10-10000.mat', 'evals');

for grupo=3
    idAlunos = unique(evals{grupo}(:,1));%indice de alunos por posicao nos dados
    idQuestoes = unique(evals{grupo}(:,2));%indice de questoes por ID
    numEvalPerIteration = length(evals{grupo});


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
    
    
    
    
    for Alat=valuesAlat
        thetaMax = sqrt(1e300/Alat);
        
        
        for turns=1:numTurnos
            
            thetaUser = -1+2*rand(numel(idAlunos),Alat);
            thetaUser(:, Alat) = -1;
            %thetaUser = rand(numel(idAlunos),Alat);
            
            %thetaObj = -1+2*rand(numel(idQuestoes),Alat);
            thetaObj = rand(numel(idQuestoes),Alat);
            %thetaObj = eye(Alat);
            

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


                    aucPlot = [aucPlot auc/size(evals{grupo},1)];
                    erroPlot = [erroPlot erro/size(evals{grupo},1)];
                    disp(['auc = ' num2str(auc/size(evals{grupo},1))]);
                    disp(['loglikelihood = ' num2str(erro/size(evals{grupo}, 1))]);

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
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
%             for iterations=1:numLearnStep
%                 
%                 if mod(iterations,rateEvaluate) == 0
%                     auc = 0;
%                     erro = 0;
%                     for i=1:size(evals{grupo}, 1)
%                         u = find(idAlunos==evals{grupo}(i,1));
%                         q = find(idQuestoes==evals{grupo}(i,2));
%                         auc = auc + (evals{grupo}(i,3)==((thetaObj(q,:)*thetaUser(u,:)')>0));
%                         x = thetaObj(q,:)*thetaUser(u,:)';
%                         if evals{grupo}(i,3)
%                             if (-sigma*x > 700)
%                                 erro = erro - 1e300;
%                             else
%                                 erro = erro + log(1/(1+exp(-sigma*x)));
%                             end
%                         else
%                             if (-sigma*x > 700)
%                                 erro = erro;
%                             else
%                                 erro = erro + log(1 - 1/(1+exp(-sigma*x)));
%                             end
%                         end
%                     end
%                     erro = erro - lambda*(sum(sum(thetaObj.^2))+sum(sum(thetaUser.^2)));
%                     
%                     aucPlot(iterations/rateEvaluate,turns) = auc/size(evals{grupo}, 1);
%                     %sqrt(auc)/(nObj*nUser)
%                     [grupo turns Alat]
%                     disp(['auc = ' num2str(auc/size(evals{grupo},1))]);
%                     disp(['loglikelihood = ' num2str(erro/size(evals{grupo}, 1))]);
%                     disp(['percentage de execution = ' num2str(iterations/numLearnStep)]);
%                     erroPlot(iterations/rateEvaluate,turns) = erro/size(evals{grupo}, 1);
%                     %max(max(abs(thetaObj*thetaUser')))
%                     
%                     %         pause
%                 end
%                 
%                 deltaUser1 = zeros(numel(idAlunos),Alat);
%                 deltaObj1 = zeros(numel(idQuestoes),Alat);
%                 
%                 for i=1:numEvalPerIteration
%                     %          for index=1:size(evals,1)
%                     index = randi(size(evals{grupo}, 1));
%                     u = find(idAlunos==evals{grupo}(index,1));
%                     q = find(idQuestoes==evals{grupo}(index,2));
%                     
%                     if evals{grupo}(index,3)
%                         x = (thetaObj(q,:))*thetaUser(u,:)'; %calcula x_uij
%                         deltaUser1(u,:) = deltaUser1(u,:) + sigma*exp(-sigma*x)/(1+exp(-sigma*x))*thetaObj(q,:); %calcula gradiente de sigma
%                         deltaObj1(q,:) = deltaObj1(q,:) + sigma*exp(-sigma*x)/(1+exp(-sigma*x))*thetaUser(u,:); %calcula gradiente de sigma
%                     else
%                         x = (thetaObj(q,:))*thetaUser(u,:)'; %calcula x_uij
%                         deltaUser1(u,:) = deltaUser1(u,:) - sigma/(1+exp(-sigma*x))*thetaObj(q,:); %calcula gradiente de sigma
%                         deltaObj1(q,:) = deltaObj1(q,:) - sigma/(1+exp(-sigma*x))*thetaUser(u,:); %calcula gradiente de sigma
%                     end
%                 end
%                 
%                 deltaUser2 = -2*lambda*thetaUser; %gradiente da gaussiana
%                 deltaObj2 = -2*lambda*thetaObj; %gradiente da gaussiana
%                 deltaUser = deltaUser1/numEvalPerIteration + deltaUser2;  %gradiente total
%                 deltaObj = deltaObj1/numEvalPerIteration + deltaObj2;  %gradiente total
%                 
%                 if any(any(isnan(deltaUser)))
%                     disp(3)
%                 end
%                 
%                 %thetaUser = thetaUser + alpha*deltaUser; %atualiza theta
%                 thetaUser = max(min(thetaUser + alpha*deltaUser,thetaMax),-thetaMax);
%                 thetaUser(:, Alat) = -1;
%                 %         thetaUser(1) = max(min(thetaUser(1) + alpha*deltaUser(1),thetaMax),-thetaMax);
%                 
%                 %thetaObj = thetaObj + alpha*deltaObj; %atualiza theta
%                 thetaObj = max(min(thetaObj + alpha*deltaObj,thetaMax),0);
%             end
            save(strcat('thetas-grupo-', num2str(grupo), 'Alat-', num2str(Alat), '-turn-', num2str(turns), '.mat'), 'alphaPlot', 'Alat', 'grupo', 'thetaObj', 'thetaUser', 'aucPlot', 'erroPlot');
        end
    end
end