within AixLib.Fluid.Movers.Compressors.Utilities;
package IsentropicEfficiency "Package that contains models describing different isentropic efficiencies"
  extends Modelica.Icons.Library;


  model PowerIsentropicEfficiency
    "Model describing flow isentropic efficiency on power approach"
    extends PartialIsentropicEfficiency;

    // Definition of parameters
    //
    parameter Choices.IsentropicPowerModels
      powMod=Choices.IsentropicPowerModels.MendozaMirandaEtAl2016
      "Chose predefined power model for flow coefficient"
      annotation (Dialog(group="Modelling approach"));
    parameter Real a
      "Multiplication factor for generic power approach"
      annotation(Dialog(group="Modelling approach"));
    parameter Real b[:]
      "Exponents for each multiplier"
      annotation(Dialog(group="Modelling approach"));
    parameter Integer nT = size(b,1)
      "Number of terms used for the calculation procedure"
      annotation(Dialog(group="Modelling approach",
                        enable=false));

    // Definition of further parameters required for special approaches
    //
    parameter Modelica.SIunits.MolarMass MRef=0.1
      "Reference molar wheight";
    parameter Modelica.SIunits.Frequency rotSpeRef = 9.334
      "Reference rotational speed";

    // Definition of coefficients
    //
    Real P[nT]
      "Array that contains all coefficients used for the calculation procedure";

protected
    Medium.SaturationProperties satInl
      "Saturation properties at valve's inlet conditions";
    Medium.SaturationProperties satOut
      "Saturation properties at valve's outlet conditions";

  equation
    // Calculation of protected variables
    //
    satInl = Medium.setSat_p(Medium.pressure(staInl))
      "Saturation properties at valve's inlet conditions";
    satOut = Medium.setSat_p(Medium.pressure(staOut))
      "Saturation properties at valve's outlet conditions";

    // Calculation of coefficients
    //
    if (powMod == Choices.IsentropicPowerModels.MendozaMirandaEtAl2016) then
      /*Power approach presented by Mendoza et al. (2005):
      etaIse = piPre^b1 * (rotSpeRef/rotSpe)^b2 * (rotSpe^3*VDis/dhISe^1.5)^b3
               * (1/((TInl+TOutISe)/2-TOut))^b4     
    */
      P[1] = piPre
        "Pressure ratio";
      P[2] = rotSpeRef/rotSpe
        "Rotational Speed";
      P[3] = rotSpe^3*VDis/(Medium.isentropicEnthalpy(p_downstream=
        Medium.pressure(staInl),refState=staInl))^1.5
        "Isentropic specific enthalpy difference";
      P[4] = MRef/Medium.fluidConstants[1].molarMass
        "Molar Mass";

    else
      assert(false, "Invalid choice of power approach");
    end if;

    // Calculationg of flow coefficient
    //
    etaIse = a * product(P[i]^b[i] for i in 1:nT)
      "Calculation procedure of generic power approach";

  end PowerIsentropicEfficiency;

annotation (Icon(coordinateSystem(preserveAspectRatio=false),
              graphics={
                Ellipse(
                  extent={{-90,-90},{90,90}},
                  lineThickness=0.25,
                  pattern=LinePattern.None,
                  lineColor={215,215,215},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-40,60},{-30,70},{-20,60},{-20,60}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5),
                Line(
                  points={{-20,60},{-20,-30},{-20,38},{-16,50},
                          {-6,58},{0,60},{6,58}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5),
                Line(
                  points={{6,58},{16,50},{20,40},{20,-70},
                          {20,-70},{20,-70},{20,-70}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5)}),
Documentation(revisions="<html>
<ul>
  <li>
  October 19, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end IsentropicEfficiency;
