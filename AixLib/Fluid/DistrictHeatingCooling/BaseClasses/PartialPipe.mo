within AixLib.Fluid.DistrictHeatingCooling.BaseClasses;
partial model PartialPipe
  "Base class for a pipe connection in DHC systems"
  extends AixLib.Fluid.DistrictHeatingCooling.BaseClasses.PartialPipeAdiabatic;

  parameter Modelica.SIunits.Length dIns
    "Thickness of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.SIunits.ThermalConductivity kIns
    "Heat conductivity of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Real R(unit="(m.K)/W")=1/(kIns*2*Modelica.Constants.pi/
    Modelica.Math.log((dh/2 + dIns)/(dh/2)))
    "Thermal resistance per unit length from fluid to boundary temperature"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.SIunits.Temperature T_ground(start=Medium.T_default)
    "Ground temperature around the pipe"
    annotation (Dialog(group="Ambient"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This base class provides an interface for pipe models. It can be used
  to wrap around different pipe model implementations with
  representation of the thermal losses through the pipe wall.
</p>
<ul>
  <li>Jun 21, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end PartialPipe;
