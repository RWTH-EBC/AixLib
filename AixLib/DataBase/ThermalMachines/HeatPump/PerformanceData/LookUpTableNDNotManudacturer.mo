within AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData;
model LookUpTableNDNotManudacturer "4-dimensional table without manufacturer data for heat pump"
 extends
    AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

  SDF.NDTable SDFCOP(
    final nin=4,
    final readFromFile=true,
    final filename=FilenameCOP,
    final dataset="\COP",
    final dataUnit="-",
    final scaleUnits={"degC","-","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    "SDF-Table data for COP nominal"
                             annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={76,-18})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={38,16})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=0,
        origin={73,83})));
  NominalHeatPumpNotManufacturer nominalHeatPump(
    HighTemp=HighTemp,
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    DeltaTCon=DeltaTCon,
    dTConFix=dTConFix)
    annotation (Placement(transformation(extent={{-80,-16},{-60,4}})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{-124,50},{-104,70}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-60,60})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=270,
        origin={-35,13})));
  Modelica.Blocks.Sources.RealExpression zero
    annotation (Placement(transformation(extent={{-52,70},{-70,90}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={80,-72})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-18,-72},{-2,-56}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-80,-62})));

  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={74,62})));
  Modelica.Blocks.Sources.RealExpression deltaTCon(y=DeltaTCon)
    annotation (Placement(transformation(extent={{-7,-8},{7,8}},
        rotation=180,
        origin={51,62})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={36,126})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=180,
        origin={58,108})));
  Modelica.Blocks.Sources.RealExpression tHotNom(y=THotNom) annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=270,
        origin={58,2})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={76,16})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin5
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={58,16})));
  SDF.NDTable SDFCOP1(
    final nin=4,
    final readFromFile=true,
    final filename=FilenameCOP,
    final dataset="\COP",
    final dataUnit="-",
    final scaleUnits={"degC","-","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    "SDF-Table data for COP" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={38,-16})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=15)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-80,-90})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=15)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={80,-90})));
  Modelica.Blocks.Sources.RealExpression zero1
    annotation (Placement(transformation(extent={{0,26},{-18,46}})));
  Modelica.Blocks.Sources.RealExpression tSource(y=TSource)
    annotation (Placement(transformation(extent={{40,74},{56,92}})));
  Modelica.Blocks.Sources.RealExpression deltaTCon1(y=DeltaTCon)
    annotation (Placement(transformation(extent={{-7,-8},{7,8}},
        rotation=180,
        origin={91,104})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=180,
        origin={122,60})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-108,-38})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=dTConFix)
    annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));
protected
  parameter String FilenameCOP= if HighTemp==false then "D:/dja-mzu/SDF/WP/COP_Scroll_R410a.sdf" else "D:/dja-mzu/SDF/WP/COP_Hubkolben_R134a.sdf";

