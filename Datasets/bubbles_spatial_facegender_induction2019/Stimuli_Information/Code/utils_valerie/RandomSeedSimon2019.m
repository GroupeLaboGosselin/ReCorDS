%Extract initial random seed number for every participant/every block

%% Variables
nbParticipants = 140 ; 
participants = {{'MMC',3,0,0.87,'F'}
    {'CD',3 ,1, 0.5,'F'}
    {'LVA',4 ,0,1,'F'}
    {'ae', 3, 0,0.8,'M'}
    {'kd', 4, 1,0.9,'F'} 
    {'MD', 4, 1,0.4,'F'}
    {'kg', 3,1,0.375,'F'} 
    {'AHp', 3,1,0.2,'F'}
    {'JOE',1,0,0.88,'F'}
    {'DMC',1 ,0,1,'F'}
    {'GE',3 ,1, 0.8,'M' }
    {'MB',1 ,0,0.6,'F' }
    {'POD',1 ,1, 0.47,'M' }
    {'EAH',1 ,1,0.5,'F'  }
    {'FL1',1,1,1,'F' } 
    {'DMB',1,0, 0.683,'F' }
    {'IS',4 ,0,0.9,'F' } 
    {'MPT',2 ,0,0.9,'F' }
    {'CS',2,1, 0.9,'F'}
    {'JG',2,0, 0.8,'F' }
    {'BDT',2,1, 0.7,'M' }
    {'JHR',2,0,0.7,'M' }
    {'KD2',3,1, 0.8,'M' }
    {'EEJ',4,0,  0.2,'M'}
    {'JMM',4,1, 0.9,'M' }
    {'LF',3,1, 1,'F' }
    {'VA',3,0, 0.7,'M' }
    {'MSG',4,0, 1,'F' }
    {'SL',3, 1, 0.4,'M'}
    {'MABT',3, 0,0.74,'M' }
    {'TB',4, 0,0.2,'M' }
    {'RF',4, 1,1,'F' } 
    {'CS1',3,0,0.9,'F' }
    {'VB',4, 1,0.3,'F'}
    {'SC1',4, 0,0.9,'F' }
    {'FL2',5, 0,0.6,'M' } 
    {'SB',5, 1,0.9,'F' }
    {'SP1',6, 0,0.9,'M' }
    {'GFS',6, 0,0.8,'F' }
    {'VG1',6, 1, 1,'F'}
    {'MAS',6, 1, 0.789,'M'}
    {'SR',5, 0,0.684,'F'}
    {'AG1',5, 0,0.375,'F'}
    {'NB',6, 1,0.89,'M'}
    {'CBA',5, 1,0.8,'F'}
    {'MN1',5, 0,1,'F'}
    {'CLL',5, 1,1,'F'}
    {'JP',5, 0,1,'F'}
    {'JLP',6, 0,0.6,'M'}
    {'NRM',1, 1,0.8,'F'}
    {'JB',6, 0,0.2,'F'}
    {'MSA',6, 1,0.62,'F'}
    {'AS2',5, 1,0.4,'M'}
    {'EG',1, 0,1,'F'}
    {'WC',6,0,1,'M'}
    {'HA',6, 0,0.4,'M'}
    {'CB3',6, 1,0.68,'F'}
    {'AB',6, 1,1,'M'} 
    {'JFD',5, 0,0.65,'M'}
    {'LR3',6, 0,0.5,'F'}
    {'SDG1',6, 0,1,'F'}  
    {'SBE',6, 1,0.8,'F'}
    {'SB4',6,0,1,'F'}
    {'BM4',6,1,1,'F'}
    {'FTC4',5,1,1,'F'}
    {'AS4',5,1,1,'F'}
    {'BE4',6,0,.88,'H'} 
    {'FMJ4',5,1,.7,'H'} 
    {'SCDM4',5,1,.75,'F'}
    {'MA4',6,1,.7,'F'}
    {'MR4',5,0,.7,'F'}
    {'MOA4',6,1,.83,'H'}
    {'ARB4',6,0,.6,'H'}
    {'JBB4',5,1,.76,'H'}
    {'FTD4',999,1,1,'F'}
    {'SM4',6,0,1,'H'} 
    {'SM5',6,0,.8,'F'}
    {'SZ4',5,0,.8,'F'}
    {'SHD4',5,0,.44,'F'}
    {'AE4',5,0,1,'F'}
    {'NJB4',5,1,.5,'H'}  
    {'FL5',5,0,0.7,'H'}
    {'TR5',6,0,0.68,'H'}
    {'PL5',5,0,0.73,'F'}
    {'HD5',6,0,0.89,'F'}
    {'NL5',5,1,0.8,'F'}
    {'MEV5',6,0,1,'F'}
    {'AF6',5,1,.8,'M'}
    {'XMB6',5,0,1,'M'}
    {'MEVB6',6,1,0.57,'F'}
    {'OD6',6,1,.714,'F'}
    {'MABK6',5,1,1,'F'}
    {'CO7',6,0,.8,'F'}
    {'MC7',5,0,0,'F'} 
    {'MBB6',6,1,.9,'F'}
    {'MEL6',6,0,1,'F'}
    {'AG6',5,0,-.1,'F'}
    {'AR7',6,0,1,'F'}
    {'PT6',5,0,1,'F'}
    {'ASDR6',6,0,1,'F'} 
    {'FD8',6,0,1,'F'}
    {'AP7',5,0,1,'F'}
    {'NL5',5,1,.8,'M'}
    {'SFS',6,0,0.75,'M'}
    {'GR6',5,0,1,'M'}
    {'NN6',5,0,.666,'M'}
    {'PR7',6,0,.9,'M'}
    {'KK7',5,0,1,'F'}
    {'CBP7',6,0,.68,'M'}
    {'NR8',5,1,1,'M'}
    {'FC',5,0,1,'M'}
    {'MB8',5,0,1,'M'}
    {'MB9',6,1,0.428,'M'}
    {'MHG7',6,1,.4,'F'}
    {'LM8',5,0,1,'F'}
    {'PB8',6,1,-1,'F'}
    {'NB8',6,0,.89,'F'}
    {'MF8',6,0,-.64,'F'}
    {'CG6',6,1,0.4,'F'}
    {'EJ6',6,0,0.6,'F'}
    {'AFL6',6,1,1,'F'}
    {'ACGL6',6,0,.77,'F'}
    {'AE7',5,1,1,'M'}
    {'CG8',6,0,0.4286,'F'}
    {'GJO8',6,0,.333,'F'}
    {'SF6',6,1,1,'F'} 
    {'CB6',6,0,1,'F'}
    {'MR6',5,0,.9375,'F'}  
    {'NCS6',5,1,.7143,'F'}  
    {'OBC6',5,0,1,'M'} 
    {'BN6',5,1,1,'M'}  
    {'SIR7',5,0,1,'F'}  
    {'CBG6',6,0,.4,'F'} 
    {'GA7',5,1,1,'F'}  
    {'RL6',6,0,.8571,'M'} 
    {'RSA6',5,0,.89,'F'}  
    {'RBH6',5,1,-1,'M'}  
    {'AD6',5,0,-1,'F'} 
    {'SN6',5,0,.9,'F'}  
    {'ML6',5,1,.4,'M'}
    };

