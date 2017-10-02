within AixLib.DataBase.Media.Refrigerants;
package R290 "Package provides records for R290"
  extends Modelica.Icons.VariantsPackage;



  record EoS_IIR_P05_30_T263_343
    "Record with fitting coefficients taken from the Fast_Propane model"
    import AixLib;
    extends
      AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition(
      name="Coefficients taken from Fast_Propane model developed by Sangi et al.",
      alpha_0_nL=1,
      alpha_0_l1={3},
      alpha_0_l2={1},
      alpha_0_nP=2,
      alpha_0_p1={-4.970583,4.29352},
      alpha_0_p2={0,1},
      alpha_0_nE=4,
      alpha_0_e1={3.043,5.874,9.337,7.922},
      alpha_0_e2={1.062478,3.344237,5.363757,11.762957},
      alpha_r_nP=5,
      alpha_r_p1={0.042910051,1.7313671,-2.4516524,0.34157466,-0.46047898},
      alpha_r_p2={4,1,1,2,2},
      alpha_r_p3={1,0.33,0.8,0.43,0.9},
      alpha_r_nB=6,
      alpha_r_b1={-0.66847295,0.20889705,0.19421381,-0.22917851,-0.60405866,0.066680654},
      alpha_r_b2={1,3,6,6,2,3},
      alpha_r_b3={2.46,2.09,0.88,1.09,3.25,4.62},
      alpha_r_b4={1,1,1,1,2,2},
      alpha_r_nG=7,
      alpha_r_g1={0.017534618,0.33874242,0.22228777,-0.23219062,-0.09220694,-0.47575718,-0.017486824},
      alpha_r_g2={1,1,1,2,2,4,1},
      alpha_r_g3={0.76,2.5,2.75,3.05,2.55,8.4,6.75},
      alpha_r_g4={0.963,1.977,1.917,2.307,2.546,3.28,14.6},
      alpha_r_g5={1.283,0.6936,0.788,0.473,0.8577,0.271,0.948},
      alpha_r_g6={2.33,3.47,3.15,3.19,0.92,18.8,547.8},
      alpha_r_g7={0.684,0.829,1.419,0.817,1.5,1.426,1.093});
    annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 10, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",   info="<html>
