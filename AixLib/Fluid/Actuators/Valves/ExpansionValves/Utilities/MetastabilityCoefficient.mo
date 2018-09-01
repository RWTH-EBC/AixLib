within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities;
package MetastabilityCoefficient

  model PowerMetastabilityCoefficient
    "Model describing flow coefficient based on power approach"

    extends BaseClasses.Coefficient.PartialMetastabilityCoefficient;

    // Definition of parameters

    //

    /*parameter  Types.MetastabilityModels MetaPowMod = Types.MetastabilityModels.Liang2008
"Chose predefinied power model for Metastability parameter";*/

    parameter Types.PowerModels MetaPowMod=Types.PowerModels.Liang2008;

    parameter Real a "Multiplication factor for generic power approach"
      annotation (Dialog(group="Modelling approach"));
    parameter Real b[:] "Exponents for each multiplier"
      annotation (Dialog(group="Modelling approach"));
    parameter Integer nT=size(b, 1)
      "Number of terms used for the calculation procedure"
      annotation (Dialog(group="Modelling approach", enable=false));

    parameter Modelica.SIunits.Diameter dCle=0.02e-3
      "Clearance diameter dCle = d_inner - d_needle" annotation (Dialog(
          group="Further geometry data", enable=if (powMod == Types.PowerModels.ShanweiEtAl2005)
             then true else false));
    parameter Real pDifRat=0.84
      "Pressure differential ratio factor depending on valve moddeld"
      annotation (Dialog(group="Further geometry data", enable=if (powMod
             == Types.PowerModels.Li2013) then true else false));

    Modelica.SIunits.Diameter dThr=opening*dInlPip;

    Modelica.SIunits.Diameter d_e=dInlPip - dThr;

    // Definition of coefficients
    //
    Real P[nT]
      "Array that contains all coefficients used for the calculation procedure";
    //  Real corFact "Corraction factor used to correct flow coefficient";

    /*The correction factor is used to correct the flow coefficient if the 
    formula presented by the author is not equal to 
    m_flow = C_D*A*sqrt(2*rho_inlet*(pInl-pOut))
  */
    Modelica.SIunits.AbsolutePressure p_th "Pressure at throat Valve";

  protected
    Medium.SaturationProperties satInl
      "Saturation properties at valve's inlet conditions";
    Medium.SaturationProperties satOut
      "Saturation properties at valve's outlet conditions";

  equation
    // Calculation of protected variables
    //


      satInl = Medium.setSat_p(pInl)
      "Saturation properties at valve's inlet conditions";
    satOut = Medium.setSat_p(pOut)
      "Saturation properties at valve's outlet conditions";

    // Calculation of coefficients
    //
    if (MetaPowMod == Types.PowerModels.Liang2008) then

      /*  Caution with units - In the following, none S.I units are presented:
        Pressure:       in kPa
        Temperature:    in °C
        Heat capacity:  in kJ/(kg*K)
        Heat of vap.:   in kJ/kg
    */

      //Für Anfangszustand Liquid mit Phasenwechsel
      //R410,R22,R407C
      /*Metastability approach presented by Liang and Jingui (2007):  */
      P[1] = pInl/Medium.fluidConstants[1].criticalPressure
        "Relationship between upstream pressure and cricitcal Pressure";
      P[2] = (satInl.Tsat - Medium.temperature(staInl))/(Medium.fluidConstants[
        1].criticalTemperature - 273.15) "Degree of Subcooling";
      P[3] = Medium.density(staInl)/(1000*pInl/(
        Medium.specificHeatCapacityCp(staInl)*(Medium.fluidConstants[1].criticalTemperature
         - 273.15))) "Inlet liquid density";
      P[4] = Medium.dynamicViscosity(staInl)/(d_e*sqrt(Medium.density(
        staInl)*pInl)*10^6) "Inlet liquid viscosity";
      P[5] = d_e/dThr "Throat area";
      //P[6] = p_th / Medium.fluidConstants[1].criticalPressure     "Pressure at the throat";
      p_th = Medium.fluidConstants[1].criticalPressure*a*product(abs(P[i])^
        b[i] for i in 1:nT) "Calculation Pressure at the throat";
      //C _D = 0.94
      //C_D=0.9673 - 5.6682/sqrt(dInlet*d_e*vInl/viscotität)
       C_meta =  (satInl.psat-p_th)/satInl.psat;







    else
      assert(false, "Invalid choice of power approach");
    end if;

    // Calculationg of flow coefficient
    //
    // C_d = corFact*a*product(abs(P[i])^b[i] for i in 1:nT)    "Calculation procedure of generic power approach";


    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end PowerMetastabilityCoefficient;

  model PolynomialMetastabilityCoefficient


    extends BaseClasses.Coefficient.PartialMetastabilityCoefficient;

    Real C_meta "Metastbility Coefficient";



    // Definition of parameters
    //
    parameter Types.PolynomialModels MetaPolyMod=Types.PolynomialModels.Liu2006
      "Chose predefined polynomial model for metastability coefficient"
      annotation (Dialog(group="Modelling approach"));

    parameter Real a[:] "Multiplication factors for each summand"
      annotation (Dialog(group="Modelling approach"));
    parameter Real b[:] "Exponents for each summand"
      annotation (Dialog(group="Modelling approach"));
    parameter Integer nT=size(a, 1)
      "Number of terms used for the calculation procedure"
      annotation (Dialog(group="Modelling approach", enable=false));

    parameter Modelica.SIunits.Diameter dCle=0.02e-3
      "Clearance diameter dCle = d_inner - d_needle" annotation (Dialog(
          group="Further geometry data", enable=if (polyMod == Types.PolynomialModels.ShanweiEtAl2005)
             then true else false));
    parameter Real pDifRat=0.84
      "Pressure differential ratio factor depending on valve moddeld"
      annotation (Dialog(group="Further geometry data", enable=if (polyMod
             == Types.PolynomialModels.Li2013) then true else false));

    // Definition of coefficients
    //
    Real P[nT]
      "Array that contains all coefficients used for the calculation procedure";
    Real corFact "Corraction factor used to correct flow coefficient";

    /*The correction factor is used to correct the flow coefficient if the 
    formula presented by the author is not equal to 
    m_flow = C_D*A*sqrt(2*rho_inlet*(pInl-pOut))
  */

  protected
    Medium.SaturationProperties satInl
      "Saturation properties at valve's inlet conditions";
    Medium.SaturationProperties satOut
      "Saturation properties at valve's outlet conditions";

  equation
    // Calculation of protected variables
    //
    satInl = Medium.setSat_T(Medium.temperature(staInl))
      "Saturation properties at valve's inlet conditions";
     //  satInl = Medium.setSat_p(pInl)
    satOut = Medium.setSat_p(pOut)
      "Saturation properties at valve's outlet conditions";

    // Calculation of coefficients
    //
    if (MetaPolyMod == Types.PolynomialModels.Liu2006) then
      /*Polynominal approach presented by Jinghui Liu *, Jiangping Chen, Qifang Ye, Zhijiu Chen et al.(2006):
    C_meta = a0+a1*T_subcooling+a2*AThr-a3*AThr^2*/
      P[1] = 1 "Dummy coefficient since no coefficient is needed";
      P[2] = satInl.Tsat - Medium.temperature(staInl)
        "Temperature subcooling";
      P[3] = AVal*opening "Area throat valve";
      P[4] = (AVal*opening)^2 "quadratic Area throat valve";
      C_meta = sum(a[i]*P[i]^b[i] for i in 1:nT)
        "Calculation procedure of generel polynomial";
      C_meta = (satInl.psat - p_th)/p_th;

    elseif (MetaPolyMod == Types.PolynomialModels.Liang2008) then
      /* p_th = a0+a1*pInl+a2+deltaT_subcooling+a3*deltaT_subcooling^2+a4*Athr
    Chen Liang *, Chen Jiangping, Liu Jinghui, Chen Zhijiu (2008) */

      P[1] = 1 "Dummy coefficient since no coefficient is needed";
      P[2] = pInl "Pressure at inlet";
      P[3] = satInl.Tsat - Medium.temperature(staInl);
      P[4] = (satInl.Tsat - Medium.temperature(staInl))^2;
      P[5] = AVal*opening;

      p_th = sum(a[i]*P[i]^b[i] for i in 1:nT);
      C_meta = (satInl.psat - p_th)/satInl.psat;



    else
      assert(false, "Invalid choice of polynomial approach");
    end if;

    //Calculation of Metastability coefficient
    //


    corFact = 1;



  end PolynomialMetastabilityCoefficient;

  package SpecifiedMetastabilityCoefficient
      "Package that cointains Metastability coefficient that are specified"
    extends Modelica.Icons.VariantsPackage;
    model Buck_R22R407CR410A_EEV_16_18_meta
      "Buckingham - Similitude for R22, R407C, R410A - EEV - 1.6 mm to 1.8 mm "
      extends PowerMetastabilityCoefficient(
        final MetaPowMod=Types.PowerModels.Liang2008,
        final a=9.6681,
        final b={0.4314,-0.0844,-0.4871,0.0559,0.2580});

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Buck_R22R407CR410A_EEV_16_18_meta;

    model Poly_C_meta
     /*extends Metastability_HHMFFM(
    final MetaPolyMod=Types.PolynomialModels.Liu2006,
    final a={0.53351,0.015159,0.32296,-0.14936},
    final b={1,1,1,1});
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
           Ellipse(
                extent={{-90,-94},{90,86}},
                lineThickness=0.25,
                pattern=LinePattern.None,
                lineColor={215,215,215},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),Text(
                extent={{-100,-54},{100,-254}},
                lineColor={0,0,127},
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid,
                textString="M

")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
*/
      annotation (Icon(graphics={
               Ellipse(
                    extent={{-90,-94},{90,86}},
                    lineThickness=0.25,
                    pattern=LinePattern.None,
                    lineColor={215,215,215},
                    fillColor={215,215,215},
                    fillPattern=FillPattern.Solid),Text(
                    extent={{-100,-54},{100,-254}},
                    lineColor={0,0,127},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.Solid,
                    textString="M

")}));
    end Poly_C_meta;

    model Poly_R410A_16_18_pth
      extends PolynomialMetastabilityCoefficient(
        final MetaPolyMod=Types.PolynomialModels.Liang2008,
        final a={-0.24002,0.6609,0.06320,-0.01959,0.09674},
        final b={1,1,1,1,1});




      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Poly_R410A_16_18_pth;

    model Poly_R22_16_18_pth
      extends PolynomialMetastabilityCoefficient(
        final MetaPolyMod=Types.PolynomialModels.Liang2008,
        final a={-0.1229,0.7308,-0.01127,9.9668e-5,0.1162},
        final b={1,1,1,1,1});
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Poly_R22_16_18_pth;

    model ConstantMetastabilityCoefficient
      extends BaseClasses.Coefficient.PartialMetastabilityCoefficient;

      //Definition of parameters
      parameter Real C_meta_const(
        unit="1",
        min=0,
        max=1,
        nominal=0.25) = 0.4;

    equation
      C_meta = C_meta_const;

      p_th = 1;


    end ConstantMetastabilityCoefficient;

    model Poly_R407C_16_18_pth
      extends PolynomialMetastabilityCoefficient(
        final MetaPolyMod=Types.PolynomialModels.Liang2008,
        final a={-0.00846,0.7150,-0.02048,0.000598,0.08231},
        final b={1,1,1,1,1});
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)));

    end Poly_R407C_16_18_pth;
  end SpecifiedMetastabilityCoefficient;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
           Ellipse(
                extent={{-90,-94},{90,86}},
                lineThickness=0.25,
                pattern=LinePattern.None,
                lineColor={215,215,215},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),Text(
                extent={{-100,-54},{100,-254}},
                lineColor={0,0,127},
                fillColor={135,135,135},
                fillPattern=FillPattern.Solid,
                textString="M

")}), Diagram(coordinateSystem(preserveAspectRatio=false)));
end MetastabilityCoefficient;
