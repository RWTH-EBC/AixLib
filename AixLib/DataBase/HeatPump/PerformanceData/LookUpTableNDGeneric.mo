within AixLib.DataBase.HeatPump.PerformanceData;
model LookUpTableNDGeneric "Generic performance map characteristic"
 extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

  // Not Manufacturer

  parameter Modelica.Units.SI.Temperature THotNom=THotNom "Nominal temperature of THot"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.Temperature TSourceNom=TSourceNom "Nominal temperature of TSource"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.HeatFlowRate QNom=QNom "Nominal heat flow"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=DeltaTCon "Temperature difference heat sink condenser"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));
  parameter Modelica.Units.SI.TemperatureDifference DeltaTEvap=DeltaTEvap "Temperature difference heat source evaporator"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

  parameter Modelica.Units.SI.Temperature TSource=TSource "temperature of heat source"
   annotation (Dialog(tab="NotManufacturer", group="General machine information"));

   parameter Boolean TSourceInternal=TSourceInternal
                                          "Use internal TSource?"
    annotation (Dialog(tab="NotManufacturer",tab="Advanced",group="General machine information"));

    parameter Boolean Modulating=Modulating "Is the heat pump inverter-driven?";

  BaseClasses.DesignGenericHP design(
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    DeltaTCon=DeltaTCon,
    Modulating=Modulating) "design operation"
    annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Modelica.Blocks.Math.Add addQEvap(k1=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-86})));
  Modelica.Blocks.Math.Product productPel annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,16})));
  Modelica.Blocks.Math.Product productQCon annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,-54})));

  BaseClasses.OffDesignGeneric offDesign(
    TSourceInternal=TSourceInternal,
    TSource=TSource)
                   "off design operation" annotation (Placement(transformation(
        extent={{-10,-20},{10,20}},
        rotation=270,
        origin={-80,64})));
  Modelica.Blocks.Sources.RealExpression zero3
    annotation (Placement(transformation(extent={{-60,-22},{-32,-4}})));

  Modelica.Blocks.Logical.Switch PelOnOff annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,-22})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={68,28})));
  Modelica.Blocks.Sources.BooleanExpression modulating(y=Modulating)
    annotation (Placement(transformation(extent={{126,16},{92,40}})));
  Modelica.Blocks.Sources.RealExpression one(y=1)
    annotation (Placement(transformation(extent={{118,40},{100,60}})));
  Modelica.Blocks.Math.Division division3
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Sources.RealExpression zero1(y=100)
    annotation (Placement(transformation(extent={{54,54},{74,74}})));
equation

  connect(productQCon.y, addQEvap.u2) annotation (Line(points={{-80,-65},{-80,
          -70},{74,-70},{74,-74}},                                  color={0,0,127}));

  connect(QEva, QEva)
    annotation (Line(points={{80,-110},{80,-110}}, color={0,0,127}));

  connect(sigBus.TConInMea,offDesign. tConIn) annotation (Line(
      points={{-0.925,100.07},{-0.925,102},{-86,102},{-86,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(offDesign.COP, productQCon.u2) annotation (Line(points={{-80,52.8},{
          -80,-38},{-86,-38},{-86,-42}}, color={0,0,127}));
  connect(PelOnOff.y, productQCon.u1) annotation (Line(points={{-6.66134e-16,
          -33},{-6.66134e-16,-36},{-74,-36},{-74,-42}}, color={0,0,127}));
  connect(PelOnOff.y, addQEvap.u1) annotation (Line(points={{-6.66134e-16,-33},
          {-6.66134e-16,-50},{86,-50},{86,-74}}, color={0,0,127}));
  connect(productQCon.y, QCon)
    annotation (Line(points={{-80,-65},{-80,-110}}, color={0,0,127}));
  connect(addQEvap.y, QEva)
    annotation (Line(points={{80,-97},{80,-110}}, color={0,0,127}));
  connect(PelOnOff.y, Pel)
    annotation (Line(points={{-6.66134e-16,-33},{0,-110}}, color={0,0,127}));
  connect(sigBus.TConOutMea,offDesign. tConOut) annotation (Line(
      points={{-0.925,100.07},{-38,100.07},{-38,102},{-98,102},{-98,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TEvaInMea,offDesign. tSource) annotation (Line(
      points={{-0.925,100.07},{-0.925,94},{-62,94},{-62,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.y, productPel.u1) annotation (Line(points={{57,28},{26,28}},
                                             color={0,0,127}));
  connect(modulating.y, switch1.u2) annotation (Line(points={{90.3,28},{80,28}},
                                     color={255,0,255}));

  connect(one.y, switch1.u3)
    annotation (Line(points={{99.1,50},{80,50},{80,36}},  color={0,0,127}));
  connect(sigBus, design.sigBus) annotation (Line(
      points={{-1,100},{-2,100},{-2,50},{19.95,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(design.PelFullLoadSetPoint, productPel.u2) annotation (Line(points={{18.8,
          48.25},{14,48.25},{14,28}}, color={0,0,127}));
  connect(sigBus.frequency,offDesign. frequency) annotation (Line(
      points={{-0.925,100.07},{-74,100.07},{-74,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(division3.y, switch1.u1) annotation (Line(points={{121,70},{130,70},{
          130,20},{80,20}},         color={0,0,127}));
  connect(zero1.y, division3.u2) annotation (Line(points={{75,64},{98,64}},
                                               color={0,0,127}));
  connect(sigBus.frequency, division3.u1) annotation (Line(
      points={{-0.925,100.07},{-2,100.07},{-2,76},{98,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.OnOff, PelOnOff.u2) annotation (Line(
      points={{-0.925,100.07},{-0.925,-10},{0,-10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(productPel.y, PelOnOff.u1)
    annotation (Line(points={{20,5},{20,-10},{8,-10}},     color={0,0,127}));
  connect(zero3.y, PelOnOff.u3)
    annotation (Line(points={{-30.6,-13},{-30.6,-14},{-18,-14},{-18,-10},{-8,
          -10}},                                         color={0,0,127}));
  connect(offDesign.COP, sigBus.COP) annotation (Line(points={{-80,52.8},{-80,
          40},{-32,40},{-32,100.07},{-0.925,100.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{140,100}}),                                  graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{140,
            100}})),
    Documentation(info="<html>
<p>This model uses 4-dimensional table data, wich are calculated for a simplyfied refrigerant circuit with the use of isentropic compressor efficienciecs as a function of pressure gradient and frequency, superheating and calibration of minimal temperature differencees in condeser and evaporater. The table data ist a function of THot, TSource, deltaTCon and relative power, which represents compressor frequency.</p>
<p><br><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_Prel.png\"/></p>
<p><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_DeltaT_HK.png\"/></p>
</html>"));
end LookUpTableNDGeneric;
