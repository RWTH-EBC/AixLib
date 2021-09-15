within AixLib.ThermalZones.HighOrder.Examples.ASHREA140;
model CompareDynamicAndStaticSolarFrac_Case270 "Based on Case270 from validation package"
  extends Validation.ASHRAE140.Case220(absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs09,
                                       Room(
      outerWall_South(use_shortWaveRadIn=true, use_shortWaveRadOut=true),
      ceiling(use_shortWaveRadIn=true, use_shortWaveRadOut=false),
      outerWall_West(use_shortWaveRadIn=true),
      outerWall_North(use_shortWaveRadIn=true),
      outerWall_East(use_shortWaveRadIn=true),
      floor(use_shortWaveRadIn=true)));
  Modelica.Blocks.Sources.CombiTimeTable Solar_Radiation_dyn(
    tableOnFile=true,
    tableName="Table",
    columns={2,3},
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-46,164},{-26,184}})));
  Modelica.Blocks.Sources.CombiTimeTable Source_Weather_dyn(
    tableOnFile=true,
    tableName="Table",
    columns={4,5,6,7},
    fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/Weatherdata_ASHARE140.mat"))
    annotation (Placement(transformation(extent={{-46,194},{-26,214}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outsideTemp_dyn
    "ambient temperature"
    annotation (Placement(transformation(extent={{-2,205},{9,216}})));
  Rooms.ASHRAE140.SouthFacingWindows Room_dyn(
    energyDynamicsWalls=Modelica.Fluid.Types.Dynamics.FixedInitial,
    initDynamicsAir=Modelica.Fluid.Types.Dynamics.FixedInitial,
    redeclare model WindowModel = Components.WindowsDoors.Window_ASHRAE140,
    redeclare model CorrSolarGainWin =
        Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorG_ASHRAE140,
    solar_absorptance_OW=0.1,
    redeclare Components.Types.CoeffTableSouthWindow coeffTableSolDistrFractions,
    outerWall_South(
      use_shortWaveRadIn=true,
      use_shortWaveRadOut=true,
      solar_absorptance=0.1),
    ceiling(
      use_shortWaveRadIn=true,
      use_shortWaveRadOut=false,
      solar_absorptance=0.1),
    outerWall_West(use_shortWaveRadIn=true, solar_absorptance=0.1),
    outerWall_North(use_shortWaveRadIn=true, solar_absorptance=0.1),
    outerWall_East(use_shortWaveRadIn=true, solar_absorptance=0.1),
    floor(use_shortWaveRadIn=true))
    annotation (Placement(transformation(extent={{59,181},{101,222}})));
  Modelica.Blocks.Sources.Constant AirExchangeRate_dyn(k=0)
    annotation (Placement(transformation(extent={{28,114},{41,127}})));
  Modelica.Blocks.Sources.Constant Source_InternalGains_convective_dyn(k=0.4*0)
    annotation (Placement(transformation(extent={{-44,133},{-31,146}})));
  Modelica.Blocks.Sources.Constant Source_InternalGains_radiative_dyn(k=0.6*0)
    annotation (Placement(transformation(extent={{-44,106},{-32,118}})));
  Modelica.Blocks.Sources.Constant Source_TsetC_dyn(k=273.15 + 20.1)
    annotation (Placement(transformation(extent={{58,114},{71,127}})));
  Modelica.Blocks.Sources.Constant Source_TsetH_dyn(k=273.15 + 20)
    annotation (Placement(transformation(extent={{108,114},{95,127}})));
  Utilities.Sources.HeaterCooler.HeaterCoolerPI idealHeaterCooler_dyn(
    TN_heater=1,
    TN_cooler=1,
    h_heater=1e6,
    KR_heater=1000,
    l_cooler=-1e6,
    KR_cooler=1000,
    recOrSep=false)
    annotation (Placement(transformation(extent={{74,130},{94,150}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow Ground_dyn(Q_flow=0)
    "adiabatic boundary"
    annotation (Placement(transformation(extent={{-7,164},{13,184}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_convective_dyn
    annotation (Placement(transformation(extent={{-23,130},{-3,150}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    InternalGains_radiative_dyn
    annotation (Placement(transformation(extent={{-24,102},{-4,122}})));
equation
  connect(Source_Weather_dyn.y[1], outsideTemp_dyn.T) annotation (Line(points={{-25,204},{-12,204},{-12,210},{-8,210},{-8,
          210.5},{-3.1,210.5}}, color={0,0,127}));
  connect(Source_Weather_dyn.y[2], Room_dyn.WindSpeedPort)
    annotation (Line(points={{-25,204},{56.9,204},{56.9,207.65}}, color={0,0,127}));
  connect(Source_TsetC_dyn.y, idealHeaterCooler_dyn.setPointCool)
    annotation (Line(points={{71.65,120.5},{81.6,120.5},{81.6,132.8}}, color={0,0,127}));
  connect(Source_TsetH_dyn.y, idealHeaterCooler_dyn.setPointHeat)
    annotation (Line(points={{94.35,120.5},{86.2,120.5},{86.2,132.8}}, color={0,0,127}));
  connect(Room_dyn.thermRoom, idealHeaterCooler_dyn.heatCoolRoom)
    annotation (Line(points={{77.06,201.5},{77.06,157},{106,157},{106,136},{93,136}}, color={191,0,0}));
  connect(Ground_dyn.port, Room_dyn.Therm_ground)
    annotation (Line(points={{13,174},{59,174},{59,181}},          color={191,0,0}));
  connect(Source_InternalGains_radiative_dyn.y, InternalGains_radiative_dyn.Q_flow)
    annotation (Line(points={{-31.4,112},{-24,112}}, color={0,0,127}));
  connect(InternalGains_convective_dyn.port, Room_dyn.thermRoom) annotation (Line(points={{-3,140},{18,140},{18,160},{76,
          160},{76,201.5},{77.06,201.5}}, color={191,0,0}));
  connect(InternalGains_radiative_dyn.port, Room_dyn.starRoom) annotation (Line(points={{-4,112},{18,112},{18,158},{92,158},
          {92,180},{83.36,180},{83.36,201.5}}, color={191,0,0}));
  connect(outsideTemp_dyn.port, Room_dyn.thermOutside)
    annotation (Line(points={{9,210.5},{31,210.5},{31,221.59},{59,221.59}}, color={191,0,0}));
  connect(Room_dyn.AirExchangePort, AirExchangeRate_dyn.y) annotation (Line(points={{56.9,215.748},{52,215.748},{52,216},{46,216},{46,120.5},{41.65,120.5}},
                                              color={0,0,127}));
  connect(Source_InternalGains_convective_dyn.y, InternalGains_convective_dyn.Q_flow)
    annotation (Line(points={{-30.35,139.5},{-26.175,139.5},{-26.175,140},{-23,140}}, color={0,0,127}));
  connect(radOnTiltedSurf_Perez.OutTotalRadTilted, Room_dyn.SolarRadiationPort) annotation (Line(points={{-75.4,60.6},{-54,60.6},{-54,222},{22,222},{22,212},{56.9,212},{56.9,213.8}},
                                                                           color={255,128,0}));
  annotation (experiment(StopTime=86400, Tolerance=1e-06),
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/ThermalZones/HighOrder/Examples/ASHREA140/CompareDynamicAndStaticSolarFrac_Case270.mos"
        "Simulate and plot"),
    Diagram(coordinateSystem(extent={{-160,-100},{120,240}}), graphics={
        Rectangle(
          extent={{-150,238},{114,94}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-141,234},{-70,168}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Dynamic calculation 
of short wave radiation 
in room model")}),                             Icon(coordinateSystem(extent={{-160,-100},{120,240}})));
end CompareDynamicAndStaticSolarFrac_Case270;
