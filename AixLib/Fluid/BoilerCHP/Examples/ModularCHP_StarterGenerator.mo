within AixLib.Fluid.BoilerCHP.Examples;
model ModularCHP_StarterGenerator
  extends Modelica.Icons.Example;

  ModularCHP.CHP_StarterGenerator cHP_ASMGenerator(inertia(w(fixed=false)),
      CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15())
    annotation (Placement(transformation(extent={{-24,-12},{0,12}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(           startTime=0,
    width=100,
    period=100)
    annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  Modelica.Mechanics.Rotational.Sources.Speed
    quadraticSpeedDependentTorque(phi(fixed=false))
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  Modelica.Blocks.Sources.Ramp ramp(duration=10, height=1530*3.14/30)
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
equation
  connect(cHP_ASMGenerator.isOn, booleanPulse.y)
    annotation (Line(points={{-23.76,0},{-81,0}}, color={255,0,255}));
  connect(cHP_ASMGenerator.flange_a, quadraticSpeedDependentTorque.flange)
    annotation (Line(points={{0,0},{40,0}}, color={0,0,0}));
  connect(quadraticSpeedDependentTorque.w_ref, ramp.y)
    annotation (Line(points={{62,0},{89,0}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>Model of an electric induction machine that includes the calculation of:</p>
<p>-&gt; mechanical output (torque and speed)</p>
<p>-&gt; electrical output (current and power)</p>
<p>It delivers positive torque and negative electrical power when operating below the synchronous speed (motor) and can switch into generating electricity (positive electrical power and negative torque) when operating above the synchronous speed (generator).</p>
<p>The calculations are based on simple electrical equations and an analytical approach by Pichai Aree (2017) that determinates stator current and torque depending on the slip.</p>
<p>The parameters rho0, rho1, rho3 and k are used for the calculation of the characteristic curves. They are determined from the general machine data at nominal operation and realistic assumptions about the ratio between starting torque, starting current, breakdown torque, breakdown slip and nominal current and torque. These assumptions are taken from DIN VDE 2650/2651. It shows good agreement for machines up to 100kW of mechanical power.</p>
</html>"));
end ModularCHP_StarterGenerator;
