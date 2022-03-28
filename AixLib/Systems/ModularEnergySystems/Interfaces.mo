within AixLib.Systems.ModularEnergySystems;
package Interfaces
extends Modelica.Icons.InterfacesPackage;
  expandable connector VapourCompressionMachineControleBusModular
    "Extends the original bus by inputs needed for modular heat pump"
    extends AixLib.Controls.Interfaces.VapourCompressionMachineControlBus;
    Real QRel "Part load ratio";

    Real PLR "Part load ratio compressor";

    Boolean Shutdown "true: force shutdown";

    Modelica.SIunits.Power QEvapNom "Nominal evaporation heat flow";

    Modelica.SIunits.Power QEvap "Nominal evaporation heat flow";
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end VapourCompressionMachineControleBusModular;

  expandable connector BoilerControlBus
    "Standard data bus with boiler information"
    extends Modelica.Icons.SignalBus;

  Boolean isOn "Switches Controller on and off";
  Modelica.SIunits.Temperature TAmbient "Ambient air temperature";
  Boolean switchToNightMode "Switches the boiler to night mode";
  Modelica.SIunits.Power chemicalEnergyFlowRate "Flow of primary (chemical) energy into boiler";

  // BoilerNotManufacturer
  Real PLR "Part load ratio";
  Modelica.SIunits.TemperatureDifference DeltaTWater "Setpoint temperature difference heat circuit";
  Modelica.SIunits.Temperature TCold "Sensor output TCold";
  Modelica.SIunits.Temperature THot "Sensor output THot";
  Modelica.SIunits.Power EnergyDemand "Energy Demand";

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a standard boiler control bus that contains basic data points
  that appear in every boiler.</p>
</html>",   revisions="<html>
<ul>
  <li>
  March 31, 2017, by Marc Baranski:<br/>
  First implementation (see
  <a href=\"https://github.com/RWTH-EBC/AixLib/issues/371\">issue 371</a>).
  </li>
</ul>

</html>"));
  end BoilerControlBus;
end Interfaces;
