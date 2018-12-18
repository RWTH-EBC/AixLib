within AixLib.DataBase.CHP;
package CHPDataSimple
  record CHPBaseDataDefinition "Basic CHP data"
  extends Modelica.Icons.Record;

    import SI = Modelica.SIunits;

    parameter SI.Volume vol[:] "Water volume of CHP";
    parameter Real data_CHP[:,5];
            //Matrix contains : [capacity [Percent], electrical power [kW], total heat recovery [kW], fuel input [kW], fuel consumption [m3/h]]
    parameter SI.Temperature maxTFlow "Maximum flow temperature";
    parameter SI.Temperature maxTReturn "Maximum return temperature";
    parameter SI.Length DPipe "Outlet pipe diameter";

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Base data record for combined heat and power generators (CHP). </p>
</html>", revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>June 27, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and
formatted appropriately</li>
</ul>
</html>"));
  end CHPBaseDataDefinition;

  record CHP_Cleanergy_C9G
    "Cleanergy: mini BHKW C9G (8-25 kW thermal, Stirling engine for low caloric gas)"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={4.2e-3},
      data_CHP=[0, 0,    0,      0,    0;
               24, 2.00, 7.18,  11.76, 1.31;
               30, 2.70, 9.27,  14.59, 1.62;
               35, 3.20, 10.32, 16.00, 1.78;
               40, 3.75, 11.61, 17.86, 1.98;
               50, 4.60, 13.60, 20.44, 2.27;
               60, 5.60, 16.80, 24.35, 2.71;
               70, 6.50, 18.69, 27.08, 3.01;
               80, 7.40, 20.99, 30.20, 3.36;
               90, 8.15, 23.29, 33.27, 3.70;
              100, 8.90, 25.61, 36.33, 4.04],
      maxTFlow=353.15,
      maxTReturn=343.15,
      DPipe=0.08);
      /*
    Minimum modulation limit is unknown and set to the same value as for Vaillant
    eco power 5.

    Total efficiency at lower modulation limt is unknown and set arbitrarily to
    90 percent.
    Total efficiency at design power is unknown (but assuming the data sheet
     value
    is for the design condition): 93 percent.

    The CHP works with a range of gases: natural gas (all qualities), propane,
    butane.
    The last column fuel consumption in m3/h can be set accordingly if needed.
    Here high grade natural gas (11 .. 12 kWh/m3) is used.

    */
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Cleanergy mini-BHKW C9G (low caloric gas) </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The electrical and thermal powers are in kW. The &quot;fuel input&quot; is in
kW. The fuel consumption is in m&sup3;/h.</p>
<p>The calorific value of natural gas is assumed to be 11.5 kWh/m&sup3;
(10 - 12 kWh/m&sup3;). </p>
<h4><span style=\"color:#008000\">Data Sheet (English, German)</span></h4>
<table summary=\"Data Sheet\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tr>
<td valign=\"top\"><p>Max. noise level dB(A)</p></td>
<td valign=\"top\"><p>49</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Dimensions (L x W x H) cm</p></td>
<td valign=\"top\"><p>14.5 x 70 x 100</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Floor area m<sup>2</sup></p></td>
<td valign=\"top\"><p>0.70</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Weight kg</p></td>
<td valign=\"top\"><p>470</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Service interval hours</p></td>
<td valign=\"top\"><p>10,000</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Fuels: natural gas (all qualities), mainly designed for
low caloric gas (bio gas) </p></td>
<td valign=\"top\"><p>yes</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Electrical output (modulating) kW</p></td>
<td valign=\"top\"><p>2 - 9</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Thermal output kW</p></td>
<td valign=\"top\"><p>8 - 25</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Power consumption (gas) kW</p></td>
<td valign=\"top\"><p>~36</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Electrical efficiency </p></td>
<td valign=\"top\"><p>21 &#37; (24&#37; capacity), 24 &#37;
(80&#37; capacity)</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Thermal efficiency excluding optional condenser</p></td>
<td valign=\"top\"><p>58 &#37; (24&#37; capacity), 70 &#37;
(80&#37; capacity)</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Total efficiency excluding optional condenser</p></td>
<td valign=\"top\"><p>79 &#37; (24&#37; capacity), 94 &#37;
(80&#37; capacity)</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Flow temperature (constant) &deg;C</p></td>
<td valign=\"top\"><p>60 &ndash; 65 (optimal: 50 &deg;C)</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Max. return temperature (variable) &deg;C</p></td>
<td valign=\"top\"><p>50 (TRmin = 30 &deg;C)</p></td>
</tr>
</table>
<p><br/>
<br/>
<b>The CHP engine is not designed for continuous operation at more
than 80&#37; load (7.2 kW).</b> Continuous use at higher load than 80&#37;
decreases the time between services.</p>
<p>For low methane applications, the C9G LowCal is capped to 120 bar engine
pressure being equivalent to 7.2 kW.</p>
<p>Source:</p>
<ul>
<li>URL: <a href=\"http://www.ecpower.eu/deutsch/xrgi/technische-daten/xrgir-9.html\">www.ecpower.eu/xrgir-9.html</a></li>
</ul>
</html>", revisions="<html>
<ul>
<li><i>January 24, 2013</i> by Peter Matthes:<br/>
implemented</li>
</ul>
</html>"));
  end CHP_Cleanergy_C9G;

  record CHP_FMB_1500_GSMK "FMB-1500-GSMK : Guascor"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={56.0e-3},
      data_CHP=[0,0,0,0,0; 50,600,777,1599,159.5; 75,900,1046,2252,224.4; 100,
          1200,1315,2916,290.9],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.2);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-1500-GSMK </p>
</html>", revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_FMB_1500_GSMK;

  record CHP_FMB_155_GSK "FMB-155-GSK : Schmitt Enertec"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={11.97e-3},
      data_CHP=[0,0,0,0,0; 50,61,129,213,21.2; 75,92,166,283,28.3; 100,122,196,
          348,34.7],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.13);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-155-GSK </p>
</html>", revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_FMB_155_GSK;

  record CHP_FMB_2500_GSMK "FMB-2500-GSMK : Cummins"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={91.6e-3},
      data_CHP=[0,0,0,0,0; 50,1000,1250,2760,249.1; 75,1500,1648,3809,343.8; 100,
          2000,2164,4900,422.2],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.3);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-2500-GSMK </p>
