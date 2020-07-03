cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\Simon_2019\experiment");
load("images.mat");

%save female images
cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids\Stimuli_Information\Stimuli");
mkdir("Female")
cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids\Stimuli_Information\Stimuli" + "\Female")
for ii = 1:150
    filename = sprintf("Female_%d.tif",ii);
    imwrite(imF{1,ii},filename);
    disp(ii);
end

%save male images
cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids\Stimuli_Information\Stimuli");
mkdir("Male")
cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids\Stimuli_Information\Stimuli" + "\Male")
for ii = 1:150
    filename = sprintf("Male_%d.tif",ii);
    imwrite(imM{1,ii},filename);
    disp(ii);
end
