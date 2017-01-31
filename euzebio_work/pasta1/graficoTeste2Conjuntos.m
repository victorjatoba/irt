% aucPlotFinal = [];
% for Alat=[1 2 3 4 5]
%     load(strcat('user-Alat-', num2str(Alat),'-turn-1-workspace.mat'));
%     aucPlotFinal = [aucPlotFinal; aucPlot Alat];
% end
% plot(aucPlotFinal(:, 2), aucPlotFinal(:, 1));

aucPlotFinal = [];
for Alat=[1 2 3 4 5 10 20 30 40 50]
    load(strcat('user2-Alat-', num2str(Alat),'-turn-1'));
    aucPlotFinal = [aucPlotFinal; auc Alat];
end
plot(aucPlotFinal(:, 2), aucPlotFinal(:, 1));

hold on

aucPlotFinal = [];
for Alat=[1 2 3 4 5 10 20 30 40 50]
    load(strcat('user2-Alat-', num2str(Alat),'-turn-1'));
    aucPlotFinal = [aucPlotFinal; aucPlot(end) Alat];
end
plot(aucPlotFinal(:, 2), aucPlotFinal(:, 1),'r');



aucPlotFinal = [];
for Alat=[1 2 3 4 5 10 20 30 40 50]
    load(strcat('Alat-', num2str(Alat),'-turn-1-workspace.mat'));
    aucPlotFinal = [aucPlotFinal; aucPlot(end) Alat];
end
plot(aucPlotFinal(:, 2), aucPlotFinal(:, 1),'g');

legend('Teste em questoes fora do treinamente', 'Teste em questoes dentro do treinamento', 'Desempenho no conjunto original')