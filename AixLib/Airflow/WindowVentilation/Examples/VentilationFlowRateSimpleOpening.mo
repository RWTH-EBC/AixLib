within AixLib.Airflow.WindowVentilation.Examples;
model VentilationFlowRateSimpleOpening
  "Use different empirical expressions to determine the window ventilation flow rate by simple opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialExampleVentilationFlowRate;
  EmpiricalExpressions.WarrenParkins warrenParkins(winClrW=winClrW, winClrH=
        winClrH)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  EmpiricalExpressions.GidsPhaff gidsPhaff(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  EmpiricalExpressions.LarsenHeiselberg larsenHeiselberg(winClrW=winClrW,
      winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  EmpiricalExpressions.Caciolo caciolo(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,20},{100,40}})));
  Utilities.WindProfilePowerLaw windProfilePowerLaw(hei=5)
    annotation (Placement(transformation(extent={{50,20},{60,30}})));
  EmpiricalExpressions.Tang tang(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  EmpiricalExpressions.VDI2078 vDI2078(
    winClrW=winClrW,
    winClrH=winClrH,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimpleVDI2078)
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{70,-30},{80,-20}})));
  EmpiricalExpressions.DIN16798 dIN16798(
    winClrW=winClrW,
    winClrH=winClrH,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple)
    annotation (Placement(transformation(extent={{80,-60},{100,-40}})));
  EmpiricalExpressions.DIN4108 dIN4108(
    winClrW=winClrW,
    winClrH=winClrH,
    redeclare model OpeningArea =
        AixLib.Airflow.WindowVentilation.OpeningAreas.OpeningAreaSimple)
    annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
  EmpiricalExpressions.ASHRAE aSHRAE(winClrW=winClrW, winClrH=winClrH)
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
equation
  connect(from_degC_i.y, warrenParkins.T_i) annotation (Line(points={{-39,90},{
          -30,90},{-30,98},{78,98}}, color={0,0,127}));
  connect(from_degC_a.y, warrenParkins.T_a) annotation (Line(points={{-39,60},{
          -20,60},{-20,94},{78,94}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], warrenParkins.u_10) annotation (Line(points={{-79,
          30},{-10,30},{-10,88},{78,88}}, color={0,0,127}));
  connect(from_degC_i.y, gidsPhaff.T_i) annotation (Line(points={{-39,90},{-30,
          90},{-30,78},{78,78}}, color={0,0,127}));
  connect(from_degC_a.y, gidsPhaff.T_a) annotation (Line(points={{-39,60},{-20,
          60},{-20,74},{78,74}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], gidsPhaff.u_10) annotation (Line(points={{-79,30},
          {-10,30},{-10,68},{78,68}}, color={0,0,127}));
  connect(from_degC_i.y, larsenHeiselberg.T_i) annotation (Line(points={{-39,90},
          {-30,90},{-30,58},{78,58}}, color={0,0,127}));
  connect(from_degC_a.y, larsenHeiselberg.T_a) annotation (Line(points={{-39,60},
          {-20,60},{-20,54},{78,54}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], larsenHeiselberg.u_10) annotation (Line(points={{
          -79,30},{-10,30},{-10,48},{78,48}}, color={0,0,127}));
  connect(windDirection_sine.y, larsenHeiselberg.phi)
    annotation (Line(points={{-79,0},{0,0},{0,44},{78,44}}, color={0,0,127}));
  connect(from_degC_i.y, caciolo.T_i) annotation (Line(points={{-39,90},{-30,90},
          {-30,38},{78,38}}, color={0,0,127}));
  connect(from_degC_a.y, caciolo.T_a) annotation (Line(points={{-39,60},{-20,60},
          {-20,34},{78,34}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], windProfilePowerLaw.u_r) annotation (Line(points=
          {{-79,30},{-10,30},{-10,25},{49,25}}, color={0,0,127}));
  connect(windDirection_sine.y, caciolo.phi) annotation (Line(points={{-79,0},{
          0,0},{0,20},{74,20},{74,24},{78,24}}, color={0,0,127}));
  connect(from_degC_i.y, tang.T_i) annotation (Line(points={{-39,90},{-30,90},{
          -30,18},{78,18}}, color={0,0,127}));
  connect(from_degC_a.y, tang.T_a) annotation (Line(points={{-39,60},{-20,60},{
          -20,14},{78,14}}, color={0,0,127}));
  connect(from_degC_i.y, vDI2078.T_i) annotation (Line(points={{-39,90},{-30,90},
          {-30,-2},{78,-2}}, color={0,0,127}));
  connect(from_degC_a.y, vDI2078.T_a) annotation (Line(points={{-39,60},{-20,60},
          {-20,-6},{78,-6}}, color={0,0,127}));
  connect(const.y, vDI2078.C_ss)
    annotation (Line(points={{80.5,-25},{90,-25},{90,-22}}, color={0,0,127}));
  connect(from_degC_i.y, dIN16798.T_i) annotation (Line(points={{-39,90},{-30,
          90},{-30,-42},{78,-42}}, color={0,0,127}));
  connect(from_degC_a.y, dIN16798.T_a) annotation (Line(points={{-39,60},{-20,
          60},{-20,-46},{78,-46}}, color={0,0,127}));
  connect(windSpeed_ctt.y[1], dIN16798.u_10) annotation (Line(points={{-79,30},
          {-10,30},{-10,-52},{78,-52}}, color={0,0,127}));
  connect(windProfilePowerLaw.u, caciolo.u) annotation (Line(points={{60.5,25},
          {70,25},{70,28},{78,28}}, color={0,0,127}));
  connect(from_degC_i.y, dIN4108.T_i) annotation (Line(points={{-39,90},{-30,90},
          {-30,-62},{78,-62}}, color={0,0,127}));
  connect(from_degC_a.y, dIN4108.T_a) annotation (Line(points={{-39,60},{-20,60},
          {-20,-66},{78,-66}}, color={0,0,127}));
  connect(windProfilePowerLaw.u, dIN4108.u) annotation (Line(points={{60.5,25},
          {70,25},{70,-72},{78,-72}}, color={0,0,127}));
  connect(from_degC_i.y, aSHRAE.T_i) annotation (Line(points={{-39,90},{-30,90},
          {-30,-82},{78,-82}}, color={0,0,127}));
  connect(from_degC_a.y, aSHRAE.T_a) annotation (Line(points={{-39,60},{-20,60},
          {-20,-86},{78,-86}}, color={0,0,127}));
  connect(windProfilePowerLaw.u, aSHRAE.u) annotation (Line(points={{60.5,25},{
          70,25},{70,-92},{78,-92}}, color={0,0,127}));
  connect(windDirection_sine.y, aSHRAE.phi) annotation (Line(points={{-79,0},{0,
          0},{0,-96},{78,-96}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>April 9, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>This example checks the models that simulate the window ventilation flow rate with the simple opening.</p>
<p>The result shows that the estimated volume flow can be quite different when using different models.</p>
</html>"));
end VentilationFlowRateSimpleOpening;
