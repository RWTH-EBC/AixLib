within AixLib.DataBase.HeatPump.PerformanceData;
model LookUpTableNDNotManufacturerSlim
  "4-dimensional table without manufacturer data for heat pump"
 extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

  // Not Manufacturer
  parameter Modelica.Units.SI.Temperature THotMax=333.15 "Max. value of THot before shutdown"
  annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.HeatFlowRate QNom=30000 "Nominal heat flow"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Real PLRMin=0.4 "Limit of PLR; less =0"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Boolean HighTemp=false "true: THot > 60°C"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

  parameter Modelica.Units.SI.Temperature TSource=280 "temperature of heat source"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

   parameter Boolean TSourceInternal=false
                                          "Use internal TSource?"
    annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

    parameter Boolean THotExternal=false "Use external THot?"
                                                             annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

  NominalHeatPumpNotManufacturer NominalCOP(
    HighTemp=HighTemp,
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    DeltaTCon=DeltaTCon) "Nominal Operating"
    annotation (Placement(transformation(extent={{28,36},{8,56}})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={50,44})));
  Modelica.Blocks.Sources.RealExpression zero
    annotation (Placement(transformation(extent={{102,44},{84,64}})));
  Modelica.Blocks.Math.Add addQEvap(k1=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-86})));
  Modelica.Blocks.Math.Product productPel annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={8,14})));
  Modelica.Blocks.Math.Product productQCon annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,-54})));

  Modelica.Blocks.Logical.LessThreshold mFlowWaterMin(threshold=0.01)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,50})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=THotExternal)
    annotation (Placement(transformation(extent={{26506,-7302},{26552,-7278}})));
  COPNotManufacturer ActualCOP(
    TSourceInternal=TSourceInternal,
    THotExternal=THotExternal,
    TSource=TSource,
    THotNom=THotNom,
    PLRMin=PLRMin,
    HighTemp=HighTemp) "Actual operating is represented" annotation (Placement(
        transformation(
        extent={{-10,-20},{10,20}},
        rotation=270,
        origin={-80,64})));
  Modelica.Blocks.Sources.RealExpression zero3
    annotation (Placement(transformation(extent={{-48,-12},{-36,2}})));

  Modelica.Blocks.Logical.Switch P_elOnOff annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-22})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{58,78},{78,98}})));
equation

  connect(zero.y, switch4.u1) annotation (Line(points={{83.1,54},{70,54},{70,56},
          {58,56}},          color={0,0,127}));
  connect(productQCon.y, addQEvap.u2) annotation (Line(points={{-80,-65},{-80,
          -70},{74,-70},{74,-74}},                                  color={0,0,127}));
  connect(NominalCOP.QEvapNom, sigBus.QEvapNom) annotation (Line(points={{7,48},{
          -0.925,48},{-0.925,100.07}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(NominalCOP.PelFullLoad, productPel.u2) annotation (Line(points={{7,38},{
          2,38},{2,26}},                           color={0,0,127}));
  connect(sigBus.PLR, pLRMin.u) annotation (Line(
      points={{-0.925,100.07},{-0.925,92},{0,92},{0,80},{18,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.PLR, switch4.u3) annotation (Line(
      points={{-0.925,100.07},{-0.925,80},{12,80},{12,60},{42,60},{42,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(QEva, QEva)
    annotation (Line(points={{80,-110},{80,-110}}, color={0,0,127}));
  connect(sigBus.mFlowWaterRel, mFlowWaterMin.u) annotation (Line(
      points={{-0.925,100.07},{-0.925,68},{-30,68},{-30,62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(sigBus.TSource, ActualCOP.tSource) annotation (Line(
      points={{-1,100},{-1,102},{-62,102},{-62,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.PLR, ActualCOP.pLR) annotation (Line(
      points={{-0.925,100.07},{-0.925,102},{-74,102},{-74,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.THot, ActualCOP.tConOutSet) annotation (Line(
      points={{-0.925,100.07},{-0.925,102},{-98,102},{-98,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConInMea, ActualCOP.tConIn) annotation (Line(
      points={{-0.925,100.07},{-0.925,102},{-86,102},{-86,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ActualCOP.COP, productQCon.u2) annotation (Line(points={{-80,52.8},{
          -80,-38},{-86,-38},{-86,-42}}, color={0,0,127}));
  connect(zero3.y, P_elOnOff.u1)
    annotation (Line(points={{-35.4,-5},{-8,-5},{-8,-10}}, color={0,0,127}));
  connect(mFlowWaterMin.y, P_elOnOff.u2) annotation (Line(points={{-30,39},{-30,
          0},{0,0},{0,-10},{7.77156e-16,-10}}, color={255,0,255}));
  connect(productPel.y, P_elOnOff.u3)
    annotation (Line(points={{8,3},{8,-10}}, color={0,0,127}));
  connect(P_elOnOff.y, productQCon.u1) annotation (Line(points={{-6.66134e-16,
          -33},{-6.66134e-16,-36},{-74,-36},{-74,-42}}, color={0,0,127}));
  connect(P_elOnOff.y, addQEvap.u1) annotation (Line(points={{-6.66134e-16,-33},
          {-6.66134e-16,-36},{86,-36},{86,-74}}, color={0,0,127}));
  connect(productQCon.y, QCon)
    annotation (Line(points={{-80,-65},{-80,-110}}, color={0,0,127}));
  connect(addQEvap.y, QEva)
    annotation (Line(points={{80,-97},{80,-110}}, color={0,0,127}));
  connect(P_elOnOff.y, Pel)
    annotation (Line(points={{-6.66134e-16,-33},{0,-110}}, color={0,0,127}));
  connect(pLRMin.y, or1.u2)
    annotation (Line(points={{41,80},{56,80}}, color={255,0,255}));
  connect(sigBus.Shutdown, or1.u1) annotation (Line(
      points={{-0.925,100.07},{-0.925,100},{48,100},{48,88},{56,88}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(or1.y, switch4.u2) annotation (Line(points={{79,88},{84,88},{84,62},{
          50,62},{50,56}}, color={255,0,255}));
  connect(switch4.y, productPel.u1)
    annotation (Line(points={{50,33},{50,26},{14,26}}, color={0,0,127}));
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
