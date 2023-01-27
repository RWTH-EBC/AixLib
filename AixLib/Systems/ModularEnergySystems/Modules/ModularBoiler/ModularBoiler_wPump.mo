within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler_wPump
   "Modular Boiler Model - With pump - Simple PLR regulation"
  extends BaseClasses.Boiler_base;

  Control.Control_wPump control_wPump(
    final dTWaterNom=dTWaterNom,
    final QNom=QNom,
    final THotMax=TFlowMax,
    final PLRMin=PLRMin)
    annotation (Placement(transformation(extent={{-28,48},{26,80}})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

equation

  connect(control_wPump.TCold, senTRet.T) annotation (Line(points={{-28,57.1429},
          {-60,57.1429},{-60,11}}, color={0,0,127}));
  connect(heatGeneratorNoControl.TVolume, control_wPump.THot_Boiler)
    annotation (Line(points={{0,-11},{0,-20},{-50,-20},{-50,52.5714},{-28,
          52.5714}},
        color={0,0,127}));
  connect(senTFlow.T, control_wPump.THot) annotation (Line(points={{60,11},{60,
          20},{-40,20},{-40,48},{-28,48}}, color={0,0,127}));
  connect(control_wPump.y, pump.y) annotation (Line(points={{-11.8,48},{-12,48},
          {-12,40},{-36,40},{-36,12}}, color={0,0,127}));
  connect(control_wPump.PLR, heatGeneratorNoControl.PLR)
    annotation (Line(
        points={{-6.4,48},{-6.4,34},{-20,34},{-20,5.4},{-12,5.4}}, color={0,0,127}));
  connect(control_wPump.dTWater, heatGeneratorNoControl.dTWater)
    annotation (
      Line(points={{-1,48},{-1,28},{-16,28},{-16,9},{-12,9}}, color={0,0,127}));
  connect(boilerControlBus.DeltaTWater, control_wPump.dTwater_in)
    annotation (
      Line(
      points={{0.05,98.05},{-60,98.05},{-60,70.8571},{-28,70.8571}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLR, control_wPump.PLR_in)
    annotation (Line(
      points={{0.05,98.05},{-60,98.05},{-60,75.4286},{-28,75.4286}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(port_a, senTRet.port_a)
    annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularBoiler_wPump;
