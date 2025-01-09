within AixLib.Utilities.KPIs.IndoorAirQuality;
model Co2DIN16798 "CO2 concentration assessment based on DIN EN 16798-1"
  parameter Boolean use_itgAct_in=false
    "= true, enable activation connector; = false, disable connector, integrator continuously activated"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean use_itgTim=false
    "= true, activate integral timers"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Real co2ConAmb = 400 "Ambient CO2 concentration";
  Modelica.Blocks.Interfaces.BooleanInput itgAct_in if use_itgAct_in
    "Conditional connector to activate integrator"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput co2Con(final min=0) "CO2 concentration in ppm"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  AixLib.Utilities.KPIs.IndoorAirQuality.Co2FixedLimit fixLimCat1(
    final use_itgAct_in=use_itgAct_in,
    final resItgInBou=false,
    final use_itgTim=use_itgTim,
    final resItgTimInBou=false,
    final co2ConLim=co2ConAmb + 350) "Fixed limit for category I"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  AixLib.Utilities.KPIs.IndoorAirQuality.Co2FixedLimit fixLimCat2(
    final use_itgAct_in=use_itgAct_in,
    final resItgInBou=false,
    final use_itgTim=use_itgTim,
    final resItgTimInBou=false,
    final co2ConLim=co2ConAmb + 550) "Fixed limit for category II"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  AixLib.Utilities.KPIs.IndoorAirQuality.Co2FixedLimit fixLimCat3(
    final use_itgAct_in=use_itgAct_in,
    final resItgInBou=false,
    final use_itgTim=use_itgTim,
    final resItgTimInBou=false,
    final co2ConLim=co2ConAmb + 900) "Fixed limit for category III"
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  AixLib.Utilities.KPIs.IndoorAirQuality.Co2FixedLimit fixLimCat4(
    final use_itgAct_in=use_itgAct_in,
    final resItgInBou=false,
    final use_itgTim=use_itgTim,
    final resItgTimInBou=false,
    final co2ConLim=co2ConAmb + 1350) "Fixed limit for category IV"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Interfaces.RealOutput ppmSecOutBouCat1(final unit="s")
    "Total ppm-second out of bound of category I"
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput ppmSecOutBouCat2(final unit="s")
    "Total ppm-second out of bound of category II"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput ppmSecOutBouCat3(final unit="s")
    "Total ppm-second out of bound of category III"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput ppmSecOutBouCat4(final unit="s")
    "Total ppm-second out of bound of category IV"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput totTimeOutBouCat1(final unit="s")
    if use_itgTim "Total time out of bound of category I"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput totTimeOutBouCat2(final unit="s")
    if use_itgTim "Total time out of bound of category II"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput totTimeOutBouCat3(final unit="s")
    if use_itgTim "Total time out of bound of category III"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Interfaces.RealOutput totTimeOutBouCat4(final unit="s")
    if use_itgTim "Total time out of bound of category IV"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
equation
  connect(co2Con, fixLimCat1.co2Con) annotation (Line(points={{-120,0},{-80,0},{
          -80,70},{-62,70}}, color={0,0,127}));
  connect(co2Con, fixLimCat2.co2Con) annotation (Line(points={{-120,0},{-80,0},{
          -80,30},{-62,30}}, color={0,0,127}));
  connect(co2Con, fixLimCat3.co2Con) annotation (Line(points={{-120,0},{-80,0},{
          -80,-10},{-62,-10}}, color={0,0,127}));
  connect(co2Con, fixLimCat4.co2Con) annotation (Line(points={{-120,0},{-80,0},{
          -80,-50},{-62,-50}}, color={0,0,127}));
  connect(fixLimCat1.ppmSecOutBou, ppmSecOutBouCat1) annotation (Line(points={{-39,
          70},{60,70},{60,90},{110,90}}, color={0,0,127}));
  connect(fixLimCat2.ppmSecOutBou, ppmSecOutBouCat2) annotation (Line(points={{-39,
          30},{62,30},{62,70},{110,70}}, color={0,0,127}));
  connect(fixLimCat3.ppmSecOutBou, ppmSecOutBouCat3) annotation (Line(points={{-39,
          -10},{64,-10},{64,50},{110,50}}, color={0,0,127}));
  connect(fixLimCat4.ppmSecOutBou, ppmSecOutBouCat4) annotation (Line(points={{-39,
          -50},{66,-50},{66,30},{110,30}}, color={0,0,127}));
  connect(itgAct_in, fixLimCat1.itgAct_in) annotation (Line(
      points={{0,-120},{0,58},{-50,58}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgAct_in then LinePattern.Solid else LinePattern.Dash)));
  connect(itgAct_in, fixLimCat2.itgAct_in) annotation (Line(
      points={{0,-120},{0,18},{-50,18}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgAct_in then LinePattern.Solid else LinePattern.Dash)));
  connect(itgAct_in, fixLimCat3.itgAct_in) annotation (Line(
      points={{0,-120},{0,-22},{-50,-22}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgAct_in then LinePattern.Solid else LinePattern.Dash)));
  connect(itgAct_in, fixLimCat4.itgAct_in) annotation (Line(
      points={{0,-120},{0,-62},{-50,-62}},
      color={255,0,255},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgAct_in then LinePattern.Solid else LinePattern.Dash)));
  connect(fixLimCat1.totTimeOutBou, totTimeOutBouCat1) annotation (Line(
      points={{-39,63},{80,63},{80,-30},{110,-30}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(fixLimCat2.totTimeOutBou, totTimeOutBouCat2) annotation (Line(
      points={{-39,23},{82,23},{82,-50},{110,-50}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(fixLimCat3.totTimeOutBou, totTimeOutBouCat3) annotation (Line(
      points={{-39,-17},{84,-17},{84,-70},{110,-70}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  connect(fixLimCat4.totTimeOutBou, totTimeOutBouCat4) annotation (Line(
      points={{-39,-57},{86,-57},{86,-90},{110,-90}},
      color={0,0,127},
      pattern=DynamicSelect(LinePattern.Dash,
        if use_itgTim then LinePattern.Solid else LinePattern.Dash)));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model assesses room CO<sub>2</sub> concentration according to DIN EN 16798-1.</p>
</html>", revisions="<html>
<ul>
  <li>
    January 9, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1534\">issue 1534</a>)
  </li>
</ul>
</html>"));
end Co2DIN16798;
