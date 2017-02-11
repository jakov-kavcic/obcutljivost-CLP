%Da bi ta skripta delovala sta potrebni funkciji obcutljivost_f in
%obcutljivost_b.

% Zapi?emo koeficjente celo?tevilskega linearnega problema, ki ga ho?emo
% opazovati.

A=[1,-2,3,4;    %Matrika koeficjentov
    9,-3,4,5;
    1,-3,5,7;
    2,-4,-5,13]; 
f=[10,10,10,10];   %Vektor namenskih koeficjentov
b=[10,7,3,4];  %Vektor omejitvenih vrednosti

set(0,'DefaultFigureVisible','off'); % Da se ne ska?ejo grafi ceu ?as


options = optimoptions('intlinprog','TolFun',1e-6,'Display', 'off' );

% Preverimo ?e ima problem resitev
intcon=[1,2,3,4];
prva_resitev=intlinprog(f,intcon,A,b,[],[],[1,1,1,1],[inf,inf,inf,inf],options);
if size(prva_resitev) == [0,0] 
    disp('Problem nima resitve!')
    return
else
    disp('Problem ima resitev!')
end

%Generiramo podatke in shranimo grafe

s=30; %Dolocimo stevilo iteracij

[fig,fig1,fig2,fig3,fig4]=obcutljivost_f(A,b,f,s,options);
print(fig,'spremembe_f','-dpng');
print(fig1,'spremembe_f1','-dpng');
print(fig2,'spremembe_f2','-dpng');
print(fig3,'spremembe_f3','-dpng');
print(fig4,'spremembe_f4','-dpng');


[figb,fig1b,fig2b,fig3b,fig4b] = obcutljivost_b(A,b,f,s,options);
print(figb,'spremembe_b','-dpng');
print(fig1b,'spremembe_b1','-dpng');
print(fig2b,'spremembe_b2','-dpng');
print(fig3b,'spremembe_b3','-dpng');
print(fig4b,'spremembe_b4','-dpng');


