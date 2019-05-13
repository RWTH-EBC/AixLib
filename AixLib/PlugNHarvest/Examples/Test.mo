within AixLib.PlugNHarvest.Examples;
model Test
  extends Modelica.Icons.Example;
  Aggregation.Room_EnergySyst room_EnergySyst(
    room_length=parameters.room_length,
    room_width=parameters.room_width,
    room_height=parameters.room_height,
    wallType_OW1=parameters.wallType_OW1,
    wallType_IW1=parameters.wallType_IW1,
    wallType_IW2=parameters.wallType_IW2,
    wallType_IW3=parameters.wallType_IW3,
    wallType_CE=parameters.wallType_CE,
    wallType_FL=parameters.wallType_FL,
    windowarea_OW1=parameters.windowarea_OW1,
    Type_Win=parameters.Type_Win,
    withSmartFacade=parameters.withSmartFacade,
    withMechVent=parameters.withMechVent,
    withPV=parameters.withPV,
    withSolAirHeat=parameters.withSolAirHeat,
    NrPVpanels=parameters.NrPVpanels,
    dataPV=parameters.dataPV,
    PelPV_max=parameters.PelPV_max,
    heatLoadForActivity=parameters.heatLoadForActivity,
    occupationDensity=parameters.occupationDensity,
    spPelSurface_lights=parameters.spPelSurface_lights,
    spPelSurface_elApp=parameters.spPelSurface_elApp,
    Pmax_heater=parameters.Pmax_heater,
    Tset_heater=parameters.Tset_heater,
    Tout_isHeatOn=parameters.Tout_isHeatOn,
    Tset_chiller=parameters.Tset_chiller,
    Pmax_chiller=parameters.Pmax_chiller,
    solar_absorptance_OW=parameters.solar_absorptance_OW,
    ModelConvOW=parameters.ModelConvOW,
    n50=parameters.n50,
    e=parameters.e,
    eps=parameters.eps,
    use_sunblind=parameters.use_sunblind,
    ratioSunblind=parameters.ratioSunblind,
    solIrrThreshold=parameters.solIrrThreshold,
    TOutAirLimit=parameters.TOutAirLimit,
    withHeatBridge=parameters.withHeatBridge,
    psiHor=parameters.psiHor,
    psiVer=parameters.psiVer,
    RatioConvectiveHeat_persons=parameters.RatioConvectiveHeat_persons,
    coeffThermal_lights=parameters.coeffThermal_lights,
    coeffRadThermal_lights=parameters.coeffRadThermal_lights,
    coeffThermal_elApp=parameters.coeffThermal_elApp,
    coeffRadThermal_elApp=parameters.coeffRadThermal_elApp,
    isEl_heater=parameters.isEl_heater,
    isEl_cooler=parameters.isEl_cooler,
    etaEl_heater=parameters.etaEl_heater,
    etaEl_cooler=parameters.etaEl_cooler,
    redeclare package AirModel = Media.Air,
    MassFlowSetPoint=parameters.MassFlowSetPoint,
    CoverArea=parameters.CoverArea,
    InnerCrossSection=parameters.InnerCrossSection,
    Perimeter=parameters.Perimeter,
    SAHLength1=parameters.SAHLength1,
    SAHLength2=parameters.SAHLength2,
    AbsorberHeatCapacity=parameters.AbsorberHeatCapacity,
    CoverTransmitance=parameters.CoverTransmitance,
    CoverConductance=parameters.CoverConductance)
    annotation (Placement(transformation(extent={{10,4},{66,58}})));
  AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.Weather weather(
    Wind_speed=true,
    Air_temp=true,
    Rel_hum=true,
    Wind_dir=true,
    Air_press=true,
    Mass_frac=false,
    fileName=parameters.weatherFileName,
    Latitude=parameters.Latitude,
    Longitude=parameters.Longitude)
    annotation (Placement(transformation(extent={{-100,28},{-48,62}})));
  Modelica.Blocks.Sources.CombiTimeTable schedule_occupants(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=false,
    table=parameters.schedulePersons.Profile)               "0...1"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.CombiTimeTable schedule_lights(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=false,
    table=parameters.scheduleLights.Profile)             "0...1"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.CombiTimeTable schedule_elAppliances(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=parameters.scheduleElAppliances.Profile,
    tableOnFile=false)                                         "0...1"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Components.Parameters parameters(
    isEl_heater = true,
    withMechVent=true,
    withPV=true,withSmartFacade=true,
    withSolAirHeat= false)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-38,38},{-18,58}})));
  Modelica.Blocks.Sources.CombiTimeTable schedule_ventilation(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=false,
    table=parameters.scheduleMechVent.Profile)                "0...1 in 1/h"
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  Modelica.Blocks.Sources.CombiTimeTable schedule_cooling(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=false,
    table=parameters.scheduleHVAC_cooling.Profile)        "0(off) or 1 (on)"
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Blocks.Sources.CombiTimeTable schedule_heating(
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    tableOnFile=false,
    table=parameters.scheduleHVAC_heating.Profile)        "0(off) or 1 (on)"
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{68,-56},{80,-44}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean1
    annotation (Placement(transformation(extent={{50,-76},{62,-64}})));
  Modelica.Blocks.Math.Gain gain(k=0.1)
    annotation (Placement(transformation(extent={{28,-94},{36,-86}})));
