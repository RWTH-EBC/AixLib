within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlantHybrPumpErdeis
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

  AixLib.Fluid.HeatExchangers.PrescribedOutlet heater(redeclare package Medium
      = Medium,
    QMin_flow=0,use_X_wSet=false,
    dp_nominal=dp_heater,
    m_flow_nominal=m_flow_nominal,
    use_TSet=true)
    annotation (Placement(transformation(extent={{40,70},{60,90}})));

  Modelica.Blocks.Interfaces.RealInput TIn(unit="K")
    "Minimum supply temperature of the hot line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-126,22},{-86,62}})));
  Sources.Boundary_pT bou(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-86,-50})));
  FixedResistances.PlugFlowPipe plugFlowPipe(
    redeclare package Medium = Medium,
    dh=0.7,
    length=1700,
    m_flow_nominal=m_flow_nominal,
    dIns=0.01,
    kIns=5,
    nPorts=2)
    annotation (Placement(transformation(extent={{6,70},{26,90}})));
  FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dpRes_nominal)
    annotation (Placement(transformation(extent={{-18,70},{2,90}})));
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
    annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
  Sensors.RelativePressure senRelPre
    annotation (Placement(transformation(extent={{-4,40},{16,60}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{98,-70},{118,-50}})));
  Sensors.RelativePressure senRelPre1
    annotation (Placement(transformation(extent={{-24,14},{2,34}})));
  Modelica.Blocks.Sources.Constant dpSet(k=dpPump_nominal)
    "Set pressure difference for substation" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={24,-44})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-30})));
  Modelica.Blocks.Sources.Constant dpSet1(k=0)
    "Set pressure difference for substation" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-56,-60})));
  Modelica.Blocks.Logical.LessThreshold    lessThreshold(   threshold=threshold)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-64})));
  parameter Real threshold=0 "Comparison with respect to threshold";
equation
  connect(TIn, heater.TSet) annotation (Line(points={{-106,42},{-44,42},{-44,88},
          {38,88}},color={0,0,127}));
  connect(plugFlowPipe.ports_b[1], heater.port_a)
    annotation (Line(points={{26,78},{40,78},{40,80}},
                                             color={0,127,255}));
  connect(fan.port_b, res.port_a)
    annotation (Line(points={{-30,0},{-30,80},{-18,80}}, color={0,127,255},
      thickness=0.5));
  connect(senRelPre.p_rel, dpOut) annotation (Line(points={{6,41},{6,-60},{108,-60}},
                           color={0,0,127}));
  connect(fan.port_a, senT_return.port_b) annotation (Line(points={{-50,0},{-60,
          0}},                  color={0,127,255},
      thickness=0.5));
  connect(bou.ports[1], senT_return.port_a) annotation (Line(points={{-86,-40},{
          -88,-40},{-88,0},{-80,0}}, color={0,127,255}));
  connect(dpSet1.y, switch1.u1)
    annotation (Line(points={{-56,-49},{-56,-42},{-28,-42}}, color={0,0,127}));
  connect(senRelPre.p_rel, lessThreshold.u)
    annotation (Line(points={{6,41},{6,-76},{-20,-76}}, color={0,0,127}));
  connect(lessThreshold.y, switch1.u2)
    annotation (Line(points={{-20,-53},{-20,-42}}, color={255,0,255}));
  connect(heater.port_b, senT_supply.port_a) annotation (Line(
      points={{60,80},{80,80},{80,40},{40,40},{40,0}},
      color={0,127,255},
      thickness=0.5));
  connect(senRelPre.port_a, res.port_a) annotation (Line(
      points={{-4,50},{-30,50},{-30,80},{-18,80}},
      color={0,127,255},
      thickness=0.5));
  connect(senRelPre.port_b, heater.port_a) annotation (Line(
      points={{16,50},{32,50},{32,80},{40,80}},
      color={0,127,255},
      thickness=0.5));
  connect(res.port_b, plugFlowPipe.port_a)
    annotation (Line(points={{2,80},{6,80}}, color={0,127,255}));
  connect(senRelPre1.port_b, plugFlowPipe.ports_b[2]) annotation (Line(
      points={{2,24},{32,24},{32,82},{26,82}},
      color={0,127,255},
      thickness=0.5));
  connect(senRelPre1.port_a, senT_return.port_b) annotation (Line(
      points={{-24,24},{-56,24},{-56,0},{-60,0}},
      color={0,127,255},
      thickness=0.5));
  connect(switch1.y, fan.dp_in)
    annotation (Line(points={{-20,-19},{-40,-19},{-40,-12}}, color={0,0,127}));
  connect(dpSet.y, switch1.u3) annotation (Line(points={{13,-44},{0,-44},{0,-42},
          {-12,-42}}, color={0,0,127}));
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
