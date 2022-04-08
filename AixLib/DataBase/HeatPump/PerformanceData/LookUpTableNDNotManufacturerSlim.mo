within AixLib.DataBase.HeatPump.PerformanceData;
model LookUpTableNDNotManufacturerSlim
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

   parameter Boolean TSourceInternal=false
                                          "Use internal TSource?"
    annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

    parameter Boolean THotExternal=false "Use external THot?"
                                                             annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

  NominalHeatPumpNotManufacturer nominalHeatPump(
    HighTemp=HighTemp,
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    DeltaTCon=DeltaTCon)
    annotation (Placement(transformation(extent={{-40,32},{-20,52}})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{26,66},{40,80}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={66,72})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=270,
        origin={87,29})));
  Modelica.Blocks.Sources.RealExpression zero
    annotation (Placement(transformation(extent={{26,80},{40,98}})));
  Modelica.Blocks.Math.Add addQEvap(k1=-1) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={86,-46})));
  Modelica.Blocks.Math.Product productPel annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={0,-8})));
  Modelica.Blocks.Math.Product productQCon annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-80,-40})));

  Modelica.Blocks.Sources.RealExpression zero1
    annotation (Placement(transformation(extent={{118,44},{100,64}})));

  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=15)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-46,-88})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=15)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={16,-90})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=90,
        origin={-84,-86})));
  Modelica.Blocks.Logical.LessThreshold mFlowWaterMin(threshold=0.01)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={30,30})));
  Modelica.Blocks.Logical.Switch switch6
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=90,
        origin={81,-87})));
  Modelica.Blocks.Sources.RealExpression zero2
    annotation (Placement(transformation(extent={{9,-10},{-9,10}},
        rotation=180,
        origin={-109,-72})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=THotExternal)
    annotation (Placement(transformation(extent={{26506,-7302},{26552,-7278}})));
  COPNotManufacturer cOPNotManufacturer(
    TSourceInternal=TSourceInternal,
    THotExternal=THotExternal,
    TSource=TSource,
    THotNom=THotNom,
    PLRMin=PLRMin,
    HighTemp=HighTemp)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,70})));
  Modelica.Blocks.Sources.RealExpression zero3
    annotation (Placement(transformation(extent={{38,-98},{46,-88}})));

