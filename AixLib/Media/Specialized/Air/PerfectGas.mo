within AixLib.Media.Specialized.Air;

package PerfectGas "Model for air as a perfect gas"

  extends Modelica.Media.Interfaces.PartialCondensingGases(

     mediumName="Moist air unsaturated perfect gas",

     substanceNames={"water", "air"},

     final reducedX=true,

     final singleState=false,

     reference_X={0.01,0.99},

     reference_T=273.15,

     reference_p=101325,

     fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O,

                       Modelica.Media.IdealGases.Common.FluidData.N2},

     AbsolutePressure(start=p_default),

     Temperature(start=T_default));



  extends Modelica.Icons.Package;



  constant Integer Water=1

    "Index of water (in substanceNames, massFractions X, etc.)";

  constant Integer Air=2

    "Index of air (in substanceNames, massFractions X, etc.)";



  redeclare record extends ThermodynamicState(

    p(start=p_default),

    T(start=T_default),

    X(start=X_default)) "ThermodynamicState record for moist air"

  end ThermodynamicState;



  redeclare replaceable model extends BaseProperties(

    p(stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),

    Xi(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default),

    final standardOrderComponents=true)



    /* p, T, X = X[Water] are used as preferred states, since only then all

     other quantities can be computed in a recursive sequence.

     If other variables are selected as states, static state selection

     is no longer possible and non-linear algebraic equations occur.

      */

  protected

    constant Modelica.SIunits.MolarMass[2] MMX = {steam.MM,dryair.MM}

      "Molar masses of components";



    MassFraction X_steam "Mass fraction of steam water";

    MassFraction X_air "Mass fraction of air";

  equation

    assert(T >= 200.0 and T <= 423.15, "

Temperature T is not in the allowed range

200.0 K <= (T =" + String(T) + " K) <= 423.15 K

required from medium model \""     + mediumName + "\".");



    MM = 1/(Xi[Water]/MMX[Water]+(1.0-Xi[Water])/MMX[Air]);



    X_steam  = Xi[Water];

    X_air    = 1-Xi[Water];



    h = (T - reference_T)*dryair.cp * (1 - Xi[Water]) +

        ((T-reference_T) * steam.cp + h_fg) * Xi[Water];



    R = dryair.R*(1 - X_steam) + steam.R*X_steam;

    //

    u = h - R*T;

    d = p/(R*T);

    /* Note, u and d are computed under the assumption that the volume of the liquid

         water is negligible with respect to the volume of air and of steam

      */

    state.p = p;

    state.T = T;

    state.X = X;

  end BaseProperties;



  function Xsaturation = Modelica.Media.Air.MoistAir.Xsaturation

    "Steam water mass fraction of saturation boundary in kg_water/kg_moistair"

  annotation (

    Inline=true);



  redeclare function setState_pTX

    "Thermodynamic state as function of p, T and composition X"

      extends Modelica.Media.Air.MoistAir.setState_pTX;

  annotation (

    Inline=true);

  end setState_pTX;



  redeclare function setState_phX

    "Thermodynamic state as function of p, h and composition X"

  extends Modelica.Icons.Function;

  input AbsolutePressure p "Pressure";

  input SpecificEnthalpy h "Specific enthalpy";

  input MassFraction X[:] "Mass fractions";

  output ThermodynamicState state;

  algorithm

  state := if size(X,1) == nX then

         ThermodynamicState(p=p,T=temperature_phX(p,h,X),X=X) else

        ThermodynamicState(p=p,T=temperature_phX(p,h,X), X=cat(1,X,{1-sum(X)}));

    annotation (

  Inline=true,

  Documentation(info="<html>
Function to set the state for given pressure, enthalpy and species concentration. </html>",revisions="<html> The thermodynamic state record is computed from density d, temperature T and composition X. Saturation pressure of water above the triple point temperature is computed from temperature. It's range of validity is between 273.16 and 373.16 K. Outside these limits a less accurate result is returned. Derivative function of <a href=\"modelica://AixLib.Media.Specialized.Air.PerfectGas.saturationPressureLiquid\">AixLib.Media.Specialized.Air.PerfectGas.saturationPressureLiquid</a> Pressure is returned from the thermodynamic state record input as a simple assignment. Temperature is returned from the thermodynamic state record input as a simple assignment. Density is computed from pressure, temperature and composition in the thermodynamic state record applying the ideal gas law. Specific entropy is calculated from the thermodynamic state record, assuming ideal gas behavior and including entropy of mixing. Liquid or solid water is not taken into account, the entire water content X[1] is assumed to be in the vapor state (relative humidity below 1.0). Temperature as a function of specific enthalpy and species concentration. The pressure is input for compatibility with the medium models, but the temperature is independent of the pressure.
<p>
  This data record contains the coefficients for perfect gases.
</p>
<ul>
  <li>June 6, 2015, by Michael Wetter:<br/>
    Set <code>AbsolutePressure(start=p_default)</code> and <code>Temperature(start=T_default)</code> to have to have conistent start values. See also revision notes of <a href=\"modelica://AixLib.Media.Water\">AixLib.Media.Water</a>. This is for <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/266\">#266</a>.
  </li>
  <li>May 1, 2015, by Michael Wetter:<br/>
    Added <code>Inline=true</code> for <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/227\">issue 227</a>.
  </li>
  <li>September 12, 2014, by Michael Wetter:<br/>
    Corrected the wrong location of the <code>preferredView</code> and the <code>revisions</code> annotation.
  </li>
  <li>November 21, 2013, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
<p>
  This package contains a <i>thermally perfect</i> model of moist air.
</p>
<p>
  A medium is called thermally perfect if
</p>
<ul>
  <li>it is in thermodynamic equilibrium,
  </li>
  <li>it is chemically not reacting, and
  </li>
  <li>internal energy and enthalpy are functions of temperature only.
  </li>
</ul>
<p>
  In addition, this medium model is <i>calorically perfect</i>, i.e., the specific heat capacities at constant pressure <i>c<sub>p</sub></i> and constant volume <i>c<sub>v</sub></i> are both constant (Bower 1998).
</p>
<p>
  This medium uses the ideal gas law
</p>
<p align=\"center\" style=\"font-style:italic;\">
  ρ = p ⁄(R T),
</p>
<p>
  where <i>ρ</i> is the density, <i>p</i> is the pressure, <i>R</i> is the gas constant and <i>T</i> is the temperature.
</p>
<p>
  The enthalpy is computed using the convention that <i>h=0</i> if <i>T=0</i> °C and no water vapor is present.
</p>
<p>
  Note that for typical building simulations, the media <a href=\"modelica://AixLib.Media.Air\">AixLib.Media.Air</a> should be used as it leads generally to faster simulation.
</p>
<h4>
  References
</h4>
<p>
  Bower, William B. <i>A primer in fluid mechanics: Dynamics of flows in one space dimension</i>. CRC Press. 1998.
</p>
<ul>
  <li>March 15, 2016, by Michael Wetter:<br/>
    Replaced <code>spliceFunction</code> with <code>regStep</code>. This is for <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/300\">issue 300</a>.
  </li>
  <li>November 13, 2014, by Michael Wetter:<br/>
    Removed <code>phi</code> and removed non-required computations.
  </li>
  <li>March 29, 2013, by Michael Wetter:<br/>
    Added <code>final standardOrderComponents=true</code> in the <code>BaseProperties</code> declaration. This avoids an error when models are checked in Dymola 2014 in the pedenatic mode.
  </li>
  <li>April 12, 2012, by Michael Wetter:<br/>
    Added keyword <code>each</code> to <code>Xi(stateSelect=...</code>.
  </li>
  <li>April 4, 2012, by Michael Wetter:<br/>
    Added redeclaration of <code>ThermodynamicState</code> to avoid a warning during model check and translation.
  </li>
  <li>January 27, 2010, by Michael Wetter:<br/>
    Added function <code>enthalpyOfNonCondensingGas</code> and its derivative.
  </li>
  <li>January 27, 2010, by Michael Wetter:<br/>
    Fixed bug with temperature offset in <code>T_phX</code>.
  </li>
  <li>August 18, 2008, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>

</html>"),

    Icon(graphics={

        Ellipse(

          extent={{-78,78},{-34,34}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{-18,86},{26,42}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{48,58},{92,14}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{-22,32},{22,-12}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{36,-32},{80,-76}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{-36,-30},{8,-74}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120}),

        Ellipse(

          extent={{-90,-6},{-46,-50}},

          lineColor={0,0,0},

          fillPattern=FillPattern.Sphere,

          fillColor={120,120,120})}));

end PerfectGas;

