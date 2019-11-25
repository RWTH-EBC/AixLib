within AixLib.Systems.Benchmark.Model.InternalLoad;
model InternalLoads_new
  InternalLoads_Water internalLoads_Water
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(
    tableOnFile=true,
    tableName="final",
    timeScale=1,
    columns={2,3,4,5,6,7,8,9,10,11},
    final fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Building/Benchmark/InternalLoads/InternalLoads_v2.mat"))
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b PerCon[5]
    annotation (Placement(transformation(extent={{88,74},{108,94}})));
  BusSystems.InternalBus internalBus
    annotation (Placement(transformation(extent={{72,-40},{112,-80}})));
  BusSystems.Bus_measure measureBus
    annotation (Placement(transformation(extent={{76,-10},{116,-50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b PerRad[5]
    annotation (Placement(transformation(extent={{88,32},{108,52}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b MacCon[5]
    annotation (Placement(transformation(extent={{90,-2},{110,18}})));
  InternalLoads_Power_new internalLoads_Power_new
    annotation (Placement(transformation(extent={{-8,50},{12,70}})));
equation
  connect(internalLoads_Water.u1,combiTimeTable1. y) annotation (Line(points={{-10,-60},
          {-40,-60},{-40,0},{-59,0}},          color={0,0,127}));
  connect(internalLoads_Water.WaterPerRoom[1],internalBus. InternalLoads_MFlow_Openplanoffice)
    annotation (Line(points={{10,-60.8},{32,-60.8},{32,-60},{54.1,-60},{54.1,-60.1},
          {92.1,-60.1}}, color={0,0,127}));
  connect(internalLoads_Water.WaterPerRoom[2],internalBus. InternalLoads_MFlow_Conferenceroom)
    annotation (Line(points={{10,-60.4},{34,-60.4},{34,-60},{56.1,-60},{56.1,-60.1},
          {92.1,-60.1}}, color={0,0,127}));
  connect(internalLoads_Water.WaterPerRoom[3],internalBus. InternalLoads_MFlow_Multipersonoffice)
    annotation (Line(points={{10,-60},{56,-60},{56,-60.1},{92.1,-60.1}}, color=
          {0,0,127}));
  connect(internalLoads_Water.WaterPerRoom[4],internalBus. InternalLoads_MFlow_Canteen)
    annotation (Line(points={{10,-59.6},{36,-59.6},{36,-60},{60.1,-60},{60.1,-60.1},
          {92.1,-60.1}}, color={0,0,127}));
  connect(internalLoads_Water.WaterPerRoom[5],internalBus. InternalLoads_MFlow_Workshop)
    annotation (Line(points={{10,-59.2},{34,-59.2},{34,-60},{56.1,-60},{56.1,-60.1},
          {92.1,-60.1}}, color={0,0,127}));
  connect(combiTimeTable1.y, internalLoads_Power_new.u1) annotation (Line(
        points={{-59,0},{-40,0},{-40,60},{-8,60}}, color={0,0,127}));
  connect(internalLoads_Power_new.Machine_power[1], MacCon[1]) annotation (Line(
        points={{12.4,57.8},{54,57.8},{54,0},{100,0}}, color={191,0,0}));
  connect(internalLoads_Power_new.Machine_power[2], MacCon[2]) annotation (Line(
        points={{12.4,58.2},{54,58.2},{54,4},{100,4}}, color={191,0,0}));
  connect(internalLoads_Power_new.Machine_power[3], MacCon[3]) annotation (Line(
        points={{12.4,58.6},{54,58.6},{54,8},{100,8}}, color={191,0,0}));
  connect(internalLoads_Power_new.Machine_power[4], MacCon[4]) annotation (Line(
        points={{12.4,59},{54,59},{54,12},{100,12}}, color={191,0,0}));
  connect(internalLoads_Power_new.Machine_power[5], MacCon[5]) annotation (Line(
        points={{12.4,59.4},{54,59.4},{54,16},{100,16}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonRad[1], PerRad[1]) annotation (Line(
        points={{12.4,61.8},{74,61.8},{74,34},{98,34}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonRad[2], PerRad[2]) annotation (Line(
        points={{12.4,62.2},{74,62.2},{74,38},{98,38}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonRad[3], PerRad[3]) annotation (Line(
        points={{12.4,62.6},{74,62.6},{74,42},{98,42}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonRad[4], PerRad[4]) annotation (Line(
        points={{12.4,63},{74,63},{74,46},{98,46}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonRad[5], PerRad[5]) annotation (Line(
        points={{12.4,63.4},{74,63.4},{74,50},{98,50}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonCon[1], PerCon[1]) annotation (Line(
        points={{12.4,66.4},{74,66.4},{74,76},{98,76}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonCon[2], PerCon[2]) annotation (Line(
        points={{12.4,66.8},{74,66.8},{74,80},{98,80}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonCon[3], PerCon[3]) annotation (Line(
        points={{12.4,67.2},{74,67.2},{74,84},{98,84}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonCon[4], PerCon[4]) annotation (Line(
        points={{12.4,67.6},{74,67.6},{74,88},{98,88}}, color={191,0,0}));
  connect(internalLoads_Power_new.PersonCon[5], PerCon[5]) annotation (Line(
        points={{12.4,68},{74,68},{74,92},{98,92}}, color={191,0,0}));
  connect(internalLoads_Power_new.Power_Sum, measureBus.Sum_Power) annotation (
      Line(points={{12,53.8},{16,53.8},{16,54},{36,54},{36,-34},{96.1,-34},{
          96.1,-30.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalLoads_new;