</html>", revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_FMB_2500_GSMK;

  record CHP_FMB_270_GSMK "FMB-270-GSMK : Schmitt Enertec"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={15.08e-3},
      data_CHP=[0,0,0,0,0; 50,110,173,323,32.2; 75,165,247,460,45.9; 100,220,307,
          590,58.9],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.13);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-270-GSMK </p>
</html>", revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_FMB_270_GSMK;

  record CHP_FMB_31_GSK "FMB-31-GSK : Schmitt Enertec"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={3e-3},
      data_CHP=[0,0,0,0,0; 50,13,25,44,4.4; 75,20,35,62,6.2; 100,26,46,81,8.1],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.08);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-31-GSK </p>
</html>", revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_FMB_31_GSK;

  record CHP_FMB_410_GSMK "FMB-410-GSMK : Schmitt Enertec"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={22.6e-3},
      data_CHP=[0,0,0,0,0; 50,167,269,491,49.0; 75,251,376,703,70.2; 100,334,485,
          913,91.1],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.13);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-410-GSMK </p>
</html>", revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_FMB_410_GSMK;

  record CHP_FMB_65_GSK "FMB-65-GSK : Schmitt Enertec"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={4.5e-3},
      data_CHP=[0,0,0,0,0; 50,25,52,88,8.8; 75,38,75,128,12.8; 100,50,82,150,15.0],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.08);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-65-GSK </p>
</html>", revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_FMB_65_GSK;

  record CHP_FMB_750_GSMK "FMB-750-GSMK : Guascor"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={36.0e-3},
      data_CHP=[0,0,0,0,0; 50,305,408,860,85.8; 75,457,583,1196,119.3; 100,609,
          731,1559,155.6],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.16);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Natural Gas CHP: Schmitt Enertec GmbH FMB-750-GSMK </p>
</html>", revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_FMB_750_GSMK;

  record CHP_GG_113 "GG 113 : Sokratherm"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={3e-3},
      data_CHP=[0,0,0,0,0; 50,55,110,189,18.9; 75,84,148,263,26.3; 100,113,180,
          328,32.8],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.1);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Sokratherm BHKW GG 113 </p>
</html>", revisions="<html>
<ul>
<li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_GG_113;

  record CHP_GG_50 "GG 50 : Sokratherm"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={3e-3},
      data_CHP=[0,0,0,0,0; 50,24,54,91,9.1; 75,37,68,118,11.8; 100,50,82,146,14.6],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.08);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Sokratherm BHKW GG 50 </p>
