clc; clear; close all;
fnts=20;I=imread('letter_bar.bmp');[X, Y]=size(I);
JF=fft2(I); JFS=fftshift(JF); FS=JFS;
D0 = 5; %D0 is filter width. For best result, use 5 for Gaussian.
H = ones(size(I));
for i=1:X
    for j=1:Y
        D = sqrt((i-(X/2+1))^2+(j-(Y/2+1))^2);
        H(i,j) =1-exp(-0.5*((D^2)/(D0*D0)));
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
figure(3);imagesc(H);colormap(gray);title('Filter in freq domain','FontSize',fnts);
figure(4);imshow(JFR);title('Filtered Image before Thresholding','FontSize',fnts);
figure(5); imshow(JFF);title('FFT of filtered Image before thresholding','FontSize',fnts);
%Thresholding
meanval = mean(mean(JFR));threshold = meanval*0.6;
JFRT = zeros([X,Y]);
JFRT(find(JFR>threshold))=1;
JFTH = fftshift(fft2(JFRT));JFTH = log(abs(JFTH)+1);
Jmin=min(min(JFTH)); Jmax=max(max(JFTH)); JFTHN=(JFTH-Jmin)/Jmax;
figure(6);imshow(JFRT);title('Filtered and thresholded Image','FontSize',fnts);
figure(7); imshow(JFTHN);title('FFT of filtered Image after thresholding','FontSize',fnts);




