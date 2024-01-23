within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model SourceIdealPumpErdeis
  "Simple supply node model with speed controled pump"
  extends
    AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Supplies.OpenLoop.PartialSupplyLessInputs(
      allowFlowReversal=true);

  parameter Modelica.SIunits.AbsolutePressure pReturn
    "Fixed return pressure";

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 5 "Nominal mass flow rate";

  parameter Modelica.SIunits.Velocity v_nominal = 1.5
    "Velocity at m_flow_nominal (used to compute default value for hydraulic diameter dh)"
    annotation(Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.PressureDifference dp_heater = 30000;

  parameter Modelica.SIunits.PressureDifference dp_pump = 300000;

  parameter Modelica.SIunits.Pressure dpRes_nominal(displayUnit="Bar")=0.11
    "Pressure difference of the resistance at nominal flow rate"
    annotation(Dialog(group="Resistance"));

  parameter Modelica.SIunits.Length dh(displayUnit="m")=sqrt(4*m_flow_nominal/rho_default/v_nominal/Modelica.Constants.pi)
    "Hydraulic pipe diameter"
    annotation(Dialog(group="Pipe"));

  parameter Modelica.SIunits.Length length(displayUnit="m")
    "Pipe length"
    annotation(Dialog(group="Pipe"));
  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));
  Modelica.Blocks.Interfaces.RealOutput Q_flow
    annotation (Placement(transformation(extent={{98,70},{118,90}})));

  Movers.FlowControlled_dp                 fan(        redeclare package Medium =
        Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    p_start=pReturn + 150000,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    m_flow_small=1E-4*abs(m_flow_nominal),
    redeclare Movers.Data.Generic per,
    init=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=1,
    dp_start(displayUnit="bar") = 300000,
    dp_nominal(displayUnit="bar") = 150000)
    annotation (Placement(transformation(extent={{6,90},{26,70}})));
  Modelica.Blocks.Interfaces.RealInput TIn "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-124,40},{-84,80}})));
  AixLib.Fluid.Sensors.DensityTwoPort senDen(redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
      m_flow_nominal=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,20})));
  AixLib.Fluid.HeatExchangers.Heater_T IdealHeater(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    dp_nominal(displayUnit="bar") = dp_heater)
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Modelica.Blocks.Interfaces.RealInput dpIn
                                           "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-124,-60},{-84,-20}})));
  FixedResistances.PressureDrop res1(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    dp_nominal(displayUnit="bar") = dpRes_nominal)
    annotation (Placement(transformation(extent={{-56,10},{-36,30}})));
  FixedResistances.PlugFlowPipe plugFlowPipe1(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    dh=dh,
    length=length,
    m_flow_nominal=m_flow_nominal,
    dIns=0.001,
    kIns=5,
    nPorts=1) annotation (Placement(transformation(extent={{-32,10},{-12,30}})));
  Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    p=pReturn,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={4,-4})));


equation
  Q_flow = (senT_supply.T - senT_return.T) * 4180 * senMasFlo.m_flow;
  connect(senDen.port_b, senT_supply.port_a)
    annotation (Line(points={{40,10},{40,0}}, color={0,127,255}));
  connect(senDen.port_a, IdealHeater.port_b) annotation (Line(points={{40,30},{40,
          60},{60,60},{60,80},{50,80}}, color={0,127,255}));
  connect(TIn, IdealHeater.TSet) annotation (Line(points={{-104,60},{-82,60},{-82,
          94},{28,94},{28,88}}, color={0,0,127}));
  connect(fan.port_b, IdealHeater.port_a)
    annotation (Line(points={{26,80},{30,80}},  color={0,127,255}));
  connect(dpIn, fan.dp_in) annotation (Line(points={{-104,-40},{16,-40},{16,68}},
                                  color={0,0,127}));
  connect(plugFlowPipe1.port_a, res1.port_b)
    annotation (Line(points={{-32,20},{-36,20}}, color={0,127,255}));
  connect(plugFlowPipe1.ports_b[1], bou.ports[1]) annotation (Line(points={{-12,
          20},{-4,20},{-4,6},{2,6}}, color={0,127,255}));
  connect(bou.ports[2], fan.port_a)
    annotation (Line(points={{6,6},{6,6},{6,80}}, color={0,127,255}));
  connect(res1.port_a, senT_return.port_b) annotation (Line(points={{-56,20},{
          -58,20},{-58,0},{-60,0}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-80,80},{80,0}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-80},{80,0}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.None),
              Ellipse(extent={{-58,60},{60,-60}},
  lineColor = {0, 0, 0}, fillColor = {0, 127, 0},
            fillPattern=FillPattern.Solid),
            Polygon(points={{-30,46},{52,0},{-30,-44},{-30,46}},
            lineColor = {0, 0, 0}, fillColor = {175, 175, 175},
            fillPattern=FillPattern.Solid)}),                    Diagram(
        coordinateSystem(preserveAspectRatio=false)), Documentation(revisions="<html><ul>
  <li>March 3, 2018, by Marcus Fuchs:<br/>
    Implemented for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 403</a>.
  </li>
</ul>
</html>", info="<html>
<p>
  This model represents the supply node with an ideal pressure source
  and sink. It provides a prescribed supply pressure and supply
  temperature to the network.
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end SourceIdealPumpErdeis;
