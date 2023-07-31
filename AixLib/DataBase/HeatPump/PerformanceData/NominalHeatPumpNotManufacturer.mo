within AixLib.DataBase.HeatPump.PerformanceData;
model NominalHeatPumpNotManufacturer

  parameter Modelica.Units.SI.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.HeatFlowRate QNom=30000 "Nominal heat flow"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
     parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

     parameter Boolean Modulating=true "Is the heat pump inverter-driven?";


  Modelica.Blocks.Math.Division NomPel "Nominal electric Power"
    annotation (Placement(transformation(extent={{116,66},{136,86}})));

  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{178,68},{198,88}})));

  Modelica.Blocks.Sources.RealExpression tSourceNom(y=TSourceNom)
    annotation (Placement(transformation(extent={{-100,80},{-74,104}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-36,92})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,34})));
  Modelica.Blocks.Sources.RealExpression qNom(y=QNom)
    annotation (Placement(transformation(extent={{66,72},{100,94}})));
  Modelica.Blocks.Sources.RealExpression deltaTCon(y=DeltaTCon)
    annotation (Placement(transformation(extent={{12,11},{-12,-11}},
        rotation=180,
        origin={-100,57})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,70})));
  SDF.NDTable SDFCOPNominal(
    final nin=4,
    final readFromFile=true,
    final filename=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/COP_Scroll_R410A.sdf"),
    final dataset="\COP",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    "SDF-Table data for COP" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={36,70})));

  Modelica.Blocks.Sources.RealExpression NomFrequency(y=100)
    "Frequency if Modulating=true" annotation (Placement(transformation(
        extent={{11,12},{-11,-12}},
        rotation=180,
        origin={-189,92})));

  Modelica.Blocks.Sources.RealExpression tHotNom(y=THotNom) annotation (
      Placement(transformation(
        extent={{12,10},{-12,-10}},
        rotation=180,
        origin={-100,34})));

  Controls.Interfaces.VapourCompressionMachineControlBus        sigBus
    "Bus-connector used in a heat pump" annotation (Placement(
        transformation(
        extent={{-15,-14},{15,14}},
        rotation=0,
        origin={201,0})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-32,-28})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-78,-38})));
  Modelica.Blocks.Interfaces.RealOutput PelFullLoadSetPoint(final unit="W",
      final displayUnit="kW") "maximal electric power at operating point"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={224,-28})));
  Modelica.Blocks.Math.Division division3
    annotation (Placement(transformation(extent={{124,-44},{144,-24}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{168,-38},{188,-18}})));
  Modelica.Blocks.Math.Log log
    annotation (Placement(transformation(extent={{62,-38},{82,-18}})));
  Modelica.Blocks.Math.Log log1
    annotation (Placement(transformation(extent={{66,14},{86,34}})));
  SDF.NDTable SDF_PI_Nom(
    final nin=4,
    final readFromFile=true,
    final filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/DataBase/HeatPump/PerformanceData/PI_Scroll_R410A.sdf"),
    final dataset="\PI",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    "SDF-Table data for PressureRatio" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={38,24})));

  SDF.NDTable SDF_PI_FullLoad(
    final nin=4,
    final readFromFile=true,
    final filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/DataBase/HeatPump/PerformanceData/PI_Scroll_R410A.sdf"),
    final dataset="\PI",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    "SDF-Table data for PressureRatio" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={10,-28})));

  Modelica.Blocks.Sources.BooleanExpression modulating(y=Modulating)
    annotation (Placement(transformation(extent={{-200,62},{-166,86}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-138,74})));
  Modelica.Blocks.Sources.RealExpression NomFrequency1(y=50)
    "Frequency if Modulating=false" annotation (Placement(transformation(
        extent={{11,12},{-11,-12}},
        rotation=180,
        origin={-189,50})));
  SDF.NDTable SDFCOPNominal1(
    final nin=4,
    final readFromFile=true,
    final filename=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/HeatPump/PerformanceData/COP_Scroll_R410A.sdf"),
    final dataset="\COP",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    "SDF-Table data for COP" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={8,-78})));

  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{80,-84},{100,-64}})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{160,-78},{180,-58}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{256,10},{276,30}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={332,20})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=100, uMin=25)
    annotation (Placement(transformation(extent={{-148,-72},{-128,-52}})));
