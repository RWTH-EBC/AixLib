within AixLib.DataBase.Media.Refrigerants.R1270;
record EoS_Engelpracht
  "Record with fitting coefficients calculated for first implementation"
  import AixLib;
  extends
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition(
    name="Coefficients taken from Engelpracht",
    alpha_0_nL=0,
    alpha_0_l1={0},
    alpha_0_l2={0},
    alpha_0_nP=0,
    alpha_0_p1={0},
    alpha_0_p2={0},
    alpha_0_nE=0,
    alpha_0_e1={0},
    alpha_0_e2={0},
    alpha_r_nP=0,
    alpha_r_p1={0},
    alpha_r_p2={0},
    alpha_r_p3={0},
    alpha_r_nB=0,
    alpha_r_b1={0},
    alpha_r_b2={0},
    alpha_r_b3={0},
    alpha_r_b4={0},
    alpha_r_nG=0,
    alpha_r_g1={0},
    alpha_r_g2={0},
    alpha_r_g3={0},
    alpha_r_g4={0},
    alpha_r_g5={0},
    alpha_r_g6={0},
    alpha_r_g7={0});

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 14, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>In this record, fitting coefficients are provided for the Helmholtz equation of state (EoS). For detailed information of the EoS as well as the fitting coefficients, please checkout <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition\">AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition</a>. The fitting coefficients are used in a hybrid refrigerant model provided in <a href=\"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>. For detailed information, please checkout <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium</a>.</p>
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
end EoS_Engelpracht;
