within AixLib.DataBase.Media.Refrigerants.R410a;
record EoS_IIR_P1_48_T233_340
  "Record with fitting coefficients calculated for first implementation"
  import AixLib;
  extends
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition(
    name="Coefficients taken from Lemmon, Pseudo-Pure Fluid Equations of State for the Refrigerant Blends R-410A, R-404A, R-507A, and R-407C",
    alpha_0_nL=1,
    alpha_0_l1={-1},
    alpha_0_l2={1},
    alpha_0_nP=3,
    alpha_0_p1={36.8871,7.15807,-46.87575},
    alpha_0_p2={0,1,-0.1},
    alpha_0_nE=3,
    alpha_0_e1={2.0623,5.9751,1.5612},
    alpha_0_e2={2.02326,5.00154,11.2484},
    alpha_r_nP=5,
    alpha_r_p1={0.987252,-1.03017,1.17666,-0.138991,0.00302373},
    alpha_r_p2={1,1,1,2,5},
    alpha_r_p3={0.44,1.2,2.97,2.95,0.2},
    alpha_r_nB=16,
    alpha_r_b1={-2.53639,-1.9668,-0.83048,0.172477,-0.261116,-0.0745473,0.679757,-0.652431,0.0553849,-0.071097,-0.000875332,0.020076,-0.0139761,-0.018511,0.0171939,-0.00482049},
    alpha_r_b2={1,2,3,5,5,5,1,1,4,4,9,2,2,4,5,6},
    alpha_r_b3={1.93,1.78,3,0.2,0.74,3,2.1,4.3,0.25,7,4.7,13,16,25,17,7.4},
    alpha_r_b4={1,1,1,1,1,1,2,2,2,2,2,3,3,3,3,3},
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
<p>In this record, fitting coefficients are provided for the Helmholtz equation of state (EoS). For detailed information of the EoS as well as the fitting coefficients, please checkout <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition\">AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition</a>. The fitting coefficients are used in a hybrid refrigerant model provided in <a href=\"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>. For detailed information, please checkout <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>.</p>
<p><b>Assumptions and limitations</b></p>
<p>The provided coefficients are fitted to external data by Engelpracht and are valid within the following range:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"30%\"><tr>
<td><p>Parameter</p></td>
<td><p>Minimum Value</p></td>
<td><p>Maximum Value</p></td>
</tr>
<tr>
<td><p>Pressure (p) in bar</p></td>
<td><p>1</p></td>
<td><p>48</p></td>
</tr>
<tr>
<td><p>Temperature (T) in K</p></td>
<td><p>233.15</p></td>
<td><p>340.15</p></td>
</tr>
</table>
<p>The reference point is defined as 200 kJ/kg and 1 kJ/kg/K, respectively, for enthalpy and entropy for the saturated liquid at 273.15 K.</p>
<p><b>References</b></p>
<p>Engelpracht, Mirko (2017): Development of modular and scalable simulation models for heat pumps and chillers considering various refrigerants. <i>Master Thesis</i></p>
</html>"));
end EoS_IIR_P1_48_T233_340;
