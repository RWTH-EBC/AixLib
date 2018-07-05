within AixLib.Building.Benchmark.Floors;
model FirstFloor
  Rooms.OpenPlanOffice openPlanOffice
    annotation (Placement(transformation(extent={{18,-16},{54,18}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_NorthWall_OpenPlanOffice
    annotation (Placement(transformation(extent={{112,68},{88,92}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_North
    annotation (Placement(transformation(extent={{-102,74},{-90,86}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_EastWall_OpenPlanOffice
    annotation (Placement(transformation(extent={{112,24},{88,48}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort_SouthWall_OpenPlanOffice
    annotation (Placement(transformation(extent={{112,-26},{88,-2}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_East
    annotation (Placement(transformation(extent={{-100,34},{-88,46}})));
  Utilities.Interfaces.SolarRad_in SolarRadiationPort_South
    annotation (Placement(transformation(extent={{-100,-26},{-88,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside annotation(Placement(transformation(extent={{-26,6},
            {-6,26}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=250)
    annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside1
                                                                          annotation(Placement(transformation(extent={{-26,-26},
            {-6,-6}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(
                                                        y=250)
    annotation (Placement(transformation(extent={{-70,-26},{-50,-6}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_OutdoorTemp
    annotation (Placement(transformation(extent={{18,90},{38,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToWorkshop_OpenPlanOffice
    annotation (Placement(transformation(extent={{-34,-110},{-14,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    HeatPort_ToKitchen_OpenPlanOffice
    annotation (Placement(transformation(extent={{40,-110},{60,-90}})));
equation
  connect(openPlanOffice.WindSpeedPort_NorthWall,
    WindSpeedPort_NorthWall_OpenPlanOffice) annotation (Line(points={{32.4,
          18.68},{32.4,80},{100,80}}, color={0,0,127}));
  connect(openPlanOffice.SolarRadiationPort_NorthWall, SolarRadiationPort_North)
    annotation (Line(points={{37.8,19.7},{37.8,80},{-96,80}}, color={255,128,0}));
  connect(openPlanOffice.WindSpeedPort_EastWall,
    WindSpeedPort_EastWall_OpenPlanOffice) annotation (Line(points={{54.72,
          -2.06},{80,-2.06},{80,36},{100,36}}, color={0,0,127}));
  connect(openPlanOffice.WindSpeedPort_SouthWall,
    WindSpeedPort_SouthWall_OpenPlanOffice) annotation (Line(points={{21.24,
          -17.02},{21.24,-30},{80,-30},{80,-14},{100,-14}}, color={0,0,127}));
  connect(openPlanOffice.SolarRadiationPort_SouthWall, SolarRadiationPort_South)
    annotation (Line(points={{31.68,-17.7},{31.68,-80},{-80,-80},{-80,-20},{-94,
          -20}}, color={255,128,0}));
  connect(openPlanOffice.SolarRadiationPort_EastWall, SolarRadiationPort_East)
    annotation (Line(points={{55.8,-7.5},{76,-7.5},{76,-80},{-80,-80},{-80,40},
          {-94,40}}, color={255,128,0}));
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
    annotation (Line(points={{26.64,18},{28,18},{28,100}}, color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToWorkshop,
    HeatPort_ToWorkshop_OpenPlanOffice) annotation (Line(points={{38.52,-16},{
          39,-16},{39,-80},{-24,-80},{-24,-100}}, color={191,0,0}));
  connect(openPlanOffice.HeatPort_ToKitchen, HeatPort_ToKitchen_OpenPlanOffice)
    annotation (Line(points={{48.6,-16},{50,-16},{50,-100}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-68,52},{-6,32}},
          lineColor={28,108,200},
          textString="Platzhalter für Mehrpersonen-
büro und Konferenzraum")}));
end FirstFloor;
