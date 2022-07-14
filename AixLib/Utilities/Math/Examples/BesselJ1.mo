within AixLib.Utilities.Math.Examples;
model BesselJ1 "Test model for besselJ1 function "
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp x(duration=30, height=30) "Real signal"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  AixLib.Utilities.Math.BesselJ1 J1 "Bessel function J1"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(x.y, J1.u)
    annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
  annotation (  experiment(Tolerance=1e-6, StopTime=30.0),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Math/Examples/BesselJ1.mos"
        "Simulate and plot"), Documentation(info="<html>
 <p>
 This model tests the implementation of
 <a href=\"modelica://AixLib.Utilities.Math.BesselJ1\">
 AixLib.Utilities.Math.BesselJ1</a>.
 </p>
 </html>",revisions="<html>
 <ul>
 <li>
 July 17, 2018, by Massimo Cimmino:<br/>First implementation.
 </li>
 </ul>
 </html>"),
  __Dymola_LockedEditing="Model from IBPSA");
end BesselJ1;
