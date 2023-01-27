within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler_wPumpInternalCtrl
  "Modular Boiler Model - With pump - Simple PLR regulation"
  extends BaseClasses.Boiler_base;

  Control.Control_wPump internalCtrl(
    final dTWaterNom=dTWaterNom,
    final QNom=QNom,
    final THotMax=TFlowMax,
    final PLRMin=PLRMin)
    annotation (Placement(transformation(extent={{-48,42},{6,74}})));
  Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));

protected
  Interfaces.BoilerControlBus boilerControlBus1
    annotation (Placement(transformation(extent={{-1,81},{1,83}})));
equation

  connect(internalCtrl.TCold, senTRet.T) annotation (Line(points={{-48,51.1429},
          {-48,50},{-60,50},{-60,11}}, color={0,0,127}));
  connect(heatGeneratorNoControl.TVolume, internalCtrl.THot_Boiler) annotation (
     Line(points={{0,-11},{0,-12},{-18,-12},{-18,20},{-28,20},{-28,18},{-56,18},
          {-56,46.5714},{-48,46.5714}}, color={0,0,127}));
  connect(senTFlow.T, internalCtrl.THot) annotation (Line(points={{60,11},{60,
          18},{-38,18},{-38,34},{-54,34},{-54,42},{-48,42}}, color={0,0,127}));
  connect(internalCtrl.y, pump.y) annotation (Line(points={{-31.8,42},{-30,42},
          {-30,20},{-36,20},{-36,12}}, color={0,0,127}));
  connect(internalCtrl.PLR, heatGeneratorNoControl.PLR) annotation (Line(points=
         {{-26.4,42},{-26.4,14},{-20,14},{-20,5.4},{-12,5.4}}, color={0,0,127}));
  connect(internalCtrl.dTWater, heatGeneratorNoControl.dTWater) annotation (
      Line(points={{-21,42},{-21,12},{-16,12},{-16,14},{-12,14},{-12,9}}, color=
         {0,0,127}));
  connect(boilerControlBus.DeltaTWater, internalCtrl.dTwater_in) annotation (
      Line(
      points={{0.05,98.05},{0.05,76},{-4,76},{-4,78},{-56,78},{-56,64.8571},{
          -48,64.8571}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(boilerControlBus.PLR, internalCtrl.PLR_in) annotation (Line(
      points={{0.05,98.05},{0.05,76},{-54,76},{-54,69.4286},{-48,69.4286}},
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
end ModularBoiler_wPumpInternalCtrl;
