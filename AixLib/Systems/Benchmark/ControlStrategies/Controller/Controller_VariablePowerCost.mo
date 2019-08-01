within AixLib.Systems.Benchmark.ControlStrategies.Controller;
model Controller_VariablePowerCost
  import AixLib;
  AixLib.Systems.Benchmark.Model.BusSystems.Bus_Control controlBus
    annotation (Placement(transformation(extent={{80,-40},{120,0}})));
  AixLib.Systems.Benchmark.Model.BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{80,0},{120,40}})));
  Modelica.Blocks.Math.Gain gain(k=1)
    annotation (Placement(transformation(extent={{82,20},{74,28}})));
  AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp.PI_Regler_TBA_v2
    TBA_Temp annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,0})));
  AixLib.Systems.Benchmark.ControlStrategies.Controller_Temp.PI_Regler_RLT
    RLT_Temp annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,0})));
  ControlStrategies.Controller_Generation.Valve_Basis valve_Basis
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  AixLib.Systems.Benchmark.ControlStrategies.Controller_Generation.Generation_VariablePowerCost
    generation_VariablePowerCost
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans.Fan_VariablePowerCost
    fan_VariablePowerCost
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  AixLib.Systems.Benchmark.ControlStrategies.Controller_PumpsAndFans.Pump_VariablePowerCost
    pump_VariablePowerCost
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(gain.u, measureBus.WaterInAir) annotation (Line(points={{82.8,24},{86,
          24},{86,20},{92,20},{92,20.1},{100.1,20.1}},
                                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(gain.y, controlBus.X_Central) annotation (Line(points={{73.6,24},{72,
          24},{72,-20},{86,-20},{86,-19.9},{100.1,-19.9}}, color={0,0,127}));
  connect(TBA_Temp.measureBus, measureBus) annotation (Line(
      points={{-90,10},{-90,40},{100,40},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(RLT_Temp.measureBus, measureBus) annotation (Line(
      points={{-60,10},{-60,40},{100,40},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(RLT_Temp.controlBus, controlBus) annotation (Line(
      points={{-60,-10},{-60,-40},{100,-40},{100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(TBA_Temp.controlBus, controlBus) annotation (Line(
      points={{-90,-10},{-90,-40},{100,-40},{100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(valve_Basis.measureBus, measureBus) annotation (Line(
      points={{30,10},{30,40},{100,40},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(valve_Basis.controlBus, controlBus) annotation (Line(
      points={{30,-10},{30,-40},{100,-40},{100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_VariablePowerCost.measureBus, measureBus) annotation (Line(
      points={{58,10},{58,40},{100,40},{100,20},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(generation_VariablePowerCost.controlBus, controlBus) annotation (Line(
      points={{58,-10},{58,-40},{100,-40},{100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(fan_VariablePowerCost.measureBus, measureBus) annotation (Line(
      points={{0,10},{0,40},{100,40},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(fan_VariablePowerCost.controlBus, controlBus) annotation (Line(
      points={{0,-10},{0,-40},{100,-40},{100,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(pump_VariablePowerCost.measureBus, measureBus) annotation (Line(
      points={{-30,10},{-30,40},{100,40},{100,20}},
      color={255,204,51},
      thickness=0.5));
  connect(pump_VariablePowerCost.controlBus, controlBus) annotation (Line(
      points={{-30,-10},{-30,-40},{100,-40},{100,-20}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Controller_VariablePowerCost;
