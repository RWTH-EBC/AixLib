within AixLib.Building.Benchmark.Buildings;
model Office
  Floors.FirstFloor firstFloor
    annotation (Placement(transformation(extent={{-20,14},{22,56}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside annotation(Placement(transformation(extent={{-28,-50},
            {-8,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=250)
    annotation (Placement(transformation(extent={{-72,-50},{-52,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside1
                                                                          annotation(Placement(transformation(extent={{-28,-82},
            {-8,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(
                                                        y=250)
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
equation
  connect(realExpression.y,tempOutside. T) annotation (Line(points={{-51,-40},{
          -30,-40}},                  color={0,0,127}));
  connect(realExpression1.y, tempOutside1.T)
    annotation (Line(points={{-51,-72},{-30,-72}}, color={0,0,127}));
  connect(tempOutside.port, firstFloor.HeatPort_ToWorkshop_OpenPlanOffice)
    annotation (Line(points={{-8,-40},{-4,-40},{-4,14},{-4.04,14}}, color={191,
          0,0}));
  connect(tempOutside1.port, firstFloor.HeatPort_ToKitchen_OpenPlanOffice)
    annotation (Line(points={{-8,-72},{12,-72},{12,14},{11.5,14}}, color={191,0,
          0}));
  connect(firstFloor.WindSpeedPort_NorthWall_OpenPlanOffice,
    WindSpeedPort_North) annotation (Line(points={{22,51.8},{60,51.8},{60,80},{
          100,80}}, color={0,0,127}));
  connect(firstFloor.WindSpeedPort_EastWall_OpenPlanOffice, WindSpeedPort_East)
    annotation (Line(points={{22,42.56},{60,42.56},{60,50},{100,50}}, color={0,
          0,127}));
  connect(firstFloor.WindSpeedPort_SouthWall_OpenPlanOffice,
    WindSpeedPort_South) annotation (Line(points={{22,32.06},{60,32.06},{60,20},
          {100,20}}, color={0,0,127}));
  connect(firstFloor.HeatPort_OutdoorTemp, HeatPort_OutdoorTemp) annotation (
      Line(points={{6.88,56},{6,56},{6,80},{0,80},{0,100}}, color={191,0,0}));
  connect(firstFloor.SolarRadiationPort_North, SolarRadiationPort_North)
    annotation (Line(points={{-19.16,51.8},{-80,51.8},{-80,80},{-100,80}},
        color={255,128,0}));
  connect(firstFloor.SolarRadiationPort_East, SolarRadiationPort_East)
    annotation (Line(points={{-18.74,43.4},{-80,43.4},{-80,50},{-100,50}},
        color={255,128,0}));
  connect(firstFloor.SolarRadiationPort_South, SolarRadiationPort_West)
    annotation (Line(points={{-18.74,30.8},{-80,30.8},{-80,-10},{-100,-10}},
        color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-72,-2},{-10,-22}},
          lineColor={28,108,200},
          textString="Platzhalter für 
Erdgeschoss")}));
end Office;
