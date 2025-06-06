within AixLib.Electrical.AC.ThreePhasesUnbalanced.Lines.Examples;
model ACLineMatrix_RL
  "Test model for a three-phase unbalanced inductive-resistive line specified by a Z matrix"
  extends Modelica.Icons.Example;
  Sources.FixedVoltage E(
    definiteReference=true,
    f=60,
    V=100*sqrt(3)) "Voltage source"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Loads.Impedance sc_load1(R=0, L=0) "Short circuit load"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Loads.Impedance sc_load2(R=0, L=0) "Short circuit load"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Loads.Impedance sc_load3(R=0, L=0) "Short circuit load"
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Lines.TwoPortMatrixRL Rline_1(
    Z11={10,10},
    Z12={0,0},
    Z13={0,0},
    Z22={10,10},
    Z23={0,0},
    Z33={10,10},
    V_nominal=100*sqrt(3)) "RL line that connects to load 1"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Lines.TwoPortMatrixRL Rline_2a(
    Z12={0,0},
    Z13={0,0},
    Z23={0,0},
    Z11=0.5*{10,10},
    Z22=0.5*{10,10},
    Z33=0.5*{10,10},
    V_nominal=100*sqrt(3)) "RL line that connects to load 2"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Lines.TwoPortMatrixRL Rline_2b(
    Z12={0,0},
    Z13={0,0},
    Z23={0,0},
    Z11=0.5*{10,10},
    Z22=0.5*{10,10},
    Z33=0.5*{10,10},
    V_nominal=100*sqrt(3)) "RL line that connects to load 2"
    annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
  Lines.TwoPortMatrixRL Rline_3a(
    Z12={0,0},
    Z13={0,0},
    Z23={0,0},
    Z11=2*{10,10},
    Z22=2*{10,10},
    Z33=2*{10,10},
    V_nominal=100*sqrt(3)) "RL line that connects to load 3"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Lines.TwoPortMatrixRL Rline_3b(
    Z12={0,0},
    Z13={0,0},
    Z23={0,0},
    Z11=2*{10,10},
    Z22=2*{10,10},
    Z33=2*{10,10},
    V_nominal=100*sqrt(3)) "RL line that connects to load 3"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
equation
  connect(E.terminal, Rline_1.terminal_n) annotation (Line(
      points={{-80,0},{-70,0},{-70,30},{-60,30}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(Rline_1.terminal_p, sc_load1.terminal) annotation (Line(
      points={{-40,30},{0,30}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(E.terminal, Rline_2a.terminal_n) annotation (Line(
      points={{-80,0},{-70,0},{-70,6.66134e-16},{-60,6.66134e-16}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(Rline_2a.terminal_p, Rline_2b.terminal_n) annotation (Line(
      points={{-40,0},{-36,0}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(Rline_2b.terminal_p, sc_load2.terminal) annotation (Line(
      points={{-16,0},{-4.44089e-16,0}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(E.terminal, Rline_3a.terminal_n) annotation (Line(
      points={{-80,0},{-70,0},{-70,-30},{-60,-30}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(E.terminal, Rline_3b.terminal_n) annotation (Line(
      points={{-80,0},{-70,0},{-70,-50},{-60,-50}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(Rline_3a.terminal_p, sc_load3.terminal) annotation (Line(
      points={{-40,-30},{-20,-30},{-20,-40},{0,-40}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(Rline_3b.terminal_p, sc_load3.terminal) annotation (Line(
      points={{-40,-50},{-20,-50},{-20,-40},{0,-40}},
      color={0,120,120},
      smooth=Smooth.None));
  annotation (experiment(StopTime=1.0, Tolerance=1e-6),
  __Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/ThreePhasesUnbalanced/Lines/Examples/ACLineMatrix_RL.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example demonstrates how to use an inductive resistive line model to connect
a source to a load. The model is parameterized using the impedance matrix <i>Z</i>.
</p>
<p>
The model has three loads. The loads represent a short circuit <i>R=0</i>.
The current that flows through the load depends on the resistance of the line.
</p>
</html>", revisions="<html>
<ul>
<li>
October 8, 2014, by Marco Bonvini:<br/>
Created model and documentation.
</li>
</ul>
</html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
end ACLineMatrix_RL;
