within AixLib.DataBase.HeatPump.Functions.DefrostCorrection;
function WetterAfjei1996
  "Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996"
  extends AixLib.DataBase.HeatPump.Functions.DefrostCorrection.PartialBaseFct(
      T_eva);

parameter Real A=0.03;
parameter Real B=-0.004;
parameter Real C=0.1534;
parameter Real D=0.8869;
parameter Real E=26.06;
protected
Real factor;
Real linear_term;
Real gauss_curve;
algorithm
linear_term:=A + B*T_eva;
gauss_curve:=C*Modelica.Math.exp(-(T_eva - D)*(T_eva - D)/E);
if linear_term>0 then
  factor:=linear_term + gauss_curve;
else
  factor:=gauss_curve;
end if;
f_CoPicing:=1-factor;
  annotation (Documentation(info="<html><p>
  Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996.
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>December 10, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
</ul>
</html>"));
end WetterAfjei1996;