equation
  connect(tSourceNom.y, fromKelvin3.Kelvin)
    annotation (Line(points={{-72.7,92},{-48,92}}, color={0,0,127}));
  connect(qNom.y, NomPel.u1) annotation (Line(points={{101.7,83},{101.7,82},{
          114,82}}, color={0,0,127}));
  connect(SDFCOPNominal.y, NomPel.u2)
    annotation (Line(points={{49.2,70},{114,70}}, color={0,0,127}));
  connect(multiplex4_1.y, SDFCOPNominal.u)
    annotation (Line(points={{11,70},{21.6,70}}, color={0,0,127}));
  connect(fromKelvin3.Celsius, multiplex4_1.u1[1]) annotation (Line(points={{-25,92},
          {-12,92},{-12,79}},                     color={0,0,127}));
  connect(deltaTCon.y, multiplex4_1.u3[1])
    annotation (Line(points={{-86.8,57},{-22,57},{-22,67},{-12,67}},
                                                            color={0,0,127}));
  connect(fromKelvin2.Celsius, multiplex4_1.u4[1])
    annotation (Line(points={{-45,34},{-12,34},{-12,61}}, color={0,0,127}));
  connect(fromKelvin2.Kelvin, tHotNom.y) annotation (Line(points={{-68,34},{
          -86.8,34}},                       color={0,0,127}));
  connect(deltaTCon.y, multiplex4_2.u3[1]) annotation (Line(points={{-86.8,57},
          {-44,57},{-44,-12},{-52,-12},{-52,-31},{-44,-31}},
                                       color={0,0,127}));
  connect(fromKelvin3.Celsius, multiplex4_2.u1[1]) annotation (Line(points={{-25,92},
          {-20,92},{-20,0},{-54,0},{-54,-19},{-44,-19}},
                                               color={0,0,127}));
  connect(NomPel.y, product1.u1) annotation (Line(points={{137,76},{148,76},{
          148,72},{164,72},{164,-12},{158,-12},{158,-22},{166,-22}}, color={0,0,
          127}));
  connect(log.y, division3.u1) annotation (Line(points={{83,-28},{122,-28}},
                      color={0,0,127}));
  connect(log1.y, division3.u2) annotation (Line(points={{87,24},{92,24},{92,
          -40},{122,-40}},
                      color={0,0,127}));
  connect(SDF_PI_FullLoad.y, log.u) annotation (Line(points={{23.2,-28},{60,-28}},
                              color={0,0,127}));
  connect(SDF_PI_Nom.y, log1.u)
    annotation (Line(points={{51.2,24},{64,24}}, color={0,0,127}));
  connect(multiplex4_1.y, SDF_PI_Nom.u) annotation (Line(points={{11,70},{14,70},
          {14,24},{23.6,24}},                   color={0,0,127}));
  connect(multiplex4_2.y,SDF_PI_FullLoad. u) annotation (Line(points={{-21,-28},
          {-4.4,-28}},
        color={0,0,127}));
  connect(division3.y, product1.u2) annotation (Line(points={{145,-34},{166,-34}},
                                                color={0,0,127}));
  connect(product1.y, PelFullLoadSetPoint)
    annotation (Line(points={{189,-28},{224,-28}},
                                                 color={0,0,127}));
  connect(NomFrequency.y, switch1.u1) annotation (Line(points={{-176.9,92},{
          -158,92},{-158,82},{-150,82}},
                                    color={0,0,127}));
  connect(modulating.y, switch1.u2)
    annotation (Line(points={{-164.3,74},{-150,74}}, color={255,0,255}));
  connect(NomFrequency1.y, switch1.u3) annotation (Line(points={{-176.9,50},{
          -158,50},{-158,66},{-150,66}},
                                    color={0,0,127}));
  connect(switch1.y, multiplex4_1.u2[1])
    annotation (Line(points={{-127,74},{-69.5,74},{-69.5,73},{-12,73}},
                                                           color={0,0,127}));
  connect(switch1.y, multiplex4_2.u2[1]) annotation (Line(points={{-127,74},{
          -32,74},{-32,-4},{-62,-4},{-62,-25},{-44,-25}},
                                     color={0,0,127}));
  connect(qNom.y, add.u1) annotation (Line(points={{101.7,83},{106,83},{106,94},
          {168,94},{168,84},{176,84}}, color={0,0,127}));
  connect(NomPel.y, add.u2) annotation (Line(points={{137,76},{148,76},{148,72},
          {176,72}}, color={0,0,127}));
  connect(multiplex4_2.y, SDFCOPNominal1.u) annotation (Line(points={{-21,-28},
          {-16,-28},{-16,-78},{-6.4,-78}}, color={0,0,127}));
  connect(SDFCOPNominal1.y, product2.u2)
    annotation (Line(points={{21.2,-78},{78,-78},{78,-80}}, color={0,0,127}));
  connect(product1.y, product2.u1) annotation (Line(points={{189,-28},{194,-28},
          {194,-48},{56,-48},{56,-68},{78,-68}}, color={0,0,127}));
  connect(product2.y, add1.u2)
    annotation (Line(points={{101,-74},{158,-74}}, color={0,0,127}));
  connect(product1.y, add1.u1) annotation (Line(points={{189,-28},{194,-28},{
          194,-48},{130,-48},{130,-62},{158,-62}}, color={0,0,127}));
  connect(add.y, greater.u1) annotation (Line(points={{199,78},{216,78},{216,20},
          {254,20}}, color={0,0,127}));
  connect(add1.y, greater.u2) annotation (Line(points={{181,-68},{242,-68},{242,
          12},{254,12}}, color={0,0,127}));
  connect(greater.y, switch2.u2)
    annotation (Line(points={{277,20},{320,20}}, color={255,0,255}));
  connect(add.y, switch2.u1) annotation (Line(points={{199,78},{296,78},{296,28},
          {320,28}}, color={0,0,127}));
  connect(add1.y, switch2.u3) annotation (Line(points={{181,-68},{296,-68},{296,
          12},{320,12}},                     color={0,0,127}));
  connect(switch2.y, sigBus.QEvapNom) annotation (Line(points={{343,20},{368,20},
          {368,0.07},{201.075,0.07}},                   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(limiter.y, multiplex4_2.u4[1]) annotation (Line(points={{-127,-62},{
          -94,-62},{-94,-54},{-56,-54},{-56,-37},{-44,-37}}, color={0,0,127}));
  connect(sigBus.THotSet, fromKelvin1.Kelvin) annotation (Line(
      points={{201.075,0.07},{-114,0.07},{-114,-38},{-90,-38}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(fromKelvin1.Celsius, limiter.u) annotation (Line(points={{-67,-38},{
          -68,-38},{-68,-46},{-176,-46},{-176,-62},{-150,-62}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-160},{200,
            160}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-160},{
            200,160}}), graphics={Rectangle(
          extent={{-200,160},{202,0}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-200,0},{200,-160}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-76,-130},{88,-140}},
          textColor={28,108,200},
          textString="Off-Design Full-Load & Evap-Power"),
        Text(
          extent={{-62,142},{102,132}},
          textColor={28,108,200},
          textString="Design Full-Load & Evap-Power")}),
    Documentation(info="<html>
<p>Auslegung des Betriebspunktes indem die maximale elektrische Leistung vorliegt</p>
</html>"));
end NominalHeatPumpNotManufacturer;
