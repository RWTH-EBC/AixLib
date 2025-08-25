within AixLib.Systems.ScalableGenerationModules.ScalableBoiler;
model ScalableBoiler
  "Modular Boiler Model - With pump and feedback - Simple PLR regulation"

  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium = MediumWater, final m_flow_nominal=Q_flow_nominal/(Medium.cp_const
        *dT_nominal));

  // System Parameters
  parameter Boolean hasPum=true "Model includes a pump"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, group=
          "System setup"));
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal=50000
    "Nominal heat flow rate"
    annotation (Dialog(group="System setup"));
  parameter Real FirRatMin=0.15 "Minimal firing rate"  annotation(Dialog(group="System setup"));
  package MediumWater = AixLib.Media.Water "Boiler Medium" annotation(Dialog(group="System setup"));

  // Nominal parameters
  parameter Modelica.Units.SI.Temperature TRet_nominal=308.15
    "Return temperature TCold"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.TemperatureDifference dT_nominal=20
    "Temperature difference nominal"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature TSup_nominal=353.15
    "Design supply temperature" annotation (Dialog(group="Nominal condition"));
  // Safety Control
  parameter Modelica.Units.SI.Temperature TSup_max=363.15
    "Maximal temperature to force shutdown" annotation(Dialog(tab="Control", group="Safety"));
  parameter Modelica.Units.SI.Temperature TRet_min=313.15
    "Minimum return temperature, at which the system is shut down" annotation(Dialog(tab="Control", group="Safety"));
  parameter Modelica.Units.SI.Time time_minOff=900
    "Time after which the device can be turned on again" annotation(Dialog(tab="Control", group="Safety"));
  parameter Modelica.Units.SI.Time time_minOn=900
    "Time after which the device can be turned off again" annotation(Dialog(tab="Control", group="Safety"));

  // Heating Curve
  parameter Boolean use_HeaCur=false
    "Use heating curve to set flow temperature" annotation(Dialog(tab="Control", group="Heating Curve"), choices(checkBox = true));
  parameter Boolean use_tableData=true
    "Choose between tables or function to calculate TSet" annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
  replaceable function HeatingCurveFunction =
      AixLib.Controls.SetPoints.Functions.HeatingCurveFunction annotation (
      choicesAllMatching=true, Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
  parameter Real declination=1 annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
  parameter Real day_hour=6 annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
  parameter Real night_hour=22 annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
  parameter Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2017
    "Enumeration for choosing how reference time (time = 0) should be defined. Used for heating curve" annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));
  parameter Modelica.Units.SI.ThermodynamicTemperature TOffset=0
    "Offset to heating curve temperature" annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));

  // Flow temperature control
  parameter Real kFloTem=0.05 "Gain of controller"
                                                annotation (Dialog(tab="Control", group="Flow temperature"));
  parameter Modelica.Units.SI.Time TiFloTem=10
    "Time constant of Integrator block"                                         annotation (Dialog(tab="Control", group=
          "Flow temperature"));

  // Feedback
  parameter Boolean hasFedBac=true "circuit has Feedback"        annotation (choices(checkBox=true), Dialog(descriptionLabel=true, group=
          "Feedback"));
  parameter Real kFedBac=1 "Gain of controller"   annotation (Dialog(enable=
          hasFedBac,                                                                   tab="Control", group=
          "Feedback"));
  parameter Modelica.Units.SI.Time TiFeedBack=0.5
    "Time constant of Integrator block" annotation (Dialog(enable=hasFedBac, tab="Control", group = "Feedback"));
  parameter Real yMaxFedBac=0.99 "Upper limit of output"   annotation (Dialog(enable=
          hasFedBac,                                                                            tab="Control", group=
          "Feedback"));
  parameter Real yMinFedBac=0.01 "Lower limit of output"   annotation (Dialog(enable=
          hasFedBac,                                                                            tab="Control", group=
          "Feedback"));
  parameter Modelica.Units.SI.PressureDifference dp_Valve  "Pressure Difference set in regulating valve for pressure equalization in heating system"
    annotation (Dialog(enable = hasFedBac, group="Feedback"));
  parameter Real Kv "Kv (metric) flow coefficient [m3/h/(bar)^(1/2)]"
        annotation (Dialog(enable = hasFedBac, group="Feedback"));

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state" annotation (Dialog(tab="Dynamics"), group="Conservation equations");
  parameter Modelica.Media.Interfaces.Types.Temperature T_start=Medium.T_default
    "Start value of temperature" annotation (Dialog(tab="Initialization"));

  Fluid.BoilerCHP.BoilerGeneric boiGen(
    allowFlowReversal=allowFlowReversal,
    final T_start=T_start,
    final Q_flow_nominal=Q_flow_nominal,
    TSup_nominal=TSup_nominal,
    final TRet_nominal=TRet_nominal,
    energyDynamics=energyDynamics)
    annotation (Placement(transformation(extent={{12,-10},{32,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTSup(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final T_start=T_start,
    final transferHeat=false,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,0})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTRet(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final T_start=T_start,
    final transferHeat=false,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=0.001)
    "Temperature sensor of cold side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,0})));

  AixLib.Fluid.Movers.SpeedControlled_y pum(
    redeclare final package Medium = Medium,
    energyDynamics=energyDynamics,
    T_start=T_start,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=0.001,
    final per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={
            dp_nominal/0.8,dp_nominal,0})),
    final addPowerToMedium=false) if hasPum  "Boiler Pump"
    annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));

  AixLib.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    redeclare final package Medium = Medium,
    energyDynamics=energyDynamics,
    T_start=T_start,
    use_strokeTime=false,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    final dpValve_nominal=dp_Valve,
    Kv=Kv,
    final m_flow_nominal= m_flow_nominal,
    final dpFixed_nominal={10,10}) if hasFedBac
    annotation (Placement(transformation(extent={{-74,-10},{-54,10}})));

  AixLib.Controls.Interfaces.BoilerControlBus boiBus
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

  AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.BoilerControl boiCtr(
    dtWaterNom=dT_nominal,
    final FirRatMin=FirRatMin,
    kFloTem=kFloTem,
    TiFloTem=TiFloTem,
    final TFlowByHeaCur=use_HeaCur,
    final use_tableData=use_tableData,
    redeclare final function heaCurFun = HeatingCurveFunction,
    final dec=declination,
    final dayHou=day_hour,
    final nigHou=night_hour,
    final zerTim=zerTim,
    final TOffset=TOffset,
    final TRetNom=TRet_nominal,
    final hasFeedback=hasFedBac,
    final kFeedBack=kFedBac,
    final TiFeedBack=TiFeedBack,
    final yMaxFeedBack=yMaxFedBac,
    final yMinFeedBack=yMinFedBac,
    final TRetMin=TRet_min,
    final time_minOff=time_minOff,
    final TFlowMax=TSup_max,
    final time_minOn=time_minOn) "Central control unit of boiler"
    annotation (Placement(transformation(extent={{-96,58},{-62,92}})));
  Modelica.Blocks.Sources.Constant conPum(k=1)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