</html>", revisions="<html>
<ul>
<li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_GG_50;

  record CHP_GG_70 "GG 70 : Sokratherm"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={3e-3},
      data_CHP=[0,0,0,0,0; 50,34,69,122,12.2; 75,52,88,159,15.9; 100,70,114,204,
          20.4],
      maxTFlow=363.15,
      maxTReturn=343.15,
      DPipe=0.1);

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Sokratherm BHKW GG 70 </p>
</html>", revisions="<html>
<ul>
<li><i>August 13, 2013&nbsp;</i> by Ole Odendahl:<br/>Added reference</li>
</ul>
</html>"));
  end CHP_GG_70;

  record CHP_XRGI_9kWel "Eco Power: mini BHKW XRGI 9 (12-20 kW thermal)"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={3e-3},
      data_CHP=[0,   0,   0,           0,   0;
               39,   4,  12, (12+4)/0.90,  (12+4)/0.90/11.5;
              100,   9,  20, (20+9)/0.93,  (20+9)/0.93/11.5],
      maxTFlow=353.15,
      maxTReturn=343.15,
      DPipe=0.08);
      /*
    Minimum modulation limit is unknown and set to the same value as for
    Vaillant eco power 5.

    Total efficiency at lower modulation limt is unknown and set arbitrarily to
    90 percent.
    Total efficiency at design power is unknown (but assuming the data sheet value
    is for the design condition): 93 percent.

    The CHP works with a range of gases: natural gas (all qualities), propane,
    butane.
    The last column fuel consumption in m3/h can be set accordingly if needed.
    Here high grade natural gas (11 .. 12 kWh/m3) is used.
    */
    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>EC Power mini-BHKW XRGI 9 (Natural Gas) </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The electrical and thermal powers are in kW. The fuel input is in
kW. The fuel consumption is in m&sup3;/h.</p>
<p>The calorific value of natural gas is assumed to be 11.5 kWh/m&sup3;
(10 - 12 kWh/m&sup3;). </p>
<h4><span style=\"color:#008000\">Data Sheet (English, German)</span></h4>
<table summary=\"Data Sheet\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tr>
<td valign=\"top\"><p>Max. noise level dB(A)</p></td>
<td valign=\"top\"><p>49</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Dimensions (L x W x H) cm</p></td>
<td valign=\"top\"><p>92 x 64 x 96</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Floor area m<sup>2</sup></p></td>
<td valign=\"top\"><p>0.59</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Weight kg</
p></td>
<td valign=\"top\"><p>440</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Service interval hours</p></td>
<td valign=\"top\"><p>10,000</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Fuels: natural gas (all qualities), propane, butane </p></td>
<td valign=\"top\"><p>yes</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Electrical output (modulating) kW</p></td>
<td valign=\"top\"><p>4 - 9</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Thermal output kW</p></td>
<td valign=\"top\"><p>12 - 20</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Power consumption (gas) kW</p></td>
<td valign=\"top\"><p>31</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Electrical efficiency </p></td>
<td valign=\"top\"><p>29.5 &#37;</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Thermal efficiency excluding optional condenser</p></td>
<td valign=\"top\"><p>63.5 &#37;</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Total efficiency excluding optional condenser</p></td>
<td valign=\"top\"><p>93 &#37;</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Flow temperature (constant) &deg;C</p></td>
<td valign=\"top\"><p>80 &ndash; 85</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Max. return temperature (variable) &deg;C</p></td>
<td valign=\"top\"><p>5 &ndash; 75</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Maximum exhaust gas temperature &deg;C</p></td>
<td valign=\"top\"><p>100</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Emissions mg/Nm<sup>3</sup></p></td>
<td valign=\"top\"><p>CO: &#60; 50</p><p>NO<sub>X</sub>: &#60; 100</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Primary energy saving PES (EU Directive, verification in
accordance with DIN 4709)</p></td>
<td valign=\"top\"><p>22.4 &#37;</p></td>
</tr>
</table>
<table summary=\"Emmisions\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\"><tr>
<td valign=\"top\"><p>Emission</p></td>
<td valign=\"top\"><p>&#60; &frac12; TA Luft</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Prim&auml;renergieeinsparung PEE (EU-Richtlinie,
Pr&uuml;fung nach DIN 4709) </p></td>
<td valign=\"top\"><p>22,4 &#37;</p></td>
</tr>
<tr>
<td valign=\"top\"><p>Prim&auml;renergiefaktor fp (EnEV 2009, EN15326)</p></td>
<td valign=\"top\"><p>0,53</p></td>
</tr>
</table>
<p>Source:</p>
<ul>
<li>URL: <a href=\"http://www.ecpower.eu/deutsch/xrgi/technische-daten/xrgir-9.html\">www.ecpower.eu/xrgir-9.html</a></li>
</ul>
</html>", revisions="<html>
<ul>
<li><i>January 24, 2013</i> by Peter Matthes:<br/>implemented</li>
</ul>
</html>"));
  end CHP_XRGI_9kWel;

  record CHP_mikro_ECO_POWER_1 "Vaillant mikro CHP ecoPOWER 1.0"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={3e-3},
      data_CHP=[0,0,0,0,0; 100,1,2.58,2.63,2.63],
      maxTFlow=353.15,
      maxTReturn=343.15,
      DPipe=0.08);
   //Matrix contains : [Capacity, Electrical Power, Total Heat Recovery,Fuel Input, Fuel Consumption]

    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Vaillant mikro-BHKW ecoPOWER 1.0 (Natural Gas) </p>
