within AixLib.Systems.HydraulicModules;
model SimpleConsumer "Simple Consumer"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;
  import SI=Modelica.SIunits;

  parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]" annotation (Dialog(enable = functionality=="T_fixed" or functionality=="T_input"));
  parameter SI.Temperature T_fixed=293.15  "Ambient temperature for convection" annotation (Dialog(enable = functionality=="T_fixed"));
  parameter SI.HeatCapacity capacity=1 "Capacity of the material";
  parameter SI.Volume V=0.001 "Volume of water";
  parameter SI.HeatFlowRate Q_flow_fixed = 0 "Prescribed heat flow" annotation (Dialog(enable = functionality=="Q_flow_fixed"));
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter SI.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate";
  parameter SI.Temperature T_start
    "Initialization temperature" annotation(Dialog(tab="Advanced"));
  parameter String functionality "Choose between different functionalities" annotation (choices(
              choice="T_fixed",
              choice="T_input",
              choice="Q_flow_fixed",
              choice="Q_flow_input"),Dialog(enable=true));
  parameter Integer demandType=1 "Choose between heating and cooling functionality" annotation (choices(
              choice=1 "use as heating consumer",
              choice=-1 "use as cooling consumer"),Dialog(enable=true));

  Fluid.MixingVolumes.MixingVolume volume(
    final V=V,
    final T_start=T_start,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nPorts=2)                          annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,10})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                          T(start=T_start, fixed=true), C=capacity)
    annotation (Placement(transformation(
        origin={44,40},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection if
    functionality == "T_input" or functionality == "T_fixed"
    annotation (Placement(transformation(
        origin={10,70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature if functionality == "T_input" or functionality == "T_fixed"
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,80})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=kA) if functionality == "T_input"
     or functionality == "T_fixed"                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,78})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_fixed) if
    functionality == "T_fixed"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,80})));
  Modelica.Blocks.Interfaces.RealInput T if functionality == "T_input"
                                         annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow if
    functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-12,40})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=Q_flow_fixed) if
    functionality == "Q_flow_fixed"                           annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,80})));
  Modelica.Blocks.Interfaces.RealInput Q_flow if functionality == "Q_flow_input"
    "Consumed heat flow, positive for heating or cooling"
                                              annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
  Fluid.Movers.SpeedControlled_y     pump(
    redeclare package Medium = Medium,
    T_start=T_start,
    allowFlowReversal=allowFlowReversal,
    redeclare Fluid.Movers.Data.Generic per(pressure(V_flow={0,m_flow_nominal/
            1000,m_flow_nominal/500}, dp={dp_nominalPumpConsumer/0.8,
            dp_nominalPumpConsumer,0}), motorCooledByFluid=false),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-40,10},{-20,-10}})));



  parameter SI.PressureDifference dp_nominalPumpConsumer=if pump.rho_default < 500
       then 500 else 10000
    "Nominal pressure raise, used for default pressure curve if not specified in record per";
  Modelica.Blocks.Continuous.LimPID PIPump(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k_ControlConsumerPump,
    Ti=Ti_ControlConsumerPump,
    yMax=1,
    yMin=0,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=1) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,-40})));
  Fluid.Sensors.TemperatureTwoPort senTemReturn(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start)
                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={50,0})));
  Fluid.Sensors.TemperatureTwoPort senTemFlow(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-62,0})));
  parameter Real k_ControlConsumerPump "Gain of controller";
  parameter SI.Time Ti_ControlConsumerPump
    "Time constant of Integrator block";
  Modelica.Blocks.Interfaces.RealInput T_returnSet annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Math.Gain gain2(k=demandType)
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Math.Gain gain(k=demandType)
    "Used to reverse direction of operation of controller"
    annotation (Placement(transformation(extent={{20,-70},{0,-50}})));
  Modelica.Blocks.Math.Gain gain1(k=-demandType) if functionality == "Q_flow_input"
     or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-42,40})));
equation
  connect(volume.heatPort,heatCapacitor. port) annotation (Line(points={{10,10},
          {10,40},{34,40}},               color={191,0,0},
      pattern=LinePattern.Dash));
  connect(heatCapacitor.port,convection. solid) annotation (Line(points={{34,40},
          {10,40},{10,60}},              color={191,0,0}));
  connect(convection.fluid,prescribedTemperature. port)
    annotation (Line(points={{10,80},{30,80}},   color={191,0,0},
      pattern=LinePattern.Dash));
  connect(realExpression.y,convection. Gc)
    annotation (Line(points={{-19,78},{-10,78},{-10,70},{0,70}},
                                               color={0,0,127}));
  connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{79,80},{52,80}},         color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedTemperature.T, T)
    annotation (Line(points={{52,80},{60,80},{60,120}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(prescribedHeatFlow.port, heatCapacitor.port)
    annotation (Line(points={{-2,40},{34,40}},           color={191,0,0},
      pattern=LinePattern.Dash));
  connect(volume.ports[1], pump.port_b)
    annotation (Line(points={{2,0},{-20,0}},  color={0,127,255}));
  connect(volume.ports[2], senTemReturn.port_a)
    annotation (Line(points={{-2,0},{40,0}}, color={0,127,255}));
  connect(port_b, senTemReturn.port_b)
    annotation (Line(points={{100,0},{60,0}}, color={0,127,255}));
  connect(port_a, senTemFlow.port_a)
    annotation (Line(points={{-100,0},{-72,0}}, color={0,127,255}));
  connect(pump.port_a, senTemFlow.port_b) annotation (Line(points={{-40,0},{-52,
          0}},                 color={0,127,255}));
  connect(PIPump.y, pump.y)
    annotation (Line(points={{-39,-40},{-30,-40},{-30,-12}},
                                                          color={0,0,127}));
  connect(PIPump.u_s, gain2.y)
    annotation (Line(points={{-62,-40},{-79,-40}}, color={0,0,127}));
  connect(senTemReturn.T, gain.u)
    annotation (Line(points={{50,-11},{50,-60},{22,-60}}, color={0,0,127}));
  connect(gain.y, PIPump.u_m)
    annotation (Line(points={{-1,-60},{-50,-60},{-50,-52}}, color={0,0,127}));
  connect(Q_flow, gain1.u) annotation (Line(
      points={{-60,120},{-60,40},{-54,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(realExpression2.y, gain1.u) annotation (Line(
      points={{-79,80},{-60,80},{-60,40},{-54,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gain1.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-31,40},{-22,40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gain2.u, T_returnSet) annotation (Line(points={{-102,-40},{-120,-40},
          {-120,90},{0,90},{0,120}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                   Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-56,18},{56,-18}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="CONSUMER")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  Model with a simple consumer. The consumed power depends either on
  the temperature (T_fixed or T_input) and the convective coefficient
  kA or the power is prescribed (Q_flow_input or _Q_flow_fixed). It is
  possible to choose between these options with the parameter
  \"functionality\".
</p>
</html>", revisions="<html>
<ul>
  <li>August 31, 2020, by Alexander Kümpel:<br/>
    Remove pipes
  </li>
  <li>October 31, 2019, by Alexander Kümpel:<br/>
    Add more options
  </li>
  <li>October 25, 2017, by Alexander Kümpel:<br/>
    Transfer from ZUGABE to AixLib
  </li>
  <li>
    <i>2016-03-06 &#160;</i> by Peter Matthes:<br/>
    added documentation
  </li>
  <li>
    <i>2016-02-17 &#160;</i> by Rohit Lad:<br/>
    implemented simple consumers model
  </li>
</ul>
</html>"));
end SimpleConsumer;
