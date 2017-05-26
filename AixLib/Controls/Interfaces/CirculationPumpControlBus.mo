within AixLib.Controls.Interfaces;
expandable connector CirculationPumpControlBus
  "Standard data bus with circulation pump information"
  extends Modelica.Icons.SignalBus;

  Modelica.SIunits.Pressure dp "pressure gain from the circulation pump";
  Modelica.SIunits.VolumeFlowRate V_flow "volume flor of the mdeium through the circulation pump";
  Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm N "rotational speed of the circulation pump";
  Modelica.SIunits.Power Pel "Total electrical active power of circulation pump";
  Modelica.SIunits.Efficiency eff "efficiency of the ciruclation pump";

end CirculationPumpControlBus;
