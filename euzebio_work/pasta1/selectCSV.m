fileSrc = fopen('teste.txt');
fileDest = fopen('teste2.txt','w');

linhas = randperm(5000000);
linhas = sort(linhas(1:200000));

linhas = randperm(10);
linhas = [1 (sort(linhas(1:5))+1)];


count = 0;
count2 = 0;
for i=linhas
    while count < i
        x = fgets(fileSrc);
        count = count+1;
    end
        
    fprintf(fileDest, '%s', x);
    
    count2 = count2 + 1;
    if mod(count2,100) == 0
        disp(count2);
    end
end

fclose(fileSrc);
fclose(fileDest);