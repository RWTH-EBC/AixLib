within AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.EnergySystem.IdealHeaters;
model UpperFloor
  parameter Real ratioRadHeat = 0.3
    "ratio of radiative heat from total heat generated";
  AixLib.Utilities.Interfaces.RadPort Rad_Bedroom annotation(Placement(transformation(extent = {{-149, 80}, {-129, 100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Bedroom annotation(Placement(transformation(extent = {{-150, 49}, {-130, 69}})));
  AixLib.Utilities.Interfaces.RadPort Rad_Children2 annotation(Placement(transformation(extent = {{-149, -25}, {-129, -5}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Children2 annotation(Placement(transformation(extent = {{-151, -61}, {-131, -41}})));
  AixLib.Utilities.Interfaces.RadPort Rad_Children1 annotation(Placement(transformation(extent = {{127, 63}, {147, 83}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Chidlren1 annotation(Placement(transformation(extent = {{129, 40}, {149, 60}})));
  AixLib.Utilities.Interfaces.RadPort Rad_Bath annotation(Placement(transformation(extent = {{130, -50}, {150, -30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Con_Bath annotation(Placement(transformation(extent = {{129, -78}, {149, -58}})));
  Modelica.Blocks.Interfaces.RealInput TSet_UF[4] annotation(Placement(transformation(extent = {{-85, 82}, {-57, 112}}), iconTransformation(extent = {{-77, 90}, {-57, 112}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bedroom annotation(Placement(transformation(extent = {{-119, -11}, {-107, 1}})));
  Modelica.Blocks.Continuous.LimPID PI_bedroom(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.3, Ti = 10, yMax = 2000, yMin = 0) annotation(Placement(transformation(extent = {{-99, -1}, {-79, 19}})));
  Modelica.Blocks.Math.Gain gainRad_bedroom(k = ratioRadHeat) annotation(Placement(transformation(extent = {{-67, -4}, {-58, 5}})));
  Modelica.Blocks.Math.Gain gainConv_bedroom(k = 1 - ratioRadHeat) annotation(Placement(transformation(extent = {{-68, 13}, {-59, 22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceRad_bedroom
    "source radiative heat bedroom"                                                                          annotation(Placement(transformation(extent = {{-52, -10}, {-32, 10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceConv_bedroom
    "source convective heat bedroom"                                                                           annotation(Placement(transformation(extent = {{-53, 8}, {-33, 28}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_children1 annotation(Placement(transformation(extent = {{4, 36}, {16, 48}})));
  Modelica.Blocks.Continuous.LimPID PI_children1(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.3, Ti = 10, yMax = 2000, yMin = 0) annotation(Placement(transformation(extent = {{24, 46}, {44, 66}})));
  Modelica.Blocks.Math.Gain gainRad_children1(k = ratioRadHeat) annotation(Placement(transformation(extent = {{56, 43}, {65, 52}})));
  Modelica.Blocks.Math.Gain gainConv_children1(k = 1 - ratioRadHeat) annotation(Placement(transformation(extent = {{55, 60}, {64, 69}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceRad_children1
    "source radiative heat children1"                                                                            annotation(Placement(transformation(extent = {{71, 37}, {91, 57}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceConv_children1
    "source convective heat children1"                                                                             annotation(Placement(transformation(extent = {{70, 55}, {90, 75}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_bath annotation(Placement(transformation(extent = {{17, -64}, {29, -52}})));
  Modelica.Blocks.Continuous.LimPID PI_bath(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.3, Ti = 10, yMax = 2000, yMin = 0) annotation(Placement(transformation(extent = {{37, -54}, {57, -34}})));
  Modelica.Blocks.Math.Gain gainRad_bath(k = ratioRadHeat) annotation(Placement(transformation(extent = {{69, -57}, {78, -48}})));
  Modelica.Blocks.Math.Gain gainConv_bath(k = 1 - ratioRadHeat) annotation(Placement(transformation(extent = {{68, -40}, {77, -31}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceRad_bath
    "source radiative heat bath"                                                                       annotation(Placement(transformation(extent = {{84, -63}, {104, -43}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceConv_bath
    "source convective heat bath"                                                                        annotation(Placement(transformation(extent = {{83, -45}, {103, -25}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor tempSensor_children2 annotation(Placement(transformation(extent = {{-123, -69}, {-111, -57}})));
  Modelica.Blocks.Continuous.LimPID PI_children2(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 0.3, Ti = 10, yMax = 2000, yMin = 0) annotation(Placement(transformation(extent = {{-103, -59}, {-83, -39}})));
  Modelica.Blocks.Math.Gain gainRad_children2(k = ratioRadHeat) annotation(Placement(transformation(extent = {{-71, -62}, {-62, -53}})));
  Modelica.Blocks.Math.Gain gainConv_children2(k = 1 - ratioRadHeat) annotation(Placement(transformation(extent = {{-72, -45}, {-63, -36}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceRad_children2
    "source radiative heat children2"                                                                            annotation(Placement(transformation(extent = {{-56, -68}, {-36, -48}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow SourceConv_children2
    "source convective heat children2"                                                                             annotation(Placement(transformation(extent = {{-57, -50}, {-37, -30}})));
equation
  connect(tempSensor_bedroom.T, PI_bedroom.u_m) annotation(Line(points = {{-107, -5}, {-89, -5}, {-89, -3}}, color = {0, 0, 127}));
  connect(PI_bedroom.y, gainRad_bedroom.u) annotation(Line(points = {{-78, 9}, {-73, 9}, {-73, 0.5}, {-67.9, 0.5}}, color = {0, 0, 127}));
  connect(PI_bedroom.y, gainConv_bedroom.u) annotation(Line(points = {{-78, 9}, {-73, 9}, {-73, 17.5}, {-68.9, 17.5}}, color = {0, 0, 127}));
  connect(gainRad_bedroom.y, SourceRad_bedroom.Q_flow) annotation(Line(points = {{-57.55, 0.5}, {-54, 0.5}, {-54, 0}, {-52, 0}}, color = {0, 0, 127}));
  connect(SourceConv_bedroom.Q_flow, gainConv_bedroom.y) annotation(Line(points = {{-53, 18}, {-55, 18}, {-55, 17.5}, {-58.55, 17.5}}, color = {0, 0, 127}));
  connect(tempSensor_children1.T, PI_children1.u_m) annotation(Line(points = {{16, 42}, {34, 42}, {34, 44}}, color = {0, 0, 127}));
  connect(PI_children1.y, gainRad_children1.u) annotation(Line(points = {{45, 56}, {50, 56}, {50, 47.5}, {55.1, 47.5}}, color = {0, 0, 127}));
  connect(PI_children1.y, gainConv_children1.u) annotation(Line(points = {{45, 56}, {50, 56}, {50, 64.5}, {54.1, 64.5}}, color = {0, 0, 127}));
  connect(gainRad_children1.y, SourceRad_children1.Q_flow) annotation(Line(points = {{65.45, 47.5}, {69, 47.5}, {69, 47}, {71, 47}}, color = {0, 0, 127}));
  connect(SourceConv_children1.Q_flow, gainConv_children1.y) annotation(Line(points = {{70, 65}, {68, 65}, {68, 64.5}, {64.45, 64.5}}, color = {0, 0, 127}));
  connect(tempSensor_bath.T, PI_bath.u_m) annotation(Line(points = {{29, -58}, {47, -58}, {47, -56}}, color = {0, 0, 127}));
  connect(PI_bath.y, gainRad_bath.u) annotation(Line(points = {{58, -44}, {63, -44}, {63, -52.5}, {68.1, -52.5}}, color = {0, 0, 127}));
  connect(PI_bath.y, gainConv_bath.u) annotation(Line(points = {{58, -44}, {63, -44}, {63, -35.5}, {67.1, -35.5}}, color = {0, 0, 127}));
  connect(gainRad_bath.y, SourceRad_bath.Q_flow) annotation(Line(points = {{78.45, -52.5}, {82, -52.5}, {82, -53}, {84, -53}}, color = {0, 0, 127}));
  connect(SourceConv_bath.Q_flow, gainConv_bath.y) annotation(Line(points = {{83, -35}, {81, -35}, {81, -35.5}, {77.45, -35.5}}, color = {0, 0, 127}));
  connect(tempSensor_children2.T, PI_children2.u_m) annotation(Line(points = {{-111, -63}, {-93, -63}, {-93, -61}}, color = {0, 0, 127}));
  connect(PI_children2.y, gainRad_children2.u) annotation(Line(points = {{-82, -49}, {-77, -49}, {-77, -57.5}, {-71.9, -57.5}}, color = {0, 0, 127}));
  connect(PI_children2.y, gainConv_children2.u) annotation(Line(points = {{-82, -49}, {-77, -49}, {-77, -40.5}, {-72.9, -40.5}}, color = {0, 0, 127}));
  connect(gainRad_children2.y, SourceRad_children2.Q_flow) annotation(Line(points = {{-61.55, -57.5}, {-58, -57.5}, {-58, -58}, {-56, -58}}, color = {0, 0, 127}));
  connect(SourceConv_children2.Q_flow, gainConv_children2.y) annotation(Line(points = {{-57, -40}, {-59, -40}, {-59, -40.5}, {-62.55, -40.5}}, color = {0, 0, 127}));
  connect(Con_Bedroom, tempSensor_bedroom.port) annotation(Line(points = {{-140, 59}, {-129, 59}, {-129, -5}, {-119, -5}}, color = {191, 0, 0}));
  connect(tempSensor_children1.port, Con_Chidlren1) annotation(Line(points = {{4, 42}, {0, 42}, {0, 30}, {139, 30}, {139, 50}}, color = {191, 0, 0}));
  connect(tempSensor_bath.port, Con_Bath) annotation(Line(points = {{17, -58}, {1, -58}, {1, -68}, {139, -68}}, color = {191, 0, 0}));
  connect(tempSensor_children2.port, Con_Children2) annotation(Line(points = {{-123, -63}, {-129, -63}, {-129, -51}, {-141, -51}}, color = {191, 0, 0}));
  connect(SourceRad_children2.port, Rad_Children2) annotation(Line(points = {{-36, -58}, {-23, -58}, {-23, -15}, {-139, -15}}, color = {191, 0, 0}));
  connect(SourceConv_children2.port, Con_Children2) annotation(Line(points = {{-37, -40}, {-23, -40}, {-23, -71}, {-129, -71}, {-129, -51}, {-141, -51}}, color = {191, 0, 0}));
  connect(SourceConv_children1.port, Con_Chidlren1) annotation(Line(points = {{90, 65}, {139, 65}, {139, 50}}, color = {191, 0, 0}));
  connect(SourceRad_children1.port, Rad_Children1) annotation(Line(points = {{91, 47}, {137, 47}, {137, 73}}, color = {191, 0, 0}));
  connect(SourceConv_bath.port, Con_Bath) annotation(Line(points = {{103, -35}, {111, -35}, {111, -36}, {139, -36}, {139, -68}}, color = {191, 0, 0}));
  connect(SourceRad_bath.port, Rad_Bath) annotation(Line(points = {{104, -53}, {118, -53}, {118, -55}, {140, -55}, {140, -40}}, color = {191, 0, 0}));
  connect(PI_bedroom.u_s, TSet_UF[1]) annotation(Line(points = {{-101, 9}, {-129, 9}, {-129, 85.75}, {-71, 85.75}}, color = {0, 0, 127}));
  connect(PI_children1.u_s, TSet_UF[2]) annotation(Line(points = {{22, 56}, {0, 56}, {0, 93.25}, {-71, 93.25}}, color = {0, 0, 127}));
  connect(PI_bath.u_s, TSet_UF[3]) annotation(Line(points = {{35, -44}, {0, -44}, {0, 100.75}, {-71, 100.75}}, color = {0, 0, 127}));
  connect(PI_children2.u_s, TSet_UF[4]) annotation(Line(points = {{-105, -49}, {-129, -49}, {-129, 108.25}, {-71, 108.25}}, color = {0, 0, 127}));
  connect(SourceConv_bedroom.port, Con_Bedroom) annotation(Line(points = {{-33, 18}, {-22, 18}, {-22, 43}, {-140, 43}, {-140, 59}}, color = {191, 0, 0}));
  connect(SourceRad_bedroom.port, Rad_Bedroom) annotation(Line(points = {{-32, 0}, {-22, 0}, {-22, 43}, {-139, 43}, {-139, 90}}, color = {191, 0, 0}));
  annotation(Dialog(group = "Radiators", descriptionLabel = true), Dialog(group = "Valves", descriptionLabel = true), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-130, -100}, {130, 100}}, grid = {1, 1}), graphics={  Rectangle(extent = {{0, 73}, {127, 30}}, pattern = LinePattern.Solid, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Rectangle(extent = {{0, -14}, {129, -71}}, pattern = LinePattern.Solid, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Rectangle(extent = {{-129, 43}, {-22, -11}}, pattern = LinePattern.Solid, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Rectangle(extent = {{-130, -16}, {-23, -70}}, pattern = LinePattern.Solid, lineColor = {0, 0, 0}, fillColor = {215, 215, 215},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid), Text(extent = {{-129, -17}, {-78, -31}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "Children2"), Text(extent = {{-155, 38}, {-48, 25}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "Bedroom"), Text(extent = {{31, -15}, {138, -28}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "Bath"), Text(extent = {{52, 41}, {159, 28}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
            fillPattern =                                                                                                                                                                                                        FillPattern.Solid, textString = "Children1"), Text(extent = {{-53, 95}, {-11, 72}}, lineColor = {0, 0, 0}, textString = "1 - Bedroom
 2- Children1
 3 - Bath
 4 - Children2")}), Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-130, -100}, {130, 100}}, grid = {1, 1}), graphics={  Rectangle(extent = {{-122, 91}, {120, -80}}, lineColor = {255, 0, 0}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Line(points = {{-17, 22}, {-17, 44}}, color = {255, 0, 0}, thickness = 1), Line(points = {{-102, 21}, {101, 21}, {101, -7}}, color = {255, 0, 0}, thickness = 1), Line(points = {{-101, 12}, {92, 12}, {92, -7}}, color = {0, 0, 255}, thickness = 1), Line(points = {{-24, 12}, {-24, 34}}, color = {0, 0, 255}, thickness = 1), Text(extent = {{-79, 66}, {-37, 43}}, lineColor = {0, 0, 0}, textString = "1 - Bedroom
 2- Children1
 3 - Bath
 4 - Children2")}), Documentation(revisions = "<html><ul>
  <li>
    <i>June 19, 2014</i> by Ana Constantin:<br/>
    Implemented
  </li>
</ul>
</html>", info = "<html>
<h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the upper floor.
</p>
</html>"));
end UpperFloor;
