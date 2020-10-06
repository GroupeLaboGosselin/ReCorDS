cd("C:\Users\valer\Documents\GitHub\ReCorDS\Datasets\Faghel-Soubeyrand_2019");
subject = struct;
tempmati = [];
tempmatj = [];
for ii = 1:140
    %create structure 
    subject(ii).PreInduction.Bubbles_i = num2cell(zeros(300,1));
    subject(ii).PreInduction.Bubbles_j = num2cell(zeros(300,1));
    subject(ii).Induction.Bubbles_i = num2cell(zeros(500,1));
    subject(ii).Induction.Bubbles_j = num2cell(zeros(500,1));
    subject(ii).PostInduction.Bubbles_i = num2cell(zeros(300,1));
    subject(ii).PostInduction.Bubbles_j = num2cell(zeros(300,1));
    
    %open subject folder
    subdirectory = "C:\Users\valer\Documents\GitHub\ReCorDS\Datasets\Faghel-Soubeyrand_2019"+"\Subject_";
    
    if ii < 10
        subdirectory = subdirectory + "00" + ii;
    elseif ii < 100
        subdirectory = subdirectory + "0" + ii;
    else 
        subdirectory  = subdirectory + ii; 
    end
    cd(subdirectory);
    %pre-induction files
    for jj = 1: 3 
        switch jj
            case 1
                file = "Bubbles_Pre-Induction_" + ii+".txt";
                trials = 300;
            case 2
                file = "Bubbles_Induction_" + ii + ".txt";
                trials = 500;
            case 3
                file = "Bubbles_Post-Induction_" + ii +".txt";
                trials = 300; 
        end
        if fopen(file) == -1
            disp( "Could not open " + file);
        else
            mat = readmatrix(file);
            
            for vv = 1 : trials
               colonne =  mat(:,vv);
               nZerosIndx = find(colonne); 
               tempmati = [];
                tempmatj = [];
               
               for ww = 1 : length(nZerosIndx)
                   imIndx = colonne(ww);
                   [imi imj] = ind2sub([128 128], imIndx);
                   tempmati(ww) = imi;
                   tempmatj(ww) = imj; 
               end
               switch jj
                   case 1
                       subject(ii).PreInduction.Bubbles_i{vv} = tempmati;
                       subject(ii).PreInduction.Bubbles_j{vv} = tempmatj;
                       
                   case 2
                       subject(ii).Induction.Bubbles_i{vv} = tempmati;
                       subject(ii).Induction.Bubbles_j{vv} = tempmatj;
                       
                   case 3 
                       subject(ii).PostInduction.Bubbles_i{vv} = tempmati;
                       subject(ii).PostInduction.Bubbles_j{vv} = tempmatj;
    
               end
                
            end
            
            
        end
        
    end 
    
  cd("C:\Users\valer\Documents");
  save("Bubbles_position.mat", "subject");
  disp(ii);
end
