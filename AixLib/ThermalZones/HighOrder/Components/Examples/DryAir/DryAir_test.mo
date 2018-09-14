within AixLib.ThermalZones.HighOrder.Components.Examples.DryAir;
model DryAir_test "Simulation to test the dry air models"
  import AixLib;
  extends Modelica.Icons.Example;
  AixLib.ThermalZones.HighOrder.Components.DryAir.DynamicVentilation
    dynamicVentilation(
    pITemp(triggeredTrapezoid(falling=1), TN=60),
    HeatingLimit=288.15,
    Max_VR=0.15,
    Tset=295.15)
    annotation (Placement(transformation(extent={{-12,-14},{8,6}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload(V=100, T(
        start=303.15))
    annotation (Placement(transformation(extent={{30,-12},{50,8}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.Airload airload1(T(start=
          289.15))
    annotation (Placement(transformation(extent={{-12,70},{8,90}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.VarAirExchange varAirExchange
    annotation (Placement(transformation(extent={{-12,38},{8,58}})));
  AixLib.ThermalZones.HighOrder.Components.DryAir.InfiltrationRate_DIN12831
    infiltrationRate_DIN12831
    annotation (Placement(transformation(extent={{-12,12},{8,32}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow = 150) annotation(Placement(transformation(extent = {{-90, 72}, {-70, 92}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TempOutsideDaycurve annotation(Placement(transformation(extent = {{-90, 40}, {-70, 60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TempInside(T = 293.15) annotation(Placement(transformation(extent = {{90, 40}, {70, 60}})));
  Modelica.Blocks.Sources.Sine sine(amplitude = 7, offset = 273.15 + 13, freqHz = 1 / (3600 * 24)) annotation(Placement(transformation(extent = {{-74, 20}, {-86, 32}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 1, freqHz = 1 / 3600, offset = 1.5) annotation(Placement(transformation(extent = {{-34, 32}, {-24, 42}})));
  Modelica.Blocks.Interfaces.RealOutput realOut[4] annotation(Placement(transformation(extent = {{72, -22}, {92, -2}})));
equation
  //Connecting the most relevant outputs
  realOut[1] = airload1.T;
  realOut[2] = varAirExchange.port_b.Q_flow;
  realOut[3] = infiltrationRate_DIN12831.port_b.Q_flow;
  realOut[4] = dynamicVentilation.port_inside.Q_flow;
  connect(dynamicVentilation.port_inside, airload.port) annotation(Line(points = {{7.4, -5}, {19.5, -5}, {19.5, -4}, {31, -4}}, color = {191, 0, 0}));
  connect(fixedHeatFlow.port, airload1.port) annotation(Line(points = {{-70, 82}, {-38, 82}, {-38, 78}, {-11, 78}}, color = {191, 0, 0}));
  connect(TempOutsideDaycurve.port, varAirExchange.port_a) annotation(Line(points = {{-70, 50}, {-41, 50}, {-41, 48}, {-12, 48}}, color = {191, 0, 0}));
  connect(TempInside.port, varAirExchange.port_b) annotation(Line(points = {{70, 50}, {49, 50}, {49, 48}, {8, 48}}, color = {191, 0, 0}));
  connect(TempOutsideDaycurve.port, infiltrationRate_DIN12831.port_a) annotation(Line(points = {{-70, 50}, {-50, 50}, {-50, 22}, {-12, 22}}, color = {191, 0, 0}));
  connect(TempInside.port, infiltrationRate_DIN12831.port_b) annotation(Line(points = {{70, 50}, {40, 50}, {40, 22}, {8, 22}}, color = {191, 0, 0}));
  connect(sine.y, TempOutsideDaycurve.T) annotation(Line(points = {{-86.6, 26}, {-92, 26}, {-92, 50}}, color = {0, 0, 127}));
  connect(sine1.y, varAirExchange.InPort1) annotation(Line(points = {{-23.5, 37}, {-17.75, 37}, {-17.75, 41.6}, {-11, 41.6}}, color = {0, 0, 127}));
  connect(TempOutsideDaycurve.port, dynamicVentilation.port_outside) annotation(Line(points = {{-70, 50}, {-50, 50}, {-50, -5}, {-11.6, -5}}, color = {191, 0, 0}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(extent = {{12, 90}, {20, 82}}, lineColor = {0, 0, 255}, textString = "1"), Text(extent = {{12, 60}, {20, 52}}, lineColor = {0, 0, 255}, textString = "2"), Text(extent = {{12, 32}, {20, 24}}, lineColor = {0, 0, 255}, textString = "3"), Text(extent = {{12, 6}, {20, -2}}, lineColor = {0, 0, 255}, textString = "4")}), experiment(StopTime = 86400, Interval = 15, Algorithm = "Lsodar"), experimentSetupOutput(events = false), Documentation(revisions = "<html>
 <ul>
   <li><i>May 14, 2013&nbsp;</i> by Ole Odendahl:<br/>Implemented remaining DryAir models, adjusted existing model, documentated</li>
   <li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li><i>October 16, 2011&nbsp;</i>
          by Ana Constantin:<br/>implemented DynamicVentilation</li>
 </ul>
 </html>", info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>This simulation tests the functionality of the dry air models. Default simulation parameters are provided. </p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>The simulation consists of the following models:</p>
 <table summary=\"Models\" cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
 <td bgcolor=\"#dcdcdc\"><p>index</p></td>
 <td bgcolor=\"#dcdcdc\"><p>model</p></td>
 </tr>
 <tr>
 <td><p>1</p></td>
 <td><p><a href=\"Building.Components.DryAir.Airload\">Airload</a></p></td>
 </tr>
 <tr>
 <td><p>2</p></td>
 <td><p><a href=\"Building.Components.DryAir.VarAirExchange\">VarAirExchange</a></p></td>
 </tr>
 <tr>
 <td><p>3</p></td>
 <td><p><a href=\"Building.Components.DryAir.InfiltrationRate_DIN12831\">InfiltrationRate_DIN12831</a></p></td>
 </tr>
 <tr>
 <td><p>4</p></td>
 <td><p><a href=\"Building.Components.DryAir.DynamicVentilation\">DynamicVentilation</a></p></td>
 </tr>
 </table>
 <p>Outputs can easily be displayed via the provided outputs.</p>
 </html>"));
end DryAir_test;
