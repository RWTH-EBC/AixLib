within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialSensitivityAnalysisExample
  "Input boundary conditions of sensitivity analysis"
  Modelica.Blocks.Sources.Constant TRoomCon_degC(k=22)
    "Constant room temperature in degC"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant TAmbCon_degC(k=12)
    "Constant ambient temperature in degC"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.Ramp TAmbVar_degC(
    height=-10,
    duration=10,
    offset=22) "Variable ambient temperature in degC"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC2
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant WinSpeCon(k=0) "Constant wind speed"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Sources.Ramp WinSpeVar(
    height=10,
    duration=10,
    offset=0) "Variable wind speed"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Constant WinDirCon_deg(k=0)
    "Constant wind direction in deg"
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Sources.Ramp WinDirVar_deg(
    height=360,
    duration=10,
    offset=0) "Variable wind direction in deg"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Math.UnitConversions.From_deg from_deg1
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Modelica.Blocks.Sources.Constant WinSpeCon1(k=10)
                                                  "Constant wind speed"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(TRoomCon_degC.y, from_degC.u)
    annotation (Line(points={{-79,90},{-62,90}}, color={0,0,127}));
  connect(TAmbCon_degC.y, from_degC1.u)
    annotation (Line(points={{-79,60},{-62,60}}, color={0,0,127}));
  connect(TAmbVar_degC.y, from_degC2.u)
    annotation (Line(points={{-79,30},{-62,30}}, color={0,0,127}));
  connect(WinDirCon_deg.y, from_deg.u)
    annotation (Line(points={{-79,-60},{-62,-60}}, color={0,0,127}));
  connect(WinDirVar_deg.y, from_deg1.u)
    annotation (Line(points={{-79,-90},{-62,-90}}, color={0,0,127}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    October 21, 2025, by Jun Jiang:<br/>
    First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1608\">issue 1608</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial model provides settings for the boundary conditions used in examples of sensitivity analysis.</p>
</html>"));
end PartialSensitivityAnalysisExample;
