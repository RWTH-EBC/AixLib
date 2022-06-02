within AixLib.Systems.HydraulicModules.BaseClasses;
model PumpInterface_PumpHeadControlled
  "Head controlled polynomial based pump with controller"
  extends AixLib.Systems.HydraulicModules.BaseClasses.BasicPumpInterface;

  parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord pumpParam = AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord()
    "pump parameter record" annotation (choicesAllMatching=true);


  parameter Medium.AbsolutePressure p_start=Medium.p_default "Start value for pressure."
    annotation (Dialog(tab="Initialization", group="Pressure"));

  // Assumptions
  parameter Modelica.SIunits.Volume V=0 "Volume inside the pump"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);

  // Power and Efficiency
  parameter Boolean calculatePower=true "calc. power consumption?"
    annotation (Dialog(tab="General", group="Power and Efficiency"));
  parameter Boolean calculateEfficiency=false
    "calc. efficency? (eta = f(H, Q, P))" annotation (Dialog(
      tab="General",
      group="Power and Efficiency",
      enable=calculate_Power));

  Fluid.Movers.PumpsPolynomialBased.PumpHeadControlled physics(
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    final pumpParam=pumpParam,
    redeclare final package Medium = Medium,
    final p_start=p_start,
    final T_start=T_start,
    final V=V,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    final massDynamics=massDynamics,
    final calculatePower=calculatePower,
    final calculateEfficiency=calculateEfficiency,
    redeclare final function efficiencyCharacteristic =
        Fluid.Movers.PumpsPolynomialBased.BaseClasses.efficiencyCharacteristic.Wilo_Formula_efficiency)
    annotation (Placement(transformation(extent={{-30,-30},{30,30}})));

equation
  connect(physics.port_a, port_a) annotation (Line(points={{-30,0},{-100,0}},
                            color={0,127,255}));
  connect(physics.port_b, port_b) annotation (Line(points={{30,0},{100,0}},
                       color={0,127,255}));
  connect(physics.pumpBus, pumpBus) annotation (Line(
      points={{0,30},{0,65},{0,65},{0,100}},
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
    to dp_var (<code><span style=
    \"color: #ff0000;\">PumpControlDeltaPvar</span></code>).
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
    * Changes parameter name n_start into Nstart to be
    compatible/exchangeable with the speed controlled pump (red
    pump).<br/>
    * Adds missing parameters to be compatible with red pump.
  </li>
  <li>2017-11-22 by Peter Matthes:<br/>
    Initial implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Pump container for the
  AixLib.Fluid.Movers.PumpsPolynomialBased.PumpHeadControlled
</p>
</html>"));
end PumpInterface_PumpHeadControlled;
