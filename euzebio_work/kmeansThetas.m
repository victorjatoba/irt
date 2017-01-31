numClusters = 3; %ou 4

load('evals10-10000.mat', 'evals');
load('areaItens.mat');
idQuestoes = unique([COD_AREA{:, 1}])';
matriz = zeros(numel(idQuestoes), numel(idQuestoes)); %quantas vezes cada uma apareceu no mesmo grupo da outra

for Alat=3; %numero de atributos latentes com melhor resultado (supostamente 3 ou 4)
    for grupo=1:10
        for turns=1:10
            arquivo = dir(strcat('test-users-grupo1-', num2str(grupo), '-Alat-', num2str(Alat), '-turn-', num2str(turns), '-grupo2-*.mat'));
            load(arquivo.name, 'thetaObj');
            
            idx = kmeans(thetaObj(:, 1:Alat-1), numClusters, 'Distance', 'cosine');
            
            for i=1:numClusters
                for j=1:
            end
        end
    end
end

%matriz = matriz/(10*10);