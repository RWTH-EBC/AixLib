within AixLib.ThermalZones.HighOrder.Components.Shadow;
model Test
  extends Modelica.Icons.Example;
  ShadowLength shadowLength
    annotation (Placement(transformation(extent={{40,60},{80,100}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/TRY2015_Jahr_City_Aachen.mos"))
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  ShadowEff shadowEff1
    annotation (Placement(transformation(extent={{40,20},{80,60}})));
  RadTrans radTrans
    annotation (Placement(transformation(extent={{-62,-60},{-20,-20}})));
  ShadowEff shadowEff2(Mode=2)
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
  ShadowEff shadowEff3(Mode=3)
    annotation (Placement(transformation(extent={{40,-60},{80,-20}})));
  ShadowEff shadowEff4(Mode=100)
    annotation (Placement(transformation(extent={{40,-100},{80,-60}})));
equation
  connect(weaDat.weaBus, radTrans.weaBus) annotation (Line(
      points={{-80,0},{-70,0},{-70,-24},{-62,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(shadowLength.weaBus, radTrans.weaBus) annotation (Line(
      points={{40,80},{0,80},{0,0},{-70,0},{-70,-24},{-62,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(shadowEff1.weaBus, radTrans.weaBus) annotation (Line(
      points={{40,56},{0,56},{0,0},{-70,0},{-70,-24},{-62,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(shadowEff2.weaBus, radTrans.weaBus) annotation (Line(
      points={{40,16},{0,16},{0,0},{-70,0},{-70,-24},{-62,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(shadowEff3.weaBus, radTrans.weaBus) annotation (Line(
      points={{40,-24},{0,-24},{0,0},{-70,0},{-70,-24},{-62,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(shadowEff4.weaBus, radTrans.weaBus) annotation (Line(
      points={{40,-64},{0,-64},{0,0},{-70,0},{-70,-24},{-62,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(radTrans.solarRad_out, shadowEff1.solarRad_in) annotation (Line(
        points={{-17.9,-40},{20,-40},{20,40},{38,40}}, color={255,128,0}));
  connect(shadowEff2.solarRad_in, shadowEff1.solarRad_in) annotation (Line(
        points={{38,0},{20,0},{20,40},{38,40}}, color={255,128,0}));
  connect(shadowEff3.solarRad_in, shadowEff1.solarRad_in) annotation (Line(
        points={{38,-40},{20,-40},{20,40},{38,40}}, color={255,128,0}));
  connect(shadowEff4.solarRad_in, shadowEff1.solarRad_in) annotation (Line(
        points={{38,-80},{20,-80},{20,40},{38,40}}, color={255,128,0}));
  annotation (experiment(
      StopTime=31536000,
      Interval=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end Test;