%% Random seed extraction

randomSeedMat = zeros(nbParticipants,11);

for ii = 1: nbParticipants

%Participant info
    participantCell = participants{ii};
    participantID = participantCell{1};
    participantCondition = participantCell{2};
    participantKey = participantCell{3};
    
%Opening Pre-inductions files (1-2-3)
   cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\Simon_2019\gender_learn_data"); 
   
   for jj = 1:3
       matFileName = sprintf("simon_exp_%s_%d_7_%d.mat",participantID,jj,participantKey);
       if fopen(matFileName)== -1
           disp(sprintf("Pre-Induction file %d for participant %s number %d could not be found",jj,participantID,ii));
       else
           load(matFileName);
           temp = cid.noise; %remove text
           temp = sscanf(temp,"%s");
           ind = strfind(temp,"=");
           temp = temp(ind+1:(length(temp)));
           temp = str2num(temp);
           randomSeedMat(ii,jj) = temp;
       end
   end
 
 
 %Opening Induction files (4-5-6-7-8)
 
   for jj = 1:5
       matFileName = sprintf("simon_exp_%s_%d_%d_%d.mat",participantID,jj,participantCondition,participantKey);
       if fopen(matFileName) == -1
         disp(sprintf("Induction file %d for participant %s number %d could not be found",jj,participantID,ii)); 
       else
           load(matFileName);
           temp = cid.noise; %remove text
           temp = sscanf(temp,"%s");
           ind = strfind(temp,"=");
           temp = temp(ind+1:(length(temp)));
           temp = str2num(temp);
           randomSeedMat(ii,jj+3) = temp;
       end
   end
   

 %Opening Post-Induction files (9-10-11)
 
   for jj = 1:3
       matFileName = sprintf("simon_exp_%s_%d_7_%d.mat",participantID,jj+3,participantKey);
       if fopen(matFileName) == -1
         disp(sprintf("Post-Induction file %d for participant %s number %d could not be found",jj,participantID,ii)); 
       else
           load(matFileName);
           temp = cid.noise; %remove text
           temp = sscanf(temp,"%s");
           ind = strfind(temp,"=");
           temp = temp(ind+1:(length(temp)));
           temp = str2num(temp);
           randomSeedMat(ii,jj+8) = temp;
       end
   end 
   disp(ii);
end


%% Save random seed matrix in a file

lineOne = ["Subject","PreInduction1","PreInduction2","PreInduction3","Induction1","Induction2","Induction3","Induction4","Induction5","PostInduction1","PostInduction2","PostInduction3"];

tmat = zeros(nbParticipants+1,12);
tmat(2:nbParticipants+1,2:12) = randomSeedMat;
tmat = num2cell(tmat);

for vv = 1:12 % add first text line
    tmat{1,vv} = lineOne(vv);
end

for vv = 1: nbParticipants
    tmat{vv+1,1}= vv;
end

cd("C:\Users\valer\OneDrive\Documents\Laboratoire vision\PSY3009\2_Gender Recognition_PsychBids\Dataset_Information");

writecell(tmat,"Participants_RandomSeed.txt",'Delimiter','tab');

    













