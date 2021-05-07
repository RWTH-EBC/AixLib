within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model tabsPlusAirController
  Modelica.Blocks.Interfaces.RealInput tabsHeatPower
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.BooleanInput HeaterActiveInput
    annotation (Placement(transformation(extent={{-120,10},{-80,50}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Interfaces.BooleanOutput HeaterActiveOutput
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.BooleanInput CoolerActiveInput
    annotation (Placement(transformation(extent={{-120,-90},{-80,-50}})));
  Modelica.Blocks.Interfaces.RealInput tabsCoolPower
    annotation (Placement(transformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Interfaces.BooleanOutput CoolerActiveOutput
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
equation
  connect(tabsHeatPower, greaterThreshold.u)
    annotation (Line(points={{-100,70},{-62,70}}, color={0,0,127}));
  connect(greaterThreshold.y, not1.u)
    annotation (Line(points={{-39,70},{-22,70}}, color={255,0,255}));
  connect(HeaterActiveInput, and1.u2) annotation (Line(points={{-100,30},{-28,
          30},{-28,42},{18,42}}, color={255,0,255}));
  connect(not1.y, and1.u1) annotation (Line(points={{1,70},{6,70},{6,50},{18,50}},
        color={255,0,255}));
  connect(and1.y, HeaterActiveOutput)
    annotation (Line(points={{41,50},{110,50}}, color={255,0,255}));
  connect(tabsCoolPower, lessThreshold.u)
    annotation (Line(points={{-100,-30},{-62,-30}}, color={0,0,127}));
  connect(lessThreshold.y, not2.u)
    annotation (Line(points={{-39,-30},{-22,-30}}, color={255,0,255}));
  connect(not2.y, and2.u1) annotation (Line(points={{1,-30},{14,-30},{14,-50},{
          18,-50}}, color={255,0,255}));
  connect(CoolerActiveInput, and2.u2) annotation (Line(points={{-100,-70},{-38,
          -70},{-38,-58},{18,-58}}, color={255,0,255}));
  connect(and2.y, CoolerActiveOutput)
    annotation (Line(points={{41,-50},{110,-50}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end tabsPlusAirController;
