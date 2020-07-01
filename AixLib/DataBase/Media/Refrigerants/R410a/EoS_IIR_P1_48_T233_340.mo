within AixLib.DataBase.Media.Refrigerants.R410a;
record EoS_IIR_P1_48_T233_340
  "Record with fitting coefficients calculated for first implementation"

  extends AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition(
    name="Coefficients taken from Lemmon, Pseudo-Pure Fluid Equations of State
    for the Refrigerant Blends R-410A, R-404A, R-507A, and R-407C",
    f_IdgNl=1,
    f_IdgL1={-1},
    f_IdgL2={1},
    f_IdgNp=3,
    f_IdgP1={36.8871,7.15807,-46.87575},
    f_IdgP2={0,1,-0.1},
    f_IdgNe=3,
    f_IdgE1={2.0623,5.9751,1.5612},
    f_IdgE2={2.02326,5.00154,11.2484},
    f_ResNp=5,
    f_ResP1={0.987252,-1.03017,1.17666,-0.138991,0.00302373},
    f_ResP2={1,1,1,2,5},
    f_ResP3={0.44,1.2,2.97,2.95,0.2},
    f_ResNb=16,
    f_ResB1={-2.53639,-1.9668,-0.83048,0.172477,-0.261116,-0.0745473,
             0.679757,-0.652431,0.0553849,-0.071097,-0.000875332,
             0.020076,-0.0139761,-0.018511,0.0171939,-0.00482049},
    f_ResB2={1,2,3,5,5,5,1,1,4,4,9,2,2,4,5,6},
    f_ResB3={1.93,1.78,3,0.2,0.74,3,2.1,4.3,0.25,7,4.7,13,16,25,17,7.4},
    f_ResB4={1,1,1,1,1,1,2,2,2,2,2,3,3,3,3,3},
    f_ResNG=0,
    f_ResG1={0},
    f_ResG2={0},
    f_ResG3={0},
    f_ResG4={0},
    f_ResG5={0},
    f_ResG6={0},
    f_ResG7={0});
  annotation (Documentation(revisions="<html><ul>
  <li>June 14, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  In this record, fitting coefficients are provided for the Helmholtz
  equation of state (EoS). For detailed information of the EoS as well
  as the fitting coefficients, please checkout <a href=
  \"modelica://AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition\">
  AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition</a>
  . The fitting coefficients are used in a hybrid refrigerant model
  provided in <a href=
  \"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>
  . For detailed information, please checkout <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>
  .
</p>
<h4>
  Assumptions and limitations
</h4>
<p>
  The provided coefficients are fitted to external data by Engelpracht
  and are valid within the following range:<br/>
</p>
<table summary=\"Range of validiry\" cellspacing=\"0\" cellpadding=\"2\"
border=\"1\" width=\"30%\" style=\"border-collapse:collapse;\">
  <tr>
    <td>
      <p>
        Parameter
      </p>
    </td>
    <td>
      <p>
        Minimum Value
      </p>
    </td>
    <td>
      <p>
        Maximum Value
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Pressure (p) in bar
      </p>
    </td>
    <td>
      <p>
        1
      </p>
    </td>
    <td>
      <p>
        48
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Temperature (T) in K
      </p>
    </td>
    <td>
      <p>
        233.15
      </p>
    </td>
    <td>
      <p>
        340.15
      </p>
    </td>
  </tr>
</table>
<p>
  The reference point is defined as 200 kJ/kg and 1 kJ/kg/K,
  respectively, for enthalpy and entropy for the saturated liquid at
  273.15 K.
</p>
<h4>
  References
</h4>
<p>
  Engelpracht, Mirko (2017): Development of modular and scalable
  simulation models for heat pumps and chillers considering various
  refrigerants. <i>Master Thesis</i>
</p>
</html>"));
end EoS_IIR_P1_48_T233_340;
