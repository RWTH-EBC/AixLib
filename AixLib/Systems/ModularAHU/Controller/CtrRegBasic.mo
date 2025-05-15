within AixLib.Systems.ModularAHU.Controller;
block CtrRegBasic "Controller for heating and cooling registers"
  //Boolean choice;

  parameter Boolean useExternalTset = false "If True, set temperature can be given externally";
  parameter Boolean useExternalTMea = false "If True, measured temperature can be given externally";
  parameter Modelica.Units.SI.Temperature TflowSet = 293.15 "Flow temperature set point of consumer" annotation (Dialog(enable=
          useExternalTset == false));
  parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small)=130
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time Td(min=0) = 4
    "Time constant of Derivative block";
  parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the Pump";
  parameter Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(group="PID"));
  parameter Boolean reverseAction = true
    "Set to true if a heating coil, and false if a cooling coil is controlled";
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(group="PID"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation(Dialog(group="PID"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(group="PID"));
  Modelica.Blocks.Interfaces.RealInput Tset if useExternalTset
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  AixLib.Controls.Continuous.LimPID PID(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    final k=k,
    final Ti=Ti,
    final Td=Td,
    final initType=initType,
    final xi_start=xi_start,
    final xd_start=xd_start,
    final y_start=y_start,
    final reverseActing=reverseAction,
    final reset=AixLib.Types.Reset.Disabled) "PID controller for valve opening"
            annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump)
    "Constant pump speed"                                         annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Blocks.Sources.Constant constTflowSet(final k=TflowSet) if not useExternalTset
    "Constant internal flow temperature setoint, if not external"                         annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant "Pump is always on"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  BaseClasses.RegisterBus registerBus "Connector bus for register module" annotation (Placement(transformation(
          extent={{74,-26},{128,26}}), iconTransformation(extent={{88,-14},{116,
            14}})));
  Modelica.Blocks.Interfaces.RealInput TMea if useExternalTMea
    "Connector of second Real input signal" annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120}),                              iconTransformation(
          extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
    annotation (Placement(transformation(extent={{56,-4},{68,8}})));
  Modelica.Blocks.Sources.Constant const(k=1/(3*129/3600))
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_air_set
    annotation (Placement(transformation(extent={{-128,52},{-88,92}})));
  Modelica.Blocks.Interfaces.RealOutput rpm_Set "Connector of Real output signal"
    annotation (Placement(transformation(extent={{96,70},{116,90}})));
  Modelica.Blocks.Interfaces.RealOutput valve_Set "Connector of Real output signal"
    annotation (Placement(transformation(extent={{96,-100},{116,-80}})));
equation

    connect(PID.u_s, Tset) annotation (Line(
      points={{-12,-50},{-48,-50},{-48,0},{-106,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
    connect(constTflowSet.y, PID.u_s) annotation (Line(
      points={{-79,-50},{-12,-50}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  if useExternalTMea==false then
  connect(PID.u_m, registerBus.TAirOutMea) annotation (Line(points={{0,-62},{0,
            -80},{102,-80},{102,0.13},{101.135,0.13}},        color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  end if;
  connect(PID.u_m, TMea) annotation (Line(
      points={{0,-62},{0,-120}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(booleanConstant.y, registerBus.hydraulicBus.pumpBus.onSet)
    annotation (Line(points={{81,30},{101.135,30},{101.135,0.13}}, color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constRpmPump.y, multiProduct.u[1])
    annotation (Line(points={{41,0},{41,0.6},{56,0.6}}, color={0,0,127}));
  connect(const.y, multiProduct.u[2])
    annotation (Line(points={{11,50},{50,50},{50,2},{56,2}}, color={0,0,127}));
  connect(V_flow_air_set, multiProduct.u[3])
    annotation (Line(points={{-108,72},{50,72},{50,3.4},{56,3.4}}, color={0,0,127}));
  connect(multiProduct.y, rpm_Set)
    annotation (Line(points={{69.02,2},{74,2},{74,18},{92,18},{92,80},{106,80}}, color={0,0,127}));
  connect(valve_Set, PID.y)
    annotation (Line(points={{106,-90},{86,-90},{86,-50},{11,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{20,100},{100,0},{20,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(revisions="<html><ul>
  <li>August 1, 2019, by Alexander Kümpel:<br/>
    Improvement.
  </li>
  <li>October 18, 2018, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Simple controller for heating and cooling registers. The controlled
  variable is the air outflow temperature T_air_out. The pump (if
  existing in hydraulic circuit) operates at constant frequency and is
  always on.
</p>
</html>"));
end CtrRegBasic;
