within AixLib.Fluid.HeatExchangers.Examples;
model TestCombiTable2D "Test case for boiler model"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Tables.CombiTable2D HeatFlowCondenserTable(table = [0.0, 273.15, 283.15; 308.15, 4800, 6300; 328.15, 4400, 5750]) annotation(Placement(transformation(extent = {{0, 40}, {20, 60}})));
  Modelica.Blocks.Sources.Ramp rampSourceTemp(height = 20, duration = 1000, offset = -5) annotation(Placement(transformation(extent = {{-80, 20}, {-60, 40}})));
  Modelica.Blocks.Sources.Constant constSinkTemp(k = 55) annotation(Placement(transformation(extent = {{-80, 60}, {-60, 80}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC annotation(Placement(transformation(extent = {{-40, 20}, {-20, 40}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1 annotation(Placement(transformation(extent = {{-40, 60}, {-20, 80}})));
equation
  connect(from_degC.u, rampSourceTemp.y) annotation(Line(points = {{-42, 30}, {-59, 30}}, color = {0, 0, 127}));
  connect(constSinkTemp.y, from_degC1.u) annotation(Line(points = {{-59, 70}, {-42, 70}}, color = {0, 0, 127}));
  connect(from_degC.y, HeatFlowCondenserTable.u2) annotation(Line(points = {{-19, 30}, {-14, 30}, {-14, 44}, {-2, 44}}, color = {0, 0, 127}));
  connect(from_degC1.y, HeatFlowCondenserTable.u1) annotation(Line(points = {{-19, 70}, {-14, 70}, {-14, 56}, {-2, 56}}, color = {0, 0, 127}));
  annotation( experiment(StopTime = 1000, Interval = 1), __Dymola_experimentSetupOutput(events = false), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Example to test the tables used within the HeatPump model</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>09.10.2013&nbsp;</i>
    by Marcus Fuchs:<br/>
    corrected error in equation</li>
 <li><i>November 25, 2013&nbsp;</i>
    by Kristian Huchtemann:<br/>
    implemented</li>
 </ul>
 </html>"));
end TestCombiTable2D;
