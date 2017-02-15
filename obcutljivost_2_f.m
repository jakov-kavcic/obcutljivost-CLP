function [fig,fig1,fig2,X1,X2]=obcutljivost_2_f(A,b,f,s,options)
%dolo?imo spremenljivke, ki morajo biti celo?tevilske
intcon=[1,2];

%Dolocimo prvo reisitev
prva_resitev=intlinprog(f,intcon,A,b,[],[],[1,1],[inf,inf],options);

options = optimoptions('intlinprog','TolFun',1e-6,'Display', 'off' );

X=[];
h=1;
for i = 1:2 
    j=1;
    o=f(i);
    for n = 1:s %naredimo s iteracij poskusa
        df=-5+10*rand(); % random spremenljivka z intervala (-5,5)
        f(i)=f(i)+df;
        [x,fval,exitflag,output]=intlinprog(f,intcon,A,b,[],[],[1,1],[1000,1000],options);
        F(i,j)=fval;
        F(i,j+1)=df;
        X(:,h)=x;
        h=h+1;
        j=j+2;
        f(i)=o;
    end
end

%Locimo podatke
F1_y=F(1,1:2:end);
F1_x=F(1,2:2:end);
F2_y=F(2,1:2:end);
F2_x=F(2,2:2:end);
X1=X(:,1:s);
X2=X(:,s+1:2*s);


%nari?emo vse spremembe skupaj
fig=figure;
plot(F1_x,F1_y,'c*',F2_x,F2_y,'k*',[0],f*prva_resitev,'ro');
title('Spremembe f-a');
xlabel('sprememba f');
ylabel('optimalna vrednost');
legend('sprememba prvega koeficjenta','sprememba drugega koeficjenta','originalna resitev');
hold off

%Najdemo najbolj?e prilagajo?i polinom druge stopnje za mno?ico to?k (F1_x,F1_y)
f1=fit(F1_x',F1_y','poly2'); %polinom
k1=coeffvalues(f1); %koeficjenti polinoma

a1=0;
for i=2:s
    for j=1:2
     if X1(j,i)~=X1(j,i-1)
        a1=1;
     end
    end
end
if a1~=0;
    a1_t='Resitev se spreminja.';
else a1_t='Resitev se ne spreminja.';
end

%Nari?emo graf ter ga shranimo za (F1_x,F1_y)
fig1=figure;
plot(f1, '-g',F1_x,F1_y,'c*');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe prvega koeficjenta namenske funkcije');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,f1(0)-1,a1_t) % ena?ba funkcije koeficjenti so k1
hold off

%Najdemo najbolj?e prilagajo?i polinom druge stopnje za mno?ico to?k (F2_x,F2_y)
f2=fit(F2_x',F2_y','poly2'); %polinom
k2=coeffvalues(f2); %koeficjenti polinoma

a2=0;
for i=2:s
    for j=1:2
     if X2(j,i)~=X2(j,i-1)
        a2=1;
     end
    end
end
if a2~=0;
    a2_t='Resitev se spreminja.';
else a2_t='Resitev se ne spreminja.';
end

%Nari?emo graf ter ga shranimo za (F2_x,F2_y)
fig2=figure;
plot(f2, '-g',F2_x,F2_y,'co');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe drugega koeficjenta namenske funkcije');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,f1(0)-1,a2_t) % ena?ba funkcije koeficjenti so k2
hold off





end

