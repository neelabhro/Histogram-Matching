%Neelabhro Roy
%2016171
clear;
clc;

%Histogram Matching Basic

R = [2.4 3 3 3]
%R = round(R);
Z = [0 0.9 3 3]
%Z = round(Z);
M = [0 0 0 0];

%min = abs( Z(1)-R(1));

for i=1:4
    
    for j=1:3
        min = abs( Z(i)-R(i));
        if abs(Z(j) - R(i)) <= min
            %break
            min = abs(Z(j) - R(i));
            %break
            M(i) = j-1;
            %break;
        else if(Z(j)==R(i))
                M(i)=j-1;
                break;
            end
            
        end
       
    end
    
end
%M = M-1;
disp('The Matched Values without Rounding off are: ');
M



%%

%Neelabhro Roy
%2016171
clear;
clc;


%%%%%%%%%%%%%%%%%%compute histogram and T(r)
x=double(imread('cameraman.tif')); % inpute image
[M,N]=size(x);


for i=0:255
h(i+1)=sum(sum(x==i)); % histogram of input image
end

% compute hist equalization
y=x; % initialize output image y
s=sum(h);
figure,imshow(imread('cameraman.tif')) %show input image
title('Input image')
figure,imhist(imread('cameraman.tif')) % show input hist
title('Input image hist')

for r = 0:255
T(r+1)=uint8(sum(h(1:r))/s*255); %T(r)
end


x = imadjust(imread('cameraman.tif'),[],[],.4);% specified image, it is only contrast enhanced
[M,N]=size(x);


for i=0:255
h1(i+1)=sum(sum(x==i));
end
% compute hist equalization

s=sum(h1);
figure;
imshow(imread('Friends.jpg')) %show specified image
figure;
imshow(uint8(x))
title('Specified image')
figure 
imhist(uint8(x)) % show specified hist
title('Specified image hist')


for z = 0:255
G(z+1)=uint8(sum(h1(1:z))/s*255); %G(z)
end


[pix] = unique(y); % find all indices of unique pixel values
matchedY = y; %initialize matched output as matchedY


for i =1:numel(pix)
diffpix = abs(double(T(pix(i)+1))-double(G)); % for every unique pixel value in 'y' find difference of T(r) and G(z)
[~,ind]=min(diffpix); % find index of nearest value of a unique pixel value in 'y' in G(z)
val = ind-1; %take the pixel value corresponding to index obtained in previous line
I=find(y==pix(i)); % find all indices of pixels with value 'pix(i)' in 'y'
matchedY(I)=val; % substitute pixel value 'val' in the indices obtained in previous line
end

figure,imshow(uint8(matchedY)) %show matched image
title('Hist Matched image')
figure,imhist(uint8(matchedY)) % show matched hist
title('Matched image hist')
