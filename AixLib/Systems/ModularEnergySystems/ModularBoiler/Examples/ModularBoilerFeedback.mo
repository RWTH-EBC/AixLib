within AixLib.Systems.ModularEnergySystems.ModularBoiler.Examples;
model ModularBoilerFeedback
  "Example for ModularBoiler - With Pump and simple Pump regulation"
  extends Modelica.Icons.Example;
  parameter Integer k=2 "number of consumers";
  package MediumWater = AixLib.Media.Water;

  ModularBoiler modularBoiler(
    hasPump=true,
    QNom=50000,
    kFeedBack=1,
    TiFeedBack=1,
    T_start=303.15,
    hasFeedback=true,
    use_tableData=true,
    redeclare function HeatingCurveFunction =
        AixLib.Controls.SetPoints.Functions.HeatingCurveFunction,
    dp_Valve(displayUnit="Pa") = 6000,
    use_HeaCur=false,
    Kv=10,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-34,-30},{26,30}})));
  Fluid.Sources.Boundary_pT bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    T=293.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-12},{-72,12}})));
  AixLib.Controls.Interfaces.BoilerControlBus
                              boilerControlBus
    annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Modelica.Blocks.Sources.Constant TFlowSet(k=273 + 60) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-86,40})));
  Modelica.Blocks.Sources.BooleanConstant isOnSet(k=true) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-88,76})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = AixLib.Media.Water,
    T_start=323.15,
    m_flow_nominal=modularBoiler.m_flow_nominal,
    V=0.1,
    nPorts=2) annotation (Placement(transformation(extent={{64,0},{84,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,40})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=-9000,
    f=4/86400,
    offset=-45000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={50,68})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=5,
    f=4/86400,
    offset=278.15)
    annotation (Placement(transformation(extent={{-128,46},{-108,66}})));
  Fluid.Sensors.TemperatureTwoPort        senTRet(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=modularBoiler.m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final m_flow_small=0.001)
    "Temperature sensor of cold side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={24,-62})));
equation
  connect(boilerControlBus, modularBoiler.boilerControlBus) annotation (Line(
      points={{0,62},{0,29.4},{-4,29.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bou.ports[1], modularBoiler.port_a) annotation (Line(points={{-72,0},
          {-34,0}},                  color={0,127,255}));
  connect(isOnSet.y, boilerControlBus.isOn) annotation (Line(points={{-77,76},
          {0,76},{0,62}},         color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(modularBoiler.port_b, vol.ports[1]) annotation (Line(points={{26,0},{
          73,0}},                        color={0,127,255}));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation (Line(points={{64,30},
          {64,10}},                             color={191,0,0}));
  connect(sine.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{61,68},{
          64,68},{64,50}},         color={0,0,127}));
  connect(TFlowSet.y, boilerControlBus.TSupSet) annotation (Line(points={{-75,40},
          {0,40},{0,62}},          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sine1.y, boilerControlBus.TAmbient) annotation (Line(points={{-107,56},
          {-16,56},{-16,62},{0,62}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(vol.ports[2], senTRet.port_a) annotation (Line(points={{75,0},{72,0},
          {72,-60},{34,-60},{34,-62}}, color={0,127,255}));
  connect(senTRet.port_b, modularBoiler.port_a) annotation (Line(points={{14,
          -62},{-56,-62},{-56,0},{-34,0}}, color={0,127,255}));
annotation (
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"),
     __Dymola_Commands(file=
        "modelica://AixLib/Resources/Scripts/Dymola/Systems/ModularEnergySystems/Examples/ModularBoilerFeedback.mos"
        "Simulate and Plot"), Documentation(info="<html>
<p>Example with constant flow set temperature by input and activated feedback valve for return temperature control.</p>
</html>"));
end ModularBoilerFeedback;
