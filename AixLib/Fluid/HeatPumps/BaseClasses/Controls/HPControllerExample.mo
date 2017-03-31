within AixLib.Fluid.HeatPumps.BaseClasses.Controls;
model HPControllerExample "Example controller for heat pump model"
  extends HPControllerBaseClass;
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=1000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant N(k=0)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.BooleanConstant mode
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
equation
  connect(N.y, heatPumpControlBus.N) annotation (Line(points={{11,50},{40,50},{
          40,-0.095},{99.09,-0.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(booleanPulse.y, heatPumpControlBus.input_on) annotation (Line(points=
          {{11,0},{99.09,0},{99.09,-0.095}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(mode.y, heatPumpControlBus.input_mode) annotation (Line(points={{11,
          -50},{40,-50},{40,-0.095},{99.09,-0.095}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
end HPControllerExample;
