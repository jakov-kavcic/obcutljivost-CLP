%Da bi ta skripta delovala sta potrebni funkciji obcutljivost_f in
%obcutljivost_b.

% Zapisemo koeficiente celostevilskega linearnega programa, ki ga hocemo
% opazovati.


%Ta deluje vendar se resitev ne spreminja pod vplivom f-a (CLP-1)
% A=[1,-2,3,4;    %Matrika koeficientov
%     9,-3,4,5;
%     1,-3,5,7;
%     2,-4,-5,13]; 
% f=[10,10,10,10];   %Vektor namenskih koeficientov
% b=[12,12,12,12]; %Vektor omejitvenih vrednosti

% % % Ta deluje in zanimivi rezultati za spremembe f-a (CLP-2)
A=[2,6,-3,-3;
    2,4,1,-1;
    -4,-7,-4,-5;
    7,-3,-4,-5]; 
f=[-10,-10,-10,-10];   %Vektor namenskih koeficientov
b=[12,12,-12,12];
    

set(0,'DefaultFigureVisible','off'); % Da grafi ne skacejo celi cas


options = optimoptions('intlinprog','TolFun',1e-6,'Display', 'off' );

% Preverimo ce ima problem resitev
intcon=[1,2,3,4];
prva_resitev=intlinprog(f,intcon,A,b,[],[],[1,1,1,1],[1000,1000,1000,1000],options);
if size(prva_resitev) == [0,0] 
    disp('Problem nima resitve!')
    return
else
    disp('Problem ima resitev!')
end

%Generiramo podatke in shranimo grafe

s=40; %Dolocimo stevilo iteracij

[fig,fig1,fig2,fig3,fig4,X1,X2,X3,X4]=obcutljivost_f(A,b,f,s,options);
print(fig,'spremembe_f','-dpng');
print(fig1,'spremembe_f1','-dpng');
print(fig2,'spremembe_f2','-dpng');
print(fig3,'spremembe_f3','-dpng');
print(fig4,'spremembe_f4','-dpng');


[figb,fig1b,fig2b,fig3b,fig4b,Y1,Y2,Y3,Y4] = obcutljivost_b(A,b,f,s,options);
print(figb,'spremembe_b','-dpng');
print(fig1b,'spremembe_b1','-dpng');
print(fig2b,'spremembe_b2','-dpng');
print(fig3b,'spremembe_b3','-dpng');
print(fig4b,'spremembe_b4','-dpng');
