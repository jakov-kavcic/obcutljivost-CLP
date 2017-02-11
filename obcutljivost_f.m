function [fig,fig1,fig2,fig3,fig4] = obcutljivost_f(A,b,f,s,options)

%dolo?imo spremenljivke, ki morajo biti celo?tevilske
intcon=[1,2,3,4];

%Dolocimo prvo reisitev
prva_resitev=intlinprog(f,intcon,A,b,[],[],[1,1,1,1],[inf,inf,inf,inf],options);

% Spreminjamo vrednosti namenske funkcije
for i = 1:4 
    j=1;
    o=f(i);
    for n = 1:s %naredimo s iteracij poskusa
        df=-10+20*rand(); % random spremenljivka z intervala (-10,10)
        f(i)=f(i)+df;
        [x,fval,exitflag,output]=intlinprog(f,intcon,A,b,[],[],[1,1,1,1],[1000,1000,1000,1000],options);
        F(i,j)=fval;
        F(i,j+1)=df;
        j=j+2;
        f(i)=o;
    end
end

%Locimo podatke
F1_y=F(1,1:2:end);
F1_x=F(1,2:2:end);
F2_y=F(2,1:2:end);
F2_x=F(2,2:2:end);       
F3_y=F(3,1:2:end);
F3_x=F(3,2:2:end);     
F4_y=F(4,1:2:end);
F4_x=F(4,2:2:end); 

%nari?emo vse spremembe skupaj
fig=figure;
plot(F1_x,F1_y,'c*',F2_x,F2_y,'k*',F3_x,F3_y,'g*',F4_x,F4_y,'b*',[0],f*prva_resitev,'ro');
title('Spremembe f-a');
xlabel('sprememba f');
ylabel('optimalna vrednost');
legend('sprememba prvega koeficjenta','sprememba drugega koeficjenta','sprememba tretjega koeficjenta','sprememba cetrtega koeficjenta','originalna resitev');
hold off

%Najdemo najbolj?e prilagajo?i polinom druge stopnje za mno?ico to?k (F1_x,F1_y)
f1=fit(F1_x',F1_y','poly2'); %polinom
k1=coeffvalues(f1); %koeficjenti polinoma

%Nari?emo graf ter ga shranimo za (F1_x,F1_y)
fig1=figure;
plot(f1, '-g',F1_x,F1_y,'c*');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe prvega koeficjenta namenske funkcije');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,f1(0)-1,texlabel(f1)) % ena?ba funkcije koeficjenti so k1
hold off

%Najdemo najbolj?e prilagajo?i polinom druge stopnje za mno?ico to?k (F2_x,F2_y)
f2=fit(F2_x',F2_y','poly2'); %polinom
k2=coeffvalues(f2); %koeficjenti polinoma

%Nari?emo graf ter ga shranimo za (F2_x,F2_y)
fig2=figure;
plot(f2, '-g',F2_x,F2_y,'co');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe drugega koeficjenta namenske funkcije');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,f1(0)-1,texlabel(f2)) % ena?ba funkcije koeficjenti so k2
hold off

%Najdemo najbolj?e prilagajo?i polinom druge stopnje za mno?ico to?k (F3_x,F3_y)
f3=fit(F3_x',F3_y','poly2'); %polinom
k3=coeffvalues(f3); %koeficjenti polinoma

%Nari?emo graf ter ga shranimo za (F3_x,F3_y)
fig3=figure;
plot(f3, '-g',F3_x,F3_y,'co');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe tretjega koeficjenta namenske funkcije');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,f3(0)-1,texlabel(f3)) % ena?ba funkcije koeficjenti so k3
hold off

%Najdemo najbolj?e prilagajo?i polinom druge stopnje za mno?ico to?k (F4_x,F4_y)
f4=fit(F4_x',F4_y','poly2'); %polinom
k4=coeffvalues(f4); %koeficjenti polinoma

%Nari?emo graf ter ga shranimo za (F4_x,F4_y)
fig4=figure;
plot(f4, '-g',F4_x,F4_y,'co');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe cetrtega koeficjenta namenske funkcije');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,f4(0)-1,texlabel(f4)) % ena?ba funkcije koeficjenti so k4
hold off

end


