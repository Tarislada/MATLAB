%{
1. data ������ �ΰ����� ����: color & depth
2. Color �� xy�࿡ �÷����ϰ�, depth�� z�࿡ plotting�ϸ� 3d image�� ���� �� ������ ���� ������ distinctive ���� �ʾ� �˾ƺ��Ⱑ �����
3. ����, depth data�� ���ױ׸��� �۾��� �ʿ�
4. 3�� ������� ������ �ٽ� colordata�� �÷����Ͽ� ������ '���̷���'���� ������� ����
5. ����, ���̷����� ���� layer�� subplot�Ͽ� �� �� �ֵ��� arrange
  * layer������ ���� �Լ��� �����ؾ� ���߿� ���ϴ� 1000sounds like a good #
  * layer�� ��ǥ���� ��հ�����
%}
load('color_depth.mat');
%% Data reconfig
frameNum2Use = 1;
cdat = colorFrameData(:,:,:,frameNum2Use);
ddat = depthFrameData(:,:,:,frameNum2Use);
cdat_resized = imresize(cdat,size(ddat));

%% Smoothout Depthdata & store in layers
layerdepth = 1000;                          % number range
n = (layerdepth * ceil(max(max(ddat))/layerdepth)) / layerdepth; % # of layers
n = double(n);                              % n needs to be double                      
%%layerdata = zeros([size(ddat) n]);          
newddat = ddat;                             % to conserve original data
meanstring = zeros(1,n);

for ii = 1:n
   range = layerdepth*(ii-1)<=newddat & newddat<layerdepth*ii;
   meanstring(ii) = mean(newddat(range));
   newddat(range) = meanstring(ii);
   
   %layerdata(:,:,ii) = mean(newddat(range));
        % assign the mean of the values of layers to matrix
   %newddat(range) = layerdata(:,:,ii); 
        % tear DDAT apart into layers
end
figure(1);
clf;
warp(max(max(max(newddat)))-newddat,cdat_resized);   %draw whole image


% meanstring�� �� ��(�� n��)�� ������ newddat�� index�� ã�Ƽ�, (=allocationindex)
% cdat_resized���� �ش� index�� ���� �����ϰ� �������� ���� 
% ����: �ش� index�κ��� r���� �����ǰ�, �������� �������� ����. ��, G���� B���� ���� ���� ȭ��+ �ش�κ��� ���� ȭ��
% allocationindex�� ���������ΰ�? = Ȯ�ΰ��, allocationindex�� ���� ��ü cdat_resize�� ������
% �͹��Ͼ��� ������. why? �͹��� ���� ������ ���� �ƴ϶�, 3����¥���� �ƴ� 2���� ������ ������ index�ΰ�!
% newcdat�� (::2)�� (::3)������ �� ������ �̷������ ��!
% �ش� ddat���� cdat���� �Բ� warp
%% cdat rearrange
figure(2);
meanstring = round(meanstring);
meanstring(isnan(meanstring)) = 0;
%�̷��� ���ϸ� ���ڰ� �ȸ°�, nan������ n�� ����� ������ ��ġ���� ����
zeromatrix = 255*ones(size(cdat_resized));
newcdat1 = zeromatrix(:,:,1);
newcdat2 = zeromatrix(:,:,2);
newcdat3 = zeromatrix(:,:,3);
cdat_resized1 = cdat_resized(:,:,1);
cdat_resized2 = cdat_resized(:,:,2);
cdat_resized3 = cdat_resized(:,:,3);
drawingddat = zeros(size(ddat));
for ii = 1:n
    allocationindex = find(newddat==meanstring(ii));
    newcdat1(allocationindex) = cdat_resized(allocationindex);
    newcdat2(allocationindex) = cdat_resized(allocationindex);
    newcdat3(allocationindex) = cdat_resized(allocationindex);
    newcdat = cat(3,newcdat1,newcdat2,newcdat3);
    drawingddat(allocationindex) = newddat(allocationindex);
    subplot(2,n/2,ii);
    warp(drawingddat,newcdat);
end



%{
newcdat = zeros([size(cdat_resized)]);  % create newcdat that will be used to draw layerd image
index = find(layerdata~=0);             % index info of where layerdata ~= 0
newcdat(find(layerdata~=0)) = cdat_resized(find(layerdata~=0));   % assign value of cdat in the position where layerdata is not 0


layerdata 


%% Print by layer

figure(2)
for ii = 1:n
subplot(1,n,ii);
warp(max(max(max(layerdata(:,:,ii))))-layerdata(:,:,ii),newcdat);
end
%}