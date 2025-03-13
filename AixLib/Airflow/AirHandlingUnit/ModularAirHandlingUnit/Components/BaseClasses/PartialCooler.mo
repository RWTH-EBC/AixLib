within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses;
partial model PartialCooler
  "BaseClass for cooling heat exchangers in air handling units"
  extends Components.BaseClasses.PartialComponent;

  parameter Boolean use_T_set=false
    "if true, a set temperature is used to calculate the necessary heat flow rate";

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal(max=0) = -45E3
    "maximum cooling power of cooler (design point), has to be negative"
    annotation(Dialog(enable=not use_T_set));

  // Variables
  Modelica.Blocks.Interfaces.RealInput T_set if use_T_set annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));

  Modelica.Blocks.Interfaces.RealOutput Q_flow "heat flow rate"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealInput u(min=0,max=1) if not use_T_set
    "input connector scaling heat flow rate [0..1]"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));
  replaceable model PartialPressureDrop =
      Components.PressureDrop.BaseClasses.partialPressureDrop
      annotation(choicesAllMatching=true);

  PartialPressureDrop partialPressureDrop(
    final m_flow=mAirIn_flow,
    final rho=rhoAir,
    final dp_nominal=dp_nominal,
    final m_flow_nominal=m_flow_nominal);

protected
  Modelica.Units.SI.MassFlowRate mb_flow
    "mass flow over boundary";
  Modelica.Units.SI.HeatFlowRate Qb_flow
    "heat flow over boundary";
  Modelica.Blocks.Interfaces.RealInput T_intern
    "internal temperature";
  Modelica.Blocks.Interfaces.RealInput X_intern
    "internal mass fraction";
  Modelica.Blocks.Interfaces.RealInput u_intern
    "internal input connector for heat flow scaling";
  Modelica.Blocks.Math.Min minT if use_T_set
    annotation (Placement(transformation(extent={{-48,68},{-36,80}})));
equation

  // mass balances
  mAirIn_flow - mAirOut_flow = mb_flow;

  mDryAirIn_flow*(1 + XAirIn) = mAirIn_flow;
  mDryAirOut_flow - mDryAirIn_flow = 0;

  mb_flow =mDryAirIn_flow*(XAirOut - XAirIn);      // condensate

  // heat flows
  // Qb_flow = mDryAirOut_flow * hAirOut - mDryAirIn_flow * hAirIn + mb_flow * h_wat;
  Qb_flow = mDryAirOut_flow * hAirOut - mDryAirIn_flow * hAirIn;
  Q_flow = Qb_flow;
  if not use_T_set then
    Qb_flow = u_intern * Q_flow_nominal;
    T_intern =TAirIn;
  else
    TAirOut = T_intern;
    u_intern = 0;
  end if;

  partialPressureDrop.dp = dp;

  // conditional connectors
  connect(minT.y, T_intern);
  connect(u, u_intern);

  // connectors
  connect(T_set, minT.u1) annotation (Line(points={{0,110},{0,86},{-56,86},{-56,
          77.6},{-49.2,77.6}}, color={0,0,127}));
  connect(TAirIn, minT.u2) annotation (Line(points={{-120,40},{-80,40},{-80,70.4},
          {-49.2,70.4}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(
          points={{-100,94},{100,-94}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-100,-94},{100,94}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-92,-64},{-84,-64}},
          color={0,0,0},
          thickness=1)}),        Documentation(info="<html><p>
  This partial model provides a idealized heat exchanger. The model
  considers the convective heat transfer from the heat transfer surface
  in the air stream. Moreover the heat capacity of the heating surface
  and the housing of the heat exchanger is considered.
</p>
</html>", revisions="<html>
<ul>
  <li>April, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
  <li>August, 2019, by Martin Kremer:<br/>
    Added possibility to use set temperature.
  </li>
  <li>December, 2019, by Martin Kremer:<br/>
    Removed internal PID. Output temperature and humidity are now
    directly set to set temperature.
  </li>
</ul>
</html>"));
end PartialCooler;
