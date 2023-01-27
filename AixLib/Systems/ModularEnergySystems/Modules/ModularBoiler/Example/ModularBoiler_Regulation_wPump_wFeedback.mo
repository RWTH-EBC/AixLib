within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Example;
model ModularBoiler_Regulation_wPump_wFeedback
  "Example for ModularBoiler - With pump, feedback and regulation controller"
  extends Modelica.Icons.Example;

  package MediumWater = AixLib.Media.Water;

  AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.ModularBoiler_Regulation_wPump_wFeedback
    modularBoiler_Regulation_wPump_wFeedback(
    dTWaterNom=20,
    m_flowVar=true,
    Advanced=false,
    hasFeedback=true,
    dp_Valve(displayUnit="Pa") = 10,
    dpFixed_nominal(displayUnit="Pa") = {10,10},
    use_advancedControl=true,
    severalHeatCircuits=true,
    redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-30,-30},{34,30}})));
  Fluid.Sources.Boundary_pT bou(
    use_T_in=true,
    redeclare package Medium = MediumWater,
    T(displayUnit="K"),
    nPorts=2)
    annotation (Placement(transformation(extent={{-68,-12},{-44,12}})));
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
        origin={-90,4})));

equation
  connect(bou.ports[1], modularBoiler_Regulation_wPump_wFeedback.port_a)
   annotation (Line(points={{-44,-1.2},{-34,-1.2},{-34,0},{-30,0}}, color={0,127,
          255}));
  connect(boilerControlBus, modularBoiler_Regulation_wPump_wFeedback.boilerControlBus)
   annotation (Line(
      points={{0,62},{0,30},{2,30}},
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
  connect(modularBoiler_Regulation_wPump_wFeedback.port_b, bou.ports[2])
   annotation (Line(points={{34,0},{60,0},{60,-60},{-40,-60},{-40,1.2},{-44,1.2}},
                  color={0,127,255}));
  connect(BouT_sine.y, bou.T_in)
   annotation (Line(points={{-79,4},{-74,4},{-74,4.8},
          {-70.4,4.8}}, color={0,0,127}));

annotation (
    experiment(StopTime=3600));
end ModularBoiler_Regulation_wPump_wFeedback;
