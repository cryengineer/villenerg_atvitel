%--------------2.3.6. LOAD-FLOW Gauss-Seidel algoritmussal

%redukalnunk kell a 2,3,5 node-okat, mert azokra nincs szukseg a gauss-hoz
Y_red=node_reduction(Y,8,2); %2-es node
Y_red=node_reduction(Y_red,7,2); %3-as node, de Y_red-ben ez a 2-es
Y_red=node_reduction(Y_red,6,3); %5-os node, de az uj Y_red-ben ez a 3-as

% inicializalas
S_init_6=150+1i*80;
S_init_4=-100-1i*100*tan(acos(0.9));
S_init_7=-50-1i*50*tan(acos(0.96));
S_init_8=-70-1i*70*tan(acos(0.92));
S_init=[NaN;S_init_4;S_init_6;S_init_7;S_init_8]*1000000/3; %fazis ertekekkel kell szamolni, osztunk 3-mal

V=zeros(5,1);
V(1) = 400000/sqrt(3);
V(2:5)=V(1);

err = inf; %error

% iteration counter
j=1;
while nanmax(abs(err))>1e-5
j=j+1;
%calculate required current, if voltages and powers are given
I = conj(S_init)./conj(V);
%the new voltage vector
Vnew = V;
for i=2:numel(V)
%gauss iteration
Vnew(i) = 1/Y_red(i,i)*(I(i)-Y_red(i,:)*V+Y_red(i,i)*V(i));
end
%powers from new voltages and current
S = Vnew.*conj(I);
%difference criteria
err = abs(S)-abs(S_init);
%voltage for the next iteration
V = Vnew;
end
%current and power of slack bus
I(1)=Y_red(1,:)*V;
S=V.*conj(I);

%a teljes halozat feszultseg profilja
I_full=[I(1);0;0;I(2);0;I(3);I(4);I(5)];
U=Z*I_full*sqrt(3);
abs(U);
radtodeg(angle(U));
sqrt(3)*U(8)*conj(I_full(8))
