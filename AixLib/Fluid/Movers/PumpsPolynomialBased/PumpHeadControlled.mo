﻿within AixLib.Fluid.Movers.PumpsPolynomialBased;
model PumpHeadControlled
  "Pump model with pump head control, an onOff-Switch and limitation of pump head."


  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;



  parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord pumpParam=
      AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord() "pump parameter record"
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


 // Parameters
  // Initialization
  parameter Modelica.SIunits.Height Hstart=Hnom "
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
  parameter Modelica.SIunits.Volume V=0 "Volume inside the pump"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);


  final parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
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
    constrainedby
    AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.baseEfficiency
    "eta = f(H, Q, P)" annotation (Dialog(
      tab="General",
      group="Power and Efficiency",
      enable=calculate_Efficiency), choicesAllMatching=true);

  // Variables
  Modelica.SIunits.Pressure dp_pump  "Pressure increase";
  Modelica.Blocks.Interfaces.RealOutput head(
    quantity="Length",
    unit="m") "Pump head";
  Modelica.SIunits.AngularVelocity n "pump speed calculated from volume flow and head n=f(Q,H)";
  Modelica.Blocks.Interfaces.RealOutput power(quantity="Power", unit="W")
    "electical power";
  Modelica.Blocks.Interfaces.RealOutput eta(
    quantity="Efficiency",
    unit="1",
    min=0) "efficiency";

  Modelica.Blocks.Sources.RealExpression Vflow_m3h(y=m_flow/rho_default*3600)
    "conversion of mass flow rate to volume flow rate"
    annotation (Placement(transformation(extent={{-100,35},{-80,55}})));

  Modelica.Blocks.Tables.CombiTable1D maxMinTable(
    columns={2,3},
    table=pumpParam.maxMinHeight,
    tableName="NoName",
    tableOnFile=false)
    "Outputs static head (H). Maximum, minimum and freely selectable pump curve"
    annotation (Placement(transformation(extent={{-75,10},{-55,30}}, rotation=0)));

  Modelica.Blocks.Routing.DeMultiplex2 deMultiplex3_1
    "Seperate max/min pump head curve signal" annotation (Placement(
        transformation(extent={{-47,10},{-27,30}}, rotation=0)));
  BaseClasses.VariableLimiter variableLimiter(strict=false)
    "Limit pump head to max/min curve" annotation (Placement(transformation(
          extent={{-10,10},{10,30}}, rotation=0)));

  BaseClasses.PumpBus pumpBus annotation (Placement(transformation(extent={{-19,
            81},{20,120}}), iconTransformation(extent={{-20,80},{20,120}})));

protected
  Modelica.Blocks.Sources.RealExpression pumpPower(y=power) if calculatePower
    "implements a connectable object that can be cuppled with pumpBus."
    annotation (Placement(transformation(extent={{-100,66},{-80,86}})));
  Modelica.Blocks.Sources.RealExpression pumpHead(y=head)
    "implements a connectable object that can be cuppled with pumpBus."
    annotation (Placement(transformation(extent={{73,-20},{93,0}})));
  Modelica.Blocks.Sources.RealExpression pumpEfficiency(y=eta) if
    calculateEfficiency
    "implements a connectable object that can be cuppled with pumpBus."
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant off(k=0)
    annotation (Placement(transformation(extent={{23,7},{33,17}})));
  Modelica.Blocks.Sources.RealExpression pressure_difference(y=-dp_pump)
    "implements a connectable object that can be cuppled with pumpBus."
    annotation (Placement(transformation(extent={{-71,-76},{-51,-56}})));
  Modelica.Blocks.Continuous.CriticalDamping
                                    criticalDamping(
    y_start=Hstart,
    f=1/5,
    initType=Modelica.Blocks.Types.Init.InitialOutput)
    annotation (Placement(transformation(extent={{50,-20},{70,0}})));
