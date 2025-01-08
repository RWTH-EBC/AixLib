within AixLib.Utilities.KPIs.Energy;
model ElectricityMeter
  "Electricity meter for electric energy consumption"
  extends Modelica.Icons.RoundSensor;
  parameter Boolean use_itgTim=false
    "= true, activate integral timers"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput P(unit="W", final min=0) "Electric power"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput E(unit="J", displayUnit="kWh")
    "Electric energy"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput timeAct(final unit="s") if use_itgTim
    "Activation time of consumption"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralErrorBySign itg(
    final use_itgAct_in=false,
    final use_itgRes_in=false,
    final posItg=true) "Integration electric energy"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Constant conZero(final k=0) "Constant zero"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  AixLib.Utilities.KPIs.IntegralErrorSingleReference.IntegralTimer itgTim(
    final use_itgRes_in=false) if use_itgTim
    "Integral timer for consumption"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
equation
  connect(conZero.y, itg.ref) annotation (Line(points={{-79,90},{-70,90},{-70,-6},
          {-62,-6}}, color={0,0,127}));
  connect(P, itg.u)
    annotation (Line(points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(itg.y, E)
    annotation (Line(points={{-39,0},{110,0}}, color={0,0,127}));
  connect(itg.isItgAct, itgTim.itgAct_in) annotation (Line(
      points={{-39,6},{-28,6},{-28,-72},{-10,-72},{-10,-62}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash, if use_itgTim then LinePattern.Solid
           else LinePattern.Dash)));
  connect(itgTim.y,timeAct)  annotation (Line(
      points={{1,-50},{110,-50}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash, if use_itgTim then LinePattern.Solid
           else LinePattern.Dash)));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    January 8, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>"), Icon(graphics={Line(points={{80,-40},{60,-80},{80,-60},{60,-100}},
            color={0,0,0}), Line(points={{60,-92},{60,-100},{66,-96}}, color={0,
              0,0})}));
end ElectricityMeter;
