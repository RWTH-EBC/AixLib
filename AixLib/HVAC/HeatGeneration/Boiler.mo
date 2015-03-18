within AixLib.HVAC.HeatGeneration;
model Boiler "Model of a boiler for space heating"
  import AixLib;
  parameter AixLib.DataBase.Boiler.BoilerEfficiencyBaseDataDefinition boilerEfficiencyB = AixLib.DataBase.Boiler.BoilerConst()
    "boiler efficiency as a function of part-load factor"                                                                                                     annotation(choicesAllMatching = true);
  parameter Modelica.SIunits.Power Q_flow_max = 20000
    "Maximum heat output of boiler at full load";
  parameter Modelica.SIunits.Volume Volume = 0.01
    "Fluid volume inside the heat generation unit";
  extends BaseClasses.PartialHeatGen(volume(V = Volume));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 50})));
  Utilities.HeatDemand heatDemand annotation(Placement(transformation(extent = {{-64, 60}, {-44, 80}})));
  Utilities.FuelCounter fuelCounter annotation(Placement(transformation(extent = {{80, 60}, {100, 80}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = Q_flow_max, uMin = 0) annotation(Placement(transformation(extent = {{-30, 60}, {-10, 80}})));
  Utilities.BoilerEfficiency boilerEfficiency(boilerEfficiencyBE = boilerEfficiencyB, Q_flow_max = Q_flow_max) annotation(Placement(transformation(extent = {{40, 60}, {60, 80}})));
  Modelica.Blocks.Interfaces.RealInput T_set annotation(Placement(transformation(extent = {{-128, 50}, {-88, 90}})));
equation
  connect(prescribedHeatFlow.port, volume.heatPort) annotation(Line(points = {{0, 40}, {0, 10}}, color = {191, 0, 0}, smooth = Smooth.None));
  connect(T_in.signal, heatDemand.T_in) annotation(Line(points = {{-70, 10}, {-70, 38}, {-60, 38}, {-60, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(massFlowSensor.signal, heatDemand.m_flow_in) annotation(Line(points = {{-40, 10}, {-40, 30}, {-52, 30}, {-52, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(heatDemand.Q_flow_out, limiter.u) annotation(Line(points = {{-43.4, 70}, {-32, 70}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(limiter.y, prescribedHeatFlow.Q_flow) annotation(Line(points = {{-9, 70}, {0, 70}, {0, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(limiter.y, boilerEfficiency.heatDemand) annotation(Line(points = {{-9, 70}, {40, 70}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(boilerEfficiency.fuelUse, fuelCounter.fuel_in) annotation(Line(points = {{60.6, 70}, {80, 70}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(heatDemand.T_set, T_set) annotation(Line(points = {{-64, 70}, {-108, 70}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p><br>This basic boiler model calculates the heat demand in order to reach the fluid set temperature. The heat input to the fluid is limited between 0 and the maximum heat output of the boiler. </p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The idea is to have a very simple heating mechanism, which heats the fluid to a given set temperature using any amount of heat flow between 0 and the boiler&apos;s maximum heat output. As the model should be able to answer interesting questions for the students, one important value is fuel consumption. Therefore the model calculates fuel consumption as the integral of heat intput to the fluid divided by the boiler efficiency. This efficiency part is replaceable and can be either a fixed value or a table with part load efficiencies.</p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst</a></p>
 <p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTVar\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTVar</a></p>
 </html>", revisions = "<html>
 <p>09.10.2013, Marcus Fuchs</p>
 <p><ul>
 <li>included the unit&apos;s volume as a parameter</li>
 </ul></p>
 <p>07.10.2013, Marcus Fuchs</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"), Icon(graphics={  Rectangle(extent=  {{-40.5, 74.5}, {53.5, -57.5}}, lineColor=  {0, 0, 0},
            fillPattern=                                                                                             FillPattern.VerticalCylinder, fillColor=  {170, 170, 255}), Polygon(points=  {{-12.5, -19.5}, {-20.5, -3.5}, {1.5, 40.5}, {9.5, 14.5}, {31.5, 18.5}, {21.5, -23.5}, {3.5, -19.5}, {-2.5, -19.5}, {-12.5, -19.5}}, lineColor=  {0, 0, 0},
            fillPattern=                                                                                                    FillPattern.Sphere, fillColor=  {255, 127, 0}), Rectangle(extent=  {{-20.5, -17.5}, {33.5, -25.5}}, lineColor=  {0, 0, 0},
            fillPattern=                                                                                                    FillPattern.HorizontalCylinder, fillColor=  {192, 192, 192}), Polygon(points=  {{-10.5, -17.5}, {-0.5, 2.5}, {25.5, -17.5}, {-0.5, -17.5}, {-10.5, -17.5}}, lineColor=  {255, 255, 170}, fillColor=  {255, 255, 170},
            fillPattern=                                                                                                    FillPattern.Solid)}));
end Boiler;

