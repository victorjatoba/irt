load data

[nA, nQ] = size(matriz);
diagonal = diag(data);
x = data./sqrt(diagonal*diagonal');
% x = data;

nAreas = 16;

areas = zeros(1,nQ);

for i=1:nQ
    areas(i) = randi(nAreas);
end

soma = 0;
for i=1:nQ
    soma = soma + nanmean(x(i,areas==areas(i)));
end
soma

last = nQ;
index = 0;
mudou = 1;
teste =0;
while mudou
    teste = teste + 1;
    i = index+1;
    
    areasCopy = areas;
    areasCopy(i) = 0;
    
    menos = nanmean(x(i,areasCopy==areas(i)));
    newArea = 0;
    for j=1:nAreas
        mais = nanmean(x(i,areasCopy==j));
        if mais > menos
            newArea = j;
            menos = mais;
        end
    end
    
    if newArea > 0
        last = i;
        areas(i) = newArea;
        mudou = 1;
    elseif i == last
        mudou = 0;
    end
    
    
    
    index = mod(index+1,nQ);
    

end

soma = 0;
for i=1:nQ
    soma = soma + nanmean(x(i,areas==areas(i)));
end
soma


%%

idAlunos = unique(evals{grupo}(:,1));%indice de alunos por posicao nos dados
idQuestoes = unique(evals{grupo}(:,2));%indice de questoes por ID
areasReais = zeros(nQ,4);
for i=1:nQ
    for j=1:length(COD_AREA)
        if idQuestoes(i) == ID_ITEM(j)
            areasReais(i,:) = COD_AREA{j};
            break;
        end
    end
end