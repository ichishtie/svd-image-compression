% Prompt user for file name and then read the image file.
% Convert image matrix to double precision.
% Obtain matrix dimensions.
prompt = 'File Name: ';
img = imread(input(prompt,'s'));
img = im2double(img);
sz = size(img);

% Calculate the length later used to determine the number of 
% terms retained when creating the compressed matrix.
num = min([sz(1) sz(2)]);
num = round(num * 1/10);

% Divide 3-D matrix to its three 2-D components (Red, Green, Blue).
matrix1 = img(:,:,1);
matrix2 = img(:,:,2);
matrix3 = img(:,:,3);

% Delete all the values in the matrix of eigenvalues, except for the amount
% specified in the previous calculation.
[U,S,V] = svd(matrix1);
sz2 = size(S);
if sz2(1) < sz2(2)
    len = sz2(1);
else
    len = sz2(2);
end
for n = num:len
    S(n,n) = 0;
end
matrix1 = U*S*V';

[U,S,V] = svd(matrix2);
sz2 = size(S);
if sz2(1) < sz2(2)
    len = sz2(1);
else
    len = sz2(2);
end
for n = num:len
    S(n,n) = 0;
end
matrix2 = U*S*V';

[U,S,V] = svd(matrix3);
sz2 = size(S);
if sz2(1) < sz2(2)
    len = sz2(1);
else
    len = sz2(2);
end
for n = num:len
    S(n,n) = 0;
end
matrix3 = U*S*V';

% Reconstruct the original image matrix into its compressed form.
finalmatrix = zeros(sz(1),sz(2),sz(3));
finalmatrix(:,:,1) = matrix1;
finalmatrix(:,:,2) = matrix2;
finalmatrix(:,:,3) = matrix3;

% Prompt user for information on where to store compressed image file.
% Write image file to desired location.
prompt = 'File Name: ';
fileName = input(prompt,'s');
imwrite(finalmatrix,fileName);
