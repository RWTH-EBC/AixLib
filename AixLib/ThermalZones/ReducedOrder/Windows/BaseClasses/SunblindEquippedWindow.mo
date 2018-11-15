within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model SunblindEquippedWindow
  "Calculates if sunblind of window is active"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer n(min = 1) "Vector size for input and output";
  parameter Modelica.SIunits.RadiantEnergyFluenceRate lim
    "Limit for the sunscreen to become active";

  parameter Real shadingFactor
    "Factor representing how much solar irradiation goes through the sunblind";

  Modelica.Blocks.Interfaces.RealInput HDirTil[n](
    each final quantity="RadiantEnergyFluenceRate",
    each final unit="W/m2")
    "Direct solar radiation on a tilted surface per unit area"
    annotation (Placement(transformation(extent={{-116,-68},{-100,-52}}),
        iconTransformation(extent={{-120,-72},{-100,-52}})));
  Modelica.Blocks.Interfaces.RealInput HSkyDifTil[n](
    each final quantity="RadiantEnergyFluenceRate",
    each final unit="W/m2")
    "Hemispherical diffuse solar irradiation on a tilted surface from the sky" annotation (Placement(transformation(
          extent={{-116,52},{-100,68}}),   iconTransformation(extent={{-122,46},
            {-102,66}})));
  Modelica.Blocks.Interfaces.RealOutput windowFac[n]
    annotation (Placement(transformation(extent={{94,-10},{114,10}})));
equation
  for i in 1:n loop
    if (HSkyDifTil[i]+HDirTil[i])>lim then
       windowFac[i] = shadingFactor;
    else
       windowFac[i] = 1;
    end if;
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model computes whether the sunscreen is active or not. Therefore it
 compares the irradiation on the window with a limit for the sunscreen to be
 active set as a parameter.</p>

</html>",
      revisions="<html>
<ul>
<li>June 30, 2016,&nbsp; by Stanley Risch:<br/>Implemented. </li>
</ul>
</html>"));
end SunblindEquippedWindow;
