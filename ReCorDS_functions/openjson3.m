% Openjson3.m
% Opens JSON subject files and outputs a subject structure variable
% Openjson(path)
% path : path to the subject files (e.g.
% C:\Users\valer\OneDrive\Documents\GitHub\ReCorDS\Datasets\Faghel-Soubeyrand_2019)
% Valerie Daigneault (valerie.daigneault.2@umontreal.ca), 29/07/2020

function subject = openjson3(path)
cd(path);
d = dir;
answer = questdlg("Would you like to analyse all the subject files in directory?","Specifications",'Yes','No','Yes');
switch answer
    
    case 'No'
        nb = inputdlg("How many subject files would you like to analyze?","Specifications",[1 100]);
        prompt = {};
        example = {};
        for ii = 1:str2num(nb{1})
            prompt{ii} = "Subject Number " + ii+":";
        end
        files = inputdlg(prompt,"Which subject files are to be analyzed?",[1 100]);
        files = sort(files);
        
    case 'Yes'
        files = {};
        c = 1;
        for ii = 1 : size(d,1)
            temp = d(ii).name;
            if length(temp) > 7
                if temp(1:8) == "Subject_"
                    files{c} = temp(9:length(temp));
                    c = c+1;
                end
            end
        end 
        files = sort(files);
end

for ii = 1: length(files)
    sub = files{ii};
    if isempty(strfind(path, "\")) 
        cd(path + "/Subject_" + sub);
    else 
        cd(path + "\Subject_" + sub); 
    end
    temp = jsondecode(fileread("BehaviorData_"+sub+".json"));
    if ii == 1
        data = temp;
    else
        data(ii) = temp; 
    end
end
for ii = 1 : length(files)
    data(ii).Subject = files{ii};
end  
subject = data;  
end

