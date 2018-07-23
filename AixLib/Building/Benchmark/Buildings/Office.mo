within AixLib.Building.Benchmark.Buildings;
model Office
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";
  Floors.FirstFloor firstFloor
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside annotation(Placement(transformation(extent={{-28,-50},
            {-8,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273)
    annotation (Placement(transformation(extent={{-72,-50},{-52,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside1
                                                                          annotation(Placement(transformation(extent={{-28,-82},
            {-8,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273)
    annotation (Placement(transformation(extent={{-72,-82},{-52,-62}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_North
    annotation (Placement(transformation(extent={{110,70},{90,90}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_East
    annotation (Placement(transformation(extent={{110,40},{90,60}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_South
    annotation (Placement(transformation(extent={{110,10},{90,30}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_West
    annotation (Placement(transformation(extent={{110,-20},{90,0}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_North[5]
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_Hor annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA
    annotation (Placement(transformation(extent={{70,-110},{90,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={0,78})));
  Modelica.Blocks.Interfaces.RealInput AirTemp annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,100}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-2,98})));
equation
  connect(realExpression.y,tempOutside. T) annotation (Line(points={{-51,-40},{
          -30,-40}},                  color={0,0,127}));
  connect(realExpression1.y, tempOutside1.T)
    annotation (Line(points={{-51,-72},{-30,-72}}, color={0,0,127}));
  connect(tempOutside.port, firstFloor.HeatPort_ToWorkshop_OpenPlanOffice)
    annotation (Line(points={{-8,-40},{-8,20}},                     color={191,
          0,0}));
  connect(tempOutside1.port, firstFloor.HeatPort_ToKitchen_OpenPlanOffice)
    annotation (Line(points={{-8,-72},{8,-72},{8,19.6}},           color={191,0,
          0}));
  connect(firstFloor.WindSpeedPort_North, WindSpeedPort_North) annotation (Line(
        points={{20,56},{80,56},{80,80},{100,80}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_East, WindSpeedPort_East) annotation (Line(
        points={{20,52},{80,52},{80,50},{100,50}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_South, WindSpeedPort_South) annotation (Line(
        points={{20,48},{80,48},{80,20},{100,20}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_Hor, WindSpeedPort_Hor) annotation (Line(
        points={{16,60},{16,80},{80,80},{80,100}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_West, WindSpeedPort_West) annotation (Line(
        points={{20,44},{80,44},{80,-10},{100,-10}}, color={0,0,127}));
  connect(firstFloor.SolarRadiationPort_Hor, SolarRadiationPort_North[5])
    annotation (Line(points={{-16,59.2},{-16,88},{-100,88}}, color={255,128,0}));
  connect(firstFloor.SolarRadiationPort_North, SolarRadiationPort_North[1])
    annotation (Line(points={{-19.2,56},{-40,56},{-40,72},{-100,72}}, color={
          255,128,0}));
  connect(firstFloor.SolarRadiationPort_East, SolarRadiationPort_North[2])
    annotation (Line(points={{-19.2,52},{-40,52},{-40,76},{-100,76}}, color={
          255,128,0}));
  connect(firstFloor.SolarRadiationPort_South, SolarRadiationPort_North[3])
    annotation (Line(points={{-19.2,48},{-40,48},{-40,80},{-100,80}}, color={
          255,128,0}));
  connect(firstFloor.SolarRadiationPort_West, SolarRadiationPort_North[4])
    annotation (Line(points={{-19.2,44},{-40,44},{-40,84},{-100,84}}, color={
          255,128,0}));
  connect(firstFloor.Air_out, Air_out) annotation (Line(points={{-20,32},{-80,
          32},{-80,-100}}, color={0,127,255}));
  connect(firstFloor.Air_in, Air_in) annotation (Line(points={{-20,24},{-40,24},
          {-40,-100}}, color={0,127,255}));
  connect(firstFloor.Heatport_TBA, Heatport_TBA)
    annotation (Line(points={{20,28},{80,28},{80,-100}}, color={191,0,0}));
  connect(prescribedTemperature.port, firstFloor.HeatPort_OutdoorTemp)
    annotation (Line(points={{-1.11022e-015,72},{-1.11022e-015,64},{0,64},{0,60}},
        color={191,0,0}));
  connect(AirTemp, prescribedTemperature.T)
    annotation (Line(points={{0,100},{0,85.2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-72,-2},{-10,-22}},
          lineColor={28,108,200},
          textString="Platzhalter für 
Erdgeschoss")}));
end Office;
