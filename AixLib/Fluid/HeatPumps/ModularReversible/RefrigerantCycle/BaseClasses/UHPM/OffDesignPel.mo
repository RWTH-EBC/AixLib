within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM;
model OffDesignPel

    extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.PartialBase;
    extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.ParamsUHPM;

  Modelica.Blocks.Routing.Multiplex4 multiplex4_1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-22,82})));
  Modelica.Blocks.Math.Division offDesRat
    "off design ratio for electric power"
    annotation (Placement(transformation(extent={{54,20},{74,40}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{62,-28},{82,-8}})));
  Modelica.Blocks.Math.Log log
    annotation (Placement(transformation(extent={{-6,32},{14,52}})));
  SDF.NDTable SDF_PI(
    final nin=4,
    final readFromFile=true,
    final filename=filename_PI,
    final dataset="\PI",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
    "SDF-Table data for pressure ratio" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={40,82})));
  SDF.NDTable SDF_CompT(
    final nin=4,
    final readFromFile=true,
    final filename=filename_T_Comp,
    final dataset="\T_mean_comp",
    final dataUnit="K",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
    "SDF-Table data for mean compressor temperature" annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-34,10})));
  Modelica.Blocks.Math.Product product4
    annotation (Placement(transformation(extent={{24,26},{44,46}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
    annotation (Placement(transformation(extent={{-14,0},{6,20}})));
  Modelica.Blocks.Sources.RealExpression deltaTConDes(y=DeltaTCon)
    "design temperature difference" annotation (Placement(transformation(
        extent={{12,11},{-12,-11}},
        rotation=180,
        origin={-90,51})));
  Modelica.Blocks.Interfaces.RealOutput PelFulLoaOffDes(final unit="W",
      final displayUnit="kW")
    "full electric power at off design operating point" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Sources.RealExpression tSourceNom(y=TEvaInNom)
    "design heat source temperature"
    annotation (Placement(transformation(extent={{-116,80},{-90,104}})));
  Modelica.Blocks.Sources.RealExpression DesFre(y=50) "design frequency 50 Hz"
    annotation (Placement(transformation(extent={{-100,58},{-82,78}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-64,92})));
  Modelica.Blocks.Interfaces.RealInput tConOut annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,30})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,30})));
  Modelica.Blocks.Interfaces.RealInput PelDes annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-70})));
  Modelica.Blocks.Interfaces.RealInput ComDes
    "compressor mean design operating conditions" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-30})));
equation
  connect(SDF_PI.y, log.u) annotation (Line(points={{53.2,82},{84,82},{84,60},
          {-16,60},{-16,42},{-8,42}}, color={0,0,127}));
  connect(multiplex4_1.y, SDF_PI.u)
    annotation (Line(points={{-11,82},{25.6,82}}, color={0,0,127}));
  connect(product1.y, PelFulLoaOffDes) annotation (Line(points={{83,-18},{90,-18},
          {90,0},{110,0}}, color={0,0,127}));
  connect(log.y,product4. u1)
    annotation (Line(points={{15,42},{22,42}},   color={0,0,127}));
  connect(product4.y,offDesRat. u1) annotation (Line(points={{45,36},{52,36}},
                                                    color={0,0,127}));
  connect(multiplex4_1.y, SDF_CompT.u) annotation (Line(points={{-11,82},{0,82},
          {0,66},{-54,66},{-54,10},{-48.4,10}}, color={0,0,127}));
  connect(SDF_CompT.y, toKelvin1.Celsius)
    annotation (Line(points={{-20.8,10},{-16,10}}, color={0,0,127}));
  connect(toKelvin1.Kelvin,product4. u2) annotation (Line(points={{7,10},{16,10},
          {16,30},{22,30}},                         color={0,0,127}));
  connect(fromKelvin3.Celsius, multiplex4_1.u1[1]) annotation (Line(points={{-53,
          92},{-52,92},{-52,91},{-34,91}}, color={0,0,127}));
  connect(deltaTConDes.y, multiplex4_1.u3[1]) annotation (Line(points={{-76.8,
          51},{-74,51},{-74,79},{-34,79}}, color={0,0,127}));
  connect(DesFre.y, multiplex4_1.u2[1]) annotation (Line(points={{-81.1,68},{-78,
          68},{-78,85},{-34,85}}, color={0,0,127}));
  connect(tSourceNom.y, fromKelvin3.Kelvin)
    annotation (Line(points={{-88.7,92},{-76,92}}, color={0,0,127}));
  connect(tConOut, fromKelvin1.Kelvin)
    annotation (Line(points={{-120,30},{-92,30}}, color={0,0,127}));
  connect(fromKelvin1.Celsius, multiplex4_1.u4[1]) annotation (Line(points={{-69,
          30},{-68,30},{-68,73},{-34,73}}, color={0,0,127}));
  connect(offDesRat.y, product1.u1) annotation (Line(points={{75,30},{80,30},{
          80,10},{54,10},{54,-12},{60,-12}}, color={0,0,127}));
  connect(PelDes, product1.u2) annotation (Line(points={{-120,-70},{54,-70},{54,
          -24},{60,-24}}, color={0,0,127}));
  connect(ComDes, offDesRat.u2) annotation (Line(points={{-120,-30},{46,-30},{
          46,24},{52,24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-122,-174},{42,-184}},
          textColor={28,108,200},
          textString="Off-Design Full-Load & Evap-Power")}));
end OffDesignPel;
