within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses;
model TwoStar_RadEx "Adaptor for approximative longwave radiation exchange"
  import BaseLib;

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm annotation (
      Placement(transformation(extent={{-102,-10},{-82,10}}, rotation=0)));
  AixLib.Utilities.Interfaces.Star Star annotation (Placement(transformation(
          extent={{81,-10},{101,10}}, rotation=0)));

  parameter Modelica.SIunits.Area A=12 "Area of radiation exchange";
  parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity";

equation
  Therm.Q_flow + Star.Q_flow = 0;
//  Therm.Q_flow =A*(
//    (Therm.T/100)*(Therm.T/100)*(Therm.T/100)*(Therm.T/100) -(Star.T/100)*(Star.T/100)*(Star.T/100)*(Star.T/100));

  Therm.Q_flow =Modelica.Constants.sigma*eps*A*(
    (Therm.T)*(Therm.T)*(Therm.T)*(Therm.T) -(Star.T)*(Star.T)*(Star.T)*(Star.T));
  annotation (
    Diagram(graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={135,150,177},
          fillPattern=FillPattern.Solid), Text(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={135,150,177},
          fillPattern=FillPattern.Solid,
          textString=
               "2*")}),
    Icon(graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={135,150,177},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-82,82},{78,-78}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={135,150,177},
          fillPattern=FillPattern.Solid,
          textString=
               "2*"),
        Text(
          extent={{-58,92},{52,64}},
          lineColor={0,0,0},
          textString=
               "Modified")}),
    Documentation(revisions="<html>
<p><ul>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>
", info=
    "<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Adaptor for approximative longwave radiation exchange</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>"));
end TwoStar_RadEx;
