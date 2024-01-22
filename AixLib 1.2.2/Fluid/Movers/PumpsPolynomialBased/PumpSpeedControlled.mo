within AixLib.Fluid.Movers.PumpsPolynomialBased;
model PumpSpeedControlled
  "Pump model with speed control, onOff-Switch and bounding of speed instead of pump delivery head."

  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
    // Energy and mass balance (defines Medium start properties)


  parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord pumpParam= AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord() "pump parameter record"
    annotation (choicesAllMatching=true);

  parameter Real Qnom(
    quantity="VolumeFlowRate",
    unit="m3/h",
    displayUnit="m3/h") = 0.67*max(pumpParam.maxMinSpeedCurves[:, 1])
    "Nominal volume flow rate in m³/h (~0.67*Qmax).
    Qmax is taken from pumpParam.maxMinSpeedCurves."
    annotation (Dialog(tab="Nominal design point", group="Design point of pump. Used for start value calculation."));
  parameter Modelica.Units.NonSI.AngularVelocity_rpm Nnom=
      Modelica.Math.Vectors.interpolate(
      x=pumpParam.maxMinSpeedCurves[:, 1],
      y=pumpParam.maxMinSpeedCurves[:, 2],
      xi=Qnom) "Pump speed in design point (Qnom,Hnom).
    Default is maximum speed at Qnom from pumpParam.maxMinSpeedCurves.
    Note that N is defined only on [nMin, nMax]. Due to power limitation
    N might be smaller than nMax for higher Q." annotation (Dialog(tab=
          "Nominal design point", group=
          "Design point of pump. Used for start value calculation."));
  parameter Modelica.Units.SI.Height Hnom=
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cHQN,
      Qnom,
      Nnom) "Nominal pump head in m (water).
      Will by default be calculated automatically from Qnom and Nnom.
      If you change the value make sure to also set a feasible Qnom."
    annotation (Dialog(tab="Nominal design point", group=
          "Design point of pump. Used for start value calculation."));

  // Parameters
  // Initialization
  parameter Modelica.Units.SI.Height Hstart=Hnom "
      Start value of pump head. Will be used to initialize criticalDamping."
    annotation (Dialog(tab="Initialization", group="Pressure"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
    "Start value of pressure" annotation (Dialog(tab="Initialization", group="Pressure"));
  parameter Modelica.Media.Interfaces.Types.Temperature T_start=Medium.T_default
    "Start value of temperature" annotation (Dialog(tab="Initialization", group="Temperature"));

  // Dynamics
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state" annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  // Assumptions
  parameter Modelica.Units.SI.Volume V=0 "Volume inside the pump"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);


  final parameter Modelica.Units.SI.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default) "Default medium density";

  // Power and Efficiency
  parameter Boolean calculatePower=true "calc. power consumption?" annotation (
     Dialog(tab="General", group="Power and Efficiency"));
  parameter Boolean calculateEfficiency=false
    "calc. efficency? (eta = f(H, Q, P))" annotation (Dialog(
      tab="General",
      group="Power and Efficiency",
      enable=calculate_Power));
  replaceable function efficiencyCharacteristic =
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.Wilo_Formula_efficiency
    constrainedby AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.baseEfficiency
    "eta = f(H, Q, P)" annotation (Dialog(
      tab="General",
      group="Power and Efficiency",
      enable=calculate_Efficiency), choicesAllMatching=true);
  /*
  Defining constants that will be used as min, max, nominal attributes for variables
  */
protected
  constant Modelica.Units.SI.Length constHmax=20;
  constant Modelica.Units.SI.Length constHnom=0.5*constHmax;
  constant Modelica.Units.SI.PressureDifference constDpMax=1.1*constHmax*995*
      Modelica.Constants.g_n;
  constant Modelica.Units.SI.PressureDifference constDpNom=constDpMax*0.5;
  constant Modelica.Units.SI.MassFlowRate constMflowMax=60*995/3600;
  constant Modelica.Units.SI.MassFlowRate constMflowNom=2*995/3600;

  // Variables
