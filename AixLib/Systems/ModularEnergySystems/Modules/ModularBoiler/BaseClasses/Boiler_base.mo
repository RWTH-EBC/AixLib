within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.BaseClasses;
partial model Boiler_base
  "Base model for modular boiler - with one output"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    redeclare package Medium = MediumWater,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));

  package MediumWater = AixLib.Media.Water "Boiler Medium";
  parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature TColdNom=308.15 "Return temperature TCold"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature THotMax=363.15 "Maximal temperature to force shutdown";
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Thermal dimension power"
    annotation (Dialog(group="Nominal condition"));
  parameter Boolean m_flowVar=false "Use variable water massflow"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
  parameter Boolean Pump=true "Model includes a pump"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true));
  parameter Boolean Advanced=false "dTWater is constant for different PLR"
    annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
  parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
    annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";
  parameter Modelica.Units.SI.Temperature TStart=293.15 "T start"
    annotation (Dialog(tab="Advanced"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));

  Fluid.BoilerCHP.BoilerNotManufacturer heatGeneratorNoControl(
    final T_start=TStart,
    final dTWaterSet=dTWaterSet,
    final QNom=QNom,
    final PLRMin=PLRMin,
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final dTWaterNom=dTWaterNom,
    final TColdNom=TColdNom,
    final m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  inner Modelica.Fluid.System system(final p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTHot(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,0})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCold(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of cold side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,0})));

  AixLib.Fluid.Movers.SpeedControlled_y fan(
    redeclare final package Medium = Medium,
    final allowFlowReversal=false,
    final m_flow_small=0.001,
    final per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={dp_nominal/0.8,
            dp_nominal,0})),
    final addPowerToMedium=false) if Pump "Boiler Pump"
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));

protected
  parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  parameter Modelica.Units.SI.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
  parameter Modelica.Units.SI.HeatCapacity cp_medium = Medium.cp_const;

equation

  if not Pump then
    connect(senTCold.port_b, heatGeneratorNoControl.port_a);
  else
    connect(fan.port_b, heatGeneratorNoControl.port_a)
      annotation (Line(points={{-26,0},{-10,0}},color={0,127,255}));
    connect(senTCold.port_b, fan.port_a)
      annotation (Line(points={{-50,0},{-46,0}}, color={0,127,255}));
  end if;

  connect(senTHot.port_b, port_b)
    annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
  connect(senTHot.port_a, heatGeneratorNoControl.port_b)
    annotation (Line(points={{50,0},{10,0}}, color={0,127,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),
        Polygon(
          points={{-18.5,-23.5},{-26.5,-7.5},{-4.5,36.5},{3.5,10.5},{25.5,14.5},
              {15.5,-27.5},{-2.5,-23.5},{-8.5,-23.5},{-18.5,-23.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-16.5,-21.5},{-6.5,-1.5},{19.5,-21.5},{-6.5,-21.5},{-16.5,-21.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26.5,-21.5},{27.5,-29.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  A boiler model consisting of physical components. The user has the
  choice to run the model for three different setpoint options:
</p>
<ol>
  <li>Setpoint depends on part load ratio (water mass flow=dimension
  water mass flow; advanced=false & m_flowVar=false)
  </li>
  <li>Setpoint depends on part load ratio and a constant water
  temperature difference which is idependent from part load ratio
  (water mass flow is variable; advanced=false & m_flowVar=true)
  </li>
  <li>Setpoint depends on part load ratio an a variable water
  temperature difference (water mass flow is variable; advanced=true)
  </li>
</ol>
</html>"),
    experiment(StopTime=10));
end Boiler_base;
