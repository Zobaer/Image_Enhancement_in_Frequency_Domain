clc; clear; close all;
fnts=20;
I=imread('clowngray.bmp');[X, Y]=size(I);
JF=fft2(I); JFS=fftshift(JF); FS=JFS;
u0=124; v0=190; u1=172; v1=106; 
u3=136; v3=127; u4=160; v4=169;
D0=50;
H = ones(size(I));
for i=1:X
    for j=1:Y
        D1=(i-u0)^2+(j-v0)^2;
        D2=(i-u1)^2+(j-v1)^2;
        D3=(i-u3)^2+(j-v3)^2;
        D4=(i-u4)^2+(j-v4)^2;
        if(D1<=D0||D2<=D0||D3<=D0||D4<=D0) H(i,j) = 0;end
    end
end
JFS=FS.*H;JK=real(ifft2(ifftshift(JFS)));
Jmin=min(min(JK)); Jmax=max(max(JK)); JFR=(JK-Jmin)/Jmax;
JFF=log(abs(JFS)+1);
Jmin=min(min(JFF)); Jmax=max(max(JFF)); JFF=(JFF-Jmin)/Jmax;
JFT=log(abs(FS)+1);
Jmin=min(min(JFT)); Jmax=max(max(JFT)); JFT=(JFT-Jmin)/Jmax;
figure(1); imshow(I);title('Original Image','FontSize',fnts);
figure(2); imshow(JFT);title('FFT of Original Image','FontSize',fnts);
figure(3);imagesc(H);colormap(gray);
title('Filter in freq domain','FontSize',fnts);
figure(4);imshow(JFR);title('Filtered Image','FontSize',fnts);
figure(5); imshow(JFF);title('FFT of filtered Image','FontSize',fnts);




