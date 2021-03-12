within AixLib.ThermalZones.ReducedOrder.Examples;
model ThermalZone "Illustrates the use of ThermalZone"
  extends Modelica.Icons.Example;

   parameter Integer numZones=2
    "Number of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[:]={
      Output_Schwimmbad_Modell.Hallenbad.Hallenbad_DataBase.Hallenbad_Schwimmhalle(),
      Output_Schwimmbad_Modell.Hallenbad.Hallenbad_DataBase.Hallenbad_Schwimmhalle()}
    "Setup for zones" annotation (choicesAllMatching=false);
  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone_withPools thermalZone_withPools[numZones](
    each final internalGainsMode=1,
    each final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final zoneParam=zoneParam,
    ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
            each der_T(fixed=true)))),
    redeclare package Medium = Media.Air,
    use_AirExchange=true)                 "Thermal zone"
    annotation (Placement(transformation(extent={{-14,-12},{6,8}})));


     replaceable model corG = SolarGain.CorrectionGDoublePane constrainedby
    AixLib.ThermalZones.ReducedOrder.SolarGain.BaseClasses.PartialCorrectionG
    "Model for correction of solar transmission" annotation (choicesAllMatching
      =true);


  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[numZones]
    "Radiative heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{34,20},{14,40}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=500,
    freqHz=1/86400,
    offset=500)
    "Sinusoidal excitation for additional internal gains"
    annotation (Placement(transformation(extent={{92,-6},{72,14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1[numZones]
    "Convective heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{46,-24},{26,-4}})));
  Modelica.Blocks.Math.Gain gain(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{64,-2},{52,10}})));
  Modelica.Blocks.Math.Gain gain1(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{64,-20},{52,-8}})));

  Modelica.Blocks.Sources.CombiTimeTable tableOpeningHours(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="OpeningHours",
    columns=2:(numZones + 1),
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Output_Schwimmbad_Modell/Hallenbad/OpeningHours_Hallenbad.txt"))                                                        "Boundary condition: Opening Hours of swiming pools"
    annotation (Placement(transformation(extent={{-74,-88},{-58,-72}})));
  Modelica.Blocks.Sources.CombiTimeTable tableTSet(
    tableOnFile=true,
    tableName="Tset",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Output_Schwimmbad_Modell/Hallenbad/Hallenbad_34grad.txt"),
    columns=2:(numZones + 1))
    "Set points for heater"
    annotation (Placement(transformation(extent={{70,-64},{54,-48}})));

    Modelica.Blocks.Sources.CombiTimeTable tableTSetCool(
    tableOnFile=true,
    tableName="Tset",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://Output_Schwimmbad_Modell/Hallenbad/Hallenbad_34grad.txt"),
    columns=2:(numZones + 1))
      "Set points for cooler"
    annotation (Placement(transformation(extent={{76,-86},{60,-70}})));


  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=Modelica.Utilities.Files.loadResource("modelica://Output_Schwimmbad_Modell/Hallenbad/InternalGains_Hallenbad.txt"),
    columns=2:(1 + 3))
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{72,-42},{56,-26}})));

  Modelica.Blocks.Sources.Constant const1[numZones](each k=0.2)
    "Infiltration rate"
    annotation (Placement(transformation(extent={{-82,-42},{-72,-32}})));
  Modelica.Blocks.Routing.Replicator replicatorTemperatureVentilation(nout=
        numZones)
    "Replicates dry bulb air temperature for numZones"
    annotation (Placement(transformation(
    extent={{-5,-5},{5,5}},
    rotation=0,
    origin={-61,-9})));
  Modelica.Blocks.Sources.Constant const2[numZones](each k=0.2)
    "Infiltration rate"
    annotation (Placement(transformation(extent={{-30,22},{-20,32}})));
  BoundaryConditions.WeatherData.Bus        weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-112,-6},{-78,26}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
equation
   for i in 1:numZones loop
      connect(tableInternalGains.y, thermalZone_withPools[i].intGains) annotation (
      Line(points={{55.2,-34},{4,-34},{4,-10.4}},             color={0,0,127}));
      connect(thermalZone_withPools[i].intGainsConv, prescribedHeatFlow[i].port)
    annotation (Line(points={{6.2,-1.6},{16.1,-1.6},{16.1,30},{14,30}},
                                                                      color={191,
          0,0}));
      connect(thermalZone_withPools[i].intGainsRad, prescribedHeatFlow1[i].port)
    annotation (Line(points={{6.2,1.4},{16.1,1.4},{16.1,-14},{26,-14}}, color={191,
          0,0}));
    connect(gain1.y, prescribedHeatFlow1[i].Q_flow)
    annotation (Line(points={{51.4,-14},{46,-14}},          color={0,0,127}));
      connect(weaDat.weaBus, thermalZone_withPools[i].weaBus) annotation (Line(
      points={{-70,30},{-42,30},{-42,4},{-14,4}},
      color={255,204,51},
      thickness=0.5));
    connect(gain.y, prescribedHeatFlow[i].Q_flow) annotation (Line(points={{51.4,4},
          {44,4},{44,30},{34,30}}, color={0,0,127}));
    if thermalZone_withPools[i].zoneParam.CoolerOn then
      connect(tableTSetCool.y[i], thermalZone_withPools[i].TSetCool) annotation (Line(
        points={{59.2,-78},{-34,-78},{-34,2},{-13.6,2}}, color={0,0,127}));
    end if;
    if thermalZone_withPools[i].zoneParam.HeaterOn then
      connect(tableTSet.y[i], thermalZone_withPools[i].TSetHeat) annotation (Line(points={{53.2,
              -56},{-24,-56},{-24,-0.8},{-13.6,-0.8}},
        color={0,0,127}));
    end if;
   end for;
  connect(tableOpeningHours.y, thermalZone_withPools.openingHours) annotation (
      Line(points={{-57.2,-80},{-28,-80},{-28,-10.4},{1.2,-10.4}}, color={0,0,127}));


  connect(sine.y, gain.u)
    annotation (Line(points={{71,4},{65.2,4}},          color={0,0,127}));
  connect(sine.y, gain1.u) annotation (Line(points={{71,4},{68,4},{68,-14},{65.2,
          -14}}, color={0,0,127}));







  connect(weaBus.TDryBul,replicatorTemperatureVentilation. u) annotation (Line(
      points={{-95,10},{-90,10},{-90,-16},{-67,-16},{-67,-9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-70,30},{-32,30},{-32,10},{-95,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(replicatorTemperatureVentilation.y, thermalZone_withPools.ventTemp)
    annotation (Line(points={{-55.5,-9},{-44,-9},{-44,-2},{-28,-2},{-28,-3.6},{
          -13.6,-3.6}}, color={0,0,127}));
  connect(const1.y, thermalZone_withPools.ventRate) annotation (Line(points={{
          -71.5,-37},{-60,-37},{-60,-38},{-50,-38},{-50,-6.2},{-13.6,-6.2}},
        color={0,0,127}));
  connect(thermalZone_withPools.ventHum, const2.y) annotation (Line(points={{
          -13.5,-9.1},{-13.5,9.45},{-19.5,9.45},{-19.5,27}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),experiment(StopTime=172800,
        Interval=3600),
    Documentation(revisions="<html><ul>
  <li>September 29, 2016, by Moritz Lauster:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  This example illustrates the use of <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone</a>.
  Parameter set for thermal zone is for an office zone of an office
  building build as passive house. All boundary conditions are generic
  to show how to apply different kinds of boundary conditions. The
  results should show a typical profile for indoor air temperatures,
  but are not related to a specific building or measurement data.
</p>
</html>"));
end ThermalZone;
