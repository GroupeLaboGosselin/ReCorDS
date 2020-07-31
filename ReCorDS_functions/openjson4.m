% Openjson4.m
% Opens JSON subject files and outputs a subject structure variable
% Openjson(path)
% path : path to the subject files (e.g.
% C:\Users\valer\OneDrive\Documents\GitHub\ReCorDS\Datasets\Faghel-Soubeyrand_2019)
% Valerie Daigneault (valerie.daigneault.2@umontreal.ca), 29/07/2020

function subject = openjson4(path)
cd(path);
d = dir;
answer = questdlg("Would you like to analyse all the subject files in directory?","Specifications",'Yes','No','Yes');
switch answer
    
    case 'No'
        answer2 = questdlg("1) Specify subject files to analyse or 2) Specify subject files to exclude","Specifications",'1','2','1');
        switch answer2
            case '1'
                nb = inputdlg("How many subject files would you like to analyze?","Specifications",[1 100]);
                prompt = {};
                for ii = 1:str2num(nb{1})
                    prompt{ii} = "Subject Number " + ii+":";
                end
                files = inputdlg(prompt,"Which subject files are to be analyzed?",[1 100]);
                files = sort(files);
            
            case '2'
                nb = inputdlg("How many subject files would you like to exclude?","Specifications",[1 100]);
                prompt = {};
                for ii = 1:str2num(nb{1})
                    prompt{ii} = "Subject Number " + ii+":";
                end
                exc = inputdlg(prompt,"Which subject files are to be excluded?",[1 100]);
                exc = sort(exc); 
                files = {};
                c = 1;
                for ii = 1 : size(d,1)
                    temp = d(ii).name;
                    if length(temp) > 7
                        if temp(1:8) == "Subject_"
                            t = temp(9:length(temp));
                            if sum(strcmp(exc,t))==0
                                files{c} = t;
                                c = c+1;
                            end
                        end
                    end
                end 
                files = sort(files);  
        end
                
        
  
        
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

