function [Acont, Aener, Acont1, Aener1, Acont2, Aener2] = extract(Numerki)
n = 9;
%figure();
for i = 1:n
    Numerk = Numerki(i);
    [SI, cont, ener, cont1, ener1, cont2, ener2] = extraction(Numerk);
    Acont(i) = cont;
    Aener(i) = ener;
    Acont1(i) = cont1;
    Aener1(i) = ener1;
    Acont2(i) = cont2;
    Aener2(i) = ener2;
    %subplot(3,3,i); imshow(SI);
end
