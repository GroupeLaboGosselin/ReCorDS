cd("C:\Users\valer\OneDrive\Documents\GitHub\ReCorDS\Datasets\Faghel-Soubeyrand_2019\Subject_001");
mat = readmatrix("Bubbles_Induction_1.txt");
sizeMat = size(mat);

cell = zeros(sizeMat(1),sizeMat(2));
cell = num2cell(cell);

for ii = 1: sizeMat(1)
    for jj = 1: sizeMat(2)
        
        indx = mat(ii,jj);
        
        if indx > 0 
        n = indx/128;
        completeColumns = floor(n);
        rowNumber = (n - completeColumns)*128;
        cell{ii,jj} = "" + rowNumber + "," + (completeColumns+1);
        else
            cell{ii,jj} = "NaN";
        end
        
        
    end           
end