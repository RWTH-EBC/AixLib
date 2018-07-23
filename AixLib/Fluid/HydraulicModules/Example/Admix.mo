within AixLib.Fluid.HydraulicModules.Example;
model Admix "Test for admix circuit"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.Fluid.HydraulicModules.Admix Admix(
    redeclare package Medium = Medium,
    redeclare
      AixLib.Fluid.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      basicPumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to6 per)),
    m_flow_nominal=1,
    pipe1(
      dIns=0.001,
      length=1,
      kIns=0.028),
    pipe2(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe3(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe4(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe5(
      length=1,
      dIns=0.01,
      kIns=0.028),
    pipe6(
      length=1,
      dIns=0.01,
      kIns=0.028),
    T_amb=293.15,
    val(Kv=10))                     annotation (Placement(transformation(
        extent={{-28,-25},{28,25}},
        rotation=90,
        origin={17,20})));
  package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    annotation (choicesAllMatching=true);
  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    T=323.15,
    redeclare package Medium = Medium)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-30})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    nPorts=1,
    T=323.15,
    redeclare package Medium = Medium)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={40,-30})));

  AixLib.Fluid.FixedResistances.PressureDrop hydRes(
    m_flow_nominal=8*996/3600,
    dp_nominal=8000,
    m_flow(start=hydRes.m_flow_nominal),
    dp(start=hydRes.dp_nominal),
    redeclare package Medium = Medium)
    "Hydraulic resistance in distribution cirquit (shortcut pipe)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,60})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  BaseClasses.HydraulicBus hydraulicBus
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
equation

  connect(valveOpening.y,hydraulicBus. valveSet) annotation (Line(points={{-79,10},
          {-60,10},{-60,20},{-40,20}},              color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Admix.port_b1, hydRes.port_a)
    annotation (Line(points={{3.11111,48},{4,48},{4,60},{10,60}},
                                                          color={0,127,255}));
  connect(Admix.port_a2, hydRes.port_b) annotation (Line(points={{36.4444,48},{
          36,48},{36,60},{30,60}}, color={0,127,255}));
  connect(Admix.port_a1, boundary.ports[1])
    annotation (Line(points={{3.11111,-8},{1.9984e-015,-8},{1.9984e-015,-20}},
                                                         color={0,127,255}));
  connect(Admix.port_b2, boundary1.ports[1])
    annotation (Line(points={{36.4444,-8},{40,-8},{40,-20}},
                                                           color={0,127,255}));
  connect(Admix.hydraulicBus, hydraulicBus) annotation (Line(
      points={{-8,20},{-40,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-25,3},{-25,3}}));
  connect(RPM.y, hydraulicBus.pumpBus.rpm_Input) annotation (Line(points={{-79,
          50},{-39.95,50},{-39.95,20.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Icon(graphics,
         coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=800),
    Documentation(revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Transfer from ZUGABE to AixLib.</li>
</ul>
</html>"));
end Admix;
