function [d] = d_eq(Aj,Ab,Bj,Bb)

d=(sqrt((Aj(1)-Bj(1))^2+(Aj(2)-Bj(2))^2)*sqrt((Aj(1)-Bb(1))^2+(Aj(2)-Bb(2))^2) ...
    *sqrt((Ab(1)-Bj(1))^2+(Ab(2)-Bj(2))^2)*sqrt((Ab(1)-Bb(1))^2+(Ab(2)-Bb(2))^2))^0.25;
end

