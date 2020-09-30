within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlantErdeis
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

  AixLib.Fluid.HeatExchangers.PrescribedOutlet heater(redeclare package Medium =
        Medium,
        allowFlowReversal=allowFlowReversal,
    QMin_flow=0,use_X_wSet=false,
    dp_nominal=dp_heater,
    m_flow_nominal=m_flow_nominal,
    use_TSet=true)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium,
        allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    tau=0)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Interfaces.RealInput TIn(unit="K")
    "Minimum supply temperature of the hot line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-126,22},{-86,62}})));
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
    nPorts=1)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    dp_nominal(displayUnit="bar") = dpRes_nominal)
    annotation (Placement(transformation(extent={{-76,-10},{-56,10}})));
equation
  connect(heater.port_b, senTem.port_a)
    annotation (Line(points={{20,0},{60,0}},   color={0,127,255}));
  connect(TIn, heater.TSet) annotation (Line(points={{-106,42},{-18,42},{-18,8},
          {-2,8}}, color={0,0,127}));
  connect(bou.ports[1], senTem.port_a) annotation (Line(points={{30,60},{30,0},
          {60,0}},              color={0,127,255}));
  connect(senTem.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
  connect(plugFlowPipe.ports_b[1], heater.port_a)
    annotation (Line(points={{-20,0},{0,0}}, color={0,127,255}));
  connect(port_a, res.port_a)
    annotation (Line(points={{-100,0},{-76,0}}, color={0,127,255}));
  connect(res.port_b, plugFlowPipe.port_a)
    annotation (Line(points={{-56,0},{-40,0}}, color={0,127,255}));
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
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
This model represents the supply node of a bidirectional network with indeal heater and ideal cooler. The operation mode of the depends on the flow direction.
In the case that port_b is the outlet, heating operation takes place. In the case that port_a is the outlet, cooling operation takes place.
</html>"));
end IdealPlantErdeis;
