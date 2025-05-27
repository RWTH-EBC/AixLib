within AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Examples;
model ScalableBoilerHeatingCurve
  "Example for ScalableBoiler - With Pump and simple Pump regulation using a 
  heating curve for supply temperature control"
  extends Modelica.Icons.Example;
  package MediumWater = AixLib.Media.Water;

  AixLib.Systems.ScalableGenerationModules.ScalableBoiler.ScalableBoiler scaBoi(
    hasPum=true,
    Q_flow_nominal=50000,
    T_start=303.15,
    hasFedBac=false,
    use_tableData=true,
    dp_Valve(displayUnit="Pa") = 6000,
    use_HeaCur=true,
    Kv=10,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));
  AixLib.Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  AixLib.Controls.Interfaces.BoilerControlBus boiBus "Signal bus for boiler"
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Sources.BooleanConstant isOnSet(k=true) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,90})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=scaBoi.energyDynamics,
    massDynamics=scaBoi.energyDynamics,
    T_start=scaBoi.T_start,
    m_flow_nominal=scaBoi.m_flow_nominal,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,50})));
  Modelica.Blocks.Sources.Sine sineHeaFlo(
    amplitude=-5000,
    f=4/86400,
    offset=-25000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,70})));
  Modelica.Blocks.Sources.Sine sinTAmb(
    amplitude=5,
    f=4/86400,
    offset=278.15)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTRet(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=scaBoi.m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final m_flow_small=0.001)
    "Temperature sensor of cold side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={22,-80})));
equation
  connect(boiBus, scaBoi.boiBus) annotation (Line(
      points={{0,62},{0,29.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bou.ports[1], scaBoi.port_a)
    annotation (Line(points={{-60,-10},{-44,-10},{-44,0},{-30,0}},
                                               color={0,127,255}));
  connect(isOnSet.y, boiBus.isOn) annotation (Line(points={{-59,90},{0,90},{0,
          62}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(scaBoi.port_b, vol.ports[1])
    annotation (Line(points={{30,0},{79,0}}, color={0,127,255}));
  connect(preHeaFlo.port, vol.heatPort)
    annotation (Line(points={{70,40},{70,24},{60,24},{60,10},{70,10}},
                                               color={191,0,0}));
  connect(sineHeaFlo.y, preHeaFlo.Q_flow)
    annotation (Line(points={{61,70},{70,70},{70,60}}, color={0,0,127}));
  connect(sinTAmb.y, boiBus.TAmbient) annotation (Line(points={{-59,50},{-20,50},
          {-20,62},{0,62}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(vol.ports[2], senTRet.port_a) annotation (Line(points={{81,0},{54,0},
          {54,-80},{32,-80}},color={0,127,255}));
  connect(scaBoi.port_a, senTRet.port_b)
    annotation (Line(points={{-30,0},{-40,0},{-40,-80},{12,-80}},
                                                          color={0,127,255}));
annotation (
    experiment(StopTime=86400, Tolerance=1e-06, __Dymola_Algorithm="Dassl"),
     __Dymola_Commands(file=
        "modelica://AixLib/Resources/Scripts/Dymola/Systems/ScalableGenerationModules/Examples/ScalableBoilerHeatingCurve.mos"
        "Simulate and Plot"), Documentation(info="<html>
<p>Example with flow set temperature defined by heating curve.</p>
</html>", revisions="<html>
<ul>
<li>
<i>June, 2023</i> by Moritz Zuschlag; David Jansen<br/>
    First Implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1147\">#1147</a>)
</li>
</ul>
</html>"));
end ScalableBoilerHeatingCurve;
