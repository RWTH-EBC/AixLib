within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model Sunblind "Calculates if sunblind of window is active"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.RadiantEnergyFluenceRate lim
    "Limit for the sunscreen to become active";

  Modelica.Blocks.Interfaces.RealInput HDifTil
    "Hemispherical diffuse solar irradiation on a tilted surface from the sky"
    annotation (Placement(transformation(extent={{-116,52},{-100,68}}),
        iconTransformation(extent={{-120,48},{-100,68}})));
  Modelica.Blocks.Interfaces.RealInput HDirTil
    "Direct irradition on tilted surface"
    annotation (Placement(transformation(extent={{-114,-64},{-100,-50}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Interfaces.BooleanOutput sunscreen
    "If true: sunscreen is closed, else sunscreen is open;"
      annotation (Placement(transformation(extent={{98,-10},{118,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

equation
  if (HDifTil+HDirTil)>lim then
    sunscreen=true;
  else
    sunscreen=false;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model computes whether the sunscreen is active or not. Therefore
  it compares the irradiation on the window with a limit for the
  sunscreen to be active set as a parameter.
</p>
</html>",
      revisions="<html><ul>
  <li>June 30, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Sunblind;
