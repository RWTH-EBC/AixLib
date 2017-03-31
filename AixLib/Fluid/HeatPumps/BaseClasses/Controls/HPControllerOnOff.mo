within AixLib.Fluid.HeatPumps.BaseClasses.Controls;
model HPControllerOnOff
  "Simple on/off controller for heat pump model"
  extends HPControllerBaseClass;

  Modelica.Blocks.Sources.BooleanConstant on_off
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Sources.BooleanConstant mode
    annotation (Placement(transformation(extent={{-12,-50},{8,-30}})));
  Modelica.Blocks.Sources.Constant N(k=0)
    annotation (Placement(transformation(extent={{-12,30},{8,50}})));
equation


  connect(N.y, heatPumpControlBus.N) annotation (Line(points={{9,40},{40,40},{40,
          -0.095},{99.09,-0.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(on_off.y, heatPumpControlBus.input_on) annotation (Line(points={{9,0},
          {99.09,0},{99.09,-0.095}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(mode.y, heatPumpControlBus.input_mode) annotation (Line(points={{9,-40},
          {40,-40},{40,0},{99.09,0},{99.09,-0.095}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
end HPControllerOnOff;
