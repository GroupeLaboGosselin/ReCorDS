%% Variables
% SFS : this is now much cleaner
participants   = info_subjects;
nbParticipants = length(subjects_Experimental); 

%% Subject results CSV document output
lineOne = ["Trial","Gender_Face1","Face1_nb","Face2_nb","Right_left_flip","Nb_Bubbles","Overlap_Target","Response","RT","Accuracy","Simi2Target","Trial_Reward"];

%% Data creation


for ii = 1 : nbParticipants
    
    %Participant info
    participantCell      = participants{ii};
    participantID        = participantCell{1};
    participantCondition = participantCell{2};
    participantKey       = participantCell{3};
    
    
    % Create subject folder
    cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids"); % SFS: should be put in a more general format (use fullfile(yourdir) for example).
    folderName = sprintf("Subject_%d",ii);
    mkdir (folderName);
    subjectDirectory = "C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids\" + folderName;
    
    
    %Create Results_Pre-Induction_x.csv file
    
    cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\Simon_2019\gender_learn_data");
    ResultsPreInduction = zeros(300,11);
    nbMissingFiles = 0;
    for jj = 1:3  %create Pre-Induction results matrix
      matFileName = sprintf("simon_exp_%s_%d_7_%d.mat",participantID,jj,participantKey);
      if fopen(matFileName)== -1
          disp(sprintf("Pre-Induction file for participant %s number %d could not be found",participantID,jj));
          nbMissingFiles = nbMissingFiles+1;
      else 
          load(matFileName);
          b = (((jj-1)*100)+1);
          c = jj*100;
          d = transpose(cid.data);
          ResultsPreInduction(b:c,1:11) = d(1:100,1:11);
      end  
    end
    if nbMissingFiles < 3 % customises and saves nonblank file
        temp = zeros(301,12); %customizes matrix for csv document
        temp(2:301,2:12)= ResultsPreInduction; %add results matrix
        temp = num2cell(temp);
       for vv = 1:12 %add line1
           temp{1,vv} = lineOne(vv);
       end
        for tt = 1:300 %add column 1
            temp{tt+1,1} = tt;
        end
        cd(subjectDirectory);%saves non blank file
        CSVFileNamePI = sprintf("Results_Pre-Induction_%d.txt",ii);
        writecell(temp,CSVFileNamePI,'Delimiter','tab');  
    else
        disp(sprintf("Check participant %s. File number %d is empty",participantID,ii));
    end
    
    
    %Create Results_Induction_x.csv file
    
    if nbMissingFiles < 3
        cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\Simon_2019\gender_learn_data");
        ResultsInduction = zeros(500,11);
        
        for jj = 1:5 %create induction results matrix
            matFileName = sprintf("simon_exp_%s_%d_%d_%d.mat",participantID,jj,participantCondition,participantKey);
            
            if fopen(matFileName)== -1
                disp(sprintf("Induction file for participant %s number %d could not be found",participantID,jj));
            else
                load(matFileName);
                b = (((jj-1)*100)+1);
                c = jj*100;
                d = transpose(cid.data);
                ResultsInduction(b:c,1:11) = d(1:100,1:11);
            end
        end
        
        if isempty(ResultsInduction) == 0% customizes and saves induction matrix
             temp = zeros(501,12); %customizes matrix for csv document
             temp(2:501,2:12)= ResultsInduction; %add results matrix
             temp = num2cell(temp);
             for vv = 1:12 %add line1
                 temp{1,vv} = lineOne(vv);
             end
             for tt = 1:500 %add column 1
                 temp{tt+1,1} = tt;
             end
             cd(subjectDirectory)%saves non blank file
             CSVFileNameI = sprintf("Results_Induction_%d.txt",ii);
             writecell(temp,CSVFileNameI,'Delimiter','tab');
        else
            disp(sprintf("No induction files have been found for participant %s number %d",participantID,ii));        
        end   
    end
    
    
    %Creates Results_Post-Induction_x.csv file
    
        if nbMissingFiles < 3
            cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\Simon_2019\gender_learn_data");
            ResultsPostInduction = zeros(300,11);
            
            for jj = 1:3 %create induction results matrix
                matFileName = sprintf("simon_exp_%s_%d_7_%d.mat",participantID,jj+3,participantKey);
                if fopen(matFileName)== -1
                    disp(sprintf("Post-Induction file for participant %s number %d could not be found",participantID,jj));
                else
                load(matFileName);
                b = (((jj-1)*100)+1);
                c = jj*100;
                d = transpose(cid.data);
                ResultsPostInduction(b:c,1:11) = d(1:100,1:11);
                end
            end
            
            if isempty(ResultsPostInduction) == 0% customizes and saves induction matrix
                 temp = zeros(301,12); %customizes matrix for csv document
                 temp(2:301,2:12)= ResultsPostInduction; %add results matrix
                 temp = num2cell(temp);
                 for vv = 1:12 %add line1
                     temp{1,vv} = lineOne(vv);
                 end
                 for tt = 1:300 %add column 1
                     temp{tt+1,1} = tt;
                 end
                 cd(subjectDirectory)%saves non blank file
                 CSVFileNamePPI = sprintf("Results_Post-Induction_%d.txt",ii);
                 writecell(temp,CSVFileNamePPI,'Delimiter','tab');
            else
                disp(sprintf("No post-induction files have been found for participant %s number %d",participantID,ii));        
            end       
        end 
        
        disp(ii);
        
        
end