equation

  connect(switch4.y,switch3. u3) annotation (Line(points={{77,72},{80,72},{80,44},
          {79.8,44},{79.8,39.8}},       color={0,0,127}));
  connect(pLRMin.y,switch4. u2) annotation (Line(points={{40.7,73},{40.7,72},{54,
          72}},                              color={255,0,255}));
  connect(zero.y, switch4.u1) annotation (Line(points={{40.7,89},{54,89},{54,80}},
                             color={0,0,127}));
  connect(productPel.y, productQCon.u1) annotation (Line(points={{-1.60982e-15,-16.8},
          {-1.60982e-15,-26},{-76,-26},{-76,-30.4},{-75.2,-30.4}}, color={0,0,127}));
  connect(productQCon.y, addQEvap.u2) annotation (Line(points={{-80,-48.8},{-80,
          -58},{40,-58},{40,-30},{80,-30},{80,-36.4},{81.2,-36.4}}, color={0,0,127}));
  connect(productPel.y, addQEvap.u1) annotation (Line(points={{-1.55431e-15,
          -16.8},{-1.55431e-15,-26},{90.8,-26},{90.8,-36.4}},
                                                       color={0,0,127}));
  connect(nominalHeatPump.QEvapNom, sigBus.QEvapNom) annotation (Line(points={{-19,44},
          {-0.925,44},{-0.925,100.07}},                       color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(productPel.y, Pel)
    annotation (Line(points={{-1.60982e-15,-16.8},{0,-110}}, color={0,0,127}));
  connect(nominalHeatPump.PelFullLoad, productPel.u2)
    annotation (Line(points={{-19,34},{-4.8,34},{-4.8,1.6}}, color={0,0,127}));
  connect(zero1.y, switch3.u1) annotation (Line(points={{99.1,54},{94.2,54},{94.2,
          39.8}},        color={0,0,127}));
  connect(switch3.y, productPel.u1) annotation (Line(points={{87,19.1},{86,19.1},
          {86,14},{4.8,14},{4.8,1.6}}, color={0,0,127}));
  connect(sigBus.PLR, pLRMin.u) annotation (Line(
      points={{-0.925,100.07},{-0.925,92},{0,92},{0,73},{24.6,73}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.PLR, switch4.u3) annotation (Line(
      points={{-0.925,100.07},{-0.925,100},{0,100},{0,64},{54,64}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.Shutdown, switch3.u2) annotation (Line(
      points={{-0.925,100.07},{86,100.07},{86,100},{87,100},{87,39.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(productQCon.y, firstOrder.u) annotation (Line(points={{-80,-48.8},{-80,
          -72},{-46,-72},{-46,-80.8}}, color={0,0,127}));
  connect(addQEvap.y, firstOrder1.u) annotation (Line(points={{86,-54.8},{70,-54.8},
          {70,-74},{12,-74},{12,-82.8},{16,-82.8}}, color={0,0,127}));
  connect(QEva, QEva)
    annotation (Line(points={{80,-110},{80,-110}}, color={0,0,127}));
  connect(switch5.y, QCon) annotation (Line(points={{-84,-92.6},{-84,-96},{-80,-96},
          {-80,-110}},          color={0,0,127}));
  connect(switch6.y, QEva) annotation (Line(points={{81,-94.7},{81,-104},{80,-104},
          {80,-110}},
                  color={0,0,127}));
  connect(mFlowWaterMin.y, switch5.u2) annotation (Line(points={{30,19},{30,-68},
          {-84,-68},{-84,-78.8}}, color={255,0,255}));
  connect(mFlowWaterMin.y, switch6.u2) annotation (Line(points={{30,19},{30,-68},
          {81,-68},{81,-78.6}}, color={255,0,255}));
  connect(productQCon.y, switch5.u3) annotation (Line(points={{-80,-48.8},{-80,-78.8},
          {-79.2,-78.8}}, color={0,0,127}));
  connect(zero2.y, switch5.u1) annotation (Line(points={{-99.1,-72},{-88.8,-72},
          {-88.8,-78.8}},                          color={0,0,127}));
  connect(sigBus.mFlowWaterRel, mFlowWaterMin.u) annotation (Line(
      points={{-0.925,100.07},{-0.925,48},{30,48},{30,42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(sigBus.TSource, cOPNotManufacturer.tSource) annotation (Line(
      points={{-1,100},{-1,61},{-18,61}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.PLR, cOPNotManufacturer.pLR) annotation (Line(
      points={{-0.925,100.07},{-0.925,67},{-18,67}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.THot, cOPNotManufacturer.tConOutSet) annotation (Line(
      points={{-0.925,100.07},{-0.925,79},{-18,79}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConInMea, cOPNotManufacturer.tConIn) annotation (Line(
      points={{-0.925,100.07},{-0.925,73},{-18,73}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cOPNotManufacturer.COP, productQCon.u2) annotation (Line(points={{-41.2,
          70},{-84.8,70},{-84.8,-30.4}}, color={0,0,127}));
  connect(zero3.y, switch6.u1) annotation (Line(points={{46.4,-93},{64,-93},{64,
          -78.6},{75.4,-78.6}}, color={0,0,127}));
  connect(addQEvap.y, switch6.u3) annotation (Line(points={{86,-54.8},{86,-70},{
          86.6,-70},{86.6,-78.6}}, color={0,0,127}));
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
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model uses 4-dimensional table data, wich are calculated for a simplyfied refrigerant circuit with the use of isentropic compressor efficienciecs as a function of pressure gradient and frequency, superheating and calibration of minimal temperature differencees in condeser and evaporater. The table data ist a function of THot, TSource, deltaTCon and relative power, which represents compressor frequency.</p>
<p><br><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_Prel.png\"/></p>
<p><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_DeltaT_HK.png\"/></p>
</html>"));
end LookUpTableNDNotManufacturerSlim;