public
  Modelica.Blocks.Logical.Switch onOff
    annotation (Placement(transformation(extent={{48,10},{68,30}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=n)
    annotation (Placement(transformation(extent={{9,34},{29,54}})));

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
    p_start=p_start,
    T_start=T_start,
    m_flow_nominal=m_flow_nominal,
    m_flow_small=1E-4*abs(m_flow_nominal),
    allowFlowReversal=allowFlowReversal,
    final V=V,
    nPorts=2) annotation (Placement(transformation(extent={{23,-80},{43,-60}})));
equation


  connect(maxMinTable.u[1], Vflow_m3h.y)
    "for the interpolation of the max curve"
    annotation (Line(points={{-77,20},{-77,45},{-79,45}}, color={0,0,127}));
  connect(maxMinTable.u[2], Vflow_m3h.y)
    "for the interpolation of the min curve"
    annotation (Line(points={{-77,20},{-77,45},{-79,45}}, color={0,0,127}));

  head = criticalDamping.y "safe head after limiting and other checks.";
  dp_pump = head * rho_default * Modelica.Constants.g_n;
  //Calculate power and Efficiency
  if pumpBus.onSet and head >
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cHQN,
      Modelica.Constants.small,
      pumpParam.nMin*0.9) then
    if calculatePower then
      n = max(0,
        AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomialABCinverse(
        {pumpParam.cHQN[3, 1],pumpParam.cHQN[2, 2],pumpParam.cHQN[1, 3]},
        Vflow_m3h.y,
        head)) "n can be calculated with inverse ABC formula or with a solver
        when using the full information in pumpParam.cHQN.";
      power = AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
        pumpParam.cPQN,
        Vflow_m3h.y,
        n) "will not check for negative values";
    else
      n = 0;
      power = 0;
    end if;

    eta = if (calculateEfficiency) and power >
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cPQN,
      Modelica.Constants.small,
      pumpParam.nMin*0.9) then efficiencyCharacteristic(
      Vflow_m3h.y,
      head,
      power,
      rho_default) else 0;
  else
    n = 0;
    power = 0;
    eta = 0;
  end if;

  connect(maxMinTable.y, deMultiplex3_1.u) annotation (Line(
      points={{-54,20},{-49,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(deMultiplex3_1.y2[1], variableLimiter.limit2) annotation (Line(
      points={{-26,14},{-11,14},{-11,12},{-12,12}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(pumpPower.y, pumpBus.PelMea) annotation (Line(points={{-79,76},{-66,
          76},{-66,93},{0.5975,93},{0.5975,100.597}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpHead.y, pumpBus.dpMea) annotation (Line(points={{94,-10},{95,-10},
          {95,90},{0.5975,90},{0.5975,100.597}},color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpEfficiency.y, pumpBus.efficiencyMea) annotation (Line(points={{-79,60},
          {-62,60},{-62,100.597},{0.5975,100.597}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(onOff.u2, pumpBus.onSet) annotation (Line(points={{46,20},{38,20},{38,
          100.597},{0.5975,100.597}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(off.y, onOff.u3)
    annotation (Line(points={{33.5,12},{46,12}}, color={0,0,127}));
  connect(deMultiplex3_1.y1[1], variableLimiter.limit1) annotation (Line(points=
         {{-26,26},{-14,26},{-14,28},{-12,28}}, color={0,0,127}));
  connect(variableLimiter.y, onOff.u1) annotation (Line(points={{11,20},{15,20},
          {15,28},{46,28}}, color={0,0,127}));
  connect(Vflow_m3h.y, pumpBus.vFRcur_m3h) annotation (Line(points={{-79,45},{-56,
          45},{-56,85},{0.5,85},{0.5,100.5}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(variableLimiter.u, pumpBus.dpSet) annotation (Line(points={{-12,20},{
          -19,20},{-19,100.597},{0.5975,100.597}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(realExpression.y, pumpBus.rpmMea) annotation (Line(points={{30,44},{
          30,100.597},{0.5975,100.597}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(pressure_difference.y,idealSource. dp_in)
    annotation (Line(points={{-50,-66},{-15,-66},{-15,-72}}, color={0,0,127}));
  connect(idealSource.port_a, port_a) annotation (Line(points={{-31,-80},{-81,-80},
          {-81,0},{-100,0}}, color={0,127,255}));
  connect(idealSource.port_b,vol. ports[1])
    annotation (Line(points={{-11,-80},{31,-80}}, color={0,127,255}));
  connect(vol.ports[2], port_b)
    annotation (Line(points={{35,-80},{100,-80},{100,0}}, color={0,127,255}));
  connect(onOff.y, criticalDamping.u) annotation (Line(points={{69,20},{70,20},{
          70,5},{41,5},{41,-10},{48,-10}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1})),
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
          fillColor={170,213,255}),
        Polygon(
          points={{-28,64},{-28,-40},{54,12},{-28,64}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={220,220,220})}),
    Documentation(info="<html><h4>
  Overview
</h4>
<p>
  Simple model for a pump that sets pump speed (headUnbound) and can
  compute pump power and efficiency from polynomial functions. Pump
  speed (n) will be calculated from volume flow rate and pump head
  n=f(Q,H). Pump head (pressure difference in meter water column) is
  limited by pumpParam.maxMinHeight. This is used in 2Dtable
  maxMinTable. Those curves are normally derived from an electronic
  power limitation of a pump.
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
  Controlling the pump (pumpBus.dp_Input)
</h4>
<p>
  The pump must be controlled by setting the pump head
  (pumpBus.dp_Input). dp_Input must be given in meter water column.
  This is an idealized pump that can maintain the given pump pressure
  difference at all times. The hydraulic network's pressure difference
  will then determine the resulting volume flow. The idealized
  calculation in this model maybe advantegous in terms of speed in
  comparison to the red pump that will compute pressure head from
  volume flow rate and pump speed via polynomial functions. To make the
  two pumps exchangeable also the controllers must be exchangeable.
</p>
<h4>
  Power and Efficiency calculation
</h4>
<p>
  The power and the efficiency of the pump can be calculated, with the
  help of polynomial aproximations. Only use them if you have correct /
  complete data about the pump. The efficiency calculation depends on
  pump power. Pump power depends on correct pump speed. Therefore, in
  this model, the pump speed (n) will be approximated from volume flow
  rate (v_dot_m3_h) and pump head (head) using the inverse of the ABC
  formula. Only for this simple case of a quadratic polynomial the
  equation H=f(Q,N) can be inverted to the form N=f(Q,H). If you use
  more coefficients in the polynomial (cHQN) the inversion makes no
  sense and the calculated pump speed will probably be wrong leading to
  a useless power usage assumption. Therefore, an assertion will check
  if
  parameter&#160;'calculatePower'&#160;was&#160;set&#160;true&#160;but&#160;the&#160;corresponding&#160;coefficients
  in&#160;pumpParam.cHQN&#160;([3,1],&#160;[2,2]&#160;and&#160;[1,3])&#160;are&#160;all&#160;zero&#160;OR&#160;if
  there&#160;are&#160;more&#160;than&#160;those&#160;3&#160;coefficients&#160;defined&#160;in&#160;cHQN.&#160;
</p>
<p>
  See the examples under package \"Examples\".
</p>
<h4>
  Hints
</h4>
<p>
  Qnom, the nominal or design volume flow rate of the pump, is given in
  m³/h and should be selected by the engineer. A good default value
  would be 67 % of Qmax .The default value, however, is set to
  <span style=\"font-family: Courier New;\">0.5*</span><span style=
  \"color: #ff0000;\">max</span>(pumpParam.maxMinSpeedCurves[:,&#160;1]).
  max(pumpParam.maxMinSpeedCurves[:, 1]) is the maximum value found in
  column 1 of table maxMinSpeedCurves. This however, is more than the
  real maximum volume flow rate of the pump as the the table is
  extended by additional rows for proper extrapolation of table values.
  In order to compensate for this excess value Qnom is by default only
  at 50 % of the maxMinSpeedCurves value. Please refer to the
  referenceDataQHPN matrix to find the real Qmax value. A simple
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
<ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming, restructuring and bug fixes.
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
    off as well. Be aware that the pump speed will only be calculated
    when calculatePower==true.<br/>
    * n has been converted into a RealOutput instead of a normal
    Real.<br/>
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
    * Renamed delivery head controlled pump model (blue) from Pump into
    PumpH as well as PumpPhysics into PumpPhysicsH. \"H\" stands for pump
    delivery head.<br/>
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
    * Changes parameter name n_start into Nstart to be
    compatible/exchangeable with the speed controlled pump (red
    pump).<br/>
    * Removes unused code and remarks from the model.<br/>
    * Adds start parameters to the model and updates parameter
    equations (for Qnom for example).<br/>
    * Removes old headUnbound calculation via function of Q and N. Now
    sets bus.dp_Input directly.
  </li>
  <li>2017-12-01 by Peter Matthes:<br/>
    Changed pump due to removed parameters pumpParam.cABCeq and .cNQH.
  </li>
  <li>2017-11-22 by Peter Matthes:<br/>
    Prepares new pump model for external controller<br/>
    * Adds pumpBus connections for volume flow rate (vFRcur_m3h) and
    maximum/minimum pump head (maxMinHead).<br/>
    * Adds graphical annotations for v_dot_m3_h and headUnbound<br/>
    * Changes pump icon color to light blue to make a distinction to
    the other pumps.<br/>
    * Fixes documentation.
  </li>
  <li>2017-11-21 by Peter Matthes:<br/>
    Adds parameters n_start, Qnom and Hnom with defaults. Changes text
    in Icon view.
  </li>
  <li>2017-11-16 by Peter Matthes:<br/>
    Updated assertion for pumpParam.cABCeq and adds a second for
    pumpParam.cHQN and pumpParam.cNQH.<br/>
    * Removes all control strategies except n_set and
    fullFieldTable.<br/>
    * Removes pumpControlBlockDay component.<br/>
    * Adds instead (of pumpControlBlockDay.Head_calc).<br/>
    * Removes all unused parameters in pump model.<br/>
    * Adds new parameter useABCformulas.<br/>
    * Adds new equations for headUnbound and pump speed and power.<br/>
    * n_set becomes default control algorithm.<br/>
    * Changes start pressure of pump volume from p_b_start to
    p_a_start.<br/>
    (We normally know what the minimum pressure point before the
    pump<br/>
    should be.)
  </li>
  <li>2017-11-13 by Peter Matthes:<br/>
    Implemented. Non functional yet.
  </li>
</ul>
</html>"));
end PumpHeadControlled;
