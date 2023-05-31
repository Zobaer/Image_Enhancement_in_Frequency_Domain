clc; clear; close all;
fnts=20; 
I=imread('tunnel.bmp');[X, Y]=size(I);
ID = im2double(I);
IL = log(ID+1);
JF=fft2(IL); JFS=fftshift(JF); FS=JFS;
D0 = 15; yH = .85; yL = .6; c = 1;
for i=1:X
    for j=1:Y
        D=(i-(X/2+1))^2+(j-(Y/2+1))^2;
        H(i,j) = (yH-yL)*(1-exp(-c*(D^2/D0^2)))+yL;
    end
end
JFS=FS.*H;
JK=real(ifft2(ifftshift(JFS))); JK = exp(JK)-1;
Jmin=min(min(JK)); Jmax=max(max(JK)); JFR=(JK-Jmin)/Jmax;
figure(1);imshow(I);title('Original Image','FontSize',fnts);
figure(2);imshow(JFR);title('Filtered Image','FontSize',fnts);
