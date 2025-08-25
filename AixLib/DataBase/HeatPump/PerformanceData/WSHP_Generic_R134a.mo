within AixLib.DataBase.HeatPump.PerformanceData;
model WSHP_Generic_R134a "WSHP_Generic_R134a"
 extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;



  BaseClasses.DesignGenericHP design(
    THotNom=THotNom,
    TSourceNom=TSourceNom,
    QNom=QNom,
    DeltaTCon=DeltaTCon,
    FreDep=FreDep,
    filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/DataBase/HeatPump/PerformanceData/TEMP_COMP_MEAN_Scroll_R134a.sdf"),
    filename_T_Design=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/DataBase/HeatPump/PerformanceData/TEMP_COMP_MEAN_Scroll_R134a.sdf"),
    filename_COP=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/DataBase/HeatPump/PerformanceData/COP_Scroll_R134a.sdf"),
    filename_PI=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/DataBase/HeatPump/PerformanceData/PI_Scroll_R134a.sdf"))
                           "design operation"
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
    TSource=TSource,
    FreDep=FreDep,
    filename=ModelicaServices.ExternalReferences.loadResource("modelica://AixLib/DataBase/HeatPump/PerformanceData/COP_Scroll_R134a.sdf"))
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

equation

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
  connect(sigBus.nSet, productPel.u1) annotation (Line(
      points={{-0.925,100.07},{-0.925,88},{50,88},{50,32},{26,32},{26,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.nSet, offDesign.frequency) annotation (Line(
      points={{-0.925,100.07},{-38,100.07},{-38,98},{-78.4,98},{-78.4,76}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(productQCon.y, QCon) annotation (Line(points={{-80,-65},{-80,-110},{
          -80,-110}}, color={0,0,127}));
  connect(productQCon.y, addQEvap.u2) annotation (Line(points={{-80,-65},{-80,
          -80},{72,-80},{72,-74},{74,-74}}, color={0,0,127}));
  connect(offDesign.COP, sigBus.COP) annotation (Line(points={{-80,52.8},{-80,
          28},{-0.925,28},{-0.925,100.07}}, color={0,0,127}), Text(
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
    Documentation(info="<html><p>
  This model uses 4-dimensional table data, wich are calculated for a
  simplyfied refrigerant circuit with the use of isentropic compressor
  efficienciecs as a function of pressure gradient and frequency,
  superheating and calibration of minimal temperature differencees in
  condeser and evaporater. The table data ist a function of THot,
  TSource, deltaTCon and relative power, which represents compressor
  frequency.
</p>
<p>
  <br/>
  <img src=
  \"modelica://AixLib/../../../Diagramme%20AixLib/WP/KennfeldScroll_Prel.png\">
</p>
<p>
  <img src=
  \"modelica://AixLib/../../../Diagramme%20AixLib/WP/KennfeldScroll_DeltaT_HK.png\">
</p>
</html>"));
end WSHP_Generic_R134a;
