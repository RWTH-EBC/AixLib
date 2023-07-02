within AixLib.ThermalZones.HighOrder.Components.Shadow;
model Test
  extends Modelica.Icons.Example;
  ShadowLength shadowLength
    annotation (Placement(transformation(extent={{20,20},{60,60}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "D:/jji/Gitce/ebc0268_aif_smart_ventilation_nk/Sim_2023/WeatherData/TRY2015_507931060546_Jahr_City_Aachen.mos")
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  ShadowEff shadowEff1
    annotation (Placement(transformation(extent={{20,-60},{60,-20}})));
  RadTrans radTrans
    annotation (Placement(transformation(extent={{-62,-60},{-20,-20}})));
  ShadowEff shadowEff2(Mode=2)
    annotation (Placement(transformation(extent={{20,-100},{60,-60}})));
equation
  connect(weaDat.weaBus, shadowLength.weaBus) annotation (Line(
      points={{-80,0},{0,0},{0,40},{20,40}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, shadowEff1.weaBus) annotation (Line(
      points={{-80,0},{0,0},{0,-24},{20,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, radTrans.weaBus) annotation (Line(
      points={{-80,0},{-70,0},{-70,-24},{-62,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(radTrans.solarRad_out, shadowEff1.solarRad_in)
    annotation (Line(points={{-17.9,-40},{18,-40}}, color={255,128,0}));
  connect(shadowEff2.weaBus, shadowEff1.weaBus) annotation (Line(
      points={{20,-64},{0,-64},{0,-24},{20,-24}},
      color={255,204,51},
      thickness=0.5));
  connect(shadowEff2.solarRad_in, shadowEff1.solarRad_in) annotation (Line(
        points={{18,-80},{-8,-80},{-8,-40},{18,-40}}, color={255,128,0}));
  annotation (experiment(
      StopTime=31536000,
      Interval=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end Test;
