within AixLib.Fluid.HydraulicModules.Example;
model ThrottlePump "Test for throttle circuit"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.Fluid.HydraulicModules.ThrottlePump ThrottlePump(redeclare package
      Medium = Medium,
    redeclare
      AixLib.Fluid.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      basicPumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    val(Kv=10, m_flow_nominal=0.5)) annotation (
      Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=90,
        origin={0,0})));
  replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (__Dymola_choicesAllMatching=true);
  Modelica.Fluid.Sources.Boundary_pT boundary(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-50})));

  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Fluid.Sources.FixedBoundary boundary1(          redeclare package
      Medium = Modelica.Media.Water.ConstantPropertyLiquidWater, nPorts=1)
                                                                 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-50})));
  AixLib.Fluid.FixedResistances.PressureDrop hydRes(
    m_flow_nominal=8*996/3600,
    dp_nominal=8000,
    m_flow(start=hydRes.m_flow_nominal),
    dp(start=hydRes.dp_nominal),
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,50})));
  AixLib.Fluid.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
equation
  connect(ThrottlePump.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-24,1.55431e-015},{-38,1.55431e-015},{-38,0},{-50,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveOpening.y, hydraulicBus.valveSet) annotation (Line(points={{-79,0},
          {-58,0},{-58,0.05},{-49.95,0.05}},        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(RPM.y, hydraulicBus.rpm_Input) annotation (Line(points={{-79,40},{-50,
          40},{-50,28},{-49.95,28},{-49.95,0.05}},      color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ThrottlePump.port_b1, hydRes.port_a) annotation (Line(points={{-14.4,24},
          {-14,24},{-14,50},{-10,50}}, color={0,127,255}));
  connect(ThrottlePump.port_a2, hydRes.port_b)
    annotation (Line(points={{14.4,24},{14.4,50},{10,50}}, color={0,127,255}));
  connect(boundary1.ports[1], ThrottlePump.port_b2) annotation (Line(points={{20,
          -40},{20,-32},{14.4,-32},{14.4,-24}}, color={0,127,255}));
  connect(boundary.ports[1], ThrottlePump.port_a1) annotation (Line(points={{-20,
          -40},{-20,-32},{-14.4,-32},{-14.4,-24}}, color={0,127,255}));
  annotation (Icon(graphics,
                   coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{120,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    experiment(StopTime=600),
    __Dymola_Commands);
end ThrottlePump;
