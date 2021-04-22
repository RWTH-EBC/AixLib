within AixLib.Utilities.Sources.HeaterCoolerVDI6007AC1;
model tabscontrollertest
  tabsHeaterCoolerController_test tabsHeaterCoolerController_test1
    annotation (Placement(transformation(extent={{-24,-8},{-4,12}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{86,14},{106,34}})));
  Modelica.Blocks.Interfaces.RealOutput y1
    annotation (Placement(transformation(extent={{90,-20},{110,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 26)
    annotation (Placement(transformation(extent={{-56,44},{-16,66}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273.15 + 10)
    annotation (Placement(transformation(extent={{-102,-10},{-64,12}})));
equation
  connect(tabsHeaterCoolerController_test1.tabsHeatingPower, y) annotation (
      Line(points={{-5.8,4},{42,4},{42,24},{96,24}}, color={0,0,127}));
  connect(tabsHeaterCoolerController_test1.tabsCoolingPower, y1) annotation (
      Line(points={{-5.8,0},{44,0},{44,-10},{100,-10}}, color={0,0,127}));
  connect(realExpression1.y, tabsHeaterCoolerController_test1.u) annotation (
      Line(points={{-62.1,1},{-46,1},{-46,11},{-25.6,11}}, color={0,0,127}));
  connect(realExpression.y, tabsHeaterCoolerController_test1.TOpe) annotation (
      Line(points={{-14,55},{-14,12.8},{-13.8,12.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end tabscontrollertest;
