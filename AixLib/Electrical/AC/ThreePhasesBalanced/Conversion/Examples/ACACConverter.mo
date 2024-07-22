within AixLib.Electrical.AC.ThreePhasesBalanced.Conversion.Examples;
model ACACConverter
  "This example illustrates how to use the AC/AC converter model"
  extends Modelica.Icons.Example;

  AixLib.Electrical.AC.ThreePhasesBalanced.Conversion.ACACConverter
    conACAC(eta=0.9, conversionFactor=120/480) "ACAC transformer"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Sources.FixedVoltage sou(
    definiteReference=true,
    f=60,
    V=480) "Voltage source"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-60,10})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Loads.Inductive load(
    mode=AixLib.Electrical.Types.Load.VariableZ_P_input,
    V_nominal=120) "Load model"
    annotation (Placement(transformation(extent={{24,0},{44,20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=0.5,
    startTime=0.3,
    height=2000,
    offset=-1000) "Power consumed by the model"
    annotation (Placement(transformation(extent={{80,0},{60,20}})));
equation
  connect(sou.terminal, conACAC.terminal_n) annotation (Line(
      points={{-50,10},{-10,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(conACAC.terminal_p, load.terminal)     annotation (Line(
      points={{10,10},{24,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(ramp.y, load.Pow) annotation (Line(
      points={{59,10},{44,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation ( experiment(StopTime=1.0, Tolerance=1e-6),
Documentation(info="<html>
<p>
This example illustrates the use of a model that converts AC voltage to AC voltage.
The transformer model assumes a linear loss when transmitting the power.
</p>
</html>",
      revisions="<html>
<ul>
<li>
October 1, 2015, by Michael Wetter:<br/>
Removed assignment of <code>load.P_nominal</code> as it is
not required and leads to dublicate assignments.
</li>
<li>
August 5, 2014, by Marco Bonvini:<br/>
Revised model and documentation.
</li>
<li>
January 29, 2013, by Thierry S. Nouidui:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/ThreePhasesBalanced/Conversion/Examples/ACACConverter.mos"
        "Simulate and plot"));
end ACACConverter;
