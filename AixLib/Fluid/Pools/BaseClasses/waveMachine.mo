within AixLib.Fluid.Pools.BaseClasses;
model waveMachine "Calculate energy demands of a wave machine"

  parameter Modelica.SIunits.Length h_wave "Height of generated wave";
  parameter Modelica.SIunits.Length w_wave "Width of wave machine outlet/of generated wave";

  Modelica.Blocks.Math.RealToBoolean useWavePool(threshold=1)
    "If input = 1, then true, else no waves generated"
    annotation (Placement(transformation(extent={{-16,-8},{0,8}})));
  Modelica.Blocks.Tables.CombiTable1D tablePWave(
    y(unit="W/m"),
    tableOnFile=false,
    table=[0,0; 0.7,3500; 0.9,6000; 1.3,12000],
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
    "Estimate consumed power per width to generate wave of a certain heigth; "
    annotation (Placement(transformation(extent={{-38,36},{-18,56}})));
  Modelica.Blocks.Sources.RealExpression get_h_wave(y=h_wave)
    "Get height of generated wave"
    annotation (Placement(transformation(extent={{-82,36},{-62,56}})));
  Modelica.Blocks.Interfaces.RealInput wavePool "Input profil of wave machine"
    annotation (Placement(transformation(extent={{-136,-20},{-96,20}})));
  Modelica.Blocks.Interfaces.RealOutput PWaveMachine( final unit="W", final quantity="Power")
    "Power consumption of wave machine"
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Modelica.Blocks.Math.Gain multiply(k=w_wave) "Multply by width of wave"
    annotation (Placement(transformation(extent={{8,38},{24,54}})));
  Modelica.Blocks.Sources.Constant zero(k=0)
    "no output if wave machine is off"
    annotation (Placement(transformation(extent={{-14,-38},{0,-24}})));
  Modelica.Blocks.Logical.Switch switchWaveMachine
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(get_h_wave.y, tablePWave.u[1]) annotation (Line(points={{-61,46},{
          -40,46}},              color={0,0,127}));
  connect(multiply.u, tablePWave.y[1]) annotation (Line(points={{6.4,46},{-17,
          46}},               color={0,0,127}));
  connect(wavePool, useWavePool.u) annotation (Line(points={{-116,0},{-17.6,0}},
                           color={0,0,127}));
  connect(switchWaveMachine.y, PWaveMachine) annotation (Line(points={{81,0},{
          106,0}},                     color={0,0,127}));
  connect(useWavePool.y, switchWaveMachine.u2) annotation (Line(points={{0.8,0},
          {58,0}},                        color={255,0,255}));
  connect(multiply.y, switchWaveMachine.u1)
    annotation (Line(points={{24.8,46},{50,46},{50,8},{58,8}},
                                                             color={0,0,127}));
  connect(zero.y, switchWaveMachine.u3) annotation (Line(points={{0.7,-31},{
          52,-31},{52,-8},{58,-8}}, color={0,0,127}));
  connect(PWaveMachine, PWaveMachine) annotation (Line(
      points={{106,0},{101,0},{101,0},{106,0}},
      color={0,0,127},
      smooth=Smooth.Bezier));
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
