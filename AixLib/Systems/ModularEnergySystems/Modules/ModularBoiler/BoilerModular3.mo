within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model BoilerModular3

  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare final
      package Medium = AixLib.Media.Water, final m_flow_nominal=DesQ/(Medium.cp_const
        *DesDelT));

  parameter Modelica.Units.SI.TemperatureDifference DesDelT=20
    "Design temperature difference between supply and return"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature DesRetT=273.15 + 35
    "Design return temperature"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.HeatFlowRate DesQ=50000 "Design thermal capacity"
   annotation (Dialog(group="Nominal condition"));

    parameter Boolean Pump=true "Model includes a pump"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));

  parameter Boolean DWheating=false "Model includes drinking water heating system"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));

  final parameter Real PLR_min=0.15 "Minimal Part Load Ratio";

  parameter Modelica.Units.SI.Temperature T_start=273.15 + 20
                                                           "Starting temperature"
   annotation (Dialog(tab="Advanced"));

   parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=0
     "Guess value of dp = port_a.p - port_b.p"
     annotation (Dialog(tab="Advanced", group="Initialization"));

     parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_external=0;
   parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
     "Guess value of m_flow = port_a.m_flow"
     annotation (Dialog(tab="Advanced", group="Initialization"));
   parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
     "Start value of pressure"
     annotation (Dialog(tab="Advanced", group="Initialization"));

  Fluid.BoilerCHP.BoilerGeneric boilerGeneric(
    allowFlowReversal=true,
    initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start,
    QNom=DesQ,
    THotNom=DesRetT + DesDelT,
    TColdNom=DesRetT)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Fluid.Sensors.TemperatureTwoPort senTIn(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start,
    final transferHeat=false,
    final allowFlowReversal=true,
    final m_flow_small=0.001) "Temperature sensor module inlet" annotation (
      Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=0,
        origin={-56,0})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    p(start=Medium.p_default),
    redeclare final package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  final parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  final parameter Modelica.Units.SI.PressureDifference dp_Boiler= 7.143*
      10^8*exp(-0.000007078*DesQ)*(V_flow_nominal)^2;
  final parameter Modelica.Units.SI.PressureDifference dp_nominal= dp_Boiler+dp_external;

  Fluid.Sensors.TemperatureTwoPort senTIn1(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=T_start,
    final transferHeat=false,
    final allowFlowReversal=true,
    final m_flow_small=0.001) "Temperature sensor module inlet" annotation (
      Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=0,
        origin={-86,0})));
  Fluid.Movers.SpeedControlled_y pump(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=DesRetT,
    allowFlowReversal=true,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per(pressure(
          V_flow={0,V_flow_nominal,V_flow_nominal/0.7}, dp={dp_nominal/0.9,
            dp_nominal,0})),
    addPowerToMedium=false,
    use_inputFilter=false) if Pump == true
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  Modelica.Blocks.Continuous.Integrator integrator4
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  Modelica.Blocks.Math.Gain gain1
    annotation (Placement(transformation(extent={{32,64},{44,76}})));
equation

  connect(boilerControlBus, boilerGeneric.boilerControlBus) annotation (Line(
      points={{0,100},{0,10},{0,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

    if DWheating == true then

    end if;

    if Pump == false then

    else

    end if;

  connect(port_a, senTIn1.port_a)
    annotation (Line(points={{-100,0},{-92,0}}, color={0,127,255}));
  connect(senTIn1.port_b, senTIn.port_a)
    annotation (Line(points={{-80,0},{-62,0}}, color={0,127,255}));
  connect(senTIn.port_b, pump.port_a)
    annotation (Line(points={{-50,0},{-44,0}}, color={0,127,255}));
  connect(pump.port_b, boilerGeneric.port_a)
    annotation (Line(points={{-24,0},{-10,0}}, color={0,127,255}));
  connect(boilerControlBus.m_flowSet, pump.y) annotation (Line(
      points={{0,100},{0,58},{-34,58},{-34,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerGeneric.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(boilerControlBus.PowerDemand, integrator4.u) annotation (Line(
      points={{0,100},{0,40},{28,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator4.y, boilerControlBus.EnergyFuel) annotation (Line(points={
          {51,40},{64,40},{64,38},{86,38},{86,100},{0,100}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.PowerDemand, gain1.u) annotation (Line(
      points={{0,100},{0,70},{30.8,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(gain1.y, boilerControlBus.PowerFuel) annotation (Line(points={{44.6,
          70},{62,70},{62,68},{74,68},{74,100},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
          points={{-16.5,-21.5},{-6.5,-1.5},{19.5,-21.5},{-6.5,-21.5},{-16.5,
              -21.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26.5,-21.5},{27.5,-29.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerModular3;
