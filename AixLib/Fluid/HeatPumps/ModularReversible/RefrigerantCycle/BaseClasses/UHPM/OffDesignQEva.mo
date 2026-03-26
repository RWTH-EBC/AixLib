within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM;
model OffDesignQEva

    extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.PartialBase;
    extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.ParamsUHPM;


  SDF.NDTable SDF_COP(
    final nin=4,
    final readFromFile=true,
    final filename=filename_COP,
    final dataset="\COP",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
    "SDF-Table data for COP" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={52,-42})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={18,-42})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-46,8},{-26,28}})));
  Modelica.Blocks.Math.Add add1(k1=-1)
    annotation (Placement(transformation(extent={{-2,22},{18,42}})));
  Modelica.Blocks.Sources.RealExpression tSourceNom(y=TEvaInNom)
    "design heat source temperature"
    annotation (Placement(transformation(extent={{-100,-32},{-74,-8}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-46,-20})));
  Modelica.Blocks.Sources.RealExpression DesFre(y=50) "design frequency 50 Hz"
    annotation (Placement(transformation(extent={{-100,-50},{-82,-28}})));
  Modelica.Blocks.Sources.RealExpression deltaTConDes(y=DeltaTCon)
    "design temperature difference" annotation (Placement(transformation(
        extent={{12,11},{-12,-11}},
        rotation=180,
        origin={-52,-53})));
  Modelica.Blocks.Interfaces.RealInput tConOut annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-70})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,-70})));
  Modelica.Blocks.Interfaces.RealInput PelFulLoaDes
    "full electric power at design operating point" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,38})));
  Modelica.Blocks.Interfaces.RealOutput QEvaOffDes(final unit="W", final
      displayUnit="kW") "full evaporator power at off design operating point"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{0,54},{20,74}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,40})));
  Modelica.Blocks.Interfaces.RealInput QEvaFulLoaDes
    "evaporator power at design operating point" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,80})));
equation
  connect(SDF_COP.y, product2.u2) annotation (Line(points={{65.2,-42},{74,-42},
          {74,0},{-76,0},{-76,12},{-48,12}}, color={0,0,127}));
  connect(product2.y,add1. u2)
    annotation (Line(points={{-25,18},{-14,18},{-14,26},{-4,26}},
                                                   color={0,0,127}));
  connect(tSourceNom.y, fromKelvin3.Kelvin)
    annotation (Line(points={{-72.7,-20},{-58,-20}}, color={0,0,127}));
  connect(fromKelvin3.Celsius, multiplex4_1.u1[1]) annotation (Line(points={{-35,
          -20},{-28,-20},{-28,-33},{6,-33}}, color={0,0,127}));
  connect(DesFre.y, multiplex4_1.u2[1])
    annotation (Line(points={{-81.1,-39},{6,-39}}, color={0,0,127}));
  connect(deltaTConDes.y, multiplex4_1.u3[1]) annotation (Line(points={{-38.8,
          -53},{-16,-53},{-16,-45},{6,-45}}, color={0,0,127}));
  connect(fromKelvin1.Celsius, multiplex4_1.u4[1]) annotation (Line(points={{-69,
          -70},{-12,-70},{-12,-51},{6,-51}}, color={0,0,127}));
  connect(tConOut, fromKelvin1.Kelvin)
    annotation (Line(points={{-120,-70},{-92,-70}}, color={0,0,127}));
  connect(multiplex4_1.y, SDF_COP.u)
    annotation (Line(points={{29,-42},{37.6,-42}}, color={0,0,127}));
  connect(PelFulLoaDes, product2.u1) annotation (Line(points={{-120,38},{-76,38},
          {-76,24},{-48,24}}, color={0,0,127}));
  connect(PelFulLoaDes, add1.u1)
    annotation (Line(points={{-120,38},{-4,38}}, color={0,0,127}));
  connect(greater.y, switch2.u2) annotation (Line(points={{21,64},{36,64},{36,
          40},{58,40}}, color={255,0,255}));
  connect(QEvaFulLoaDes, greater.u1) annotation (Line(points={{-120,80},{-88,80},
          {-88,64},{-2,64}}, color={0,0,127}));
  connect(QEvaFulLoaDes, switch2.u1) annotation (Line(points={{-120,80},{42,80},
          {42,48},{58,48}}, color={0,0,127}));
  connect(add1.y, greater.u2) annotation (Line(points={{19,32},{30,32},{30,50},
          {-32,50},{-32,56},{-2,56}}, color={0,0,127}));
  connect(add1.y, switch2.u3)
    annotation (Line(points={{19,32},{58,32}}, color={0,0,127}));
  connect(switch2.y, QEvaOffDes) annotation (Line(points={{81,40},{86,40},{86,
          0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OffDesignQEva;
