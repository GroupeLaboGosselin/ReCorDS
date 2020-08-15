% Openjson.m
% Opens JSON subject files and outputs a subject structure variable
% Openjson(path,varargin)
% path : path to the subject files (e.g.
% C:\Users\valer\OneDrive\Documents\GitHub\ReCorDS\Datasets\Faghel-Soubeyrand_2019)
% second optional argument(varargin): if user does not want to analyse all
% subject files present in path, specify the subject files to analyse in
% one dimensional cell vector. The cell vector must contain the subjects' ID numbers in a
% string (e.g.{'001','004', '006','057','139'}). Must use single quote.
% Valerie Daigneault (valerie.daigneault.2@umontreal.ca), 15/08/2020

function subject = openjson(path,varargin)
cd(path);
d = dir;
narginchk(1,2);
switch nargin
    
    case 2
        files = varargin{1};       
        files = sort(files);
        
    case 1
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

