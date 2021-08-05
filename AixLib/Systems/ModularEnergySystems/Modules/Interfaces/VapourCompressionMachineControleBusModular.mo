within AixLib.Systems.ModularEnergySystems.Modules.Interfaces;
expandable connector VapourCompressionMachineControleBusModular
  "Extends the original bus by inputs needed for modular heat pump"
  extends AixLib.Controls.Interfaces.VapourCompressionMachineControlBus;
  Real QRel "Part load ratio";

  Real PLR "Part load ratio compressor";

  Boolean Shutdown "true: force shutdown";

  Modelica.SIunits.Power QEvapNom "Nominal evaporation heat flow";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end VapourCompressionMachineControleBusModular;