<p>In this record, fitting coefficients are provided for the Helmholtz equation of state (EoS). For detailed information of the EoS as well as the fitting coefficients, please checkout <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition\">AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition</a>. The fitting coefficients are used in a hybrid refrigerant model provided in <a href=\"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>. For detailed information, please checkout <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>.</p>
<p><b>Assumptions and limitations</b></p>
<p>The provided coefficients are fitted to external data by Sangi et al. and are valid within the following range:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"30%\"><tr>
<td><p>Parameter</p></td>
<td><p>Minimum Value</p></td>
<td><p>Maximum Value</p></td>
</tr>
<tr>
<td><p>Pressure (p) in bar</p></td>
<td><p>0.5</p></td>
<td><p>30</p></td>
</tr>
<tr>
<td><p>Temperature (T) in K</p></td>
<td><p>263.15</p></td>
<td><p>343.15</p></td>
</tr>
</table>
<p>The reference point is defined as 200 kJ/kg and 1 kJ/kg/K, respectively, for enthalpy and entropy for the saturated liquid at 273.15 K.</p>
<p><b>References</b></p>
<p>Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita; M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275</p>
</html>"));
  end EoS_IIR_P05_30_T263_343;

  record BDSP_IIR_P05_30_T263_343
    "Record with fitting coefficients taken from the Fast_Propane model"
    import AixLib;
    extends
      AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition(
      name="Coefficients taken from Fast_Propane model developed by Sangi et al.",
      saturationPressure_nT=5,
      saturationPressure_n={-6.7722, 1.6938, -1.3341, -3.1876, 0.94937},
      saturationPressure_e={1, 1.5, 2.2, 4.8, 6.5},
      saturationTemperature_nT=36,
      saturationTemperature_n={398148862.940126, -199919955.396472, -757908233.955288, 367952699.725659, 667046798.608578, -312549990.204649, -357938868.07772, 161410013.061604, 130510724.837043, -56445981.8598188, -34132767.2831829, 14097753.337877, 6597033.14683305, -2588996.07334184, -956016.453555908, 354129.363109993, 104671.21653575, -36365.4299997343, -8551.71765339857, 2737.41277992834, 548.032269738263, -169.618396241937, -14.0609083306686, -0.171965430903563, 5.1496074119545, -3.2101839991522, 2.10314346387695, -1.50075370184942, 1.08909694031671, -0.809987090417357, 0.624647765942656, -0.509758482228388, 0.452113517399419, -0.485252422559269, 0.812915722176255, 0.049784532},
      saturationTemperature_iO={1570581.06473046, 2557900, 314.714456959068, 89.9988984287752},
      bubbleDensity_nT=27,
      bubbleDensity_n={168.562039493205, 102.498679842295, -417.252850518645, -379.369839448631, 259.875445333347, 360.650888848736, -34.286073230572, -167.388526468939, -38.3089822429208, 32.2321439731247, 16.240179568742, -1.02099838936652, -2.73648898021723, -1.28146729979824, -0.699142505344287, -0.486571806528472, -0.362711228684454, -0.295698328266597, -0.257687633710071, -0.232292001969948, -0.214228995994567, -0.20556940574841, -0.209973677149465, -0.241754621811309, -0.31988094531161, -0.921191170759037, 0.0299586382685047},
      bubbleDensity_iO={303.15, 90, 479.63605641964, 158.710809951891},
      dewDensity_nT=30,
      dewDensity_n={24729.5537485333, -4790.47306548912, -52999.2668562323, 7058.92241323013, 52982.2892015502, -2370.58912808463, -31858.637385946, -1861.34451993193, 12491.6995976091, 2253.53926320725, -3122.52067135369, -1051.27601610942, 412.3820502853, 267.637744405501, 12.9822226129711, -27.0147438072994, -10.2971934822874, -0.739113632299647, 1.49114325185849, 1.35527523720564, 0.923630488185071, 0.672792235972464, 0.560751132479985, 0.509690199864535, 0.490192151807828, 0.495282411314377, 0.590898303947074, 0.811832008381672, 0.808375476827012, -0.0754744015174044},
      dewDensity_iO={303.15, 90, 28.4811865500103, 66.6559013317995},
      bubbleEnthalpy_nT=41,
      bubbleEnthalpy_n={-9294767843.63885, 4601044486.87677, 20637884091.3137, -9916466348.59996, -21359403718.5665, 9947264847.89552, 13636958532.2276, -6142679157.11019, -6000574809.17466, 2607836222.80069, 1926833832.78873, -805551262.020446, -466601813.162386, 187005402.363897, 86860131.7909424, -33235234.3082519, -12561996.4230609, 4567071.19402525, 1416354.0638898, -486313.365924655, -124542.594195178, 40167.0083231862, 8397.46595050577, -2498.28167363608, -462.619336965067, 137.536958919031, 6.47029425217843, 2.64758244293881, -5.32098880051055, 3.46672373461629, -2.26302221729487, 1.59069973995372, -1.13913175345066, 0.832473481266347, -0.610337601733258, 0.487787294421858, -0.381084129429948, 0.372237411342447, -0.34966667159822, 0.849926390294104, 0.0361438659731507},
      bubbleEnthalpy_iO={1570581.06473046, 2557900, 315624.984387066, 256478.426329608},
      dewEnthalpy_nT=41,
      dewEnthalpy_n={-18775386313.6055, 9394086287.20505, 41644196829.4943, -20247895189.1885, -43051291028.3205, 20309540510.172, 27452478313.3802, -12538264110.1784, -12063991762.716, 5319760814.06607, 3868950611.13826, -1641348684.22018, -936106557.039505, 380310593.940752, 174364505.252102, -67425029.5319391, -25335355.2373842, 9258056.41821587, 2898773.57918601, -997509.402878578, -263711.217390457, 88279.4166642683, 18539.6674822496, -7265.37195240485, -791.349145978091, 783.380077339674, -118.386708715477, -87.4509889200359, 28.7466309562791, 22.7165909170454, -12.9134840899498, 0.37918804346481, -1.09461342269619, 2.21831905224981, -1.37432108544607, 0.840516589045987, -0.879264408088915, 0.602870738214699, -0.988765189667206, 0.73697777870168, 0.0980593948500622},
      dewEnthalpy_iO={1570581.06473046, 2557900, 611770.95439052, 72569.9367503185},
      bubbleEntropy_nT=41,
      bubbleEntropy_n={-15349607814.6221, 7636274154.59154, 34083168950.6415, -16468859514.8044, -35274256182.5208, 16529163595.4961, 22520438414.7263, -10212384678.3319, -9909434496.20396, 4337708567.68782, 3182094478.82347, -1340537038.4187, -770642130.02999, 311344581.740643, 143483390.503767, -55358907.3112437, -20756825.7164981, 7610600.46375838, 2341379.49521742, -810782.536880512, -205991.835180489, 66975.5024566354, 13911.5167143464, -4172.85884728481, -763.056131634308, 226.059931948838, 12.7752539636391, 3.11268958206643, -7.85167676769299, 5.00328992083909, -3.24391515196012, 2.26101216009097, -1.60045805379047, 1.15217954418816, -0.838779616598381, 0.651059130787342, -0.506702271997059, 0.465184273228716, -0.435627195532008, 0.805470640142587, 0.0457609974234471},
      bubbleEntropy_iO={1570581.06473046, 2557900, 1376.30588505819, 826.068105213303},
      dewEntropy_nT=41,
      dewEntropy_n={77490431827.9399, -38415276654.6987, -172242854661.379, 82962121367.1925, 178399484846.286, -83356734431.6106, -113970547248.801, 51553752249.9676, 50177422017.5857, -21921194748.1992, -16120343329.1663, 6783508534.79747, 3904793200.14042, -1578181058.50373, -726577962.8212, 281202937.346275, 104799948.851401, -38715062.2946953, -11716161.8016396, 4105031.67420979, 1007213.05553646, -326165.883627773, -65541.5043152719, 16329.6212516804, 3852.60757433586, 91.0319174951408, -343.494332982509, -224.377993905924, 107.45943824896, 24.4635507698644, -8.50688453256311, -13.0500554559933, 6.58097770859788, -1.42438707828771, 1.58146106221061, -1.50959232991508, 0.66941156982168, -0.759627313555789, -0.113920392204933, -0.624499077638527, -0.00619048868799449},
      dewEntropy_iO={1570581.06473046, 2557900, 2335.75170536325, 97.9077112667096});
    annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 10, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",   info="<html>
