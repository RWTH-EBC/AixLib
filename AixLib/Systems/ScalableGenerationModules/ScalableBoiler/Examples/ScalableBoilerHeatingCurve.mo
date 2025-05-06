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
    annotation (Placement(transformation(extent={{-36,-30},{24,30}})));
  AixLib.Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-12},{-72,12}})));
  AixLib.Controls.Interfaces.BoilerControlBus
                              boilerControlBus
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Sources.BooleanConstant isOnSet(k=true) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,76})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=scaBoi.energyDynamics,
    massDynamics=scaBoi.energyDynamics,
    T_start=scaBoi.T_start,
    m_flow_nominal=scaBoi.m_flow_nominal,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(extent={{64,0},{84,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,40})));
  Modelica.Blocks.Sources.Sine sineHeaFlo(
    amplitude=-5000,
    f=4/86400,
    offset=-25000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,68})));
  Modelica.Blocks.Sources.Sine sinTAmb(
    amplitude=5,
    f=4/86400,
    offset=278.15)
    annotation (Placement(transformation(extent={{-128,46},{-108,66}})));
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
  connect(boilerControlBus, scaBoi.boilerControlBus) annotation (Line(
      points={{0,62},{0,29.4},{-6,29.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bou.ports[1], scaBoi.port_a)
    annotation (Line(points={{-72,0},{-36,0}}, color={0,127,255}));
  connect(isOnSet.y, boilerControlBus.isOn) annotation (Line(points={{-77,76},
          {0,76},{0,62}},         color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(scaBoi.port_b, vol.ports[1])
    annotation (Line(points={{24,0},{73,0}}, color={0,127,255}));
  connect(preHeaFlo.port, vol.heatPort)
    annotation (Line(points={{64,30},{64,10}}, color={191,0,0}));
  connect(sineHeaFlo.y, preHeaFlo.Q_flow)
    annotation (Line(points={{61,68},{64,68},{64,50}}, color={0,0,127}));
  connect(sinTAmb.y, boilerControlBus.TAmbient) annotation (Line(points={{-107,56},
          {-16,56},{-16,62},{0,62}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(vol.ports[2], senTRet.port_a) annotation (Line(points={{75,0},{54,0},{
          54,-80},{32,-80}}, color={0,127,255}));
  connect(scaBoi.port_a, senTRet.port_b)
    annotation (Line(points={{-36,0},{-36,-80},{12,-80}}, color={0,127,255}));
annotation (
    experiment(StopTime=86400, Tolerance=1e-06, __Dymola_Algorithm="Dassl"),
     __Dymola_Commands(file=
        "modelica://AixLib/Resources/Scripts/Dymola/Systems/ScalableGenerationModules/Examples/ScalableBoilerHeatingCurve.mos"
        "Simulate and Plot"), Documentation(info="<html>
<p>Example with flow set temperature defined by heating curve.</p>
</html>"));
end ScalableBoilerHeatingCurve;
