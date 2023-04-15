within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler
  "Modular Boiler Model - With pump and feedback - Simple PLR regulation"
    extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    redeclare package Medium = MediumWater,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));

  parameter Boolean m_flowVar=false "Use variable water massflow"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

  parameter Boolean Advanced=false "dTWater is constant for different PLR"
    annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
  parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
    annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));

  parameter Modelica.Units.SI.Temperature TStart=293.15 "T start"
    annotation (Dialog(tab="Advanced"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));

  // System Parameters
  parameter Boolean hasFeedback=true  "circuit has Feedback"     annotation (choices(checkBox=true), Dialog(descriptionLabel=true, group="System setup"));
  parameter Boolean Pump=true "Model includes a pump"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, group="System setup"));
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Thermal dimension power"
    annotation (Dialog(group="System setup"));
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio" annotation(Dialog(group="System setup"));
  package MediumWater = AixLib.Media.Water "Boiler Medium" annotation(Dialog(group="System setup"));

  // Nominal parameters
    parameter Modelica.Units.SI.Temperature TRetNom=308.15
    "Return temperature TCold"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
    annotation (Dialog(group="Nominal condition"));

  // Safety Control
  parameter Modelica.Units.SI.Temperature TFlowMax=363.15
    "Maximal temperature to force shutdown" annotation(Dialog(tab="Control", group="Safety"));
  parameter Modelica.Units.SI.Temperature TRetMin=313.15
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
  parameter Modelica.Units.SI.ThermodynamicTemperature TOffset=273.15
    "Offset to heating curve temperature" annotation(Dialog(enable = use_HeaCur, tab="Control", group="Heating Curve"));

  // PLR Flow temperature control
  parameter Real kPLR=0.05 "Gain of controller" annotation (Dialog(tab="Control", group = "Flow temperature"));
  parameter Modelica.Units.SI.Time TiPLR=10 "Time constant of Integrator block" annotation (Dialog(tab="Control", group = "Flow temperature"));
  parameter Real yMaxPLR=1.0 "Upper limit of output" annotation (Dialog(tab="Control", group = "Flow temperature"));
  parameter Real yMinPLR=0 "Lower limit of output" annotation (Dialog(tab="Control", group = "Flow temperature"));

  // Feedback
  parameter Real kFeedBack=1 "Gain of controller" annotation (Dialog(enable=hasFeedback, tab="Control", group = "Feedback"));
  parameter Modelica.Units.SI.Time TiFeedBack=0.5
    "Time constant of Integrator block" annotation (Dialog(enable=hasFeedback, tab="Control", group = "Feedback"));
  parameter Real yMaxFeedBack=0.99 "Upper limit of output" annotation (Dialog(enable=hasFeedback, tab="Control", group = "Feedback"));
  parameter Real yMinFeedBack=0.01 "Lower limit of output" annotation (Dialog(enable=hasFeedback, tab="Control", group = "Feedback"));
  parameter Modelica.Units.SI.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system"
    annotation (Dialog(enable = hasFeedback, group="Feedback"));

  Fluid.BoilerCHP.BoilerNotManufacturer heatGeneratorNoControl(
    allowFlowReversal=allowFlowReversal,
    final T_start=TStart,
    final QNom=QNom,
    final PLRMin=PLRMin,
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final dTWaterNom=dTWaterNom,
    final TRetNom=TRetNom,
    final m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTFlow(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final T_start=TStart,
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
    final T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=0.001)
    "Temperature sensor of cold side of heat generator (supply)" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,0})));

  AixLib.Fluid.Movers.SpeedControlled_y pump(
    redeclare final package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=0.001,
    final per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={
            dp_nominal/0.8,dp_nominal,0})),
    final addPowerToMedium=false) if Pump "Boiler Pump"
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));

  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    redeclare final package Medium = Medium,
    use_inputFilter=false,
    final m_flow_nominal= m_flow_nominal,
    final dpValve_nominal=dp_Valve,
    final dpFixed_nominal={0,0})           if hasFeedback
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));

  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

  ControlsModularBoiler.BoilerControl boilerControl(
    dtWaterNom=dTWaterNom,
    final PLRMin=PLRMin,
    kPLR=kPLR,
    TiPLR=TiPLR,
    yMaxPLR=yMaxPLR,
    yMinPLR=yMinPLR,
    final TFlowByHeaCur=use_HeaCur,
    final use_tableData=use_tableData,
    redeclare final function HeatingCurveFunction = HeatingCurveFunction,
    final declination=declination,
    final day_hour=day_hour,
    final night_hour=night_hour,
    final zerTim=zerTim,
    final TOffset=TOffset,
    final TReturnNom=TRetNom,
    final kFeedBack=kFeedBack,
    final TiFeedBack=TiFeedBack,
    final yMaxFeedBack=yMaxFeedBack,
    final yMinFeedBack=yMinFeedBack,
    final TRetMin=TRetMin,
    final time_minOff=time_minOff,
    final TFlowMax=TFlowMax,
    final time_minOn=time_minOn)
                       "Central control unit of boiler"
    annotation (Placement(transformation(extent={{-92,56},{-58,90}})));

