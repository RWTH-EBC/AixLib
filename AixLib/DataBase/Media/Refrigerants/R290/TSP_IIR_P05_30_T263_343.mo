within AixLib.DataBase.Media.Refrigerants.R290;
record TSP_IIR_P05_30_T263_343
  "Record with fitting coefficients taken from the Fast_Propane model"

  extends AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition(
    name="Coefficients taken from Fast_Propane model developed by Sangi et al.",
    T_phNt={5, 5,
            21, 5,
            5, 21},
    Tl_phA={-0.0704729863184529, -0.00678884566695906,
            0.000202836611783306, -9.71248676197528e-06,
            7.98267274869292e-07},
    Tl_phB={20.5578417380748, -0.770247506716285,
            -0.038647246926071, -0.00751600683912493,
            -0.0016300055996751},
    Tl_phC={-1.12691051342428e-05, 0.000273729410002939,
            0.000134930636679386, -0.0044760279738207,
            -0.00177519423682889, -0.000392485634748443,
            0.136811720776647, 0.0309332207143316,
            0.00767135438646387, 0.00140205757787774},
    Tl_phD={291.384236041825},
    Tv_phA={6.59039876392094, 0.0453108439023189,
            0.00540769150996739, -0.000196566506959251,
            -4.64422678045603e-05},
    Tv_phB={20.795024314138, -0.411365889418558,
            -0.00497446957449581, 0.0046513295424428,
            -0.000577281104194347},
    Tv_phC={0.000787074643540945, -0.00847992074678385,
            0.00281445602040784, -0.0188305448625778,
            0.00660309588666398, -0.00176606807260317,
            -1.43969687581506, 0.255977908649908,
            -0.0432200997543392, 0.00590025752789791},
    Tv_phD={308.060027778396},
    T_phIO={1682457.5126701, 720642.233056887,
             247137.397786416, 54003.5903158973,
             0, 1, 382099.574228781, 403596.556578661,
             639399.497939419, 37200.2691858212,
             0, 1},
    T_psNt={5, 5,
            21, 5,
            5, 21},
    Tl_psA={0.490828546245446, 0.117871744016533,
            0.0181671755438826, 0.00191602988674819,
            0.00011497599662102},
    Tl_psB={19.8608752914032, -0.040817223566116,
            -0.0857625427384498, -0.0124017661200968,
            -0.00192723964571896},
    Tl_psC={0.000243666235393007, 0.0037715016370504,
            0.000459514035453056, 0.0292848788419663,
            0.00622225803519055, 0.00090717580273224,
            0.130154107880201, 0.0324083687227166,
            0.00799217399325639, 0.00127247920370296},
    Tl_psD={290.574168937952},
    Tv_psA={34.3546579581206, 0.95682930429454,
            0.129780738468536, 0.0577060502424694,
            0.0132124973316544},
    Tv_psB={36.3220486736092, 0.702977715170277,
            -0.100508863694088, 0.0160903628800248,
            -0.00049456983306658},
    Tv_psC={-0.00720862103838031, -0.0264862744961215,
            0.00736011556482272, -0.30336257516708,
            0.0826586807740864, -0.00773556171071259,
            0.23922945375389, 0.00081428356388169,
            -0.00125351482775024, 0.0036583657279175},
    Tv_psD={305.667994209752},
    T_psIO={14.2251890031606,0.499169296800688,
            1152.46506841802, 179.299713840403,
            0, 1,
            12.3876547448383, 0.961902709412239,
            2715.6535956075, 207.473158311391,
            0, 1},
    d_pTNt={5, 5,
            21, 5,
            5, 21},
    dl_pTA={1.8705425621798, -0.0351624357762205,
            0.00126962771607607, 7.69903677841526e-06,
            1.34663813731525e-05},
    dl_pTB={-29.9062841232497, -2.21393734916457,
            -0.419234944193293, -0.104815271970145,
            -0.0227711391125435},
    dl_pTC={1.90380071619604e-06, 0.00219916470789359,
            0.00117322708291575, -0.0298496253585084,
            -0.0156164603769147, -0.00424731659901982,
            0.693501535440458, 0.222243208624831,
            0.0699901864638379, 0.0141806356166424},
    dl_pTD={506.208387981876},
    dv_pTA={7.85762798977443, 0.561456406237816,
            0.0745135118619033, 0.0141066470211284,
            0.00292620516208197},
    dv_pTB={-0.618509525341628, 0.0644646531072409,
            -0.00894774750115025, 0.00116677386847406,
            -2.13433530006928e-05},
    dv_pTC={-0.01655069884562, -0.0614336770277778,
            0.0269207717408464, -0.227438027200113,
            0.0715858695051831, -0.0137994983041971,
            -0.827135398454184, 0.113487112138254,
            -0.021065201099773, 0.00162333280148309},
    dv_pTD={6.99012116216078},
    d_pTIO={1682457.5126701, 720642.233056887,
            290.645659315997, 19.9347318052857,
            0, 1,
            382099.574228781, 403596.556578661,
            307.564799259815, 22.5879133275781,
            0, 1});
    annotation (Documentation(revisions="<html><ul>
  <li>June 10, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  In this record, fitting coefficients are provided for thermodynamic
  properties calculated from two independent state variables. For
  detailed information of these thermodynamic properties as well as the
  fitting coefficients, please checkout <a href=
  \"modelica://AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition\">
  AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition</a>
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
end TSP_IIR_P05_30_T263_343;
