%% Oliva, Pamela Camille E.
%  2009 - 11797
%  CoE 123 Exam 2

%%  PROBLEM # 1                                                             % may take time to simulate
                                                                            % due to a number of for loops    
%%

% Read image
stripe = imread('stripe.jpg');
stripe = im2double(stripe);
[m,n] = size(stripe);


%% Arithmetic Mean Filter

% 3x3
A = imfilter(stripe, ones([3,3]))/(3*3);    

% 7x7
B = imfilter(stripe, ones([7,7]))/(7*7);

% 9x9
C = imfilter(stripe, ones([9,9]))/(9*9);

%% Geometric Mean
%  3x3

% Initialize variables:
window_size = 3;

% Distance from center pixel
radius = floor(window_size/2);

% Boundary pixels will not be filtered. Zero padding only.
margin = radius + 1;
D3 = zeros([m,n]);

for i = margin : m-margin                                                   % Scan whole image except boundary
    for j = margin : n-margin
    window = stripe( i-radius : i+radius, j-radius : j+radius );
    vector = reshape(window, 9, 1);                                         % 2nd parameter of rename()
                                                                            %  should not be a variable
    % Multiply all elements in the subwindow.  Get 9th root.                
    D3(i, j) = geomean(vector);                                             % Has to convert matrix to vector
                                                                            % because geomean only operates per column of matrix
                                                                            
                                                                            % UPDATE! no need for vector, can do
    end                                                                     %         with geomean(geomean(window))
end

%% Geometric Mean
%  7x7:

% Initialization
window_size = 7;
radius = floor(window_size/2);
margin = radius + 1;

D7 = zeros([m,n]);


for i = margin : m-margin 
    for j = margin : n-margin
    window = stripe( i-radius : i+radius, j-radius : j+radius );
    vector = reshape(window, 49, 1);                                        
                                                                            
    % Multiply all elements in the subwindow.  Get 49th root.
    D7(i, j) = geomean(vector);
    
    end
end


%% Geometric Mean
%  9x9:

% Initialization
window_size = 9;
radius = floor(window_size/2);
margin = radius + 1;

D9 = zeros([m,n]);

for i = margin : m-margin 
    for j = margin : n-margin
    window = stripe( i-radius : i+radius, j-radius : j+radius );
    vector = reshape(window, 81, 1);
    
    % Multiply all elements in the subwindow.  Get 81st root.
    D9(i, j) = geomean(vector);
    
    end
end


%% Contraharmonic Filter (Q = 1)
%  3x3

window_size = 3;
radius = floor(window_size/2);
margin = radius + 1;

E3 = zeros([m,n]);


for i = margin : m-margin 
    for j = margin : n-margin
    window = stripe( i-radius : i+radius, j-radius : j+radius );                                        
                                                                            
    % [(a^2) + (b^2) + (c^2)] divided by [a+b+c]
    numerator   = sum(sum( (window.^2) ));
    denominator = sum(sum(  window     )); 
    E3(i, j) = numerator/denominator;                                       % Can have 0/0
    
    end
end

E3(isnan(E3)) = 0;                                                          % Find NaN values, replace with ZERO

%% Contraharmonic Filter (Q = 1)
%  7x7

window_size = 7;
radius = floor(window_size/2);
margin = radius + 1;

E7 = zeros([m,n]);


for i = margin : m-margin 
    for j = margin : n-margin
    window = stripe( i-radius : i+radius, j-radius : j+radius );                                        
                                                                            
    % [(a^2) + (b^2) + (c^2)] divided by [a+b+c]
    numerator   = sum(sum( (window.^2) ));
    denominator = sum(sum(  window     )); 
    E7(i, j) = numerator/denominator;
    
    end
end

E7(isnan(E7)) = 0;

%% Contraharmonic Filter (Q = 1)
%  9x9

window_size = 9;
radius = floor(window_size/2);
margin = radius + 1;

E9 = zeros([m,n]);


for i = margin : m-margin 
    for j = margin : n-margin
    window = stripe( i-radius : i+radius, j-radius : j+radius );                                        
                                                                            
    % [(a^2) + (b^2) + (c^2)] divided by [a+b+c]
    numerator   = sum(sum( (window.^2) ));
    denominator = sum(sum(  window     )); 
    E9(i, j) = numerator/denominator;
    
    end
end

E9(isnan(E9)) = 0; 
%% Harmonic Mean Filter (Contraharmonic with Q = -1)
%  3x3

window_size = 3;
radius = floor(window_size/2);
margin = radius + 1;

F3 = zeros([m,n]);


for i = margin : m-margin 
    for j = margin : n-margin
    window = stripe( i-radius : i+radius, j-radius : j+radius );                                        
                                                                            
    % Reciprocal all elements. Sum up. (Windowsize^2) / Sum.
    F3(i, j) = harmmean(harmmean(window));
    
    end
end

%% Harmonic Mean Filter
%  7x7

window_size = 7;
radius = floor(window_size/2);
margin = radius + 1;

F7 = zeros([m,n]);


for i = margin : m-margin 
    for j = margin : n-margin
    window = stripe( i-radius : i+radius, j-radius : j+radius );                                        
                                                                            
    % Reciprocal all elements. Sum up. (Windowsize^2) / Sum.
    F7(i, j) = harmmean(harmmean(window));
    
    end
end

%% Harmonic Mean Filter (Contraharmonic with Q = -1)
%  9x9

window_size = 9;
radius = floor(window_size/2);
margin = radius + 1;

F9 = zeros([m,n]);


for i = margin : m-margin 
    for j = margin : n-margin
    window = stripe( i-radius : i+radius, j-radius : j+radius );                                        
                                                                            
    % Reciprocal all elements. Sum up. (Windowsize^2) / Sum.
    F9(i, j) = harmmean(harmmean(window));                                  % Harmonic mean of any subwindows with
                                                                            % zero is zero since 1/0 is undefined
    end                                                                     % harmmean() may not have zero correction
end

%% Median Filter

G3 = medfilt2(stripe, [3 3]);      
G7 = medfilt2(stripe, [7 7]);
G9 = medfilt2(stripe, [9 9]);


%% Display images

figure, imshow(stripe), title('Problem 1: Original Image');
figure, imshow(A), title('3x3 Arithmetic Mean Filter');
figure, imshow(B), title('7x7 Arithmetic Mean Filter');
figure, imshow(C), title('9x9 Arithmetic Mean Filter');
figure, imshow(D3), title('3x3 Geometric Mean Filter');
figure, imshow(D7), title('7x7 Geometric Mean Filter');
figure, imshow(D9), title('9x9 Geometric Mean Filter');
figure, imshow(E3), title('3x3 Contraharmonic Mean Filter');
figure, imshow(E7), title('7x7 Contraharmonic Mean Filter');
figure, imshow(E9), title('9x9 Contraharmonic Mean Filter');
figure, imshow(F3), title('3x3 Harmonic Mean Filter');
figure, imshow(F7), title('7x7 Harmonic Mean Filter');
figure, imshow(F9), title('9x9 Harmonic Mean Filter');
figure, imshow(G3), title('3x3 Median Filter');
figure, imshow(G7), title('7x7 Median Filter');
figure, imshow(G9), title('9x9 Median Filter');
