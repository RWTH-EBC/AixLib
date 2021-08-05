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
  Modelica.SIunits.ThermodynamicTemperature TEvaInMea
    "Temperature of flow into evaporator";

  Modelica.SIunits.ThermodynamicTemperature TConInMea
    "Temperature of flow into condenser";

  Modelica.SIunits.ThermodynamicTemperature TEvaOutMea
    "temperature of flow out of evaporator";

  Modelica.SIunits.ThermodynamicTemperature TConOutMea
    "Temperature of flow out of condenser";

  Modelica.SIunits.Power PelMea "Total electrical active power";

  Modelica.SIunits.MassFlowRate m_flowEvaMea
    "Mass flow rate through evaporator";

  Modelica.SIunits.MassFlowRate m_flowConMea "Mass flow rate through condenser";

  Real CoPMea "Coefficient of performance";

  Modelica.SIunits.ThermodynamicTemperature TOdaMea "Outdoor air temperature";
  Modelica.SIunits.ThermodynamicTemperature TEvaAmbMea
    "Ambient temperature on evaporator side";
  Modelica.SIunits.ThermodynamicTemperature TConAmbMea
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

  // Non Manufacturer Models only
  Real QRel "Part load ratio";

  Real PLR "Part load ratio compressor";

  Boolean Shutdown "true: force shutdown";

  Modelica.SIunits.Power QEvapNom "Nominal evaporation heat flow";

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
