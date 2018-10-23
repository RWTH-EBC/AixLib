within AixLib.Fluid.DistrictHeatingCooling.Supplies.Controllers.Temperature;
model ControllerTFlexibilityElectricHeating
  "This is a model for controlling the flow temperature taking into account the renewable electricity supply. If there is a surplus of renewable electricity, this is used to increase the flow temperatures. Otherwise, the flow temperature is set according to the heating curve."
  extends PartialControllerT;

  parameter Modelica.SIunits.Temperature T_maxNetwork
  "Parameters for defining the maximum supply temperature";

  Modelica.Blocks.Interfaces.RealInput T_setNormalOperation(unit="K")
    "Supply temperature input for normal network operation, could be a constant value or a heating curve based on the outdoor air temperature."
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.BooleanInput electricitySignal
    "Input indicating whether there is a surplus of renewable electricity Electricity (true: renewable energy available)"
    annotation (Placement(transformation(extent={{-140,-48},{-100,-8}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-46,-38},{-26,-18}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-92,-70},{-72,-50}})));
  Modelica.Blocks.Sources.Constant const1(k=T_maxNetwork)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(electricitySignal, switch1.u2)
    annotation (Line(points={{-120,-28},{-48,-28}}, color={255,0,255}));
  connect(T_setNormalOperation, max.u1)
    annotation (Line(points={{-120,30},{6,30},{6,6},{18,6}}, color={0,0,127}));
  connect(max.y, y) annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  connect(const1.y, switch1.u1) annotation (Line(points={{-69,0},{-60,0},{-60,
          -20},{-48,-20}}, color={0,0,127}));
  connect(const.y, switch1.u3) annotation (Line(points={{-71,-60},{-56,-60},{
          -56,-36},{-48,-36}}, color={0,0,127}));
  connect(switch1.y, max.u2) annotation (Line(points={{-25,-28},{6,-28},{6,-6},
          {18,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -80},{100,40}})),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,40}})),
    Documentation(revisions="<html>
<ul>
<li>
October 23, 2018, by Tobias Blacha:<br/>
First implementation for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
</li>
</ul>
</html>"));
end ControllerTFlexibilityElectricHeating;
