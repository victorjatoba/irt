% load evals10-10000.mat
% evals = evals{1};

dataDif = [];
for i=1:185
    dataDif = [dataDif mean(evals(find(evals(:,2) == idQuestoes(i)),3))];
end
plot(thetaObj(:,Alat),dataDif,'.')

%%
grupo = 1;
idAlunos = unique(evals{grupo}(:,1));%indice de alunos por posicao nos dados
idQuestoes = unique(evals{grupo}(:,2));%indice de questoes por ID

nQ = length(idQuestoes);
nA = length(idAlunos);

matriz = NaN(nA,nQ);

for i=1:nQ
    a = find( evals{grupo}(:,2) == idQuestoes(i) );
    for k=a'
        matriz(find(idAlunos==evals{grupo}(k,1)),i) = evals{grupo}(k,3);
    end
    i
end


data = NaN(nQ,nQ);
for i=1:nQ
    for j=i:nQ
        count = [];
        for k=1:nA
            if ~any(isnan(matriz(k,[i j])))
                count = [count; [matriz(k,i) matriz(k,j)]];
            end
        end
        if ~isempty(count)
            data(i,j) = mean(count(:,1).*count(:,2)) - mean(count(:,1))*mean(count(:,2));
            data(j,i) = data(i,j);
        end
    end
    i
end
save data.mat data matriz

%%


load data.mat

amplitude = diag(thetaObj(:,1:Alat-1)*thetaObj(:,1:Alat-1)');
covariancia = nanmean(abs(data)); 
index = ones(1,185);
% index(find(sum(isnan(data)))) = 0;
%index(find(sum(isnan(matriz))> 50)) = 0;

figure
plot(amplitude(index==1),covariancia(index==1),'.')


figure
[a b] = sort(amplitude(index==1));
teste = covariancia(index==1);
plot(teste(b))

