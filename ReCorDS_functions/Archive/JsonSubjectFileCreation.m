% How to create subject JSON files
% 1) Create the final structure wanted with all subject information for all
% subjects (subject(ii).blocname.variablename). All variables in the same bloc should have the same length (number of trials in bloc)
% (i.e. variable1 : 300 x 1, variable2 300 x1,...)
% 2) Run this code
%
% Valerie Daigneault(valerie.daigneault.2@umontreal.ca),07/10/2020

nbSubjects = 1;
mainDir = "C:\Users\valer\Documents\GitHub\ReCorDS\Datasets\Faghel-Soubeyrand_2019";
filename = "DataBehavior_";
structure = nameOfStructureVariable;

for ii = 1: nbSubjects
    
    
%     sub_fold = fullfile(output_dir,'/',sprintf('Subject_%03d',subject));
%     mkdir(sub_fold)
%  fprintf('Subject_%03d ...\n',subject)
   sub = ii;
   for jj = 1:strlength("" + nbSubjects)-strlength(""+ii)
       sub = "0"+ sub;
   end
     % Uncomment if new folders for subjects have not been made
%     mkdir("C:\Users\valer\Documents\GitHub\ReCorDS\Datasets\Faghel-Soubeyrand_2019", "Subject_" + sub);
    
    cd(mainDir + "Subject_" + sub); % this is not good practice at all. Doing so you change directory EVERYTIME! It's
    id = fopen(filename+ ii + ".json", 'w');
    fprintf(id, '%s', jsonencode(structure(ii)));
    fclose(id); 
end