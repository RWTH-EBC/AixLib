within AixLib.Fluid.Examples.DistrictHeating.Examples;
model SolarDistrictHeating "Example that illustrates use of solar district heating model"

    replaceable package Medium = AixLib.Media.Water;
    extends Modelica.Icons.Example;

  AixLib.Fluid.Examples.DistrictHeating.SolarDistrictHeating solarDistrictHeating
    annotation (Placement(transformation(extent={{-18,4},{30,36}})));
  AixLib.Fluid.Examples.DistrictHeating.Controller.SolarDistrictHeatingController
    solarDistrictHeatingController
    annotation (Placement(transformation(extent={{-46,-46},{-8,-20}})));
  AixLib.Fluid.Sources.Boundary_pT Sink(          redeclare package Medium =
               Medium, nPorts=1)
                       annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={60,36})));
  AixLib.Fluid.Sources.Boundary_pT Source(
    redeclare package Medium = Medium,
    nPorts=1,
    T=303.15) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={60,2})));
  Modelica.Blocks.Sources.CombiTimeTable WeatherData(
    tableOnFile=true,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
    columns=2:3,
    tableName="WeatherData04150419",
    fileName=
        "N:/Forschung/EBC0155_PtJ_Exergiebasierte_regelung_rsa/Students/pma-fda/Masterarbeit/MonitoringData/WeatherData04150419/WeatherData04150419.mat")
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-66,9})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2 annotation (
      Placement(transformation(
        extent={{4,-4.5},{-4,4.5}},
        rotation=180,
        origin={-28,10.5})));
  Modelica.Blocks.Sources.Step     BuffStgSetpoint(
    startTime=43200,
    offset=50,
    height=10)
    annotation (Placement(transformation(extent={{-72,-28},{-60,-16}})));
  Modelica.Blocks.Sources.Constant flowTempCHP(k=273.15 + 80)
    annotation (Placement(transformation(extent={{-36,42},{-24,54}})));
  Modelica.Blocks.Sources.Constant PressureRise(k=50000) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={34,-10})));
