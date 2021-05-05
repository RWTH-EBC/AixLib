within AixLib.Fluid.Movers.PumpsPolynomialBased;
model PumpSpeedControlled
  "Pump model with speed control, onOff-Switch and bounding of speed instead of pump delivery head."

  // =====================
  // Parameters
  // =====================
  // -----------------------
  // Flow Characteristic
  // -----------------------
  parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord pumpParam= AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord() "pump parameter record"
    annotation (choicesAllMatching=true);

  parameter Real Qnom(
    quantity="VolumeFlowRate",
    unit="m3/h",
    displayUnit="m3/h") = 0.67*max(pumpParam.maxMinSpeedCurves[:, 1])
    "Nominal volume flow rate in m³/h (~0.67*Qmax).
    Qmax is taken from pumpParam.maxMinSpeedCurves."
    annotation (Dialog(tab="Nominal design point", group="Design point of pump. Used for start value calculation."));
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm Nnom=
      Modelica.Math.Vectors.interpolate(
        x=pumpParam.maxMinSpeedCurves[:,1],
        y=pumpParam.maxMinSpeedCurves[:,2],
        xi=Qnom)
    "Pump speed in design point (Qnom,Hnom).
    Default is maximum speed at Qnom from pumpParam.maxMinSpeedCurves.
    Note that N is defined only on [nMin, nMax]. Due to power limitation
    N might be smaller than nMax for higher Q."
    annotation (Dialog(tab="Nominal design point", group="Design point of pump. Used for start value calculation."));
  parameter Modelica.SIunits.Height Hnom=
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cHQN,
      Qnom,
      Nnom) "Nominal pump head in m (water).
      Will by default be calculated automatically from Qnom and Nnom.
      If you change the value make sure to also set a feasible Qnom."
    annotation (Dialog(tab="Nominal design point", group="Design point of pump. Used for start value calculation."));

  extends Modelica.Fluid.Interfaces.PartialTwoPort(
    port_b_exposesState=energyDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState
         or massDynamics <> Modelica.Fluid.Types.Dynamics.SteadyState,
    port_a(p(start=p_a_start), m_flow(start=m_flow_start, min=if
            allowFlowReversal and not checkValve then -1.5*max(pumpParam.maxMinSpeedCurves[
            :, 1]) else 0)),
    port_b(p(start=p_b_start), m_flow(start=-m_flow_start, max=if
            allowFlowReversal and not checkValve then +1.5*max(pumpParam.maxMinSpeedCurves[
            :, 1]) else 0)));

  // Parameters
  // Initialization
  parameter Real Qstart(
    quantity="VolumeFlowRate",
    unit="m3/h",
    displayUnit="m3/h")=Qnom "Volume flow rate in m³/h at start of simulation.
  Default is design point (Qnom)."
    annotation (Dialog(tab="Initialization", group="Volume flow"));
  parameter Medium.MassFlowRate m_flow_start=Qstart*Medium.density_pTX(
      p_a_start,
      T_start,
      X_start)/3600 "Start value of m_flow in port_a.m_flow
      Used to initialize ports a and b and for initial checks of model.
      Use it to conveniently initialize upper level models' start mass flow rate.
      Default is to convert Qnom value. Disabled for user change by default."
    annotation (Dialog(tab="Initialization", group="Volume flow", enable=false));
  parameter Modelica.SIunits.Height Hstart=max(0,
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cHQN,
      Qstart,
      Nnom)) "
      Start value of pump head. Will be used to initialize criticalDamping block
      and pressure in ports a and b.
      Default is to calculate it from Qstart and Nnom.  If you change the value
      make sure to also set Qstart to a suitable value."
    annotation (Dialog(tab="Initialization", group="Pressure"));
  parameter Medium.AbsolutePressure p_a_start=system.p_start "
  Start value for inlet pressure. Use it to set a defined absolute pressure
  in the circuit. For example system.p_start. Also use it to initialize
  upper level models properly. It will affect p_b_start."
    annotation (Dialog(tab="Initialization", group="Pressure"));
  parameter Medium.AbsolutePressure p_b_start=p_a_start + Hstart*system.g*
      Medium.density_pTX(
      p_a_start,
      T_start,
      X_start) "
      Start value for outlet pressure. It depends on p_a_start and Hstart.
      It is deactivated for user input by default. Use it in an upper level model
      for proper initialization of other pressure states in that circuit."
      annotation (Dialog(
      tab="Initialization",
      group="Pressure",
      enable=false));

  // Assumptions
  parameter Boolean checkValve=false "= true to prevent reverse flow"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.Volume V=0 "Volume inside the pump"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);

  // Energy and mass balance (defines Medium start properties)
  extends Modelica.Fluid.Interfaces.PartialLumpedVolume(
    final fluidVolume=V,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    final p_start=p_b_start);

  // Power and Efficiency
  parameter Boolean calculatePower=false "calc. power consumption?" annotation (
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
  constant Modelica.SIunits.Length constHmax = 20;
  constant Modelica.SIunits.Length constHnom = 0.5*constHmax;
  constant Modelica.SIunits.PressureDifference constDpMax=1.1*constHmax*995*system.g;
  constant Modelica.SIunits.PressureDifference constDpNom=constDpMax*0.5;
  constant Modelica.SIunits.MassFlowRate constMflowMax=60*995/3600;
  constant Modelica.SIunits.MassFlowRate constMflowNom=2*995/3600;

  // Variables
public
  Modelica.SIunits.PressureDifference dp_pump(
    min=0,
    max=constDpMax,
    nominal=constDpNom) = port_b.p - port_a.p "Pressure increase";
  Modelica.Blocks.Interfaces.RealOutput head(
    quantity="Length",
    unit="m",
    min=0,
    max=constHmax,
    nominal=constHnom) = dp_pump/(medium.d*system.g)
    "Pump head";
  Modelica.SIunits.MassFlowRate m_flow(
    start=m_flow_start,
    min=0,
    max=constMflowMax,
    nominal=constMflowNom) = -port_b.m_flow "Mass flow rate (total)";
  Modelica.Blocks.Interfaces.RealOutput n(
    start=Nnom,
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
      start=Qstart,
      min=0,
      max=max(pumpParam.maxMinSpeedCurves[:, 1]),
      nominal=Qnom)=
      if noEvent(port_b.m_flow > 0) then 0 else m_flow/medium.d*3600)
    "conversion of mass flow rate to volume flow rate"
    annotation (Placement(transformation(extent={{-100,35},{-80,55}})));
  Modelica.Blocks.Tables.CombiTable1D maxMinTable(
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
    annotation (Placement(transformation(extent={{47,-49},{67,-29}})));
  Modelica.Blocks.Sources.RealExpression pumpEfficiency(y=eta) if
    calculateEfficiency
    "implements a connectable object that can be cuppled with pumpBus."
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant off(k=Modelica.Constants.small)
    annotation (Placement(transformation(extent={{-70,-35},{-60,-25}})));
  Modelica.Blocks.Continuous.CriticalDamping
                                    criticalDamping(
    y_start=Hstart,
    y(max=constHmax,
      nominal=constHnom),
    f=1/5,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{23,-50},{43,-30}})));
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
initial equation
  assert(
    sum(abs(pumpParam.cHQN)) <> 0,
    "Warning:
    In a pump model 
    the coefficients in pumpParam.cHQN, which define pump head as polynomial 
    function of volume flow rate and pump speed, seem all to be zero. 
    This cannot work - please redefine.",
    level=AssertionLevel.warning);
  assert(
    m_flow_start >= 0,
    "Warning:
    In a pump model
    parameter 'm_flow_start' (" + String(m_flow_start) + ") has a negative value.
    But this pump model cannot produce a reverse flow. Consider changing the 
    initialization setup.",
    level=AssertionLevel.warning);
  assert(
    p_b_start >= p_a_start,
    "Warning:
    In a pump model 
    parameter 'p_a_start' (" + String(p_a_start) + ") is bigger than 'p_b_start'
    (" + String(p_b_start) + "). But this pump model can only produce a positive
    pump head. Consider changing the initialization setup.",
    level=AssertionLevel.warning);

