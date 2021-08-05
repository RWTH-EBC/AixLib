within AixLib.DataBase.HeatPump.PerformanceData;
model LookUpTableNDNotManufacturer
  "4-dimensional table without manufacturer data for heat pump"
 extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

  // Not Manufacturer
  parameter Modelica.SIunits.Temperature THotMax=333.15 "Max. value of THot before shutdown"
  annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.HeatFlowRate QNom=30000 "Nominal heat flow"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Real PLRMin=0.4 "Limit of PLR; less =0"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Boolean HighTemp=false "true: THot > 60°C"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.SIunits.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

  parameter Modelica.SIunits.Temperature TSource=280 "temperature of heat source"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

 parameter Boolean dTConFix=false
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));


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
        origin={250,-26})));
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
        rotation=0,
        origin={268,112})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={250,8})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin5
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=90,
        origin={278,74})));
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
        rotation=270,
        origin={246,54})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-108,-38})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=dTConFix)
    annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));

protected
  parameter String FilenameCOP= if HighTemp==false then "modelica://Resources/Data/Fluid/HeatPumps/NotManufacturer/COP_Scroll_R410a.sdf" else "modelica://Resources/Data/Fluid/HeatPumps/NotManufacturer/COP_Hubkolben_R134a.sdf";

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
      points={{-0.925,100.07},{-0.925,92},{-90,92},{-90,52},{-72,52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.PLR, pLRMin.u) annotation (Line(
      points={{-0.925,100.07},{-0.925,98},{2,98},{2,92},{-136,92},{-136,60},{-126,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.Shutdown, switch3.u2) annotation (Line(
      points={{-0.925,100.07},{-0.925,48},{-35,48},{-35,23.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(nominalHeatPump.QEvapNom, sigBus.QEvapNom) annotation (Line(points={{-59,-4},{8,-4},{8,58},
          {-0.925,58},{-0.925,100.07}},                       color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(limiter.y, multiplex4_1.u2[1]) annotation (Line(points={{74,55.4},{
          74,46},{41,46},{41,28}},      color={0,0,127}));
  connect(sigBus.PLR, limiter.u) annotation (Line(
      points={{-0.925,100.07},{6,100.07},{6,69.2},{74,69.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(product1.y, Pel) annotation (Line(points={{-1.2,-64},{24,-64},{24,
          -92},{0,-92},{0,-110}},
                             color={0,0,127}));
  connect(limiter.y, multiplex4_2.u2[1]) annotation (Line(points={{74,55.4},{74,
          36},{253,36},{253,20}},  color={0,0,127}));
  connect(fromKelvin1.Celsius, multiplex4_2.u1[1]) annotation (Line(points={{80.7,83},
          {90,83},{90,40},{259,40},{259,20}},      color={0,0,127}));
  connect(nominalHeatPump.PelFullLoad, product1.u2) annotation (Line(points={
          {-59,-14},{-58,-14},{-58,-68.8},{-19.6,-68.8}}, color={0,0,127}));
  connect(tHotNom.y, fromKelvin5.Kelvin)
    annotation (Line(points={{261.4,112},{254,112},{254,82},{278,82},{278,78.8}},
                                                  color={0,0,127}));
  connect(sigBus.T_flow_co, fromKelvin4.Kelvin) annotation (Line(
      points={{-1,100},{2,100},{2,126},{24,126}},
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
  connect(fromKelvin5.Celsius, multiplex4_2.u4[1]) annotation (Line(points={{278,
          69.6},{278,32},{241,32},{241,20}}, color={0,0,127}));
  connect(multiplex4_1.y, SDFCOP1.u)
    annotation (Line(points={{38,5},{38,-1.6}}, color={0,0,127}));
  connect(multiplex4_2.y, SDFCOP.u)
    annotation (Line(points={{250,-3},{250,-11.6}},
                                                color={0,0,127}));
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
  connect(add2.y, multiplex4_2.u3[1]) annotation (Line(points={{246,45.2},{246,
          42},{247,42},{247,20}},    color={0,0,127}));
  connect(fromKelvin4.Celsius, add2.u2) annotation (Line(points={{47,126},{140,
          126},{140,63.6},{241.2,63.6}},               color={0,0,127}));
  connect(fromKelvin5.Celsius, add2.u1) annotation (Line(points={{278,69.6},{
          278,64},{250.8,64},{250.8,63.6}},           color={0,0,127}));
  connect(SDFCOP1.y, switch2.u1) annotation (Line(points={{38,-29.2},{38,-44},{
          -84,-44},{-84,-18},{-112.8,-18},{-112.8,-30.8}},           color={0,0,
          127}));
  connect(switch2.y, product2.u2) annotation (Line(points={{-108,-44.6},{-108,
          -48},{-84.8,-48},{-84.8,-52.4}},
                                      color={0,0,127}));
  connect(SDFCOP.y, switch2.u3) annotation (Line(points={{250,-39.2},{250,-40},
          {58,-40},{58,-32},{-103.2,-32},{-103.2,-30.8}},
                                                color={0,0,127}));
  connect(booleanExpression.y, switch2.u2) annotation (Line(points={{-119,0},
          {-108,0},{-108,-30.8}},
                            color={255,0,255}));
  connect(switch3.y, product1.u1) annotation (Line(points={{-35,3.1},{-35,
          -59.2},{-19.6,-59.2}}, color={0,0,127}));
  connect(add1.y, nominalHeatPump.u) annotation (Line(points={{49.2,108},{-94,
          108},{-94,-12},{-82,-12}}, color={0,0,127}));
  connect(switch2.y, sigBus.CoP) annotation (Line(points={{-108,-44.6},{-108,-48},{-174,-48},{-174,
          116},{-1,116},{-1,100}},                                color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
    Line(points={{-60,40},{-60,-40},{60,-40},{60,40},{30,40},{30,-40},{-30,-40},
              {-30,40},{-60,40},{-60,20},{60,20},{60,0},{-60,0},{-60,-20},{60,-20},
              {60,-40},{-60,-40},{-60,40},{60,40},{60,-40}}),
    Line(points={{0,40},{0,-40}}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-60,0},{-30,20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60,-40},{-30,-20}}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-60,-20},{-30,0}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-60,-40},{-30,-20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-30,-40},{0,-20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{0,-40},{30,-20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{30,-40},{60,-20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{30,-20},{60,0}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{0,-20},{30,0}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{0,0},{30,20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{30,0},{60,20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{0,20},{30,40}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{30,20},{60,40}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-60,20},{-30,40}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-30,20},{0,40}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-30,0},{0,20}},
          lineColor={0,0,0}),
    Rectangle(fillColor={255,255,0},
      fillPattern=FillPattern.Solid,
      extent={{-30,-20},{0,0}},
          lineColor={0,0,0})}),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{286,-12},{378,-44}},
          lineColor={28,108,200},
          textString="COP calc for dT variable and THotNom"), Text(
          extent={{58,4},{150,-28}},
          lineColor={28,108,200},
          textString="COP calc for dT fix and THotCurrent")}),
    Documentation(info="<html>
<p>This model uses 4-dimensional table data, wich are calculated for a simplyfied refrigerant circuit with the use of isentropic compressor efficienciecs as a function of pressure gradient and frequency, superheating and calibration of minimal temperature differencees in condeser and evaporater. The table data ist a function of THot, TSource, deltaTCon and relative power, which represents compressor frequency.</p>
<p><br><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_Prel.png\"/></p>
<p><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_DeltaT_HK.png\"/></p>
</html>"));
end LookUpTableNDNotManufacturer;
