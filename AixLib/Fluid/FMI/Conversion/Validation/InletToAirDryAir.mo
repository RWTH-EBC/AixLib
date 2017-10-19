within AixLib.Fluid.FMI.Conversion.Validation;
model InletToAirDryAir
  "Validation model for inlet to air with dry air medium"
  extends AixLib.Fluid.FMI.Conversion.Validation.InletToAirMoistAir(
    redeclare package Medium = Modelica.Media.Air.SimpleAir);
  annotation (Documentation(info="<html>
<p>
This validation test is identical to
<a href=\"modelica://AixLib.Fluid.FMI.Conversion.Validation.InletToAirMoistAir\">
AixLib.Fluid.FMI.Conversion.Validation.InletToAirMoistAir</a>
except that it uses a medium model without moisture.
Hence, it tests whether the water vapor connectors are correctly removed.
</p>
</html>", revisions="<html>
<ul>
<li>
June 29, 2016, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/FMI/Conversion/Validation/InletToAirDryAir.mos"
        "Simulate and plot"),
    experiment(Tolerance=1e-6, StopTime=1.0));
end InletToAirDryAir;
