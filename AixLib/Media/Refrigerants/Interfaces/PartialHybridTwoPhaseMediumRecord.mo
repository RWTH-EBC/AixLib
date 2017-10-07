within AixLib.Media.Refrigerants.Interfaces;
partial package PartialHybridTwoPhaseMediumRecord
  "Base class for two phase medium using a hybrid approach with records"
  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula;
    //Modelica.Media.Interfaces.PartialTwoPhaseMedium;

  /*Provide records that contain the fitting coefficients for all fitted
    formula (e.g. Helmholtz equation of state). These records must be
    redeclared within the template to provide the coefficients.
  */
  replaceable record EoS
    "Record that contains fitting coefficients of the Helmholtz EoS"
    extends
      AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition;
  end EoS;

  replaceable record BDSP "Record that contains fitting coefficients of the state properties at bubble
    and dew lines"
    extends
      AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition;
  end BDSP;

  replaceable record TSP "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
    extends
      AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition;
  end TSP;
  /*Provide Helmholtz equations of state (EoS). These EoS must be fitted to
    different refrigerants. However, the structure will not change and, 
    therefore, the coefficients, which are obtained during the fitting 
    procedure, are provided by a record. These coefficients have to be 
    provided within the template.
    Just change if needed.
  */
  redeclare replaceable function extends alpha_0
    "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"
  protected
    EoS cf;

  algorithm
    alpha_0 := log(delta);
    if not cf.alpha_0_nL == 0 then
      for k in 1:cf.alpha_0_nL loop
        alpha_0 := alpha_0 +
          cf.alpha_0_l1[k]*log(tau^cf.alpha_0_l2[k]);
      end for;
    end if;
    if not cf.alpha_0_nP == 0 then
      for k in 1:cf.alpha_0_nP loop
        alpha_0 := alpha_0 +
          cf.alpha_0_p1[k]*tau^cf.alpha_0_p2[k];
      end for;
    end if;
    if not cf.alpha_0_nE == 0 then
      for k in 1:cf.alpha_0_nE loop
        alpha_0 := alpha_0 +
          cf.alpha_0_e1[k]*log(1-exp(-cf.alpha_0_e2[k]*tau));
      end for;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end alpha_0;

  redeclare replaceable function extends alpha_r
    "Dimensionless Helmholtz energy (Residual part alpha_r)"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        alpha_r := alpha_r +
          cf.alpha_r_p1[k]*delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
      alpha_r := alpha_r +
        cf.alpha_r_b1[k]*delta^cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*
        exp(-delta^cf.alpha_r_b4[k]);
      end for;
    end if;
    if not cf.alpha_r_nG == 0 then
      for k in 1:cf.alpha_r_nG loop
        alpha_r := alpha_r +
          cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
          exp(-cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 -
          cf.alpha_r_g6[k]*(tau - cf.alpha_r_g7[k])^2);
      end for;
    end if;
    annotation(Inline=false,
        LateInline=true);
  end alpha_r;

  redeclare replaceable function extends tau_d_alpha_0_d_tau
    "Short form for tau*(dalpha_0/dtau)@delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_0_nL == 0 then
      for k in 1:cf.alpha_0_nL loop
        tau_d_alpha_0_d_tau := tau_d_alpha_0_d_tau +
          cf.alpha_0_l1[k]*cf.alpha_0_l2[k];
      end for;
    end if;
    if not cf.alpha_0_nP == 0 then
      for k in 1:cf.alpha_0_nP loop
        tau_d_alpha_0_d_tau := tau_d_alpha_0_d_tau +
          cf.alpha_0_p1[k]*cf.alpha_0_p2[k]*tau^cf.alpha_0_p2[k];
      end for;
    end if;
    if not cf.alpha_0_nE == 0 then
      for k in 1:cf.alpha_0_nE loop
        tau_d_alpha_0_d_tau := tau_d_alpha_0_d_tau +
          tau*cf.alpha_0_e1[k]*cf.alpha_0_e2[k]/(exp(cf.alpha_0_e2[k]*tau)-1);
      end for;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end tau_d_alpha_0_d_tau;

  redeclare replaceable function extends tau2_d2_alpha_0_d_tau2
    "Short form for tau*tau*(ddalpha_0/(dtau*dtau))@delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_0_nL == 0 then
      for k in 1:cf.alpha_0_nL loop
        tau2_d2_alpha_0_d_tau2 := tau2_d2_alpha_0_d_tau2 -
          cf.alpha_0_l1[k]*cf.alpha_0_l2[k];
      end for;
    end if;
    if not cf.alpha_0_nP == 0 then
      for k in 1:cf.alpha_0_nP loop
        tau2_d2_alpha_0_d_tau2 := tau2_d2_alpha_0_d_tau2 +
          cf.alpha_0_p1[k]*cf.alpha_0_p2[k]*(cf.alpha_0_p2[k]-1)*tau^cf.alpha_0_p2[k];
      end for;
    end if;
    if not cf.alpha_0_nE == 0 then
      for k in 1:cf.alpha_0_nE loop
        tau2_d2_alpha_0_d_tau2 := tau2_d2_alpha_0_d_tau2 -
          tau^2*cf.alpha_0_e1[k]*cf.alpha_0_e2[k]^2*exp(-cf.alpha_0_e2[k]*tau)/
          ((1-exp(-cf.alpha_0_e2[k]*tau))^2);
      end for;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end tau2_d2_alpha_0_d_tau2;

  redeclare replaceable function extends tau_d_alpha_r_d_tau
    "Short form for tau*(dalpha_r/dtau)@delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        tau_d_alpha_r_d_tau := tau_d_alpha_r_d_tau +
          cf.alpha_r_p1[k]*cf.alpha_r_p3[k]*delta^cf.alpha_r_p2[k]*
          tau^cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
        tau_d_alpha_r_d_tau := tau_d_alpha_r_d_tau +
          cf.alpha_r_b1[k]*cf.alpha_r_b3[k]*delta^cf.alpha_r_b2[k]*
          tau^cf.alpha_r_b3[k]*exp(-delta^cf.alpha_r_b4[k]);
      end for;
    end if;
    if not cf.alpha_r_nG == 0 then
      for k in 1:cf.alpha_r_nG loop
        tau_d_alpha_r_d_tau := tau_d_alpha_r_d_tau +
          cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
          exp(-cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 - cf.alpha_r_g6[k]*
          (tau - cf.alpha_r_g7[k])^2)*(cf.alpha_r_g3[k]-2*cf.alpha_r_g6[k]*
          tau*(tau-cf.alpha_r_g7[k]));
      end for;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end tau_d_alpha_r_d_tau;

  redeclare replaceable function extends tau2_d2_alpha_r_d_tau2
    "Short form for tau*tau*(ddalpha_r/(dtau*dtau))@delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        tau2_d2_alpha_r_d_tau2 := tau2_d2_alpha_r_d_tau2 +
          cf.alpha_r_p1[k]*cf.alpha_r_p3[k]*(cf.alpha_r_p3[k]-1)*
          delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
        tau2_d2_alpha_r_d_tau2 := tau2_d2_alpha_r_d_tau2 +
          cf.alpha_r_b1[k]*cf.alpha_r_b3[k]*(cf.alpha_r_b3[k]-1)*delta^
          cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*exp(-delta^cf.alpha_r_b4[k]);
      end for;
    end if;
    if not cf.alpha_r_nG == 0 then
      for k in 1:cf.alpha_r_nG loop
        tau2_d2_alpha_r_d_tau2 := tau2_d2_alpha_r_d_tau2 +
          cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
          exp(-cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 - cf.alpha_r_g6[k]*
          (tau - cf.alpha_r_g7[k])^2)*((cf.alpha_r_g3[k]-2*cf.alpha_r_g6[k]*tau*
          (tau-cf.alpha_r_g7[k]))^2-cf.alpha_r_g3[k]-2*cf.alpha_r_g6[k]*tau^2);
      end for;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end tau2_d2_alpha_r_d_tau2;

  redeclare replaceable function extends delta_d_alpha_r_d_delta
    "Short form for delta*(dalpha_r/(ddelta))@tau=const"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        delta_d_alpha_r_d_delta := delta_d_alpha_r_d_delta +
          cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*delta^cf.alpha_r_p2[k]*tau^
          cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
        delta_d_alpha_r_d_delta := delta_d_alpha_r_d_delta +
          cf.alpha_r_b1[k]*delta^cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*
          exp(-delta^cf.alpha_r_b4[k])*(cf.alpha_r_b2[k]-cf.alpha_r_b4[k]*
          delta^cf.alpha_r_b4[k]);
      end for;
    end if;
    if not cf.alpha_r_nG == 0 then
      for k in 1:cf.alpha_r_nG loop
        delta_d_alpha_r_d_delta := delta_d_alpha_r_d_delta +
          cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
          exp(-cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 - cf.alpha_r_g6[k]*
          (tau - cf.alpha_r_g7[k])^2)*(cf.alpha_r_g2[k]-2*cf.alpha_r_g4[k]*delta*
          (delta-cf.alpha_r_g5[k]));
      end for;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end delta_d_alpha_r_d_delta;

  redeclare replaceable function extends delta2_d2_alpha_r_d_delta2
    "Short form for delta*delta(ddalpha_r/(ddelta*delta))@tau=const"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        delta2_d2_alpha_r_d_delta2 := delta2_d2_alpha_r_d_delta2 +
          cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*(cf.alpha_r_p2[k]-1)*
          delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
        delta2_d2_alpha_r_d_delta2 := delta2_d2_alpha_r_d_delta2 +
          cf.alpha_r_b1[k]*delta^cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*
          exp(-delta^cf.alpha_r_b4[k])*((cf.alpha_r_b2[k]-1-cf.alpha_r_b4[k]*
          delta^cf.alpha_r_b4[k])*(cf.alpha_r_b2[k]-cf.alpha_r_b4[k]*
          delta^cf.alpha_r_b4[k])-cf.alpha_r_b4[k]^2*delta^cf.alpha_r_b4[k]);
      end for;
    end if;
    if not cf.alpha_r_nG == 0 then
      for k in 1:cf.alpha_r_nG loop
        delta2_d2_alpha_r_d_delta2 := delta2_d2_alpha_r_d_delta2 +
          cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
          exp(-cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 - cf.alpha_r_g6[k]*
          (tau - cf.alpha_r_g7[k])^2)*((cf.alpha_r_g2[k]-2*cf.alpha_r_g4[k]*
          delta*(delta-cf.alpha_r_g5[k]))^2-cf.alpha_r_g2[k]-2*cf.alpha_r_g4[k]*
          delta^2);
      end for;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end delta2_d2_alpha_r_d_delta2;

  redeclare replaceable function extends tau_delta_d2_alpha_r_d_tau_d_delta
    "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        tau_delta_d2_alpha_r_d_tau_d_delta := tau_delta_d2_alpha_r_d_tau_d_delta +
          cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*cf.alpha_r_p3[k]*
          delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
        tau_delta_d2_alpha_r_d_tau_d_delta := tau_delta_d2_alpha_r_d_tau_d_delta +
          cf.alpha_r_b1[k]*cf.alpha_r_b3[k]*delta^cf.alpha_r_b2[k]*tau^
          cf.alpha_r_b3[k]*exp(-delta^cf.alpha_r_b4[k])*(cf.alpha_r_b2[k]-
          cf.alpha_r_b4[k]*delta^cf.alpha_r_b4[k]);
      end for;
    end if;
    if not cf.alpha_r_nG == 0 then
      for k in 1:cf.alpha_r_nG loop
        tau_delta_d2_alpha_r_d_tau_d_delta := tau_delta_d2_alpha_r_d_tau_d_delta +
          cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
          exp(-cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 - cf.alpha_r_g6[k]*
          (tau - cf.alpha_r_g7[k])^2)*(cf.alpha_r_g3[k]-2*cf.alpha_r_g6[k]*tau*
          (tau-cf.alpha_r_g7[k]))*(cf.alpha_r_g2[k]-2*cf.alpha_r_g4[k]*delta*
          (delta-cf.alpha_r_g5[k]));
      end for;
    end if;
  annotation(Inline=false,
          LateInline=true);
  end tau_delta_d2_alpha_r_d_tau_d_delta;

  redeclare replaceable function extends tau3_d3_alpha_0_d_tau3
    "Short form for tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))@delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_0_nL == 0 then
      for k in 1:cf.alpha_0_nL loop
        tau3_d3_alpha_0_d_tau3 := tau3_d3_alpha_0_d_tau3 +
          2*cf.alpha_0_l1[k]*cf.alpha_0_l2[k];
      end for;
    end if;
    if not cf.alpha_0_nP == 0 then
      for k in 1:cf.alpha_0_nP loop
        tau3_d3_alpha_0_d_tau3 := tau3_d3_alpha_0_d_tau3 +
          cf.alpha_0_p1[k]*cf.alpha_0_p2[k]*(cf.alpha_0_p2[k]-1)*
          (cf.alpha_0_p2[k]-2)*tau^cf.alpha_0_p2[k];
      end for;
    end if;
    if not cf.alpha_0_nE == 0 then
      for k in 1:cf.alpha_0_nE loop
        tau3_d3_alpha_0_d_tau3 := tau3_d3_alpha_0_d_tau3 +
          tau^3*cf.alpha_0_e1[k]*cf.alpha_0_e2[k]^3*exp(cf.alpha_0_e2[k]*tau)*
          (exp(cf.alpha_0_e2[k]*tau)+1)/((exp(cf.alpha_0_e2[k]*tau)-1)^3);
      end for;
    end if;
    annotation(Inline=false,
          LateInline=true);
  end tau3_d3_alpha_0_d_tau3;

  redeclare replaceable function extends tau3_d3_alpha_r_d_tau3
    "Short form for tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))@delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        tau3_d3_alpha_r_d_tau3 := tau3_d3_alpha_r_d_tau3 +
          cf.alpha_r_p1[k]*cf.alpha_r_p3[k]*(cf.alpha_r_p3[k]-1)*
          (cf.alpha_r_p3[k]-2)*delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
        tau3_d3_alpha_r_d_tau3 := tau3_d3_alpha_r_d_tau3 +
          cf.alpha_r_b1[k]*cf.alpha_r_b3[k]*(cf.alpha_r_b3[k]-1)*
          (cf.alpha_r_b3[k]-2)*delta^cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*
          exp(-delta^cf.alpha_r_b4[k]);
      end for;
    end if;
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nG loop
        tau3_d3_alpha_r_d_tau3 := tau3_d3_alpha_r_d_tau3 -
        cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
        (8*cf.alpha_r_g6[k]^3*tau^6-24*cf.alpha_r_g6[k]^3*cf.alpha_r_g7[k]*
        tau^5+12*cf.alpha_r_g6[k]^2*(2*cf.alpha_r_g6[k]*cf.alpha_r_g7[k]^2-
        cf.alpha_r_g3[k]-1)*tau^4-4*cf.alpha_r_g6[k]^2*cf.alpha_r_g7[k]*(2*
        cf.alpha_r_g6[k]*cf.alpha_r_g7[k]^2-6*cf.alpha_r_g3[k]-3)*tau^3-6*
        cf.alpha_r_g3[k]*cf.alpha_r_g6[k]*(2*cf.alpha_r_g6[k]*cf.alpha_r_g7[k]^2-
        cf.alpha_r_g3[k])*tau^2-6*(cf.alpha_r_g3[k]-1)*cf.alpha_r_g3[k]*
        cf.alpha_r_g6[k]*cf.alpha_r_g7[k]*tau-cf.alpha_r_g3[k]^3+3*
        cf.alpha_r_g3[k]^2-2*cf.alpha_r_g3[k])*exp(-cf.alpha_r_g6[k]*
        (tau-cf.alpha_r_g7[k])^2-cf.alpha_r_g4[k]*(delta-cf.alpha_r_g5[k])^2);
      end for;
    end if;
    annotation(Inline=false,
          LateInline=true);
  end tau3_d3_alpha_r_d_tau3;

  redeclare replaceable function extends delta3_d3_alpha_r_d_delta3
    "Short form for delta*delta*delta*(dddalpha_r/(ddelta*ddelta*ddelta))@tau=const"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        delta3_d3_alpha_r_d_delta3 := delta3_d3_alpha_r_d_delta3 +
          cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*(cf.alpha_r_p2[k]-1)*
          (cf.alpha_r_p2[k]-2)*delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
        delta3_d3_alpha_r_d_delta3 := delta3_d3_alpha_r_d_delta3 -
          cf.alpha_r_b1[k]*delta^cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*
          exp(-delta^cf.alpha_r_b4[k])*(cf.alpha_r_b4[k]*delta^cf.alpha_r_b4[k]*
          (cf.alpha_r_b4[k]*(delta^cf.alpha_r_b4[k]*(cf.alpha_r_b4[k]*
          (delta^cf.alpha_r_b4[k]-3)-3*cf.alpha_r_b2[k]+3)+cf.alpha_r_b4[k]+
          3*cf.alpha_r_b2[k]-3)+3*cf.alpha_r_b2[k]^2-6*cf.alpha_r_b2[k]+2)-
          (cf.alpha_r_b2[k]-2)*(cf.alpha_r_b2[k]-1)*cf.alpha_r_b2[k]);
      end for;
    end if;
    if not cf.alpha_r_nG == 0 then
      for k in 1:cf.alpha_r_nG loop
        delta3_d3_alpha_r_d_delta3 := delta3_d3_alpha_r_d_delta3 -
          cf.alpha_r_g1[k]*tau^cf.alpha_r_g3[k]*delta^cf.alpha_r_g2[k]*
          (8*cf.alpha_r_g4[k]^3*delta^6-24*cf.alpha_r_g4[k]^3*cf.alpha_r_g5[k]*
          delta^5+12*cf.alpha_r_g4[k]^2*(2*cf.alpha_r_g4[k]*cf.alpha_r_g5[k]^2-
          cf.alpha_r_g2[k]-1)*delta^4-4*cf.alpha_r_g4[k]^2*cf.alpha_r_g5[k]*(2*
          cf.alpha_r_g4[k]*cf.alpha_r_g5[k]^2-6*cf.alpha_r_g2[k]-3)*delta^3-6*
          cf.alpha_r_g2[k]*cf.alpha_r_g4[k]*(2*cf.alpha_r_g4[k]*
          cf.alpha_r_g5[k]^2-cf.alpha_r_g2[k])*delta^2-6*(cf.alpha_r_g2[k]-1)*
          cf.alpha_r_g2[k]*cf.alpha_r_g4[k]*cf.alpha_r_g5[k]*delta-
          cf.alpha_r_g2[k]^3+3*cf.alpha_r_g2[k]^2-2*cf.alpha_r_g2[k])*
          exp(-cf.alpha_r_g4[k]*(delta-cf.alpha_r_g5[k])^2-cf.alpha_r_g6[k]*
          (tau-cf.alpha_r_g7[k])^2);
      end for;
    end if;
    annotation(Inline=false,
          LateInline=true);
  end delta3_d3_alpha_r_d_delta3;

  redeclare replaceable function extends tau_delta2_d3_alpha_r_d_tau_d_delta2
    "Short form for tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        tau_delta2_d3_alpha_r_d_tau_d_delta2 := tau_delta2_d3_alpha_r_d_tau_d_delta2 +
          cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*(cf.alpha_r_p2[k]-1)*cf.alpha_r_p3[k]*
          delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
        tau_delta2_d3_alpha_r_d_tau_d_delta2 := tau_delta2_d3_alpha_r_d_tau_d_delta2 +
          cf.alpha_r_b1[k]*cf.alpha_r_b3[k]*delta^cf.alpha_r_b2[k]*tau^
          cf.alpha_r_b3[k]*exp(-delta^cf.alpha_r_b4[k])*(cf.alpha_r_b4[k]*
          delta^cf.alpha_r_b4[k]*(cf.alpha_r_b4[k]*(delta^cf.alpha_r_b4[k]-1)-
          2*cf.alpha_r_b2[k]+1)+cf.alpha_r_b2[k]*(cf.alpha_r_b2[k]-1));
      end for;
    end if;
    if not cf.alpha_r_nG == 0 then
      for k in 1:cf.alpha_r_nG loop
        tau_delta2_d3_alpha_r_d_tau_d_delta2 := tau_delta2_d3_alpha_r_d_tau_d_delta2 +
          cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
          exp(-cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 - cf.alpha_r_g6[k]*
          (tau - cf.alpha_r_g7[k])^2)*(cf.alpha_r_g3[k]-2*cf.alpha_r_g6[k]*tau*
          (tau-cf.alpha_r_g7[k]))*((cf.alpha_r_g2[k]-2*cf.alpha_r_g4[k]*
          delta*(delta-cf.alpha_r_g5[k]))^2-cf.alpha_r_g2[k]-2*cf.alpha_r_g4[k]*
          delta^2);
      end for;
    end if;
    annotation(Inline=false,
          LateInline=true);
  end tau_delta2_d3_alpha_r_d_tau_d_delta2;

  redeclare replaceable function extends tau2_delta_d3_alpha_r_d_tau2_d_delta
    "Short form for tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))"
  protected
    EoS cf;

  algorithm
    if not cf.alpha_r_nP == 0 then
      for k in 1:cf.alpha_r_nP loop
        tau2_delta_d3_alpha_r_d_tau2_d_delta := tau2_delta_d3_alpha_r_d_tau2_d_delta +
          cf.alpha_r_p1[k]*cf.alpha_r_p2[k]*cf.alpha_r_p3[k]*(cf.alpha_r_p3[k]-1)*
          delta^cf.alpha_r_p2[k]*tau^cf.alpha_r_p3[k];
      end for;
    end if;
    if not cf.alpha_r_nB == 0 then
      for k in 1:cf.alpha_r_nB loop
        tau2_delta_d3_alpha_r_d_tau2_d_delta := tau2_delta_d3_alpha_r_d_tau2_d_delta +
          cf.alpha_r_b1[k]*cf.alpha_r_b3[k]*(cf.alpha_r_b3[k]-1)*delta^
          cf.alpha_r_b2[k]*tau^cf.alpha_r_b3[k]*exp(-delta^cf.alpha_r_b4[k])*
          (cf.alpha_r_b2[k]-cf.alpha_r_b4[k]*delta^cf.alpha_r_b4[k]);
      end for;
    end if;
    if not cf.alpha_r_nG == 0 then
      for k in 1:cf.alpha_r_nG loop
        tau2_delta_d3_alpha_r_d_tau2_d_delta := tau2_delta_d3_alpha_r_d_tau2_d_delta +
          cf.alpha_r_g1[k]*delta^cf.alpha_r_g2[k]*tau^cf.alpha_r_g3[k]*
          exp(-cf.alpha_r_g4[k]*(delta - cf.alpha_r_g5[k])^2 - cf.alpha_r_g6[k]*
          (tau - cf.alpha_r_g7[k])^2)*(cf.alpha_r_g2[k]-2*cf.alpha_r_g4[k]*delta*
          (delta-cf.alpha_r_g5[k]))*((cf.alpha_r_g3[k]-2*cf.alpha_r_g6[k]*tau*
          (tau-cf.alpha_r_g7[k]))^2-cf.alpha_r_g3[k]-2*cf.alpha_r_g6[k]*tau^2);
      end for;
    end if;
    annotation(Inline=false,
          LateInline=true);
  end tau2_delta_d3_alpha_r_d_tau2_d_delta;
  /*Provide polynomial functions for saturation properties. These functions are
    fitted to external data (e.g. data extracted from RefProp or FluidProp). 
    Currently, just one fitting approach is implemented. Therefore, the 
    coefficients, which are obtained during the fitting procedure, are provided
     by records.
  */
  redeclare replaceable function extends saturationPressure
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
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end saturationPressure;

  redeclare replaceable function extends saturationTemperature
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
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end saturationTemperature;

  redeclare replaceable function extends bubbleDensity
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
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleDensity;

  redeclare replaceable function extends dewDensity
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
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewDensity;

  redeclare replaceable function extends bubbleEnthalpy
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
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleEnthalpy;

  redeclare replaceable function extends dewEnthalpy
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
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewEnthalpy;

  redeclare replaceable function extends bubbleEntropy
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
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end bubbleEntropy;

  redeclare replaceable function extends dewEntropy
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
    annotation(smoothOrder = 2,
          Inline=false,
          LateInline=true);
  end dewEntropy;
  /*Provide functions to calculate thermodynamic properties depending on the
    independent variables. Moreover, these functions may depend on the Helmholtz
    EoS. Just change these functions if needed.
  */
  redeclare replaceable function temperature_ph
    "Calculates temperature as function of pressure and specific enthalpy"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input SpecificEnthalpy h "Specific enthalpy";
    input FixedPhase phase=0
      "2 for two-phase, 1 for one-phase, 0 if not known";
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
    Integer count;

  algorithm
    h_dew := dewEnthalpy(sat = setSat_p(p=p));
    h_bubble := bubbleEnthalpy(sat = setSat_p(p=p));

    if h<h_bubble-dh then
      x1 := (p-cf.temperature_ph_iO[1])/cf.temperature_ph_iO[2];
      y1 := (h-cf.temperature_ph_iO[3])/cf.temperature_ph_iO[4];
      T1 := cf.temperature_ph_sc_d[1];
      for i in 1:cf.temperature_ph_nT[1] loop
        T1 := T1 + cf.temperature_ph_sc_a[i]*x1^i;
      end for;
      for j in 1:cf.temperature_ph_nT[2] loop
        T1 := T1 + cf.temperature_ph_sc_b[j]*y1^j;
      end for;
      if cf.temperature_ph_nT[1] >= cf.temperature_ph_nT[2] then
        for i in 1:cf.temperature_ph_nT[1]-1 loop
          for j in 1:min(i,cf.temperature_ph_nT[2]) loop
            count :=count + 1;
            T1 := T1 + cf.temperature_ph_sc_c[count]*x1^(cf.temperature_ph_nT[1] - i)*y1^j;
          end for;
        end for;
      else
        for j in 1:cf.temperature_ph_nT[2]-1 loop
          for i in 1:min(j,cf.temperature_ph_nT[1]) loop
            count :=count + 1;
            T1 := T1 + cf.temperature_ph_sc_c[count]*y1^(cf.temperature_ph_nT[2] - j)*x1^i;
          end for;
        end for;
      end if;
      T := T1*cf.temperature_ph_iO[6]+cf.temperature_ph_iO[5];
    elseif h>h_dew+dh then
       x2 := (p-cf.temperature_ph_iO[7])/cf.temperature_ph_iO[8];
       y2 := (h-cf.temperature_ph_iO[9])/cf.temperature_ph_iO[10];
       T2 := cf.temperature_ph_sh_d[1];
       for i in 1:cf.temperature_ph_nT[4] loop
         T2:= T2 + cf.temperature_ph_sh_a[i]*x2^i;
       end for;
       for j in 1:cf.temperature_ph_nT[5] loop
         T2:= T2 + cf.temperature_ph_sh_b[j]*y2^j;
       end for;
       if cf.temperature_ph_nT[4] >= cf.temperature_ph_nT[5] then
         for i in 1:cf.temperature_ph_nT[4]-1 loop
           for j in 1:min(i, cf.temperature_ph_nT[5]) loop
             count :=count + 1;
             T2 := T2 + cf.temperature_ph_sh_c[count]*x2^(cf.temperature_ph_nT[4] - i)*y2^j;
           end for;
         end for;
       else
         for j in 1:cf.temperature_ph_nT[5]-1 loop
           for i in 1:min(j,cf.temperature_ph_nT[4]) loop
             count :=count + 1;
             T2 := T2 + cf.temperature_ph_sh_c[count]*y2^(cf.temperature_ph_nT[5] - j)*x2^i;
           end for;
         end for;
       end if;
       T := T2*cf.temperature_ph_iO[12]+cf.temperature_ph_iO[11];
    else
      if h<h_bubble then
        x1 := (p-cf.temperature_ph_iO[1])/cf.temperature_ph_iO[2];
        y1 := (h-cf.temperature_ph_iO[3])/cf.temperature_ph_iO[4];
        T1 := cf.temperature_ph_sc_d[1];
        for i in 1:cf.temperature_ph_nT[1] loop
          T1 := T1 + cf.temperature_ph_sc_a[i]*x1^i;
        end for;
        for j in 1:cf.temperature_ph_nT[2] loop
          T1 := T1 + cf.temperature_ph_sc_b[j]*y1^j;
        end for;
        if cf.temperature_ph_nT[1] >= cf.temperature_ph_nT[2] then
          for i in 1:cf.temperature_ph_nT[1]-1 loop
            for j in 1:min(i, cf.temperature_ph_nT[2]) loop
              count :=count + 1;
              T1 := T1 + cf.temperature_ph_sc_c[count]*x1^(cf.temperature_ph_nT[1] - i)*y1^j;
            end for;
          end for;
        else
          for j in 1:cf.temperature_ph_nT[2]-1 loop
            for i in 1:min(j,cf.temperature_ph_nT[1]) loop
              count :=count + 1;
              T1 := T1 + cf.temperature_ph_sc_c[count]*y1^(cf.temperature_ph_nT[2] - j)*x1^i;
            end for;
          end for;
        end if;
        T1 := T1*cf.temperature_ph_iO[6]+cf.temperature_ph_iO[5];
        T := saturationTemperature(p)*(1 - (h_bubble - h)/dh) +
          T1*(h_bubble - h)/dh;
      elseif h>h_dew then
        x2 := (p-cf.temperature_ph_iO[7])/cf.temperature_ph_iO[8];
        y2 := (h-cf.temperature_ph_iO[9])/cf.temperature_ph_iO[10];
        T2 := cf.temperature_ph_sh_d[1];
        for i in 1:cf.temperature_ph_nT[4] loop
          T2:= T2 + cf.temperature_ph_sh_a[i]*x2^i;
        end for;
        for j in 1:cf.temperature_ph_nT[5] loop
          T2:= T2 + cf.temperature_ph_sh_b[j]*y2^j;
        end for;
        if cf.temperature_ph_nT[4] >= cf.temperature_ph_nT[5] then
          for i in 1:cf.temperature_ph_nT[4]-1 loop
            for j in 1:min(i, cf.temperature_ph_nT[5]) loop
              count :=count + 1;
              T2 := T2 + cf.temperature_ph_sh_c[count]*x2^(cf.temperature_ph_nT[4] - i)*y2^j;
            end for;
          end for;
        else
          for j in 1:cf.temperature_ph_nT[5]-1 loop
            for i in 1:min(j,cf.temperature_ph_nT[4]) loop
              count :=count + 1;
              T2 := T2 + cf.temperature_ph_sh_c[count]*y2^(cf.temperature_ph_nT[5] - j)*x2^i;
            end for;
          end for;
        end if;
        T2 := T2*cf.temperature_ph_iO[12]+cf.temperature_ph_iO[11];
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
    Integer count = 0;

  algorithm
    s_dew := dewEntropy(sat = setSat_p(p=p));
    s_bubble := bubbleEntropy(sat = setSat_p(p=p));

    if s<s_bubble-ds then
      x1 := (log(p)-cf.temperature_ps_iO[1])/cf.temperature_ps_iO[2];
      y1 := (s-cf.temperature_ps_iO[3])/cf.temperature_ps_iO[4];
      T1 := cf.temperature_ps_sc_d[1];
      for i in 1:cf.temperature_ps_nT[1] loop
        T1:= T1 + cf.temperature_ps_sc_a[i]*x1^i;
      end for;
      for j in 1:cf.temperature_ps_nT[2] loop
        T1:= T1 + cf.temperature_ps_sc_b[j]*y1^j;
      end for;
      if cf.temperature_ps_nT[1] >= cf.temperature_ps_nT[2] then
        for i in 1:cf.temperature_ps_nT[1]-1 loop
          for j in 1:min(i,cf.temperature_ps_nT[2]) loop
            count :=count + 1;
            T1 :=T1 + cf.temperature_ps_sc_c[count]*x1^(cf.temperature_ps_nT[1] - i)*y1^j;
          end for;
        end for;
      else
        for j in 1:cf.temperature_ps_nT[2]-1 loop
          for i in 1:min(j,cf.temperature_ps_nT[1]) loop
            count :=count + 1;
            T1 :=T1 + cf.temperature_ps_sc_c[count]*y1^(cf.temperature_ps_nT[2] - j)*x1^i;
          end for;
        end for;
      end if;
      T := T1;
      T := T1*cf.temperature_ps_iO[6]+cf.temperature_ps_iO[5];
    elseif s>s_dew+ds then
        x2 := (log(p)-cf.temperature_ps_iO[7])/cf.temperature_ps_iO[8];
        y2 := (s-cf.temperature_ps_iO[9])/cf.temperature_ps_iO[10];
        T2 := cf.temperature_ps_sh_d[1];
        for i in 1:cf.temperature_ps_nT[4] loop
          T2:= T2 + cf.temperature_ps_sh_a[i]*x2^i;
        end for;
        for j in 1:cf.temperature_ps_nT[5] loop
          T2:= T2 + cf.temperature_ps_sh_b[j]*y2^j;
        end for;
        if cf.temperature_ps_nT[4] >= cf.temperature_ps_nT[5] then
          for i in 1:cf.temperature_ps_nT[4]-1 loop
            for j in 1:min(i,cf.temperature_ps_nT[5]) loop
              count :=count + 1;
              T2 :=T2 + cf.temperature_ps_sh_c[count]*x2^(cf.temperature_ps_nT[4] - i)*y2^j;
            end for;
          end for;
        else
          for j in 1:cf.temperature_ps_nT[5]-1 loop
            for i in 1:min(j,cf.temperature_ps_nT[4]) loop
              count :=count + 1;
              T2 := T2 + cf.temperature_ps_sh_c[count]*y2^(cf.temperature_ps_nT[5] - j)*x2^i;
            end for;
          end for;
        end if;
        T := T2*cf.temperature_ps_iO[12]+cf.temperature_ps_iO[11];
    else
      if s<s_bubble then
        x1 := (log(p)-cf.temperature_ps_iO[1])/cf.temperature_ps_iO[2];
        y1 := (s-cf.temperature_ps_iO[3])/cf.temperature_ps_iO[4];
        T1 := cf.temperature_ps_sc_d[1];
        for i in 1:cf.temperature_ps_nT[1] loop
          T1:= T1 + cf.temperature_ps_sc_a[i]*x1^i;
        end for;
        for j in 1:cf.temperature_ps_nT[2] loop
          T1:= T1 + cf.temperature_ps_sc_b[j]*y1^j;
        end for;
        if cf.temperature_ps_nT[1] >= cf.temperature_ps_nT[2] then
          for i in 1:cf.temperature_ps_nT[1]-1 loop
            for j in 1:min(i,cf.temperature_ps_nT[2]) loop
              count :=count + 1;
              T1 :=T1 + cf.temperature_ps_sc_c[count]*x1^(cf.temperature_ps_nT[1] - i)*y1^j;
            end for;
          end for;
        else
          for j in 1:cf.temperature_ps_nT[2]-1 loop
            for i in 1:min(j,cf.temperature_ps_nT[1]) loop
              count :=count + 1;
              T1 :=T1 + cf.temperature_ps_sc_c[count]*y1^(cf.temperature_ps_nT[2] - j)*x1^i;
            end for;
          end for;
        end if;
        T1 := T1*cf.temperature_ps_iO[6]+cf.temperature_ps_iO[5];
        T := saturationTemperature(p)*(1 - (s_bubble - s)/ds) +
          T1*(s_bubble - s)/ds;
      elseif s>s_dew then
        x2 := (log(p)-cf.temperature_ps_iO[7])/cf.temperature_ps_iO[8];
        y2 := (s-cf.temperature_ps_iO[9])/cf.temperature_ps_iO[10];
        T2 := cf.temperature_ps_sh_d[1];
        for i in 1:cf.temperature_ps_nT[4] loop
          T2:= T2 + cf.temperature_ps_sh_a[i]*x2^i;
        end for;
        for j in 1:cf.temperature_ps_nT[5] loop
          T2:= T2 + cf.temperature_ps_sh_b[j]*y2^j;
        end for;
        if cf.temperature_ps_nT[4] >= cf.temperature_ps_nT[5] then
          for i in 1:cf.temperature_ps_nT[4]-1 loop
            for j in 1:min(i,cf.temperature_ps_nT[5]) loop
              count :=count + 1;
              T2 :=T2 + cf.temperature_ps_sh_c[count]*x2^(cf.temperature_ps_nT[4] - i)*y2^j;
            end for;
          end for;
        else
          for j in 1:cf.temperature_ps_nT[5]-1 loop
            for i in 1:min(j,cf.temperature_ps_nT[4]) loop
              count :=count + 1;
              T2 := T2 + cf.temperature_ps_sh_c[count]*y2^(cf.temperature_ps_nT[5] - j)*x2^i;
            end for;
          end for;
        end if;
        T2 := T2*cf.temperature_ps_iO[12]+cf.temperature_ps_iO[11];
        T := saturationTemperature(p)*(1 - (s - s_dew)/ds) +
          T2*(s - s_dew)/ ds;
      else
        T := saturationTemperature(p);
      end if;
    end if;
    annotation(derivative(noDerivative=phase)=temperature_ps_der,
          Inline=false,
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
    Integer count = 0;

  algorithm
    if p<sat.psat-dp then
      x1 := (p-cf.density_pT_iO[7])/cf.density_pT_iO[8];
      y1 := (T-cf.density_pT_iO[9])/cf.density_pT_iO[10];
      d1 := cf.density_pT_sh_d[1];
      for i in 1:cf.density_pT_nT[4] loop
        d1:= d1 + cf.density_pT_sh_a[i]*x1^i;
      end for;
      for j in 1:cf.density_pT_nT[5] loop
        d1:= d1 + cf.density_pT_sh_b[j]*y1^j;
      end for;
      if cf.density_pT_nT[4] >= cf.density_pT_nT[5] then
        for i in 1:cf.density_pT_nT[4]-1 loop
          for j in 1:min(i,cf.density_pT_nT[5]) loop
            count :=count + 1;
            d1 :=d1 + cf.density_pT_sh_c[count]*x1^(cf.density_pT_nT[4] - i)*y1^j;
          end for;
        end for;
      else
        for j in 1:cf.density_pT_nT[5]-1 loop
          for i in 1:min(j,cf.density_pT_nT[4]) loop
            count :=count + 1;
            d1 :=d1 + cf.density_pT_sh_c[count]*y1^(cf.density_pT_nT[5] - j)*x1^i;
          end for;
        end for;
      end if;
      d := d1*cf.density_pT_iO[12]+cf.density_pT_iO[11];
    elseif p>sat.psat+dp then
      x2 := (p-cf.density_pT_iO[1])/cf.density_pT_iO[2];
      y2 := (T-cf.density_pT_iO[3])/cf.density_pT_iO[4];
      d2 := cf.density_pT_sc_d[1];
      for i in 1:cf.density_pT_nT[1] loop
        d2:= d2 + cf.density_pT_sc_a[i]*x2^i;
      end for;
      for j in 1:cf.density_pT_nT[2] loop
        d2:= d2 + cf.density_pT_sc_b[j]*y2^j;
      end for;
      if cf.density_pT_nT[1] >= cf.density_pT_nT[2] then
        for i in 1:cf.density_pT_nT[1]-1 loop
          for j in 1:min(i,cf.density_pT_nT[2]) loop
            count :=count + 1;
            d2 :=d2 + cf.density_pT_sc_c[count]*x2^(cf.density_pT_nT[1] - i)*y2^j;
          end for;
        end for;
      else
        for j in 1:cf.density_pT_nT[2]-1 loop
          for i in 1:min(j,cf.density_pT_nT[1]) loop
            count :=count + 1;
            d2 := d2 + cf.density_pT_sc_c[count]*y2^(cf.density_pT_nT[2] - j)*x2^i;
          end for;
        end for;
      end if;
      d := d2*cf.density_pT_iO[6]+cf.density_pT_iO[5];
    else
      if p<sat.psat then
        x1 := (p-cf.density_pT_iO[7])/cf.density_pT_iO[8];
        y1 := (T-cf.density_pT_iO[9])/cf.density_pT_iO[10];
        d1 := cf.density_pT_sh_d[1];
        for i in 1:cf.density_pT_nT[4] loop
          d1:= d1 + cf.density_pT_sh_a[i]*x1^i;
        end for;
        for j in 1:cf.density_pT_nT[5] loop
          d1:= d1 + cf.density_pT_sh_b[j]*y1^j;
        end for;
        if cf.density_pT_nT[4] >= cf.density_pT_nT[5] then
          for i in 1:cf.density_pT_nT[4]-1 loop
            for j in 1:min(i,cf.density_pT_nT[5]) loop
              count :=count + 1;
              d1 :=d1 + cf.density_pT_sh_c[count]*x1^(cf.density_pT_nT[4] - i)*y1^j;
            end for;
          end for;
        else
          for j in 1:cf.density_pT_nT[5]-1 loop
            for i in 1:min(j,cf.density_pT_nT[4]) loop
              count :=count + 1;
              d1 :=d1 + cf.density_pT_sh_c[count]*y1^(cf.density_pT_nT[5] - j)*x1^i;
            end for;
          end for;
        end if;
        d1 := d1*cf.density_pT_iO[12]+cf.density_pT_iO[11];
        d := bubbleDensity(sat)*(1 -(sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
      elseif p>=sat.psat then
        x2 := (p-cf.density_pT_iO[1])/cf.density_pT_iO[2];
        y2 := (T-cf.density_pT_iO[3])/cf.density_pT_iO[4];
        d2 := cf.density_pT_sc_d[1];
        for i in 1:cf.density_pT_nT[1] loop
          d2:= d2 + cf.density_pT_sc_a[i]*x2^i;
        end for;
        for j in 1:cf.density_pT_nT[2] loop
          d2:= d2 + cf.density_pT_sc_b[j]*y2^j;
        end for;
        if cf.density_pT_nT[1] >= cf.density_pT_nT[2] then
          for i in 1:cf.density_pT_nT[1]-1 loop
            for j in 1:min(i,cf.density_pT_nT[2]) loop
              count :=count + 1;
              d2 :=d2 + cf.density_pT_sc_c[count]*x2^(cf.density_pT_nT[1] - i)*y2^j;
            end for;
          end for;
        else
          for j in 1:cf.density_pT_nT[2]-1 loop
            for i in 1:min(j,cf.density_pT_nT[1]) loop
              count :=count + 1;
              d2 := d2 + cf.density_pT_sc_c[count]*y2^(cf.density_pT_nT[2] - j)*x2^i;
            end for;
          end for;
        end if;
        d2 := d2*cf.density_pT_iO[6]+cf.density_pT_iO[5];
        d := dewDensity(sat)*(1 -(p - sat.psat)/dp) + d2*(p - sat.psat)/dp;
      end if;
    end if;
    annotation(derivative(noDerivative=phase)=density_pT_der,
          inverse(p=pressure_dT(d=d,T=T,phase=phase)),
          Inline=false,
          LateInline=true);
  end density_pT;
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
<p align=\"center\"><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_EoS.png\" alt=\"Calculation procedure of dimensionless Helmholtz energy\"/></p>
<p>As it can be seen, the general formula of the EoS can be divided in two part: The <b>ideal gas part (left summand) </b>and the <b>residual part (right summand)</b>. Both parts&apos; formulas are given below:</p>
<p align=\"center\"><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_IdealGasPart.png\" alt=\"Calculation procedure of dimensionless ideal gas Helmholtz energy\"/></p>
<p align=\"center\"><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_ResidualPart.png\" alt=\"Calculation procedure of dimensionless residual Helmholtz energy\"/></p>
<p>Both, the ideal gas part and the residual part can be divided in three subparts (i.e. the summations) that contain different coefficients (e.g. nL, l<sub>i</sub>, p<sub>i</sub> or e<sub>i</sub>). These coefficients are fitting coefficients and must be obtained during a fitting procedure. While the fitting procedure, the general formula of the EoS is fitted to external data (e.g. obtained from measurements or external media libraries) and the fitting coefficients are determined. In order to keep the package clear and easy to extend, the fitting coefficients are stored in records inherited from the base data definition <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition\">AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition</a>.</p>
<p>For further information of <b>the EoS and its partial derivatives</b>, please read the paper &quot;<a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia - A fluid properties library</a>&quot; by Thorade and Saadat as well as the paper&quot;<a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">Partial derivatives of thermodynamic state properties for dynamic simulation</a>&quot; by Thorade and Saadat.</p>
<p><b>Fitted formulas</b></p>
<p>Fitted formulas allow to reduce the overall computing time of the refrigerant model. Therefore, both thermodynamic state properties at bubble and dew line and thermodynamic state properties depending on two independent state properties are expresses as fitted formulas. The fitted formulas&apos; approaches implemented in this package are developed by Sangi et al. within their &quot;Fast_Propane&quot; model and given below:</p>
<p>
<table summary=\"Formulas for calculating saturation properties\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\" style=\"border-collapse:collapse;\">
<tr>
<td valign=\"middle\"><p><i>Saturation pressure</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationPressure.png\" alt=\"Formula to calculate saturation pressure\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Saturation temperature</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationTemperature.png\" alt=\"Formula to calculate saturation temperature\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Bubble density</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleDensity.png\" alt=\"Formula to calculate bubble density\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Dew density</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewDensity.png\" alt=\"Formula to calculate dew density\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Bubble Enthalpy</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEnthalpy.png\" alt=\"Formula to calculate bubble enthalpy\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Dew Enthalpy</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEnthalpy.png\" alt=\"Formula to calculate dew enthalpy\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Bubble Entropy</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEntropy.png\" alt=\"Formula to calculate bubble entropy\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Dew Entropy</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEntropy.png\" alt=\"Formula to calculate dew entropy\"/></p></td>
</tr>
</table>
</p>
<p>
<table summary=\"Formulas for calculating thermodynamic properties at superheated and supercooled regime\" cellspacing=\"0\" cellpadding=\"3\" border=\"1\" width=\"80%\" style=\"border-collapse:collapse;\">
<tr>
<td valign=\"middle\" rowspan=\"2\"><p><i>Temperature_ph</i></p></td>
<td valign=\"middle\"><p>First Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input1.png\" alt=\"First input required to calculate temperature by pressure and specific enthalpy\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p>Second Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input2.png\" alt=\"Second input required to calculate temperature by pressure and specific enthalpy\"/></p></td>
</tr>
<tr>
<td valign=\"middle\" rowspan=\"2\"><p><i>Temperature_ps</i></p></td>
<td valign=\"middle\"><p>First Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input1.png\" alt=\"First input required to calculate temperature by pressure and specific entropy\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p>Second Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input2.png\" alt=\"Second input required to calculate temperature by pressure and specific entropy\"/></p></td>
</tr>
<tr>
<td valign=\"middle\" rowspan=\"2\"><p><i>Density_pT</i></p></td>
<td valign=\"middle\"><p>First Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input1.png\" alt=\"First input required to calculate density by pressure and temperature\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p>Second Input</p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input2.png\" alt=\"Second input required to calculate density by pressure and temperature\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>Functional approach</i></p></td>
<td valign=\"middle\" colspan=\"2\"><p><img src=\"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/StateProperties_Approach.png\"/></p></td>
</tr>
</table>
</p>
<p>As it can be seen, the fitted formulas consist basically of the coefficients e<sub>i</sub>, c<sub>i</sub> as well as of the parameters Mean<sub>i</sub> and Std<sub>i</sub>. These coefficients are the fitting coefficients and must be obtained during a fitting procedure. While the fitting procedure, the formulas presented above are fitted to external data (e.g. obtained from measurements or external media libraries) and the fitting coefficients are determined. In order to keep the package clear and easy to extend, the fitting coefficients are stored in records inherited from the base data definition <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition</a> and <a href=\"modelica://AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition\">AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition</a>.</p>
<p>For further information of <b>the hybrid approach</b>, please read the paper &quot;<a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>&quot; by Sangi et al..</p>
<p><b>Smooth transition</b></p>
<p>To ensure a smooth transition between different regions (e.g. from supercooled region to two-phase region) and, therefore, to avoid discontinuities as far as possible, Sangi et al. implemented functions for a smooth transition between the regions. An example (i.e. specificEnthalpy_ps) of these functions is given below:</p>
<p>
<table summary=\"Calculation procedures to avoid numerical instability at phase change\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\" style=\"border-collapse:collapse;\">
<tr>
<td valign=\"middle\"><p><i>From supercooled region to bubble line and vice versa</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SupercooledToTwoPhase.png\" alt=\"Calculation procedure for change from supercooled to two-phase\"/></p></td>
<tr>
<td valign=\"middle\"><p><i>From dew line to superheated region and vice versa</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/TwoPhaseToSuperheated.png\" alt=\"Calculation procedure for change from superheated to two-phase\"/></p></td>
</tr>
<tr>
<td valign=\"middle\"><p><i>From bubble or dew line to two-phase region and vice versa</i></p></td>
<td valign=\"middle\"><p><img src=\"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SaturationToTwoPhase.png\" alt=\"Calculation procedure for change from saturation to two-phase\"/></p></td>
</tr>
</table>
</p>
<h4>Assumptions and limitations</h4>
<p>Three limitations are known for this package:</p>
<ol>
<li>The modelling approach implemented in this package is a hybrid approach and, therefore, is based on the Helmholtz equation of state as well as on fitted formula. Hence, the refrigerant model is just valid within the valid range of the fitted formula.</li>
<li>It may be possible to have discontinuities when moving from one region to another (e.g. from supercooled region to two-phase region). However, functions are implemented to reach a smooth transition between the regions and to avoid these discontinuities as far as possible. (Sangi et al., 2014)</li>
</ol>
<h4>Typical use and important parameters</h4>
<p>The refrigerant models provided in this package are typically used for heat pumps and refrigerating machines. However, it is just a partial package and, hence, it must be completed before usage. In order to allow an easy completion of the package, a template is provided in <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>.</p>
<h4>References</h4>
<p>Thorade, Matthis; Saadat, Ali (2012): <a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia - A fluid properties library</a>. In: <i>Proceedings of the 9th International Modelica Conference</i>; September 3-5; 2012; Munich; Germany. Link&ouml;ping University Electronic Press, S. 63&ndash;70.</p>
<p>Thorade, Matthis; Saadat, Ali (2013): <a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">Partial derivatives of thermodynamic state properties for dynamic simulation</a>. In:<i> Environmental earth sciences 70 (8)</i>, S. 3497&ndash;3503.</p>
<p>Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita; M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund, Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press (Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275</p>
<p>Klasing,Freerk: A New Design for Direct Exchange Geothermal Heat Pumps - Modeling, Simulation and Exergy Analysis. <i>Master thesis</i></p>
</html>"));
end PartialHybridTwoPhaseMediumRecord;
