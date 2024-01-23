within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlantErdeisFMU
  "Supply node model with ideal heater and cooler for heat and cold supply of bidirectional networks"
  extends
    AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Supplies.OpenLoop.PartialSupplyLessInputs(
      allowFlowReversal=true);

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
      "Nominal pressure drop";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal "Nominal mass flow rate";

  parameter Modelica.SIunits.PressureDifference dp_heater = 30000;

  parameter Modelica.SIunits.Pressure dpRes_nominal(displayUnit="Bar")=0.11
    "Pressure difference of the resistance at nominal flow rate"
    annotation(Dialog(group="Resistance"));

  parameter Modelica.SIunits.Velocity v_nominal = 1.5
    "Velocity at m_flow_nominal (used to compute default value for hydraulic diameter dh)"
    annotation(Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));

  parameter Modelica.SIunits.Length dh(displayUnit="m")=sqrt(4*m_flow_nominal/rho_default/v_nominal/Modelica.Constants.pi)
    "Hydraulic pipe diameter"
    annotation(Dialog(group="Pipe"));

  parameter Modelica.SIunits.Length length(displayUnit="m")
    "Pipe length"
    annotation(Dialog(group="Pipe"));

protected
  AixLib.Fluid.HeatExchangers.PrescribedOutlet heater(redeclare package Medium =
        Medium,
        allowFlowReversal=allowFlowReversal,
    QMin_flow=0,use_X_wSet=false,
    dp_nominal=dp_heater,
    m_flow_nominal=m_flow_nominal,
    use_TSet=true)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
public
  Modelica.Blocks.Interfaces.RealInput TIn(unit="K")
    "Minimum supply temperature of the hot line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-126,22},{-86,62}})));
protected
  Sources.Boundary_pT bou(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={30,70})));
  FixedResistances.PlugFlowPipe plugFlowPipe(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    dh=0.7,
    length=1700,
    m_flow_nominal=m_flow_nominal,
    dIns=0.01,
    kIns=5,
    nPorts=2)
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    dp_nominal(displayUnit="bar") = dpRes_nominal)
    annotation (Placement(transformation(extent={{-54,-10},{-34,10}})));
public
  Sensors.RelativePressure senRelPre
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{96,-70},{116,-50}})));
  Modelica.Blocks.Interfaces.RealOutput T_return
    annotation (Placement(transformation(extent={{96,70},{116,90}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
equation
  connect(TIn, heater.TSet) annotation (Line(points={{-106,42},{-8,42},{-8,8},{
          -2,8}},  color={0,0,127}));
  connect(senRelPre.p_rel, dpOut) annotation (Line(points={{-30,-49},{4,-49},{4,
          -60},{106,-60}}, color={0,0,127}));
  connect(plugFlowPipe.port_a, res.port_b)
    annotation (Line(points={{-28,0},{-34,0}}, color={0,127,255}));
  connect(senT_return.port_b, res.port_a)
    annotation (Line(points={{-60,0},{-54,0}}, color={0,127,255}));
  connect(plugFlowPipe.ports_b[1], heater.port_a) annotation (Line(points={{-8,
          -2},{-4,-2},{-4,0},{0,0}}, color={0,127,255}));
  connect(plugFlowPipe.ports_b[2], senRelPre.port_b)
    annotation (Line(points={{-8,2},{-8,-40},{-20,-40}}, color={0,127,255}));
  connect(res.port_a, senRelPre.port_a)
    annotation (Line(points={{-54,0},{-54,-40},{-40,-40}}, color={0,127,255}));
  connect(heater.port_b, senT_supply.port_a)
    annotation (Line(points={{20,0},{40,0}}, color={0,127,255}));
  connect(bou.ports[1], senT_supply.port_a) annotation (Line(points={{30,60},{
          32,60},{32,0},{40,0}}, color={0,127,255}));
  connect(senT_return.T, T_return) annotation (Line(points={{-70,11},{-68,11},{
          -68,90},{80,90},{80,80},{106,80}}, color={0,0,127}));
  connect(senMasFlo.m_flow, m_flow)
    annotation (Line(points={{80,11},{80,60},{106,60}}, color={0,0,127}));
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
          fillPattern=FillPattern.None)}),                       Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>August 09, 2018</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
This model represents the supply node of a bidirectional network with
indeal heater and ideal cooler. The operation mode of the depends on
the flow direction. In the case that port_b is the outlet, heating
operation takes place. In the case that port_a is the outlet, cooling
operation takes place.
</html>"));
end IdealPlantErdeisFMU;
