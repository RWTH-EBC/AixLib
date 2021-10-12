within AixLib.Systems.HydraulicModules.Controller;
model CalcHydraulicPower
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in hydraulic circuits";
  parameter Real Density = 1000 "Density of Medium";
  parameter Real HeatCapacity = 4180 "Heat Capacity of Medium";
public
  BaseClasses.HydraulicBus  hydraulicBus
    annotation (Placement(transformation(extent={{-124,-26},{-76,22}}),
        iconTransformation(extent={{-124,-24},{-76,24}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-20,22},{0,42}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{22,-6},{42,14}})));
  Modelica.Blocks.Math.Gain gain(k=Density)
    annotation (Placement(transformation(extent={{-56,-10},{-38,8}})));
  Modelica.Blocks.Math.Gain gain1(k=HeatCapacity)
    annotation (Placement(transformation(extent={{-22,-10},{-4,8}})));
  Modelica.Blocks.Interfaces.RealOutput Qflow "Connector of Real output signal"
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));
equation
  connect(add.u2, hydraulicBus.TFwrdInMea) annotation (Line(points={{-22,26},{-99.88,
          26},{-99.88,-1.88}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u1, hydraulicBus.TRtrnOutMea) annotation (Line(points={{-22,38},{-100,
          38},{-100,-1.88},{-99.88,-1.88}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(product1.u1, add.y) annotation (Line(points={{20,10},{12,10},{12,32},{
          1,32}}, color={0,0,127}));
  connect(gain.u, hydraulicBus.VFlowInMea) annotation (Line(points={{-57.8,-1},{
          -64.9,-1},{-64.9,-1.88},{-99.88,-1.88}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(gain.y, gain1.u)
    annotation (Line(points={{-37.1,-1},{-23.8,-1}}, color={0,0,127}));
  connect(gain1.y, product1.u2) annotation (Line(points={{-3.1,-1},{8.45,-1},{8.45,
          -2},{20,-2}}, color={0,0,127}));
  connect(product1.y, Qflow)
    annotation (Line(points={{43,4},{102,4},{102,0}}, color={0,0,127}));
  connect(Qflow, Qflow)
    annotation (Line(points={{102,0},{102,0}}, color={0,0,127}));
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
           false)));
end CalcHydraulicPower;
