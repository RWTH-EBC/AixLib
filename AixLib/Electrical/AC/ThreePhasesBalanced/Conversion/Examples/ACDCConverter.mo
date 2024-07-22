within AixLib.Electrical.AC.ThreePhasesBalanced.Conversion.Examples;
model ACDCConverter
  "This example illustrates how to use the AC/DC converter model"
  extends Modelica.Icons.Example;
  AixLib.Electrical.DC.Loads.Resistor res(
    R=1,
    V_nominal=120,
    i(each start=0))
    "Resistive load" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={50,10})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Conversion.ACDCConverter conversion(
    eta=0.9,
    ground_AC=false,
    ground_DC=true,
    conversionFactor=120/480) "AC/DC transformer"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Sources.FixedVoltage sou(
    definiteReference=true,
    f=60,
    V=480) "Voltage source"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-62,10})));
  AixLib.Electrical.DC.Loads.Conductor load(
    mode=AixLib.Electrical.Types.Load.VariableZ_P_input,
    V_nominal=120) "Variable resistive load"
    annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={50,-10})));
  Modelica.Blocks.Sources.Ramp pow(
    duration=0.5,
    startTime=0.2,
    offset=-200,
    height=5200) "Variable load profile"
    annotation (Placement(transformation(extent={{90,-20},{70,0}})));
equation
  connect(sou.terminal, conversion.terminal_n) annotation (Line(
      points={{-52,10},{-10,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(conversion.terminal_p, res.terminal) annotation (Line(
      points={{10,10},{40,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(conversion.terminal_p, load.terminal) annotation (Line(
      points={{10,10},{30,10},{30,-10},{40,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pow.y, load.Pow) annotation (Line(
      points={{69,-10},{60,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation ( experiment(StopTime=1.0, Tolerance=1e-6),
Documentation(info="<html>
<p>
This example illustrates the use of a model that converts AC voltage to DC voltage.
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
          "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/ThreePhasesBalanced/Conversion/Examples/ACDCConverter.mos"
        "Simulate and plot"));
end ACDCConverter;
