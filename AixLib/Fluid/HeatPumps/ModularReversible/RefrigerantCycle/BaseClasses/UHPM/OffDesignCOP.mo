within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM;
model OffDesignCOP

    extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.PartialBase;
    extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.ParamsUHPM;


  SDF.NDTable sDF_COP(
    final nin=4,
    final readFromFile=true,
    final filename=filename_COP,
    final dataset="/COP",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    "SDF-Table data for COP" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={80,4})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-34,60})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={46,4})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin5
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-84,-60})));
  Modelica.Blocks.Math.Add deltaTCon(k1=-1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-4,28})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-78,0})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=100, uMin=0)
    annotation (Placement(transformation(extent={{-58,-70},{-38,-50}})));
  Modelica.Blocks.Sources.RealExpression DesFre(y=50) "design frequency 50 Hz"
    annotation (Placement(transformation(extent={{-68,34},{-50,54}})));
  Modelica.Blocks.Interfaces.RealOutput OffDesCOP annotation (Placement(
        transformation(
        extent={{12,-12},{-12,12}},
        rotation=180,
        origin={110,4})));
  Modelica.Blocks.Interfaces.RealInput tConIn annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealInput tSource annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,60})));
  Modelica.Blocks.Interfaces.RealInput tConOut annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-60})));
equation
  connect(fromKelvin1.Celsius,multiplex4_2. u1[1]) annotation (Line(points={{-25.2,
          60},{28,60},{28,12},{34,12},{34,13}},    color={0,0,127}));
  connect(multiplex4_2.y,sDF_COP. u)
    annotation (Line(points={{57,4},{65.6,4}},      color={0,0,127}));
  connect(deltaTCon.y,multiplex4_2. u3[1])
    annotation (Line(points={{7,28},{12,28},{12,1},{34,1}},
                                                 color={0,0,127}));
  connect(fromKelvin4.Celsius,deltaTCon. u1) annotation (Line(points={{-67,0},
          {-42,0},{-42,34},{-16,34}},color={0,0,127}));
  connect(sDF_COP.y, OffDesCOP)
    annotation (Line(points={{93.2,4},{110,4}}, color={0,0,127}));
  connect(tConIn,fromKelvin4. Kelvin) annotation (Line(points={{-120,0},{-90,0}},
                            color={0,0,127}));
  connect(tConOut,fromKelvin5. Kelvin) annotation (Line(points={{-120,-60},{-96,
          -60}},                       color={0,0,127}));
  connect(limiter1.y,multiplex4_2. u4[1]) annotation (Line(points={{-37,-60},{
          -24,-60},{-24,-5},{34,-5}},
                                    color={0,0,127}));
  connect(fromKelvin5.Celsius,limiter1. u)
    annotation (Line(points={{-73,-60},{-60,-60}}, color={0,0,127}));
  connect(limiter1.y,deltaTCon. u2) annotation (Line(points={{-37,-60},{-24,-60},
          {-24,22},{-16,22}},                       color={0,0,127}));
  connect(tSource, fromKelvin1.Kelvin)
    annotation (Line(points={{-120,60},{-43.6,60}}, color={0,0,127}));
  connect(DesFre.y, multiplex4_2.u2[1]) annotation (Line(points={{-49.1,44},{20,
          44},{20,7},{34,7}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OffDesignCOP;
