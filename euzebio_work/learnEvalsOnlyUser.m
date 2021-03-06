tic;

%valuesAlat = [1 2 3 4 5 10 20 30 40 50];
valuesAlat = 4;
alpha = 10;
lambda = 0;
sigma = 1;

numEvalPerIteration = 500;
numTurnos = 1;
numLearnStep = 5000;
rateEvaluate = 100;

load('evalsTest.mat');
load('areaItens.mat');


for turns=1:numTurnos
    % Seleção dos grupos
    idAlunos = unique(evals(:,1)); % Indice de alunos por posicao nos dados (vetor de ids)
    idQuestoes = unique(evals(:,2)); % Indice de questoes por ID (vetor de ids)
    idQuestoesTrain = datasample(unique(evals(:,2)), round(numel(unique(evals(:,2)))/2), 'Replace', false); % pega metade das 180 questoes

    evalsTrain = evals(ismember(evals(:,2),idQuestoesTrain),:); % Questoes de (Grupo) treinamento 125547x3
    evalsTest = evals(~ismember(evals(:,2),idQuestoesTrain),:); % Questoes de (Grupo) teste 125203x3

    for Alat =valuesAlat % 4 itetacoes
        % Primeiro gera-se, com o algoritmo e os microdados adaptados, o modelo de atributos latentes dos itens do ENEM para um dos grupos de dados.
        % Inicializa os estimadores thetaUser e thetaObj
        
        % load(strcat('Alat-', num2str(Alat),'-turn-1-workspace.mat'));
        aucPlot = [];
        thetaMax = sqrt(1e300/sigma/Alat); % Valores maximos para o theta. =~ 2.5*10^299

        erroPlot = [];
        
        thetaUser = -1+2*rand(numel(idAlunos),Alat); % init matrix 1461 x 4
        %thetaUser = rand(numel(idAlunos),Alat);
        
        thetaUser(:,Alat) = -1; % inicializa ultima coluna com -1
        
        thetaObj = -1+2*rand(numel(idQuestoes),Alat); %init matrix 185 x 4
        %thetaObj = eye(Alat);
        
        for iterations=1:numLearnStep % 5000 itetacoes
            
            if mod(iterations,rateEvaluate) == 0 % Entra nas primeiras 99 iteracoes
                auc = 0;
                erro = 0;
                for i=1:size(evalsTrain,1) % 132336 it
                    u = find(idAlunos==evalsTrain(i,1)); % retorna a posicao do aluno (elem i) do vetor idAlunos
                    q = find(idQuestoes==evalsTrain(i,2)); % retorna a posicao da questao (elem i) do vetor idQuestoes
                    % thetaUser(u,:) Traz a linha u
                    % ' é a transporta da matriz
                    % ((thetaObj(q,:)*thetaUser(u,:)')>0) Retorna 1 se o produto das matrizes for maior que 1
                    % evalsTrain(i,3) resposta do usuario i a questao j
                    auc = auc + (evalsTrain(i,3)==((thetaObj(q,:)*thetaUser(u,:)')>0)); % soma da verificacao da igualdade entre o produto e a resposta
                    x = thetaObj(q,:)*thetaUser(u,:)'; % produto dos vetores
                    if evalsTrain(i,3) % se a resposta for correta
                        if (-sigma*x > 700) % Nunca entra
                            erro = erro - 1e300;
                            disp('#1#')
                        else
                            erro = erro + log(1/(1+exp(-sigma*x))); % Calcula P
                        end
                    else
                        if (-sigma*x > 700) % Nunca entra
                            disp('#2#')
                            erro = erro;
                        else
                            erro = erro + log(1 - 1/(1+exp(-sigma*x))); % Calcula Q
                        end
                    end
                end
                erro = erro - lambda*(sum(sum(thetaObj.^2))+sum(sum(thetaUser.^2))); % erro nao eh alterado

                aucPlot(iterations/rateEvaluate,turns) = auc/size(evalsTrain,1); % vetor com 50 itens
                %sqrt(auc)/(nObj*nUser)
                
                disp(['auc = ' num2str(auc/size(evalsTrain,1))]);
                disp(['loglikelihood = ' num2str(erro/size(evalsTrain,1))]);
                disp(['percentage de execution = ' num2str(iterations/numLearnStep)]);
                erroPlot(iterations/rateEvaluate,turns) = erro/size(evalsTrain,1);
                
                %max(max(abs(thetaObj*thetaUser')))

                %         pause
            end
            
            
            
            deltaUser1 = zeros(numel(idAlunos),Alat); % Init matriz com zeros
            %deltaObj1 = zeros(numel(idQuestoes),Alat);
            
            for i=1:numEvalPerIteration % 500 it
                % Algoritmo busca por gradiente
                index = randi(size(evalsTrain,1));
                u = find(idAlunos==evalsTrain(index,1)); % Id do aluno
                q = find(idQuestoes==evalsTrain(index,2)); % Id da questao
                
                if evalsTrain(index,3)
                    x = (thetaObj(q,:))*thetaUser(u,:)'; %calcula x_uij
                    deltaUser1(u,:) = deltaUser1(u,:) + sigma*exp(-sigma*x)/(1+exp(-sigma*x))*thetaObj(q,:); %calcula gradiente de sigma
                    %deltaObj1(q,:) = deltaObj1(q,:) + sigma*exp(-sigma*x)/(1+exp(-sigma*x))*thetaUser(u,:); %calcula gradiente de sigma
                else
                    x = (thetaObj(q,:))*thetaUser(u,:)'; %calcula x_uij
                    deltaUser1(u,:) = deltaUser1(u,:) - sigma/(1+exp(-sigma*x))*thetaObj(q,:); %calcula gradiente de sigma
                    %deltaObj1(q,:) = deltaObj1(q,:) - sigma/(1+exp(-sigma*x))*thetaUser(u,:); %calcula gradiente de sigma
                end
            end
            
            deltaUser2 = -2*lambda*thetaUser; %gradiente da gaussiana
            %deltaObj2 = -2*lambda*thetaObj; %gradiente da gaussiana
            deltaUser = deltaUser1/numEvalPerIteration + deltaUser2;  %gradiente total
            %deltaObj = deltaObj1/numEvalPerIteration + deltaObj2;  %gradiente total
            
            if any(any(isnan(deltaUser)))
                disp(3)
            end
            
            %thetaUser = thetaUser + alpha*deltaUser; %atualiza theta
            % Atualizacao do gradiente (theta em t+1)
            thetaUser = max(min(thetaUser + alpha*deltaUser,thetaMax),-thetaMax);
                    thetaUser(:,Alat) = -1;

            %         thetaUser(1) = max(min(thetaUser(1) + alpha*deltaUser(1),thetaMax),-thetaMax);
            
            %thetaObj = thetaObj + alpha*deltaObj; %atualiza theta
            %thetaObj = max(min(thetaObj + alpha*deltaObj,thetaMax),-thetaMax);
        end
        
        auc = 0;
        erro = 0;
        
        for i=1:size(evalsTest,1) % 126414 it
            u = find(idAlunos==evalsTest(i,1));
            q = find(idQuestoes==evalsTest(i,2));
            
            auc = auc + (evalsTest(i,3)==((thetaObj(q,:)*thetaUser(u,:)')>0));
            x = thetaObj(q,:)*thetaUser(u,:)';
            if evalsTest(i,3)
                if (-sigma*x > 700)
                    erro = erro - 1e300;
                else
                    erro = erro + log(1/(1+exp(-sigma*x)));
                end
            else
                if (-sigma*x > 700)
                    erro = erro;
                else
                    erro = erro + log(1 - 1/(1+exp(-sigma*x)));
                end
            end
        end
        erro = erro - lambda*(sum(sum(thetaObj.^2))+sum(sum(thetaUser.^2)));
        
        auc = auc/size(evalsTest,1)
        erro = erro/size(evalsTest,1)
        
        save(strcat('user2-Alat-', num2str(Alat), '-turn-', num2str(turns), '.mat'), 'alpha', 'thetaObj', 'thetaUser', 'aucPlot', 'erroPlot', 'auc', 'erro', 'idQuestoesTrain');
    end
end

toc;