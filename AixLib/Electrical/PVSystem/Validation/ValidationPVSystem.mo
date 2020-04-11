within AixLib.Electrical.PVSystem.Validation;
model ValidationPVSystem
  "Validation with empirical data from NIST for the date of 14.06.2020"
  extends Modelica.Icons.Example;

  PVSystem pVSystem(
    redeclare DataBase.SolarElectric.SharpNUU235F2 data,
    redeclare model IVCharacteristics = BaseClasses.PVModule5pAnalytical,
    redeclare model CellTemperature = BaseClasses.CellTemperatureOpenRack,
    n_mod=1152,
    til=0.34906585039887,
    azi=0,
    lat=0.68298049756117,
    lon=-1.3476402739642,
    alt=0.67,
    timZon=-18000)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
    "DC output power of the PV array"
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{4,-10},{24,10}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="Ground2016",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/weatherdata/NIST_onemin_Ground_2016.txt"),
    columns={5,8,3,6},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  Modelica.Blocks.Math.UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-22,-4},{-16,2}})));

  Modelica.Blocks.Interfaces.RealOutput DCOutputPower_Measured(
  final quantity="Power",
  final unit="W")
    "Measured DC output power of the PV array"
    annotation (Placement(transformation(extent={{96,-50},{116,-30}})));
  Modelica.Blocks.Math.Gain gain(k=1000)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation
  connect(pVSystem.DCOutputPower, DCOutputPower)
    annotation (Line(points={{61,0},{106,0}}, color={0,0,127}));
  connect(pVSystem.weaBus, weaBus) annotation (Line(
      points={{38.2,0.6},{14.1,0.6},{14.1,0},{14,0}},
      color={255,204,51},
      thickness=0.5));
  connect(combiTimeTable.y[2], weaBus.winSpe) annotation (Line(points={{-79,0},
          {-36,0},{-36,-20},{14,-20},{14,0}}, color={0,0,127}));
  connect(combiTimeTable.y[3], weaBus.HGloHor) annotation (Line(points={{-79,0},
          {-36,0},{-36,12},{14,12},{14,0}}, color={0,0,127}));
  connect(combiTimeTable.y[1], from_degC.u) annotation (Line(points={{-79,0},{
          -30,0},{-30,-1},{-22.6,-1}},
                                     color={0,0,127}));
  connect(from_degC.y, weaBus.TDryBul) annotation (Line(points={{-15.7,-1},{
          0.15,-1},{0.15,0},{14,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable.y[4], gain.u) annotation (Line(points={{-79,0},{-36,0},
          {-36,-40},{38,-40}},          color={0,0,127}));
  connect(gain.y, DCOutputPower_Measured)
    annotation (Line(points={{61,-40},{106,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-98,40},{-40,6}},
          lineColor={28,108,200},
          textString="1 - Air temperature in °C
2 - Wind speed in m/s
3 - Global horizontal irradiance in W/m2
4 - Ouput power in kW",
          horizontalAlignment=TextAlignment.Left)}),
    experiment(
      StartTime=14256000,
      StopTime=14342400,
      Interval=60),
    Documentation(info="<html>
<p>The PVSystem model is validaded with empirical data from: <a href=\"https://pvdata.nist.gov/\">https://pvdata.nist.gov/</a> </p>
<p>The date 14.06.2020 was chosen as an example for the PVSystem model.</p>
</html>"));
end ValidationPVSystem;
