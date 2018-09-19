function Y = transformer_admittance(S,eps,Uh,Ul)
%transformer_admittance Calculates the admittance matrix of a transformer

y=(100*S)/(eps*Uh*Uh);
a=Ul/Uh;
Y=[y/(a*conj(a)) -y/conj(a);-y/a y];

end

