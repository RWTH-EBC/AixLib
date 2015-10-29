within AixLib.Utilities.Sources.HeaterCooler;
partial model partialIdealHeaterCoolerBaseSepParam
  extends AixLib.Utilities.Sources.HeaterCooler.partialIdealHeaterCooler;
  Sensors.TEnergyMeter coolMeter if Cooler_on "measures cooling energy" annotation(Placement(transformation(extent = {{40, -50}, {60, -30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Cooling if Cooler_on annotation(Placement(transformation(extent = {{6, -23}, {26, -2}})));
  Control.PITemp pITemp2(RangeSwitch = false, h = h_cooler, l = l_cooler, KR = KR_cooler, TN = TN_cooler) if Cooler_on annotation(Placement(transformation(extent = {{-20, -10}, {0, -30}})));
  Sensors.TEnergyMeter heatMeter if Heater_on "measures heating energy" annotation(Placement(transformation(extent = {{40, 30}, {60, 50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heating if Heater_on annotation(Placement(transformation(extent = {{6, 22}, {26, 2}})));
  Control.PITemp pITemp1(RangeSwitch = false, h = h_heater, l = l_heater, KR = KR_heater, TN = TN_heater) if Heater_on annotation(Placement(transformation(extent = {{-20, 10}, {0, 30}})));
  parameter Modelica.SIunits.Temp_K T0all = 295.15
    "Initial temperature for all components";
  parameter Modelica.SIunits.HeatFlowRate Q_flow_heat = 1
    "Heat flow rate of the heater"                                                       annotation(Dialog(tab = "Heater"));
  parameter Real weightfactor_heater = 1 "weightfactor of the heater" annotation(Dialog(tab = "Heater"));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_cooler = 1
    "Heat flow rate of the cooler"                                                         annotation(Dialog(tab = "Cooler"));
  parameter Real weightfactor_cooler = 1 "weightfactor of the cooler" annotation(Dialog(tab = "Cooler"));
  parameter Real h_heater = 100000
    "upper limit controller output of the heater"                                annotation(Dialog(tab = "Heater", group = "Controller"));
  parameter Real l_heater = 0 "lower limit controller output of the heater" annotation(Dialog(tab = "Heater", group = "Controller"));
  parameter Real KR_heater = 10000 "Gain of the heating controller" annotation(Dialog(tab = "Heater", group = "Controller"));
  parameter Modelica.SIunits.Time TN_heater = 1
    "Time constant of the heating controller"                                             annotation(Dialog(tab = "Heater", group = "Controller"));
  parameter Real h_cooler = 0 "upper limit controller output of the cooler" annotation(Dialog(tab = "Cooler", group = "Controller"));
  parameter Real l_cooler = -100000
    "lower limit controller output of the cooler"                                 annotation(Dialog(tab = "Cooler", group = "Controller"));
  parameter Real KR_cooler = 10000 "Gain of the cooling controller" annotation(Dialog(tab = "Cooler", group = "Controller"));
  parameter Modelica.SIunits.Time TN_cooler = 1
    "Time constant of the cooling controller"                                             annotation(Dialog(tab = "Cooler", group = "Controller"));
  parameter Boolean Heater_on = true "Activates the heater" annotation(Dialog(tab = "Heater"));
  parameter Boolean Cooler_on = true "Activates the cooler" annotation(Dialog(tab = "Cooler"));
equation
  connect(pITemp2.y, Cooling.Q_flow) annotation(Line(points = {{-1, -20}, {6, -20}, {6, -12.5}}, color = {0, 0, 127}));
  connect(Cooling.Q_flow, coolMeter.p) annotation(Line(points = {{6, -12.5}, {6, -40}, {41.4, -40}}, color = {0, 0, 127}));
  connect(pITemp1.y, Heating.Q_flow) annotation(Line(points = {{-1, 20}, {2, 20}, {2, 12}, {6, 12}}, color = {0, 0, 127}));
  connect(Heating.Q_flow, heatMeter.p) annotation(Line(points = {{6, 12}, {6, 40}, {41.4, 40}}, color = {0, 0, 127}));
  connect(Heating.port, heatCoolRoom) annotation(Line(points = {{26, 12}, {2, 12}, {2, 0}, {90, 0}}, color = {191, 0, 0}));
  connect(Cooling.port, heatCoolRoom) annotation(Line(points = {{26, -12.5}, {2.4, -12.5}, {2.4, 0}, {90, 0}}, color = {191, 0, 0}));
  connect(pITemp2.Therm1, heatCoolRoom) annotation(Line(points = {{-16, -11}, {-16, 0}, {90, 0}}, color = {191, 0, 0}));
  connect(pITemp1.Therm1, heatCoolRoom) annotation(Line(points = {{-16, 11}, {-16, 0}, {90, 0}}, color = {191, 0, 0}));
  annotation (Icon(graphics={  Rectangle(extent = {{-94, 6}, {80, -28}}, lineColor = {135, 135, 135}, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{-82, 6}, {-82, 40}, {-48, 6}, {-82, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{-46, 6}, {-8, 6}, {-8, 40}, {-46, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{30, 6}, {-8, 6}, {-8, 40}, {30, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Polygon(points = {{64, 6}, {64, 40}, {30, 6}, {64, 6}}, lineColor = {135, 135, 135},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent = {{64, -18}, {-80, -4}}, lineColor = {0, 0, 0},
            lineThickness =                                                                                                   1, fillColor = {135, 135, 135},
            fillPattern =                                                                                                   FillPattern.Solid, textString = "T_set_room<->T_air_room"), Line(points = {{-62, 24}, {-62, 50}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-46, 10}, {-46, 50}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-30, 24}, {-30, 50}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-66, 48}, {-62, 54}, {-58, 48}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-50, 48}, {-46, 54}, {-42, 48}}, color = {0, 128, 255}, thickness = 1), Line(points = {{-34, 48}, {-30, 54}, {-26, 48}}, color = {0, 128, 255}, thickness = 1), Line(points = {{16, 24}, {16, 50}}, color = {255, 0, 0}, thickness = 1), Line(points = {{12, 48}, {16, 54}, {20, 48}}, color = {255, 0, 0}, thickness = 1), Line(points = {{44, 24}, {44, 50}}, color = {255, 0, 0}, thickness = 1), Line(points = {{40, 48}, {44, 54}, {48, 48}}, color = {255, 0, 0}, thickness = 1), Line(points = {{30, 10}, {30, 50}}, color = {255, 0, 0}, thickness = 1), Line(points = {{26, 48}, {30, 54}, {34, 48}}, color = {255, 0, 0}, thickness = 1)}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This is the base class of an ideal heater and/or cooler. It is used in full ideal heater/cooler models as an extension. It extends another base class and adds some basic elements.</p>
 </html>", revisions = "<html>
 <ul>
 <li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
 </ul>
 </html>"));
end partialIdealHeaterCoolerBaseSepParam;
