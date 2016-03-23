within AixLib.Building.LowOrder.Examples;
model MultizoneExample "This is an example for a multizone office building"
  import AixLib;
  import AixLib;
  extends Modelica.Icons.Example;

  Multizone.MultizoneEquipped multizoneEquipped(
      redeclare AixLib.Building.LowOrder.ThermalZone.ThermalZone zone(
        redeclare
        AixLib.Building.LowOrder.BaseClasses.BuildingPhysics.BuildingPhysicsVDI
        buildingPhysics(redeclare
          AixLib.Building.Components.WindowsDoors.BaseClasses.CorrectionSolarGain.NoCorG
          corG)),
    redeclare AixLib.HVAC.AirHandlingUnit.AHU AirHandlingUnit "with AHU",
    buildingParam=
        AixLib.DataBase.Buildings.OfficePassiveHouse.OfficePassiveHouse())
    annotation (Placement(transformation(extent={{-26,-14},{28,36}})));
  Components.Weather.Weather weather(
    Outopt=1,
    Air_temp=true,
    Mass_frac=true,
    Sky_rad=true,
    Ter_rad=true,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/WeatherData/TRY2010_12_Jahr_Modelica-Library.txt"))
    annotation (Placement(transformation(extent={{-24,68},{6,88}})));
  Modelica.Blocks.Sources.CombiTimeTable tableTSet(
    tableOnFile=true,
    tableName="Tset",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    columns=2:7,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/Tset_6Zone.txt"))
    annotation (Placement(transformation(extent={{-92,8},{-72,28}})));
  Modelica.Blocks.Sources.CombiTimeTable tableAHU(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="AHU",
    columns=2:5,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/AHU_Input_6Zone_SIA_4Columns.txt"))
    annotation (Placement(transformation(extent={{66,-50},{46,-30}})));
  Modelica.Blocks.Sources.CombiTimeTable tableInternalGains(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableName="Internals",
    columns=2:19,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/LowOrder_ExampleData/Internals_Input_6Zone_SIA.txt"))
    annotation (Placement(transformation(extent={{84,18},{64,38}})));
  Modelica.Blocks.Sources.Constant const[6](each k=0)
    annotation (Placement(transformation(extent={{-92,-22},{-72,-2}})));
equation
  connect(weather.SolarRadiation_OrientedSurfaces, multizoneEquipped.radIn)
    annotation (Line(points={{-16.8,67},{-16.8,50.5},{-15.74,50.5},{-15.74,33.5}},
        color={255,128,0}));
  connect(weather.WeatherDataVector, multizoneEquipped.weather) annotation (
     Line(points={{-9.1,67},{-9.1,52},{-3.32,52},{-3.32,34.5}}, color={0,0,127}));
  connect(tableTSet.y, multizoneEquipped.TSetHeater) annotation (Line(
        points={{-71,18},{-48,18},{-48,12.5},{-24.38,12.5}}, color={0,0,127}));
  connect(tableAHU.y, multizoneEquipped.AHU) annotation (Line(points={{45,-40},
          {12.61,-40},{12.61,-12.25}}, color={0,0,127}));
  connect(tableInternalGains.y, multizoneEquipped.internalGains)
    annotation (Line(points={{63,28},{46,28},{46,27.25},{26.11,27.25}},
        color={0,0,127}));
  connect(const.y, multizoneEquipped.TSetCooler) annotation (Line(points={{-71,
          -12},{-66,-12},{-66,-14},{-48,-14},{-48,5.5},{-24.38,5.5}}, color=
         {0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), experiment(StopTime=3.1536e+007, Interval=3600));
end MultizoneExample;