<h4><font color=\"#008000\">Known Limitations</font></h4>
<p>Electrical output is taken from the manufacturer&apos;s website. The values
for heat output, fuel input and fuel consumption are calculated with the
provided efficiency. They are not given by the manufacturer.</p>
<p>Source:</p>
<ul>
<li>URL:<a href=\"http://www.vaillant.de/Produkte/Kraft-Waerme-Kopplung/Blockheizkraftwerke/produkt_vaillant/mikro-KWK-System_ecoPOWER_1.0.html\">Vaillant Website </a></li>
</ul>
</html>", revisions="<html>
<ul>
<li><i>July 4, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and
formatted appropriately</li>
</ul>
</html>"));
  end CHP_mikro_ECO_POWER_1;

  record CHP_mini_ECO_POWER_3 "Vaillant: mini BHKW eco Power 3 (Natural Gas)"
  extends CHPDataSimple.CHPBaseDataDefinition(
    vol={2.72e-3},
    data_CHP=[0,     0,     0,     0,     0;
             58,  1.76,  4.7,  7.8624,  54.4;
             100,    3,    8, 13.3488,  92.6],
    maxTFlow=348.15,
    maxTReturn=338.15,
    DPipe=0.08);
  /* the el. and thermal powers are in KW. The fuel input is in kW. The fuel
consumption is in l/kWh.
 the calorific value of liquid gas is assumed 28 kWh/m^3.
 and the calorific value of natural gas is assumed 12 kWh/m^3.
*/
  annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Vaillant mini-BHKW ecoPOWER 3.0 (Natural Gas) </p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>The electrical and thermal powers are in kW. The fuel mass flow is in l/s.
The fuel consumption is in l/kWh.</p>
<p>The calorific value of liquid gas is assumed to be 28 kWh/m&sup3; and the
calorific value of natural gas is assumed to be 12 kWh/m&sup3;. </p>
<p>Source:</p>
<ul>
<li>URL: <a href=\"http://www.vaillant.de/Produkte/Kraft-Waerme-Kopplung/Blockheizkraftwerke/produkt_vaillant/mini-KWK-System_ecoPOWER_3.0_und_4.7.html\">mini-KWK-System_ecoPOWER_3.0_und_4.7.html</a></li>
<li>URL: <a href=\"http://www.vaillant.de/stepone2/data/downloads/21/4b/00/Prospekt-KWK.pdf\">Prospekt-KWK.pdf</a></li>
</ul>
</html>",
        revisions="<html>
<ul>
<li><i>January 24, 2013</i> by Peter Matthes:<br/>implemented</li>
</ul>
</html>"));
  end CHP_mini_ECO_POWER_3;

  record CHP_mini_ECO_POWER_3_LiquidGas
    "Vaillant: mini BHKW eco Power 3 (Liquid gas)"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={2.72e-3},
      data_CHP=[0,  0,  0,  0,  0;
               65,  1.95,  5.2,  0.09,  25.8;
               100,  3,  8,  0.132,  39.7],
      maxTFlow=348.15,
      maxTReturn=338.15,
      DPipe=0.08);
  /* the el. and thermal powers are in KW. The fuel mass flow is in l/s. The fuel
consumption is in l/kWh.
 the calorific value of liquid gas is assumed 28 kWh/m^3.
 and the calorific value of natural gas is assumed 12 kWh/m^3.
*/
    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Vaillant mini-BHKW ecoPOWER 3.0 (Liquid Gas) </p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>The electrical and thermal powers are in kW. The fuel mass flow is in l/s.
