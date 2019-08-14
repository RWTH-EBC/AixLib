within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrderModel_MultipleRooms  "Multiple instances of high order room with input paramaters"
  extends Modelica.Icons.Example;
   ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows southFacingWindows[5](
    Room_Length={30,30,5,5,30},
    Room_Height={3,3,3,3,3},
    Room_Width={20,30,10,20,50},
    Win_Area={80,180,20,40,200},
    each use_sunblind=true,
    each ratioSunblind=0,
    each solIrrThreshold=1000,
    each solar_absorptance_OW=0.48,
    each eps_out=25,
    each TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    each TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    each TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    each Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    each TOutAirLimit=1273.15)
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Blocks.Sources.Constant constantWindSpeed [5](each k=2.2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-48,-34})));
  Modelica.Blocks.Sources.Constant constantAirExchangeRate [5](each k=0.15) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,-34})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowInternal [5]
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,18})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowToOutside[5](Q_flow={-7634,-12285,-1292,-2584,-18161})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,44})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughFloorPlate[5](Q_flow={-3867,-4576,-480,-897,-7557})
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,-12})));
  Modelica.Blocks.Sources.Sine InternalGains [5](
    amplitude={21000,7200,1900,700,10000},
    each freqHz=1/1200,
    offset={21000,7200,1900,700,10000}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={64,16})));
  Utilities.Sources.PrescribedSolarRad prescribedSolarRad [5](n=5)
    annotation (Placement(transformation(extent={{-60,24},{-40,44}})));
equation
  connect(constantWindSpeed.y, southFacingWindows.WindSpeedPort)
    annotation (Line(points={{-48,-23},{-48,1},{-11,1}}, color={0,0,127}));
  connect(constantAirExchangeRate.y, southFacingWindows.AER)
    annotation (Line(points={{-16,-23},{-16,-7},{-11,-7}}, color={0,0,127}));
  connect(fixedHeatFlowThroughFloorPlate.port, southFacingWindows.Therm_ground)
    annotation (Line(points={{20,-12},{20,-11.6},{-3.2,-11.6}}, color={191,0,0}));
  connect(fixedHeatFlowToOutside.port, southFacingWindows.Therm_outside)
    annotation (Line(points={{20,44},{-10.5,44},{-10.5,7.7}}, color={191,0,0}));
  connect(prescribedHeatFlowInternal.port, southFacingWindows.thermRoom)
    annotation (Line(points={{20,18},{-4,18},{-4,0.3},{-2.9,0.3}}, color={191,0,
          0}));
  connect(InternalGains.y, prescribedHeatFlowInternal.Q_flow) annotation (Line(
        points={{53,16},{48,16},{48,18},{40,18}}, color={0,0,127}));
  connect(prescribedSolarRad.solarRad_out, southFacingWindows.SolarRadiationPort)
    annotation (Line(points={{-41,34},{-26,34},{-26,4},{-11,4}}, color={255,128,
          0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighOrderModel_MultipleRooms;
