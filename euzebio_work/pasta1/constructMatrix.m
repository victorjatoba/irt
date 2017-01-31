load evalsTest
load areaItens

matriz = sparse(evals(:,1), evals(:,2), evals(:,3)+1);

soma = sum(matriz>0,2);

while any(soma<=0)
    index = find(soma<180,1,'first');
    matriz(index,:) = [];
    soma = sum(matriz>0,2);
end

[nStudent nQuestion] = size(matriz);

areas = zeros(1,nQuestion);


for i=1:size(COD_AREA,1)
    switch COD_AREA{i,2}
        case '"CH"'
            areas(COD_AREA{i,1}) = 1;
        case '"CN"'
            areas(COD_AREA{i,1}) = 2;
        case '"MT"'
            areas(COD_AREA{i,1}) = 3;
        case '"LC"'
            areas(COD_AREA{i,1}) = 4;
    end
end

soma = sum(matriz>0,1);
while any(soma<=0)
    index = find(soma<nStudent,1,'first');
    matriz(:,index) = [];
    areas(index) = [];
    soma = sum(matriz>0,1);
end

[aux, indexes] = sort(areas);

matriz = matriz(:,indexes)-1;
areas = areas(indexes);


matriz = full(matriz);

save matriz.txt -ASCII matriz