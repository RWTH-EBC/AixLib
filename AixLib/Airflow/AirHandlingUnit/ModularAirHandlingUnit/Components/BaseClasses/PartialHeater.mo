within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses;
partial model PartialHeater
  "BaseClass for heat exchangers in air handling units"
  extends Components.BaseClasses.PartialComponent;

  parameter Boolean use_T_set=false
    "if true, a set temperature is used to calculate the necessary heat flow rate";

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal = 45E3
    "maximum heat output of heater at design point. Only used, if use_T_set = true"
    annotation (Dialog(enable=not use_T_set));

  // Variables
  Modelica.Blocks.Interfaces.RealInput T_set(start=293.15) if use_T_set
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,100})));

  Modelica.Blocks.Interfaces.RealOutput Q_flow "heat flow rate"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealInput u(min=0, max=1)
    if not use_T_set "input connector scaling heat flow rate [0..1]" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={48,110}), iconTransformation(
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
  Modelica.Units.SI.HeatFlowRate Qb_flow "heat flow over boundary";

  parameter Real Q_in=0 "dummy heat flow rate, if use_T_set = false";
  Modelica.Blocks.Interfaces.RealInput Q_in_internal "internal heat flow rate";
  Modelica.Blocks.Interfaces.RealInput T_internal "internal temperature";
  Modelica.Blocks.Math.Max max if use_T_set
    annotation (Placement(transformation(extent={{-18,74},{-8,84}})));
  Modelica.Blocks.Sources.Constant Q_nominal(k=Q_flow_nominal) if not use_T_set
    annotation (Placement(transformation(extent={{12,40},{32,60}})));
  Modelica.Blocks.Math.Product product1 if not use_T_set
    annotation (Placement(transformation(extent={{52,22},{72,42}})));
equation

  // mass balances
  mAirIn_flow - mAirOut_flow = 0;
  mDryAirIn_flow - mDryAirOut_flow = 0;
  mDryAirIn_flow*(1 + XAirIn) = mAirIn_flow;

  // heat flows
  Qb_flow = mDryAirOut_flow * hAirOut - mDryAirIn_flow * hAirIn;
  Q_flow = Qb_flow;

  Qb_flow = Q_in_internal;

  TAirOut = T_internal;

  partialPressureDrop.dp = dp;

  // Conditional connectors
  connect(max.y,T_internal);
  connect(product1.y, Q_in_internal);

  // Connectors
  connect(T_set, max.u1) annotation (Line(points={{0,110},{0,88},{-22,88},{-22,82},
          {-19,82}}, color={0,0,127}));
  connect(TAirIn, max.u2) annotation (Line(points={{-120,40},{-80,40},{-80,76},{
          -19,76}}, color={0,0,127}));
  connect(Q_nominal.y, product1.u1) annotation (Line(points={{33,50},{42,50},{42,
          38},{50,38}}, color={0,0,127}));
  connect(u, product1.u2) annotation (Line(points={{48,110},{48,82},{42,82},{42,
          26},{50,26}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(
          points={{-100,94},{100,-94}},
          color={0,0,0},
          thickness=0.5),
                        Line(
          points={{-76,-74},{-60,-74}},
          color={0,0,0},
          thickness=1),      Line(
          points={{-68,-66},{-68,-82}},
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
    Removed internal PID. Output temperature is now directly set to set
    temperature.
  </li>
</ul>
</html>"));
end PartialHeater;
