within AixLib.Fluid.Solar.Thermal;
model SolarThermal "Model of a solar thermal panel"
  extends AixLib.Fluid.Solar.Thermal.BaseClasses.PartialSolarThermal(solTheEff(
      final eta_zero=parCol.eta_zero,
      final c1=parCol.c1,
      final c2=parCol.c2));
  replaceable parameter AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition parCol
    constrainedby AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition
    "Properties of solar thermal collector"
     annotation(choicesAllMatching = true);
  annotation (Documentation(info="<html><p>
  <b><span style=\"color: #008000;\">Overview</span></b>
</p>
<p>
  Model of a solar thermal collector. Inputs are outdoor air
  temperature and solar irradiation. Based on these values and the
  collector properties from database, this model creates a heat flow to
  the fluid circuit.
</p>
<p>
  <b><span style=\"color: #008000;\">Concept</span></b>
</p>
<p>
  The model maps solar collector efficiency based on the equation
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Fluid/HeatExchanger/SolarThermal/equation-vRK5Io7E.png\"
  alt=\"eta = eta_o - c_1 * deltaT / G - c_2 * deltaT^2/ G\">
</p>
<p>
  <b><span style=\"color: #008000;\">Known Limitations</span></b>
</p>
<ul>
  <li>Connected directly with Sources.TempAndRad, this model only
  represents a horizontal collector. There is no calculation for
  radiation on tilted surfaces.
  </li>
  <li>With the standard BaseParameters, this model uses water as
  working fluid
  </li>
</ul>
<p>
  <b><span style=\"color: #008000;\">Example Results</span></b>
</p>
<p>
  <a href=
  \"AixLib.Fluid.Solar.Thermal.Examples.SolarThermalCollector\">AixLib.Fluid.Solar.Thermal.Examples.SolarThermalCollector</a>
</p>
<h5>
  Parameters
</h5>
<p>
  Furbo1996 (<a href=
  \"http://orbit.dtu.dk/en/publications/optimum-solar-collector-fluid-flow-rates(34823dd4-5b1d-4e16-be04-17f9f6ae05e5).html\">Optimum
  solar collector fluid flow rates</a>) suggests a default volume flow
  rate of approx. 0.2 l/(min.m2) to 0.4 l/(min.m2). Taken from a panel
  manufacturer's manual (<a href=
  \"https://www.altestore.com/static/datafiles/Others/SunMaxx%20Technical%20Manual.pdf\">SunMaxx
  Technical Manual.pdf</a>) the standard volume flow rate seems to be
  around 1.5 l/(min.m2). This is 3 l/min for collectors of size 0.93 m2
  up to 2.79 m2.
</p>
<table>
  <caption>
    \"Volume flow rate suggestions according to Furbo1996 and SunMaxx\"
    cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"50%\"&gt;
    <table>
      <tr>
        <td>
          <p>
            unit
          </p>
        </td>
        <td>
          <p>
            SunMaxx
          </p>
        </td>
        <td>
          <p>
            Furbo1996
          </p>
        </td>
      </tr>
      <tr>
        <td>
          <p>
            l/(min.m2)
          </p>
        </td>
        <td>
          <p>
            1.5
          </p>
        </td>
        <td>
          <p>
            0.3
          </p>
        </td>
      </tr>
      <tr>
        <td>
          <p>
            m3/(h.m2)
          </p>
        </td>
        <td>
          <p>
            0.091
          </p>
        </td>
        <td>
          <p>
            0.018
          </p>
        </td>
      </tr>
      <tr>
        <td>
          <p>
            m3/(s.m2)
          </p>
        </td>
        <td>
          <p>
            2.5e-5
          </p>
        </td>
        <td>
          <p>
            5.0e-6
          </p>
        </td>
      </tr>
      <tr>
        <td>
          <p>
            gpm/m2
          </p>
        </td>
        <td>
          <p>
            0.40
          </p>
        </td>
        <td>
          <p>
            0.079
          </p>
        </td>
      </tr>
    </table>
    <p>
      <br/>
      Assuming a default size for a unit of 2 m2 we get pressure losses
      for a module as in the following table (vfr=0.79 gpm):
    </p>
    <table>
      <caption>
        \"Pressure drop of two flat collector modules\" cellspacing=\"0\"
        cellpadding=\"2\" border=\"1\" width=\"50%\"&gt;
        <table>
          <tr>
            <td>
              <p>
                Collector
              </p>
            </td>
            <td>
              <p>
                pressure drop in psi
              </p>
            </td>
            <td>
              <p>
                pressure drop in Pa
              </p>
            </td>
          </tr>
          <tr>
            <td>
              <p>
                Titan Power Plus SU2
              </p>
            </td>
            <td>
              <p>
                0.28
              </p>
            </td>
            <td>
              <p>
                1900
              </p>
            </td>
          </tr>
          <tr>
            <td>
              <p>
                SunMaxx-VHP 30 (40&#160;% Glycol)
              </p>
            </td>
            <td>
              <p>
                0.43
              </p>
            </td>
            <td>
              <p>
                3000
              </p>
            </td>
          </tr>
        </table>
        <p>
          <br/>
          The pressureloss factor should therefore be around 2500 Pa /
          (2*2.5e-5 m3/s)^2 = 1e12.
        </p>
      </caption>
    </table>
  </caption>
</table>
</html>", revisions="<html>
<ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    Add partial model, align naming with guidelines (See 
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>).
  </li>
  <li>
  <i>Febraury 7, 2018&#160;</i> by Peter Matthes:<br/>
  Rename \"gain\" block into \"convertRelHeatFlow2absHeatFlow\"
  to make clearer what it does.<br/>
  Remove redundant
  <code>connect(solarThermalEfficiency.Q_flow,&#160;convertRelHeatFlow2absHeatFlow.u)</code><br/>

  Change default pressure drop coefficient from 1e6 to 2500
  Pa / (2*2.5e-5 m3/s)^2 = 1e12 Pa.s2/m6.<br/>
  Change default collector area to 2 m2.<br/>
  Extend documentation with some default parameters from
  references.<br/>
  Grid-align the RealInputs.
</li>
<li>
  <i>Febraury 1, 2018&#160;</i> by Philipp Mehrfeld:<br/>
  Delete max block as it is now implemented in the efficiency
  model
</li>
<li>
  <i>October 25, 2017</i> by Philipp Mehrfeld:<br/>
  Extend now from <a href=
  \"modelica://AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator\">
  AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator</a>.<br/>

  Use mean temperature.<br/>
  Limiter moved in equation section of efficiency model.
</li>
<li>
  <i>December 15, 2016</i> by Moritz Lauster:<br/>
  Moved
</li>
<li>
  <i>November 2014&#160;</i> by Marcus Fuchs:<br/>
  Changed model to use Annex 60 base class
</li>
<li>
  <i>November 19, 2013&#160;</i> by Marcus Fuchs:<br/>
  Implemented
</li>
</ul></html>"));
end SolarThermal;