public
  Modelica.Units.SI.PressureDifference dp_pump(
    min=0,
    max=constDpMax,
    nominal=constDpNom) "Pressure increase";
  Modelica.Blocks.Interfaces.RealOutput head(
    quantity="Length",
    unit="m",
    min=0,
    max=constHmax,
    nominal=constHnom) "Pump head";
  Modelica.Blocks.Interfaces.RealOutput n(
    nominal=Nnom,
    min=0,
    max=pumpParam.nMax,
    quantity="AngularVelocity",
    unit="rev/min")
    "limited pump speed calculated from volume flow and head n=f(Q,H)";
  Modelica.Blocks.Interfaces.RealOutput power(
    quantity="Power",
    unit="W",
    min=0) "electical power";
  Modelica.Blocks.Interfaces.RealOutput eta(
    quantity="Efficiency",
    unit="1",
    min=0) "efficiency";
  Modelica.Blocks.Sources.RealExpression Vflow_m3h(y(
      min=0,
      max=max(pumpParam.maxMinSpeedCurves[:, 1]),
      nominal=Qnom)= m_flow/rho_default*3600)
    "conversion of mass flow rate to volume flow rate"
    annotation (Placement(transformation(extent={{-100,35},{-80,55}})));
  Modelica.Blocks.Tables.CombiTable1Dv maxMinTable(
    columns={2,3},
    tableName="NoName",
    tableOnFile=false,
    table=pumpParam.maxMinSpeedCurves)
    "Outputs max [1] and min [2] pump speed for the current value of volume flow rate. "
    annotation (Placement(transformation(extent={{-75,10},{-55,30}}, rotation=0)));

  Modelica.Blocks.Routing.DeMultiplex2 deMultiplex2(n1=1, n2=1)
    "Seperate max/min pump head curve signal" annotation (Placement(
        transformation(extent={{-47,10},{-27,30}}, rotation=0)));
  BaseClasses.VariableLimiter variableLimiter(strict=false)
    "Limit pump speed to max/min curve" annotation (Placement(transformation(
          extent={{-10,10},{10,30}}, rotation=0)));

  BaseClasses.PumpBus pumpBus annotation (Placement(transformation(extent={{-19,
            81},{20,120}}), iconTransformation(extent={{-20,80},{20,120}})));

protected
  Modelica.Blocks.Sources.RealExpression pumpPower(y=power) if calculatePower
    "implements a connectable object that can be cuppled with pumpBus."
    annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
  Modelica.Blocks.Sources.RealExpression pumpHead(y=head)
    "implements a connectable object that can be cuppled with pumpBus."
    annotation (Placement(transformation(extent={{54,-50},{74,-30}})));
  Modelica.Blocks.Sources.RealExpression pumpEfficiency(y=eta)
 if calculateEfficiency
    "implements a connectable object that can be cuppled with pumpBus."
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant off(k=Modelica.Constants.small)
    annotation (Placement(transformation(extent={{-70,-35},{-60,-25}})));
  Modelica.Blocks.Continuous.CriticalDamping
                                    criticalDamping(
    y_start=Hstart,
    f=1/5,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{23,-50},{43,-30}})));
  Modelica.Blocks.Sources.RealExpression pressure_difference(y=-dp_pump)
    "implements a connectable object that can be cuppled with pumpBus."
    annotation (Placement(transformation(extent={{-71,-76},{-51,-56}})));
