within AixLib.Fluid.HeatPumps.BaseClasses.Functions;
package DefrostCorrection
   extends Modelica.Icons.Package;

  partial function baseFct
    "Base class for correction model, icing and defrosting of evaporator"
    extends Modelica.Icons.Function;
    input Real T_eva;
    output Real f_CoPicing;
    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base funtion used in HeatPump model. Input is the evaporator inlet temperature, output is a CoP-correction factor f_cop_icing.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
    revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>"));
  end baseFct;

  function noModel "No model"
    extends
      AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.baseFct(
        T_eva);

  algorithm
  f_CoPicing:=1;

    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
No correction factor for icing/defrosting: f_cop_icing=1.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
    revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>"));
  end noModel;

  function WetterAfjei1996
    "Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996"
    extends
      AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.baseFct(
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
    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
    revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>"));
  end WetterAfjei1996;
end DefrostCorrection;
