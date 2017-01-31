evals = cell(1,10);
grupos = zeros(10000, 10);
load('2012dadosENEMcolunas.mat');
load('2012itensDadosColunas.mat');

ind = randperm(200000);

count = 0;

for i=1:10
    evals{i} = nan(10000*180,3);
    for j=1:10000
        
        if(mod(j, 100)==0)
            disp([i j count]);
        end
        
        count = count+1;
        u = ind(count);
        
        while isnan(ID_PROVA_CH(u))||isnan(ID_PROVA_LC(u))||isnan(ID_PROVA_CN(u))||isnan(ID_PROVA_MT(u))||(length(DS_GABARITO_LC{u})<51)
            count = count+1;
            u = ind(count);
        end
        
        grupos(j, i) = u;
        
        id_prova_ch = ID_PROVA_CH(u);
        id_prova_cn = ID_PROVA_CN(u);
        id_prova_lc = ID_PROVA_LC(u);
        id_prova_mt = ID_PROVA_MT(u);
        tipo_lingua = TP_LINGUA(u);
        respostas_ch = TX_RESPOSTAS_CH{u};
        respostas_cn = TX_RESPOSTAS_CN{u};
        respostas_lc = TX_RESPOSTAS_LC{u};
        respostas_mt = TX_RESPOSTAS_MT{u};
        gabarito_ch = DS_GABARITO_CH{u};
        gabarito_cn = DS_GABARITO_CN{u};
        gabarito_lc = DS_GABARITO_LC{u};
        gabarito_mt = DS_GABARITO_MT{u};
        
        questoesProva = find(ID_PROVA==id_prova_ch);
        desloca = 0;
        for q=2:46
            id_questao = ID_ITEM(questoesProva(q-1));
%             evals{i} = [evals{i}; u, id_questao, respostas_ch(q)==gabarito_ch(q)];
            desloca = desloca+1;
            evals{i}((j-1)*180+desloca,:) = [u, id_questao, respostas_ch(q)==gabarito_ch(q)];
        end
        
        questoesProva = find(ID_PROVA==id_prova_cn);
        for q=2:46
            id_questao = ID_ITEM(questoesProva(q-1));
%             evals{i} = [evals{i}; u, id_questao, respostas_cn(q)==gabarito_cn(q)];
            desloca = desloca+1;
            evals{i}((j-1)*180+desloca,:) = [u, id_questao, respostas_cn(q)==gabarito_cn(q)];
        end
        
        questoesProva = find(ID_PROVA==id_prova_lc);
        if (tipo_lingua==0)
            for q=2:6
                id_questao = ID_ITEM(questoesProva(q-1));
%                 evals{i} = [evals{i}; u, id_questao, respostas_lc(q)==gabarito_lc(q)];
                desloca = desloca+1;
                evals{i}((j-1)*180+desloca,:) = [u, id_questao, respostas_lc(q)==gabarito_lc(q)];
            end
        else
            for q=7:11
                id_questao = ID_ITEM(questoesProva(q-1));
%                 evals{i} = [evals{i}; u, id_questao, respostas_lc(q)==gabarito_lc(q)];
                desloca = desloca+1;
                evals{i}((j-1)*180+desloca,:) = [u, id_questao, respostas_lc(q)==gabarito_lc(q)];
            end
        end
        
        for q=12:51
            id_questao = ID_ITEM(questoesProva(q-1));
%             evals{i} = [evals{i}; u, id_questao, respostas_lc(q-5)==gabarito_lc(q)];
            desloca = desloca+1;
            evals{i}((j-1)*180+desloca,:) = [u, id_questao, respostas_lc(q-5)==gabarito_lc(q)];
        end
        
        questoesProva = find(ID_PROVA==id_prova_mt);
        for q=2:46
            id_questao = ID_ITEM(questoesProva(q-1));
%             evals{i} = [evals{i}; u, id_questao, respostas_mt(q)==gabarito_mt(q)];
            desloca = desloca+1;
            evals{i}((j-1)*180+desloca,:) = [u, id_questao, respostas_mt(q)==gabarito_mt(q)];
        end
    end
end

save('evals10-10000.mat', 'evals', 'grupos', 'ind');