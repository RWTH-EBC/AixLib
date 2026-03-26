within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle;
model UHPM "unified heat pump model - refrigerant cyclePartial model to allow selection of only heat pump optionsRefrigerant cycle model of a heat pump"

  extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.PartialRefrigerantCycle;



  BaseClasses.UHPM.offdesignparameter offdesignparameter
    annotation (Placement(transformation(extent={{-42,60},{-22,80}})));
  BaseClasses.UHPM.design design
    annotation (Placement(transformation(extent={{42,56},{82,88}})));
  Modelica.Blocks.Math.Product proPEleParLoa
    "electric power respecting part load" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={2,0})));
  Modelica.Blocks.Math.Product proPEleParLoa1
    "electric power respecting part load" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-38,-24})));
equation
  connect(design.PelFullLoadSetPoint, proPEleParLoa.u2) annotation (Line(points
        ={{84.4,69.2},{102,69.2},{102,30},{8,30},{8,12}}, color={0,0,127}));
  connect(sigBus.yel, proPEleParLoa.u1) annotation (Line(
      points={{1,120},{1,80},{-4,80},{-4,12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TEvaInMea, offdesignparameter.tSource) annotation (Line(
      points={{1,120},{1,96},{-94,96},{-94,79},{-44,79}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConInMea, offdesignparameter.tConIn) annotation (Line(
      points={{1,120},{-106,120},{-106,67},{-44,67}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConOutMea, offdesignparameter.tConOut) annotation (Line(
      points={{1,120},{1,104},{-100,104},{-100,61},{-44,61}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus, design.sigBus) annotation (Line(
      points={{1,120},{46,120},{46,126},{92,126},{92,72},{82.1,72}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(proPEleParLoa.y, PEle)
    annotation (Line(points={{2,-11},{2,-130},{0,-130}}, color={0,0,127}));
  connect(offdesignparameter.COP, proPEleParLoa1.u1) annotation (Line(points={{
          -20.8,70},{-16,70},{-16,16},{-44,16},{-44,-12}}, color={0,0,127}));
  connect(proPEleParLoa.y, proPEleParLoa1.u2) annotation (Line(points={{2,-11},
          {2,-20},{-22,-20},{-22,-2},{-32,-2},{-32,-12}}, color={0,0,127}));
  connect(proPEleParLoa1.y, proRedQEva.u2) annotation (Line(points={{-38,-35},{
          -38,-42},{-24,-42},{-24,-78}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end UHPM;
