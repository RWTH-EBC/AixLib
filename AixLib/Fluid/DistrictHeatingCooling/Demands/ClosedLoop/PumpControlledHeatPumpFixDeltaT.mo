within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledHeatPumpFixDeltaT
  "Substation with variable dT and Heat Pump"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    final m_flow(start=0),
    final dp(start=0),
    allowFlowReversal=true,
    m_flow_nominal = (Q_flow_nominal*(1 - 1 / 3.5))/(cp_default * dTDesign));

  replaceable package MediumBuilding =
    Modelica.Media.Interfaces.PartialMedium
      "Medium in the building heating system"
      annotation (choicesAllMatching = true);

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal(
    min=0) "Nominal heat flow rate added to medium (Q_flow_nominal > 0)";

  parameter Modelica.SIunits.TemperatureDifference dTBuilding(
    displayUnit="K")
    "Design temperature difference for the building's heating system";

  parameter Modelica.SIunits.Temperature TSupplyBuilding
    "Fixed supply temperature for the building heating system";

  parameter Modelica.SIunits.Temperature TReturn
    "Fixed return temperature";

  parameter Modelica.SIunits.TemperatureDifference dTDesign(
    displayUnit="K")
    "Design temperature difference for the heat pump on its district heating side";

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

    // Control Parameters
  parameter Real k=0.002 "Gain of controller";
  parameter Modelica.SIunits.Time Ti=7 "Time constant of Integrator block";
  parameter Real yMax=m_flow_nominal "Upper limit of output";
  parameter Real yMin=0.01 "Lower limit of output";
  parameter Real y_start=0.3 "Initial value of output";

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
        Medium,
    allowFlowReversal=allowFlowReversal,
                m_flow_nominal=m_flow_nominal) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium =
        Medium,
    allowFlowReversal=allowFlowReversal,
                m_flow_nominal=m_flow_nominal) "Return flow temperature sensor"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Constant delT(k=dTDesign)
    "Temperature difference of substation" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,50})));
  Sources.Boundary_pT                sinkHeating(redeclare package Medium =
        MediumBuilding, nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-38})));
  HeatPumps.Carnot_TCon              heaPum(
    redeclare package Medium1 = MediumBuilding,
    allowFlowReversal1=allowFlowReversal,
    allowFlowReversal2=allowFlowReversal,
    dTEva_nominal=dTEva_nominal,
    dTCon_nominal=dTCon_nominal,
    COP_nominal=3.8,
    TCon_nominal=306.15,
    TEva_nominal=277.65,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=false,
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
        origin={48,-74})));
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
    k=k,
    Ti=Ti,
    Td=0.1,
    yMax=yMax,
    yMin=yMin,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=y_start)  "Pressure controller" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={4,42})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{64,22},{44,42}})));
  Modelica.Blocks.Sources.Constant T_HeaPumpOff(k=-20)
    annotation (Placement(transformation(extent={{-38,-72},{-30,-64}})));
  Utilities.Logical.SmoothSwitch switch1 annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={-8,-66})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=Q_flow_input >
        500.0)
    annotation (Placement(transformation(extent={{-46,-96},{-26,-76}})));
  Utilities.Logical.SmoothSwitch switch2 annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=-90,
        origin={20,-90})));
  Modelica.Blocks.Interfaces.RealOutput COP = if heaPum.P > 0.0
    then heaPum.COP
 else
     0.0
    annotation (Placement(transformation(extent={{98,84},{118,104}})));
  parameter Modelica.SIunits.TemperatureDifference dTEva_nominal=-10
    "Temperature difference evaporator outlet-inlet";
  parameter Modelica.SIunits.TemperatureDifference dTCon_nominal=10
    "Temperature difference condenser outlet-inlet";
  Modelica.Blocks.Sources.RealExpression realExpression(y=0.5/(
        cp_default_building*dTBuilding))
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Movers.FlowControlled_m_flow              pumpHeating(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    m_flow_nominal=m_flow_nominal,
    redeclare Movers.Data.Generic per,
    addPowerToMedium=false,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));

