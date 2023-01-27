within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoiler_wPump_wFeedback
  "Example for ModularBoiler - With pump and feedback simple pump-feedback regulation"
  extends Modelica.Icons.Example;

  package MediumWater = AixLib.Media.Water;

  AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ModularBoiler_wPump_wFeedback
    modularBoiler_wPump_wFeedback(
    dTWaterNom=20,
    m_flowVar=true,
    Advanced=false,
    hasFeedback=true,
    dp_Valve(displayUnit="Pa") = 10,
    dpFixed_nominal(displayUnit="Pa") = {10,10},
    redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-32,-28},{30,28}})));
  Fluid.Sources.Boundary_pT bou(
    use_T_in=true,
    redeclare package Medium = MediumWater,
    T(displayUnit="K"),
    nPorts=2)
    annotation (Placement(transformation(extent={{-70,-14},{-46,10}})));
  Modelica.Blocks.Sources.Constant PLR_const(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,80})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Sources.Constant dT_const(k=35) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,48})));
  Modelica.Blocks.Sources.Sine BouT_sine(
    amplitude=1,
    freqHz=1/600,
    offset=308.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,2})));
equation
  connect(bou.ports[1], modularBoiler_wPump_wFeedback.port_a)
   annotation (Line(
        points={{-46,-3.2},{-36,-3.2},{-36,0},{-34,0},{-34,3.55271e-15},{-32,
          3.55271e-15}},                                color={0,127,255}));
  connect(boilerControlBus, modularBoiler_wPump_wFeedback.boilerControlBus)
   annotation (Line(
      points={{0,62},{0,27.44},{-1,27.44}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PLR_const.y, boilerControlBus.PLR)
   annotation (Line(points={{-59,80},{
          0.05,80},{0.05,62.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dT_const.y, boilerControlBus.DeltaTWater)
   annotation (Line(points={{-59,
          48},{0.05,48},{0.05,62.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler_wPump_wFeedback.port_b, bou.ports[2])
   annotation (Line(
        points={{30,3.55271e-15},{48,3.55271e-15},{48,-60},{-46,-60},{-46,-0.8}},
        color={0,127,255}));
  connect(BouT_sine.y, bou.T_in)
   annotation (Line(points={{-81,2},{-80,2},{-80,2.8},
          {-72.4,2.8}}, color={0,0,127}));

annotation (
    experiment(StopTime=3600));
end ModularBoiler_wPump_wFeedback;
