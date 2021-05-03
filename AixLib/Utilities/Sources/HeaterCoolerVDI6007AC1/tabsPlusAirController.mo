within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model tabsPlusAirController
  Modelica.Blocks.Interfaces.RealInput tabsPower
    annotation (Placement(transformation(extent={{-120,24},{-80,64}})));
  Modelica.Blocks.Interfaces.BooleanInput HeaterCoolerActiveInput
    annotation (Placement(transformation(extent={{-120,-44},{-80,-4}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-18,34},{2,54}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-58,34},{-38,54}})));
  Modelica.Blocks.Interfaces.BooleanOutput HeaterCoolerActiveOutput
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));
equation
  connect(tabsPower, greaterThreshold.u)
    annotation (Line(points={{-100,44},{-60,44}}, color={0,0,127}));
  connect(greaterThreshold.y, not1.u)
    annotation (Line(points={{-37,44},{-20,44}}, color={255,0,255}));
  connect(HeaterCoolerActiveInput, and1.u2) annotation (Line(points={{-100,-24},
          {-32,-24},{-32,-8},{20,-8}}, color={255,0,255}));
  connect(not1.y, and1.u1)
    annotation (Line(points={{3,44},{20,44},{20,0}}, color={255,0,255}));
  connect(and1.y, HeaterCoolerActiveOutput)
    annotation (Line(points={{43,0},{102,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end tabsPlusAirController;
