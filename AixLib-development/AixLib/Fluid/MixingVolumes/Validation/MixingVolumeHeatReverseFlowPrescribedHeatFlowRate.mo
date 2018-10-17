within AixLib.Fluid.MixingVolumes.Validation;
model MixingVolumeHeatReverseFlowPrescribedHeatFlowRate
  "Validation model for mixing volume with heat input and flow reversal and prescribed heat flow rate"
  extends MixingVolumeHeatReverseFlow(
    prescribedHeatFlowRate=true);

  annotation (Documentation(
info="<html>
<p>
This model is identical to
<a href=\"modelica://AixLib.Fluid.MixingVolumes.Validation.MixingVolumeHeatReverseFlow\">
AixLib.Fluid.MixingVolumes.Validation.MixingVolumeHeatReverseFlow</a>,
except that the steady state volume <code>volSte</code>
is configured to have a prescribed heat flow rate,
which is in this case zero as the heat port is not connected.
This configures <code>volSte</code> to use the two port
steady state heat and mass balance model
<a href=\"modelica://AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation\">
AixLib.Fluid.Interfaces.StaticTwoPortConservationEquation</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 9, 2016, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
 __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/MixingVolumes/Validation/MixingVolumeHeatReverseFlowPrescribedHeatFlowRate.mos"
        "Simulate and plot"),
    experiment(Tolerance=1e-6, StopTime=10));
end MixingVolumeHeatReverseFlowPrescribedHeatFlowRate;
