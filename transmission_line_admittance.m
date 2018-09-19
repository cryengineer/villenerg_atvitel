function Y = transmission_line_admittance(r,x,c,l)
%transmission_line_admittance Calculates the admittance matrix of a
%transmission line

y12=1/(l*(r+1i*x));
y0=1i*100*pi*c*l*0.5;

Y=[y12+y0 -y12;-y12 y12+y0];
end