protected
    parameter Modelica.Units.SI.PressureDifference dp_nominal = dp_nominal_boiler + dp_Valve;
  parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  parameter Modelica.Units.SI.PressureDifference dp_nominal_boiler=7.143*10^8*
      exp(-0.007078*Q_flow_nominal/1000)*(V_flow_nominal)^2;
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_medium = Medium.cp_const;

equation
  if not hasPum then
    connect(senTRet.port_b, boiGen.port_a);
  else
    connect(pum.port_b, boiGen.port_a)
      annotation (Line(points={{-6,0},{12,0}}, color={0,127,255}));
    connect(senTRet.port_b, pum.port_a)
      annotation (Line(points={{-30,0},{-26,0}}, color={0,127,255}));
  end if;

  connect(senTSup.port_b, port_b)
    annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
  connect(senTSup.port_a, boiGen.port_b)
    annotation (Line(points={{50,0},{32,0}}, color={0,127,255}));

  if hasFedBac then
    connect(port_a, val.port_1)
      annotation (Line(points={{-100,0},{-74,0}}, color={0,127,255},
        pattern=LinePattern.Dash));
    connect(val.port_2, senTRet.port_a) annotation (Line(
        points={{-54,0},{-50,0}},
        color={0,127,255},
        pattern=LinePattern.Dash));
    connect(port_b, val.port_3)
      annotation (Line(points={{100,0},{78,0},{78,-44},{-64,-44},{-64,-10}},
                      color={0,127,255},
        pattern=LinePattern.Dash));
  else
    connect(port_a, senTRet.port_a);
  end if;

  connect(boiGen.boiBus, boiBus) annotation (Line(
      points={{22,10},{22,92},{0,92},{0,98}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boiBus.yValSet, val.y) annotation (Line(
      points={{0,98},{0,22},{-64,22},{-64,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boiCtr.boiBus, boiBus) annotation (Line(
      points={{-79,92},{0,92},{0,98}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPum.y, pum.y)
    annotation (Line(points={{-19,50},{-16,50},{-16,12}}, color={0,0,127}));
    annotation (Dialog(group = "Feedback"), choices(checkBox = true),
              Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Line(
          points={{-94,0},{96,0}},
          color={0,127,255},
          thickness=0.5),
        Polygon(
          points={{-80,-10},{-80,10},{-60,0},{-80,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid, visible=hasFeedback),
        Polygon(
          points={{10,-10},{-10,-10},{0,10},{10,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-60,-10},
          rotation=0, visible=hasFeedback),
        Polygon(
          points={{-40,-10},{-40,10},{-60,0},{-40,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid, visible=hasFeedback),
        Ellipse(
          extent={{-26,20},{14,-20}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid, visible=hasPump),
        Line(
          points={{-6,20},{14,0},{-6,-20}},
          color={135,135,135},
          thickness=0.5, visible=hasPump),
        Rectangle(
          extent={{36,20},{72,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{42,10},{64,-12}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{58,-10},{60,-6},{60,-2},{58,2},{56,4},{54,4},{52,2},{54,0},{54,
              -4},{52,-6},{50,-8},{50,-10},{54,-10},{58,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,-10},{58,-12}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{82,2},{86,-2}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid, visible=hasFeedback),
        Line(
          points={{-60,-20},{-60,-60}},
          color={0,128,255},
          thickness=0.5, visible=hasFeedback),
        Line(
          points={{-60,-60},{84,-60}},
          color={0,128,255},
          thickness=0.5, visible=hasFeedback),
        Line(
          points={{84,-2},{84,-60}},
          color={0,128,255},
          thickness=0.5, visible=hasFeedback)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>The ModularBoiler package uses the <a href=\"modelica://AixLib.Fluid.BoilerCHP.BoilerGeneric\">AixLib.Fluid.BoilerCHP.BoilerGeneric</a> model to create an easy to use module. </p>
<h4>Configuration options</h4>
<p>The model can be configured with or without a pump (<i>hasPump</i>) and with or without a feedback circuit (<i>hasFeedback</i>) for return temperature control.</p>
<p>Furthermore the model can have an internal control for the flow temperature based on a heating curve (<i>use_HeaCur</i>). This allows an easy setup of a direct to use simulation model of the boiler that can be connected to other modules.</p>
</html>", revisions="<html>
<ul>
<li>
<i>June, 2023</i> by Moritz Zuschlag; David Jansen<br/>
    First Implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1147\">#1147</a>)
</li>
</ul>
</html>"));
end ScalableBoiler;
