function [resultingCAR,Governorate,numberOfNumbers,NumberOfChars] = segmentImage(inputImg, n)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

img = inputImg;
[w,h,~] = size(img);

found = 0;
resultingCAR = 'empty';

%get car Type
for i = 1: w 
  for j = 1: h 
    if ((img(i,j,1) == 0) &&  (img(i,j,2) == 0) &&(img(i,j,3) == 0))
         continue;
    elseif ((img(i,j,1) == 255) &&  (img(i,j,2) == 255) &&(img(i,j,3) == 255))
          resultingCAR = 'Government cars';
            %found = 1;
            %break;
    elseif ((img(i,j,1) <= 255) && (img(i,j,1) > 100) &&(img(i,j,2) == 0) && (img(i,j,3) == 0))
            resultingCAR = 'Transport';
            found = 1;
            break;
    elseif ((img(i,j,1) <= 55) && (img(i,j,1) > 10) && (img(i,j,2) <= 100) && (img(i,j,2) > 10) && (img(i,j,3) <= 230) && (img(i,j,3)> 140)) 
            resultingCAR = 'Owners cars';
            found = 1;
            break;
    elseif ((img(i,j,1) == 128) && (img(i,j,2) == 128) && (img(i,j,3) == 128))
            resultingCAR = 'Government cars';
            found = 1;
            break;
    elseif ((img(i,j,1) <= 255) && (img(i,j,1) > 150)&& (img(i,j,2) <= 250)  && (img(i,j,2) >= 50)&& (img(i,j,3) <= 50))
            resultingCAR = 'Taxi';
            found = 1;
            break;
    end
  end
  if found==1
      break;
  end
end

%to Segment plat from car
im = img;
im = imresize(im, [480 NaN]);
imgray = rgb2gray(im);
imbin = imbinarize(imgray);
im = edge(imgray, 'sobel');

im = imdilate(im, strel('diamond', 7));
im = imfill(im, 'holes');
im = imerode(im, strel('diamond', 10));

Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    

%all above step are to find location of number plate
im = imcrop(imbin, boundingBox);

%resize number plate to 240 NaN
im = imresize(im, [240 NaN]);
%clear dust
%im = imopen(im, strel('rectangle', [4 4]));

%remove some object if it width is too long or too small than 500
im = imerode(im, strel('diamond', 4));

%im = bwareaopen(~im, 100);
im = ~im;

%%%get width[h, w] = size(im);
for i = 1:92
    for j = 1:444
        im(i,j) = 1;
    end
end

figure(n),subplot(2,8,1:8),imshow(im);

%read letter
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
count = numel(Iprops);
numberOfNumbers = 0;
noPlate=[]; % Initializing the variable of number plate string.
NumberOfChars = 0;
plot = 9;
for i=1:count
   if Iprops(i).Area > 250 && Iprops(i).Area < 40000 
       [letter, num]=readLetter(Iprops(i).Image); % Reading the letter corresponding the binary image 'N'.
       numberOfNumbers = numberOfNumbers + num;
       subplot(2,8,plot), imshow(Iprops(i).Image);
       plot = plot + 1;
       NumberOfChars = NumberOfChars + 1;
       noPlate=[noPlate letter]; % Appending every subsequent character in noPlate variable.
   end
end

%get car governorate
Governorate = 'empty';
if(NumberOfChars == 6 && numberOfNumbers == 3)
    Governorate = 'Cairo';
elseif(NumberOfChars == 6 && numberOfNumbers == 4)
    Governorate = 'Giza';
else
    Governorate = 'Other governorate';
end

clear c count found h j num oh ow w i maxa letter;
end

