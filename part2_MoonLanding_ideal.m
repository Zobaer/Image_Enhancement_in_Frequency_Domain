clc; clear; close all;
fnts=20;I=imread('MoonLanding.bmp');[X, Y]=size(I);
JF=fft2(I); JFS=fftshift(JF); FS=JFS;JFO = JFS;
JFT=log(abs(FS)+1);
Jmin=min(min(JFT)); Jmax=max(max(JFT)); JFT=(JFT-Jmin)/Jmax;
th=mean(mean(JFT));
[un, vn] = find(JFT>th*1.5);
D0 = 6; H = ones(size(I));
for i=1:X
    for j=1:Y
        for k = 1:length(un)
            D(k) = sqrt((i-un(k))^2+(j-vn(k))^2);
        end
        if(sum(D<D0)>=1)
            H(i,j)=0;
        end
    end
end
W=45; H(X/2-W:X/2+1+W,Y/2-W:Y/2+W+1)=1;
JFS=FS.*H;JK=real(ifft2(ifftshift(JFS)));
Jmin=min(min(JK)); Jmax=max(max(JK)); JFR=(JK-Jmin)/Jmax;
JFF=log(abs(JFS)+1);
Jmin=min(min(JFF)); Jmax=max(max(JFF)); JFF=(JFF-Jmin)/Jmax;
figure(1); imshow(I);title('Original Image','FontSize',fnts);
figure(2); imshow(JFT);title('FFT of Original Image','FontSize',fnts);
figure(3);imagesc(H);colormap(gray);
title('Filter in freq domain','FontSize',fnts);
figure(4);imshow(JFR);title('Filtered Image','FontSize',fnts);
figure(5); imshow(JFF);title('FFT of filtered Image','FontSize',fnts);



