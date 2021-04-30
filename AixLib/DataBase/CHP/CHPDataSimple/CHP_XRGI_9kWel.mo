within AixLib.DataBase.CHP.CHPDataSimple;
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
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  EC Power mini-BHKW XRGI 9 (Natural Gas)
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The electrical and thermal powers are in kW. The fuel input is in kW.
  The fuel consumption is in m³/h.
</p>
<p>
  The calorific value of natural gas is assumed to be 11.5 kWh/m³ (10 -
  12 kWh/m³).
</p>
<h4>
  <span style=\"color:#008000\">Data Sheet (English, German)</span>
</h4>
<table summary=\"Data Sheet\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">
  <tr>
    <td valign=\"top\">
      <p>
        Max. noise level dB(A)
      </p>
    </td>
    <td valign=\"top\">
      <p>
        49
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Dimensions (L x W x H) cm
      </p>
    </td>
    <td valign=\"top\">
      <p>
        92 x 64 x 96
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Floor area m<sup>2</sup>
      </p>
    </td>
    <td valign=\"top\">
      <p>
        0.59
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Weight kg&lt;/ p&gt;
      </p>
    </td>
    <td valign=\"top\">
      <p>
        440
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Service interval hours
      </p>
    </td>
    <td valign=\"top\">
      <p>
        10,000
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Fuels: natural gas (all qualities), propane, butane
      </p>
    </td>
    <td valign=\"top\">
      <p>
        yes
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Electrical output (modulating) kW
      </p>
    </td>
    <td valign=\"top\">
      <p>
        4 - 9
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Thermal output kW
      </p>
    </td>
    <td valign=\"top\">
      <p>
        12 - 20
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Power consumption (gas) kW
      </p>
    </td>
    <td valign=\"top\">
      <p>
        31
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Electrical efficiency
      </p>
    </td>
    <td valign=\"top\">
      <p>
        29.5 %
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Thermal efficiency excluding optional condenser
      </p>
    </td>
    <td valign=\"top\">
      <p>
        63.5 %
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Total efficiency excluding optional condenser
      </p>
    </td>
    <td valign=\"top\">
      <p>
        93 %
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Flow temperature (constant) °C
      </p>
    </td>
    <td valign=\"top\">
      <p>
        80 – 85
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Max. return temperature (variable) °C
      </p>
    </td>
    <td valign=\"top\">
      <p>
        5 – 75
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Maximum exhaust gas temperature °C
      </p>
    </td>
    <td valign=\"top\">
      <p>
        100
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Emissions mg/Nm<sup>3</sup>
      </p>
    </td>
    <td valign=\"top\">
      <p>
        CO: &lt; 50
      </p>
      <p>
        NO<sub>X</sub>: &lt; 100
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Primary energy saving PES (EU Directive, verification in
        accordance with DIN 4709)
      </p>
    </td>
    <td valign=\"top\">
      <p>
        22.4 %
      </p>
    </td>
  </tr>
</table>
<table summary=\"Emmisions\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\">
  <tr>
    <td valign=\"top\">
      <p>
        Emission
      </p>
    </td>
    <td valign=\"top\">
      <p>
        &lt; ½ TA Luft
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Primärenergieeinsparung PEE (EU-Richtlinie, Prüfung nach DIN
        4709)
      </p>
    </td>
    <td valign=\"top\">
      <p>
        22,4 %
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Primärenergiefaktor fp (EnEV 2009, EN15326)
      </p>
    </td>
    <td valign=\"top\">
      <p>
        0,53
      </p>
    </td>
  </tr>
</table>
<p>
  Source:
</p>
<ul>
  <li>URL: <a href=
  \"http://www.ecpower.eu/deutsch/xrgi/technische-daten/xrgir-9.html\">www.ecpower.eu/xrgir-9.html</a>
  </li>
</ul>
</html>",
        revisions="<html><ul>
  <li>
    <i>January 24, 2013</i> by Peter Matthes:<br/>
    implemented
  </li>
</ul>
</html>"));
end CHP_XRGI_9kWel;
