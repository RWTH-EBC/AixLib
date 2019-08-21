within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrderModel_OneRoom "Single instance of high order room with input paramaters"
   extends Modelica.Icons.Example;
  ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows southFacingWindows(
    Room_Length=30,
    Room_Height=3,
    Room_Width=20,
    Win_Area=80,
    Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    solar_absorptance_OW=0.48,
    eps_out=25,
    TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    use_sunblind=true,
    ratioSunblind=0,
    solIrrThreshold=1000,
    TOutAirLimit=1273.15)
    annotation (Placement(transformation(extent={{-10,-12},{10,8}})));
  Modelica.Blocks.Sources.Constant constantWindSpeed(k=2.2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-48,-34})));
  Modelica.Blocks.Sources.Constant constantAirExchangeRate(k=0.15) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,-34})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowInternal
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,18})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowToOutside(Q_flow=-7634)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,44})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlowThroughFloorPlate(Q_flow=-3867)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,-12})));
  Modelica.Blocks.Sources.Sine InternalGains(
    amplitude=21000,
    offset=21000,
    freqHz=1/3600)
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={64,16})));
  Utilities.Sources.PrescribedSolarRad prescribedSolarRad(n=5)
    annotation (Placement(transformation(extent={{-60,24},{-40,44}})));
  Modelica.Blocks.Sources.Constant const_I[5](each k=2.2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-84,70})));
  Modelica.Blocks.Sources.Constant const_I_dir[5](each k=2.2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-84,38})));
  Modelica.Blocks.Sources.Constant const_I_diff[5](each k=2.2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-84,8})));
  Modelica.Blocks.Sources.Constant const_I_gr[5](each k=2.2) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-82,-20})));
  Modelica.Blocks.Sources.Constant const_AngleOfIncidence[5](each k=2.2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-84,-52})));
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
  connect(const_I.y, prescribedSolarRad.I) annotation (Line(points={{-73,70},{-66,
          70},{-66,42.9},{-58.9,42.9}}, color={0,0,127}));
  connect(const_I_dir.y, prescribedSolarRad.I_dir) annotation (Line(points={{-73,
          38},{-66,38},{-66,39},{-59,39}}, color={0,0,127}));
  connect(const_I_diff.y, prescribedSolarRad.I_diff) annotation (Line(points={{-73,
          8},{-66,8},{-66,35},{-59,35}}, color={0,0,127}));
  connect(const_I_gr.y, prescribedSolarRad.I_gr) annotation (Line(points={{-71,-20},
          {-66,-20},{-66,30.9},{-58.9,30.9}}, color={0,0,127}));
  connect(const_AngleOfIncidence.y, prescribedSolarRad.AOI) annotation (Line(
        points={{-73,-52},{-66,-52},{-66,27},{-59,27}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighOrderModel_OneRoom;
