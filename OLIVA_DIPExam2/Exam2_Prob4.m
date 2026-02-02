%% Oliva, Pamela Camille E.
%  2009 - 11797
%  CoE 123 Exam 2

%%  PROBLEM # 4

%%
lines_orig = imread('lines.bmp');
lines_orig = im2bw(lines_orig);
figure, imshow(lines_orig), title('Problem 4: Original Image') ;

lines = imcrop(lines_orig, [9 9 822 822]);                                  % Crop a little to remove the unneeded lines at the 
figure, imshow(lines), title('Problem 4: Cropped(Preprocessing) Original Image');                                                      % border to exclude them from the Hough transformation


%% Hough transform is used for line detection                               % I wasn't able to detect the arc via Hough

lines_edge = edge(lines,'canny');                                           % Extract edges
[HT, Th ,Rh] = hough(lines_edge);

% Hough Plot
imshow(HT,[],'XData',Th,'YData',Rh, 'InitialMagnification','fit');          % Theta and Rho parameter of Hough plots
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot);

% Hough Peaks Plot
peaks  = houghpeaks(HT, 5, 'threshold', ceil( 0.3 * max( HT(:) ) ) );
x = Th( peaks(:,2) );                                                       % Theta axis location
y = Rh( peaks(:,1) );                                                       % Rho axis location

% Mark peaks in hough plot with white squares 
plot(x,y,'s','color','white');                                              


% Now find the lines in the cropped original image and plot them
Lhough = houghlines(lines_edge, Th, Rh, peaks);                             %Default: FillGap = 20, MinLength = 40
figure, imshow(lines), hold on


for k = 1:length(Lhough)

   xy = [Lhough(k).point1; Lhough(k).point2];                               % Get the 2 endpoints
   plot( xy(:,1), xy(:,2), 'LineWidth', 2, 'Color','red' );                 % Mark with red line segments                               

   len_of_line_seg(k) = (norm(Lhough(k).point1 - Lhough(k).point2)) / 59;   % Measure length
 
end

%% Region props for pixel detection.  Total perimeter using Area from regionprops

bone = ~lines;
bone = bwmorph (bone, 'fill');
bone = bwmorph (bone, 'thin');

[B,L,N,A] = bwboundaries(bone);
STATS = regionprops(L, 'all'); 
length(STATS);

 figure, imshow(~bone), impixelinfo, hold on;

for i = 1 : length(STATS)
  centroid = STATS(i).Centroid;                                               % 1 = circle
  plot(centroid(1),centroid(2),'rO');
end

total_peri = STATS.Area/59
len_of_line_seg(:)

% So now we can get the length of the arc
len_arc = total_peri - sum(len_of_line_seg)


% Running the code, the following values will be displayed at the command window:
%
% len_line1 =  4.3391 cm
% len_line2 =  4.0339 cm
% len_line3 =  2.1356 cm
% len_arc   =  8.4575 cm
% total_perimeter =   18.9661 cm



%% (d) Using Length = 0.948 (# of orthogonal neighbors) + 1.340 (# of diagonal neighbors)

lines_neg = ~lines;

lines_neg = bwmorph (lines_neg, 'skel') ;
lines_neg = bwmorph (lines_neg, 'spur') ;

figure, imshow(lines_neg);
sum(sum(lines_neg))

%%
                
nn = im2double(lines_neg);              % 'logical' kasi kanina kaya ayaw mag-add sa convolution
                                        % kelangan i-cast as 'double'

filt1 = [0 1 0; 1 0 1; 0 1 0];          
filt2 = [1 0 1; 0 0 0; 1 0 1];          

tst1 = imfilter(nn, filt1) * 0.948;     
tst2 = imfilter(nn, filt2) * 1.340;


figure, imshow(tst1);
figure, imshow(tst2);

tst = tst1 + tst2;

figure, imshow(tst);
sum(sum(tst))


