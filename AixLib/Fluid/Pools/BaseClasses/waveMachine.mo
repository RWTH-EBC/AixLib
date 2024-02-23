within AixLib.Fluid.Pools.BaseClasses;
model waveMachine "Calculate energy demands of a wave machine"

  parameter Modelica.Units.SI.Length heightWave "Height of generated wave";
  parameter Modelica.Units.SI.Length widthWave
    "Width of generated wave/ width of wave machineoutlet";
  parameter Modelica.Units.SI.Time timeWavePul_start
    "Start time of first wave cycle";
  parameter Modelica.Units.SI.Time periodeWavePul "Time of cycling period";
  parameter Real widthWavePul "Fraction of time of wave generation within cycling period";

  Modelica.Blocks.Math.RealToBoolean useWavePool(threshold=1)
    "If input = 1, then true, else no waves generated"
    annotation (Placement(transformation(extent={{-58,-8},{-42,8}})));
  Modelica.Blocks.Tables.CombiTable1Dv tablePWave(
    y(unit="W/m"),
    tableOnFile=false,
    table=[0,0; 0.7,3500; 0.9,6000; 1.3,12000],
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
    "Estimate consumed power per width to generate wave of a certain heigth; "
    annotation (Placement(transformation(extent={{-46,50},{-26,70}})));
  Modelica.Blocks.Sources.RealExpression get_heightWave(y=heightWave)
    "Get height of generated wave"
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Blocks.Interfaces.RealInput open "Input profil of wave machine"
    annotation (Placement(transformation(extent={{-136,-20},{-96,20}})));
  Modelica.Blocks.Interfaces.RealOutput PWaveMachine( final unit="W", final quantity="Power")
    "Power consumption of wave machine"
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Modelica.Blocks.Math.Gain multiply(k=widthWave) "Multply by width of wave"
    annotation (Placement(transformation(extent={{0,52},{16,68}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    "no output if wave machine is off"
    annotation (Placement(transformation(extent={{-14,-78},{0,-64}})));
  Modelica.Blocks.Logical.Switch switchWaveMachine
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Sources.BooleanPulse wavePoolCycle(
    width=widthWavePul,
    period=periodeWavePul,
    startTime=timeWavePul_start)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
equation
  connect(get_heightWave.y, tablePWave.u[1]) annotation (Line(points={{-69,60},{-48,
          60}},                  color={0,0,127}));
  connect(multiply.u, tablePWave.y[1]) annotation (Line(points={{-1.6,60},{-25,60}},
                              color={0,0,127}));
  connect(open, useWavePool.u)
    annotation (Line(points={{-116,0},{-59.6,0}}, color={0,0,127}));
  connect(switchWaveMachine.y, PWaveMachine) annotation (Line(points={{81,0},{
          106,0}},                     color={0,0,127}));
  connect(multiply.y, switchWaveMachine.u1)
    annotation (Line(points={{16.8,60},{42,60},{42,8},{58,8}},
                                                             color={0,0,127}));
  connect(zero.y, switchWaveMachine.u3) annotation (Line(points={{0.7,-71},{52,-71},
          {52,-8},{58,-8}},         color={0,0,127}));
  connect(PWaveMachine, PWaveMachine) annotation (Line(
      points={{106,0},{101,0},{101,0},{106,0}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  connect(useWavePool.y, and1.u1)
    annotation (Line(points={{-41.2,0},{-10,0}}, color={255,0,255}));
  connect(and1.y, switchWaveMachine.u2)
    annotation (Line(points={{13,0},{58,0}}, color={255,0,255}));
  connect(wavePoolCycle.y, and1.u2) annotation (Line(points={{-39,-40},{-24,-40},
          {-24,-8},{-10,-8}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Line(
          points={{-98,0},{-52,62},{-2,-24},{50,60},{100,-2}},
          color={28,108,200},
          smooth=Smooth.Bezier,
          thickness=1),
        Line(
          points={{-98,-18},{-52,44},{-2,-42},{50,42},{98,-20}},
          color={28,108,200},
          smooth=Smooth.Bezier,
          thickness=1),
        Line(
          points={{-98,-36},{-52,26},{-2,-60},{50,24},{96,-36}},
          color={28,108,200},
          smooth=Smooth.Bezier,
          thickness=1)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model to calculate the energy demand of a wavemachine. Based on values of:</p>
<ul>
<li>German Association for the Recreational and Medicinal Bath Industry (Deutsche Gesellschaft f&uuml;r das Badewesen DGfdB), April 2015 : Richtlinien f&uuml;r den B&auml;derbau</li>
<li>Chroistoph Saunus, 2005: Schwimmb&auml;der Planung - Ausf&uuml;hrung - Betrieb</li>
</ul>
</html>"));
end waveMachine;
