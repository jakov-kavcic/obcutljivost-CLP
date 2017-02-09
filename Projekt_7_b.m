% V tem delu bomo definirali osnovni problem, ki bo velikosti 4x4. Vektor x
% bo imel stiri spremenljivke. Matrika A bo velikosti 4x4. Vektor b bo imel
% 4 omejitve. Funkcija f pa bo vsebovala ?tiri koeficjente.

set(0,'DefaultFigureVisible','off'); % Da se ne ska?ejo grafi ceu ?as

A=[1,-2,3,4;
    2,-3,4,5;
    1,-3,5,7;
    2,-4,6,8];
f=[6,12,3,6];
b=[10,10,10,10];
intcon=[1,2,3,4];
options = optimoptions('intlinprog','TolFun',1e-6,'Display', 'off' );

prva_resitev=intlinprog(f,intcon,A,b,[],[],[1,1,1,1],[inf,inf,inf,inf],options);

% spreminjamo vrednosti omejitev
for i = 1:4 
    j=1;
    o=b(i);
    for n = 1:30 %naredimo 30 iteracij poskusa
        db=-8+18*rand(); % random spremenljivka z intervala (-8,10)
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
b=figure;
plot(B1_x,B1_y,'c*',B2_x,B2_y,'k*',B3_x,B3_y,'g*',B4_x,B4_y,'b*',[0],f*prva_resitev,'ro');
title('spremembe b-ja');
xlabel('sprememba b');
ylabel('optimalna vrednost');
legend('sprememba prvega koeficjenta','sprememba drugega koeficjenta','sprememba tretjega koeficjenta','sprememba cetrtega koeficjenta','originalna resitev');
print(b,'spremembe_b','-dpng');
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
print(fig1b,'spremembe_b1','-dpng');
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
print(fig2b,'spremembe_b2','-dpng');
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
print(fig3b,'spremembe_b3','-dpng');
hold off

%Najdemo najbolj?e prilagajo?i graf za mno?ico to?k (B4_x,B4_y)
B4=fit(B4_x',B4_y','linearinterp'); %polinom
h4=coeffvalues(B4); %koeficjenti polinoma

%Nari?emo graf ter ga shranimo za (F4_x,F4_y)
fig4b=figure;
plot(B4, '-r',B4_x,B4_y,'ro');
hold on
plot([0],f*prva_resitev,'gx')
title('Spremembe cetrtega koeficjenta omejitvenega vektorja');
xlabel('sprememba koeficjenta');
ylabel('optimalna vrednost');
text(0,B4(0)+1,texlabel(B4)) % ena?ba funkcije koeficjenti so h4
print(fig4b,'spremembe_b4','-dpng');
hold off
