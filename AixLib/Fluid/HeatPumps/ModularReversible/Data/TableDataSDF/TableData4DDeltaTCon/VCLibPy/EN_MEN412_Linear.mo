within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4DDeltaTCon.VCLibPy;
record EN_MEN412_Linear "Calibrated on OptiHorst heat pump"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableDataSDF.TableData4DDeltaTCon.VCLibPy.GenericVCLibPy4D
                                               (
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    refrigerant="R410A",
    flowsheet="OptiHorst",
    filename="modelica://AixLib/Resources/Data/Fluid/HeatPumps/ModularReversible/Data/VCLibMap/EN_MEN412_Linear_4D_dT.sdf");
  annotation (Documentation(revisions="<html>
<ul>
  <li>
    <i>December 22, 2025</i> by Fabian Roemer:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1520\">AixLib #1623</a>)
  </li>
</ul>
</html>", info="<html>
<h4>References</h4>
<p>
Römer, Fabian and Fuchs, Nico and Fuchs, Nico and Müller, Dirk, Practical, Near-Optimal Design Rule Extraction for Heat Pumps in Single-Family Buildings (September 03, 2025). Available at SSRN: 
<a href=\"https://ssrn.com/abstract=5633891\">https://ssrn.com/abstract=5633891</a>
</p>
</html>"));
end EN_MEN412_Linear;
