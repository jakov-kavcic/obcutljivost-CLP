function [fig,fig1,fig2,fig3,fig4,X1,X2,X3,X4] = obcutljivost_f(A,b,f,s,options)

%dolocimo spremenljivke, ki morajo biti celostevilske
intcon=[1,2,3,4];

%Dolocimo prvo reisitev
prva_resitev=intlinprog(f,intcon,A,b,[],[],[1,1,1,1],[1000,1000,1000,1000],options);

% Spreminjamo vrednosti namenske funkcije
h=1;
for i = 1:4 
    j=1;
    o=f(i);
    for n = 1:s %naredimo 30 iteracij poskusa
        df=-10+20*rand(); % random spremenljivka z intervala (-10,10)
        f(i)=f(i)+df;
        [x,fval,exitflag,output]=intlinprog(f,intcon,A,b,[],[],[1,1,1,1],[1000,1000,1000,1000],options);
        F(i,j)=fval;
        F(i,j+1)=df;
        X(:,h)=x;
        j=j+2;
        h=h+1;
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
X1=X(:,1:s);
X2=X(:,s+1:2*s);
X3=X(:,2*s+1:3*s);
X4=X(:,3*s+1:4*s);

    
%narisemo vse spremembe skupaj
fig=figure;
plot(F1_x,F1_y,'c*',F2_x,F2_y,'k*',F3_x,F3_y,'g*',F4_x,F4_y,'b*',[0],f*prva_resitev,'ro');
title('Spremembe f-a');
xlabel('sprememba f');
ylabel('optimalna vrednost');
legend('sprememba prvega koeficienta','sprememba drugega koeficienta','sprememba tretjega koeficienta','sprememba cetrtega koeficienta','originalna resitev');
hold off

%Najdemo najboljse prilagajoci polinom druge stopnje za mnozico tock (F1_x,F1_y)
f1=fit(F1_x',F1_y','poly2'); %polinom
k1=coeffvalues(f1); %koeficienti polinoma

%Ali se spreminja resitev?
a1=0;
for i=2:s
    for j=1:4
        if X1(j,i)~=X1(j,i-1)
            a1=1;
        end
    end
end
if a1~=0;
    a1_t='Resitev se spreminja.';
else a1_t='Resitev se ne spreminja.';
end

%Narisemo graf ter ga shranimo za (F1_x,F1_y)
fig1=figure;
plot(f1, '-g',F1_x,F1_y,'c*');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe prvega koeficienta namenske funkcije');
xlabel('sprememba koeficienta~');
ylabel('optimalna vrednost');
text(0,f1(0)-1,a1_t) % enacba funkcije koeficjenti so k1
hold off

%Najdemo najboljse prilagajoci polinom druge stopnje za mnozico tock (F2_x,F2_y)
f2=fit(F2_x',F2_y','poly2'); %polinom
k2=coeffvalues(f2); %koeficienti polinoma

%Ali se spreminja resitev?
a2=0;
for i=2:s
    for j=1:4
        if X2(j,i)~=X2(j,i-1)
            a2=1;
        end
    end
end
if a2~=0;
    a2_t='Resitev se spreminja.';
else a2_t='Resitev se ne spreminja.';
end

%Narisemo graf ter ga shranimo za (F2_x,F2_y)
fig2=figure;
plot(f2, '-g',F2_x,F2_y,'co');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe drugega koeficienta namenske funkcije');
xlabel('sprememba koeficienta');
ylabel('optimalna vrednost');
text(0,f1(0)-1,a2_t)
hold off

%Najdemo najboljse prilagajoci polinom druge stopnje za mnozico tock (F3_x,F3_y)
f3=fit(F3_x',F3_y','poly2'); %polinom
k3=coeffvalues(f3); %koeficienti polinoma

%Ali se spreminja resitev?
a3=0;
for i=2:s
    for j=1:4
     if X3(j,i)~=X3(j,i-1)
        a3=1;
     end
    end
end
if a3~=0;
    a3_t='Resitev se spreminja.';
else a3_t='Resitev se ne spreminja.';
end

%Narisemo graf ter ga shranimo za (F3_x,F3_y)
fig3=figure;
plot(f3, '-g',F3_x,F3_y,'co');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe tretjega koeficienta namenske funkcije');
xlabel('sprememba koeficienta');
ylabel('optimalna vrednost');
text(0,f3(0)-1,a3_t)
hold off

%Najdemo najboljse prilagajoci polinom druge stopnje za mnozico tock (F4_x,F4_y)
f4=fit(F4_x',F4_y','poly2'); %polinom
k4=coeffvalues(f4); %koeficienti polinoma

%Ali se spreminja resitev?
a4=0;
for i=2:s
    for j=1:4
        if X4(j,i)~=X4(j,i-1)
            a4=1;
        end
    end
end
if a4~=0;
    a4_t='Resitev se spreminja.';
else a4_t='Resitev se ne spreminja.';
end

%Narisemo graf ter ga shranimo za (F4_x,F4_y)
fig4=figure;
plot(f4, '-g',F4_x,F4_y,'co');
hold on
plot([0],f*prva_resitev,'ro')
title('Spremembe cetrtega koeficienta namenske funkcije');
xlabel('sprememba koeficienta');
ylabel('optimalna vrednost');
text(0,f4(0)-1,a4_t) % enacba funkcije koeficienti so k4
hold off

end



