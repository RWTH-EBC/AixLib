within AixLib.Airflow.WindowVentilation.Examples;
model VentilationFlowRateSimpleOpening
  "Use different empirical expressions to determine the window ventilation flow rate by simple opening"
  extends
    AixLib.Airflow.WindowVentilation.BaseClasses.PartialExampleVentilationFlowRate;
  extends Modelica.Icons.UnderConstruction;

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
  Utilities.WindProfilePowerLaw windProfilePowerLaw(hei=10, heiRef=5)
    annotation (Placement(transformation(extent={{50,20},{60,30}})));
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
  connect(windProfilePowerLaw.u, caciolo.u) annotation (Line(points={{60.5,25},
          {70,25},{70,28},{78,28}}, color={0,0,127}));
  connect(windDirection_sine.y, caciolo.phi) annotation (Line(points={{-79,0},{
          0,0},{0,20},{70,20},{70,24},{78,24}}, color={0,0,127}));
end VentilationFlowRateSimpleOpening;
