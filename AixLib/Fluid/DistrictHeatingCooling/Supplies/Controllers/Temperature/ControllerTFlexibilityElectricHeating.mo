within AixLib.Fluid.DistrictHeatingCooling.Supplies.Controllers.Temperature;
model ControllerTFlexibilityElectricHeating
  "This is a model for controlling the flow temperature taking into account the renewable electricity supply. If there is a surplus of renewable electricity, this is used to increase the flow temperatures. Otherwise, the flow temperature is set according to the heating curve."
  extends PartialControllerT;

  parameter Modelica.SIunits.Temperature T_maxNetwork
  "Parameters for defining the maximum supply temperature";

  Modelica.Blocks.Interfaces.RealInput T_setNormalOperation(unit="K")
    "Supply temperature input for normal network operation, could be a constant value or a heating curve based on the outdoor air temperature."
    annotation (Placement(transformation(extent={{-138,-80},{-98,-40}})));
  Modelica.Blocks.Interfaces.BooleanInput electricitySignal
    "Input indicating whether there is a surplus of renewable electricity Electricity (true: renewable energy available)"
    annotation (Placement(transformation(extent={{-138,-10},{-98,30}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-44,0},{-24,20}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-88,-20},{-68,0}})));
  Modelica.Blocks.Sources.Constant const1(k=T_maxNetwork)
    annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
  Modelica.Blocks.Interfaces.RealOutput T_setElectricHeater
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
equation
  connect(electricitySignal, switch1.u2)
    annotation (Line(points={{-118,10},{-46,10}},   color={255,0,255}));
  connect(const1.y, switch1.u1) annotation (Line(points={{-67,30},{-58,30},{-58,
          18},{-46,18}},   color={0,0,127}));
  connect(const.y, switch1.u3) annotation (Line(points={{-67,-10},{-54,-10},{
          -54,2},{-46,2}},     color={0,0,127}));
  connect(T_setElectricHeater, T_setElectricHeater)
    annotation (Line(points={{110,30},{110,30}}, color={0,0,127}));
  connect(switch1.y, T_setElectricHeater) annotation (Line(points={{-23,10},{52,
          10},{52,30},{110,30}}, color={0,0,127}));
  connect(T_setNormalOperation, y) annotation (Line(points={{-118,-60},{66,-60},
          {66,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -80},{100,40}})),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,40}})),
    Documentation(revisions="<html><ul>
  <li>October 23, 2018, by Tobias Blacha:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end ControllerTFlexibilityElectricHeating;
