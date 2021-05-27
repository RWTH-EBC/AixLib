within AixLib.ThermalZones.ReducedOrder;
package Examples "Collection of models that illustrate model use and test models"
  extends Modelica.Icons.ExamplesPackage;





  model MultizoneEquippedSwimmingBath "Indoor Swimming Hall"
    import AixLib;
  import ModelicaServices;
    extends Modelica.Icons.Example;


    AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped multizone(
      T_start=295.15,
      buildingID=0,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      VAir=8673.1,
      ABuilding=2626.7,
      ASurTot=10544.78039975368,
      numZones=6,
      use_swimmingPools_MZ=true,
      internalGainsMode=3,
      use_C_flow=true,
      use_moisture_balance=true,
      redeclare package Medium = AixLib.Media.Air (extraPropertiesNames={"C_flow"}),
      zoneParam={AixLib.DataBase.ThermalZones.SwimmingBath.EntranceArea(),
          AixLib.DataBase.ThermalZones.SwimmingBath.DressingRooms(),
          AixLib.DataBase.ThermalZones.SwimmingBath.LifeguardRoom(),
          AixLib.DataBase.ThermalZones.SwimmingBath.Washroom(),
          AixLib.DataBase.ThermalZones.SwimmingBath.UtilityRoom(),
          AixLib.DataBase.ThermalZones.SwimmingBath.SwimmingHall()},
      heatAHU=true,
      coolAHU=true,
      dehuAHU=true,
      huAHU=true,
      BPFDehuAHU=0.2,
      HRS=true,
      sampleRateAHU=300,
      effFanAHU_sup=0.7,
      effFanAHU_eta=0.7,
      effHRSAHU_enabled=0.8,
      effHRSAHU_disabled=0.2,
      dpAHU_sup=800,
      dpAHU_eta=800,
      zone(ROM(
          extWallRC(thermCapExt(each der_T(fixed=true))),
          intWallRC(thermCapInt(each der_T(fixed=true))),
          floorRC(thermCapExt(each der_T(fixed=true))),
          roofRC(thermCapExt(each der_T(fixed=true))))),
      redeclare model corG =
          AixLib.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane,
      redeclare model AHUMod = AixLib.Airflow.AirHandlingUnit.AHU) "Multizone"
      annotation (Placement(transformation(extent={{32,-8},{52,12}})));

    AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
      computeWetBulbTemperature=false,
      filNam=ModelicaServices.ExternalReferences.loadResource(
          "modelica://Output_Schwimmbad_Modell/TRY_517534078929_Ahlen/TRY2015_517534078929_Jahr_City_Ahlen.mos"))
      "Weather data reader"
      annotation (Placement(transformation(extent={{-82,30},{-62,50}})));

    Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
      tableOnFile=true,
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      tableName="Internals",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/InternalGains_SwimmingBath.txt"),
      columns=2:(1 + 3*6))
      "Profiles for internal gains"
      annotation (Placement(transformation(extent={{72,-42},{56,-26}})));

    Modelica.Blocks.Sources.CombiTimeTable tableTSet(
      tableOnFile=true,
      tableName="Tset",
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/TsetHeat_6Zones_SwimmingBath.txt"),
      columns=2:(1 + 6))
      "Set points for heater"
      annotation (Placement(transformation(extent={{72,-68},{56,-52}})));

      Modelica.Blocks.Sources.CombiTimeTable tableTSetCool(
        tableOnFile=true,
        tableName="Tset",
        extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/TsetCool_6Zones_SwimmingBath.txt"),
      columns=2:(1 + 6))
        "Set points for cooler"
      annotation (Placement(transformation(extent={{74,-92},{58,-76}})));

    Modelica.Blocks.Sources.CombiTimeTable tableOpeningHours(
      tableOnFile=true,
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      tableName="OpeningHours",
      columns=2:(1 + 6),
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/Profile_openingHours_pools.txt"))
      "Boundary condition: Opening Hours of swiming pools"
      annotation (Placement(transformation(extent={{-64,-32},{-48,-16}})));
    Modelica.Blocks.Sources.CombiTimeTable tableWavePool(
      tableOnFile=true,
      columns=2:(1 + 6),
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      tableName="wavePool",
    fileName=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/Profile_wavePool.txt"))
      "Boundary condition: Profil of wave pool"
      annotation (Placement(transformation(extent={{-64,-58},{-48,-42}})));
    AixLib.Fluid.Pools.BaseClasses.AHUcontrol aHUcontrol(
    phi_sup_min=0,
    T_desired=305.15,
    y_Max=100)
    annotation (Placement(transformation(extent={{-54,-4},{-34,16}})));
  equation
    connect(weaDat.weaBus, multizone.weaBus) annotation (Line(
        points={{-62,40},{-32,40},{-32,6},{34,6}},
        color={255,204,51},
        thickness=0.5));

    connect(tableInternalGains.y, multizone.intGains)
      annotation (Line(points={{55.2,-34},{48,-34},{48,-9}}, color={0,0,127}));

    connect(tableTSet.y, multizone.TSetHeat) annotation (Line(points={{55.2,-60},
            {36.8,-60},{36.8,-9}}, color={0,0,127}));

    connect(tableTSetCool.y, multizone.TSetCool) annotation (Line(points={{57.2,
            -84},{34.6,-84},{34.6,-9}},
                                   color={0,0,127}));

    connect(multizone.openingHours, tableOpeningHours.y) annotation (Line(points={
            {45.6,-9},{-0.2,-9},{-0.2,-24},{-47.2,-24}}, color={0,0,127}));
    connect(tableWavePool.y, multizone.wavePool) annotation (Line(points={{-47.2,
            -50},{0,-50},{0,-9},{43.2,-9}}, color={0,0,127}));
  connect(aHUcontrol.AHUProfile, multizone.AHU) annotation (Line(points={{-33.6,
          6},{-4,6},{-4,2},{33,2}}, color={0,0,127}));
  connect(multizone.X_w[4], aHUcontrol.X_w) annotation (Line(points={{51,
          7.16667},{-1.5,7.16667},{-1.5,7.6},{-54.2,7.6}}, color={0,0,127}));
  connect(multizone.TAir[4], aHUcontrol.T_Air) annotation (Line(points={{51,
          5.125},{-80,5.125},{-80,0},{-74,0},{-74,4.4},{-54.2,4.4}}, color={0,0,
          127}));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This example illustrates the use of <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped\">AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped</a> as a swimming bath. </p>
</html>"));
  end MultizoneEquippedSwimmingBath;

  annotation (Documentation(info="<html><p>
  This packages contains examples for Reduced Order Model applications.
</p>
</html>"));
end Examples;