The fuel consumption is in l/kWh.</p>
<p>The calorific value of liquid gas is assumed to be 28 kWh/m&sup3; and the
calorific value of natural gas is assumed to be 12 kWh/m&sup3;. </p>
<p>Source:</p>
<ul>
<li>URL: <a href=\"http://www.vaillant.de/Produkte/Kraft-Waerme-Kopplung/Blockheizkraftwerke/produkt_vaillant/mini-KWK-System_ecoPOWER_3.0_und_4.7.html\">mini-KWK-System_ecoPOWER_3.0_und_4.7.html</a></li>
<li>URL: <a href=\"http://www.vaillant.de/stepone2/data/downloads/21/4b/00/Prospekt-KWK.pdf\">Prospekt-KWK.pdf</a></li>
</ul>
</html>", revisions="<html>
<ul>
<li><i>January 24, 2013</i> by Peter Matthes:<br/>implemented</li>
</ul>
</html>"));
  end CHP_mini_ECO_POWER_3_LiquidGas;

  record CHP_mini_ECO_POWER_5 "Vaillant: mini BHKW eco Power 4.7 (Natural Gas)"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={2.72e-3},
      data_CHP=[0,    0,     0,     0,     0;
               39,    1.77,  4.7,   0.172,  36.1;
               100,   4.7,   12.5,  0.442,  92.5],
      maxTFlow=348.15,
      maxTReturn=338.15,
      DPipe=0.08);
  /* the el. and thermal powers are in KW. The fuel mass flow is in l/s. The fuel
consumption is in l/kWh.
 the calorific value of liquid gas is assumed 28 kWh/m^3.
 and the calorific value of natural gas is assumed 12 kWh/m^3.
*/
    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Vaillant mini-BHKW ecoPOWER 4.7 (Natural Gas) </p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>The electrical and thermal powers are in kW. The fuel mass flow is in l/s.
The fuel consumption is in l/kWh.</p>
<p>The calorific value of liquid gas is assumed to be 28 kWh/m&sup3; and the
calorific value of natural gas is assumed to be 12 kWh/m&sup3;. </p>
<p>Source:</p>
<ul>
<li>URL: <a href=\"http://www.vaillant.de/Produkte/Kraft-Waerme-Kopplung/Blockheizkraftwerke/produkt_vaillant/mini-KWK-System_ecoPOWER_3.0_und_4.7.html\">mini-KWK-System_ecoPOWER_3.0_und_4.7.html</a></li>
<li>URL: <a href=\"http://www.vaillant.de/stepone2/data/downloads/21/4b/00/Prospekt-KWK.pdf\">Prospekt-KWK.pdf</a></li>
</ul>
</html>", revisions="<html>
<ul>
<li><i>January 24, 2013</i> by Peter Matthes:<br/>implemented</li>
</ul>
</html>"));
  end CHP_mini_ECO_POWER_5;

  record CHP_mini_ECO_POWER_5_LiquidGas
    "Vaillant: mini BHKW eco Power 4.7 (Liquid gas)"
    extends CHPDataSimple.CHPBaseDataDefinition(
      vol={2.72e-3},
      data_CHP=[0,    0,      0,    0,   0;
               41.6,  1.96,  5.2,   0.07,    14.85;
               100,   4.7,  12.5,   0.171,    35.7],
      maxTFlow=348.15,
      maxTReturn=338.15,
      DPipe=0.08);
  /* the el. and thermal powers are in KW. The fuel mass flow is in l/s. The fuel
consumption is in l/kWh.
 the calorific value of liquid gas is assumed 28 kWh/m^3.
 and the calorific value of natural gas is assumed 12 kWh/m^3.
*/
    annotation (Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Vaillant mini-BHKW ecoPOWER 4.7 (Liquid Gas) </p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>The electrical and thermal powers are in kW. The fuel mass flow is in l/s.
The fuel consumption is in l/kWh.</p>
<p>The calorific value of liquid gas is assumed to be 28 kWh/m&sup3; and the
calorific value of natural gas is assumed to be 12 kWh/m&sup3;. </p>
<p>Source:</p>
<ul>
<li>URL: <a href=\"http://www.vaillant.de/Produkte/Kraft-Waerme-Kopplung/Blockheizkraftwerke/produkt_vaillant/mini-KWK-System_ecoPOWER_3.0_und_4.7.html\">mini-KWK-System_ecoPOWER_3.0_und_4.7.html</a></li>
<li>URL: <a href=\"http://www.vaillant.de/stepone2/data/downloads/21/4b/00/Prospekt-KWK.pdf\">Prospekt-KWK.pdf</a></li>
</ul>
</html>", revisions="<html>
<ul>
<li><i>January 24, 2013</i> by Peter Matthes:<br/>implemented</li>
</ul>
</html>"));
  end CHP_mini_ECO_POWER_5_LiquidGas;
end CHPDataSimple;