public
  Modelica.Blocks.Logical.Switch onOffHead "turns head variable off or on."
    annotation (Placement(transformation(extent={{-6,-50},{14,-30}})));
  Modelica.Blocks.Logical.Switch onOffn "turns speed variable n off or on."
    annotation (Placement(transformation(extent={{19,10},{39,30}})));

  Modelica.Blocks.Sources.RealExpression headUnbound(y=max(0,
        AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
        pumpParam.cHQN,
        Vflow_m3h.y,
        n)))
    annotation (Placement(transformation(extent={{-40,-42},{-17,-22}})));


  AixLib.Fluid.Movers.BaseClasses.IdealSource idealSource(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=1E-4*abs(m_flow_nominal),
    final control_m_flow=false)
    annotation (Placement(transformation(extent={{-31,-90},{-11,-70}})));
  MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    final p_start=p_start,
    final T_start=T_start,
    m_flow_nominal=m_flow_nominal,
    m_flow_small=1E-4*abs(m_flow_nominal),
    allowFlowReversal=allowFlowReversal,
    final V=V,
    nPorts=2) annotation (Placement(transformation(extent={{23,-80},{43,-60}})));


equation

  // Physical limitations of the pump
  connect(maxMinTable.u[1], Vflow_m3h.y)
    "for the interpolation of the max curve"
    annotation (Line(points={{-77,20},{-77,45},{-79,45}}, color={0,0,127}));
  connect(maxMinTable.u[2], Vflow_m3h.y)
    "for the interpolation of the min curve"
    annotation (Line(points={{-77,20},{-77,45},{-79,45}}, color={0,0,127}));

  // without damping: onOff.y
  head = criticalDamping.y "safe head after limiting and other checks.";
  dp_pump = head  * rho_default * Modelica.Constants.g_n;
  //Calculate power and Efficiency
  if calculatePower then
    power =if n >= pumpParam.nMin*0.9 and pumpBus.onSet and Vflow_m3h.y >
      Modelica.Constants.small then max(0,
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cPQN,
      Vflow_m3h.y,
      n)) else 0 "computing power as long as n > 90% nMin";
    if calculateEfficiency then
      eta =if n >= pumpParam.nMin*0.9 and pumpBus.onSet and power >
        AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
        pumpParam.cPQN,
        Modelica.Constants.small,
        pumpParam.nMin*0.9) then max(0, efficiencyCharacteristic(
        Vflow_m3h.y,
        head,
        power,
        rho_default)) else 0 "computing eta as long as n > 90% nMin";
    else
      eta = 0;
    end if;
  else
    power = 0;
    eta = 0;
  end if;

  connect(maxMinTable.y, deMultiplex2.u) annotation (Line(
      points={{-54,20},{-49,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(deMultiplex2.y2[1], variableLimiter.limit2) annotation (Line(
      points={{-26,14},{-20,14},{-20,12},{-12,12}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(pumpPower.y, pumpBus.PelMea) annotation (Line(points={{-79,76},{-66,76},{-66,93},{0.5975,93},{0.5975,100.597}},
                                                      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpEfficiency.y, pumpBus.efficiencyMea) annotation (Line(points={{-79,60},{-62,60},{-62,100.597},{0.5975,100.597}},
                                                        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(onOffHead.u2, pumpBus.onSet) annotation (Line(points={{-8,-40},{-43,-40},{-43,-16},{69,-16},{69,100.597},{0.5975,100.597}},
                                                             color={255,0,255}),
      Text(
      string="%second",
      index=3,
      extent={{6,3},{6,3}}));
  connect(off.y, onOffHead.u3) annotation (Line(points={{-59.5,-30},{-48,-30},{-48,
          -48},{-8,-48}}, color={0,0,127}));
  connect(deMultiplex2.y1[1], variableLimiter.limit1) annotation (Line(points={{
          -26,26},{-23,26},{-23,28},{-12,28}}, color={0,0,127}));
  connect(variableLimiter.u, pumpBus.rpmSet) annotation (Line(points={{-12,20},{-20,20},{-20,38},{0.5975,38},{0.5975,100.597}},
                                                           color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(onOffHead.y, criticalDamping.u)
    annotation (Line(points={{15,-40},{21,-40}}, color={0,0,127}));
  connect(pumpHead.y, pumpBus.dpMea) annotation (Line(points={{75,-40},{81,-40},{81,90},{0.5975,90},{0.5975,100.597}},
                                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(variableLimiter.y, onOffn.u1) annotation (Line(points={{11,20},{12,20},
          {12,28},{17,28}}, color={0,0,127}));
  connect(onOffn.u2, pumpBus.onSet) annotation (Line(points={{17,20},{14,20},{14,49},{36,49},{36,100.597},{0.5975,100.597}},
                                                         color={255,0,255}),
      Text(
      string="%second",
      index=3,
      extent={{6,3},{6,3}}));
  connect(onOffn.y, n)
    annotation (Line(points={{40,20},{50,20}}, color={0,0,127}));

  connect(n, pumpBus.rpmMea) annotation (Line(points={{40,20},{43,20},{43,
          100.598},{0.5975,100.598}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{4,12},{4,12}}));
  connect(Vflow_m3h.y, pumpBus.vFRcur_m3h) annotation (Line(points={{-79,45},{0.5,
          45},{0.5,100.5}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(off.y, onOffn.u3) annotation (Line(points={{-59.5,-30},{-48,-30},{-48,
          -7},{17,-7},{17,12}}, color={0,0,127}));
  connect(onOffHead.u1, headUnbound.y)
    annotation (Line(points={{-8,-32},{-15.85,-32}}, color={0,0,127}));
  connect(idealSource.port_a, port_a) annotation (Line(points={{-31,-80},{-85,-80},
          {-85,0},{-100,0}}, color={0,127,255}));
  connect(pressure_difference.y, idealSource.dp_in)
    annotation (Line(points={{-50,-66},{-15,-66},{-15,-72}}, color={0,0,127}));
  connect(idealSource.port_b, vol.ports[1])
    annotation (Line(points={{-11,-80},{31,-80}}, color={0,127,255}));
  connect(vol.ports[2], port_b)
    annotation (Line(points={{35,-80},{100,-80},{100,0}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Polygon(
          points={{50,25},{60,20},{50,15},{50,25}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{49,30},{59,25}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="n")}),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.1), graphics={
        Text(
          extent={{80,-40},{322,-58}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          fontName="monospace",
          textString="CA: n_set"),
        Text(
          extent={{80,-60},{322,-78}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          fontName="monospace",
          textString="H: %Hnom% m",
          visible=true),
        Text(
          extent={{80,-80},{338,-98}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          fontName="monospace",
          textString="Q: %Qnom% m³/h",
          visible=true),
        Text(
          extent={{80,-60},{320,-78}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          fontName="monospace",
          textString="n: %n% rpm",
          visible=false),
        Text(
          extent={{80,-20},{300,-38}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          fontName="monospace",
          textString="%pumpParam.pumpModelString%"),
        Ellipse(
          extent={{-80,90},{80,-70}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={254,178,76}),
        Polygon(
          points={{-28,64},{-28,-40},{54,12},{-28,64}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={220,220,220})}),
    Documentation(info="<html><h4>
  Overview
</h4>
<p>
  Simple model for a pump that uses polynomial functions to calculate
  pump head (headUnbound), power, efficiency. Pump speed (n) will be
  given by the pumpBus.rpm_Input variable. The variableLimiter will
  limit n to the maximum and minimum value of speed (which depends upon
  current volume flow rate). Pump speed is limited by pumpParam.nMin,
  pumpParam.nMax as well as a maximum (and minimum) pump speed curve
  (pumpParam.maxMinSpeedCurves). Those curves are normally derived from
  an electronic power limitation of a pump.
</p>
<h4>
  On-/Off Switch
</h4>
<p>
  The pump can be switched on/off by a boolean input
  (pumpBus.onOff_Input, TRUE = On). The switch between on and off is
  not filtered.
</p>
<h4>
  Controlling the pump (pumpBus.rpm_Input)
</h4>
<p>
  The pump must be controlled by setting the pump speed
  (pumpBus.rpm_Input).
</p>
<h4>
  Power and Efficiency calculation
</h4>
<p>
  The power and the efficiency of the pump can be calculated, with the
  help of polynomial aproximations. <b>Only use them if you have
  correct / complete data about the pump.</b>
</p>
<p>
  <br/>
  See the examples under package \"Examples\".
</p>
<h4>
  Hints
</h4>
<h5>
  Qnom
</h5>
<p>
  Qnom, the nominal or design volume flow rate of the pump, is given in
  m³/h and should be selected by the engineer. A good default value
  would be 67 % of Qmax .The default value, however, is set to
  <span style=\"font-family: Courier New;\">0.5*</span><span style=
  \"color: #ff0000;\">max(pumpParam.maxMinSpeedCurves[:,&#160;1]).
  max(pumpParam.maxMinSpeedCurves[:, 1])</span> is the maximum value
  found in column 1 of table maxMinSpeedCurves. This however, is more
  than the real maximum volume flow rate of the pump as the the table
  is extended by additional rows for proper extrapolation of table
  values. In order to compensate for this excess value Qnom is by
  default only at 50 5 of the maxMinSpeedCurves value. Please refer to
  the referenceDataQHPN matrix to find the real Qmax value. A simple
  alternative for the given assumption could be to introduce a
  parameter Qmax in the pump record that contains the exact value.
</p>
<h4>
  Assumption and limitations
</h4>
<p>
  Note assumptions such as a specific definition ranges for the model,
  possible medium models, allowed combinations with other models etc.
  There might be limitations of the model such as reduced accuracy
  under specific circumstances. Please note all those limitations you
  know of so a potential user won't make too serious mistakes
</p>
<h4>
  Dynamics
</h4>
<p>
  Describe which states and dynamics are present in the model and which
  parameters may be used to influence them. This need not be added in
  partial classes.
</p>
<h4>
  Validation
</h4>
<p>
  Describe whether the validation was done using analytical validation,
  comparative model validation or empirical validation.
</p>
</html>",
revisions="<html><ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming, restructuring and bug fixes.
  </li>
  <li>2018-05-08 by Peter Matthes:<br/>
    Changes initialization of criticalDamping to
    Types.Init.InitialOutput. \"Noinit\" could lead to always zero
    output.
  </li>
  <li>2018-03-12 by Peter Matthes:<br/>
    * Adds start values for m_flow and Vflow_m3h.<br/>
    * Removes assignment \"Vflow_m3h(y=if noEvent(port_b.m_flow &gt; 0)
    then 0 else -port_b.m_flow/medium.d*3600)\".<br/>
    * Comments out an assert statement for positive mass flow as that
    will provoke events when pump gets turned off and lead to stalled
    simulations.<br/>
    * Adds min and max attribbutes to dp_pump, head, headUnbound,
    criticalDamping.y and m_flow and Vflow_m3h should help to avoid
    negative pump delivery head or mass flow.
  </li>
  <li>2018-03-01 by Peter Matthes:<br/>
    Improved parameter setup of pump model. Ordering in GUI, disabled
    some parameters that should be used not as input but rather as
    outputs (m_flow_start, p_a_start and p_b_start) and much more
    description in the parameter doc strings to help the user make
    better decisions.
  </li>
  <li>2018-02-01 by Peter Matthes:<br/>
    * When pump is turned off the model will also turn pump speed (n)
    off as well. So far the pump speed stayed at the lower limit given
    by the variableLimiter.<br/>
    * The pump speed n is mapped onto the bus as \"rpm_Act\".<br/>
    * RealOutput v_dot_m3h has been changed into a formula block with
    the signal now being Vflow_m3h.y. This change improves model
    checking, as the former RealOutput had not defining connection but
    rather an attached equation. Dymola was not able to correctly
    reckognize this and threw a warning. This would have reduced the
    ability to debug the code as futher checks by Dymola would be
    avoided at that point.<br/>
    * Fixes calculation of power and efficiency. As power values near
    zero were possible, eta could get insanely high values. power and
    eta are now limited to more sensible values. However, there is no
    transition between the lowest possible value and zero any more. If
    that behaviour would be needed try implementing a transition
    function.
  </li>
  <li>2018-01-30 by Peter Matthes:<br/>
    * Renamed speed controlled pump model (red) from PumpNbound into
    PumpN as well as PumpPhysicsNbound into PumpPhysicsN. \"N\" stands
    for pump speed.<br/>
    * Moved efficiencyCharacteristic package directly into BaseClasses.
    This is due to moving the older pump model and depencencies into
    the Deprecated folder.
  </li>
  <li>2018-01-29 by Peter Matthes:<br/>
    * Removes parameter useABCcurves as that is the default to
    calculate speed and is only needed in the blue pump (PumpH) to
    calculate power from speed and volume flow. Currently there is no
    other way to compute speed other than inverting function H = f(Q,N)
    . This can only be done with the quadratic ABC formula. Therefore,
    an assert statement has been implemented instead to give a warning
    when you want to compute power but you use more that the ABC
    coefficients in cHQN.<br/>
    * Removes parameter Nnom and replaces it with Nstart. As discussed
    with Wilo Nnom is not very useful and it can be replaced with a
    start value. The default value has been lowered to a medium speed
    to avoid collision with the speed/power limitation. For most pumps
    the maximum speed is limited for increasing volume flows to avoid
    excess power consumption.<br/>
    * Increases Qnom from 0.5*Qmax to 0.67*Qmax as this would be a more
    realistic value.
  </li>
  <li>2018-01-26 by Peter Matthes:<br/>
    Changes Nnom from 80 % to 100 % of Nmax.
  </li>
  <li>2018-01-16 by Peter Matthes:<br/>
    Fixes power and efficiency calculation by using truth value \"
    <span style=
    \"font-family: Courier New;\">n&#160;&gt;=&#160;pumpParam.nMin*0.9<span style=\"color: #0000ff;\">&#160;and&#160;</span></span>
    pumpBus.onOff_Input\" instead of \"head &gt; 0.0\".
  </li>
  <li>2018-01-15 by Peter Matthes:<br/>
    Changes minimum mass flow rate in ports to +/- <span style=
    \"font-family: Courier New;\">1.5*<span style=
    \"color: #ff0000;\">max</span></span> (pumpParam.maxMinSpeedCurves[:,
    1]) in order to reduce search space.
  </li>
  <li>2017-12-13 by Peter Matthes:<br/>
    Adds assertions to check for unset pump record and improves the
    checks for cHQN matrix.
  </li>
  <li>2017-12-12 by Peter Matthes:<br/>
    * Changed Qnom from 1 m³/h to \" <span style=
    \"font-family: Courier New;\">0.5*<span style=
    \"color: #ff0000;\">max</span></span>
    (pumpParam.maxMinSpeedCurves[:,1])\".<br/>
    * Changed parameter name <span style=
    \"font-family: Courier New;\"><i>n_start</i> to <i>Nnom</i> as it was
    only used to determin <i>Hnom</i></span>.<br/>
    * Changed m_flow_start value from 1 to \"Qnom* <span style=
    \"color: #ff0000;\">Medium.density_pTX</span> (p_b_start, T_start,
    X_start)/3600\".<br/>
    * Changed p_b_start from system.p_start to \"p_a_start +
    Hnom*system.g_n* <span style=
    \"font-family: Courier New; color: #ff0000;\">Medium.density_pTX</span>
    (p_b_start, T_start, X_start)\" and changed p_start in medium state
    to p_b_start.<br/>
    * Added assertions to check initialization parameters.
  </li>
  <li>2017-12-01 by Peter Matthes:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end PumpSpeedControlled;
