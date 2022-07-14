within AixLib.ThermalZones.HighOrder.Components.WindowsDoors;
model Door "Simple door"
  parameter Modelica.Units.SI.Area door_area=2 "Total door area"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer U=1.8
    "Thermal transmission coefficient" annotation (Dialog(group="Properties"));
  parameter Modelica.Units.SI.Emissivity eps=0.9 "Emissivity of door material"
    annotation (Dialog(group="Radiation"));

  parameter Integer radCalcMethod=1 "Calculation method for radiation heat transfer" annotation (
    Evaluate=true,
    Dialog(group = "Radiation", compact=true),
    choices(
      choice=1 "No approx",
      choice=2 "Linear approx at wall temp",
      choice=3 "Linear approx at rad temp",
      choice=4 "Linear approx at constant T_ref",
      radioButtons=true));
  parameter Modelica.Units.SI.Temperature T_ref=
      Modelica.Units.Conversions.from_degC(16)
    "Reference temperature for optional linearization"
    annotation (Dialog(group="Radiation", enable=radCalcMethod == 4));


  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-100, -10}, {-80, 10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent = {{80, -10}, {100, 10}})));
  Utilities.HeatTransfer.HeatToRad twoStar_RadEx(
    final A=door_area,
    final radCalcMethod=radCalcMethod,
    final T_ref=T_ref,
    final eps=eps) annotation (Placement(transformation(extent={{30,50},{50,70}})));
  Utilities.Interfaces.RadPort
                            radPort annotation(Placement(transformation(extent = {{80, 50}, {100, 70}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatTrans(G = door_area * U) annotation(Placement(transformation(extent={{-10,-10},{10,10}})));
  Utilities.HeatTransfer.HeatToRad twoStar_RadEx1(
    final A=door_area,
    final radCalcMethod=radCalcMethod,
    final T_ref=T_ref,
    final eps=eps) annotation (Placement(transformation(extent={{-32,50},{-52,70}})));
  Utilities.Interfaces.RadPort
                            radPort1 annotation(Placement(transformation(extent = {{-100, 50}, {-80, 70}})));
equation
  connect(twoStar_RadEx.radPort, radPort) annotation(Line(points={{50.1,60},{90,60}},      pattern = LinePattern.Solid));
  connect(twoStar_RadEx1.radPort, radPort1) annotation(Line(points={{-52.1,60},{-90,60}},      color = {95, 95, 95}, pattern = LinePattern.Solid));
  connect(HeatTrans.port_b, twoStar_RadEx.convPort) annotation (Line(points={{10,0},{20,0},{20,60},{30,60}}, color={191,0,0}));
  connect(HeatTrans.port_a, twoStar_RadEx1.convPort) annotation (Line(points={{-10,0},{-20,0},{-20,60},{-32,60}}, color={191,0,0}));
  connect(HeatTrans.port_b, port_b) annotation (Line(points={{10,0},{90,0}}, color={191,0,0}));
  connect(HeatTrans.port_a, port_a) annotation (Line(points={{-10,0},{-90,0}}, color={191,0,0}));
  annotation(Dialog(group = "Air exchange"), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Line(points = {{-40, 18}, {-36, 18}}, color = {255, 255, 0}), Rectangle(extent = {{-52, 82}, {48, -78}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-46, 76}, {40, -68}}, lineColor = {0, 0, 0},
            fillPattern =                                                                                                   FillPattern.Solid, fillColor = {127, 0, 0}), Rectangle(extent = {{28, 12}, {36, 0}}, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                   FillPattern.Solid)}), Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The <b>Door</b> model models
</p>
<ul>
  <li>the conductive heat transfer through the door with a U-Value is
  set to 1.8 W/(m²K) (EnEV2009)
  </li>
  <li>the radiative heat transfer on both sides
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">Assumptions</span>
</h4>
<ul>
  <li>Constant U-value.
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">References/ U-values special doors</span>
</h4>
<ul>
  <li>Doors of wood or plastic 40 mm: 2,2 W/(m²K)
  </li>
  <li>Doors of wood 60 mm: 1,7 W/(m²K)
  </li>
  <li>Doors of wood with glass:
  </li>
  <li>7 mm wired glass: 4,5 W/(m²K)
  </li>
  <li>20 mm insulated glass: 2,8 W/(m²K)
  </li>
</ul>
<p>
  - Doors with a frame of light metal and with glass:
</p>
<ul>
  <li>7 mm wired glass: 5,5 W/(m²K)
  </li>
  <li>20 mm insulated glass: 3,5 W/(m²K)
  </li>
</ul>
<p>
  - Doors of wood or plastic for new building (standard construction):
  1,6 W/(m²K)
</p>
<p>
  - insulated doors of wood or plastic with triplex glass: 0,7 W/(m²K)
</p>
<p>
  Reference:[Hessisches Ministerium für Umwelt 2011] UMWELT, Energie
  Landwirtschaft und V. f.: Energieeinsparung
</p>
<p>
  an Fenstern und Außentueren. Version: 2011. www.hmuelv.hessen.de,
  p.10
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.Building.Components.Examples.WindowsDoors.DoorSimple\">AixLib.Building.Examples.WindowsDoors.DoorSimple</a>
</p>
<ul>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>March 30, 2012&#160;</i> by Corinna Leonhardt and Ana
    Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics={  Rectangle(extent = {{-80, 80}, {80, -80}}, lineColor = {0, 0, 0})}));
end Door;
