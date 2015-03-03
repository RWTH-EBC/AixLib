within AixLib.Utilities.Sources.HeaterCooler;


model IdealHeaterCoolerVar1 "heater and cooler with variable setpoints"
  extends
    AixLib.Utilities.Sources.HeaterCooler.IdealHeaterCoolerBase_seperate_parameters;
  Modelica.Blocks.Interfaces.RealInput soll_cool if Cooler_on annotation(Placement(transformation(extent = {{-120, -60}, {-80, -20}}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-48, -48})));
  Modelica.Blocks.Interfaces.RealInput soll_heat if Heater_on annotation(Placement(transformation(extent = {{-120, 20}, {-80, 60}}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {30, -48})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y = Heater_on) if Heater_on annotation(Placement(transformation(extent = {{-52, 14}, {-33, 30}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y = Cooler_on) if Cooler_on annotation(Placement(transformation(extent = {{-52, -30}, {-32, -14}})));
equation
  connect(booleanExpression.y, pITemp1.onOff) annotation(Line(points = {{-32.05, 22}, {-24, 22}, {-24, 15}, {-19, 15}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(booleanExpression1.y, pITemp2.onOff) annotation(Line(points = {{-31, -22}, {-24, -22}, {-24, -15}, {-19, -15}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(soll_heat, pITemp1.soll) annotation(Line(points = {{-100, 40}, {-18, 40}, {-18, 29}, {-18, 29}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(soll_cool, pITemp2.soll) annotation(Line(points = {{-100, -40}, {-58, -40}, {-58, -40}, {-18, -40}, {-18, -29}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(graphics), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>This is just as simple heater and/or cooler with a PI-controller. It can be used as an quasi-ideal source for heating and cooling applications. </p>
 </html>", revisions = "<html>
 <ul>
 <li><i>June, 2014&nbsp;</i> by Moritz Lauster:<br/>Added some basic documentation</li>
 </ul>
 </html>"));
end IdealHeaterCoolerVar1;