equation

  dpOut = dp;

  connect(port_a, senT_supply.port_a) annotation (Line(points={{-100,0},{-80,0}},
                                color={0,127,255}));
  connect(port_b, senT_return.port_b) annotation (Line(points={{100,0},{80,0}},
                          color={0,127,255}));
  connect(sinkHeating.ports[1], heaPum.port_b1) annotation (Line(points={{-20,-28},
          {-21,-28},{-21,-12},{-12,-12}}, color={0,127,255}));
  connect(sourceHeating.ports[1], heaPum.port_a1)
    annotation (Line(points={{20,-30},{20,-12},{8,-12}}, color={0,127,255}));
  connect(deltaTBuilding.y, temperatureReturnBuilding.u2)
    annotation (Line(points={{71,-80},{60,-80}}, color={0,0,127}));
  connect(temperatureSupplyBuilding.y, temperatureReturnBuilding.u1)
    annotation (Line(points={{71,-40},{60,-40},{60,-68}},          color={0,0,127}));
  connect(heaPum.port_b2, senT_return.port_a)
    annotation (Line(points={{8,0},{60,0}}, color={0,127,255}));
  connect(Q_flow_input, mFlowBuilding.u)
    annotation (Line(points={{-108,80},{-68,80}}, color={0,0,127}));
  connect(pControl.u_m, senT_return.T) annotation (Line(points={{4,30},{36,30},
          {36,11},{70,11}}, color={0,0,127}));
  connect(add.y, pControl.u_s) annotation (Line(points={{43,32},{30,32},{30,42},
          {16,42}}, color={0,0,127}));
  connect(senT_supply.T, add.u2) annotation (Line(points={{-70,11},{-70,24},{66,
          24},{66,26}}, color={0,0,127}));
  connect(delT.y, add.u1) annotation (Line(points={{79,50},{72,50},{72,38},{66,
          38}}, color={0,0,127}));
  connect(switch1.u3, T_HeaPumpOff.y) annotation (Line(points={{-14.4,-75.6},{
          -14.4,-68},{-29.6,-68}},
                            color={0,0,127}));
  connect(booleanExpression.y, switch1.u2) annotation (Line(points={{-25,-86},{
          -8,-86},{-8,-75.6}},
                            color={255,0,255}));
  connect(mFlowBuilding.y, switch2.u1) annotation (Line(points={{-45,80},{36,80},
          {36,-99.6},{26.4,-99.6}}, color={0,0,127}));
  connect(booleanExpression.y, switch2.u2) annotation (Line(points={{-25,-86},{
          -8,-86},{-8,-99.6},{20,-99.6}}, color={255,0,255}));
  connect(switch2.y, sourceHeating.m_flow_in) annotation (Line(points={{20,
          -81.2},{28,-81.2},{28,-52}}, color={0,0,127}));
  connect(temperatureSupplyBuilding.y, switch1.u1) annotation (Line(points={{71,
          -40},{-1.6,-40},{-1.6,-75.6}}, color={0,0,127}));
  connect(switch1.y, heaPum.TSet) annotation (Line(points={{-8,-57.2},{2,-57.2},
          {2,-15},{10,-15}}, color={0,0,127}));
  connect(temperatureReturnBuilding.y, sourceHeating.T_in) annotation (Line(
        points={{37,-74},{24,-74},{24,-52}},          color={0,0,127}));
  connect(realExpression.y, switch2.u3) annotation (Line(points={{-29,-100},{-8,
          -100},{-8,-99.6},{13.6,-99.6}}, color={0,0,127}));
  connect(senT_supply.port_b, pumpHeating.port_a)
    annotation (Line(points={{-60,0},{-48,0}}, color={0,127,255}));
  connect(pumpHeating.port_b, heaPum.port_a2)
    annotation (Line(points={{-28,0},{-12,0}}, color={0,127,255}));
  connect(pControl.y, pumpHeating.
  m_flow_in) annotation (Line(points={{-7,42},{
          -22,42},{-22,12},{-38,12}}, color={0,0,127}));
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
<ul>
  <li>March 3, 2018, by Marcus Fuchs:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end PumpControlledHeatPumpFixDeltaT;
