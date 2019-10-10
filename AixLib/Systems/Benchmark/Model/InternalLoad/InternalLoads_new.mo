within AixLib.Systems.Benchmark.Model.InternalLoad;
model InternalLoads_new
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perRad
    "Radiative heat flow of persons"
    annotation (Placement(transformation(extent={{18,80},{38,100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow perCon
    "Convective heat flow of persons"
    annotation (Placement(transformation(extent={{18,-10},{38,10}})));
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
    annotation (Placement(transformation(extent={{-66,-8},{-50,8}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow macConv
    "Convective heat flow of machines"
    annotation (Placement(transformation(extent={{18,-100},{38,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a perConv_port
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a macConv_port
    annotation (Placement(transformation(extent={{94,-100},{114,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a perRad_port
    annotation (Placement(transformation(extent={{94,80},{114,100}})));
  InternalLoads_Water internalLoads_Water
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  BusSystems.Bus_measure bus_measure
    annotation (Placement(transformation(extent={{84,30},{124,70}})));
  InternalLoadsPower_new internalLoadsPower_new
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  BusSystems.InternalBus internalBus
    annotation (Placement(transformation(extent={{84,-70},{124,-30}})));
equation
  connect(intGai.y[1],perRad. Q_flow)
    annotation (Line(points={{-49.2,0},{-26,0},{-26,90},{18,90}},
    color={0,0,127}));
  connect(intGai.y[2],perCon. Q_flow)
    annotation (Line(points={{-49.2,0},{18,0}},             color={0,0,127}));
  connect(intGai.y[3],macConv. Q_flow)
    annotation (Line(points={{-49.2,0},{-26,0},{-26,-90},{18,-90}},
    color={0,0,127}));
  connect(macConv.port, macConv_port)
    annotation (Line(points={{38,-90},{104,-90}}, color={191,0,0}));
  connect(perCon.port, perConv_port)
    annotation (Line(points={{38,0},{104,0}}, color={191,0,0}));
  connect(perRad.port, perRad_port)
    annotation (Line(points={{38,90},{104,90}}, color={191,0,0}));
  connect(intGai.y[2], internalLoads_Water.u1[1]) annotation (Line(points={{
          -49.2,0},{-26,0},{-26,-51.8},{20,-51.8}}, color={0,0,127}));
  connect(internalLoadsPower_new.Power_Sum, bus_measure.InternalLoad_Power)
    annotation (Line(points={{40,51.2},{74,51.2},{74,50.1},{104.1,50.1}}, color
        ={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[1], internalBus.InternalLoads_MFlow_Openplanoffice)
    annotation (Line(points={{40,-50.8},{72,-50.8},{72,-49.9},{104.1,-49.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[2], internalBus.InternalLoads_MFlow_Conferenceroom)
    annotation (Line(points={{40,-50.4},{72,-50.4},{72,-49.9},{104.1,-49.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[3], internalBus.InternalLoads_MFlow_Multipersonoffice)
    annotation (Line(points={{40,-50},{72,-50},{72,-49.9},{104.1,-49.9}}, color
        ={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[4], internalBus.InternalLoads_MFlow_Canteen)
    annotation (Line(points={{40,-49.6},{76,-49.6},{76,-49.9},{104.1,-49.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(internalLoads_Water.WaterPerRoom[5], internalBus.InternalLoads_QFlow_Workshop)
    annotation (Line(points={{40,-49.2},{72,-49.2},{72,-49.9},{104.1,-49.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(intGai.y, internalLoadsPower_new.u1) annotation (Line(points={{-49.2,
          0},{-26,0},{-26,50},{20,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalLoads_new;
