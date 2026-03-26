within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM;
model Operation

  extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.PartialBase;
  extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.ParamsUHPM;

  OffDesignPel offDesignPel(
    TConOutNom=TConOutNom,
    TEvaInNom=TEvaInNom,
    QConNom=QConNom,
    DeltaTCon=DeltaTCon,
    refrigerant=refrigerant)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  OffDesignCOP offDesignCOP(
    TConOutNom=TConOutNom,
    TEvaInNom=TEvaInNom,
    QConNom=QConNom,
    DeltaTCon=DeltaTCon,
    refrigerant=refrigerant)
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  OffDesignQEva offDesignQEva(
    TConOutNom=TConOutNom,
    TEvaInNom=TEvaInNom,
    QConNom=QConNom,
    DeltaTCon=DeltaTCon,
    refrigerant=refrigerant)
    annotation (Placement(transformation(extent={{-2,40},{18,60}})));
  Design design(
    TConOutNom=TConOutNom,
    TEvaInNom=TEvaInNom,
    QConNom=QConNom,
    DeltaTCon=DeltaTCon,
    refrigerant=refrigerant)
    annotation (Placement(transformation(extent={{-66,10},{-46,30}})));
  AixLib.Fluid.HeatPumps.ModularReversible.BaseClasses.RefrigerantMachineControlBus        sigBus
    "Bus-connector used in a heat pump" annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={0,100}), iconTransformation(extent={{-14,-14},{14,14}},
          origin={0,100})));
  Modelica.Blocks.Interfaces.RealOutput MaxPEle(final unit="W")
    "Full load electrical oower" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-10})));
  Modelica.Blocks.Interfaces.RealOutput COP(final unit="W")
    "coefficient of performance" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-80})));
equation

  connect(offDesignPel.PelFulLoaOffDes, offDesignQEva.PelFulLoaDes)
    annotation (Line(points={{21,-10},{40,-10},{40,28},{-14,28},{-14,53.8},{-4,53.8}},
                 color={0,0,127}));
  connect(design.PelDes, offDesignPel.PelDes) annotation (Line(points={{-45.0909,
          20},{-16,20},{-16,-17},{-2,-17}}, color={0,0,127}));
  connect(design.ComDes, offDesignPel.ComDes) annotation (Line(points={{-45.0909,
          15.4},{-28,15.4},{-28,-14},{-2,-14},{-2,-13}}, color={0,0,127}));
  connect(sigBus.TEvaInMea, offDesignCOP.tSource) annotation (Line(
      points={{0,100},{0,74},{-84,74},{-84,-74},{-2,-74}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConInMea, offDesignCOP.tConIn) annotation (Line(
      points={{0,100},{0,76},{-92,76},{-92,-80},{-2,-80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConOutMea, offDesignCOP.tConOut) annotation (Line(
      points={{0,100},{2,100},{2,76},{-100,76},{-100,-86},{-2,-86}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConOutMea, offDesignPel.tConOut) annotation (Line(
      points={{0,100},{2,100},{2,78},{-100,78},{-100,-7},{-2,-7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sigBus.TConOutMea, offDesignQEva.tConOut) annotation (Line(
      points={{0,100},{0,90},{-100,90},{-100,43},{-4,43}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(offDesignPel.PelFulLoaOffDes, MaxPEle)
    annotation (Line(points={{21,-10},{110,-10},{110,-10}}, color={0,0,127}));
  connect(design.QEvaDes, offDesignQEva.QEvaFulLoaDes) annotation (Line(points={
          {-45.0909,27.2},{-22,27.2},{-22,58},{-4,58}}, color={0,0,127}));
  connect(offDesignQEva.QEvaOffDes, sigBus.QEvaMax) annotation (Line(points={{19,
          50},{60,50},{60,100},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(offDesignCOP.OffDesCOP, COP) annotation (Line(points={{21,-79.6},{72,-79.6},
          {72,-80},{110,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><br>Unified Heat Pump Model focussing on simple yet robust parameterization and simulation.</p>
<p>Further documentation and information available:</p>
<p><i><a name=\"selectable\">Z</a>uschlag, Moritz and Jansen, David and Frank, Benjamin and Schuster, Sonja and Klingebiel, Jonas and M&uuml;ller, Dirk, How refrigerant cycle modeling shapes the techno-economic analysis of centralized vs. decentralized heat supply systems for city districts (March 20, 2026).</i></p>
<p><i>Available at SSRN: <a href=\"https://ssrn.com/abstract=6448458\">https://ssrn.com/abstract=6448458</a> or <a href=\"https://dx.doi.org/10.2139/ssrn.6448458\">http://dx.doi.org/10.2139/ssrn.6448458 </a></i></p>
</html>"));

end Operation;