<p>In this record, fitting coefficients are provided for thermodynamic properties at bubble and dew line. For detailed information of these thermodynamic properties as well as the fitting coefficients, please checkout <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition</a>. The fitting coefficients are used in a hybrid refrigerant model provided in <a href=\"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>. For detailed information, please checkout <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>.</p>
<p><b>Assumptions and limitations</b></p>
<p>The provided coefficients are fitted to external data by Sangi et al. and are valid within the following range:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"30%\"><tr>
<td><p>Parameter</p></td>
<td><p>Minimum Value</p></td>
<td><p>Maximum Value</p></td>
</tr>
<tr>
<td><p>Pressure (p) in bar</p></td>
<td><p>0.5</p></td>
<td><p>30</p></td>
</tr>
<tr>
<td><p>Temperature (T) in K</p></td>
<td><p>263.15</p></td>
<td><p>343.15</p></td>
</tr>
</table>
<p>The reference point is defined as 200 kJ/kg and 1 kJ/kg/K, respectively, for enthalpy and entropy for the saturated liquid at 273.15 K.</p>
<p><b>References</b></p>
<p>Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita; M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275</p>
</html>"));
  end BDSP_IIR_P05_30_T263_343;

  record TSP_IIR_P05_30_T263_343
    "Record with fitting coefficients taken from the Fast_Propane model"
    import AixLib;
    extends
      AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition(
      name="Coefficients taken from Fast_Propane model developed by Sangi et al.",
      temperature_ph_nT={5, 5, 21, 5, 5, 21},
      temperature_ph_sc_a={-0.0704729863184529, -0.00678884566695906, 0.000202836611783306, -9.71248676197528e-06, 7.98267274869292e-07},
      temperature_ph_sc_b={20.5578417380748, -0.770247506716285, -0.038647246926071, -0.00751600683912493, -0.0016300055996751},
      temperature_ph_sc_c={-1.12691051342428e-05, 0.000273729410002939, 0.000134930636679386, -0.0044760279738207, -0.00177519423682889, -0.000392485634748443, 0.136811720776647, 0.0309332207143316, 0.00767135438646387, 0.00140205757787774},
      temperature_ph_sc_d={291.384236041825},
      temperature_ph_sh_a={6.59039876392094, 0.0453108439023189, 0.00540769150996739, -0.000196566506959251, -4.64422678045603e-05},
      temperature_ph_sh_b={20.795024314138, -0.411365889418558, -0.00497446957449581, 0.0046513295424428, -0.000577281104194347},
      temperature_ph_sh_c={0.000787074643540945, -0.00847992074678385, 0.00281445602040784, -0.0188305448625778, 0.00660309588666398, -0.00176606807260317, -1.43969687581506, 0.255977908649908, -0.0432200997543392, 0.00590025752789791},
      temperature_ph_sh_d={308.060027778396},
      temperature_ph_iO={1682457.5126701,720642.233056887, 247137.397786416, 54003.5903158973, 0, 1, 382099.574228781, 403596.556578661, 639399.497939419, 37200.2691858212, 0, 1},
      temperature_ps_nT={5, 5, 21, 5, 5, 21},
      temperature_ps_sc_a={0.490828546245446, 0.117871744016533, 0.0181671755438826, 0.00191602988674819, 0.00011497599662102},
      temperature_ps_sc_b={19.8608752914032, -0.040817223566116, -0.0857625427384498, -0.0124017661200968, -0.00192723964571896},
      temperature_ps_sc_c={0.000243666235393007, 0.0037715016370504, 0.000459514035453056, 0.0292848788419663, 0.00622225803519055, 0.00090717580273224, 0.130154107880201, 0.0324083687227166, 0.00799217399325639, 0.00127247920370296},
      temperature_ps_sc_d={290.574168937952},
      temperature_ps_sh_a={34.3546579581206, 0.95682930429454, 0.129780738468536, 0.0577060502424694, 0.0132124973316544},
      temperature_ps_sh_b={36.3220486736092, 0.702977715170277, -0.100508863694088, 0.0160903628800248, -0.00049456983306658},
      temperature_ps_sh_c={-0.00720862103838031, -0.0264862744961215, 0.00736011556482272, -0.30336257516708, 0.0826586807740864, -0.00773556171071259, 0.23922945375389, 0.00081428356388169, -0.00125351482775024, 0.0036583657279175},
      temperature_ps_sh_d={305.667994209752},
      temperature_ps_iO={14.2251890031606,0.499169296800688, 1152.46506841802, 179.299713840403, 0, 1, 12.3876547448383, 0.961902709412239, 2715.6535956075, 207.473158311391, 0, 1},
      density_pT_nT={5, 5, 21, 5, 5, 21},
      density_pT_sc_a={1.8705425621798, -0.0351624357762205, 0.00126962771607607, 7.69903677841526e-06, 1.34663813731525e-05},
      density_pT_sc_b={-29.9062841232497, -2.21393734916457, -0.419234944193293, -0.104815271970145, -0.0227711391125435},
      density_pT_sc_c={1.90380071619604e-06, 0.00219916470789359, 0.00117322708291575, -0.0298496253585084, -0.0156164603769147, -0.00424731659901982, 0.693501535440458, 0.222243208624831, 0.0699901864638379, 0.0141806356166424},
      density_pT_sc_d={506.208387981876},
      density_pT_sh_a={7.85762798977443, 0.561456406237816, 0.0745135118619033, 0.0141066470211284, 0.00292620516208197},
      density_pT_sh_b={-0.618509525341628, 0.0644646531072409, -0.00894774750115025, 0.00116677386847406, -2.13433530006928e-05},
      density_pT_sh_c={-0.01655069884562, -0.0614336770277778, 0.0269207717408464, -0.227438027200113, 0.0715858695051831, -0.0137994983041971, -0.827135398454184, 0.113487112138254, -0.021065201099773, 0.00162333280148309},
      density_pT_sh_d={6.99012116216078},
      density_pT_iO={1682457.5126701,720642.233056887, 290.645659315997, 19.9347318052857, 0, 1, 382099.574228781, 403596.556578661, 307.564799259815, 22.5879133275781, 0, 1});
      annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 10, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",   info="<html>
