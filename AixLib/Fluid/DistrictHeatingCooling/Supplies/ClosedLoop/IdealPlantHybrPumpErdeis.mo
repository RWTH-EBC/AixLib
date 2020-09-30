within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlantHybrPumpErdeis
  "Supply node model with ideal heater and cooler for heat and cold supply of bidirectional networks"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

      parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
      "Nominal pressure drop";
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal "Nominal mass flow rate";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the cold line of the network"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the ideal plant to the warm line of the network"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet heater(redeclare package Medium
      = Medium,
    QMin_flow=0,use_X_wSet=false,
    dp_nominal=dp_nominal,
    m_flow_nominal=m_flow_nominal,
    use_TSet=true)
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium,
    m_flow_nominal=m_flow_nominal,
    tau=0)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Interfaces.RealInput TIn(unit="K")
    "Minimum supply temperature of the hot line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-126,22},{-86,62}})));
  Sources.Boundary_pT bou(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-86,-50})));
  FixedResistances.PlugFlowPipe plugFlowPipe(
    redeclare package Medium = Medium,
    dh=0.1,
    length=1700,
    m_flow_nominal=m_flow_nominal,
    dIns=0.01,
    kIns=5,
    nPorts=1)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=35000)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  Movers.FlowControlled_dp fan(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    p_start=bou.p,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    addPowerToMedium=false,
    tau=1,
    y_start=1,
    dp_start=fan.dp_nominal,
    dp_nominal=dpPump_nominal)
    annotation (Placement(transformation(extent={{-70,-14},{-50,-34}})));
  Actuators.Valves.TwoWayPressureIndependent valve(
    redeclare package Medium = Medium,
    allowFlowReversal=true,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=1.2e5,
    y_start=pControl.y_start,
    l2=1e-9,
    l=0.05) "Control valve"
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
equation
  connect(heater.port_b, senTem.port_a)
    annotation (Line(points={{52,0},{60,0}},   color={0,127,255}));
  connect(TIn, heater.TSet) annotation (Line(points={{-106,42},{24,42},{24,8},{
          30,8}},  color={0,0,127}));
  connect(senTem.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
  connect(plugFlowPipe.ports_b[1], heater.port_a)
    annotation (Line(points={{12,0},{32,0}}, color={0,127,255}));
  connect(res.port_b, plugFlowPipe.port_a)
    annotation (Line(points={{-24,0},{-8,0}},  color={0,127,255}));
  connect(fan.port_b, res.port_a)
    annotation (Line(points={{-50,-24},{-50,0},{-44,0}}, color={0,127,255}));
  connect(fan.port_b, valve.port_b)
    annotation (Line(points={{-50,-24},{-50,0}}, color={0,127,255}));
  connect(valve.port_b, res.port_a)
    annotation (Line(points={{-50,0},{-44,0}}, color={0,127,255}));
  connect(valve.port_a, port_a)
    annotation (Line(points={{-70,0},{-100,0}}, color={0,127,255}));
  connect(fan.port_a, valve.port_a)
    annotation (Line(points={{-70,-24},{-70,0}}, color={0,127,255}));
  connect(bou.ports[1], port_a) annotation (Line(points={{-86,-40},{-88,-40},{
          -88,0},{-100,0}}, color={0,127,255}));
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
end IdealPlantHybrPumpErdeis;
