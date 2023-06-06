within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_PlateHeatExchanger2
  "Simple test case for the two variants of plate heat exchanger"
  extends Modelica.Icons.Example;
  Components.HeatRecoverySystem plateHeatExchangerFixedEfficiency(redeclare
      model PartialPressureDrop = Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-20,-60},{22,-20}})));
  Modelica.Blocks.Sources.Ramp m_flow(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=1800)
    annotation (Placement(transformation(extent={{-100,74},{-80,94}})));
  Modelica.Blocks.Sources.Constant X_EtaIn(k=0.01)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Blocks.Sources.Constant T_EtaIn(k=293.15)
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Modelica.Blocks.Sources.Constant const(k=291.15)
    annotation (Placement(transformation(extent={{52,-10},{32,10}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Airflow/AirHandlingUnit/ModularAirHandlingUnit/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-84,-52},{-64,-32}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-114,-2},{-74,38}}),iconTransformation(extent={
            {-160,22},{-140,42}})));
equation
  connect(m_flow.y, plateHeatExchangerFixedEfficiency.m_flow_airInOda)
    annotation (Line(points={{-79,84},{-60,84},{-60,-24},{-22.1,-24}}, color={0,
          0,127}));
  connect(m_flow.y, plateHeatExchanger.m_flow_airInOda) annotation (Line(points={{-79,84},
          {-60,84},{-60,56},{-22,56}},          color={0,0,127}));
  connect(m_flow.y, plateHeatExchanger.m_flow_airInEta) annotation (Line(points={{-79,84},
          {-60,84},{-60,100},{60,100},{60,56},{22,56}},          color={0,0,127}));
  connect(m_flow.y, plateHeatExchangerFixedEfficiency.m_flow_airInEta)
    annotation (Line(points={{-79,84},{-60,84},{-60,100},{60,100},{60,-24},{24.1,
          -24}},      color={0,0,127}));
  connect(X_EtaIn.y, plateHeatExchangerFixedEfficiency.X_airInEta) annotation (
      Line(points={{79,-30},{60,-30},{60,-36},{24.1,-36}}, color={0,0,127}));
  connect(X_EtaIn.y, plateHeatExchanger.X_airInEta) annotation (Line(points={{
          79,-30},{60,-30},{60,44},{22,44}}, color={0,0,127}));
  connect(T_EtaIn.y, plateHeatExchanger.T_airInEta) annotation (Line(points={{
          79,30},{60,30},{60,50},{22,50}}, color={0,0,127}));
  connect(T_EtaIn.y, plateHeatExchangerFixedEfficiency.T_airInEta) annotation (
      Line(points={{79,30},{60,30},{60,-30},{24.1,-30}}, color={0,0,127}));
  connect(const.y, plateHeatExchangerFixedEfficiency.T_set)
    annotation (Line(points={{31,0},{1,0},{1,-18}}, color={0,0,127}));
  connect(const.y, plateHeatExchanger.T_set) annotation (Line(points={{31,0},{28,
          0},{28,20},{60,20},{60,82},{0,82},{0,62}}, color={0,0,127}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,50},{-80,18},{-94,18}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.pAtm,x_pTphi. p_in) annotation (Line(
      points={{-94,18},{-92,18},{-92,-36},{-86,-36}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul,x_pTphi. T) annotation (Line(
      points={{-94,18},{-92,18},{-92,-42},{-86,-42}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.relHum,x_pTphi. phi) annotation (Line(
      points={{-94,18},{-92,18},{-92,-48},{-86,-48}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, plateHeatExchanger.T_airInOda) annotation (Line(
      points={{-94,18},{-60,18},{-60,50},{-22,50}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, plateHeatExchangerFixedEfficiency.T_airInOda)
    annotation (Line(
      points={{-94,18},{-60,18},{-60,-30},{-22.1,-30}},
      color={255,204,51},
      thickness=0.5));
  connect(x_pTphi.X[1], plateHeatExchangerFixedEfficiency.X_airInOda)
    annotation (Line(points={{-63,-42},{-60,-42},{-60,-36},{-22.1,-36}}, color={
          0,0,127}));
  connect(x_pTphi.X[1], plateHeatExchanger.X_airInOda) annotation (Line(points={
          {-63,-42},{-60,-42},{-60,44},{-22,44}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, Interval=3600),
 Documentation(info="<html><p>
  Testing <a href=
  \"modelica://SimpleAHU.Components.PlateHeatExchanger\">SimpleAHU.Components.PlateHeatExchanger</a>
  and <a href=
  \"modelica://SimpleAHU.Components.PlateHeatExchangerFixedEfficiency\">SimpleAHU.Components.PlateHeatExchangerFixedEfficiency</a>
  with weather temperature and massfraction for outdoor air.
</p>
<p>
  The temperature and massfraction of the exhaust air is constant.
</p>
</html>"), Icon(graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}));
end Test_PlateHeatExchanger2;