equation
  connect(weather.SolarRadiation_OrientedSurfaces[1], room_EnergySyst.solRadPort_Facade1)
    annotation (Line(points={{-87.52,26.3},{-87.52,20},{-18,20},{-18,54.76},{
          11.68,54.76}},color={255,128,0}));
  connect(schedule_occupants.y[1], room_EnergySyst.Schedule_lights) annotation (
     Line(points={{-39,-50},{-18,-50},{-18,27.22},{12.8,27.22}},
        color={0,0,127}));
  connect(room_EnergySyst.weaBus, weaBus) annotation (Line(
      points={{11.68,47.2},{-13.16,47.2},{-13.16,48},{-28,48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weather.WindSpeed, weaBus.winSpe) annotation (Line(points={{-46.2667,
          55.2},{-40.1334,55.2},{-40.1334,48},{-28,48}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weather.AirTemp, weaBus.TDryBul) annotation (Line(points={{-46.2667,
          50.1},{-44,50.1},{-44,50},{-40,50},{-40,48},{-28,48}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weather.WindDirection, weaBus.winDir) annotation (Line(points={{
          -46.2667,60.3},{-44,60.3},{-44,60},{-40,60},{-40,54},{-28,54},{-28,48}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weather.RelHumidity, weaBus.relHum) annotation (Line(points={{
          -46.2667,34.8},{-44,34.8},{-44,34},{-40,34},{-40,48},{-28,48},{-28,48}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weather.AirPressure, weaBus.pAtm) annotation (Line(points={{-46.2667,
          45},{-44,45},{-44,46},{-40,46},{-40,48},{-28,48}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(schedule_heating.y[1], realToBoolean.u)
    annotation (Line(points={{61,-50},{66.8,-50}}, color={0,0,127}));
  connect(realToBoolean.y, room_EnergySyst.isHeaterOn) annotation (Line(points=
          {{80.6,-50},{100,-50},{100,0},{36.32,0},{36.32,5.62}}, color={255,0,
          255}));
  connect(schedule_cooling.y[1], realToBoolean1.u)
    annotation (Line(points={{41,-70},{48.8,-70}}, color={0,0,127}));
  connect(realToBoolean1.y, room_EnergySyst.isChillerOn) annotation (Line(
        points={{62.6,-70},{100,-70},{100,0},{24,0},{24,5.08}}, color={255,0,
          255}));
  connect(schedule_lights.y[1], room_EnergySyst.Schedule_Occupants) annotation (
     Line(points={{-59,-70},{-18,-70},{-18,20.2},{12.8,20.2}}, color={0,0,127}));
  connect(schedule_elAppliances.y[1], room_EnergySyst.Schedule_elAppliances)
    annotation (Line(points={{-79,-90},{-18,-90},{-18,15.88},{12.8,15.88}},
        color={0,0,127}));
  connect(schedule_ventilation.y[1], gain.u)
    annotation (Line(points={{21,-90},{27.2,-90}}, color={0,0,127}));
  connect(gain.y, room_EnergySyst.Schedule_mechVent) annotation (Line(points={{
          36.4,-90},{100,-90},{100,0},{-18,0},{-18,33.7},{12.8,33.7}}, color={0,
          0,127}));
  annotation (experiment(StopTime=31536000, Interval=60),
                                                        Documentation(revisions=
         "<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>", info="<html>
<p>SImulation set up for a PlugNHarvest use case.</p>
</html>"));
end Test;
