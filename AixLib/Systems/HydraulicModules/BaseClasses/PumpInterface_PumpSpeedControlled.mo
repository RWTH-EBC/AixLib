within AixLib.Systems.HydraulicModules.BaseClasses;
model PumpInterface_PumpSpeedControlled
  "Speed controlled polynomial based pump with controller"
  extends AixLib.Systems.HydraulicModules.BaseClasses.BasicPumpInterface;
  parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord pumpParam
    "pump parameter record" annotation (choicesAllMatching=true);

  replaceable
    AixLib.Fluid.Movers.PumpsPolynomialBased.Controls.CtrlPassThroughN
    pumpController(pumpParam=pumpParam) constrainedby
    Fluid.Movers.PumpsPolynomialBased.Controls.BaseClasses.PumpController
    annotation (
    Dialog(enable=true, tab="Control Strategy"),
    Placement(transformation(extent={{-20,40},{20,80}})),
    __Dymola_choicesAllMatching=true);

  parameter Real Qnom(
    quantity="VolumeFlowRate",
    unit="m3/h",
    displayUnit="m3/h") = 0.67*max(pumpParam.maxMinSpeedCurves[:, 1]) "<html>Nominal volume flow rate in m³/h (~0.67*Qmax).<br/>
</html>" annotation (Dialog(
        tab="Control Strategy", group="Design point for dp_var control"));
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm Nnom=
      Modelica.Math.Vectors.interpolate(
      x=pumpParam.maxMinSpeedCurves[:, 1],
      y=pumpParam.maxMinSpeedCurves[:, 2],
      xi=Qnom) "<html><br/>
Pump speed in design point (Qnom,Hnom).<br/>
Default is maximum speed at Qnom from pumpParam.maxMinSpeedCurves.<br/>
Note that N is defined only on [nMin, nMax]. Due to power
limitation<br/>
maller than nMax for higher Q.
</html>" annotation (Dialog(tab=
          "Control Strategy", group="Design point for dp_var control"));
  parameter Modelica.SIunits.Height Hnom=
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cHQN,
      Qnom,
      Nnom) "<html><br/>
Nominal pump head in m (water).<br/>
Will by default be calculated automatically from Qnom and Nnom.<br/>
change the value make sure to also set a feasible Qnom.
</html>"
    annotation (Dialog(tab="Control Strategy", group=
          "Design point for dp_var control"));
  parameter Modelica.SIunits.Height H0=0.5*Hnom
    "Pump head at Q == 0 m3/h (defines left point of dp_var line)." annotation (
     Dialog(tab="Control Strategy", group="Design point for dp_var control"));

  parameter Real Qstart(
    quantity="VolumeFlowRate",
    unit="m3/h",
    displayUnit="m3/h") = Qnom "<html>Volume flow rate in m³/h at start of simulation.<br/>
.
</html>"
    annotation (Dialog(tab="Initialization", group="Volume flow"));
  parameter Medium.MassFlowRate m_flow_start=physics.m_flow_start "<html><br/>
Start value of m_flow in port_a.m_flow<br/>
Used to initialize ports a and b and for initial checks of model.<br/>
Use it to conveniently initialize upper level models' start mass flow
rate.<br/>
default.
</html>"
    annotation (Dialog(
      tab="Initialization",
      group="Volume flow",
      enable=false));

  parameter Modelica.SIunits.Height Hstart=max(0,
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cHQN,
      Qstart,
      Nnom)) "<html><br/>
