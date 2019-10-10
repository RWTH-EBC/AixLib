within AixLib.Systems.Benchmark.Model.InternalLoad;
model InternalLoads_new
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{18,80},{38,100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{18,38},{38,58}})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    tableOnFile=false,
    table=[0,0,0,0; 3600,0,0,0; 7200,0,0,0; 10800,0,0,0; 14400,0,0,0; 18000,0,0,
        0; 21600,0,0,0; 25200,0,0,0; 25200,80,80,200; 28800,80,80,200; 32400,80,
        80,200; 36000,80,80,200; 39600,80,80,200; 43200,80,80,200; 46800,80,80,
        200; 50400,80,80,200; 54000,80,80,200; 57600,80,80,200; 61200,80,80,200;
        61200,0,0,0; 64800,0,0,0; 72000,0,0,0; 75600,0,0,0; 79200,0,0,0; 82800,
        0,0,0; 86400,0,0,0],
    tableName="final",
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Building/Benchmark/InternalLoads/InternalLoads_v2.mat"),
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic) "Table with profiles for persons (radiative and convective) and machines
    (convective)"
    annotation (Placement(transformation(extent={{-68,40},{-52,56}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{18,-2},{38,18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a perConv_port
    annotation (Placement(transformation(extent={{94,38},{114,58}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a macConv_port
    annotation (Placement(transformation(extent={{94,-2},{114,18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a perRad_port
    annotation (Placement(transformation(extent={{94,80},{114,100}})));
  InternalLoads_Water internalLoads_Water
    annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
  BusSystems.Bus_measure bus_measure
    annotation (Placement(transformation(extent={{86,-50},{126,-10}})));
  InternalLoadsPower_new internalLoadsPower_new
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  BusSystems.InternalBus internalBus
    annotation (Placement(transformation(extent={{86,-110},{126,-70}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    tableOnFile=true,
    tableName="final",
    timeScale=1,
    columns={2,3,4,5,6,7,8,9,10,11},
    final fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Building/Benchmark/InternalLoads/InternalLoads_v2.mat"))
    annotation (Placement(transformation(extent={{-72,-70},{-52,-50}})));
equation
  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{-51.2,48},{-26,48},{-26,90},{18,90}},
    color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{-51.2,48},{18,48}},           color={0,0,127}));
  connect(intGai.y[3],macConv. Q_flow)
    annotation (Line(points={{-51.2,48},{-26,48},{-26,8},{18,8}},
    color={0,0,127}));
  connect(macConv.port, macConv_port)
    annotation (Line(points={{38,8},{104,8}},     color={191,0,0}));
  connect(perCon.port, perConv_port)
    annotation (Line(points={{38,48},{104,48}},
                                              color={191,0,0}));
  connect(perRad.port, perRad_port)
    annotation (Line(points={{38,90},{104,90}}, color={191,0,0}));
  connect(internalLoadsPower_new.Power_Sum, bus_measure.InternalLoad_Power)
    annotation (Line(points={{20,-28.8},{74,-28.8},{74,-29.9},{106.1,-29.9}},
                                                                          color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[1], internalBus.InternalLoads_MFlow_Openplanoffice)
    annotation (Line(points={{20,-90.8},{72,-90.8},{72,-89.9},{106.1,-89.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[2], internalBus.InternalLoads_MFlow_Conferenceroom)
    annotation (Line(points={{20,-90.4},{72,-90.4},{72,-89.9},{106.1,-89.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[3], internalBus.InternalLoads_MFlow_Multipersonoffice)
    annotation (Line(points={{20,-90},{72,-90},{72,-89.9},{106.1,-89.9}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[4], internalBus.InternalLoads_MFlow_Canteen)
    annotation (Line(points={{20,-89.6},{76,-89.6},{76,-89.9},{106.1,-89.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[5], internalBus.InternalLoads_QFlow_Workshop)
    annotation (Line(points={{20,-89.2},{72,-89.2},{72,-89.9},{106.1,-89.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable1.y, internalLoadsPower_new.u1) annotation (Line(
        points={{-51,-60},{-26,-60},{-26,-30},{0,-30}},     color={0,0,127}));
  connect(combiTimeTable1.y, internalLoads_Water.u1) annotation (Line(
        points={{-51,-60},{-26,-60},{-26,-90},{0,-90}},     color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalLoads_new;
