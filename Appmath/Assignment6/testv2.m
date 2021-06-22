%% initialize
close all;
filtersize = 40;
inputimage = 'assignment6.png';
numclick = 1;
workimage1 = rgb2gray(imread(inputimage));
%% settings
mask = ones(size(workimage1));
midpoint = size(workimage1)/2;
%% display grayscaled image
figure(1);
imshow(workimage1)
%% display fft magnitude spectrum
workimage2 = fftshift(fft2(workimage1));

fftimage = fftshift(log(abs(fft2(workimage1))));
figure(2);
colormap gray;
imagesc(fftimage);
%% get input for masking
for i = 1 : 5
[yfilt, xfilt] = ginput(numclick);
hold on;

scatter(yfilt, xfilt, 'r+');
drawnow;

symx = abs(midpoint(1)-xfilt);
symy = abs(midpoint(2)-yfilt);
mask(round(xfilt-filtersize/2) : round(xfilt+filtersize/2),...
     round(yfilt-filtersize/2) : round(yfilt+filtersize/2)) = 0;
mask(round(midpoint(1)+symx-filtersize/2) : round(midpoint(1)+symx+filtersize/2),...
     round(midpoint(2)+symy-filtersize/2) : round(midpoint(2)+symy+filtersize/2)) = 0;
end
%% apply mask and show me
figure(3)
%/ ����ũ ������ �̹��� ������ ����r �ʵ��� if~~
%/ ����ũ�� ��� �ؾ� �����ų�� ����? ����ũ�� ����? �� ������ ������� �� �ù� ���ϰ��ִ°���?
%/ TTlqkfTlqkfTLqkfTlqkfTlqkfTlqkf

workimage3 = mask.* workimage2;

%/ ????���� ����ŷ�� �ȵǰ� ����
finalimage = abs(ifft2(ifftshift(workimage3)));

%finalimage = ifftshift(abs(ifft2(workimage3)));
%/ �ٽ� ������ ������µ� �̹����� �״�γ�?!?!??!?!?!?!??!
figure(4);
imshow(uint8(finalimage));
