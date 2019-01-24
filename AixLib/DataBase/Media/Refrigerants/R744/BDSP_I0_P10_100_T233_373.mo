within AixLib.DataBase.Media.Refrigerants.R744;
record BDSP_I0_P10_100_T233_373
  "Record with fitting coefficients for dew and bubble line"
  extends
    AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition(
    name="Coefficients taken from Göbel",
    p_Z = 7363998.80158045,
    T_Z = 304.050000000000,
    psat_Nt = 3,
    psat_N= {-10.8874701459618,-2.53014476472302,4.85976334934365},
    psat_E= {1.02777903636517, 3.04857880618312, 1.12780675832611},
    Tsat_Nt = 19,
    Tsat_N = {-1.06584203525244e-06,5.77175283129492e-06,-4.6244025542171e-06,-1.55649714573718e-05,-5.67729643824132e-06,7.84687400408321e-05,2.54822197136637e-05,-0.000123533921282085,-0.000337725889546381,0.000675120780717472,-0.000400215031011729,0.00114310539368957,-0.00369132626395774,0.00842457137711057,-0.020714524035119,0.0563877648731632,-0.189436119639029,0.971452596229363,0.200822882160402},
    Tsat_IO = {3445540.85867591,1822725.70538495,268.600000000000,20.5103632342287},
    dl_approach = 16,
    dl_Nt = 12,
    dl_N = {478.968682010804, 495.683257706123, 3543.67960624232, -16584.0906529594, 39329.3130708854, 7445.88449470718, -254232.892949454, 489081.275821062, -51539.65263982,-948816.669406408, 1205337.05384885, -479896.34391407},
    dv_approach = 16,
    dv_Nt = 25,
    dv_N = {462.48836810312,-610.315494915381,-2823.72517117551,16650.8365223046,-49525.3789777128,52571.1979874299,74412.4761984176,-159900.265678589,-119473.839067579,203760.826571182,280692.836303772,40256.3509590889,-336116.042618752,-570463.466661569,-382871.321141713,211234.622165815,1120586.29646474,2579594.67174698,-856309.127058874,-1480616.80660559,-1952678.05291741,-1966218.66650212,-1411789.30657025,204923.572495633,7059952.78039912},
    hl_approach = 1,
    hl_Nt = 5,
    hl_N = {194327.316977888, -0.769139700781037,0.460882432656297, 0.22272419609671, 0.141897620188616, 0.0519530578466151},
    hl_E = {0.722830089188778, -0.0152191856879518, 3.00703720797531, 50.6995880180848, 9.69794921193602},
    h_IIR_I0 = 505.8414680723884e+03,
    hv_approach = 16,
    hv_Nt = 29,
    hv_N= {333020.719819463, 87137.700738337, 128074.858979777, 15856.5163122911, -825356.778644089, 1438792.78172267, -133857.617994352, -902180.017600717, -812539.662160855, 685305.621672549, 689783.232726976, 1027396.02629172, -527730.424281767, -228779.518490116, -842117.608572627, -1110850.40019966, 165936.295201719, -381364.657497601, 1065824.60373945, 2128788.40782349, 577593.240467662, 1278047.43879684, -1222329.61991827, -3539546.26251493, -3243680.19253677, -168642.585698017, 4210620.55406797, 6052566.3465585, -5526855.61850467},
    hv_IO = {1},
    sl_approach= 1,
    sl_Nt = 4,
    sl_N = {971.502865291826,0.332362265133049,-0.53827965447008,0.0376198585567208,0.146071000768772},
    sl_E = {-0.0157738143026104,0.710529444013852,10.3660660062362,3.14098135792114},
    s_IIR_I0 = 2.736808957627727E3,
    sv_approach = 1,
    sv_Nt = 4,
    sv_N= {1852.51697191582, -0.104686424493378, -0.231351021595994, 0.350507795905541, -0.0111283896749802},
    sv_E= {1.91767692218586, -0.00970758719031325, 0.456797862631896, 8.11458177168435});

       annotation (Documentation(revisions="<html>
<ul>
  <li>
  January 08, 2019, by Stephan Göbel, Christian Vering:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/665\">issue 665</a>).
  </li>
</ul>
</html>", info="<html>
<p>
In this record, fitting coefficients are provided for thermodynamic properties
at bubble and dew line. For detailed information of these thermodynamic
properties as well as the fitting coefficients in general, please checkout
<a href=\"modelica://AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition\">
AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition
</a>.
The fitting coefficients are used in a hybrid refrigerant model provided in
<a href=\"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>.
For detailed information, please checkout
<a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>.
</p>
<h4>Assumptions and limitations</h4>
<p>
The provided coefficients are fitted to external data by Engelpracht and are
valid within the following range<br />
</p>
<table summary=\"Range of validiry\" cellspacing=\"0\" cellpadding=\"2\"
border=\"1\" width=\"30%\" style=\"border-collapse:collapse;\">
<tr>
  <td><p>Parameter</p></td>
  <td><p>Minimum Value</p></td>
  <td><p>Maximum Value</p></td>
</tr>
<tr>
  <td><p>Pressure (p) in bar</p></td>
  <td><p>10</p></td>
  <td><p>100</p></td>
</tr>
<tr>
  <td><p>Temperature (T) in K</p></td>
  <td><p>233.15</p></td>
  <td><p>373.15</p></td>
</tr>
</table>
<p>
The reference point is defined as 0 kJ/kg and 0 kJ/kg/K, respectively, for
enthalpy and entropy at 298.15 K and 1.01325 barm resoectively.
</p>
<h4>References</h4>
<p>
Göbel, Stephan (2019): Automated simulation model evaluation for refrigerant circuits. 
<i>Master Thesis</i>
</p>
</html>"));

end BDSP_I0_P10_100_T233_373;
