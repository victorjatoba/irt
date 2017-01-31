load('evals10-10000.mat', 'evals');
load('areaItens.mat');
areas = unique([COD_AREA(:, 2)]);

load thetas-grupo-1Alat-3-turn-4
idQuestoes = unique(evals{grupo1}(:, 2));

opcoes = ['bd'; 'r*'; 'go'; 'm.'];

figure
hold
for a=1:numel(areas)
    questoesArea = idQuestoes(ismember(idQuestoes, unique([COD_AREA{find(strcmp(COD_AREA(:, 2),areas(a))), 1}]')));
    plot(thetaObj(ismember(idQuestoes,questoesArea),1),thetaObj(ismember(idQuestoes,questoesArea),2),opcoes(a,:));
    
end

legend('CH','CN','LC','MT')