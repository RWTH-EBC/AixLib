within AixLib.Electrical.PVSystem.BaseClasses;
function W "Lambert W function using series expansion,x>0, error < 0.1 % (Batzelis, 2014)"
  input Real x(min=0.000000000001);
  output Real LW;

protected
  Real u;
  Real p;
  Real L_1;
  Real L_2;
  constant Real e=Modelica.Math.exp(1.0);

algorithm
  u :=x/e;
  p :=1 - x/e;
  L_1 :=log(x);
  L_2 :=log(log(x));


LW := if x <= 9 then
 u+p*u/(1+u)+1/2*p^2*u/(1+u)^3-1/6*p^3*u*(2*u-1)/(1+u)^5+1/24*p^4*u*(6*u^2-8*u+1)/(1+u)^7-1/120*p^5*u*(24*u^3-58*u^2+22*u-1)/(1+u)^9
 else
   L_1-L_2+L_2/L_1+L_2*(-2+L_2)/(2*L_1^2)+L_2*(6-9*L_2+2*L_2^2)/(6*L_1^3)+L_2*(-12+36*L_2-22*L_2^2+3*L_2^3)/(12*L_1^4)+L_2*(60-300*L_2+350*L_2^2-125*L_2^3+12*L_2^4)/(60*L_1^5);
end W;
