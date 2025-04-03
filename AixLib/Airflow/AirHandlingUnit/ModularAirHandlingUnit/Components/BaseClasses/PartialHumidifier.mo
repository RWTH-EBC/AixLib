within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses;
model PartialHumidifier
  "partial model of a humidifier"
  extends Components.BaseClasses.PartialComponent;

  parameter Modelica.Units.SI.SpecificHeatCapacity cpWater = 4180
    "specific heat capacity of liquid water"
    annotation(Dialog(tab="Advanced"));

  parameter Boolean use_X_set = false
    "if true, a set humidity is used to calculate the necessary mass flow rate";

  parameter Modelica.Units.SI.MassFlowRate mWat_flow_nominal = 0.05
    "nominal water/steam flow rate of humidifier"
    annotation(Dialog(enable=not use_X_set,group="Nominal conditions"));
  parameter Modelica.Units.SI.Temperature TWatIn(start=288.15)
    "temperature of liquid water added to humidifier";

  parameter Modelica.Units.SI.Temperature TSteam=373.15
    "Temperature of steam in steam humidifier"
    annotation (Dialog(
      tab="Advanced",
      group="Vaporization"));

  parameter Real k = 500 "exponent for humidification degree  in spray humidifier";

  // Variables
  Modelica.Blocks.Interfaces.RealInput u(min=0, max=1) if not use_X_set
    "input connector scaling water flow rate [0..1]" annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={-70,-104}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-60,-94})));
  Modelica.Blocks.Interfaces.RealInput X_set if use_X_set
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,102})));

  replaceable model PartialPressureDrop =
      Components.PressureDrop.BaseClasses.partialPressureDrop
      annotation(choicesAllMatching=true);

  PartialPressureDrop partialPressureDrop(
    final m_flow=mAirIn_flow,
    final rho=rhoAir,
    final dp_nominal=dp_nominal,
    final m_flow_nominal=m_flow_nominal);



  // constants
protected
  constant Modelica.Units.SI.SpecificEnthalpy r100 = 2257E3
    "specific heat of vaporization at 100°C";

  Modelica.Units.SI.HeatFlowRate Qb_flow
    "heat flow over boundary";
  Modelica.Blocks.Sources.Constant mWat_nominal(k=mWat_flow_nominal)
    if not use_X_set
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Math.Product mW_flow if not use_X_set
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Math.Max max if use_X_set
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Interfaces.RealInput X_intern
    "internal mass fraction";
  Modelica.Blocks.Interfaces.RealInput mWat_flow_intern
    "internal mass flow rate of water";
equation

  //mass flow rate
  mDryAirIn_flow - mDryAirOut_flow = 0;

  //heat flows
  Qb_flow = mDryAirOut_flow * hAirOut - mDryAirIn_flow * hAirIn;

  partialPressureDrop.dp = dp;

  connect(mW_flow.y, mWat_flow_intern);
  connect(X_set, max.u1) annotation (Line(points={{0,110},{0,86},{-48,86},{-48,76},
          {-42,76}}, color={0,0,127}));
  connect(XAirIn, max.u2) annotation (Line(points={{-120,10},{-80,10},{-80,64},{
          -42,64}}, color={0,0,127}));
  connect(mWat_nominal.y, mW_flow.u1) annotation (Line(points={{-79,-50},{-70,-50},
          {-70,-44},{-62,-44}}, color={0,0,127}));
  connect(u, mW_flow.u2) annotation (Line(points={{-70,-104},{-70,-56},{-62,-56}},
        color={0,0,127}));
        annotation (
    preferredView="info",
    Documentation(info="<html><p>
  This model provides a partial humidifier. All water added to the air
  flow is binded in the air and leads to an increase of the absolute
  humidity.
</p>
</html>", revisions="<html>
<ul>
  <li>April 2020, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"),                  Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialHumidifier;
