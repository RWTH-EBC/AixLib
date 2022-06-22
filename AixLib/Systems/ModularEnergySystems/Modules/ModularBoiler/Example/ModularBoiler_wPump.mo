within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoiler_wPump
  extends Modelica.Icons.Example;

  package MediumWater = AixLib.Media.Water;

  AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ModularBoiler_wPump
    modularBoiler_wPump(
    dTWaterNom=30,
    m_flowVar=true,
    Advanced=false,
    redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-30,-30},{32,28}})));
  Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=2)
    annotation (Placement(transformation(extent={{-96,-12},{-72,12}})));
  Modelica.Blocks.Sources.Constant
                               const1(k=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,80})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Sources.Constant
                               const2(k=35)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,46})));
equation
  connect(bou.ports[1], modularBoiler_wPump.port_a) annotation (Line(points={{-72,2.4},
          {-50,2.4},{-50,-1},{-30,-1}},      color={0,127,255}));
  connect(boilerControlBus, modularBoiler_wPump.boilerControlBus) annotation (
      Line(
      points={{0,62},{0,27.42},{1,27.42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const1.y, boilerControlBus.PLR) annotation (Line(points={{-59,80},{
          0.05,80},{0.05,62.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const2.y, boilerControlBus.DeltaTWater) annotation (Line(points={{-59,
          46},{-46,46},{-46,48},{0.05,48},{0.05,62.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler_wPump.port_b, bou.ports[2]) annotation (Line(points={{
          32,-1},{68,-1},{68,-72},{-54,-72},{-54,-2.4},{-72,-2.4}}, color={0,
          127,255}));
end ModularBoiler_wPump;
