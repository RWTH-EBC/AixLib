within AixLib.Utilities.KPIs.Energy;
model ThermalEnergyMeterDual
  "Thermal energy meter for heating and cooling energy"
  extends Modelica.Icons.RoundSensor;
  parameter Boolean use_itgTim=false
    "= true, activate integral timers"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W") "Heat flow rate"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput QHea(unit="J", displayUnit="kWh")
    "Heating energy"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput QCoo(unit="J", displayUnit="kWh")
    "Cooling energy"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput timeHea(final unit="s") if use_itgTim
    "Time of heating"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput timeCoo(final unit="s") if use_itgTim
    "Time of cooling"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itgHea(
    final use_itgAct_in=false,
    final use_itgRes_in=false,
    final posItg=true) "Integration heating energy"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itgCoo(
    final use_itgAct_in=false,
    final use_itgRes_in=false,
    final posItg=false) "Integration cooling energy"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant conZero(final k=0) "Constant zero"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralTimer itgTimHea(
    final use_itgRes_in=false) if use_itgTim "Integral timer for heating"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralTimer itgTimCoo(
    final use_itgRes_in=false) if use_itgTim "Integral timer for cooling"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
equation
  connect(conZero.y, itgHea.ref) annotation (Line(points={{-79,90},{-70,90},{-70,
          64},{-62,64}}, color={0,0,127}));
  connect(conZero.y, itgCoo.ref) annotation (Line(points={{-79,90},{-70,90},{-70,
          24},{-62,24}},   color={0,0,127}));
  connect(Q_flow, itgHea.u) annotation (Line(points={{-120,0},{-80,0},{-80,70},{
          -62,70}}, color={0,0,127}));
  connect(Q_flow, itgCoo.u) annotation (Line(points={{-120,0},{-80,0},{-80,30},{
          -62,30}},   color={0,0,127}));
  connect(itgHea.y, QHea)
    annotation (Line(points={{-39,70},{110,70}}, color={0,0,127}));
  connect(itgCoo.y, QCoo)
    annotation (Line(points={{-39,30},{110,30}},   color={0,0,127}));
  connect(itgHea.isItgAct, itgTimHea.itgAct_in) annotation (Line(
      points={{-39,76},{-28,76},{-28,-50},{-10,-50},{-10,-42}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(itgCoo.isItgAct, itgTimCoo.itgAct_in) annotation (Line(
      points={{-39,36},{-30,36},{-30,-92},{-10,-92},{-10,-82}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(itgTimHea.y, timeHea) annotation (Line(
      points={{1,-30},{110,-30}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(itgTimCoo.y, timeCoo) annotation (Line(
      points={{1,-70},{110,-70}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    December 17, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>", info="<html>
<p>This model is a thermal energy meter that measures heating and cooling energy, with the option to output the heating and cooling durations.</p>
</html>"));
end ThermalEnergyMeterDual;
