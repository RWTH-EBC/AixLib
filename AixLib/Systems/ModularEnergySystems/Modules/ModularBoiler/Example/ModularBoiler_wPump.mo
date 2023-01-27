within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoiler_wPump
  "Example for ModularBoiler - With Pump and simple Pump regulation"
  extends Modelica.Icons.Example;

  package MediumWater = AixLib.Media.Water;

  AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ModularBoiler_wPump
    modularBoiler_wPump(
    m_flowVar=true,
    redeclare package Medium = MediumWater,
    Advanced=false)
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=2)
    annotation (Placement(transformation(extent={{-96,-14},{-72,10}})));
  Modelica.Blocks.Sources.Constant PLR_const(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,80})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Sources.Constant dT_const(k=25) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,48})));
equation
  connect(bou.ports[1], modularBoiler_wPump.port_a)
   annotation (Line(points={{-72,-3.2},{-50,-3.2},{-50,0},{-30,0}},
                                             color={0,127,255}));
  connect(boilerControlBus, modularBoiler_wPump.boilerControlBus)
   annotation (
      Line(
      points={{0,62},{0,29.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PLR_const.y, boilerControlBus.PLR) annotation (Line(points={{-59,80},{
          0.05,80},{0.05,62.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dT_const.y, boilerControlBus.DeltaTWater) annotation (Line(points={{-59,
          48},{0,48},{0,56},{0.05,56},{0.05,62.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler_wPump.port_b, bou.ports[2])
   annotation (Line(points={{30,0},{60,0},{60,-46},{-72,-46},{-72,-0.8}},
        color={0,127,255}));
annotation (
    experiment(StopTime=3600));
end ModularBoiler_wPump;
