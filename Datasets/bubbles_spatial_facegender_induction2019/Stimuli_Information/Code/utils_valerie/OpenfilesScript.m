function Openfiles(mainDirectory,subjects,nbFiles)

mainDirectory = '/home/adf/faghelss/CharestLab/ReCorDS/examples_dataset/bubbles_spatial_facegender_induction2019'; % 'C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids';
subjects      = 1:10;
nbFiles       = 4;

cd(mainDirectory);
file.name = '';
file.content = [];
contentFields = {};

%% Create file structure

for ii = subjects
    
    sub_fold  = sprintf('Subject_%d',ii);
    directory = fullfile(mainDirectory,sub_fold); % SFS:  "\" won't work on anything else than Windows (won't work with LInux or Mac..). This is more general.
    infoDir   = dir(directory);
    sizeDir   = size(infoDir);
    cd(directory); % SFS : It's better practice to not change directory at each iteration... takes a lot of time for nothing. Need to change this.
    
    if sizeDir(1) < nbFiles
        continue
    end 
    
    indx = 0;
    contentFields = zeros(1,nbFiles);
    contentFields = num2cell(contentFields);

    for jj = 1: sizeDir(1)
        filename = infoDir(jj).name;
        dot = strfind(filename,".txt");
        iiString = num2str(ii);
        if sum(filename((dot-(1*length(iiString))):dot-1) == iiString)> 0
            indx = indx+1;
            file(indx).name = filename(1:dot-(1*length(iiString))-2);
            file(indx).content = tdfread(filename);
            contentFields{indx} = fieldnames((file(indx).content));
        end
    end
    
    if indx == nbFiles
        break
    end
end

%% Place subject information in file structure

for ii = subjects
    
    
    sub_fold  = sprintf('Subject_%d',ii);
    directory = fullfile(mainDirectory,sub_fold); % SFS : "\" won't work on anything else than Windows (won't work with LInux or Mac..). This is more general.
    cd(directory);
    
    for jj = 1 : nbFiles
        if (fopen(((file(jj).name)+"_"+ii+".txt")) == -1)
            variable = contentFields{jj};
            for kk = 1 : (length(contentFields{jj}))
                file(jj).content.(variable{kk})(:,ii) = NaN;
            end
        else
            temp = tdfread(((file(jj).name)+"_"+ii+".txt"));
            variable = contentFields{jj};
            for kk = 1 : (length(contentFields{jj}))
                file(jj).content.(variable{kk})(:,ii) = temp.(variable{kk});
            end
        end
    end 
    disp(ii);
    fclose('all');
end