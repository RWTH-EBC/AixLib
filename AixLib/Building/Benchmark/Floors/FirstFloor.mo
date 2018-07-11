within AixLib.Building.Benchmark.Floors;
model FirstFloor
  Rooms.OpenPlanOffice openPlanOffice
    annotation (Placement(transformation(extent={{18,-16},{54,18}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_North
    annotation (Placement(transformation(extent={{112,68},{88,92}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_North
    annotation (Placement(transformation(extent={{-102,74},{-90,86}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_East
    annotation (Placement(transformation(extent={{112,48},{88,72}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_South
    annotation (Placement(transformation(extent={{112,28},{88,52}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_East
    annotation (Placement(transformation(extent={{-102,54},{-90,66}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_South
    annotation (Placement(transformation(extent={{-102,34},{-90,46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside annotation(Placement(transformation(extent={{-26,6},
            {-6,26}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273)
    annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside1
                                                                          annotation(Placement(transformation(extent={{-26,-26},
            {-6,-6}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=273)
    annotation (Placement(transformation(extent={{-70,-26},{-50,-6}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_OutdoorTemp
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToWorkshop_OpenPlanOffice
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToKitchen_OpenPlanOffice
    annotation (Placement(transformation(extent={{30,-112},{50,-92}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_West
    annotation (Placement(transformation(extent={{-102,14},{-90,26}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_Hor annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-80,96})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_West
    annotation (Placement(transformation(extent={{112,8},{88,32}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_Hor annotation (Placement(
        transformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b
    Heatport_TBA_openPlanOffice
    annotation (Placement(transformation(extent={{90,-20},{110,0}})));
equation
  connect(openPlanOffice.WindSpeedPort_NorthWall, WindSpeedPort_North)
    annotation (Line(points={{32.4,18.68},{32.4,80},{100,80}}, color={0,0,127}));
  connect(openPlanOffice.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
    annotation (Line(points={{37.8,19.7},{37.8,80},{-96,80}}, color={255,128,0}));
  connect(openPlanOffice.WindSpeedPort_EastWall, WindSpeedPort_East)
    annotation (Line(points={{54.72,-2.06},{80,-2.06},{80,60},{100,60}}, color=
          {0,0,127}));
  connect(openPlanOffice.WindSpeedPort_SouthWall, WindSpeedPort_South)
    annotation (Line(points={{21.24,-17.02},{21.24,-30},{80,-30},{80,40},{100,
          40}}, color={0,0,127}));
  connect(openPlanOffice.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{31.68,-17.7},{31.68,-80},{-80,-80},{-80,40},{-96,
          40}},  color={255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_EastWall, SolarRadiationPort_East)
    annotation (Line(points={{55.8,-7.5},{76,-7.5},{76,-80},{-80,-80},{-80,60},
          {-96,60}}, color={255,128,0}));
  connect(realExpression.y,tempOutside. T) annotation (Line(points={{-49,16},{
          -28,16}},                   color={0,0,127}));
  connect(tempOutside.port, openPlanOffice.HeatPort_ToMultiPersonOffice)
    annotation (Line(points={{-6,16},{6,16},{6,5.76},{18,5.76}}, color={191,0,0}));
  connect(realExpression1.y, tempOutside1.T)
    annotation (Line(points={{-49,-16},{-28,-16}}, color={0,0,127}));
  connect(tempOutside1.port, openPlanOffice.HeatPort_ToConferenceRoom)
    annotation (Line(points={{-6,-16},{6,-16},{6,-3.76},{18,-3.76}}, color={191,
          0,0}));
  connect(openPlanOffice.HeatPort_OutdoorTemp, HeatPort_OutdoorTemp)
    annotation (Line(points={{26.64,18},{26,18},{26,80},{0,80},{0,100}},
                                                           color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToWorkshop,
    HeatPort_ToWorkshop_OpenPlanOffice) annotation (Line(points={{38.52,-16},{
          39,-16},{39,-80},{-40,-80},{-40,-100}}, color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToKitchen, HeatPort_ToKitchen_OpenPlanOffice)
    annotation (Line(points={{48.6,-16},{48,-16},{48,-80},{40,-80},{40,-102}},
                                                             color={191,0,0}));
  connect(openPlanOffice.SolarRadiationPort_Hor, SolarRadiationPort_Hor)
    annotation (Line(points={{48.6,19.7},{48.6,80},{-80,80},{-80,96}}, color={
          255,128,0}));
  connect(openPlanOffice.WindSpeedPort_Roof, WindSpeedPort_Hor) annotation (
      Line(points={{43.2,18.68},{43.2,28},{80,28},{80,100}}, color={0,0,127}));
  connect(HeatPort_ToKitchen_OpenPlanOffice, HeatPort_ToKitchen_OpenPlanOffice)
    annotation (Line(points={{40,-102},{40,-97},{40,-97},{40,-102}}, color={191,
          0,0}));
  connect(openPlanOffice.Heatport_TBA, Heatport_TBA_openPlanOffice) annotation (
     Line(points={{54,9.16},{80,9.16},{80,-10},{100,-10}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-68,52},{-6,32}},
          lineColor={28,108,200},
          textString="Platzhalter für Mehrpersonen-
büro und Konferenzraum")}));
end FirstFloor;
