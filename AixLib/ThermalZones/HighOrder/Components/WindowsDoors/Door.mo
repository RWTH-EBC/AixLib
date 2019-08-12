within AixLib.ThermalZones.HighOrder.Components.WindowsDoors;
model Door "Simple door"
  parameter Modelica.SIunits.Area door_area = 2 "Total door area" annotation(Dialog(group = "Geometry"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer U = 1.8
    "Thermal transmission coefficient"                                                            annotation(Dialog(group = "Properties"));
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature"                                                                                      annotation(Dialog(group = "Properties"));
  parameter Modelica.SIunits.Emissivity eps = 0.9 "Emissivity of door material" annotation(Dialog(group = "Properties"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-100, -10}, {-80, 10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent = {{80, -10}, {100, 10}})));
  Utilities.HeatTransfer.HeatToStar twoStar_RadEx(Therm(T(start = T0)), Star(T(start = T0)), A = door_area, eps = eps) annotation(Placement(transformation(extent = {{30, 50}, {50, 70}})));
  Utilities.Interfaces.Star Star annotation(Placement(transformation(extent = {{80, 50}, {100, 70}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatTrans(G = door_area * U) annotation(Placement(transformation(extent = {{-10, -8}, {10, 12}})));
  Utilities.HeatTransfer.HeatToStar twoStar_RadEx1(Therm(T(start = T0)), Star(T(start = T0)), A = door_area, eps = eps) annotation(Placement(transformation(extent = {{-32, 50}, {-52, 70}})));
  Utilities.Interfaces.Star Star1 annotation(Placement(transformation(extent = {{-100, 50}, {-80, 70}})));
equation
  connect(twoStar_RadEx.Star, Star) annotation(Line(points = {{49.1, 60}, {90, 60}}, pattern = LinePattern.Solid));
  connect(port_a, HeatTrans.port_a) annotation(Line(points = {{-90, 0}, {-49.5, 0}, {-49.5, 2}, {-10, 2}}));
  connect(HeatTrans.port_b, port_b) annotation(Line(points = {{10, 2}, {49.5, 2}, {49.5, 0}, {90, 0}}));
  connect(twoStar_RadEx.Therm, HeatTrans.port_b) annotation(Line(points = {{30.8, 60}, {20, 60}, {20, 2}, {10, 2}}, color = {191, 0, 0}));
  connect(twoStar_RadEx1.Therm, HeatTrans.port_a) annotation(Line(points = {{-32.8, 60}, {-20, 60}, {-20, 2}, {-10, 2}}, color = {191, 0, 0}));
  connect(twoStar_RadEx1.Star, Star1) annotation(Line(points = {{-51.1, 60}, {-90, 60}}, color = {95, 95, 95}, pattern = LinePattern.Solid));
  annotation(Dialog(group = "Air exchange"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Line(points = {{-40, 18}, {-36, 18}}, color = {255, 255, 0}), Rectangle(extent = {{-52, 82}, {48, -78}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-46, 76}, {40, -68}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, fillColor = {127, 0, 0}), Rectangle(extent = {{28, 12}, {36, 0}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>The<b> Door</b> model models </p>
 <ul>
 <li>the conductive heat transfer through the door with a U-Value is set to 1.8 W/(m&sup2;K) (EnEV2009)</li>
 <li>the radiative heat transfer on both sides</li>
 </ul>
 <h4><span style=\"color:#008000\">Assumptions</span></h4>
 <ul>
 <li>Constant U-value.</li>
 </ul>
 <h4><span style=\"color:#008000\">References/ U-values special doors</span></h4>
 <ul>
 <li>Doors of wood or plastic 40 mm: 2,2 W/(m&sup2;K)</li>
 <li>Doors of wood 60 mm: 1,7 W/(m&sup2;K)</li>
 <li>Doors of wood with glass:</li>
 <li>7 mm wired glass: 4,5 W/(m&sup2;K)</li>
 <li>20 mm insulated glass: 2,8 W/(m&sup2;K) </li>
 </ul>
 <p>- Doors with a frame of light metal and with glass:</p>
 <ul>
 <li>7 mm wired glass: 5,5 W/(m&sup2;K)</li>
 <li>20 mm insulated glass: 3,5 W/(m&sup2;K) </li>
 </ul>
 <p>- Doors of wood or plastic for new building (standard construction): 1,6 W/(m&sup2;K)</p>
 <p>- insulated doors of wood or plastic with triplex glass: 0,7 W/(m&sup2;K)</p>
 <p>Reference:[Hessisches Ministerium f&uuml;r Umwelt 2011] UMWELT, Energie Landwirtschaft und V. f.: Energieeinsparung</p>
 <p>an Fenstern und Au&szlig;entueren. Version: 2011. www.hmuelv.hessen.de, p.10</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.Building.Components.Examples.WindowsDoors.DoorSimple\">AixLib.Building.Examples.WindowsDoors.DoorSimple </a></p>
 </html>", revisions = "<html>
 <ul>
 <li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
   <li><i>May 02, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
   <li><i>March 30, 2012&nbsp;</i>
          by Corinna Leonhardt and Ana Constantin:<br/>
          Implemented.</li>
 </ul>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0})}));
end Door;
