within AixLib.DataBase.Media.Refrigerants.R1270;
record TSP_Engelpracht
  "Record with fitting coefficients calculated for first implementation"
  import AixLib;
  extends
    AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition(
    name="Coefficients taken from Engelpracht",
    temperature_ph_nT={0},
    temperature_ph_sc={0},
    temperature_ph_sh={0},
    temperature_ph_iO={0},
    temperature_ps_nT={0},
    temperature_ps_sc={0},
    temperature_ps_sh={0},
    temperature_ps_iO={0},
    density_pT_nT={0},
    density_pT_sc={0},
    density_pT_sh={0},
    density_pT_iO={0});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 14, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>In this record, fitting coefficients are provided for thermodynamic properties calculated from two independent state variables. For detailed information of these thermodynamic properties as well as the fitting coefficients, please checkout <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition</a>. The fitting coefficients are used in a hybrid refrigerant model provided in <a href=\"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>. For detailed information, please checkout <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium</a>.</p>
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
end TSP_Engelpracht;
