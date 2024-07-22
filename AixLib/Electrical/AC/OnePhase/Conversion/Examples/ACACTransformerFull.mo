within AixLib.Electrical.AC.OnePhase.Conversion.Examples;
model ACACTransformerFull
  "This example illustrates how to use the AC/AC transformer model"
  extends Modelica.Icons.Example;
  AixLib.Electrical.AC.OnePhase.Conversion.ACACTransformerFull tra_load(
    R1=0.0001,
    L1=0.0001,
    R2=0.0001,
    L2=0.0001,
    VABase=4000,
    magEffects=true,
    Rm=10,
    Lm=10,
    VHigh=120,
    VLow=60,
    f=60) "Transformer with load"
    annotation (Placement(transformation(extent={{-18,40},{2,60}})));
  AixLib.Electrical.AC.OnePhase.Sources.FixedVoltage sou(
    definiteReference=true,
    f=60,
    V=120) "Voltage source"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-70,50})));
  AixLib.Electrical.AC.OnePhase.Loads.Inductive load(
    mode=AixLib.Electrical.Types.Load.VariableZ_P_input,
    pf=0.8,
    V_nominal=60) "Load model"
            annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=0.5,
    startTime=0.3,
    offset=0,
    height=-4000*0.8) "Load power consumption profile"
    annotation (Placement(transformation(extent={{70,40},{50,60}})));
  AixLib.Electrical.AC.OnePhase.Conversion.ACACTransformerFull
                                                              tra_cc(
    VABase=4000,
    R1=0.01,
    L1=0.01,
    R2=0.01,
    L2=0.01,
    magEffects=false,
    Rm=100,
    Lm=100,
    VHigh=120,
    VLow=60,
    f=60) "Transformer with short circuit connection"
    annotation (Placement(transformation(extent={{-16,0},{4,20}})));
  AixLib.Electrical.AC.OnePhase.Loads.Impedance shortCircuit(R=1e-8)
    "Short circuit"
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  AixLib.Electrical.AC.OnePhase.Conversion.ACACTransformerFull tra_void(
    VABase=4000,
    R1=0.01,
    L1=0.01,
    R2=0.01,
    L2=0.01,
    magEffects=false,
    Rm=100,
    Lm=100,
    VHigh=120,
    VLow=60,
    f=60) "Transformer with open connection"
    annotation (Placement(transformation(extent={{-16,-30},{4,-10}})));
  AixLib.Electrical.AC.OnePhase.Sources.FixedVoltage sou1(
    definiteReference=true,
    f=60,
    V=120) "Voltage source for short circuit and open tests "
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-70,10})));
equation
  connect(sou.terminal, tra_load.terminal_n)
                                            annotation (Line(
      points={{-60,50},{-18,50}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(tra_load.terminal_p, load.terminal)    annotation (Line(
      points={{2,50},{10,50}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(ramp.y, load.Pow) annotation (Line(
      points={{49,50},{30,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tra_cc.terminal_p, shortCircuit.terminal) annotation (Line(
      points={{4,10},{10,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(sou1.terminal, tra_cc.terminal_n) annotation (Line(
      points={{-60,10},{-16,10}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(sou1.terminal, tra_void.terminal_n) annotation (Line(
      points={{-60,10},{-38,10},{-38,-20},{-16,-20}},
      color={0,120,120},
      smooth=Smooth.None));
  annotation ( experiment(StopTime=1.0, Tolerance=1e-6),
Documentation(info="<html>
<p>
This example illustrates the use of the AC/AC transformer model
that includes losses at the primary and secondary side and magnetization
effects.
The example shows three different configurations:
</p>
<ul>
<li>With a load connected,</li>
<li>without a load connected, and</li>
<li>with a short circuit connection.</li>
</ul>
</html>",
      revisions="<html>
<ul>
<li>
September 24, 2015 by Michael Wetter:<br/>
Removed binding of <code>P_nominal</code> as
this parameter is disabled and assigned a value
in the <code>initial equation</code> section.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
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
          "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/OnePhase/Conversion/Examples/ACACTransformerFull.mos"
        "Simulate and plot"));
end ACACTransformerFull;
