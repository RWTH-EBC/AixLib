within AixLib.Fluid.BoilerCHP.BaseClasses;
function Psat "Saturation pressure depending on temperature"
  input Real T "Air temperature [K]";
  output Real Psat "Vapour saturation pressure [Pa]";
protected
  parameter Real T_min=273.16;
  parameter Real T_max=647.3;
  parameter Real T_ref = 273.15 "Absolute temperature of reference at 0°C [K]";
  parameter Real tk=min(T_max, max(T_min, T));
  Real a;
  Real b;
  Real c;
  Real d;

algorithm
  if tk <= T_ref then
    a := -6086.67457;
    b := 0.258146988;
    c := 0;
    d := 27.2497986;
  elseif (tk <= 333.15) then
    a := -6722.94637;
    b := -4.77551358;
    c := 0;
    d := 57.8181266;
  else
    a := -7797.09834;
    b := -11.2831932;
    c := 0.00993664096;
    d := 95.5324251;
  end if;
  Psat := exp(a/tk + b*log(tk) + c*tk + d);

  annotation (Documentation(info="<html>
<p>This function calculates Saturation pressure depending upon the temperature.</p>
</html>"));
end Psat;
