within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model ValveControlledHeatPump
  "Substation with variable dT and Heat Pump"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow(start=0),
    final dp(start=0),
    final allowFlowReversal=false,
    final m_flow_nominal = Q_flow_nominal/cp_default/dTDesign);


  replaceable package MediumBuilding =
    Modelica.Media.Interfaces.PartialMedium
      "Medium in the building heating system"
      annotation (choicesAllMatching = true);

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal(
    min=0) "Nominal heat flow rate added to medium (Q_flow_nominal > 0)";

  parameter Modelica.SIunits.TemperatureDifference dTDesign(
    displayUnit="K")
    "Design temperature difference for the substation's heat exchanger";

  parameter Modelica.SIunits.TemperatureDifference dTBuilding(
    displayUnit="K")
    "Design temperature difference for the building's heating system";

  parameter Modelica.SIunits.Temperature TSupplyBuilding
    "Fixed supply temperature for the building heating system";

  parameter Modelica.SIunits.Temperature TReturn
    "Fixed return temperature";

  parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
    "Pressure difference at nominal flow rate"
    annotation(Dialog(group="Design parameter"));

  parameter Real deltaM=0.1
    "Fraction of nominal flow rate where flow transitions to laminar"
    annotation (Dialog(tab="Flow resistance"));
  parameter Modelica.SIunits.Time tau=30
    "Time constant at nominal flow (if energyDynamics <> SteadyState)"
    annotation (Dialog(tab="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics"));

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default_building=
    MediumBuilding.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid in the building heating system";
public
  Modelica.Blocks.Interfaces.RealInput Q_flow_input "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Sensors.TemperatureTwoPort              senT_supply(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Constant temperatureReturn(k=TReturn)
    "Temperature of return line in °C"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={70,60})));
  Actuators.Valves.TwoWayPressureIndependent valve(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=50000,
    l2=1e-9,
    l=0.05) "Control valve"
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  Sources.Boundary_pT                sinkHeating(redeclare package Medium =
        MediumBuilding, nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-38})));
  HeatPumps.Carnot_TCon              heaPum(
    redeclare package Medium1 = MediumBuilding,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    etaCarnot_nominal=0.3,
    show_T=true,
    redeclare package Medium2 = Medium,
    QCon_flow_nominal=Q_flow_nominal)
    annotation (Placement(transformation(extent={{8,4},{-12,-16}})));
  Sources.MassFlowSource_T              sourceHeating(
    use_m_flow_in=true,
    redeclare package Medium = MediumBuilding,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={20,-40})));
  Modelica.Blocks.Math.Add temperatureReturnBuilding(k2=-1)
    "Temperature returning from building heating system" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={40,-74})));
  Modelica.Blocks.Sources.Constant temperatureSupplyBuilding(k=TSupplyBuilding)
    "Temperature of supply line" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={82,-40})));
  Modelica.Blocks.Sources.Constant deltaTBuilding(k=dTBuilding)
    "Temperature difference in building heating system" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={82,-80})));
  Modelica.Blocks.Math.Gain mFlowBuilding(k=1/(cp_default_building*dTBuilding))
    "Changes sign of prescribed flow for extraction from network" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,80})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    "Output signal of pressure difference"
    annotation (Placement(transformation(extent={{98,70},{118,90}})));
  Modelica.Blocks.Continuous.LimPID pControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0.1)         "Pressure controller" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={4,42})));
equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-80,0}},
                                color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{80,0}},
                          color={0,127,255}));
  connect(senT_supply.port_b, valve.port_a)
    annotation (Line(points={{-60,0},{-48,0}},     color={0,127,255}));
  connect(sinkHeating.ports[1], heaPum.port_b1) annotation (Line(points={{-20,-28},
          {-21,-28},{-21,-12},{-12,-12}}, color={0,127,255}));
  connect(sourceHeating.ports[1], heaPum.port_a1)
    annotation (Line(points={{20,-30},{20,-12},{8,-12}}, color={0,127,255}));
  connect(sourceHeating.T_in, temperatureReturnBuilding.y)
    annotation (Line(points={{24,-52},{24,-74},{29,-74}}, color={0,0,127}));
  connect(deltaTBuilding.y, temperatureReturnBuilding.u2)
    annotation (Line(points={{71,-80},{52,-80}}, color={0,0,127}));
  connect(temperatureSupplyBuilding.y, temperatureReturnBuilding.u1)
    annotation (Line(points={{71,-40},{60,-40},{60,-68},{52,-68}}, color={0,0,127}));
  connect(heaPum.port_a2, valve.port_b)
    annotation (Line(points={{-12,0},{-28,0}}, color={0,127,255}));
  connect(heaPum.port_b2, senT_return.port_a)
    annotation (Line(points={{8,0},{60,0}}, color={0,127,255}));
  connect(temperatureSupplyBuilding.y, heaPum.TSet) annotation (Line(points={{71,
          -40},{59.5,-40},{59.5,-15},{10,-15}}, color={0,0,127}));
  connect(sourceHeating.m_flow_in, mFlowBuilding.y) annotation (Line(points={{28,
          -52},{28,-56},{40,-56},{40,80},{-45,80}}, color={0,0,127}));
  connect(Q_flow_input, mFlowBuilding.u)
    annotation (Line(points={{-108,80},{-68,80}}, color={0,0,127}));
  connect(pControl.u_s, temperatureReturn.y) annotation (Line(points={{16,42},{
          32,42},{32,60},{59,60}}, color={0,0,127}));
  connect(pControl.u_m, senT_return.T) annotation (Line(points={{4,30},{36,30},
          {36,11},{70,11}}, color={0,0,127}));
  connect(pControl.y, valve.y)
    annotation (Line(points={{-7,42},{-38,42},{-38,12}}, color={0,0,127}));
  annotation ( Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                     graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-42,-4},{-14,24}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{16,-4},{44,24}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{16,-54},{44,-26}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
      Rectangle(
        extent={{-42,-54},{-14,-26}},
        lineColor={255,255,255},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{52,70},{96,50}},
          lineColor={0,0,127},
          textString="PPum"),             Polygon(
          points={{-86,38},{-86,-42},{-26,-2},{-86,38}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
                             Ellipse(
          extent={{-8,40},{72,-40}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html><p>
  A simple substation model using a fixed return temperature and the
  actual supply temperature to calculate the mass flow rate drawn from
  the network. This model uses a linear control valve to set the mass
  flow rate. Please consider that this model is still in an early
  testing stage. The behavior is not verified. It seems that behavior
  may be problematic for low demands. In such cases, the actual mass
  flow rate differs significantly from the set value.
</p>
</html>", revisions="<html>
<ul>
  <li>March 3, 2018, by Marcus Fuchs:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end ValveControlledHeatPump;
