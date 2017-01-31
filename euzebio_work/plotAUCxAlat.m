aucPlot2 = zeros(10, 1);
aucPlot3 = zeros(10, 1);
for Alat=2:11
    count = 0;
    for grupo=1:2
        
        for turns=1:10
            
            arquivo = dir(strcat('test-users-grupo1-', num2str(grupo), '-Alat-', num2str(Alat), '-turn-', num2str(turns), '-grupo2-*.mat'));
            
            fid = fopen(arquivo.name);
            if fid < 0
                continue;
            end
            fclose(fid);
            
            load(arquivo.name);
            
            aucPlot2(Alat-1) = aucPlot2(Alat-1)+auc;
            aucPlot3(Alat-1) = aucPlot3(Alat-1)+aucPlot(end);
            count = count+1;
        end
    end
    aucPlot2(Alat-1) = aucPlot2(Alat-1)/count;
    aucPlot3(Alat-1) = aucPlot3(Alat-1)/count;
end

plot(1:10, aucPlot2, 1:10, aucPlot3);