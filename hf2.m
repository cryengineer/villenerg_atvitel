BL=0.3;
Cb=[-3.2 18];
Cj=[+3.2 18];
Bb=[-4.2 22];
Bj=[+4.2 22];
Ab=[-3.1 26];
Aj=[+3.1 26];
P=[0 31.3];
%vezetok atlagos magassaga
h_avga=Ab(2)-2*BL*Ab(2)/3;
h_avgb=Bb(2)-2*BL*Bb(2)/3;
h_avgc=Cb(2)-2*BL*Cb(2)/3;
h_avgp=P(2)-2*BL*P(2)/3;
%korrigalt y koordinata
Cb=[-3.2 h_avgc];
Cj=[+3.2 h_avgc];
Bb=[-4.2 h_avgb];
Bj=[+4.2 h_avgb];
Ab=[-3.1 h_avga];
Aj=[+3.1 h_avga];
P=[0 h_avgp];
%vezetok sugara
r_a=sqrt(250/pi);
r_b=sqrt(250/pi);
r_c=sqrt(250/pi);
r_p=sqrt((95+55)/pi);
%fazisvezetok egyenerteku sugara
r_eqa=sqrt((Aj(1)-Ab(1))*r_a/1000);
r_eqb=sqrt((Bj(1)-Bb(1))*r_b/1000);
r_eqc=sqrt((Cj(1)-Cb(1))*r_c/1000);
r_eqp=r_p/1000;

%tavolsagok
d_eqab=d_eq(Aj,Ab,Bj,Bb);
d_eqac=d_eq(Aj,Ab,Cj,Cb);
d_eqbc=d_eq(Cj,Cb,Bj,Bb);
d_eqap=d_eq(Aj,Ab,P,P);
d_eqbp=d_eq(Bj,Bb,P,P);
d_eqcp=d_eq(Cj,Cb,P,P);

D_eq=[0 d_eqab d_eqac d_eqap;d_eqab 0 d_eqbc d_eqbp;d_eqac d_eqbc 0 d_eqcp;d_eqap d_eqbp d_eqcp 0];

%tukorvezetok
Cbi=[-3.2 -h_avgc];
Cji=[+3.2 -h_avgc];
Bbi=[-4.2 -h_avgb];
Bji=[+4.2 -h_avgb];
Abi=[-3.1 -h_avga];
Aji=[+3.1 -h_avga];
Pi=[0 -h_avgp];

%tovabbi tavolsagok
d_eqaai=d_eq(Aj,Ab,Aji,Abi);
d_eqabi=d_eq(Aj,Ab,Bji,Bbi);
d_eqaci=d_eq(Aj,Ab,Cji,Cbi);
d_eqapi=d_eq(Aj,Ab,Pi,Pi);

d_eqbai=d_eq(Bj,Bb,Aji,Abi);
d_eqbbi=d_eq(Bj,Bb,Bji,Bbi);
d_eqbci=d_eq(Bj,Bb,Cji,Cbi);
d_eqbpi=d_eq(Bj,Bb,Pi,Pi);

d_eqcai=d_eq(Cj,Cb,Aji,Abi);
d_eqcbi=d_eq(Cj,Cb,Bji,Bbi);
d_eqcci=d_eq(Cj,Cb,Cji,Cbi);
d_eqcpi=d_eq(Cj,Cb,Pi,Pi);

d_eqpai=d_eq(P,P,Aji,Abi);
d_eqpbi=d_eq(P,P,Bji,Bbi);
d_eqpci=d_eq(P,P,Cji,Cbi);
d_eqppi=d_eq(P,P,Pi,Pi);

%Kapacitas
Pc=log([d_eqaai/r_eqa d_eqabi/d_eqab d_eqaci/d_eqac d_eqapi/d_eqap;...
    d_eqbai/d_eqab d_eqbbi/r_eqb d_eqbci/d_eqbc d_eqbpi/d_eqbp;...
    d_eqcai/d_eqac d_eqcbi/d_eqbc d_eqcci/r_eqc d_eqcpi/d_eqcp;...
    d_eqpai/d_eqap d_eqpbi/d_eqbp d_eqpci/d_eqcp d_eqppi/r_eqp]);

Cabcp=2*pi*8.85e-12*inv(Pc)*1000;

%Induktivitas
r_effa=exp(-1/4)*r_eqa;
r_effb=exp(-1/4)*r_eqb;
r_effc=exp(-1/4)*r_eqc;
r_effp=exp(-1/4)*r_eqp;
De=931;

Pl=log(De*[1/r_effa 1/d_eqab 1/d_eqac 1/d_eqap;...
    1/d_eqab 1/r_effb 1/d_eqbc 1/d_eqbp;...
    1/d_eqac 1/d_eqbc 1/r_effc 1/d_eqcp;...
    1/d_eqap 1/d_eqbp 1/d_eqcp 1/r_effp]);

Xl=4*pi*50e-7*Pl*1000;
Xl=node_reduction(Xl,4,4);




