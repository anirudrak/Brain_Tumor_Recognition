function [SI, cont, ener, cont1, ener1, cont2, ener2] = extraction(Numerk)
figure();
waaz  = load(['imageData\', num2str(Numerk), '.mat']);
waaz = waaz.cjdata;
mask = waaz.tumorMask;
image = waaz.image;
mask = single(mask);
image = minMaxNormalize(image);
SI = image;
%SI = mask.*image;

%subplot(1,2,1); imshow(image);
%subplot(1,2,2); imshow(SI);

[cA1] = dwt2(SI, 'db1');
[cA2] = dwt2(SI, 'db2');

cA1 = minMaxNormalize(cA1);
cA2 = minMaxNormalize(cA2);
SI = minMaxNormalize(SI);

[~, SI] = graycomatrix(SI, 'NumLevels', 32);
[~, cA1] = graycomatrix(cA1, 'NumLevels', 32);
[~, cA2] = graycomatrix(cA2, 'NumLevels', 32);

cA1 = minMaxNormalize(cA1);
cA2 = minMaxNormalize(cA2);
SI = minMaxNormalize(SI);

plus = SI;
subplot(1,3,1); imshow(SI);
subplot(1,3,2); imshow(cA1);
subplot(1,3,3); imshow(cA2);

glcm = graycomatrix(plus, 'NumLevels', 32);
glcm = double(glcm/(512*512));

cont = 0; ener = 0; %corr = 0; 
for i = 2:32
    for j = 2:32
        cont = cont + ((i-j)^2)*glcm(i,j);
        ener = ener + (glcm(i,j))^2;
    end;
end;

plus = cA1;
plus = mask.*image;
%plus = minMaxNormalize(plus);
glcm = graycomatrix(plus, 'NumLevels', 32);
glcm = double(glcm/(512*512));

cont1 = 0; ener1 = 0; %corr = 0; 
for i = 2:32
    for j = 2:32
        cont1 = cont1 + ((i-j)^2)*glcm(i,j);
        ener1 = ener1 + (glcm(i,j))^2;
    end;
end;

plus = cA2;
plus = mask.*image;
glcm = graycomatrix(plus, 'NumLevels', 32);
glcm = double(glcm/(512*512));

cont2 = 0; ener2 = 0; %corr = 0; 
for i = 2:32
    for j = 2:32
        cont2 = cont2 + ((i-j)^2)*glcm(i,j);
        ener2 = ener2 + (glcm(i,j))^2;
    end;
end;

size(cA2)
