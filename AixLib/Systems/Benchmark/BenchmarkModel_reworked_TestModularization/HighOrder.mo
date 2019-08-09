within AixLib.Systems.Benchmark.BenchmarkModel_reworked_TestModularization;
model HighOrder "Test of high order modeling"
  extends Modelica.Icons.Example;
  AixLib.ThermalZones.HighOrder.Rooms.ASHRAE140.SouthFacingWindows
    southFacingWindows[5](
    each TypOW=DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    each Win=DataBase.WindowsDoors.Simple.WindowSimple_EnEV2009(),
    each TypCE=DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    each TypFL=DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML(),
    Room_Length={30,30,5,5,30},
    Room_Height={3,3,3,3,3},
    Room_Width={20,30,10,20,50},
    Win_Area={80,180,20,40,200},
    each solar_absorptance_OW=0.48,
    each eps_out=25)
    annotation (Placement(transformation(extent={{-21,-23},{33,23}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[5] HeatFlowGround(Q_flow={-3867,
        -4576,-480,-897,-7557}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-4,-50})));
  Modelica.Blocks.Sources.Constant[5] Windspeed( k=2.2)
    annotation (Placement(transformation(extent={{-92,10},{-72,30}})));
  Modelica.Blocks.Sources.Constant[5] AirExRate( k=0.15)
    annotation (Placement(transformation(extent={{-90,-34},{-70,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[5] HeatFlowAmbient(Q_flow={-7634,
        -12285,-1292,-2584,-18161}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-46,58})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[5] HeatFlowRoom(Q_flow={42894,
        14474,3842,1473,20512}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={14,58})));
  Utilities.Sources.PrescribedSolarRad prescribedSolarRad(n=1)
    annotation (Placement(transformation(extent={{-62,-76},{-42,-56}})));
  Modelica.Blocks.Sources.Constant[5] AirExRate1(k=0.15)
    annotation (Placement(transformation(extent={{-84,-84},{-64,-64}})));
equation
  connect(HeatFlowGround[5].port, southFacingWindows[5].Therm_ground) annotation (
      Line(points={{-4,-40},{-4,-22.08},{-2.64,-22.08}}, color={191,0,0}));
  connect(Windspeed[5].y, southFacingWindows[5].WindSpeedPort) annotation (Line(
        points={{-71,20},{-46,20},{-46,6.9},{-23.7,6.9}}, color={0,0,127}));
  connect(AirExRate[5].y, southFacingWindows[5].AER) annotation (Line(points={{-69,
          -24},{-48,-24},{-48,-11.5},{-23.7,-11.5}}, color={0,0,127}));
  connect(HeatFlowAmbient[5].port, southFacingWindows[5].Therm_outside)
    annotation (Line(points={{-46,48},{-22,48},{-22,22.31},{-22.35,22.31}},
        color={191,0,0}));
  connect(southFacingWindows[5].thermRoom, HeatFlowRoom[5].port) annotation (
      Line(points={{-1.83,5.29},{-1.83,48.645},{14,48.645},{14,48}}, color={191,
          0,0}));
  connect(prescribedSolarRad.solarRad_out[1], southFacingWindows[5].SolarRadiationPort[
    5]) annotation (Line(points={{-43,-66},{-32,-66},{-32,15.64},{-23.7,15.64}},
        color={255,128,0}));
end HighOrder;
