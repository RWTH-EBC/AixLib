within AixLib.Controls.Interfaces;
expandable connector VapourCompressionMachineControlBus
  "Standard data bus with heat pump or chiller information"
extends Modelica.Icons.SignalBus;
  // Setpoints
  Real nSet "Relative rotational speed of compressor between 0 and 1"
  annotation (HideResult=false);
  Boolean modeSet
    "Current operation mode: true: main operation mode, false: reversible operation mode";

  // Measured values
  Boolean onOffMea
    "Measured value of device being on or off (relative speed greater than 0)"
                         annotation (HideResult=false);
  Modelica.Units.SI.ThermodynamicTemperature TEvaInMea
    "Temperature of flow into evaporator";

  Modelica.Units.SI.ThermodynamicTemperature TConInMea
    "Temperature of flow into condenser";

  Modelica.Units.SI.ThermodynamicTemperature TEvaOutMea
    "temperature of flow out of evaporator";

  Modelica.Units.SI.ThermodynamicTemperature TConOutMea
    "Temperature of flow out of condenser";

  Modelica.Units.SI.Power PelMea "Total electrical active power";

  Modelica.Units.SI.MassFlowRate m_flowEvaMea
    "Mass flow rate through evaporator";

  Modelica.Units.SI.MassFlowRate m_flowConMea
    "Mass flow rate through condenser";

  Real CoPMea "Coefficient of performance";

  Modelica.Units.SI.ThermodynamicTemperature TOdaMea "Outdoor air temperature";
  Modelica.Units.SI.ThermodynamicTemperature TEvaAmbMea
    "Ambient temperature on evaporator side";
  Modelica.Units.SI.ThermodynamicTemperature TConAmbMea
    "Ambient temperature on condenser side";
  Real iceFacMea(start=1)
    "Efficiency factor (0..1) to estimate influence of icing. 0 means no heat is transferred through heat exchanger (fully frozen). 1 means no icing/frosting."
annotation (
  defaultComponentName = "sigBusHP",
  Icon(coordinateSystem(preserveAspectRatio=false)),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  Documentation(info="<html><p>
  Definition of a standard heat pump bus that contains basic data
  points that appear in every heat pump.
</p>
</html>",
        revisions="<html><p>
  March 31, 2017, by Marc Baranski:
</p>
<p>
  First implementation.
</p>
</html>"));

  annotation (Documentation(info="<html><p>
  Bus connector with all relevant signals for vapour compression
  machines.
</p>
</html>", revisions="<html><ul>
<ul>
  <li>May 21, 2021, by Fabian Wüllhorst:<br/>
    Refactor (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/912\">issue 912</a>).
  </li>
</ul>
</html>"));
end VapourCompressionMachineControlBus;