equation
  // The assert will provoke events when pump gets turned off and lead to a
  // stalled simulation. Therefore we remove it here. The min attribbute to
  // dp_pump, head, headUnbound, criticalDamping.y and m_flow and Vflow_m3h
  // should help to avoid negative pump delivery head or mass flow.
  //   assert(
  //     m_flow > -Modelica.Constants.small,
  //     "Warning:
  //     In a pump model (" + pumpParam.pumpModelString + ") mass flow rate became
  //     negative (" + String(m_flow) + " kg/s) at time " + String(time) +
  //     " s. This is erroneous behavior. Check if the condition persists.
  //     Try to reduce tolerance to get more exact solutions.",
  //     level=AssertionLevel.warning);

  // ==========================
  // start Partial Pump content
  // ==========================
  // Energy balance
  Hb_flow = port_a.m_flow*actualStream(port_a.h_outflow) + port_b.m_flow*
    actualStream(port_b.h_outflow);

  // Ports
  port_a.h_outflow = medium.h;
  port_b.h_outflow = medium.h;
  port_b.p = medium.p
    "outlet pressure is equal to medium pressure, which includes Wb_flow";

  // Mass balance
  mb_flow = port_a.m_flow + port_b.m_flow;

  mbXi_flow = port_a.m_flow*actualStream(port_a.Xi_outflow) + port_b.m_flow*
    actualStream(port_b.Xi_outflow);
  port_a.Xi_outflow = medium.Xi;
  port_b.Xi_outflow = medium.Xi;

  mbC_flow = port_a.m_flow*actualStream(port_a.C_outflow) + port_b.m_flow*
    actualStream(port_b.C_outflow);
  port_a.C_outflow = C;
  port_b.C_outflow = C;
  // ==========================
  // end Partial Pump content
  // ==========================

  // Not yet implemented
  Wb_flow = 0;
  Qb_flow = 0;
  // Will most certainly remain zero for all models

  // Physical limitations of the pump
  connect(maxMinTable.u[1], Vflow_m3h.y)
    "for the interpolation of the max curve"
    annotation (Line(points={{-77,20},{-77,45},{-79,45}}, color={0,0,127}));
  connect(maxMinTable.u[2], Vflow_m3h.y)
    "for the interpolation of the min curve"
    annotation (Line(points={{-77,20},{-77,45},{-79,45}}, color={0,0,127}));

  // without damping: onOff.y
  head = criticalDamping.y "safe head after limiting and other checks.";

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
        medium.d)) else 0 "computing eta as long as n > 90% nMin";
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

  connect(pumpPower.y, pumpBus.PelMea) annotation (Line(points={{-79,76},{-66,
          76},{-66,93},{0.5975,93},{0.5975,100.597}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpEfficiency.y, pumpBus.efficiencyMea) annotation (Line(points={{-79,
          60},{-62,60},{-62,100.597},{0.5975,100.597}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(onOffHead.u2, pumpBus.onSet) annotation (Line(points={{-8,-40},{-43,-40},
          {-43,-16},{69,-16},{69,100.597},{0.5975,100.597}}, color={255,0,255}),
      Text(
      string="%second",
      index=3,
      extent={{6,3},{6,3}}));
  connect(off.y, onOffHead.u3) annotation (Line(points={{-59.5,-30},{-48,-30},{-48,
          -48},{-8,-48}}, color={0,0,127}));
  connect(deMultiplex2.y1[1], variableLimiter.limit1) annotation (Line(points={{
          -26,26},{-23,26},{-23,28},{-12,28}}, color={0,0,127}));
  connect(variableLimiter.u, pumpBus.rpmSet) annotation (Line(points={{-12,20},
          {-20,20},{-20,38},{0.5975,38},{0.5975,100.597}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(onOffHead.y, criticalDamping.u)
    annotation (Line(points={{15,-40},{21,-40}}, color={0,0,127}));
  connect(pumpHead.y, pumpBus.dpMea) annotation (Line(points={{68,-39},{81,-39},
          {81,90},{0.5975,90},{0.5975,100.597}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(variableLimiter.y, onOffn.u1) annotation (Line(points={{11,20},{12,20},
          {12,28},{17,28}}, color={0,0,127}));
  connect(onOffn.u2, pumpBus.onSet) annotation (Line(points={{17,20},{14,20},{
          14,49},{36,49},{36,100.597},{0.5975,100.597}}, color={255,0,255}),
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
<h5>
  Nstart
</h5>
<p>
  The start speed of the pump will be determined from interpolation in
  the maxMinSpeedCurves table, providing the maximum speed possible at
  a given volume flow rate:
</p>
<p>
  <span style=\"font-family: Courier New;\">Nstart =</span> <span style=
  \"color: #ff0000;\">Modelica.Math.Vectors.interpolate</span>(x=pumpParam.maxMinSpeedCurves[:,1],
  y=pumpParam.maxMinSpeedCurves[:,2], xi=Qstart)
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
