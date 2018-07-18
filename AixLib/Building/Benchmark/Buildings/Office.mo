within AixLib.Building.Benchmark.Buildings;
model Office
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
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_OutdoorTemp
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_North
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_East
    annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_South
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_West
    annotation (Placement(transformation(extent={{-110,-20},{-90,0}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-66,100})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_Hor annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b Heatport_TBA[n]
    annotation (Placement(transformation(extent={{70,-110},{90,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in[n](redeclare package Medium =
        Modelica.Media.Air.MoistAir)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out[n](redeclare package Medium =
        Modelica.Media.Air.MoistAir)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
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
  connect(firstFloor.HeatPort_OutdoorTemp, HeatPort_OutdoorTemp) annotation (
      Line(points={{0,60},{0,100}},                         color={191,0,0}));
  connect(firstFloor.SolarRadiationPort_North, SolarRadiationPort_North)
    annotation (Line(points={{-19.2,56},{-80,56},{-80,80},{-100,80}},
        color={255,128,0}));
  connect(firstFloor.SolarRadiationPort_East, SolarRadiationPort_East)
    annotation (Line(points={{-19.2,52},{-80,52},{-80,50},{-100,50}},
        color={255,128,0}));
  connect(firstFloor.SolarRadiationPort_South, SolarRadiationPort_West)
    annotation (Line(points={{-19.2,48},{-80,48},{-80,-10},{-100,-10}},
        color={255,128,0}));
  connect(firstFloor.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{-16,59.2},{-16,80},{-66,80},{-66,100}}, color={
          255,128,0}));
  connect(firstFloor.WindSpeedPort_Hor, WindSpeedPort_Hor) annotation (Line(
        points={{16,60},{16,80},{80,80},{80,100}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_West, WindSpeedPort_West) annotation (Line(
        points={{20,44},{80,44},{80,-10},{100,-10}}, color={0,0,127}));
  connect(firstFloor.Heatport_TBA[1], Heatport_TBA[1])
    annotation (Line(points={{20,28},{80,28},{80,-100}}, color={191,0,0}));
  connect(Air_out[1], firstFloor.Air_out[1]) annotation (Line(points={{-80,-100},
          {-80,32},{-20,32}}, color={0,127,255}));
  connect(firstFloor.Air_in[1], Air_in[1]) annotation (Line(points={{-20,24},{
          -80,24},{-80,-80},{-40,-80},{-40,-100}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-72,-2},{-10,-22}},
          lineColor={28,108,200},
          textString="Platzhalter für 
Erdgeschoss")}));
end Office;