Start value of pump head. Will be used to initialize criticalDamping
block<br/>
and pressure in ports a and b.<br/>
Default is to calculate it from Qstart and Nnom. If you change the
value<br/>
e to also set Qstart to a suitable value.
</html>"
    annotation (Dialog(tab="Initialization", group="Pressure"));



  // Assumptions
  parameter Boolean checkValve=false "= true to prevent reverse flow"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.Volume V=0 "Volume inside the pump"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  // Power and Efficiency
  parameter Boolean calculatePower=false "calc. power consumption?"
    annotation (Dialog(tab="General", group="Power and Efficiency"));
  parameter Boolean calculateEfficiency=false
    "calc. efficency? (eta = f(H, Q, P))" annotation (Dialog(
      tab="General",
      group="Power and Efficiency",
      enable=calculate_Power));

  Fluid.Movers.PumpsPolynomialBased.PumpSpeedControlled physics(
    pumpParam=pumpParam,
    Qnom=Qnom,
    Nnom=Nnom,
    Hnom=Hnom,
    redeclare package Medium = Medium,
    Qstart=Qstart,
    p_a_start=Medium.p_default,
    T_start=T_start,
    checkValve=checkValve,
    V=V,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    massDynamics=massDynamics,
    calculatePower=calculatePower,
    calculateEfficiency=calculateEfficiency,
    redeclare function efficiencyCharacteristic =
        Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.Wilo_Formula_efficiency)
    annotation (Placement(transformation(extent={{-30,-48},{30,12}})));

equation
  connect(pumpController.pumpBus, physics.pumpBus) annotation (Line(
      points={{0,40},{0,12}},
      color={255,204,51},
      thickness=0.5));
  connect(physics.port_a, port_a) annotation (Line(points={{-30,-18},{-66,-18},{
          -66,0},{-100,0}}, color={0,127,255}));
  connect(physics.port_b, port_b) annotation (Line(points={{30,-18},{66,-18},{66,
          0},{100,0}}, color={0,127,255}));
  connect(pumpController.pumpControllerBus, pumpBus) annotation (Line(
      points={{0,80},{0,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
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
          extent={{80,-20},{300,-38}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          fontName="monospace",
          textString="%pumpParam.pumpModelString%")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming and extension from BasicPumpInterface.
  </li>
  <li>2018-03-01 by Peter Matthes:<br/>
    Improved parameter setup of pump model. Ordering in GUI, disabled
    some parameters that should be used not as input but rather as
    outputs (m_flow_start, p_a_start and p_b_start) and much more
    description in the parameter doc strings to help the user make
    better decisions.
  </li>
  <li>2018-02-01 by Peter Matthes:<br/>
    Fixes option choicesAllMatching=true for controller. Needs to be
    __Dymola_choicesAllMatching=true. Sets standard control algorithm
    to n_set (<code><span style=
    \"color: #ff0000;\">PumpControlNset</span></code>).
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
    * Moves the energyBanlance and massBalance to the Assumptions tab
    as done in the PartialLumpedVolume model.<br/>
    * Removes replaceable function for efficiency calculation. There is
    only one formula at the moment and no change in sight so that we
    can declutter the GUI.<br/>
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
    * In calculation of m_flow_start changes reference to X_start into
    physics.X_start.<br/>
    * Changes Nnom from 80 % to 100 % of Nmax.
  </li>
  <li>2018-01-15 by Peter Matthes:<br/>
    Changes minimum mass flow rate in ports to
    +/-<code>1.5*<span style=\"color: #ff0000;\">max</span>(pumpParam.maxMinSpeedCurves[:,&#160;1])</code>
    in order to reduce search space.
  </li>
  <li>2018-01-10 by Peter Matthes:<br/>
    Adds parameter T_start to be compatible with PumpPyhsicsNbound
    model. This way this parameter can be transfert automatically when
    changing classes.
  </li>
  <li>2017-12-12 by Peter Matthes:<br/>
    Changes parameter name n_start into Nnom.
  </li>
  <li>2017-12-05 by Peter Matthes:<br/>
    Initial implementation (derived from Pump model with limitation of
    pump head). Changes nominal volume flow rate to
    \"Qnom=0.5*max(pumpParam.maxMinSpeedCurves[:,1])\".
  </li>
</ul>
</html>", info="<html>
<p>
  Pump container for the
  AixLib.Fluid.Movers.PumpsPolynomialBased.PumpSpeedControlled
</p>
</html>"));
end PumpInterface_PumpSpeedControlled;
