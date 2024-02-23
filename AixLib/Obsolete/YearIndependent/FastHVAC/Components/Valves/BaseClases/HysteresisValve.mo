within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Valves.BaseClases;
model HysteresisValve
  parameter Boolean filteredOpening
    "= true, if opening is filtered with a 2nd order CriticalDamping filter";
    parameter Real leakageOpening
    "The opening signal is limited by leakageOpening (to improve the numerics)";

  parameter Modelica.Units.SI.Time riseTime;

 Modelica.Blocks.Continuous.Filter filter(order=2, f_cut=5/(2*Modelica.Constants.pi
       *riseTime)) if filteredOpening
   annotation (Placement(transformation(extent={{2,-20},{16,-6}})));
public
 Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=leakageOpening)
   annotation (Placement(transformation(extent={{-22,-20},{-8,-6}})));
  Modelica.Blocks.Interfaces.RealInput opening "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput opening_actual
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{80,-18},{116,18}})));
equation
  if filteredOpening then
     connect(filter.y, opening_actual);
  else
     connect(opening, opening_actual);
  end if;
 connect(limiter1.y,filter. u) annotation (Line(
     points={{-7.3,-13},{0.6,-13}},
     color={0,0,127},
     smooth=Smooth.None));
  connect(limiter1.u, opening) annotation (Line(
      points={{-23.4,-13},{-40,-13},{-40,0},{-100,0}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,
              0}), Text(
          extent={{-72,44},{70,-42}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="hysteresisValve")}),
    Documentation(revisions="<html><ul>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end HysteresisValve;
