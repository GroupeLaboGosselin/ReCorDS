table = zeros((140-3)*4,1);
cell = num2cell(table);
a = 1;
directory = "C:\Users\valer\OneDrive\Documents\GitHub\ReCorDS\Datasets\Faghel-Soubeyrand_2019\Subject_";
for ii = 3: 140
    %change directory
    if ii < 10
        cell{a}= "cd "+directory + "00" +ii;
    elseif ii < 100
        cell{a} = "cd "+directory + "0" + ii;
    else 
        cell{a} = "cd "+directory + ii;
    end
    a = a+1;
    
    %pre-induction file
    cell{a} = "git mv Results_Pre-Induction_"+ii+".txt "+"Behavior_Pre-Induction_"+ii+".txt";
    a = a+1;
    
    %Induction file
    cell{a} = "git mv Results_Induction_"+ii+".txt "+"Behavior_Induction_"+ii+".txt";
    a = a+1;
    
    %Post-Induction file
    cell{a} = "git mv Results_Post-Induction_"+ii+".txt "+"Behavior_Post-Induction_"+ii+".txt";
    a = a+1;
end

cd("C:\Users\valer\OneDrive\Documents");
writecell(cell,"Github1.txt",'Delimiter','tab');
