within AixLib.DataBase.CHP.CHPDataSimple;
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
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Cleanergy mini-BHKW C9G (low caloric gas)
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The electrical and thermal powers are in kW. The \"fuel input\" is in
  kW. The fuel consumption is in m³/h.
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
        14.5 x 70 x 100
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
        0.70
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"top\">
      <p>
        Weight kg
      </p>
    </td>
    <td valign=\"top\">
      <p>
        470
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
        Fuels: natural gas (all qualities), mainly designed for low
        caloric gas (bio gas)
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
        2 - 9
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
        8 - 25
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
        ~36
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
        21 % (24% capacity), 24 % (80% capacity)
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
        58 % (24% capacity), 70 % (80% capacity)
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
        79 % (24% capacity), 94 % (80% capacity)
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
        60 – 65 (optimal: 50 °C)
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
        50 (TRmin = 30 °C)
      </p>
    </td>
  </tr>
</table>
<p>
  <br/>
  <br/>
  <b>The CHP engine is not designed for continuous operation at more
  than 80% load (7.2 kW).</b> Continuous use at higher load than 80%
  decreases the time between services.
</p>
<p>
  For low methane applications, the C9G LowCal is capped to 120 bar
  engine pressure being equivalent to 7.2 kW.
</p>
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
end CHP_Cleanergy_C9G;
