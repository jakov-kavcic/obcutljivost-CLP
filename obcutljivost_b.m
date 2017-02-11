
function [figb,fig1b,fig2b,fig3b,fig4b] = obcutljivost_b(A,b,f,s,options)

%dolo?imo spremenljivke, ki morajo biti celo?tevilske
intcon=[1,2,3,4];

%Dolocimo prvo reisitev
prva_resitev=intlinprog(f,intcon,A,b,[],[],[1,1,1,1],[inf,inf,inf,inf],options);

% spreminjamo vrednosti omejitev
for i = 1:4 
    j=1;
    o=b(i);
    for n = 1:s %naredimo 30 iteracij poskusa
        db=-10+20*rand(); % random spremenljivka z intervala (-8,10)
        b(i)=b(i)+db;
        [x,fval,exitflag,output]=intlinprog(f,intcon,A,b,[],[],[1,1,1,1],[1000,1000,1000,1000],options);
        B(i,j)=fval;
        B(i,j+1)=db;
        j=j+2;
        b(i)=o;
    end
end

%Locimo podatke
B1_y=B(1,1:2:end);
B1_x=B(1,2:2:end);
B2_y=B(2,1:2:end);
B2_x=B(2,2:2:end);       
B3_y=B(3,1:2:end);
B3_x=B(3,2:2:end);     
B4_y=B(4,1:2:end);
B4_x=B(4,2:2:end); 

%Nari?emo vse spremembe skupaj
figb=figure;
plot(B1_x,B1_y,'c*',B2_x,B2_y,'k*',B3_x,B3_y,'g*',B4_x,B4_y,'b*',[0],f*prva_resitev,'ro');
title('spremembe b-ja');
xlabel('sprememba b');
ylabel('optimalna vrednost');
legend('sprememba prvega koeficjenta','sprememba drugega koeficjenta','sprememba tretjega koeficjenta','sprememba cetrtega koeficjenta','originalna resitev');
hold off


%Najdemo najbolj?e prilagajo?i graf za mno?ico to?k (B1_x,B1_y)
B1=fit(B1_x',B1_y','linearinterp'); %polinom
h1=coeffvalues(B1); %koeficjenti polinoma

%Nari?emo graf ter ga shranimo za (B1_x,B1_y)
fig1b=figure;
plot(B1, '-r',B1_x,B1_y,'ro');
hold on
plot([0],f*prva_resitev,'gx')
title('Spremembe prvega koeficjenta omejitvenega vektorja');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,B1(0)+1,texlabel(B1)) % ena?ba funkcije koeficjenti so h1
hold off

%Najdemo najbolj?e prilagajo?i graf za mno?ico to?k (B2_x,B2_y)
B2=fit(B2_x',B2_y','linearinterp'); %polinom
h2=coeffvalues(B2); %koeficjenti polinoma

%Nari?emo graf ter ga shranimo za (B2_x,B2_y)
fig2b=figure;
plot(B2, '-r',B2_x,B2_y,'ro');
hold on
plot([0],f*prva_resitev,'gx')
title('Spremembe drugega koeficjenta omejitvenega vektorja');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,B1(0)+1,texlabel(B2)) % ena?ba funkcije koeficjenti so h2
hold off

%Najdemo najbolj?e prilagajo?i graf za mno?ico to?k (B3_x,B3_y)
B3=fit(B3_x',B3_y','linearinterp'); %polinom
h3=coeffvalues(B3); %koeficjenti polinoma

%Nari?emo graf ter ga shranimo za (B3_x,B3_y)
fig3b=figure;
plot(B3, '-r',B3_x,B3_y,'ro');
hold on
plot([0],f*prva_resitev,'gx')
title('Spremembe tretjega koeficjenta omejitvenega vektorja');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,B3(0)+1,texlabel(B3)) % ena?ba funkcije koeficjenti so h3
hold off

%Najdemo najbolj?e prilagajo?i graf za mno?ico to?k (B4_x,B4_y)
B4=fit(B4_x',B4_y','linearinterp'); %polinom
h4=coeffvalues(B4); %koeficjenti polinoma

%Nari?emo graf ter ga shranimo za (B4_x,B4_y)
fig4b=figure;
plot(B4, '-r',B4_x,B4_y,'ro');
hold on
plot([0],f*prva_resitev,'gx')
title('Spremembe cetrtega koeficjenta omejitvenega vektorja');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,B4(0)+1,texlabel(B4)) % ena?ba funkcije koeficjenti so h4
hold off
end
