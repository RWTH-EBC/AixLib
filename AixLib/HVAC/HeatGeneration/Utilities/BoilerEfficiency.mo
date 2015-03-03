within AixLib.HVAC.HeatGeneration.Utilities;


model BoilerEfficiency
  "Boiler efficiency as a linear interpolation between table values for a basic boiler model"
  import AixLib;
  parameter AixLib.DataBase.Boiler.BoilerEfficiencyBaseDataDefinition boilerEfficiencyBE = AixLib.DataBase.Boiler.BoilerConst()
    "boiler efficiency as a function of part-load factor"                                                                                                     annotation(choicesAllMatching = true);
  parameter Modelica.SIunits.Power Q_flow_max = 20000
    "Maximum heat output of boiler at full load";
  Modelica.Blocks.Interfaces.RealInput heatDemand annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}})));
  Modelica.Blocks.Interfaces.RealOutput fuelUse annotation(Placement(transformation(extent = {{96, -10}, {116, 10}})));
  Modelica.Blocks.Math.Division division annotation(Placement(transformation(extent = {{40, 30}, {60, 50}})));
  Modelica.Blocks.Tables.CombiTable1Ds tableBoilerEff(columns = {2}, table = boilerEfficiencyBE.boilerEfficiency) annotation(Placement(transformation(extent = {{0, 10}, {20, 30}})));
  Modelica.Blocks.Math.Division division1 annotation(Placement(transformation(extent = {{-30, -16}, {-10, 4}})));
  Modelica.Blocks.Sources.Constant const1(k = Q_flow_max) annotation(Placement(transformation(extent = {{-78, -50}, {-58, -30}})));
equation
  connect(const1.y, division1.u2) annotation(Line(points = {{-57, -40}, {-52, -40}, {-52, -12}, {-32, -12}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(heatDemand, division1.u1) annotation(Line(points = {{-100, 0}, {-32, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(heatDemand, division.u1) annotation(Line(points = {{-100, 0}, {-60, 0}, {-60, 46}, {38, 46}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(division.y, fuelUse) annotation(Line(points = {{61, 40}, {74, 40}, {74, 0}, {106, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(division1.y, tableBoilerEff.u) annotation(Line(points = {{-9, -6}, {-8, -6}, {-8, 20}, {-2, 20}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(tableBoilerEff.y[1], division.u2) annotation(Line(points = {{21, 20}, {28, 20}, {28, 34}, {38, 34}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(revisions = "<html>
 <p>09.10.2013, Marcus Fuchs</p>
 <ul>
 <li>Changed table values to be calculated according to a given value of eta at full load operation</li>
 </ul>
 <p>07.10.2013, Marcus Fuchs</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>", info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p><br/>This boiler efficiency specifies a table for eta at different part load conditions. The values are somewhat similar to the lowest curve in Recknagel, Sprenger 2009 DVD p. 822. This describes a simple boiler (no low temperature operation, no flue gas condensation)</p>
 </html>"));
end BoilerEfficiency;
