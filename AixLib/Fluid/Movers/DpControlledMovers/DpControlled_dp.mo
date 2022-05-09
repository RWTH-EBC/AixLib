within AixLib.Fluid.Movers.DpControlledMovers;
model DpControlled_dp "Pump or fan including pressure control (constant or variable)"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations(
    final mSenFac=1);
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    m_flow_nominal(final min=Modelica.Constants.small),
    port_a(
      h_outflow(start=h_outflow_start)),
    port_b(
      h_outflow(start=h_outflow_start),
      p(start=p_start),
      final m_flow(max = if allowFlowReversal then +Modelica.Constants.inf else 0)));


  replaceable parameter AixLib.Fluid.Movers.Data.Generic per(pressure=pressureCurve_default) "Record with performance data"
    annotation (choicesAllMatching=true,
    Dialog(group="Machine characteristics"),
    Placement(transformation(extent={{12,22},{32,42}})));

  parameter Modelica.Units.SI.PressureDifference dp_nominal(
    min=0,
    displayUnit="Pa") = if rho_default < 500 then 500 else 10000 "Nominal pressure raise, used to normalized the filter if use_inputFilter=true,
        to set default values of constantHead and heads, and
        and for default pressure curve if not specified in record per"
    annotation (Dialog(group="Nominal condition"));
  parameter AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType ctrlType=AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpTotal "Type of mover control" annotation (Dialog(group="Control characteristics"));
  parameter AixLib.Fluid.Movers.BaseClasses.Characteristics.flowParameters pressureCurve_default(
      V_flow=m_flow_nominal/rho_default*{0,1,1.5,2},
      dp=dp_nominal*{1.3,1,0.75,0})
    "General mover curve: volume flow rate vs. total pressure head"
    annotation (Dialog(group="Machine characteristics"));
  parameter AixLib.Fluid.Movers.BaseClasses.Characteristics.flowParameters pressureCurve_dpConst(
      V_flow=m_flow_nominal/rho_default*{0,1,1.5,2},
      dp=dp_nominal*{1,1,0.75,0})
    "dpConst control: volume flow rate vs. total pressure head"
    annotation(Dialog(enable=(ctrlType == AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpConst), group="Control characteristics"));
  parameter AixLib.Fluid.Movers.BaseClasses.Characteristics.flowParameters pressureCurve_dpVar(
      V_flow=m_flow_nominal/rho_default*{0,1,1.5,2},
      dp=dp_nominal*{0.5,1,0.75,0})
    "dpVar control: volume flow rate vs. total pressure head"
    annotation(Dialog(enable=(ctrlType == AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpVar), group="Control characteristics"));

  parameter Boolean addPowerToMedium=true
    "Set to false to avoid any power (=heat and flow work) being added to medium (may give simpler equations)";
  parameter Boolean nominalValuesDefineDefaultPressureCurve = false
    "Set to true to avoid warning if m_flow_nominal and dp_nominal are used to construct the default pressure curve";
  parameter Boolean prescribeSystemPressure=false
    "=true, to control mover such that pressure difference is obtained across two remote points in system"
    annotation (Dialog(tab="Advanced"));
  parameter Modelica.Units.SI.Time tauMov=1
    "Time constant in mover (pump or fan) of fluid volume for nominal flow, used if energy or mass balance is dynamic"
    annotation (Dialog(
      tab="Dynamics",
      group="Nominal condition",
      enable=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState or
          massDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState));

  // Classes used to implement the filtered speed
  parameter Boolean use_inputFilter=true
    "= true, if speed is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(tab="Dynamics", group="Filtered speed"));
  parameter Modelica.Units.SI.Time riseTime=30
    "Rise time of the filter (time to reach 99.6 % of the speed)" annotation (
      Dialog(
      tab="Dynamics",
      group="Filtered speed",
      enable=use_inputFilter));
  parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation(Dialog(tab="Dynamics", group="Filtered speed",enable=use_inputFilter));
  parameter Real y_start(min=0, max=1, unit="1")=0
    "Initial value of speed"
    annotation(Dialog(tab="Dynamics", group="Filtered speed",enable=use_inputFilter));

  // Sensor parameters
  parameter Modelica.Units.SI.PressureDifference dp_start=0
    "Initial value of pressure raise" annotation (Dialog(
      tab="Dynamics",
      group="Filtered speed",
      enable=use_inputFilter));
  parameter Modelica.Units.SI.Time tauSen=0
    "Time constant at nominal flow rate (use tau=0 for steady-state sensor, but see user guide for potential problems)"
    annotation (Dialog(tab="Sensor"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Sensor", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.Density d_start=Medium.density(Medium.setState_pTX(
      senVolFlo.p_start,
      senVolFlo.T_start,
      senVolFlo.X_start)) "Initial or guess value of density" annotation (Dialog(tab="Sensor", group="Initialization"));

  // Table parameters
  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"
    annotation (Dialog(tab="Curve / Table", group="Table data interpretation"));
  parameter Boolean verboseExtrapolation=false
    "= true, if warning messages are to be printed if table input is outside the definition range"
    annotation (Dialog(tab="Curve / Table", group="Table data interpretation"));

  Modelica.Blocks.Interfaces.RealInput dpMea(
    final quantity="PressureDifference",
    final displayUnit="Pa",
    final unit="Pa")=gain.u if prescribeSystemPressure
    "Measurement of pressure difference between two points where the set point should be obtained"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-20,120})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat dissipation to environment"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  AixLib.Fluid.Sensors.VolumeFlowRate senVolFlo(
    redeclare final package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=m_flow_small,
    final tau=tauSen,
    final initType=initType,
    final d_start=d_start,
    final T_start=T_start,
    final p_start=p_start,
    final X_start=X_start)
    "Sensor to measure volume flow rate"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  Modelica.Blocks.Tables.CombiTable1Dv pressureCurveSelected(
    final tableOnFile=false,
    final table=if (ctrlType == AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpConst)
         then [cat(1, pressureCurve_dpConst.V_flow),cat(1,
        pressureCurve_dpConst.dp)] elseif (ctrlType == AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpVar)
         then [cat(1, pressureCurve_dpVar.V_flow),cat(1, pressureCurve_dpVar.dp)]
         else [cat(1, per.pressure.V_flow),cat(1, per.pressure.dp)],
    final tableName="NoName",
    final fileName="NoName",
    final verboseRead=true,
    final columns=2:size(pressureCurveSelected.table, 2),
    final smoothness=smoothness,
    final extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    u(each final unit="m3/s"),
    y(each final unit="Pa"),
    final verboseExtrapolation=verboseExtrapolation)
    "Table with points of selected curve to calculate dp from V_flow"
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));

  AixLib.Fluid.Movers.FlowControlled_dp mov(
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final X_start=X_start,
    final C_start=C_start,
    final C_nominal=C_nominal,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=m_flow_small,
    final show_T=false,
    final per=per,
    final inputType=AixLib.Fluid.Types.InputType.Continuous,
    final addPowerToMedium=addPowerToMedium,
    final nominalValuesDefineDefaultPressureCurve=
        nominalValuesDefineDefaultPressureCurve,
    final tau=tauMov,
    final use_inputFilter=use_inputFilter,
    final riseTime=riseTime,
    final init=init,
    final y_start=y_start,
    final dp_start=dp_start,
    final dp_nominal=dp_nominal,
    final constantHead=dp_nominal,
    final heads=dp_nominal*{(per.speeds[i]/per.speeds[end])^2 for i in 1:size(
        per.speeds, 1)},
    final prescribeSystemPressure=prescribeSystemPressure) "Mover: pump or fan"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Blocks.Interfaces.RealOutput P(final quantity="Power", final unit="W")
    "Electrical power consumed"
    annotation (Placement(transformation(extent={{100,70},{120,90}}), iconTransformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput y_actual(final unit="1")
    "Actual normalised pump speed that is used for computations"
    annotation (Placement(transformation(extent={{100,50},{120,70}}), iconTransformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput dp_actual(final unit="Pa")
    "Pressure difference between the mover inlet and outlet"
    annotation (Placement(transformation(extent={{100,30},{120,50}}), iconTransformation(extent={{100,40},{120,60}})));

protected
  final parameter Modelica.Units.SI.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default) "Default medium density";
  final parameter Medium.ThermodynamicState sta_start=Medium.setState_pTX(
      T=T_start,
      p=p_start,
      X=X_start)
    "Medium state at start values";

  final parameter Modelica.Units.SI.SpecificEnthalpy h_outflow_start=
      Medium.specificEnthalpy(sta_start) "Start value for outflowing enthalpy";

  final parameter Modelica.Units.SI.VolumeFlowRate V_flow_min=min(min(
      pressureCurve_default.V_flow), min(min(pressureCurve_dpConst.V_flow), min(
      pressureCurve_dpVar.V_flow))) "Get minimum of three vectors";
  final parameter Modelica.Units.SI.VolumeFlowRate V_flow_max=max(max(
      pressureCurve_default.V_flow), max(max(pressureCurve_dpConst.V_flow), max(
      pressureCurve_dpVar.V_flow))) "Get maximum of three vectors";

  constant Integer n_sup_pts = 100
    "Supporting points";
  final parameter Modelica.Units.SI.PressureDifference dps_default[:]=array(
      Modelica.Math.Vectors.interpolate(
      pressureCurve_default.V_flow,
      pressureCurve_default.dp,
      Vi) for Vi in V_flow_min:(V_flow_max - V_flow_min)/n_sup_pts:V_flow_max)
    "Vector (equally spaced) with pressure heads (default curve) on the basis of n_sup_pts supporting points";
  final parameter Modelica.Units.SI.PressureDifference dps_dpConst[:]=array(
      Modelica.Math.Vectors.interpolate(
      pressureCurve_dpConst.V_flow,
      pressureCurve_dpConst.dp,
      Vi) for Vi in V_flow_min:(V_flow_max - V_flow_min)/n_sup_pts:V_flow_max)
    "Vector (equally spaced) with pressure heads (dpConst curve) on the basis of n_sup_pts supporting points";
  final parameter Modelica.Units.SI.PressureDifference dps_dpVar[:]=array(
      Modelica.Math.Vectors.interpolate(
      pressureCurve_dpVar.V_flow,
      pressureCurve_dpVar.dp,
      Vi) for Vi in V_flow_min:(V_flow_max - V_flow_min)/n_sup_pts:V_flow_max)
    "Vector (equally spaced) with pressure heads (dpVar curve) on the basis of n_sup_pts supporting points";

  function checkDpCurves
    input Modelica.Units.SI.PressureDifference dps_default[:]
      "Reference vector containing pressure head points";
    input Modelica.Units.SI.PressureDifference dps_other[:]
      "Comparing vector containing pressure head points";
    input Integer n_sup_pts(min=2) "Supporting points";
    output Boolean dps_error "Use a boolean to avoid multiple assertion errors to be printed";
  algorithm
    dps_error := false;
    for i in 1:1:n_sup_pts loop
     if dps_error == false and dps_other[i]<=dps_default[i] then
       dps_error :=false;
     else
       dps_error :=true;
     end if;
    end for;
  end checkDpCurves;

initial equation
  assert(pressureCurveSelected.n==1,
    "\n+++++++++++++++++++++++++++++++++++++++++++\nNumber of outputs of table component "+getInstanceName()+".pressureCurveSelected must equal 1, but they are "+String(pressureCurveSelected.n)+".\n+++++++++++++++++++++++++++++++++++++++++++",
    AssertionLevel.error);
  assert(pressureCurveSelected.table[1, 1] == 0.0,
    "\n+++++++++++++++++++++++++++++++++++++++++++\nParameterization error in component ("+getInstanceName()+".pressureCurveSelected):\nThe mover's (pump or fan) curve must have first point at V_flow = 0.0 m3/s.\n+++++++++++++++++++++++++++++++++++++++++++",
    AssertionLevel.error);
  assert(pressureCurveSelected.table[size(pressureCurveSelected.table, 1), size(pressureCurveSelected.table, 2)] == 0.0,
    "\n+++++++++++++++++++++++++++++++++++++++++++\nParameterization error in component ("+getInstanceName()+".pressureCurveSelected):\nThe mover's (pump or fan) curve must have last point at dp = 0.0 Pa.\n+++++++++++++++++++++++++++++++++++++++++++",
    AssertionLevel.error);
  // Check on the basis of n supporting points if both controlled curves are correct parametrized so that they lie below the default curve.
  assert(checkDpCurves(dps_default, dps_dpConst, n_sup_pts)==false,
    "\n+++++++++++++++++++++++++++++++++++++++++++\nParameterization error in component ("+getInstanceName()+".pressureCurve_dpConst):\nThe dp values of the curve must be less or equal the default/total mover's curve.\n+++++++++++++++++++++++++++++++++++++++++++",
     AssertionLevel.error);
  assert(checkDpCurves(dps_default, dps_dpVar, n_sup_pts)==false,
    "\n+++++++++++++++++++++++++++++++++++++++++++\nParameterization error in component ("+getInstanceName()+".pressureCurve_dpVar):\nThe dp values of the curve must be less or equal the default/total mover's curve.\n+++++++++++++++++++++++++++++++++++++++++++",
    AssertionLevel.error);

equation
  connect(mov.port_b, port_b) annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(port_a, senVolFlo.port_a) annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(senVolFlo.port_b, mov.port_a) annotation (Line(points={{-60,0},{-10,0}}, color={0,127,255}));
  connect(senVolFlo.V_flow, pressureCurveSelected.u[1]) annotation (Line(points={{-70,11},{-70,40},{-52,40}}, color={0,0,127}));
  connect(dpMea, mov.dpMea) annotation (Line(points={{-20,120},{-20,80},{-8,80},{-8,12}},color={0,0,127},pattern=LinePattern.Dash));
  connect(mov.heatPort, heatPort) annotation (Line(points={{0,-6.8},{0,-100}}, color={191,0,0}));
  connect(mov.P, P) annotation (Line(points={{11,9},{80,9},{80,80},{110,80}}, color={0,0,127}));
  connect(mov.y_actual, y_actual) annotation (Line(points={{11,7},{82,7},{82,60},{110,60}}, color={0,0,127}));
  connect(mov.dp_actual, dp_actual) annotation (Line(points={{11,5},{84,5},{84,40},{110,40}}, color={0,0,127}));
  connect(pressureCurveSelected.y[1], mov.dp_in) annotation (Line(points={{-29,40},{0,40},{0,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-94,100},{-42,48}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{0,90},{100,90}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,70},{100,70}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,50},{100,50}},
          color={0,0,0},
          smooth=Smooth.None),
        Rectangle(
          extent={{-100,16},{100,-16}},
          lineColor={0,0,0},
          fillColor={0,127,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-58,58},{58,-58}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{0,50},{0,-50},{54,0},{0,50}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255}),
        Ellipse(
          extent={{4,16},{36,-16}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          visible=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState,
          fillColor={0,100,199}),
        Line(
          points={{0,100},{0,50}},
          color={0,0,0},
          smooth=Smooth.None),
        Rectangle(
          visible=use_inputFilter,
          extent={{-32,40},{34,100}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          visible=use_inputFilter,
          extent={{-32,100},{34,40}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          visible=use_inputFilter,
          extent={{-20,92},{22,46}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{-94,48},{-94,96}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-1,-24},{-1,24}},
          color={0,0,0},
          thickness=0.5,
          origin={-70,49},
          rotation=90),
        Polygon(
          points={{-96,96},{-92,96},{-94,100},{-96,96}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,-2},{2,-2},{0,2},{-2,-2}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-44,48},
          rotation=270),
        Line(
          points={{-94,92},{-68,84},{-56,74},{-48,48}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-94,84},{-68,84},{-56,74},{-48,48}},
          color={255,0,0},
          thickness=0.5,
          pattern=LinePattern.Dash,
          visible=ctrlType==AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpConst),
        Line(
          points={{-94,66},{-68,84},{-56,74},{-48,48}},
          color={73,175,36},
          thickness=0.5,
          pattern=LinePattern.Dash,
          visible=ctrlType==AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpVar)}),                                                                                  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        preferredView="info",
        defaultComponentName="pum",
    Documentation(info="<html><p>
  This model represents a pump or fan which includes already a
  <b>controller</b>. Be aware that this model does not only represent
  the physical behavior of an HVAC component but also controls this
  HVAC component.
</p>
<p>
  In addition to the standard characteristic curve (should equal
  <span style=
  \"font-family: Courier New; font-size: 8pt;\">per.pressure</span>), the
  controller is able to store two further characteristic/control
  curves. This enables the user to quickly select between the two
  common control modes <i>constant pressure</i> (<span style=
  \"font-family: Courier New; font-size: 8pt;\">dpConst</span>) and
  <i>variable pressure</i> (<span style=
  \"font-family: Courier New; font-size: 8pt;\">dpVar</span>). The common
  control modes of pumps are concisely explained in the referenced
  white paper [1].
</p>
<p>
  Often, the <a href=
  \"AixLib.Fluid.Movers.FlowControlled_dp\">AixLib.Fluid.Movers.FlowControlled_dp</a>.
  This means no speed control is possible. Please use <a href=
  \"AixLib.Fluid.Movers.SpeedControlled_y\">AixLib.Fluid.Movers.SpeedControlled_y</a>
  for this application.
</p>
<p>
  The model has a standard parametrization for the three curves basing
  on the parameter <span style=
  \"font-family: Courier New; font-size: 8pt;\">m_flow_nominal</span> and
  <span style=
  \"font-family: Courier New; font-size: 8pt;\">dp_nominal</span>. See
  the figure and table below.
</p>
<p>
  <img height=\"300\" src=
  \"modelica://AixLib/Resources/Images/Fluid/Movers/DpControlledMovers/CurveTypes.jpg\">
</p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\">
  <tr>
    <td valign=\"middle\">
      <p style=\"text-align:center;\">
        <b><span style=\"font-family: Arial;\">m_flow</span></b>
      </p>
    </td>
    <td valign=\"middle\">
      <p style=\"text-align:center;\">
        <b><span style=\"font-family: Arial;\">dp_total</span></b>
      </p>
    </td>
    <td valign=\"middle\">
      <p style=\"text-align:center;\">
        <b><span style=\"font-family: Arial;\">dp_constCtrl</span></b>
      </p>
    </td>
    <td valign=\"middle\">
      <p style=\"text-align:center;\">
        <b><span style=\"font-family: Arial;\">dp_varCtrl</span></b>
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">0</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">1.3</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">1</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">0.5</span>
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">1</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">1</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">1</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">1</span>
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">1.5</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">0.75</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">0.75</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">0.75</span>
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">2</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">0</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">0</span>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <span style=\"font-family: Arial;\">0</span>
      </p>
    </td>
  </tr>
</table>
<h3>
  References
</h3>
<p>
  [1] Robinson, Reece. 2019. Pumping Control Methods and Their Impact
  on System Effciency. <a href=
  \"https://www.esmagazine.com/ext/resources/images/WhitePapers/CBS-US-Whitepaper.pdf\">
  Link to PDF</a>.
</p>
</html>", revisions="<html>
<ul>
  <li>October 28, 2021, by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1151\">#1151</a>
    Added model to library.
  </li>
</ul>
</html>"));
end DpControlled_dp;