equation

  connect(fromKelvin1.Celsius,multiplex4_1. u1[1]) annotation (Line(points={{80.7,83},
          {90,83},{90,50},{47,50},{47,28}},                     color={0,0,127}));
  connect(switch4.y,switch3. u3) annotation (Line(points={{-49,60},{-42,60},{
          -42,50},{-42.2,50},{-42.2,23.8}},
                                        color={0,0,127}));
  connect(pLRMin.y,switch4. u2) annotation (Line(points={{-103,60},{-72,60}},
                                             color={255,0,255}));
  connect(zero.y, switch4.u1) annotation (Line(points={{-70.9,80},{-80,80},{
          -80,68},{-72,68}}, color={0,0,127}));
  connect(product1.y,product2. u1) annotation (Line(points={{-1.2,-64},{24,
          -64},{24,-48},{-75.2,-48},{-75.2,-52.4}},              color={0,0,127}));
  connect(product2.y,add. u2) annotation (Line(points={{-80,-70.8},{-80,-74},
          {42,-74},{42,-60},{76.4,-60},{76.4,-64.8}},
                              color={0,0,127}));
  connect(product1.y,add. u1)
    annotation (Line(points={{-1.2,-64},{32,-64},{32,-58},{83.6,-58},{83.6,
          -64.8}},                                        color={0,0,127}));
  connect(sigBus.PLR, switch4.u3) annotation (Line(
      points={{1.075,104.07},{1.075,92},{-90,92},{-90,52},{-72,52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.PLR, pLRMin.u) annotation (Line(
      points={{1.075,104.07},{1.075,98},{2,98},{2,92},{-136,92},{-136,60},{
          -126,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.Shutdown, switch3.u2) annotation (Line(
      points={{1.075,104.07},{1.075,48},{-35,48},{-35,23.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(nominalHeatPump.QEvapNom, sigBus.QEvapNom) annotation (Line(points=
          {{-59,-4},{8,-4},{8,58},{1.075,58},{1.075,104.07}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(limiter.y, multiplex4_1.u2[1]) annotation (Line(points={{74,55.4},{
          74,46},{41,46},{41,28}},      color={0,0,127}));
  connect(sigBus.PLR, limiter.u) annotation (Line(
      points={{1.075,104.07},{6,104.07},{6,69.2},{74,69.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(product1.y, Pel) annotation (Line(points={{-1.2,-64},{24,-64},{24,
          -92},{0,-92},{0,-110}},
                             color={0,0,127}));
  connect(limiter.y, multiplex4_2.u2[1]) annotation (Line(points={{74,55.4},{
          74,36},{79,36},{79,28}}, color={0,0,127}));
  connect(fromKelvin1.Celsius, multiplex4_2.u1[1]) annotation (Line(points={{80.7,83},
          {90,83},{90,40},{85,40},{85,28}},        color={0,0,127}));
  connect(nominalHeatPump.PelFullLoad, product1.u2) annotation (Line(points={
          {-59,-14},{-58,-14},{-58,-68.8},{-19.6,-68.8}}, color={0,0,127}));
  connect(tHotNom.y, fromKelvin5.Kelvin)
    annotation (Line(points={{58,8.6},{58,11.2}}, color={0,0,127}));
  connect(sigBus.T_flow_co, fromKelvin4.Kelvin) annotation (Line(
      points={{1.075,104.07},{2,104.07},{2,126},{24,126}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(product2.y, firstOrder.u) annotation (Line(points={{-80,-70.8},{-80,
          -82.8}},         color={0,0,127}));
  connect(add.y, firstOrder1.u) annotation (Line(points={{80,-78.6},{80,-82.8}},
                                       color={0,0,127}));
  connect(firstOrder1.y, QEva) annotation (Line(points={{80,-96.6},{80,-110}},
                                                    color={0,0,127}));
  connect(firstOrder.y, QCon) annotation (Line(points={{-80,-96.6},{-80,-110}},
                                                     color={0,0,127}));
  connect(add1.y, multiplex4_1.u4[1])
    annotation (Line(points={{49.2,108},{29,108},{29,28}}, color={0,0,127}));
  connect(fromKelvin5.Celsius, multiplex4_2.u4[1]) annotation (Line(points={{
          58,20.4},{58,32},{67,32},{67,28}}, color={0,0,127}));
  connect(multiplex4_1.y, SDFCOP1.u)
    annotation (Line(points={{38,5},{38,-1.6}}, color={0,0,127}));
  connect(multiplex4_2.y, SDFCOP.u)
    annotation (Line(points={{76,5},{76,-3.6}}, color={0,0,127}));
  connect(fromKelvin4.Celsius, add1.u2) annotation (Line(points={{47,126},{80,
          126},{80,112.8},{67.6,112.8}}, color={0,0,127}));
  connect(zero1.y, switch3.u1) annotation (Line(points={{-18.9,36},{-27.8,36},
          {-27.8,23.8}}, color={0,0,127}));
  connect(fromKelvin1.Kelvin, tSource.y)
    annotation (Line(points={{64.6,83},{56.8,83}}, color={0,0,127}));
  connect(deltaTCon.y, multiplex4_1.u3[1])
    annotation (Line(points={{43.3,62},{35,62},{35,28}}, color={0,0,127}));
  connect(deltaTCon1.y, add1.u1) annotation (Line(points={{83.3,104},{74,104},
          {74,103.2},{67.6,103.2}}, color={0,0,127}));
  connect(add2.y, multiplex4_2.u3[1]) annotation (Line(points={{113.2,60},{104,60},
          {104,36},{73,36},{73,28}}, color={0,0,127}));
  connect(fromKelvin4.Celsius, add2.u2) annotation (Line(points={{47,126},{
          140,126},{140,64.8},{131.6,64.8}},           color={0,0,127}));
  connect(fromKelvin5.Celsius, add2.u1) annotation (Line(points={{58,20.4},{
          58,38},{140,38},{140,54},{131.6,54},{131.6,55.2}},
                                                      color={0,0,127}));
  connect(SDFCOP1.y, switch2.u1) annotation (Line(points={{38,-29.2},{38,-42},
          {-84,-42},{-84,-16},{-112.8,-16},{-112.8,-30.8}},          color={0,0,
          127}));
  connect(switch2.y, product2.u2) annotation (Line(points={{-108,-44.6},{-108,
          -48},{-84.8,-48},{-84.8,-52.4}},
                                      color={0,0,127}));
  connect(SDFCOP.y, switch2.u3) annotation (Line(points={{76,-31.2},{76,-36},
          {-14,-36},{-14,-28},{-103.2,-28},{-103.2,-30.8}},
                                                color={0,0,127}));
  connect(booleanExpression.y, switch2.u2) annotation (Line(points={{-119,0},
          {-108,0},{-108,-30.8}},
                            color={255,0,255}));
  connect(switch3.y, product1.u1) annotation (Line(points={{-35,3.1},{-35,
          -59.2},{-19.6,-59.2}}, color={0,0,127}));
  connect(add1.y, nominalHeatPump.u) annotation (Line(points={{49.2,108},{-94,
          108},{-94,-12},{-82,-12}}, color={0,0,127}));
  connect(switch2.y, sigBus.CoP) annotation (Line(points={{-108,-44.6},{-108,
          -48},{-174,-48},{-174,116},{1.075,116},{1.075,104.07}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model uses 4-dimensional table data, wich are calculated for a simplyfied refrigerant circuit with the use of isentropic compressor efficienciecs as a function of pressure gradient and frequency, superheating and calibration of minimal temperature differencees in condeser and evaporater. The table data ist a function of THot, TSource, deltaTCon and relative power, which represents compressor frequency.</p>
<p><br><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_Prel.png\"/></p>
<p><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_DeltaT_HK.png\"/></p>
</html>"));
end LookUpTableNDNotManudacturer;
