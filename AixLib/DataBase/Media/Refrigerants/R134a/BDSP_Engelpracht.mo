within AixLib.DataBase.Media.Refrigerants.R134a;
record BDSP_Engelpracht
  "Record with fitting coefficients calculated for first implementation"
  import AixLib;
  extends
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition(
    name="Coefficients taken from Engelpracht",
    saturationPressure_nT=0,
    saturationPressure_n={0},
    saturationPressure_e={0},
    saturationTemperature_nT=0,
    saturationTemperature_n={0},
    saturationTemperature_iO={0},
    bubbleDensity_nT=0,
    bubbleDensity_n={0},
    bubbleDensity_iO={0},
    dewDensity_nT=0,
    dewDensity_n={0},
    dewDensity_iO={0},
    bubbleEnthalpy_nT=0,
    bubbleEnthalpy_n={0},
    bubbleEnthalpy_iO={0},
    dewEnthalpy_nT=0,
    dewEnthalpy_n={0},
    dewEnthalpy_iO={0},
    bubbleEntropy_nT=0,
    bubbleEntropy_n={0},
    bubbleEntropy_iO={0},
    dewEntropy_nT=0,
    dewEntropy_n={0});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 14, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>In this record, fitting coefficients are provided for thermodynamic properties at bubble and dew line. For detailed information of these thermodynamic properties as well as the fitting coefficients, please checkout <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition</a>. The fitting coefficients are used in a hybrid refrigerant model provided in <a href=\"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>. For detailed information, please checkout <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium</a>.</p>
<p><b>Assumptions and limitations</b></p>
<p>The provided coefficients are fitted to external data by Engelpracht and are valid within the following range:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"30%\"><tr>
<td><p>Parameter</p></td>
<td><p>Minimum Value</p></td>
<td><p>Maximum Value</p></td>
</tr>
<tr>
<td><p>Pressure (p) in bar</p></td>
<td><p>??</p></td>
<td><p>??</p></td>
</tr>
<tr>
<td><p>Temperature (T) in K</p></td>
<td><p>??</p></td>
<td><p>??</p></td>
</tr>
</table>
<p><b>References</b></p>
<p>Engelpracht, Mirko (2017): Development of scalable and modular simulation models for heat pumps and refrigerating machines. <i>Master Thesis</i></p>
</html>"));
end BDSP_Engelpracht;