protected
    parameter Modelica.Units.SI.PressureDifference dp_nominal = dp_nominal_boiler + dp_Valve;
  parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  parameter Modelica.Units.SI.PressureDifference dp_nominal_boiler=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_medium = Medium.cp_const;

equation
  if not Pump then
    connect(senTRet.port_b, heatGeneratorNoControl.port_a);
  else
    connect(pump.port_b, heatGeneratorNoControl.port_a)
      annotation (Line(points={{-26,0},{-10,0}}, color={0,127,255}));
    connect(senTRet.port_b, pump.port_a)
      annotation (Line(points={{-50,0},{-46,0}}, color={0,127,255}));
  end if;

  connect(senTFlow.port_b, port_b)
    annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
  connect(senTFlow.port_a, heatGeneratorNoControl.port_b)
    annotation (Line(points={{50,0},{10,0}}, color={0,127,255}));

  if hasFeedback then
    connect(port_a, val.port_1)
      annotation (Line(points={{-100,0},{-94,0}}, color={0,127,255},
        pattern=LinePattern.Dash));
    connect(val.port_2, senTRet.port_a) annotation (Line(
        points={{-74,0},{-70,0}},
        color={0,127,255},
        pattern=LinePattern.Dash));
    connect(port_b, val.port_3)
      annotation (Line(points={{100,0},{100,-40},{-84,-40},{-84,-10}},
                      color={0,127,255},
        pattern=LinePattern.Dash));
  else
    connect(port_a, senTRet.port_a);
  end if;

  connect(boilerControlBus, boilerControl.boilerControlBus) annotation (Line(
      points={{0,98},{0,100},{-74,100},{-74,90},{-75,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControl.PLRset, heatGeneratorNoControl.PLR) annotation (Line(
        points={{-57.66,79.8},{-28,79.8},{-28,16},{-18,16},{-18,5.4},{-12,5.4}},
        color={0,0,127}));
  connect(boilerControl.mFlowRel, pump.y) annotation (Line(points={{-56.3,77.08},
          {-56.3,76},{-32,76},{-32,70},{-30,70},{-30,18},{-36,18},{-36,12}},
        color={0,0,127}));
  connect(boilerControl.yValveFeedback, val.y) annotation (Line(points={{-56.3,68.92},
          {-50,68.92},{-50,22},{-84,22},{-84,12}}, color={0,0,127}));
  connect(senTFlow.T, boilerControlBus.TFlowMea) annotation (Line(points={{60,11},
          {64,11},{64,98.05},{0.05,98.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senTRet.T, boilerControlBus.TRetMea) annotation (Line(points={{-60,11},
          {-60,16},{64,16},{64,98.05},{0.05,98.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControl.dTWaterNom, heatGeneratorNoControl.dTWater) annotation (
     Line(points={{-56.3,62.46},{-20,62.46},{-20,10},{-12,10}}, color={0,0,127}));
  connect(boilerControlBus.PLRMea, boilerControl.PLRset) annotation (Line(
      points={{0.05,98.05},{0.05,79.8},{-57.66,79.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatGeneratorNoControl.PowerDemand, boilerControlBus.EnergyDemand)
    annotation (Line(points={{11,-7},{28,-7},{28,98.05},{0.05,98.05}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
        coordinateSystem(preserveAspectRatio=false)));
end ModularBoiler;
