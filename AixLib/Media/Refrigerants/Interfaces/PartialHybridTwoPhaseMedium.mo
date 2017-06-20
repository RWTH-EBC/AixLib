within AixLib.Media.Refrigerants.Interfaces;
partial package PartialHybridTwoPhaseMedium
  "Base class for two phase medium using a hybrid approach"
  extends Modelica.Media.Interfaces.PartialTwoPhaseMedium;

  redeclare record extends ThermodynamicState "Thermodynamic state"
    Density d "Density";
    Temperature T "Temperature";
    AbsolutePressure p "Pressure";
    SpecificEnthalpy h "Enthalpy";
  end ThermodynamicState;
  /*The record "ThermodynamicState" contains the input arguments
    of all the function and is defined together with the used
    type definitions in PartialMedium. The record most often contains two of the
    variables "p, T, d, h" (e.g., medium.T)
  */

  /*Provide records thats contain the fitting coefficients for all fitted
    formula (e.g. Helmholtz equation of state). These records must be
    redeclared within the template to provide the coefficients.
  */
  replaceable record EoS
    "Record that contains fitting coefficients of the Helmholtz EoS"
    extends
      AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition;
  end EoS;

  replaceable record BDSP
    "Record that contains fitting coefficients of the state properties at bubble
    and dew lines"
    extends
      AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition;
  end BDSP;

  replaceable record TSP
    "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
    extends
      AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition;
  end TSP;

  replaceable record SmoothTransition
    "Record that contains ranges to calculate a smooth transition between
    different regions"
    SpecificEnthalpy T_ph = 10;
    SpecificEntropy T_ps = 10;
    AbsolutePressure d_pT = 10;
    SpecificEnthalpy d_ph = 10;
    Real d_ps(unit="J/(Pa.K.kg)") =  50/(30e5-0.5e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 100/(30e5-0.5e5);
    AbsolutePressure d_derh_p = 0.2;
  end SmoothTransition;

  /*Provide Helmholtz equations of state (EoS). These EoS must be fitted to
    different refrigerants. However, the structure will not change and, 
    therefore, the coefficients, which are obtained during the fitting 
    procedure, are provided by a record. These coefficients have to be 
    provided within the template.
    Just change if needed.
  */
  replaceable function alpha_0
  "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
    input Real delta "Temperature";
    input Real tau "Density";
    output Real alpha_0 = 0 "Dimensionless ideal gas Helmholz energy";

  protected
    EoS cf;

  algorithm
    alpha_0 := log(delta);
    for k in 1:cf.alpha_0_nL loop
      alpha_0 := alpha_0 +
        cf.alpha_0_l1[k]*log(tau^cf.alpha_0_l2[k]);
    end for;
    for k in 1:cf.alpha_0_nP loop
      alpha_0 := alpha_0 +
        cf.alpha_0_p1[k]*tau^cf.alpha_0_p2[k];
    end for;
    for k in 1:cf.alpha_0_nE loop
      alpha_0 := alpha_0 +
        cf.alpha_0_e1[k]*log(1-exp(cf.alpha_0_e2[k]*tau));
    end for;
  annotation(Inline=false,
          LateInline=true);
  end alpha_0;

  replaceable partial function alpha_r
  "Dimensionless Helmholtz energy (Residual part alpha_r)"
      input Real delta "Temperature";
      input Real tau "Density";
      output Real alpha_r = 0 "Dimensionless residual Helmholz energy";

  protected
    EoS cf;

  algorithm
    for k in 1:cf.alpha_r_nP loop
      alpha_r := alpha_r +
        cf.alpha_r_p1[k]*delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
    end for;
    for k in 1:cf.alpha_r_nB loop
      alpha_r := alpha_r +
        cf.alpha_r_b1[k]*delta^cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*
        exp(-delta^cf.alpha_r_b4[k]);
    end for;
    for k in 1:cf.alpha_r_nG loop
      alpha_r := alpha_r +
        cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
        exp(cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 +
        cf.alpha_r_g6[k]*(tau - cf.alpha_r_g7[k])^2);
    end for;
  annotation(Inline=false,
          LateInline=true);
  end alpha_r;

  replaceable partial function tau_d_alpha_0_d_tau
  "Short form for tau*(dalpha_0/dtau)@delta=const"
    input Real tau "Density";
    output Real tau_d_alpha_0_d_tau = 0 "Tau*(dalpha_0/dtau)@delta=const";

  protected
    EoS cf;

  algorithm
    for k in 1:cf.alpha_0_nL loop
      tau_d_alpha_0_d_tau := tau_d_alpha_0_d_tau +
        cf.alpha_0_l1[k]*cf.alpha_0_l2[k];
    end for;
    for k in 1:cf.alpha_0_nP loop
      tau_d_alpha_0_d_tau := tau_d_alpha_0_d_tau +
        cf.alpha_0_p1[k]*cf.alpha_0_p2[k]*tau^cf.alpha_0_p2[k];
    end for;
    for k in 1:cf.alpha_0_nE loop
      tau_d_alpha_0_d_tau := tau_d_alpha_0_d_tau +
        tau*cf.alpha_0_e1[k]*cf.alpha_0_e2[k]/(1-exp(-cf.alpha_0_e2[k]*tau));
    end for;
  annotation(Inline=false,
          LateInline=true);
  end tau_d_alpha_0_d_tau;

  replaceable partial function tau2_d2_alpha_0_d_tau2
  "Short form for tau*tau*(ddalpha_0/(dtau*dtau))@delta=const"
      input Real tau "Density";
      output Real tau2_d2_alpha_0_d_tau2 = 0
      "Tau*tau*(ddalpha_0/(dtau*dtau))@delta=const";

  protected
    EoS cf;

  algorithm
    for k in 1:cf.alpha_0_nL loop
      tau2_d2_alpha_0_d_tau2 := tau2_d2_alpha_0_d_tau2 -
        cf.alpha_0_l1[k]*cf.alpha_0_l2[k];
    end for;
    for k in 1:cf.alpha_0_nP loop
      tau2_d2_alpha_0_d_tau2 := tau2_d2_alpha_0_d_tau2 +
        cf.alpha_0_p1[k]*cf.alpha_0_p2[k]*(cf.alpha_0_p2[k]-1)*tau^cf.alpha_0_p2[k];
    end for;
    for k in 1:cf.alpha_0_nE loop
      tau2_d2_alpha_0_d_tau2 := tau2_d2_alpha_0_d_tau2 -
        tau^2*cf.alpha_0_e1[k]*cf.alpha_0_e2[k]^2*exp(-cf.alpha_0_e2[k]*tau)/
        ((1-exp(-cf.alpha_0_e2[k]*tau))^2);
    end for;
  annotation(Inline=false,
          LateInline=true);
  end tau2_d2_alpha_0_d_tau2;

  replaceable partial function tau_d_alpha_r_d_tau
  "Short form for tau*(dalpha_r/dtau)@delta=const"
    input Real delta "Temperature";
    input Real tau "Density";
    output Real tau_d_alpha_r_d_tau = 0 "Tau*(dalpha_r/dtau)@delta=const";

  protected
    EoS cf;

  algorithm
    for k in 1:cf.alpha_r_nP loop
      tau_d_alpha_r_d_tau := tau_d_alpha_r_d_tau +
        cf.alpha_r_p1[k]*cf.alpha_r_p3[k]*delta^cf.alpha_r_p2[k]*
        tau^cf.alpha_r_p3[k];
    end for;
    for k in 1:cf.alpha_r_nB loop
      tau_d_alpha_r_d_tau := tau_d_alpha_r_d_tau +
        cf.alpha_r_b1[k]*cf.alpha_r_b3[k]*delta^cf.alpha_r_b2[k]*
        tau^cf.alpha_r_b3[k]*exp(-delta^cf.alpha_r_b4[k]);
    end for;
    for k in 1:cf.alpha_r_nG loop
      tau_d_alpha_r_d_tau := tau_d_alpha_r_d_tau +
        cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
        exp(cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 + cf.alpha_r_g6[k]*
        (tau - cf.alpha_r_g7[k])^2)*(cf.alpha_r_g3[k]+2*cf.alpha_r_g6[k]*
        tau*(tau-cf.alpha_r_g7[k]));
    end for;
  annotation(Inline=false,
          LateInline=true);
  end tau_d_alpha_r_d_tau;

  replaceable partial function tau_delta_d2_alpha_r_d_tau_d_delta
  "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
    input Real delta "Temperature";
    input Real tau "Density";
    output Real tau_delta_d2_alpha_r_d_tau_d_delta = 0
    "Tau*delta*(ddalpha_r/(dtau*ddelta))";

  protected
    EoS cf;

  algorithm
    for k in 1:cf.alpha_r_nP loop
      tau_delta_d2_alpha_r_d_tau_d_delta := tau_delta_d2_alpha_r_d_tau_d_delta +
        cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*cf.alpha_r_p3[k]*
        delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
    end for;
    for k in 1:cf.alpha_r_nB loop
      tau_delta_d2_alpha_r_d_tau_d_delta := tau_delta_d2_alpha_r_d_tau_d_delta +
        cf.alpha_r_b1[k]*cf.alpha_r_b3[k]*delta^cf.alpha_r_b2[k]*tau^
        cf.alpha_r_b3[k]*exp(-delta^cf.alpha_r_b4[k])*(cf.alpha_r_b2[k]-
        cf.alpha_r_b4[k]*delta^cf.alpha_r_b4[k]);
    end for;
    for k in 1:cf.alpha_r_nG loop
      tau_delta_d2_alpha_r_d_tau_d_delta := tau_delta_d2_alpha_r_d_tau_d_delta +
        cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
        exp(cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 + cf.alpha_r_g6[k]*
        (tau - cf.alpha_r_g7[k])^2)*(cf.alpha_r_g3[k]+2*cf.alpha_r_g6[k]*tau*
        (tau-cf.alpha_r_g7[k]))*(cf.alpha_r_g2[k]+2*cf.alpha_r_g4[k]*delta*
        (delta-cf.alpha_r_g5[k]));
    end for;
  annotation(Inline=false,
          LateInline=true);
  end tau_delta_d2_alpha_r_d_tau_d_delta;

  replaceable partial function tau2_d2_alpha_r_d_tau2
  "Short form for tau*tau*(ddalpha_r/(dtau*dtau))@delta=const"
      input Real delta "Temperature";
      input Real tau "Density";
      output Real tau2_d2_alpha_r_d_tau2 = 0
      "Tau*tau*(ddalpha_r/(dtau*dtau))@delta=const";

  protected
    EoS cf;

  algorithm
    for k in 1:cf.alpha_r_nP loop
      tau2_d2_alpha_r_d_tau2 := tau2_d2_alpha_r_d_tau2 +
        cf.alpha_r_p1[k]*cf.alpha_r_p3[k]*(cf.alpha_r_p3[k]-1)*
        delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
    end for;
    for k in 1:cf.alpha_r_nB loop
      tau2_d2_alpha_r_d_tau2 := tau2_d2_alpha_r_d_tau2 +
        cf.alpha_r_b1[k]*cf.alpha_r_b3[k]*(cf.alpha_r_b3[k]-1)*delta^
        cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*exp(-delta^cf.alpha_r_b4[k]);
    end for;
    for k in 1:cf.alpha_r_nG loop
      tau2_d2_alpha_r_d_tau2 := tau2_d2_alpha_r_d_tau2 +
        cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
        exp(cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 + cf.alpha_r_g6[k]*
        (tau - cf.alpha_r_g7[k])^2)*((cf.alpha_r_g3[k]+2*cf.alpha_r_g6[k]*tau*
        (tau-cf.alpha_r_g7[k]))^2-cf.alpha_r_g3[k]+2*cf.alpha_r_g6[k]*tau^2);
    end for;
  annotation(Inline=false,
          LateInline=true);
  end tau2_d2_alpha_r_d_tau2;

  replaceable partial function delta_d_alpha_r_d_delta
  "Short form for delta*(dalpha_r/(ddelta))@tau=const"
    input Real delta "Temperature";
    input Real tau "Density";
    output Real delta_d_alpha_r_d_delta = 0
      "Delta*(dalpha_r/(ddelta))@tau=const";

  protected
    EoS cf;

  algorithm
    for k in 1:cf.alpha_r_nP loop
      delta_d_alpha_r_d_delta := delta_d_alpha_r_d_delta +
        cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*delta^cf.alpha_r_p2[k]*tau^
        cf.alpha_r_p3[k];
    end for;
    for k in 1:cf.alpha_r_nB loop
      delta_d_alpha_r_d_delta := delta_d_alpha_r_d_delta +
        cf.alpha_r_b1[k]*delta^cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*
        exp(-delta^cf.alpha_r_b4[k])*(cf.alpha_r_b2[k]-cf.alpha_r_b4[k]*
        delta^cf.alpha_r_b4[k]);
    end for;
    for k in 1:cf.alpha_r_nG loop
      delta_d_alpha_r_d_delta := delta_d_alpha_r_d_delta +
        cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
        exp(cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 + cf.alpha_r_g6[k]*
        (tau - cf.alpha_r_g7[k])^2)*(cf.alpha_r_g2[k]+2*cf.alpha_r_g4[k]*delta*
        (delta-cf.alpha_r_g5[k]));
    end for;
  annotation(Inline=false,
          LateInline=true);
  end delta_d_alpha_r_d_delta;

  replaceable partial function delta3_d3_alpha_r_d_delta3
  "Short form for delta*delta*delta(dddalpha_r/(ddelta*delta*delta))@tau=const"
    input Real delta "Temperature";
    input Real tau "Density";
    output Real delta3_d3_alpha_r_d_delta3 = 0
    "Delta*delta*delta(dddalpha_r/(ddelta*delta*delta))@tau=const";

  protected
    EoS cf;

  algorithm
    for k in 1:cf.alpha_r_nP loop
      delta3_d3_alpha_r_d_delta3 := delta3_d3_alpha_r_d_delta3 +
        cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*(cf.alpha_r_p2[k]-1)*
        (cf.alpha_r_p2[k]-2)*delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
    end for;
    for k in 1:cf.alpha_r_nB loop
      delta3_d3_alpha_r_d_delta3 := delta3_d3_alpha_r_d_delta3 +
        cf.alpha_r_b1[k]*delta^cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*
        exp(-delta^cf.alpha_r_b4[k])*((cf.alpha_r_b2[k]-2-cf.alpha_r_b4[k]*
        delta^cf.alpha_r_b4[k])*((cf.alpha_r_b2[k]-1-cf.alpha_r_b4[k]*
        delta^cf.alpha_r_b4[k])*(cf.alpha_r_b2[k]-cf.alpha_r_b4[k]*
        delta^cf.alpha_r_b4[k])-cf.alpha_r_b4[k]^2*delta^cf.alpha_r_b4[k])-
        cf.alpha_r_b4[k]^2*delta^cf.alpha_r_b4[k]*(2*cf.alpha_r_b2[k]-1+
        cf.alpha_r_b4[k]-2*cf.alpha_r_b4[k]*delta^cf.alpha_r_b4[k]));
    end for;
    for k in 1:cf.alpha_r_nG loop
      delta3_d3_alpha_r_d_delta3 := delta3_d3_alpha_r_d_delta3 +
        cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
        exp(cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 + cf.alpha_r_g6[k]*
        (tau - cf.alpha_r_g7[k])^2)*((cf.alpha_r_g2[k]-2-2*cf.alpha_r_g4[k]*
        delta*(delta-cf.alpha_r_g5[k]))*((cf.alpha_r_g2[k]+2*cf.alpha_r_g4[k]*
        delta*(delta-cf.alpha_r_g5[k]))^2-cf.alpha_r_g2[k]+2*cf.alpha_r_g4[k]^
        2*delta^2)+delta*(4*cf.alpha_r_g4[k]^2*delta+2*cf.alpha_r_g2[k]+4*
        cf.alpha_r_g4[k]*delta*(delta-cf.alpha_r_g5[k])*(4*cf.alpha_r_g4[k]*
        delta-2*cf.alpha_r_g4[k]*cf.alpha_r_g5[k])));
    end for;
  annotation(Inline=false,
          LateInline=true);
  end delta3_d3_alpha_r_d_delta3;

  replaceable partial function delta2_d2_alpha_r_d_delta2
  "Short form for delta*delta(ddalpha_r/(ddelta*delta))@tau=const"
    input Real delta "Temperature";
    input Real tau "Density";
    output Real delta2_d2_alpha_r_d_delta2 = 0
    "Delta*delta(ddalpha_r/(ddelta*delta))@tau=const";

  protected
    EoS cf;

  algorithm
    for k in 1:cf.alpha_r_nP loop
      delta2_d2_alpha_r_d_delta2 := delta2_d2_alpha_r_d_delta2 +
        cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*(cf.alpha_r_p2[k]-1)*
        delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
    end for;
    for k in 1:cf.alpha_r_nB loop
      delta2_d2_alpha_r_d_delta2 := delta2_d2_alpha_r_d_delta2 +
        cf.alpha_r_b1[k]*delta^cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*
        exp(-delta^cf.alpha_r_b4[k])*((cf.alpha_r_b2[k]-1-cf.alpha_r_b4[k]*
        delta^cf.alpha_r_b4[k])*(cf.alpha_r_b2[k]-cf.alpha_r_b4[k]*
        delta^cf.alpha_r_b4[k])-cf.alpha_r_b4[k]^2-delta^cf.alpha_r_b4[k]);
    end for;
    for k in 1:cf.alpha_r_nG loop
      delta2_d2_alpha_r_d_delta2 := delta2_d2_alpha_r_d_delta2 +
        cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
        exp(cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 + cf.alpha_r_g6[k]*
        (tau - cf.alpha_r_g7[k])^2)*((cf.alpha_r_g2[k]+2*cf.alpha_r_g4[k]*
        delta*(delta-cf.alpha_r_g5[k]))^2-cf.alpha_r_g2[k]+2*cf.alpha_r_g4[k]^
        2*delta^2);
    end for;
  annotation(Inline=false,
          LateInline=true);
  end delta2_d2_alpha_r_d_delta2;

  /*Provide polynomial functions for saturation properties. These functions are
    fitted to external data (e.g. data extracted from RefProp or FluidProp). 
    Currently, just one fitting approach is implemented. Therefore, the 
    coefficients, which are obtained during the fitting procedure, are provided
     by records.
  */
  redeclare function extends saturationPressure
  "Saturation pressure of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real OM = (1 - T/fluidConstants[1].criticalTemperature);
    Real p_1 = 0;

  algorithm
    if T>fluidConstants[1].criticalTemperature then
     p := fluidConstants[1].criticalPressure;
    elseif T<fluidConstants[1].triplePointTemperature then
     p := fluidConstants[1].triplePointPressure;
    else
      for k in 1:cf.saturationPressure_nT loop
        p_1 :=p_1 + cf.saturationPressure_n[k]*OM^cf.saturationPressure_e[k];
      end for;
      p := fluidConstants[1].criticalPressure *
        exp(fluidConstants[1].criticalTemperature/T * p_1);
    end if;
    annotation(Inline=false,
          LateInline=true);
  end saturationPressure;

  redeclare function extends saturationTemperature
  "Saturation temperature of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real T_1 = 0;
    Real x;

  algorithm
    x := (p - cf.saturationTemperature_iO[1])/cf.saturationTemperature_iO[2];
    for k in 1:cf.saturationTemperature_nT-1 loop
      T_1 := T_1 + cf.saturationTemperature_n[k]*x^
        (cf.saturationTemperature_nT - k);
    end for;
    T_1 := T_1 + cf.saturationTemperature_n[cf.saturationTemperature_nT];
    T := T_1*cf.saturationTemperature_iO[4] + cf.saturationTemperature_iO[3];
    annotation(Inline=false,
          LateInline=true);
  end saturationTemperature;

  redeclare function extends bubbleDensity
  "Boiling curve specific density of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real dl_1 = 0;
    Real x;

  algorithm
    x := (sat.Tsat - cf.bubbleDensity_iO[1])/cf.bubbleDensity_iO[2];
    for k in 1:cf.bubbleDensity_nT-1 loop
      dl_1 := dl_1 + cf.bubbleDensity_n[k]*x^(cf.bubbleDensity_nT - k);
    end for;
    dl_1 := dl_1 + cf.bubbleDensity_n[cf.bubbleDensity_nT];
    dl := dl_1*cf.bubbleDensity_iO[4] + cf.bubbleDensity_iO[3];
    annotation(Inline=false,
          LateInline=true);
  end bubbleDensity;

  redeclare function extends dewDensity
  "Dew curve specific density of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real dv_1 = 0;
    Real x;

  algorithm
    x := (sat.Tsat - cf.dewDensity_iO[1])/cf.dewDensity_iO[2];
    for k in 1:cf.dewDensity_nT-1 loop
      dv_1 := dv_1 + cf.dewDensity_n[k]*x^(cf.dewDensity_nT - k);
    end for;
    dv_1 := dv_1 + cf.dewDensity_n[cf.dewDensity_nT];
    dv := dv_1*cf.dewDensity_iO[4] + cf.dewDensity_iO[3];
    annotation(Inline=false,
          LateInline=true);
  end dewDensity;

  redeclare function extends bubbleEnthalpy
  "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real hl_1 = 0;
    Real x;

  algorithm
    x := (sat.psat - cf.bubbleEnthalpy_iO[1])/cf.bubbleEnthalpy_iO[2];
    for k in 1:cf.bubbleEnthalpy_nT-1 loop
      hl_1 := hl_1 + cf.bubbleEnthalpy_n[k]*x^(cf.bubbleEnthalpy_nT - k);
    end for;
    hl_1 := hl_1 + cf.bubbleEnthalpy_n[cf.bubbleEnthalpy_nT];
    hl := hl_1*cf.bubbleEnthalpy_iO[4] + cf.bubbleEnthalpy_iO[3];
    annotation(Inline=false,
          LateInline=true);
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
  "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real hv_1 = 0;
    Real x;

  algorithm
    x := (sat.psat - cf.dewEnthalpy_iO[1])/cf.dewEnthalpy_iO[2];
    for k in 1:cf.dewEnthalpy_nT-1 loop
      hv_1 := hv_1 + cf.dewEnthalpy_n[k]*x^(cf.dewEnthalpy_nT - k);
    end for;
    hv_1 := hv_1 + cf.dewEnthalpy_n[cf.dewEnthalpy_nT];
    hv := hv_1*cf.dewEnthalpy_iO[4] + cf.dewEnthalpy_iO[3];
    annotation(Inline=false,
          LateInline=true);
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
  "Boiling curve specific entropy of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real sl_1 = 0;
    Real x;

  algorithm
    x := (sat.psat - cf.bubbleEntropy_iO[1])/cf.bubbleEntropy_iO[2];
    for k in 1:cf.bubbleEntropy_nT-1 loop
      sl_1 := sl_1 + cf.bubbleEntropy_n[k]*x^(cf.bubbleEntropy_nT - k);
    end for;
    sl_1 := sl_1 + cf.bubbleEntropy_n[cf.bubbleEntropy_nT];
    sl := sl_1*cf.bubbleEntropy_iO[4] + cf.bubbleEntropy_iO[3];
    annotation(Inline=false,
          LateInline=true);
  end bubbleEntropy;

  redeclare function extends dewEntropy
  "Dew curve specific entropy of propane (Ancillary equation)"
  protected
    BDSP cf;
    Real sv_1 = 0;
    Real x;

  algorithm
    x := (sat.psat - cf.dewEntropy_iO[1])/cf.dewEntropy_iO[2];
    for k in 1:cf.dewEntropy_nT-1 loop
      sv_1 := sv_1 + cf.dewEntropy_n[k]*x^(cf.dewEntropy_nT - k);
    end for;
    sv_1 := sv_1 + cf.dewEntropy_n[cf.dewEntropy_nT];
    sv := sv_1*cf.dewEntropy_iO[4] + cf.dewEntropy_iO[3];
    annotation(Inline=false,
          LateInline=true);
  end dewEntropy;

  /*Provide functions that set the actual state depending on the given input
    parameters. Additionally, state functions for the two-phase region 
    are needed.  
    Just change these functions if needed.
  */
  redeclare function extends setDewState
  "Return thermodynamic state of refrigerant  on the dew line"
  algorithm
    state := ThermodynamicState(
       phase = phase,
       T = sat.Tsat,
       d = dewDensity(sat),
       p = saturationPressure(sat.Tsat),
       h = dewEnthalpy(sat));
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end setDewState;

  redeclare function extends setBubbleState
  "Return thermodynamic state of refrigerant on the bubble line"
  algorithm
    state := ThermodynamicState(
       phase = phase,
       T = sat.Tsat,
       d = bubbleDensity(sat),
       p = saturationPressure(sat.Tsat),
       h = bubbleEnthalpy(sat));
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end setBubbleState;

  redeclare function extends setState_dTX
  "Return thermodynamic state of refrigerant as function of d and T"
  algorithm
    state := ThermodynamicState(
      d = d,
      T = T,
      p = pressure_dT(d=d,T=T,phase=phase),
      h = specificEnthalpy_dT(d=d,T=T,phase=phase),
      phase = phase);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end setState_dTX;

  redeclare function extends setState_pTX
  "Return thermodynamic state of refrigerant as function of p and T"
  algorithm
    state := ThermodynamicState(
      d = density_pT(p=p,T=T,phase=phase),
      p = p,
      T = T,
      h = specificEnthalpy_pT(p=p,T=T,phase=phase),
      phase = phase);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end setState_pTX;

  redeclare function extends setState_phX
  "Return thermodynamic state of refrigerant as function of p and h"
  algorithm
    state:= ThermodynamicState(
      d = density_ph(p=p,h=h,phase=phase),
      p = p,
      T = temperature_ph(p=p,h=h,phase=phase),
      h = h,
      phase = phase);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end setState_phX;

  redeclare function extends setState_psX
  "Return thermodynamic state of refrigerant as function of p and s"
  algorithm
    state := ThermodynamicState(
      d = density_ps(p=p,s=s,phase=phase),
      p = p,
      T = temperature_ps(p=p,s=s,phase=phase),
      h = specificEnthalpy_ps(p=p,s=s,phase=phase),
      phase = phase);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end setState_psX;

  /*Provide functions to calculate thermodynamic properties using the EoS.
    Just change these functions if needed.
  */
  redeclare function extends pressure
  "Pressure of refrigerant"
  algorithm
      p := state.p;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end pressure;

  redeclare function extends temperature
  "Temperature of refrigerant"
  algorithm
    T := state.T;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end temperature;

  redeclare function extends density
  "Density of refrigerant"
  algorithm
    d := state.d;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end density;

  redeclare function extends specificEnthalpy
  "Specific enthalpy of refrigerant"
  algorithm
    h := state.h;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificEnthalpy;

  redeclare function extends specificInternalEnergy
  "Specific internal energy of refrigerant"
  algorithm
    u := specificEnthalpy(state)  - pressure(state)/state.d;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificInternalEnergy;

  redeclare function extends specificGibbsEnergy
  "Specific Gibbs energy of refrigerant"
  algorithm
    g := specificEnthalpy(state) - state.T*specificEntropy(state);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificGibbsEnergy;

  redeclare function extends specificHelmholtzEnergy
  "Specific Helmholtz energy of refrigerant"
  algorithm
    f := specificEnthalpy(state) - pressure(state)/state.d -
      state.T*specificEntropy(state);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificHelmholtzEnergy;

  redeclare function extends specificEntropy
  "Specific entropy of refrigerant"
  protected
    SpecificEntropy sl;
    SpecificEntropy sv;
    SaturationProperties sat = setSat_T(state.T);

    Real d_crit = fluidConstants[1].criticalMolarVolume;
    Real MM = fluidConstants[1].molarMass;
    Real R = Modelica.Constants.R/MM;
    Real tau = fluidConstants[1].criticalTemperature/state.T;
    Real delta;
    Real deltaL;
    Real deltaG;
    Real quality;

    Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
      dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
      then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      delta := state.d/(d_crit*MM);
      s := R*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(delta, tau) -
        alpha_0(delta, tau) - alpha_r(delta, tau));
    elseif state.phase==2 or phase_dT==2 then
      deltaL := bubbleDensity(sat)/(d_crit*MM);
      deltaG := dewDensity(sat)/(d_crit*MM);
      quality := (bubbleDensity(sat)/state.d - 1)/(bubbleDensity(sat)/dewDensity(
        sat) - 1);
      sl := R*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(deltaL, tau) -
        alpha_0(deltaL, tau) - alpha_r(deltaL, tau));
      sv := R*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(deltaG, tau) -
        alpha_0(deltaG, tau) - alpha_r(deltaG, tau));
       s := sl + quality*(sv-sl);
    end if;
  annotation(Inline=false,
          LateInline=true);
  end specificEntropy;

  redeclare function extends specificHeatCapacityCp
  "Specific heat capacity at constant pressure of refrigerant"
  protected
    SpecificHeatCapacity cpl;
    SpecificHeatCapacity cpv;
    SaturationProperties sat = setSat_T(state.T);

    Real d_crit = fluidConstants[1].criticalMolarVolume;
    Real MM = fluidConstants[1].molarMass;
    Real R = Modelica.Constants.R/MM;
    Real tau = fluidConstants[1].criticalTemperature/state.T;
    Real delta;
    Real deltaL;
    Real deltaG;
    Real quality;

    Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
      dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
      then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      delta :=state.d/(d_crit*MM);
      cp := specificHeatCapacityCv(state) + R*((1 +
        delta_d_alpha_r_d_delta(delta, tau) -
        tau_delta_d2_alpha_r_d_tau_d_delta(delta, tau))^2)/(1 + 2*
        delta_d_alpha_r_d_delta(delta, tau) +
        delta2_d2_alpha_r_d_delta2(delta, tau));
    elseif state.phase==2 or phase_dT==2 then
      deltaL :=bubbleDensity(sat)/(d_crit*MM);
      deltaG :=dewDensity(sat)/(d_crit*MM);
      quality := (bubbleDensity(sat)/state.d - 1)/(bubbleDensity(sat)/dewDensity(
        sat) - 1);
      cpl := specificHeatCapacityCv(setBubbleState(sat)) + R*((1 +
        delta_d_alpha_r_d_delta(deltaL, tau) -
        tau_delta_d2_alpha_r_d_tau_d_delta(deltaL, tau))^2)/(1 + 2*
        delta_d_alpha_r_d_delta(deltaL, tau) +
        delta2_d2_alpha_r_d_delta2(deltaL, tau));
      cpv := specificHeatCapacityCv(setDewState(sat)) + R*((1 +
        delta_d_alpha_r_d_delta(deltaG, tau) -
        tau_delta_d2_alpha_r_d_tau_d_delta(deltaG, tau))^2)/(1 + 2*
        delta_d_alpha_r_d_delta(deltaG, tau) +
        delta2_d2_alpha_r_d_delta2(deltaG, tau));
      cp := cpl + quality*(cpv-cpl);
    end if;
  annotation(Inline=false,
          LateInline=true);
  end specificHeatCapacityCp;

  redeclare function extends specificHeatCapacityCv
    "Specific heat capacity at constant volume of refrigerant"
  protected
    SpecificHeatCapacity cvl;
    SpecificHeatCapacity cvv;
    SaturationProperties sat = setSat_T(state.T);

    Real d_crit = fluidConstants[1].criticalMolarVolume;
    Real MM = fluidConstants[1].molarMass;
    Real R = Modelica.Constants.R/MM;
    Real tau = fluidConstants[1].criticalTemperature/state.T;
    Real delta;
    Real deltaL;
    Real deltaG;
    Real quality;

    Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
       dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
       then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      delta :=state.d/(d_crit*MM);
      cv := -R*(tau2_d2_alpha_0_d_tau2(tau) +
        tau2_d2_alpha_r_d_tau2(delta, tau));
    elseif state.phase==2 or phase_dT==2 then
      deltaL :=bubbleDensity(sat)/(d_crit*MM);
      deltaG :=dewDensity(sat)/(d_crit*MM);
      quality := (bubbleDensity(sat)/state.d - 1)/(bubbleDensity(sat)/dewDensity(
        sat) - 1);
      cvl := -R*(tau2_d2_alpha_0_d_tau2(tau) +
        tau2_d2_alpha_r_d_tau2(deltaL, tau));
      cvv := -R*(tau2_d2_alpha_0_d_tau2(tau) +
        tau2_d2_alpha_r_d_tau2(deltaG, tau));
      cv := cvl + quality*(cvv-cvl);
    end if;
  annotation(Inline=false,
          LateInline=true);
  end specificHeatCapacityCv;

  redeclare function extends velocityOfSound
    "Velocity of sound of refrigerant"
  protected
    VelocityOfSound aL;
    VelocityOfSound aG;
    SaturationProperties sat = setSat_T(state.T);

    Real d_crit = fluidConstants[1].criticalMolarVolume;
    Real MM = fluidConstants[1].molarMass;
    Real R = Modelica.Constants.R/MM;
    Real tau = fluidConstants[1].criticalTemperature/state.T;
    Real delta;
    Real deltaL;
    Real deltaG;
    Real quality;

    Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
      dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
      then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      delta :=state.d/(d_crit*MM);
      a := (R*state.T*(1+2*delta_d_alpha_r_d_delta(delta,tau)+
        delta2_d2_alpha_r_d_delta2(delta,tau)-(1+
        delta_d_alpha_r_d_delta(delta,tau)-
        tau_delta_d2_alpha_r_d_tau_d_delta(delta,tau))^2/(
        tau2_d2_alpha_0_d_tau2(tau)+tau2_d2_alpha_r_d_tau2(delta,tau))))^0.5;
    elseif state.phase==2 or phase_dT==2 then
      deltaL :=bubbleDensity(sat)/(d_crit*MM);
      deltaG :=dewDensity(sat)/(d_crit*MM);
      quality := (bubbleDensity(sat)/state.d - 1)/(bubbleDensity(sat)/dewDensity(
        sat) - 1);
      aG := (R*state.T*(1+2*delta_d_alpha_r_d_delta(deltaL,tau)+
        delta2_d2_alpha_r_d_delta2(deltaL,tau)-(1+
        delta_d_alpha_r_d_delta(deltaL,tau)-
        tau_delta_d2_alpha_r_d_tau_d_delta(deltaL,tau))^2/(
        tau2_d2_alpha_0_d_tau2(tau)+tau2_d2_alpha_r_d_tau2(deltaL,tau))))^0.5;
      aL := (R*state.T*(1+2*delta_d_alpha_r_d_delta(deltaG,tau)+
        delta2_d2_alpha_r_d_delta2(deltaG,tau)-(1+
        delta_d_alpha_r_d_delta(deltaG,tau)-
        tau_delta_d2_alpha_r_d_tau_d_delta(deltaG,tau))^2/(
        tau2_d2_alpha_0_d_tau2(tau)+tau2_d2_alpha_r_d_tau2(deltaG,tau))))^0.5;
      a:=aL + quality*(aG-aL);
    end if;
  annotation(Inline=false,
          LateInline=true);
  end velocityOfSound;

  redeclare function extends isobaricExpansionCoefficient
  "Isobaric expansion coefficient beta of refrigerant"
  protected
    IsobaricExpansionCoefficient betal;
    IsobaricExpansionCoefficient betav;
    SaturationProperties sat = setSat_T(state.T);

    Real quality;

    Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
      dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
      then 1 else 2;

  algorithm
     if state.phase==1 or phase_dT==1 then
       beta := -1/state.d * pressure_derT_d(state) *
         pressure_derd_T(state)^(-1);
     elseif state.phase==2 or phase_dT==2 then
      quality := (bubbleDensity(sat)/state.d - 1)/(bubbleDensity(sat)/dewDensity(
        sat) - 1);
      betal := -1/bubbleDensity(sat) * pressure_derT_d(setBubbleState(sat)) *
        pressure_derd_T(setBubbleState(sat))^(-1);
      betav := -1/dewDensity(sat) * pressure_derT_d(setDewState(sat)) *
        pressure_derd_T(setDewState(sat))^(-1);
      beta := betal + quality*(betav-betal);
     end if;
  annotation(Inline=false,
          LateInline=true);
  end isobaricExpansionCoefficient;

  redeclare function extends isothermalCompressibility
  "Isothermal compressibility factor of refrigerant"
  protected
    Modelica.SIunits.IsothermalCompressibility kappal;
    Modelica.SIunits.IsothermalCompressibility kappav;
    SaturationProperties sat = setSat_T(state.T);

    Real quality;

    Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
      dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
      then 1 else 2;

  algorithm
     if state.phase==1 or phase_dT==1 then
      kappa := 1/state.d *  pressure_derd_T(state)^(-1);
     elseif state.phase==2 or phase_dT==2 then
      quality := if state.phase==2 then (bubbleDensity(sat)/
        state.d - 1)/(bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
      kappal := 1/bubbleDensity(sat) *
        pressure_derd_T(setBubbleState(sat))^(-1);
      kappav := 1/dewDensity(sat) * pressure_derd_T(setDewState(sat))^(-1);
      kappa := kappal + quality*(kappav-kappal);
     end if;
  annotation(Inline=false,
          LateInline=true);
  end isothermalCompressibility;

  replaceable function isothermalThrottlingCoefficient
  "Isothermal throttling coefficient of refrigerant"
    input ThermodynamicState state "Thermodynamic state";
    output Real delta_T(unit="J/(Pa.kg)") "Isothermal throttling coefficient";

  protected
    Real delta_Tl;
    Real delta_Tv;
    SaturationProperties sat = setSat_T(state.T);

    Real quality;

    Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
      dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
      then 1 else 2;

  algorithm
     if state.phase==1 or phase_dT==1 then
       delta_T := specificEnthalpy_derd_T(state) *  pressure_derd_T(state)^(-1);
     elseif state.phase==2 or phase_dT==2 then
       quality := if state.phase==2 then (bubbleDensity(sat)/
         state.d - 1)/(bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
       delta_Tl := specificEnthalpy_derd_T(setBubbleState(sat)) *
         pressure_derd_T(setBubbleState(sat))^(-1);
       delta_Tv := specificEnthalpy_derd_T(setDewState(sat)) *
         pressure_derd_T(setDewState(sat))^(-1);
       delta_T := delta_Tl + quality*(delta_Tv-delta_Tl);
     end if;
  annotation(Inline=false,
          LateInline=true);
  end isothermalThrottlingCoefficient;

  replaceable function jouleThomsonCoefficient
  "Joule-Thomson coefficient of refrigerant"
    input ThermodynamicState state "Thermodynamic state";
    output Real my(unit="K/Pa") "Isothermal throttling coefficient";

  protected
    Real myl;
    Real myv;
    SaturationProperties sat = setSat_T(state.T);

    Real quality;

    Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
      dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
      then 1 else 2;

  algorithm
     if state.phase==1 or phase_dT==1 then
       my := temperature_derp_h(state);
     elseif state.phase==2 or phase_dT==2 then
       quality := if state.phase==2 then (bubbleDensity(sat)/
         state.d - 1)/(bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
       myl := temperature_derp_h(setBubbleState(sat));
       myv := temperature_derp_h(setDewState(sat));
       my := myl + quality*(myv-myl);
     end if;
  annotation(Inline=false,
          LateInline=true);
  end jouleThomsonCoefficient;


  /*Provide functions to calculate thermodynamic properties depending on the
    independent variables. Moreover, these functions may depend on the Helmholtz
    EoS. Just change these functions if needed.
  */
  redeclare function pressure_dT
  "Computes pressure as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase "2 for two-phase, 1 for one-phase, 0 if not known";
    output AbsolutePressure p "Pressure";

  protected
    SaturationProperties sat = setSat_T(T);
    Real phase_dT = if not ((d < bubbleDensity(sat) and d > dewDensity(sat))
      and T < fluidConstants[1].criticalTemperature) then 1 else 2;

  algorithm
    if phase_dT == 1 or phase == 1 then
      p := d*Modelica.Constants.R/fluidConstants[1].molarMass*T*
        (1+delta_d_alpha_r_d_delta(delta = d/(
        fluidConstants[1].criticalMolarVolume*fluidConstants[1].molarMass),
        tau = fluidConstants[1].criticalTemperature/T));
    elseif phase_dT == 2 or phase == 2 then
      p := saturationPressure(T);
    end if;
  annotation(derivative(noDerivative=phase)=pressure_dT_der,
          inverse(d=density_pT(p=p,T=T,phase=phase)),
          Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end pressure_dT;

  redeclare replaceable function temperature_ph
  "Calculates temperature as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";

  protected
    TSP cf;
    SmoothTransition st;

    SpecificEnthalpy dh = st.T_ph;
    SpecificEnthalpy h_dew;
    SpecificEnthalpy h_bubble;

    Real x1;
    Real y1;
    Real T1;
    Real x2;
    Real y2;
    Real T2;

  algorithm
    h_dew := dewEnthalpy(sat = setSat_p(p=p));
    h_bubble := bubbleEnthalpy(sat = setSat_p(p=p));

    if h<h_bubble-dh then
      x1 := (p-cf.temperature_ph_iO[1])/cf.temperature_ph_iO[3];
      y1 := (h-cf.temperature_ph_iO[2])/cf.temperature_ph_iO[4];
      T := cf.temperature_ph_sc[1] + cf.temperature_ph_sc[2]*x1 +
        cf.temperature_ph_sc[3]*y1 + cf.temperature_ph_sc[4]*x1^2 +
        cf.temperature_ph_sc[5]*x1*y1 + cf.temperature_ph_sc[6]*y1^2 +
        cf.temperature_ph_sc[7]*x1^3 + cf.temperature_ph_sc[8]*x1^2*y1 +
        cf.temperature_ph_sc[9]*x1*y1^2 + cf.temperature_ph_sc[10]*y1^3 +
        cf.temperature_ph_sc[11]*x1^4 + cf.temperature_ph_sc[12]*x1^3*y1 +
        cf.temperature_ph_sc[13]*x1^2*y1^2 + cf.temperature_ph_sc[14]*x1*y1^3 +
        cf.temperature_ph_sc[15]*y1^4 + cf.temperature_ph_sc[16]*x1^5 +
        cf.temperature_ph_sc[17]*x1^4*y1 + cf.temperature_ph_sc[18]*x1^3*y1^2 +
        cf.temperature_ph_sc[19]*x1^2*y1^3 + cf.temperature_ph_sc[20]*x1*y1^4 +
        cf.temperature_ph_sc[21]*y1^5;
    elseif h>h_dew+dh then
      x2 := (p-cf.temperature_ph_iO[5])/cf.temperature_ph_iO[7];
      y2 := (h-cf.temperature_ph_iO[6])/cf.temperature_ph_iO[8];
      T := cf.temperature_ph_sh[1] + cf.temperature_ph_sh[2]*x2 +
        cf.temperature_ph_sh[3]*y2 + cf.temperature_ph_sh[4]*x2^2 +
        cf.temperature_ph_sh[5]*x2*y2 + cf.temperature_ph_sh[6]*y2^2 +
        cf.temperature_ph_sh[7]*x2^3 + cf.temperature_ph_sh[8]*x2^2*y2 +
        cf.temperature_ph_sh[9]*x2*y2^2 + cf.temperature_ph_sh[10]*y2^3 +
        cf.temperature_ph_sh[11]*x2^4 + cf.temperature_ph_sh[12]*x2^3*y2 +
        cf.temperature_ph_sh[13]*x2^2*y2^2 + cf.temperature_ph_sh[14]*x2*y2^3 +
        cf.temperature_ph_sh[15]*y2^4 + cf.temperature_ph_sh[16]*x2^5 +
        cf.temperature_ph_sh[17]*x2^4*y2 + cf.temperature_ph_sh[18]*x2^3*y2^2 +
        cf.temperature_ph_sh[19]*x2^2*y2^3 + cf.temperature_ph_sh[20]*x2*y2^4 +
        cf.temperature_ph_sh[21]*y2^5;
    else
      if h<h_bubble then
        x1 := (p-cf.temperature_ph_iO[1])/cf.temperature_ph_iO[3];
        y1 := (h-cf.temperature_ph_iO[2])/cf.temperature_ph_iO[4];
        T1 := cf.temperature_ph_sc[1] + cf.temperature_ph_sc[2]*x1 +
          cf.temperature_ph_sc[3]*y1 + cf.temperature_ph_sc[4]*x1^2 +
          cf.temperature_ph_sc[5]*x1*y1 + cf.temperature_ph_sc[6]*y1^2 +
          cf.temperature_ph_sc[7]*x1^3 + cf.temperature_ph_sc[8]*x1^2*y1 +
          cf.temperature_ph_sc[9]*x1*y1^2 + cf.temperature_ph_sc[10]*y1^3 +
          cf.temperature_ph_sc[11]*x1^4 + cf.temperature_ph_sc[12]*x1^3*y1 +
          cf.temperature_ph_sc[13]*x1^2*y1^2 + cf.temperature_ph_sc[14]*x1*y1^3 +
          cf.temperature_ph_sc[15]*y1^4 + cf.temperature_ph_sc[16]*x1^5 +
          cf.temperature_ph_sc[17]*x1^4*y1 + cf.temperature_ph_sc[18]*x1^3*y1^2 +
          cf.temperature_ph_sc[19]*x1^2*y1^3 + cf.temperature_ph_sc[20]*x1*y1^4 +
          cf.temperature_ph_sc[21]*y1^5;
        T := saturationTemperature(p)*(1 - (h_bubble - h)/dh) +
          T1*(h_bubble - h)/dh;
      elseif h>h_dew then
        x2 := (p-cf.temperature_ph_iO[5])/cf.temperature_ph_iO[7];
        y2 := (h-cf.temperature_ph_iO[6])/cf.temperature_ph_iO[8];
        T2 := cf.temperature_ph_sh[1] + cf.temperature_ph_sh[2]*x2 +
          cf.temperature_ph_sh[3]*y2 + cf.temperature_ph_sh[4]*x2^2 +
          cf.temperature_ph_sh[5]*x2*y2 + cf.temperature_ph_sh[6]*y2^2 +
          cf.temperature_ph_sh[7]*x2^3 + cf.temperature_ph_sh[8]*x2^2*y2 +
          cf.temperature_ph_sh[9]*x2*y2^2 + cf.temperature_ph_sh[10]*y2^3 +
          cf.temperature_ph_sh[11]*x2^4 + cf.temperature_ph_sh[12]*x2^3*y2 +
          cf.temperature_ph_sh[13]*x2^2*y2^2 + cf.temperature_ph_sh[14]*x2*y2^3 +
          cf.temperature_ph_sh[15]*y2^4 + cf.temperature_ph_sh[16]*x2^5 +
          cf.temperature_ph_sh[17]*x2^4*y2 + cf.temperature_ph_sh[18]*x2^3*y2^2 +
          cf.temperature_ph_sh[19]*x2^2*y2^3 + cf.temperature_ph_sh[20]*x2*y2^4 +
          cf.temperature_ph_sh[21]*y2^5;
        T := saturationTemperature(p)*(1 - (h - h_dew)/dh) +
          T2*(h - h_dew)/dh;
      else
        T := saturationTemperature(p);
      end if;
    end if;
  annotation(derivative(noDerivative=phase)=temperature_ph_der,
      inverse(h=specificEnthalpy_pT(p=p,T=T,phase=phase)),
          Inline=false,
          LateInline=true);
  end temperature_ph;

  redeclare replaceable function temperature_ps
  "Calculates temperature as function of pressure and specific entroy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Temperature T "Temperature";

  protected
    TSP cf;
    SmoothTransition st;

    SpecificEntropy ds = st.T_ps;
    SpecificEntropy s_dew;
    SpecificEntropy s_bubble;

    Real x1;
    Real y1;
    Real T1;
    Real x2;
    Real y2;
    Real T2;

  algorithm
    s_dew := dewEntropy(sat = setSat_p(p=p));
    s_bubble := bubbleEntropy(sat = setSat_p(p=p));

    if s<s_bubble-ds then
      x1 := (log(p)-cf.temperature_ps_iO[1])/cf.temperature_ps_iO[3];
      y1 := (s-cf.temperature_ps_iO[2])/cf.temperature_ps_iO[4];
      T := cf.temperature_ps_sc[1] + cf.temperature_ps_sc[2]*x1 +
        cf.temperature_ps_sc[3]*y1 + cf.temperature_ps_sc[4]*x1^2 +
        cf.temperature_ps_sc[5]*x1*y1 + cf.temperature_ps_sc[6]*y1^2 +
        cf.temperature_ps_sc[7]*x1^3 + cf.temperature_ps_sc[8]*x1^2*y1 +
        cf.temperature_ps_sc[9]*x1*y1^2 + cf.temperature_ps_sc[10]*y1^3 +
        cf.temperature_ps_sc[11]*x1^4 + cf.temperature_ps_sc[12]*x1^3*y1 +
        cf.temperature_ps_sc[13]*x1^2*y1^2 + cf.temperature_ps_sc[14]*x1*y1^3 +
        cf.temperature_ps_sc[15]*y1^4 + cf.temperature_ps_sc[16]*x1^5 +
        cf.temperature_ps_sc[17]*x1^4*y1 + cf.temperature_ps_sc[18]*x1^3*y1^2 +
        cf.temperature_ps_sc[19]*x1^2*y1^3 + cf.temperature_ps_sc[20]*x1*y1^4 +
        cf.temperature_ps_sc[21]*y1^5;
    elseif s>s_dew+ds then
        x2 := (log(p)-cf.temperature_ps_iO[5])/cf.temperature_ps_iO[7];
        y2 := (s-cf.temperature_ps_iO[6])/cf.temperature_ps_iO[8];
        T := cf.temperature_ps_sh[1] + cf.temperature_ps_sh[2]*x2 +
          cf.temperature_ps_sh[3]*y2 + cf.temperature_ps_sh[4]*x2^2 +
          cf.temperature_ps_sh[5]*x2*y2 + cf.temperature_ps_sh[6]*y2^2 +
          cf.temperature_ps_sh[7]*x2^3 + cf.temperature_ps_sh[8]*x2^2*y2 +
          cf.temperature_ps_sh[9]*x2*y2^2 + cf.temperature_ps_sh[10]*y2^3 +
          cf.temperature_ps_sh[11]*x2^4 + cf.temperature_ps_sh[12]*x2^3*y2 +
          cf.temperature_ps_sh[13]*x2^2*y2^2 + cf.temperature_ps_sh[14]*x2*y2^3 +
          cf.temperature_ps_sh[15]*y2^4 + cf.temperature_ps_sh[16]*x2^5 +
          cf.temperature_ps_sh[17]*x2^4*y2 + cf.temperature_ps_sh[18]*x2^3*y2^2 +
          cf.temperature_ps_sh[19]*x2^2*y2^3 + cf.temperature_ps_sh[20]*x2*y2^4 +
          cf.temperature_ps_sh[21]*y2^5;
    else
      if s<s_bubble then
        x1 := (log(p)-cf.temperature_ps_iO[1])/cf.temperature_ps_iO[3];
        y1 := (s-cf.temperature_ps_iO[2])/cf.temperature_ps_iO[4];
        T1 := cf.temperature_ps_sc[1] + cf.temperature_ps_sc[2]*x1 +
          cf.temperature_ps_sc[3]*y1 + cf.temperature_ps_sc[4]*x1^2 +
          cf.temperature_ps_sc[5]*x1*y1 + cf.temperature_ps_sc[6]*y1^2 +
          cf.temperature_ps_sc[7]*x1^3 + cf.temperature_ps_sc[8]*x1^2*y1 +
          cf.temperature_ps_sc[9]*x1*y1^2 + cf.temperature_ps_sc[10]*y1^3 +
          cf.temperature_ps_sc[11]*x1^4 + cf.temperature_ps_sc[12]*x1^3*y1 +
          cf.temperature_ps_sc[13]*x1^2*y1^2 + cf.temperature_ps_sc[14]*x1*y1^3 +
          cf.temperature_ps_sc[15]*y1^4 + cf.temperature_ps_sc[16]*x1^5 +
          cf.temperature_ps_sc[17]*x1^4*y1 + cf.temperature_ps_sc[18]*x1^3*y1^2 +
          cf.temperature_ps_sc[19]*x1^2*y1^3 + cf.temperature_ps_sc[20]*x1*y1^4 +
          cf.temperature_ps_sc[21]*y1^5;
        T := saturationTemperature(p)*(1 - (s_bubble - s)/ds) +
          T1*(s_bubble - s)/ds;
      elseif s>s_dew then
        x2 := (log(p)-cf.temperature_ps_iO[5])/cf.temperature_ps_iO[7];
        y2 := (s-cf.temperature_ps_iO[6])/cf.temperature_ps_iO[8];
        T2 := cf.temperature_ps_sh[1] + cf.temperature_ps_sh[2]*x2 +
          cf.temperature_ps_sh[3]*y2 + cf.temperature_ps_sh[4]*x2^2 +
          cf.temperature_ps_sh[5]*x2*y2 + cf.temperature_ps_sh[6]*y2^2 +
          cf.temperature_ps_sh[7]*x2^3 + cf.temperature_ps_sh[8]*x2^2*y2 +
          cf.temperature_ps_sh[9]*x2*y2^2 + cf.temperature_ps_sh[10]*y2^3 +
          cf.temperature_ps_sh[11]*x2^4 + cf.temperature_ps_sh[12]*x2^3*y2 +
          cf.temperature_ps_sh[13]*x2^2*y2^2 + cf.temperature_ps_sh[14]*x2*y2^3 +
          cf.temperature_ps_sh[15]*y2^4 + cf.temperature_ps_sh[16]*x2^5 +
          cf.temperature_ps_sh[17]*x2^4*y2 + cf.temperature_ps_sh[18]*x2^3*y2^2 +
          cf.temperature_ps_sh[19]*x2^2*y2^3 + cf.temperature_ps_sh[20]*x2*y2^4 +
          cf.temperature_ps_sh[21]*y2^5;
        T := saturationTemperature(p)*(1 - (s - s_dew)/ds) +
          T2*(s - s_dew)/ ds;
      else
        T := saturationTemperature(p);
      end if;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end temperature_ps;

  redeclare replaceable partial function density_pT
  "Computes density as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";

  protected
    TSP cf;
    SmoothTransition st;

    AbsolutePressure dp = st.d_pT;
    SaturationProperties sat = setSat_T(T=T);

    Real x1;
    Real y1;
    Real d1;
    Real x2;
    Real y2;
    Real d2;

  algorithm
    if p<sat.psat-dp then
      x1 := (p-cf.density_pT_iO[1])/cf.density_pT_iO[3];
      y1 := (T-cf.density_pT_iO[2])/cf.density_pT_iO[4];
      d := cf.density_pT_sc[1] + cf.density_pT_sc[2]*x1 +
        cf.density_pT_sc[3]*y1 + cf.density_pT_sc[4]*x1^2 +
        cf.density_pT_sc[5]*x1*y1 + cf.density_pT_sc[6]*y1^2 +
        cf.density_pT_sc[7]*x1^3 + cf.density_pT_sc[8]*x1^2*y1 +
        cf.density_pT_sc[9]*x1*y1^2 + cf.density_pT_sc[10]*y1^3 +
        cf.density_pT_sc[11]*x1^4 + cf.density_pT_sc[12]*x1^3*y1 +
        cf.density_pT_sc[13]*x1^2*y1^2 + cf.density_pT_sc[14]*x1*y1^3 +
        cf.density_pT_sc[15]*y1^4 + cf.density_pT_sc[16]*x1^5 +
        cf.density_pT_sc[17]*x1^4*y1 + cf.density_pT_sc[18]*x1^3*y1^2 +
        cf.density_pT_sc[19]*x1^2*y1^3 + cf.density_pT_sc[20]*x1*y1^4 +
        cf.density_pT_sc[21]*y1^5;
    elseif p>sat.psat+dp then
      x2 := (p-cf.density_pT_iO[5])/cf.density_pT_iO[7];
      y2 := (T-cf.density_pT_iO[6])/cf.density_pT_iO[8];
      d := cf.density_pT_sh[1] + cf.density_pT_sh[2]*x2 +
        cf.density_pT_sh[3]*y2 + cf.density_pT_sh[4]*x2^2 +
        cf.density_pT_sh[5]*x2*y2 + cf.density_pT_sh[6]*y2^2 +
        cf.density_pT_sh[7]*x2^3 + cf.density_pT_sh[8]*x2^2*y2 +
        cf.density_pT_sh[9]*x2*y2^2 + cf.density_pT_sh[10]*y2^3 +
        cf.density_pT_sh[11]*x2^4 + cf.density_pT_sh[12]*x2^3*y2 +
        cf.density_pT_sh[13]*x2^2*y2^2 + cf.density_pT_sh[14]*x2*y2^3 +
        cf.density_pT_sh[15]*y2^4 + cf.density_pT_sh[16]*x2^5 +
        cf.density_pT_sh[17]*x2^4*y2 + cf.density_pT_sh[18]*x2^3*y2^2 +
        cf.density_pT_sh[19]*x2^2*y2^3 + cf.density_pT_sh[20]*x2*y2^4 +
        cf.density_pT_sh[21]*y2^5;
    else
      if p<sat.psat then
        x1 := (p-cf.density_pT_iO[1])/cf.density_pT_iO[3];
        y1 := (T-cf.density_pT_iO[2])/cf.density_pT_iO[4];
        d1 := cf.density_pT_sc[1] + cf.density_pT_sc[2]*x1 +
          cf.density_pT_sc[3]*y1 + cf.density_pT_sc[4]*x1^2 +
          cf.density_pT_sc[5]*x1*y1 + cf.density_pT_sc[6]*y1^2 +
          cf.density_pT_sc[7]*x1^3 + cf.density_pT_sc[8]*x1^2*y1 +
          cf.density_pT_sc[9]*x1*y1^2 + cf.density_pT_sc[10]*y1^3 +
          cf.density_pT_sc[11]*x1^4 + cf.density_pT_sc[12]*x1^3*y1 +
          cf.density_pT_sc[13]*x1^2*y1^2 + cf.density_pT_sc[14]*x1*y1^3 +
          cf.density_pT_sc[15]*y1^4 + cf.density_pT_sc[16]*x1^5 +
          cf.density_pT_sc[17]*x1^4*y1 + cf.density_pT_sc[18]*x1^3*y1^2 +
          cf.density_pT_sc[19]*x1^2*y1^3 + cf.density_pT_sc[20]*x1*y1^4 +
          cf.density_pT_sc[21]*y1^5;
        d := bubbleDensity(sat)*(1 -(sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
      elseif p>=sat.psat then
        x2 := (p-cf.density_pT_iO[5])/cf.density_pT_iO[7];
        y2 := (T-cf.density_pT_iO[6])/cf.density_pT_iO[8];
        d2 := cf.density_pT_sh[1] + cf.density_pT_sh[2]*x2 +
          cf.density_pT_sh[3]*y2 + cf.density_pT_sh[4]*x2^2 +
          cf.density_pT_sh[5]*x2*y2 + cf.density_pT_sh[6]*y2^2 +
          cf.density_pT_sh[7]*x2^3 + cf.density_pT_sh[8]*x2^2*y2 +
          cf.density_pT_sh[9]*x2*y2^2 + cf.density_pT_sh[10]*y2^3 +
          cf.density_pT_sh[11]*x2^4 + cf.density_pT_sh[12]*x2^3*y2 +
          cf.density_pT_sh[13]*x2^2*y2^2 + cf.density_pT_sh[14]*x2*y2^3 +
          cf.density_pT_sh[15]*y2^4 + cf.density_pT_sh[16]*x2^5 +
          cf.density_pT_sh[17]*x2^4*y2 + cf.density_pT_sh[18]*x2^3*y2^2 +
          cf.density_pT_sh[19]*x2^2*y2^3 + cf.density_pT_sh[20]*x2*y2^4 +
          cf.density_pT_sh[21]*y2^5;
        d := dewDensity(sat)*(1 -(p - sat.psat)/dp) + d2*(p - sat.psat)/dp;
      end if;
    end if;
  annotation(inverse(p=pressure_dT(d=d,T=T,phase=phase)),
          Inline=false,
          LateInline=true);
  end density_pT;

  redeclare replaceable function density_ph
  "Computes density as a function of pressure and enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";

  protected
    SmoothTransition st;

    SpecificEnthalpy dh = st.d_ph;
    SaturationProperties sat;
    SpecificEnthalpy h_dew;
    SpecificEnthalpy h_bubble;

  algorithm
    sat := setSat_p(p=p);
    h_dew := dewEnthalpy(sat);
    h_bubble := bubbleEnthalpy(sat);

    if h<h_bubble-dh or h>h_dew+dh then
      d := density_pT(p=p,T=temperature_ph(p=p,h=h));
    else
      if h<h_bubble then
        d := bubbleDensity(sat)*(1 - (h_bubble - h)/dh) + density_pT(
          p=p,T=temperature_ph(p=p,h=h))*(h_bubble - h)/dh;
      elseif h>h_dew then
        d := dewDensity(sat)*(1 - (h - h_dew)/dh) + density_pT(
          p=p,T=temperature_ph(p=p,h=h))*(h - h_dew)/dh;
      else
        d := 1/((1-(h-h_bubble)/(h_dew-h_bubble))/bubbleDensity(sat) +
          ((h-h_bubble)/(h_dew-h_bubble))/dewDensity(sat));
      end if;
    end if;
  annotation(derivative(noDerivative=phase)=density_ph_der,
          Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end density_ph;

  redeclare replaceable function density_ps
  "Computes density as a function of pressure and entropy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Temperature";

  protected
    SmoothTransition st;

    SpecificEntropy ds = p*st.d_ps;
    SaturationProperties sat;
    SpecificEntropy s_dew;
    SpecificEntropy s_bubble;

  algorithm
    sat := setSat_p(p=p);
    s_dew := dewEntropy(sat);
    s_bubble := bubbleEntropy(sat);

    if s<s_bubble-ds or s>s_dew+ds then
      d:=density_pT(p=p,T=temperature_ps(p=p,s=s,phase=phase));
    else
      if s<s_bubble then
        d:=bubbleDensity(sat)*(1 - (s_bubble - s)/ds) + density_pT(
          p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*
          (s_bubble - s)/ds;
      elseif s>s_dew then
        d:=dewDensity(sat)*(1 - (s - s_dew)/ds) + density_pT(
          p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*
          (s - s_dew)/ds;
      else
        d:=1/((1-(s-s_bubble)/(s_dew-s_bubble))/bubbleDensity(sat) +
          ((s-s_bubble)/(s_dew-s_bubble))/dewDensity(sat));
      end if;
    end if;
  annotation(Inline=false,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end density_ps;

  redeclare function specificEnthalpy_pT
  "Computes specific enthalpy as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "Specific enthalpy";

  algorithm
    h := specificEnthalpy_dT(density_pT(p,T,phase),T,phase);
  annotation(inverse(T=temperature_ph(p=p,h=h,phase=phase)),
          Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificEnthalpy_pT;

  redeclare function specificEnthalpy_dT
    "Computes specific enthalpy as a function of density and temperature"
    extends Modelica.Icons.Function;
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "Specific enthalpy";

  protected
    Real hl=0;
    Real hv=0;

    Real d_crit = fluidConstants[1].criticalMolarVolume;
    Real MM = fluidConstants[1].molarMass;
    Real R = Modelica.Constants.R/MM;
    Real tau = fluidConstants[1].criticalTemperature/T;
    Real delta;
    Real dewDelta;
    Real bubbleDelta;
    Real quality;

    SaturationProperties sat = setSat_T(T);
    Real phase_dT = if not ((d < bubbleDensity(sat) and d > dewDensity(sat))
      and T < fluidConstants[1].criticalTemperature) then 1 else 2;

  algorithm
    if phase_dT == 1 or phase == 1 then
      delta := d/(d_crit*MM);
      h := R*T*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(delta, tau) +
        delta_d_alpha_r_d_delta(delta, tau) + 1);
    elseif phase_dT == 2 or phase == 2 then
      dewDelta := dewDensity(sat)/(d_crit*MM);
      bubbleDelta := bubbleDensity(sat)/(d_crit*MM);
      quality := if phase==2 or phase_dT==2 then (bubbleDensity(sat)/d - 1)/
        (bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
      hl := R*T*(tau_d_alpha_0_d_tau(tau) +
        tau_d_alpha_r_d_tau(bubbleDelta, tau) + delta_d_alpha_r_d_delta(
        bubbleDelta, tau) + 1);
      hv := R*T*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(dewDelta, tau) +
        delta_d_alpha_r_d_delta(dewDelta, tau) + 1);
      h := hl + quality*(hv-hl);
    end if;
  annotation(derivative(noDerivative=phase)=specificEnthalpy_dT_der,
          Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificEnthalpy_dT;

  redeclare replaceable function specificEnthalpy_ps
  "Computes specific enthalpy as a function of pressure and entropy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEntropy s "Specific entropy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output SpecificEnthalpy h "Specific enthalpy";

  protected
    SmoothTransition st;

    SpecificEntropy ds = p*st.h_ps;
    SaturationProperties sat;
    SpecificEntropy s_dew;
    SpecificEntropy s_bubble;
    SpecificEnthalpy h_dew;
    SpecificEnthalpy h_bubble;

  algorithm
    sat := setSat_p(p=p);
    s_dew := dewEntropy(sat);
    s_bubble := bubbleEntropy(sat);

    if s<s_bubble-ds or s>s_dew+ds then
      h := specificEnthalpy_pT(p=p,T=temperature_ps(
        p=p,s=s,phase=phase),phase=phase);
    else
      h_dew := dewEnthalpy(sat);
      h_bubble := bubbleEnthalpy(sat);
      if s<s_bubble then
        h := h_bubble*(1 - (s_bubble - s)/ds) + specificEnthalpy_pT(
          p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*
          (s_bubble - s)/ds;
      elseif s>s_dew then
        h := h_dew*(1 - (s - s_dew)/ds) + specificEnthalpy_pT(
          p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*
          (s - s_dew)/ds;
      else
        h := h_bubble+(s-s_bubble)/(s_dew-s_bubble)*(h_dew-h_bubble);
      end if;
    end if;
  annotation(Inline=false,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificEnthalpy_ps;

  /*Provide functions partial derivatives. These functions may depend on the
    Helmholtz EoS and are needed to calculate thermodynamic properties.  
    Just change these functions if needed.
  */
  replaceable function pressure_dT_der
  "Calculates time derivative of pressure_dT"
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_d "Time derivative of density";
    input Real der_T "Time derivative of temperature";
    output Real der_p "Time derivative of pressure";

  protected
    ThermodynamicState state = setState_dTX(d=d,T=T,phase=phase);

  algorithm
    der_p := der_d*pressure_derd_T(state=state) + der_T*
      pressure_derT_d(state=state);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end pressure_dT_der;

  replaceable function pressure_derd_T
    "Calculates pressure derivative (dp/dd)@T=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dpdd "Pressure derivative (dp/dd)@T=const";

  protected
    Real delta = state.d/(fluidConstants[1].criticalMolarVolume*
      fluidConstants[1].molarMass);
    Real tau = fluidConstants[1].criticalTemperature/state.T;

    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT = if not ((state.d < bubbleDensity(sat) and
      state.d > dewDensity(sat)) and state.T <
      fluidConstants[1].criticalTemperature) then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      dpdd := Modelica.Constants.R/fluidConstants[1].molarMass*
        state.T*(1 + 2*delta_d_alpha_r_d_delta(delta=delta,tau=tau) +
        delta2_d2_alpha_r_d_delta2(delta=delta,tau=tau));
    elseif state.phase==2 or phase_dT==2 then
      dpdd := Modelica.Constants.small;
    end if;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end pressure_derd_T;

  replaceable function pressure_derT_d
    "Calculates pressure derivative (dp/dT)@d=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dpdT "Pressure derivative (dp/dT)@d=const";

  protected
    Real delta = state.d/(fluidConstants[1].criticalMolarVolume*
      fluidConstants[1].molarMass);
    Real tau = fluidConstants[1].criticalTemperature/state.T;

    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT = if not ((state.d < bubbleDensity(sat) and
      state.d > dewDensity(sat)) and state.T <
      fluidConstants[1].criticalTemperature) then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      dpdT:=Modelica.Constants.R/fluidConstants[1].molarMass*state.d*
        (1 + delta_d_alpha_r_d_delta(delta=delta,tau=tau) -
        tau_delta_d2_alpha_r_d_tau_d_delta(delta=delta,tau=tau));
    elseif state.phase==2 or phase_dT==2 then
      dpdT := Modelica.Constants.inf;
    end if;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end pressure_derT_d;

  replaceable function temperature_ph_der
  "Calculates time derivative of temperature_ph"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_h "Time derivative of specific enthalpy";
    output Real der_T "Time derivative of density";

  protected
    ThermodynamicState state = setState_phX(p=p,h=h,phase=phase);

  algorithm
    der_T := der_p*temperature_derp_h(state=state) +
      der_h*temperature_derh_p(state=state);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end temperature_ph_der;

  replaceable function temperature_derh_p
    "Calculates temperature derivative (dT/dh)@p=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dThp "Temperature derivative (dT/dh)@p=const";

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT = if not ((state.d < bubbleDensity(sat) and
        state.d > dewDensity(sat)) and state.T <
        fluidConstants[1].criticalTemperature) then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      dThp := 1 / (specificEnthalpy_derT_d(state) -
        specificEnthalpy_derd_T(state)*pressure_derT_d(state)/
        pressure_derd_T(state));
    elseif state.phase==2 or phase_dT==2 then
      dThp:=Modelica.Constants.small;
    end if;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end temperature_derh_p;

  replaceable function temperature_derp_h
    "Calculates temperature derivative (dT/dp)@h=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dTph "Temperature derivative (dT/dp)@h=const";

  protected
    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT = if not ((state.d < bubbleDensity(sat) and
      state.d > dewDensity(sat)) and state.T <
      fluidConstants[1].criticalTemperature) then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      dTph := 1 / (pressure_derT_d(state) - pressure_derd_T(state)*
        specificEnthalpy_derT_d(state)/specificEnthalpy_derd_T(state));
    elseif state.phase==2 or phase_dT==2 then
      dTph := Modelica.Constants.small;
    end if;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end temperature_derp_h;

  replaceable function density_ph_der
    "Calculates time derivative of density_ph"
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific Enthalpy";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_p "Time derivative of pressure";
    input Real der_h "Time derivative of specific enthalpy";
    output Real der_d "Time derivative of density";

  protected
    ThermodynamicState state = setState_phX(p=p,h=h,phase=phase);

  algorithm
    der_d := der_p*density_derp_h(state=state) +
    der_h*density_derh_p(state=state);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end density_ph_der;

  redeclare replaceable function extends density_derh_p
    "Calculates density derivative (dd/dh)@p=const"

  protected
    SmoothTransition st;

    AbsolutePressure dp = st.d_derh_p;

    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT = if not ((state.d < bubbleDensity(sat) and
      state.d > dewDensity(sat)) and state.T <
      fluidConstants[1].criticalTemperature) then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      ddhp := 1 / (specificEnthalpy_derd_T(state) -
        specificEnthalpy_derT_d(state)*pressure_derd_T(state)/
        pressure_derT_d(state));
    elseif state.phase==2 or phase_dT==2 then
      ddhp:=-(state.d^2)/state.T*(saturationTemperature(state.p+dp/2)-
        saturationTemperature(state.p-dp/2))/dp;
    end if;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end density_derh_p;

  redeclare function extends density_derp_h
    "Calculates density derivative (dd/dp)@h=const"

  algorithm
    ddph := 1 / (pressure_derd_T(state) - pressure_derT_d(state)*
      specificEnthalpy_derd_T(state)/specificEnthalpy_derT_d(state));
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end density_derp_h;

  redeclare function extends dBubbleDensity_dPressure
    "Calculates bubble point density derivative"

  protected
    ThermodynamicState state_l = setBubbleState(sat);
    ThermodynamicState state_v = setDewState(sat);

    Real ddpT = 1 / pressure_derd_T(state_l);
    Real ddTp = -pressure_derT_d(state_l) / pressure_derd_T(state_l);
    Real dTp = (1/state_v.d - 1/state_l.d)/(specificEntropy(state_v) -
      specificEntropy(state_l));

  algorithm
    ddldp := ddpT + ddTp*dTp;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end dBubbleDensity_dPressure;

  redeclare function extends dDewDensity_dPressure
    "Calculates dew point density derivative"

  protected
    ThermodynamicState state_l = setBubbleState(sat);
    ThermodynamicState state_v = setDewState(sat);

    Real ddpT = 1/pressure_derd_T(state_v);
    Real ddTp = -pressure_derT_d(state_v)/pressure_derd_T(state_v);
    Real dTp = (1/state_v.d - 1/state_l.d)/(specificEntropy(state_v) -
      specificEntropy(state_l));

  algorithm
    ddvdp := ddpT + ddTp*dTp;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end dDewDensity_dPressure;

  replaceable function specificEnthalpy_dT_der
    "Calculates time derivative of specificEnthalpy_dT"
    input Density d "Density";
    input Temperature T "Temperature";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input Real der_d "Time derivative of density";
    input Real der_T "Time derivative of temperature";
    output Real der_h "Time derivative of specific enthalpy";

  protected
    ThermodynamicState state = setState_dT(d=d,T=T,phase=phase);

  algorithm
    der_h := der_d*specificEnthalpy_derd_T(state=state) +
      der_T*specificEnthalpy_derT_d(state=state);
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificEnthalpy_dT_der;

  replaceable function specificEnthalpy_derT_d
  "Calculates enthalpy derivative (dh/dT)@d=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dhTd "Enthalpy derivative (dh/dT)@d=const";

  protected
    Real delta = state.d/(fluidConstants[1].criticalMolarVolume*
      fluidConstants[1].molarMass);
    Real tau = fluidConstants[1].criticalTemperature/state.T;

    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT = if not ((state.d < bubbleDensity(sat) and
      state.d > dewDensity(sat)) and state.T <
      fluidConstants[1].criticalTemperature) then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      dhTd := Modelica.Constants.R/fluidConstants[1].molarMass*
        (-tau2_d2_alpha_0_d_tau2(tau=tau) - tau2_d2_alpha_r_d_tau2(
        delta=delta, tau=tau) + 1 + delta_d_alpha_r_d_delta(
        delta=delta,tau=tau) - tau_delta_d2_alpha_r_d_tau_d_delta(
        delta=delta, tau=tau));
    elseif state.phase==2 or phase_dT==2 then
      dhTd:=Modelica.Constants.inf;
    end if;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificEnthalpy_derT_d;

  replaceable function specificEnthalpy_derd_T
  "Calculates enthalpy derivative (dh/dd)@T=const"
    input ThermodynamicState state "Thermodynamic state";
    output Real dhdT "Enthalpy derivative (dh/dd)@T=const";

  protected
    Real delta = state.d/(fluidConstants[1].criticalMolarVolume*
      fluidConstants[1].molarMass);
    Real tau = fluidConstants[1].criticalTemperature/state.T;

    SaturationProperties sat = setSat_p(state.p);
    Real phase_dT = if not ((state.d < bubbleDensity(sat) and
      state.d > dewDensity(sat)) and state.T <
      fluidConstants[1].criticalTemperature) then 1 else 2;

  algorithm
    if state.phase==1 or phase_dT==1 then
      dhdT := Modelica.Constants.R/fluidConstants[1].molarMass*
        state.T/state.d*(tau_delta_d2_alpha_r_d_tau_d_delta(
        delta=delta,tau=tau) + delta_d_alpha_r_d_delta(delta=delta,tau=tau) +
        delta2_d2_alpha_r_d_delta2(delta=delta,tau=tau));
    elseif state.phase==2 or phase_dT==2 then
      dhdT := -1/state.d^2*(bubbleEnthalpy(sat)-dewEnthalpy(sat))/
        (1/bubbleDensity(sat)-1/dewDensity(sat));
    end if;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end specificEnthalpy_derd_T;

  redeclare function extends dBubbleEnthalpy_dPressure
  "Calculates bubble point enthalpy derivative"

  protected
    ThermodynamicState state_l = setBubbleState(sat);
    ThermodynamicState state_v = setDewState(sat);
    Real dhpT = specificEnthalpy_derd_T(state_l)/pressure_derd_T(state_l);
    Real dhTp = specificEnthalpy_derT_d(state_l) - specificEnthalpy_derd_T(
      state_l)*pressure_derT_d(state_l)/pressure_derd_T(state_l);
    Real dTp = (1/state_v.d - 1/state_l.d)/
      (specificEntropy(state_v) - specificEntropy(state_l));

  algorithm
    dhldp := dhpT + dhTp*dTp;
  annotation(Inline=true,
          LateInline=true,
          Evaluate=true,
          efficient=true);
  end dBubbleEnthalpy_dPressure;

  redeclare function extends dDewEnthalpy_dPressure
  "Calculates dew point enthalpy derivative"

  protected
    ThermodynamicState state_l = setBubbleState(sat);
    ThermodynamicState state_v = setDewState(sat);
    Real dhpT = specificEnthalpy_derd_T(state_v)/pressure_derd_T(state_v);
    Real dhTp = specificEnthalpy_derT_d(state_v) - specificEnthalpy_derd_T(
      state_v)*pressure_derT_d(state_v)/pressure_derd_T(state_v);
    Real dTp=(1.0/state_v.d - 1.0/state_l.d)/
      (specificEntropy(state_v) - specificEntropy(state_l));

  algorithm
    dhvdp := dhpT + dhTp*dTp;
  annotation(Inline=true,
    LateInline=true,
          Evaluate=true,
          efficient=true);
  end dDewEnthalpy_dPressure;

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>This package provides the implementation of a refrigerant modelling approach using a hybrid approach. The hybrid approach is developed by Sangi et al. and consists of both the Helmholtz equation of state and fitted formula for thermodynamic state properties at bubble or dew line (e.g. p<sub>sat</sub> or h<sub>l,sat</sub>) and thermodynamic state properties depending on two independent state properties (e.g. T_ph or T_ps). In the following, the basic formulas of the hybrid approach are given.</p>
<p><b>The Helmholtz equation of state</b></p>
<p>The Helmholtz equation of state (EoS) allows the accurate description of fluids&apos; thermodynamic behaviour and uses the Helmholtz energy as fundamental thermodynamic relation with temperature and density as independent variables. Furthermore, the EoS allows determining all thermodynamic state properties from its partial derivatives and its<b> general formula</b> is given below:</p>
<p align=\"center\"><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_EoS.png\"/></p>
<p>As it can be seen, the general formula of the EoS can be divided in two part: The <b>ideal gas part (left summand) </b>and the <b>residual part (right summand)</b>. Both parts&apos; formulas are given below:</p>
<p align=\"center\"><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_IdealGasPart.png\"/></p>
<p align=\"center\"><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_ResidualPart.png\"/></p>
<p><br>Both, the ideal gas part and the residual part can be divided in three subparts (i.e. the summations) that contain different coefficients (e.g. nL, l<sub>i</sub>, p<sub>i</sub> or e<sub>i</sub>). These coefficients are fitting coefficients and must be obtained during a fitting procedure. While the fitting procedure, the general formula of the EoS is fitted to external data (e.g. NIST Refprop 9.1) and the fitting coefficients are determined. In order to keep the package clear and easy to extend, the fitting coefficients are stored in records inherited from the base data definition <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition\">AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition</a>.</p>
<p>For further information of <b>the EoS and its partial derivatives</b>, please read the paper &QUOT;<a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia - A fluid properties library</a>&QUOT; by Thorade and Saadat as well as the paper &QUOT;<a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">Partial derivatives of thermodynamic state properties for dynamic simulation</a>&QUOT; by Thorade and Saadat.</p>
<p><b>Fitted formulas</b></p>
<p>Fitted formulas allow to reduce the overall computing time of the refrigerant model. Therefore, both thermodynamic state properties at bubble and dew line and thermodynamic state properties depending on two independent state properties are expresses as fitted formulas. The fitted formulas&apos; approaches implemented in this package are developed by Sangi et al. within their &QUOT;Fast_Propane&QUOT; model and given below:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\"><tr>
<td valign=\"middle\"><p><i>Saturation pressure</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SaturationPressure.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Saturation temperature</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SaturationTemperature.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Bubble density</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/BubbleDensity.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Dew density</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/DewDensity.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Bubble Enthalpy</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/BubbleEnthalpy.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Dew Enthalpy</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/DewEnthalpy.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Bubble Entropy</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/BubbleEntropy.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Dew Entropy</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/DewEntropy.png\"/></p></td>
</tr>
</table>
<br>
<table cellspacing=\"0\" cellpadding=\"3\" border=\"1\" width=\"80%\"><tr>
<td rowspan=\"2\" valign=\"middle\"><p><i>Temperature_ph</i></p></td>
<td valign=\"middle\"><p>First Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Temperature_ph_Input1.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p>Second Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Temperature_ph_Input2.png\"/></p></td>
</tr>
<tr>
<td rowspan=\"2\" valign=\"middle\"><p><i>Temperature_ps</i></p></td>
<td valign=\"middle\"><p>First Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Temperature_ps_Input1.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p>Second Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Temperature_ps_Input2.png\"/></p></td>
</tr>
<tr>
<td rowspan=\"2\" valign=\"middle\"><p><i>Density_pT</i></p></td>
<td valign=\"middle\"><p>First Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Density_pT_Input1.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p>Second Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Density_pT_Input2.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Functional approach</i></p></td>
<td colspan=\"2\" valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/StateProperties_Approach.png\"/></p></td>
</tr>
</table>
<p>As it can be seen, the fitted formulas consist basically of the coefficients e<sub>i</sub>, c<sub>i</sub> as well as of the parameters Mean<sub>i</sub> and Std<sub>i</sub>. These coefficients are the fitting coefficients and must be obtained during a fitting procedure. While the fitting procedure, the formulas presented above are fitted to external data (e.g. NIST Refprop 9.1) and the fitting coefficients are determined. In order to keep the package clear and easy to extend, the fitting coefficients are stored in records inherited from the base data definition <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition</a> and <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition</a>.</p>
<p>For further information of <b>the hybrid approach</b>, please read the paper &QUOT;<a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>&QUOT; by Sangi et al..</p>
<p><b>Smooth transition</b></p>
<p>To ensure a smooth transition between different regions (e.g. from supercooled region to two-phase region) and, therefore, to avoid discontinuities as far as possible, Sangi et al. implemented functions for a smooth transition between the regions. An example (i.e. specificEnthalpy_ps) of these functions is given below:<br></p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\"><tr>
<td valign=\"middle\"><p><i>From supercooled region to bubble line and vice versa</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SupercooledToTwoPhase.png\"/></p></td>
<tr>
<td valign=\"middle\"><p><i>From dew line to superheated region and vice versa</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/TwoPhaseToSuperheated.png\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>From bubble or dew line to two-phase region and vice versa</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SaturationToTwoPhase.png\"/></p></td>
</tr>
</table>
<p><b>Assumptions and limitations</b></p>
<p>Three limitations are known for this package:</p>
<ol>
<li>The modelling approach implemented in this package is a hybrid approach and, therefore, is based on the Helmholtz equation of state as well as on fitted formula. Hence, the refrigerant model is just valid within the valid range of the fitted formula.</li>
<li>It may be possible to have discontinuities when moving from one region to another (e.g. from supercooled region to two-phase region). However, functions are implemented to reach a smooth transition between the regions and to avoid these discontinuities as far as possible. (Sangi et al., 2014)</li>
<li>Not all time derivatives are implemented. So far, the following time derivatives are implemented: pressure_dT_der, temperature_ph_der, density_ph_der and specificEnthalpy_dT_der.</li>
</ol>
<p><b>Typical use and important parameters</b></p>
<p>The refrigerant models provided in this package are typically used for heat pumps and refrigerating machines. However, it is just a partial package and, hence, it must be completed before usage. In order to allow an easy completion of the package, a template is provided in <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMedium</a>.</p>
<p><b>References</b> </p>
<p>Thorade, Matthis; Saadat, Ali (2012): <a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia - A fluid properties library</a>. In: <i>Proceedings of the 9th International Modelica Conference</i>; September 3-5; 2012; Munich; Germany. Link&ouml;ping University Electronic Press, S. 63&ndash;70.</p>
<p>Thorade, Matthis; Saadat, Ali (2013): <a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">Partial derivatives of thermodynamic state properties for dynamic simulation</a>. In:<i> Environmental earth sciences 70 (8)</i>, S. 3497&ndash;3503.</p>
<p>Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita; M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275</p>
<p>Klasing,Freerk: A New Design for Direct Exchange Geothermal Heat Pumps - Modeling, Simulation and Exergy Analysis. <i>Master thesis</i></p>
</html>"));
end PartialHybridTwoPhaseMedium;
