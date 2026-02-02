%% Oliva, Pamela Camille E.
%  2009 - 11797
%  CoE 123 Exam 2

%%  PROBLEM # 3

%%

tv = imread ('tv.jpg');
tv = im2double(tv);
figure, imshow(tv), title('Problem 3: Original Image');

%% RGB Monochrome

R = tv(:,:,1);
G = tv(:,:,2);
B = tv(:,:,3);

figure, imshow(R), title('[RGB] Red Component');                            % RED
figure, imshow(G), title('[RGB] Green Component');                          % GREEN
figure, imshow(B), title('[RGB] Blue Component');                           % BLUE


%% HSI 

theta = acos((0.5.*((R-G)+(R-B)))./((R-G).^2+(R-B).*(G-B)).^0.5);           % Applying formula

H = theta;                       
H(B > G) = (2*pi) - H(B>G);                                                 % in radians
H = H/(2*pi);                                                               % HUE                                                

S = 1 - (3./(R+G+B)).*(min(min(R,G),B));                                    % SATURATION

I = (1/3)*(R+G+B);                                                         % INTENSITY

figure, imshow (H), title('[HSI] Hue Component');
figure, imshow (S), title('[HSI] Saturation Component');
figure, imshow (I), title('[HSI] Intensity Component');

%% CMY

C = 1 - R;
M = 1 - G;
Y = 1 - B;

figure, imshow(C), title('[CMY] Cyan Component') ;
figure, imshow(M), title('[CMY] Magenta Component') ;
figure, imshow(Y), title('[CMY] Yellow Component') ;

%% LAB

X = (0.588 * R) + (0.179 * G) + (0.183 * B);
Y = (0.29  * R) + (0.606 * G) + (0.105 * B);
Z = (0     * R) + (0.068 * G) + (1.021 * B);

% However, there is a matlab function that can convert directly RGB to Lab

cform = makecform('srgb2lab');
lab = applycform(tv, cform);

L = lab(:,:,1);
a = lab(:,:,2);
b = lab(:,:,3);

figure, imshow(L), title('[Lab] Lightness(L) Component') ;
figure, imshow(a), title('[Lab] a Component') ;;
figure, imshow(b), title('[Lab] b Component') ;