equation
  connect(Source.ports[1], solarDistrictHeating.port_a) annotation (Line(points={{52,2},{
          44,2},{44,9.33333},{30.1674,9.33333}},         color={0,127,255}));
  connect(Sink.ports[1], solarDistrictHeating.port_b) annotation (Line(points={{52,36},
          {44,36},{44,28.8533},{30,28.8533}},        color={0,127,255}));
  connect(solarDistrictHeating.flowTempSolCir, solarDistrictHeatingController.FlowTempSol)
    annotation (Line(points={{-18.5581,31.9467},{-86,31.9467},{-86,-40.3125},{
          -44.9312,-40.3125}},
                      color={0,0,127}));
  connect(solarDistrictHeating.TopTempSeasStg, solarDistrictHeatingController.SeasStgTopTemp)
    annotation (Line(points={{-18.5581,29.3867},{-82,29.3867},{-82,-36.7375},{
          -44.9312,-36.7375}},
                      color={0,0,127}));
  connect(solarDistrictHeating.BottTempSeasStg, solarDistrictHeatingController.SeasStgBotTemp)
    annotation (Line(points={{-18.5581,26.72},{-78,26.72},{-78,-33.1625},{
          -44.9312,-33.1625}},
                      color={0,0,127}));
  connect(solarDistrictHeating.TopTempBuffStg, solarDistrictHeatingController.TopTempBuffStg)
    annotation (Line(points={{-18.5581,24.16},{-40.4188,24.16},{-40.4188,
          -20.975}},
        color={0,0,127}));
  connect(solarDistrictHeating.flowTempSDH, solarDistrictHeatingController.FlowTempSDH)
    annotation (Line(points={{-18.5581,21.4933},{-37.5688,21.4933},{-37.5688,
          -20.8937}},
        color={0,0,127}));
  connect(solarDistrictHeating.HPCondTemp, solarDistrictHeatingController.hpCondTemp)
    annotation (Line(points={{-18.5581,34.4},{-90,34.4},{-90,-43.5625},{
          -44.9312,-43.5625}},
                      color={0,0,127}));
  connect(solarDistrictHeatingController.MFSolCirPump, solarDistrictHeating.SolarCirPumpMF)
    annotation (Line(points={{-8.35625,-21.4625},{0.474419,-21.4625},{0.474419,
          4.8}},
        color={0,0,127}));
  connect(solarDistrictHeatingController.MFStgCirPump, solarDistrictHeating.SeasStgCirPumpMF)
    annotation (Line(points={{-8.35625,-24.3875},{-6,-24.3875},{-6,-16},{
          -9.46047,-16},{-9.46047,4.8}},
                                color={0,0,127}));
  connect(solarDistrictHeatingController.ValveOpDir, solarDistrictHeating.ValveOpDirSupp)
    annotation (Line(points={{-8.35625,-27.3125},{-2.87442,-27.3125},{-2.87442,
          4.8}},
        color={0,0,127}));
  connect(solarDistrictHeatingController.ValveOpIndir, solarDistrictHeating.ValveOpIndirSupp)
    annotation (Line(points={{-8.35625,-30.1563},{4,-30.1563},{4,-2},{-6.22326,
          -2},{-6.22326,4.8}},
                           color={0,0,127}));
  connect(solarDistrictHeatingController.EvaMF, solarDistrictHeating.HPevaMF)
    annotation (Line(points={{-8.35625,-33.1625},{16.6605,-33.1625},{16.6605,
          4.90667}},
        color={0,0,127}));
  connect(solarDistrictHeatingController.ConMF, solarDistrictHeating.HPcondMF)
    annotation (Line(points={{-8.35625,-36.0875},{13.4233,-36.0875},{13.4233,
          4.90667}},
        color={0,0,127}));
  connect(solarDistrictHeatingController.DirSuppMF, solarDistrictHeating.DirSuppMF)
    annotation (Line(points={{-8.35625,-39.0125},{10.1302,-39.0125},{10.1302,
          4.90667}},
        color={0,0,127}));
  connect(solarDistrictHeatingController.valOpBypass, solarDistrictHeating.ValveOpBypValve)
    annotation (Line(points={{-8.35625,-41.9375},{84,-41.9375},{84,52},{4.3814,
          52},{4.3814,35.6267}},
                             color={0,0,127}));
  connect(solarDistrictHeatingController.valOpAux, solarDistrictHeating.ValveOpAuxValve)
    annotation (Line(points={{-8.35625,-44.8625},{88,-44.8625},{88,56},{7.50698,
          56},{7.50698,35.6267}}, color={0,0,127}));
  connect(solarDistrictHeatingController.hpRPM, solarDistrictHeating.rpmHP)
    annotation (Line(points={{-25.6938,-45.5125},{-25.6938,-52},{94,-52},{94,62},
          {-0.195349,62},{-0.195349,35.6267}}, color={0,0,127}));
  connect(solarDistrictHeatingController.hpSignal, solarDistrictHeating.OnOffHP)
    annotation (Line(points={{-28.7813,-45.5125},{-28.7813,-56},{98,-56},{98,66},
          {-3.32093,66},{-3.32093,35.6267}}, color={255,0,255}));
  connect(WeatherData.y[2], solarDistrictHeating.Irradiation) annotation (Line(
        points={{-56.1,9},{-48,9},{-48,18.2933},{-17.7767,18.2933}}, color={0,0,
          127}));
  connect(WeatherData.y[1], toKelvin2.Celsius) annotation (Line(points={{-56.1,9},
          {-36,9},{-36,10.5},{-32.8,10.5}}, color={0,0,127}));
  connect(toKelvin2.Kelvin, solarDistrictHeating.Toutdoor) annotation (Line(
        points={{-23.6,10.5},{-20,10.5},{-20,16.16},{-17.7767,16.16}}, color={0,
          0,127}));
  connect(WeatherData.y[2], solarDistrictHeatingController.CurrIrrad)
    annotation (Line(points={{-56.1,9},{-52,9},{-52,-26.3375},{-44.9312,
          -26.3375}},
        color={0,0,127}));
  connect(WeatherData.y[1], solarDistrictHeatingController.AmbTemp) annotation (
     Line(points={{-56.1,9},{-52,9},{-52,-29.5875},{-44.9312,-29.5875}}, color={
          0,0,127}));
  connect(BuffStgSetpoint.y, solarDistrictHeatingController.setPointBuffStg)
    annotation (Line(points={{-59.4,-22},{-44.9312,-22},{-44.9312,-22.7625}},
        color={0,0,127}));
  connect(flowTempCHP.y, solarDistrictHeating.cHPflowTempSetpoint) annotation (
      Line(points={{-23.4,48},{17.0512,48},{17.0512,35.4667}}, color={0,0,127}));
  connect(PressureRise.y, solarDistrictHeating.NetworkPresRise) annotation (
      Line(points={{27.4,-10},{6.89302,-10},{6.89302,4.90667}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end SolarDistrictHeating;
