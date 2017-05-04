clear all;
close all;
clc;
%%
[F,P]=uigetfile('.\TEST\.jpg');
I=imread(strcat(P,F));
I=imresize(I,[300,200]);
[m,n,z]=size(I);
if z==3
    I=rgb2gray(I);
end
ik1=1;
for ib1=1:100:300
    load TRN
    I1=I(ib1:ib1+99,:);
    [I1,H2]=HOG(I1);
    imshow(uint8(I1));
    pause(.5)
    if ik1==1
        training_set=TRN.UP;
        CLASS=TRN.UP_LBL;
        e=[];
        for i=1:size(training_set,2)
            q = training_set(:,i);
            DiffWeight = H2-q;
            mag = norm(DiffWeight);
            e = [e mag];
        end
        kk = 1:size(e,2);
        MaximumValue=max(e);
        MinimumValue=min(e);
        n= find(e==MinimumValue);
        n=n(1,1);
        if MinimumValue<=10
            fprintf('PREDICTED DECOSION OF UPPER LEG PART IS %s \n',CLASS{n})
        end
    elseif ik1==2
        training_set=TRN.MP;
        CLASS=TRN.MP_LBL;
        e=[];
        for i=1:size(training_set,2)
            q = training_set(:,i);
            DiffWeight = H2-q;
            mag = norm(DiffWeight);
            e = [e mag];
        end
        kk = 1:size(e,2);
        MaximumValue=max(e);
        MinimumValue=min(e);
        n= find(e==MinimumValue);
        n=n(1,1);
        if MinimumValue<=10
            fprintf('PREDICTED DECOSION OF MIDDLE LEG PART IS %s \n',CLASS{n})
        end
    elseif ik1==3
        training_set=TRN.LP;
        CLASS=TRN.LP_LBL;
        e=[];
        for i=1:size(training_set,2)
            q = training_set(:,i);
            DiffWeight = H2-q;
            mag = norm(DiffWeight);
            e = [e mag];
        end
        kk = 1:size(e,2);
        MaximumValue=max(e);
        MinimumValue=min(e);
        n= find(e==MinimumValue);
        n=n(1,1);
        if MinimumValue<=10
            fprintf('PREDICTED DECOSION OF LOWER LEG PART IS %s \n',CLASS{n})
        end
    end
    ik1=ik1+1;
end
