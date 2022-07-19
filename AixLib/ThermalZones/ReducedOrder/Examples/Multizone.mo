within AixLib.ThermalZones.ReducedOrder.Examples;
model Multizone "Illustrates the use of Multizone"
  import AixLib;
  extends Modelica.Icons.Example;

  AixLib.ThermalZones.ReducedOrder.Multizone.Multizone multizone(
    buildingID=1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    VAir=33500,
    ABuilding=8375,
    ASurTot=12744.27,
    numZones=5,
    zoneParam={AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
        AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
        AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
        AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office(),
        AixLib.DataBase.ThermalZones.OfficePassiveHouse.OPH_1_Office()},
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    T_start=293.15,
    zone(ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(
            thermCapInt(each der_T(fixed=true))))),
    internalGainsMode=1)
    "Multizone"
    annotation (Placement(transformation(extent={{32,-8},{52,12}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3
    weaDat(
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false,
    filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-82,30},{-62,50}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(transformation(extent={{-68,-10},{-34,22}}),
    iconTransformation(extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Routing.Replicator replicatorTemperatureVentilation(nout=5)
    "Replicates dry bulb air temperature for numZones"
    annotation (Placement(transformation(
    extent={{-5,-5},{5,5}},
    rotation=0,
    origin={-31,-13})));
  Modelica.Blocks.Sources.Constant const[5](each k=0.2) "Infiltration rate"
    annotation (Placement(transformation(extent={{-36,-38},{-26,-28}})));
  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/Internals_Input_6Zone_SIA.txt"),
    columns=2:16)
    "Profiles for internal gains"
    annotation (Placement(transformation(extent={{72,-42},{56,-26}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow[5]
    "Radiative heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{-14,-64},{6,-44}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=500,
    f=1/86400,
    offset=500) "Sinusoidal excitation for additional internal gains"
    annotation (Placement(transformation(extent={{-90,-74},{-70,-54}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1[5]
    "Convective heat flow of additional internal gains"
    annotation (Placement(transformation(extent={{-14,-86},{6,-66}})));
  Modelica.Blocks.Math.Gain gain(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{-56,-60},{-44,-48}})));
  Modelica.Blocks.Math.Gain gain1(k=0.5)
    "Split additional internal gains into radiative an convective"
    annotation (Placement(transformation(extent={{-56,-82},{-44,-70}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=5)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-30,-54})));
  Modelica.Blocks.Routing.Replicator replicator1(nout=5)
    "Replicates sinusoidal excitation for numZones" annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-30,-76})));

  Modelica.Blocks.Sources.Constant TSet[5](each k=0)
    "Dummy for heater cooler (not existing in record)"
    annotation (Placement(transformation(extent={{66,-60},{56,-50}})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-62,40},{-51,40},{-51,6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaDat.weaBus, multizone.weaBus) annotation (Line(
      points={{-62,40},{-32,40},{-32,6},{34,6}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, replicatorTemperatureVentilation.u) annotation (Line(
      points={{-51,6},{-44,6},{-44,-12},{-37,-12},{-37,-13}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(replicatorTemperatureVentilation.y, multizone.ventTemp) annotation (
      Line(points={{-25.5,-13},{-20,-13},{-20,2},{33,2}},     color={0,0,127}));
  connect(const.y, multizone.ventRate) annotation (Line(points={{-25.5,-33},{
          -18,-33},{-18,-0.6},{33,-0.6}},
                                color={0,0,127}));
  connect(tableInternalGains.y, multizone.intGains)
    annotation (Line(points={{55.2,-34},{48,-34},{48,-9}}, color={0,0,127}));
  connect(gain.y, replicator.u)
    annotation (Line(points={{-43.4,-54},{-37.2,-54}}, color={0,0,127}));
  connect(sine.y, gain.u) annotation (Line(points={{-69,-64},{-62,-64},{-62,-54},
          {-57.2,-54}}, color={0,0,127}));
  connect(sine.y, gain1.u) annotation (Line(points={{-69,-64},{-62,-64},{-62,-76},
          {-57.2,-76}}, color={0,0,127}));
  connect(gain1.y, replicator1.u)
    annotation (Line(points={{-43.4,-76},{-37.2,-76}}, color={0,0,127}));
  connect(replicator1.y, prescribedHeatFlow1.Q_flow)
    annotation (Line(points={{-23.4,-76},{-14,-76}}, color={0,0,127}));
  connect(replicator.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-23.4,
          -54},{-18.7,-54},{-14,-54}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, multizone.intGainsRad) annotation (Line(
        points={{6,-54},{18,-54},{18,-22},{18,-2},{18,-3},{34,-3}},
                                color={191,0,0}));
  connect(prescribedHeatFlow1.port, multizone.intGainsConv) annotation (Line(
        points={{6,-76},{18,-76},{26,-76},{26,-6.2},{34,-6.2}},
                                                            color={191,0,0}));
  connect(TSet.y, multizone.TSetCool) annotation (Line(points={{55.5,-55},{34.6,
          -55},{34.6,-9}}, color={0,0,127}));
  connect(TSet.y, multizone.TSetHeat) annotation (Line(points={{55.5,-55},{36.8,
          -55},{36.8,-9}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=3.1536e+007, Interval=3600),
    Documentation(info="<html><p>
  This example illustrates the use of <a href=
  \"AixLib.ThermalZones.ReducedOrder.Multizone.Multizone\">AixLib.ThermalZones.ReducedOrder.Multizone.Multizone</a>.
  Parameter set is for an office building build as passive house. All
  boundary conditions are generic to show how to apply different kinds
  of boundary conditions. The results should show typical profiles for
  indoor air temperatures, but are not related to a specific building
  or measurement data.
</p>
<ul>
  <li>September 29, 2016, by Moritz Lauster:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Multizone;
