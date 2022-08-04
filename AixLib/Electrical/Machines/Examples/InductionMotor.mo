within AixLib.Electrical.Machines.Examples;
model InductionMotor
  extends Modelica.Icons.Example;
  InductionMachine inductionMachine(inertia(phi(fixed=true, start=0), w(
          fixed=true, start=0)))
    annotation (Placement(transformation(extent={{-24,-24},{24,24}})));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
    quadraticSpeedDependentTorque(tau_nominal=-100, w_nominal(displayUnit="rpm")=
         inductionMachine.n0)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=100, startTime=0)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(quadraticSpeedDependentTorque.flange, inductionMachine.flange_Machine)
    annotation (Line(points={{60,0},{24,0}}, color={0,0,0}));
  connect(booleanPulse.y, inductionMachine.isOn)
    annotation (Line(points={{-59,0},{-19.2,0}}, color={255,0,255}));

  annotation(experiment(StopTime=300, Interval=0.1));
end InductionMotor;
