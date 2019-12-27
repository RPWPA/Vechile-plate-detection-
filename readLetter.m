function [letter, num]=readLetter(snap)
%READLETTER reads the character fromthe character's binary image.
%   LETTER=READLETTER(SNAP) outputs the character in class 'char' from the
%   input binary image SNAP.

load NewTemplates % Loads the templates of characters in the memory.
snap=imresize(snap,[42 24]); % Resize the input image so it can be compared with the template's images.
comp=[ ];
for n=1:length(NewTemplates)
    sem=corr2(NewTemplates{1,n},snap); % Correlation the input image with every image in the template for best matching.
    comp=[comp sem]; % Record the value of correlation for each template's character.
    %display(sem); 
end
vd=find(comp==max(comp)); % Find the index which correspond to the highest matched character.
%display(max(comp));
%*-*-*-*-*-*-*-*-*-*-*-*-*-
num = 0;
% Accodrding to the index assign to 'letter'.
% Alphabets listings.
if vd==1 || vd==2
    letter='A';
elseif vd==3 || vd==4
    letter='B';
elseif vd==5
    letter='C';
elseif vd==6 || vd==7
    letter='D';
elseif vd==8
    letter='E';
elseif vd==9
    letter='F';
elseif vd==10
    letter='G';
elseif vd==11
    letter='H';
elseif vd==12
    letter='I';
elseif vd==13
    letter='J';
elseif vd==14
    letter='K';
elseif vd==15
    letter='L';
elseif vd==16 || vd==25 || vd==21
    letter='M' ;
elseif vd==17
    letter='N';
elseif vd==18 || vd==19
    letter='0';
    num = num + 1;
elseif vd==20 
    letter='P';
elseif vd==22 
    letter='Q';
elseif vd==24 
    letter='R';
elseif vd==26
    letter='S';
elseif vd==27
    letter='T';
elseif vd==28
    letter='U';
elseif vd==29
    letter='V';
elseif vd==30
    letter='W';
elseif vd==31
    letter='X';
elseif vd==32
    letter='Y';
elseif vd==33
    letter='Z';
    %*-*-*-*-*
% Numerals listings.

elseif vd==34
    num = num + 1;
    letter='1';
elseif vd==35
    num = num + 1;
    letter='2';
elseif vd==36
    num = num + 1;
    letter='3';
elseif vd==37 || vd==38
    num = num + 1;
    letter='4';
elseif vd==39 || vd==48
    num = num + 1;
    letter='5';
elseif vd==40 || vd==41 || vd==42
    num = num + 1;
    letter='6';
elseif vd==43
    num = num + 1;
    letter='7';
elseif vd==44 || vd==45
    num = num + 1;
    letter='8';
elseif vd==46 || vd==47 
    num = num + 1;
    letter='9';
else
    num = num + 1;
    letter='0';
end
end