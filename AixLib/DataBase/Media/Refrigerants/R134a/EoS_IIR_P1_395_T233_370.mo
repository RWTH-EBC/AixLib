within AixLib.DataBase.Media.Refrigerants.R134a;
record EoS_IIR_P1_395_T233_370
  "Record with fitting coefficients calculated for first implementation"
  extends AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition(
    name="Coefficients taken from Tillner-Roth and Baehr, An International
          Standard Formulation for the thermodynamic Properties of
          1,1,1,2‐Tetrafluoroethane (HFC‐134a) for Temperatures from 170 K to
          455 K and Pressures up to 70 MPa",
    f_IdgNl=1,
    f_IdgL1={-1.629789},
    f_IdgL2={1},
    f_IdgNp=4,
    f_IdgP1={-1.02084672674949,9.04757355104757,-9.723916,-3.92717},
    f_IdgP2={0,1,-0.5,-0.75},
    f_IdgNe=0,
    f_IdgE1={0},
    f_IdgE2={0},
    f_ResNp=8,
    f_ResP1={0.05586817,0.498223,0.02458698,0.0008570145,0.0004788584,
             -1.800808,0.2671641,-0.04781652},
    f_ResP2={2,1,3,6,6,1,1,2},
    f_ResP3={-0.5,0,0,0,1.5,1.5,2,2},
    f_ResNb=13,
    f_ResB1={0.01423987,0.3324062,-0.007485907,0.0001017263,-0.5184567,
             -0.08692288,0.2057144,-0.005000457,0.0004603262,-0.003497836,
             0.006995038,-0.01452184,-0.0001285458},
    f_ResB2={5,2,2,4,1,4,1,2,4,1,5,3,10},
    f_ResB3={1,3,5,1,5,5,6,10,10,10,18,22,50},
    f_ResB4={1,1,1,2,2,2,2,2,2,3,3,3,4},
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
  \"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>.
  For detailed information, please checkout <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>.
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
        39.5
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
        370.15
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
end EoS_IIR_P1_395_T233_370;
