%T1
Uh_T1=400000;
Ul_T1=132000;
eps_T1=11;
S_T1=320000000;
Y_T1=transformer_admittance(S_T1,eps_T1,Uh_T1,Ul_T1);
%T2
Uh_T2=400000;
Ul_T2=132000;
eps_T2=10;
S_T2=250000000;
Y_T2=transformer_admittance(S_T2,eps_T2,Uh_T2,Ul_T2);
%T3
Uh_T3=400000;
Ul_T3=15750;
eps_T3=12.5;
S_T3=260000000;
Y_T3=transformer_admittance(S_T3,eps_T3,Uh_T3,Ul_T3);
%L12
r_L12=0.01;
x_L12=0.15;
c_L12=25*10^(-9);
l_L12=90;
Y_L12=transmission_line_admittance(r_L12,x_L12,c_L12,l_L12);
%L23
r_L23=0.02;
x_L23=0.30;
c_L23=12*10^(-9);
l_L23=120;
Y_L23=transmission_line_admittance(r_L23,x_L23,c_L23,l_L23);
%L13
r_L13=0.03;
x_L13=0.33;
c_L13=10*10^(-9);
l_L13=50;
Y_L13=transmission_line_admittance(r_L13,x_L13,c_L13,l_L13);
%L57
r_L57=0.12;
x_L57=0.4;
c_L57=0;
l_L57=40;
Y_L57=transmission_line_admittance(r_L57,x_L57,c_L57,l_L57);
%L58
r_L58=0.08;
x_L58=0.25;
c_L58=0;
l_L58=30;
Y_L58=transmission_line_admittance(r_L58,x_L58,c_L58,l_L58);

%------------------------------------------------------------- Y

y11=Y_T1(2,2)+Y_L13(1,1)+Y_L12(1,1);
y22=Y_L12(2,2)+Y_T3(2,2)+Y_L23(2,2);
y33=Y_L13(2,2)+Y_T2(2,2)+Y_L23(1,1);
y44=Y_T1(1,1);
y55=Y_T2(1,1)+Y_L57(2,2)+Y_L58(2,2);
y66=Y_T3(1,1);
y77=Y_L57(1,1);
y88=Y_L58(1,1);
y12=Y_L12(1,2);
y21=Y_L12(2,1);
y13=Y_L13(1,2);
y31=Y_L13(2,1);
y14=Y_T1(2,1);
y41=Y_T1(1,2);
y15=0;
y16=0;
y17=0;
y18=0;
y23=Y_L23(2,1);
y32=Y_L23(1,2);
y24=0;
y25=0;
y27=0;
y28=0;
y26=Y_T3(2,1);
y62=Y_T3(1,2);
y35=Y_T2(2,1);
y53=Y_T2(1,2);
y34=0;
y36=0;
y37=0;
y38=0;
y42=0;
y43=0;
y45=0;
y46=0;
y47=0;
y48=0;
y51=0;
y52=0;
y54=0;
y56=0;
y57=Y_L57(2,1);
y75=Y_L57(1,2);
y58=Y_L58(2,1);
y85=Y_L58(1,2);
y61=0;
y63=0;
y64=0;
y65=0;
y67=0;
y68=0;
y71=0;
y72=0;
y73=0;
y74=0;
y76=0;
y78=0;
y81=0;
y82=0;
y83=0;
y84=0;
y86=0;
y87=0;

Y=[y11 y12 y13 y14 y15 y16 y17 y18;
    y21 y22 y23 y24 y25 y26 y27 y28;
    y31 y32 y33 y34 y35 y36 y37 y38;
    y41 y42 y43 y44 y45 y46 y47 y48;
    y51 y52 y53 y54 y55 y56 y57 y58;
    y61 y62 y63 y64 y65 y66 y67 y68;
    y71 y72 y73 y74 y75 y76 y77 y78;
    y81 y82 y83 y84 y85 y86 y87 y88];
Z=inv(Y);

%--------------2.1.3.

Un_G=15750;
P_G=150000000;
Q_G=80000000;
phi_G=atan(Q_G/P_G);
S_G=sqrt(P_G^2+Q_G^2);
Z_G=Un_G^2/S_G*(cos(phi_G)+1i*sin(phi_G));
Y_G=1/Z_G;
I_G=Un_G*Y_G;

%--------------2.2.4.

Un_N=400000;
S_N=6000000000;
X_N=Un_N^2/S_N;
Y_prime=Y;
Y_prime(1,1)=Y_prime(1,1)+1i/X_N;
Z_prime=inv(Y_prime);
I_N=Un_N/(sqrt(3)*(1i*X_N));
U_noload=Z_prime*[I_N;0;0;0;0;0;0;0]*sqrt(3);
U_noload=U_noload*exp(-1i*angle(U_noload(1))) %forgatunk, hogy U1 szoge 0 legyen

%--------------2.2.5a.

U_LOAD8=132000;
P_LOAD8=70000000;
cosphi_LOAD8=0.92;

% Impedanciatarto modell
R_LOAD8=U_LOAD8^2/P_LOAD8;
X_LOAD8=R_LOAD8*tan(acos(cosphi_LOAD8));
Z_LOAD8=R_LOAD8+1i*X_LOAD8;

Y_2prime=Y_prime;
Y_2prime(8,8)=Y_2prime(8,8)+1/Z_LOAD8;
Z_2prime=inv(Y_2prime);
U_L8constZ=Z_2prime*[I_N;0;0;0;0;0;0;0]*sqrt(3)*(-1);
U_L8constZ=U_L8constZ*exp(-1i*angle(U_L8constZ(1))); %forgatunk, hogy U1 szoge 0 legyen
S_L8constZ=3*conj(U_L8constZ(8)/(sqrt(3)*Z_LOAD8))*U_L8constZ(8);
P_L8constZ=real(S_L8constZ);
Q_L8constZ=imag(S_L8constZ);

% Aramtarto modell
S_LOAD8=sqrt(P_LOAD8^2+(P_LOAD8*tan(acos(cosphi_LOAD8)))^2);
I_LOAD8=S_LOAD8/(sqrt(3)*U_LOAD8)*(cosphi_LOAD8-1i*sin(acos(cosphi_LOAD8)));
U_L8constI=Z_prime*[I_N;0;0;0;0;0;0;-I_LOAD8]*sqrt(3);
U_L8constI=U_L8constI*exp(-1i*angle(U_L8constI(1))); %forgatunk, hogy U1 szoge 0 legyen
S_L8constI=sqrt(3)*conj(I_LOAD8)*U_L8constI(8);
P_L8constI=real(S_L8constI);
Q_L8constI=imag(S_L8constI);





