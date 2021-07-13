within AixLib.Electrical.PVSystem.Validation;
model ValidationPVSystem
  "Validation with empirical data from NIST for the date of 14.06.2016"
  extends Modelica.Icons.Example;

  PVSystem pVSystem(
    redeclare DataBase.SolarElectric.SharpNUU235F2 data,
    redeclare model IVCharacteristics =
        BaseClasses.IVCharacteristics5pAnalytical,
    redeclare model CellTemperature =
        BaseClasses.CellTemperatureMountingCloseToGround,
    n_mod=312,
    til=0.17453292519943,
    azi=0,
    lat=0.68304158408499,
    lon=-1.3476664539029,
    alt=0.08,
    timZon=-18000)
    "PV System according to measurements taken from https://pvdata.nist.gov/  "
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
    "DC output power of the PV array"
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{4,-10},{24,10}})));
  Modelica.Blocks.Sources.CombiTimeTable NISTdata(
    tableOnFile=true,
    tableName="Roof2016",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/NIST_onemin_Roof_2016.txt"),
    columns={3,5,2,4},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    "The PVSystem model is validaded with measurement data from: https://pvdata.nist.gov/ "
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-22,-4},{-14,4}})));

  Modelica.Blocks.Interfaces.RealOutput DCOutputPower_Measured(
  final quantity="Power",
  final unit="W")
    "Measured DC output power of the PV array"
    annotation (Placement(transformation(extent={{96,-50},{116,-30}})));
  Modelica.Blocks.Math.Gain kiloWattToWatt(k=1000)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation
  connect(pVSystem.DCOutputPower, DCOutputPower)
    annotation (Line(points={{61,0},{106,0}}, color={0,0,127}));
  connect(pVSystem.weaBus, weaBus) annotation (Line(
      points={{38.2,0.6},{14.1,0.6},{14.1,0},{14,0}},
      color={255,204,51},
      thickness=0.5));
  connect(NISTdata.y[2], weaBus.winSpe) annotation (Line(points={{-79,0},{-36,0},
          {-36,-20},{14,-20},{14,0}}, color={0,0,127}));
  connect(NISTdata.y[3], weaBus.HGloHor) annotation (Line(points={{-79,0},{-36,
          0},{-36,18},{14,18},{14,0}}, color={0,0,127}));
  connect(NISTdata.y[1], from_degC.u)
    annotation (Line(points={{-79,0},{-22.8,0}}, color={0,0,127}));
  connect(from_degC.y, weaBus.TDryBul) annotation (Line(points={{-13.6,0},{14,0}},
                                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(NISTdata.y[4], kiloWattToWatt.u) annotation (Line(points={{-79,0},{-36,
          0},{-36,-40},{38,-40}}, color={0,0,127}));
  connect(kiloWattToWatt.y, DCOutputPower_Measured)
    annotation (Line(points={{61,-40},{106,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-98,46},{-40,12}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="1 - Air temperature in °C
2 - Wind speed in m/s
3 - Global horizontal irradiance in W/m2
4 - Ouput power in kW")}),
    experiment(
      StartTime=28684800,
      StopTime=28771200,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html><p>
  The PVSystem model is validaded with empirical data from: <a href=
  \"https://pvdata.nist.gov/\">https://pvdata.nist.gov/</a>
</p>
<p>
  The date 14.06.2016 was chosen as an example for the PVSystem model.
</p>
<p>
  The PV mounting is an open rack system based on the ground.
</p>
</html>"));
end ValidationPVSystem;
