close all;
clear all;
I= imread('Case 3/image 2.jpg');

[w,h,~] = size(I);
area = w*h;

if(area > 49000)
    I1=I(1:size(I,1)/2,1:size(I,2)/2,:);
    I2=I(size(I,1)/2+1:size(I,1),1:size(I,2)/2,:);
    I3=I(1:size(I,1)/2,size(I,2)/2+1:size(I,2),:);
    I4=I(size(I,1)/2+1:size(I,1),size(I,2)/2+1:size(I,2),:);

    [TypeOfVehicle1,Governorate1,numberOfNumbers1,NumberOfChars1] = segmentImage(I1,1);
    [TypeOfVehicle2,Governorate2,numberOfNumbers2,NumberOfChars2] = segmentImage(I2,2);
    [TypeOfVehicle3,Governorate3,numberOfNumbers3,NumberOfChars3] = segmentImage(I3,3);
    [TypeOfVehicle4,Governorate4,numberOfNumbers4,NumberOfChars4] = segmentImage(I4,4);
else
    [TypeOfVehicle,Governorate,numberOfNumbers,NumberOfChars] = segmentImage(I,1);
end

clear area h w c;