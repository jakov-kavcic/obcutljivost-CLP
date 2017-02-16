% Obcutljivost dvorazseznega celostevilskega linearnega problema.

A=[-3,1;
    2,1];
b=[3,10];
f=[-4,6];

set(0,'DefaultFigureVisible','off'); % Da grafi ne skacejo celi cas


options = optimoptions('intlinprog','TolFun',1e-6,'Display', 'off' );

% Preverimo ce ima problem resitev
intcon=[1,2];
prva_resitev=intlinprog(f,intcon,A,b,[],[],[1,1],[inf,inf],options);
if size(prva_resitev) == [0,0] 
    disp('Problem nima resitve!')
    return
else
    disp('Problem ima resitev!')
end

%Generiramo podatke in shranimo grafe

s=40; %Dolocimo stevilo iteracij

[fig,fig1,fig2,X1,X2]=obcutljivost_2_f(A,b,f,s,options);
print(fig,'spremembe_2_f','-dpng');
print(fig1,'spremembe_2_f1','-dpng');
print(fig2,'spremembe_2_f2','-dpng');



[figb,fig1b,fig2b,Y1,Y2] = obcutljivost_2_b(A,b,f,s,options);
print(figb,'spremembe_2_b','-dpng');
print(fig1b,'spremembe_2_b1','-dpng');
print(fig2b,'spremembe_2_b2','-dpng');

%Vizualizacija problema
% hocemo minimizirati funkcijo fun(x,y)=-4x+6y, pri pogojih y-3x<=6, y+2x<=10
% in x,y sta pozitivni celi ?tevili.

% b spremenimo iz [3,10] -> [3,8]
Viz1=figure; % Vpliv omejitvenega vektorja
fill3([1,1,7/5,9/2]',[1,6,36/5,1]',[0,0,0,0]','y'); %Dopustne resitve
hold on
fill3([1,1,7/5,9/2]',[1,6,36/5,1]',[2,32,188/5,-12]','r'); %Vrednost namenske funkcije
fill3([1,1,7/2]',[1,6,1]',[0,0,0]','o'); %Dopustne resitve po spremembi drugega koeficienta b
fill3([1,1,7/2]',[1,6,1]',[2,32,-8]','g'); %Vrednost namenske funkcije po spremembi drugega koeficienta b 
xlabel('x');
ylabel('y');
zlabel('vrednost namenske funkcije');
grid on
title('Vpliv omejitvenega vektorja')
legend('Dopustne resitve','Vrednost namenske funkcije','Dopustne resitve po spremembi','Vrednosti namenske funkcije po spremembi');
fill3([1,1 ; 1,1 ; 7/5,7/5 ; 9/2,9/2]',[1,1 ; 6,6 ; 36/5,36/5 ; 1,1,]',[0,2 ; 0,32 ; 0,188/5; 0,-12]','b') %brez sprememb crte
fill3([1,1 ; 1,1 ; 7/2,7/2]',[1,1 ; 6,6 ; 1,1]',[0,2 ; 0,32 ; 0,-8]','b') % crte za spremenjeno
hold off
print(Viz1,'viz1','-dpng');


% f spremenimo iz [-4,6] -> [1,6]
Viz2=figure; % Vpliv namenskega vektorja
fill3([1,1,7/5,9/2]',[1,6,36/5,1]',[0,0,0,0]','y'); %Dopustne resitve
hold on
fill3([1,1,7/5,9/2]',[1,6,36/5,1]',[2,32,188/5,-12]','r'); %Vrednost namenske funkcije
fill3([1,1,7/5,9/2]',[1,6,36/5,1]',[7,37,44.6,10.5]','g'); %Vrednost namenske funkcije po spremembi 
xlabel('x');
ylabel('y');
zlabel('vrednost namenske funkcije');
grid on
title('Vpliv namenskega vektorja')
legend('Dopustne resitve','Vrednost namenske funkcije','Vrednosti namenske funkcije po spremembi');
fill3([1,1 ; 1,1 ; 7/5,7/5 ; 9/2,9/2]',[1,1 ; 6,6 ; 36/5,36/5 ; 1,1,]',[0,2 ; 0,32 ; 0,188/5; 0,-12]','b') %brez sprememb crte
fill3([1,1 ; 1,1 ; 7/5,7/5 ; 9/2,9/2]',[1,1 ; 6,6 ; 36/5,36/5 ; 1,1,]',[0,7 ; 0,37 ; 0,44.6; 0,10.5]','b') % crte za spremenjeno
hold off
print(Viz2,'viz2','-dpng');