<p>In this record, fitting coefficients are provided for thermodynamic properties calculated from two independent state variables. For detailed information of these thermodynamic properties as well as the fitting coefficients, please checkout <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition</a>. The fitting coefficients are used in a hybrid refrigerant model provided in <a href=\"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>. For detailed information, please checkout <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>.</p>
<p><b>Assumptions and limitations</b></p>
<p>The provided coefficients are fitted to external data by Sangi et al. and are valid within the following range:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"30%\"><tr>
<td><p>Parameter</p></td>
<td><p>Minimum Value</p></td>
<td><p>Maximum Value</p></td>
</tr>
<tr>
<td><p>Pressure (p) in bar</p></td>
<td><p>0.5</p></td>
<td><p>30</p></td>
</tr>
<tr>
<td><p>Temperature (T) in K</p></td>
<td><p>263.15</p></td>
<td><p>343.15</p></td>
</tr>
</table>
<p>The reference point is defined as 200 kJ/kg and 1 kJ/kg/K, respectively, for enthalpy and entropy for the saturated liquid at 273.15 K.</p>
<p><b>References</b></p>
<p>Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita; M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275</p>
</html>"));
  end TSP_IIR_P05_30_T263_343;
  annotation (Documentation(info="<html>
<p>This package provides records with fitting coefficients for the refrigerant R290. The records are inherited from the base data definitions provided in AixLib.DataBase.Media.Refrigerants and the fitting coefficients are used for the refrigerant model provided in AixLib.Media.Refrigerants.</p>
<p>For detailed information of the <b>base data definitions</b>, please checkout the following records:</p>
<ul>
<li><a href=\"modelica://AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition\">AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition</a></li>
<li><a href=\"modelica://AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition</a></li>
<li><a href=\"modelica://AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition</a></li>
</ul>
<p>For detailed information of the <b>refrigerant models using the fitting coefficients</b>, please checkout the following packages:</p>
<ul>
<li><a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a></li>
<li><a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord</a></li>
</ul>
</html>", revisions="<html>
<ul>
  <li>
  June 10, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end R290;
