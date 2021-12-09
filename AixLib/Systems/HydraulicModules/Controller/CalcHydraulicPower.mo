within AixLib.Systems.HydraulicModules.Controller;
model CalcHydraulicPower

  parameter Real rho = 1000 "Density of Medium";
  parameter Real cp = 4180 "Heat Capacity of Medium";
public
  BaseClasses.HydraulicBus  hydraulicBus
    annotation (Placement(transformation(extent={{-124,-24},{-76,24}}),
        iconTransformation(extent={{-124,-24},{-76,24}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-20,22},{0,42}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  Modelica.Blocks.Math.Gain gain(k=Density)
    annotation (Placement(transformation(extent={{-56,-10},{-38,8}})));
  Modelica.Blocks.Math.Gain gain1(k=HeatCapacity)
    annotation (Placement(transformation(extent={{-22,-10},{-4,8}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
equation
  connect(add.u2, hydraulicBus.TFwrdInMea) annotation (Line(points={{-22,26},{-99.88,
          26},{-99.88,0.12}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u1, hydraulicBus.TRtrnOutMea) annotation (Line(points={{-22,38},{-100,
          38},{-100,0.12},{-99.88,0.12}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(product1.u1, add.y) annotation (Line(points={{56,6},{12,6},{12,32},{1,
          32}},   color={0,0,127}));
  connect(gain.u, hydraulicBus.VFlowInMea) annotation (Line(points={{-57.8,-1},{
          -64.9,-1},{-64.9,0.12},{-99.88,0.12}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(gain.y, gain1.u)
    annotation (Line(points={{-37.1,-1},{-23.8,-1}}, color={0,0,127}));
  connect(gain1.y, product1.u2) annotation (Line(points={{-3.1,-1},{8,-1},{8,-6},
          {56,-6}},     color={0,0,127}));
  connect(product1.y, Q_flow)
    annotation (Line(points={{79,0},{108,0}}, color={0,0,127}));
  connect(Q_flow, Q_flow)
    annotation (Line(points={{108,0},{108,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{-100,100},{-36,-2},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,20},{98,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}), Diagram(coordinateSystem(preserveAspectRatio=
           false)),
    Documentation(revisions="<html><ul>
  <li>December 9, 2021, by Phillip Stoffel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
Calculates the power auf hydraulic modules and returns the power as real 
</p>
<p>

</p>
</html>"));
end CalcHydraulicPower;
