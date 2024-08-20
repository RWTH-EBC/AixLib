within AixLib.Electrical.AC.ThreePhasesBalanced.Conversion.Examples;
model ACACTransformer
  "This example illustrates how to use the AC/AC simplified transformer model"
  extends Modelica.Icons.Example;
  AixLib.Electrical.AC.ThreePhasesBalanced.Conversion.ACACTransformer tra_load(
    Zperc=0.03,
    VABase=4000,
    XoverR=8,
    VHigh=480,
    VLow=120) "Transformer with load"
    annotation (Placement(transformation(extent={{-18,40},{2,60}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Sources.FixedVoltage sou(
    definiteReference=true,
    f=60,
    V=480) "Voltage source"
      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-70,50})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Loads.Inductive load(
    mode=AixLib.Electrical.Types.Load.VariableZ_P_input,
    pf=0.8,
    V_nominal=120) "Load model"
    annotation (Placement(transformation(extent={{10,40},{30,60}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=0.5,
    startTime=0.3,
    offset=0,
    height=-4000*0.8) "Load power consumption profile"
    annotation (Placement(transformation(extent={{70,40},{50,60}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Conversion.ACACTransformer tra_cc(
    XoverR=8,
    Zperc=0.03,
    VABase=4000,
    VHigh=480,
    VLow=120) "Transformer with short circuit"
    annotation (Placement(transformation(extent={{-16,0},{4,20}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Loads.Impedance shortCircuit(R=1e-8)
    "Short circuit"
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Conversion.ACACTransformer tra_void(
    XoverR=8,
    Zperc=0.03,
    VABase=4000,
    VHigh=480,
    VLow=120) "Transformer with secondary not connected"
    annotation (Placement(transformation(extent={{-16,-30},{4,-10}})));
  AixLib.Electrical.AC.ThreePhasesBalanced.Sources.FixedVoltage sou1(
    definiteReference=true,
    f=60,
    V=480) "Voltage source for open and short circuit tests"
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
This example illustrates the use of the AC/AC transformer model.
The example shows three different configurations:
</p>
<ul>
<li>With a load connected,</li>
<li>without a load connected, and</li>
<li>with a short circuit connection.</li>
</ul>
</html>",    revisions="<html>
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
          "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/ThreePhasesBalanced/Conversion/Examples/ACACTransformer.mos"
        "Simulate and plot"), 
   __Dymola_LockedEditing="Model from IBPSA");
end ACACTransformer;
