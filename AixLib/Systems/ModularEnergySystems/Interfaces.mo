within AixLib.Systems.ModularEnergySystems;
package Interfaces
extends Modelica.Icons.InterfacesPackage;
  expandable connector VapourCompressionMachineControleBusModular
    "Extends the original bus by inputs needed for modular heat pump"
    extends AixLib.Controls.Interfaces.VapourCompressionMachineControlBus;
    Real QRel "Part load ratio";

    Real PLR "Part load ratio compressor";
    Real PLR_HP "Part load Thermal";

    Boolean Shutdown "true: force shutdown";

    Modelica.Units.SI.Power QEvapNom "Nominal evaporation heat flow";

    Modelica.Units.SI.Power QEvap "Nominal evaporation heat flow";

    Real mFlowWaterRel;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end VapourCompressionMachineControleBusModular;

  expandable connector BoilerControlBus
    "Standard data bus with boiler information"
    extends Modelica.Icons.SignalBus;

  Boolean isOn "Switches Controller on and off";
  Modelica.Units.SI.Temperature TAmbient "Ambient air temperature";
  Boolean switchToNightMode "Switches the boiler to night mode";
  Modelica.Units.SI.Power chemicalEnergyFlowRate "Flow of primary (chemical) energy into boiler";

  // BoilerNotManufacturer
    // Outer variables
      Real QrelSet "Relative fuel consumption";
      Modelica.Units.SI.Temperature TSupplySet "Setpoint supply temperature";

    // Inner variables
      Real Qrel_mFlow "Relative water mass flow";
      Real Qrel_DeltaT "Relative temperature difference";

      Modelica.Units.SI.Temperature TReturnMea "Measurement return temperature";
      Modelica.Units.SI.Temperature TSupplyMea "Measurement supply temperature";
      Modelica.Units.SI.Temperature TColdMea "Sensor output TCold combustion chamber";
      Modelica.Units.SI.Temperature THotWater "Sensor output hot water temperature";

      Modelica.Units.SI.MassFlowRate m_flowMea "Measurement water mass flow";

      Real Efficiency "Efficiency of operation point";
      Modelica.Units.SI.Power Losses "Power losses";
      Modelica.Units.SI.Power ThermalPower "Thermal power";
      Modelica.Units.SI.Power PowerDemand "Power demand";

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
