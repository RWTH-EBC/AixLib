within AixLib.DataBase.Media.Refrigerants.R290;
record EoS_IIR_P05_30_T263_343
  "Record with fitting coefficients taken from the Fast_Propane model"

  extends AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition(
    name="Coefficients taken from Fast_Propane model developed by Sangi et al.",
    f_IdgNl=1,
    f_IdgL1={3},
    f_IdgL2={1},
    f_IdgNp=2,
    f_IdgP1={-4.970583,4.29352},
    f_IdgP2={0,1},
    f_IdgNe=4,
    f_IdgE1={3.043,5.874,9.337,7.922},
    f_IdgE2={1.062478,3.344237,5.363757,11.762957},
    f_ResNp=5,
    f_ResP1={0.042910051,1.7313671,-2.4516524,0.34157466,-0.46047898},
    f_ResP2={4,1,1,2,2},
    f_ResP3={1,0.33,0.8,0.43,0.9},
    f_ResNb=6,
    f_ResB1={-0.66847295,0.20889705,0.19421381,-0.22917851,
             -0.60405866,0.066680654},
    f_ResB2={1,3,6,6,2,3},
    f_ResB3={2.46,2.09,0.88,1.09,3.25,4.62},
    f_ResB4={1,1,1,1,2,2},
    f_ResNG=7,
    f_ResG1={0.017534618,0.33874242,0.22228777,-0.23219062,-0.09220694,
             -0.47575718,-0.017486824},
    f_ResG2={1,1,1,2,2,4,1},
    f_ResG3={0.76,2.5,2.75,3.05,2.55,8.4,6.75},
    f_ResG4={0.963,1.977,1.917,2.307,2.546,3.28,14.6},
    f_ResG5={1.283,0.6936,0.788,0.473,0.8577,0.271,0.948},
    f_ResG6={2.33,3.47,3.15,3.19,0.92,18.8,547.8},
    f_ResG7={0.684,0.829,1.419,0.817,1.5,1.426,1.093});

  annotation (Documentation(revisions="<html><ul>
  <li>June 10, 2017, by Mirko Engelpracht, Christian Vering:<br/>
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
  \"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>.
  For detailed information, please checkout <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>.
</p>
<h4>
  Assumptions and limitations
</h4>
<p>
  The provided coefficients are fitted to external data by Sangi et al.
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
        0.5
      </p>
    </td>
    <td>
      <p>
        30
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
        263.15
      </p>
    </td>
    <td>
      <p>
        343.15
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
  Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita;
  Müller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A
  Medium Model for the Refrigerant Propane for Fast and Accurate
  Dynamic Simulations</a>. In: <i>The 10th International Modelica
  Conference</i>. Lund, Sweden, March 10-12, 2014: Linköping University
  Electronic Press (Linköping Electronic Conference Proceedings), S.
  1271–1275
</p>
</html>"));
end EoS_IIR_P05_30_T263_343;
