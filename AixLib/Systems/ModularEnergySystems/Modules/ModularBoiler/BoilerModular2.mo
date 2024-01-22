within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model BoilerModular2

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
   parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
     "Guess value of m_flow = port_a.m_flow"
     annotation (Dialog(tab="Advanced", group="Initialization"));
   parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
     "Start value of pressure"
     annotation (Dialog(tab="Advanced", group="Initialization"));

  Fluid.BoilerCHP.BoilerGeneric boilerGeneric(
    allowFlowReversal=true,
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
        origin={-48,0})));
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
  final parameter Modelica.Units.SI.PressureDifference dp_nominal= dp_Boiler;

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
equation

  connect(boilerControlBus, boilerGeneric.boilerControlBus) annotation (Line(
      points={{0,100},{0,10},{-2.8,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

    if DWheating == true then

    end if;

    if Pump == false then

       connect(senTIn.port_b, boilerGeneric.port_a) annotation (Line(points={{-42,0},
            {-10,0}},                 color={0,127,255}));

    else

    end if;

    connect(senTIn.T, boilerControlBus.TBoilerIn) annotation (Line(points={{-48,8.8},
          {-48,86},{0,86},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_a, senTIn1.port_a)
    annotation (Line(points={{-100,0},{-92,0}}, color={0,127,255}));
  connect(senTIn1.port_b, senTIn.port_a)
    annotation (Line(points={{-80,0},{-54,0}}, color={0,127,255}));
  connect(senTIn1.T, boilerControlBus.TReturnMea) annotation (Line(points={{-86,
          8.8},{-88,8.8},{-88,104},{0,104},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerGeneric.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
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
end BoilerModular2;
