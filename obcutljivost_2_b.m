
function [figb,fig1b,fig2b,Y1,Y2] = obcutljivost_2_b(A,b,f,s,options)

%dolo?imo spremenljivke, ki morajo biti celo?tevilske
intcon=[1,2];

%Dolocimo prvo reisitev
prva_resitev=intlinprog(f,intcon,A,b,[],[],[1,1],[inf,inf],options);

% spreminjamo vrednosti omejitev
Y=[];
h=1;
for i = 1:2 
    j=1;
    o=b(i);
    for n = 1:s %naredimo 30 iteracij poskusa
        db=-5+10*rand(); % random spremenljivka z intervala (-5,5)
        b(i)=b(i)+db;
        [x,fval,exitflag,output]=intlinprog(f,intcon,A,b,[],[],[1,1],[1000,1000],options);
        B(i,j)=fval;
        B(i,j+1)=db;
        Y(:,h)=x;
        j=j+2;
        h=h+1;
        b(i)=o;
    end
end

%Locimo podatke
B1_y=B(1,1:2:end);
B1_x=B(1,2:2:end);
B2_y=B(2,1:2:end);
B2_x=B(2,2:2:end);       
Y1=Y(:,1:s);
Y2=Y(:,s+1:2*s);

%Nari?emo vse spremembe skupaj
figb=figure;
plot(B1_x,B1_y,'c*',B2_x,B2_y,'k*',[0],f*prva_resitev,'ro');
title('spremembe b-ja');
xlabel('sprememba b');
ylabel('optimalna vrednost');
legend('sprememba prvega koeficjenta','sprememba drugega koeficjenta','originalna resitev');
hold off


%Najdemo najbolj?e prilagajo?i graf za mno?ico to?k (B1_x,B1_y)
B1=fit(B1_x',B1_y','linearinterp'); %polinom
h1=coeffvalues(B1); %koeficjenti polinoma

b1=0;
for i=2:s
    for j=1:2
     if Y1(j,i)~=Y1(j,i-1)
        b1=1;
     end
    end
end
if b1~=0;
    b1_t='Resitev se spreminja.';
else b1_t='Resitev se ne spreminja.';
end

%Nari?emo graf ter ga shranimo za (B1_x,B1_y)
fig1b=figure;
plot(B1, '-r',B1_x,B1_y,'ro');
hold on
plot([0],f*prva_resitev,'gx')
title('Spremembe prvega koeficjenta omejitvenega vektorja');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,B1(0)+1,b1_t)
hold off

%Najdemo najbolj?e prilagajo?i graf za mno?ico to?k (B2_x,B2_y)
B2=fit(B2_x',B2_y','linearinterp'); %polinom
h2=coeffvalues(B2); %koeficjenti polinoma

%Ali se optimalna resitev spreminja?
b2=0;
for i=2:s
    for j=1:2
     if Y2(j,i)~=Y2(j,i-1)
        b2=1;
     end
    end
end
if b2~=0;
    b2_t='Resitev se spreminja.';
else b2_t='Resitev se ne spreminja.';
end

%Nari?emo graf ter ga shranimo za (B2_x,B2_y)
fig2b=figure;
plot(B2, '-r',B2_x,B2_y,'ro');
hold on
plot([0],f*prva_resitev,'gx')
title('Spremembe drugega koeficjenta omejitvenega vektorja');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,B1(0)+1,b2_t)
hold off
end