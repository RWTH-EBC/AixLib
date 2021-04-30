within AixLib.Media.Refrigerants.Interfaces;
partial package PartialHybridTwoPhaseMediumRecord
  "Base class for two phase medium using a hybrid approach with records"
  extends AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula;

  /*Provide records that contain the fitting coefficients for all fitted
    formula (e.g. Helmholtz equation of state). These records must be
    redeclared within the template to provide the coefficients.
  */
  replaceable record EoS
    "Record that contains fitting coefficients of the Helmholtz EoS"
    extends AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition;
  end EoS;

  replaceable record BDSP
    "Record that contains fitting coefficients of the state properties at
    bubble and dew lines"
    extends AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition;
  end BDSP;

  replaceable record TSP
    "Record that contains fitting coefficients of the state properties
    calculated with two independent state properties"
    extends AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition;
  end TSP;
  /*Provide Helmholtz equations of state (EoS). These EoS must be fitted to
    different refrigerants. However, the structure will not change and,
    therefore, the coefficients, which are obtained during the fitting
    procedure, are provided by a record. These coefficients have to be
    provided within the template.
    Just change if needed.
  */
  redeclare function extends f_Idg
    "Dimensionless Helmholtz energy (Ideal gas contribution f_Idg)"
  protected
    EoS cf;

  algorithm
    f_Idg := log(delta);
    if not cf.f_IdgNl == 0 then
      for k in 1:cf.f_IdgNl loop
        f_Idg := f_Idg + cf.f_IdgL1[k]*log(tau^cf.f_IdgL2[k]);
      end for;
    end if;
    if not cf.f_IdgNp == 0 then
      for k in 1:cf.f_IdgNp loop
        f_Idg := f_Idg + cf.f_IdgP1[k]*tau^cf.f_IdgP2[k];
      end for;
    end if;
    if not cf.f_IdgNe == 0 then
      for k in 1:cf.f_IdgNe loop
        f_Idg := f_Idg + cf.f_IdgE1[k]*log(1-exp(-cf.f_IdgE2[k]*tau));
      end for;
    end if;

  annotation(Inline=false,
             LateInline=true);
  end f_Idg;

  redeclare function extends f_Res
    "Dimensionless Helmholtz energy (Residual part f_Res)"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
          f_Res := f_Res + cf.f_ResP1[k]*delta^cf.f_ResP2[k]*tau^cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        f_Res := f_Res + cf.f_ResB1[k]*delta^cf.f_ResB2[k]*tau^cf.f_ResB3[k]*
                 exp(-delta^cf.f_ResB4[k]);
      end for;
    end if;
    if not cf.f_ResNG == 0 then
      for k in 1:cf.f_ResNG loop
        f_Res := f_Res + cf.f_ResG1[k]*delta^cf.f_ResG2[k]*tau^cf.f_ResG3[k]*
                 exp(-cf.f_ResG4[k]*(delta - cf.f_ResG5[k])^2 -
                 cf.f_ResG6[k]*(tau - cf.f_ResG7[k])^2);
      end for;
    end if;

    annotation(Inline=false,
               LateInline=true);
  end f_Res;

  redeclare function extends t_fIdg_t
    "Short form for tau*(dalpha_0/dtau)_delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.f_IdgNl == 0 then
      for k in 1:cf.f_IdgNl loop
        t_fIdg_t := t_fIdg_t + cf.f_IdgL1[k]*cf.f_IdgL2[k];
      end for;
    end if;
    if not cf.f_IdgNp == 0 then
      for k in 1:cf.f_IdgNp loop
        t_fIdg_t := t_fIdg_t + cf.f_IdgP1[k]*cf.f_IdgP2[k]*tau^cf.f_IdgP2[k];
      end for;
    end if;
    if not cf.f_IdgNe == 0 then
      for k in 1:cf.f_IdgNe loop
        t_fIdg_t := t_fIdg_t + tau*cf.f_IdgE1[k]*cf.f_IdgE2[k]/
                    (exp(cf.f_IdgE2[k]*tau)-1);
      end for;
    end if;

  annotation(Inline=false,
             LateInline=true);
  end t_fIdg_t;

  redeclare function extends tt_fIdg_tt
    "Short form for tau*tau*(ddalpha_0/(dtau*dtau))_delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.f_IdgNl == 0 then
      for k in 1:cf.f_IdgNl loop
        tt_fIdg_tt := tt_fIdg_tt - cf.f_IdgL1[k]*cf.f_IdgL2[k];
      end for;
    end if;
    if not cf.f_IdgNp == 0 then
      for k in 1:cf.f_IdgNp loop
        tt_fIdg_tt := tt_fIdg_tt + cf.f_IdgP1[k]*cf.f_IdgP2[k]*
                      (cf.f_IdgP2[k]-1)*tau^cf.f_IdgP2[k];
      end for;
    end if;
    if not cf.f_IdgNe == 0 then
      for k in 1:cf.f_IdgNe loop
        tt_fIdg_tt := tt_fIdg_tt - tau^2*cf.f_IdgE1[k]*cf.f_IdgE2[k]^2*
                      exp(-cf.f_IdgE2[k]*tau)/((1-exp(-cf.f_IdgE2[k]*tau))^2);
      end for;
    end if;

  annotation(Inline=false,
             LateInline=true);
  end tt_fIdg_tt;

  redeclare function extends t_fRes_t
    "Short form for tau*(dalpha_r/dtau)_delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
        t_fRes_t := t_fRes_t + cf.f_ResP1[k]*cf.f_ResP3[k]*delta^cf.f_ResP2[k]*
                    tau^cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        t_fRes_t := t_fRes_t + cf.f_ResB1[k]*cf.f_ResB3[k]*delta^cf.f_ResB2[k]*
                    tau^cf.f_ResB3[k]*exp(-delta^cf.f_ResB4[k]);
      end for;
    end if;
    if not cf.f_ResNG == 0 then
      for k in 1:cf.f_ResNG loop
        t_fRes_t := t_fRes_t + cf.f_ResG1[k]*delta^cf.f_ResG2[k]*tau^
                    cf.f_ResG3[k]*exp(-cf.f_ResG4[k]*(delta - cf.f_ResG5[k])^2 -
                    cf.f_ResG6[k]*(tau - cf.f_ResG7[k])^2)*(cf.f_ResG3[k]-2*
                    cf.f_ResG6[k]*tau*(tau-cf.f_ResG7[k]));
      end for;
    end if;

  annotation(Inline=false,
             LateInline=true);
  end t_fRes_t;

  redeclare function extends tt_fRes_tt
    "Short form for tau*tau*(ddalpha_r/(dtau*dtau))_delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
        tt_fRes_tt := tt_fRes_tt + cf.f_ResP1[k]*cf.f_ResP3[k]*(cf.f_ResP3[k]-1)*
                      delta^cf.f_ResP2[k]*tau^cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        tt_fRes_tt := tt_fRes_tt + cf.f_ResB1[k]*cf.f_ResB3[k]*(cf.f_ResB3[k]-1)*
                      delta^cf.f_ResB2[k]*tau^cf.f_ResB3[k]*
                      exp(-delta^cf.f_ResB4[k]);
      end for;
    end if;
    if not cf.f_ResNG == 0 then
      for k in 1:cf.f_ResNG loop
        tt_fRes_tt := tt_fRes_tt + cf.f_ResG1[k]*delta^cf.f_ResG2[k]*tau^
                      cf.f_ResG3[k]*exp(-cf.f_ResG4[k]*(delta - cf.f_ResG5[k])^
                      2 - cf.f_ResG6[k]*(tau - cf.f_ResG7[k])^2)*
                      ((cf.f_ResG3[k]-2*cf.f_ResG6[k]*tau*(tau-cf.f_ResG7[k]))^
                      2-cf.f_ResG3[k]-2*
          cf.f_ResG6[k]*tau^2);
      end for;
    end if;

  annotation(Inline=false,
             LateInline=true);
  end tt_fRes_tt;

  redeclare function extends d_fRes_d
    "Short form for delta*(dalpha_r/(ddelta))_tau=const"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
        d_fRes_d := d_fRes_d + cf.f_ResP1[k]*cf.f_ResP2[k]*delta^cf.f_ResP2[k]*
                    tau^cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        d_fRes_d := d_fRes_d + cf.f_ResB1[k]*delta^cf.f_ResB2[k]*tau^
                    cf.f_ResB3[k]*exp(-delta^cf.f_ResB4[k])*(cf.f_ResB2[k]-
                    cf.f_ResB4[k]*delta^cf.f_ResB4[k]);
      end for;
    end if;
    if not cf.f_ResNG == 0 then
      for k in 1:cf.f_ResNG loop
        d_fRes_d := d_fRes_d + cf.f_ResG1[k]*delta^cf.f_ResG2[k]*tau^
                    cf.f_ResG3[k]*exp(-cf.f_ResG4[k]*(delta - cf.f_ResG5[k])^2 -
                    cf.f_ResG6[k]*(tau - cf.f_ResG7[k])^2)*(cf.f_ResG2[k]-2*
                    cf.f_ResG4[k]*delta*(delta-cf.f_ResG5[k]));
      end for;
    end if;

  annotation(Inline=false,
             LateInline=true);
  end d_fRes_d;

  redeclare function extends dd_fRes_dd
    "Short form for delta*delta(ddalpha_r/(ddelta*delta))_tau=const"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
        dd_fRes_dd := dd_fRes_dd + cf.f_ResP1[k]*cf.f_ResP2[k]*(cf.f_ResP2[k]-1)*
                      delta^cf.f_ResP2[k]*tau^cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        dd_fRes_dd := dd_fRes_dd + cf.f_ResB1[k]*delta^cf.f_ResB2[k]*tau^
                      cf.f_ResB3[k]*exp(-delta^cf.f_ResB4[k])*((cf.f_ResB2[k]-1-
                      cf.f_ResB4[k]*delta^cf.f_ResB4[k])*(cf.f_ResB2[k]-
                      cf.f_ResB4[k]*delta^cf.f_ResB4[k])-cf.f_ResB4[k]^2*
                      delta^cf.f_ResB4[k]);
      end for;
    end if;
    if not cf.f_ResNG == 0 then
      for k in 1:cf.f_ResNG loop
        dd_fRes_dd := dd_fRes_dd + cf.f_ResG1[k]*delta^cf.f_ResG2[k]*tau^
                      cf.f_ResG3[k]*exp(-cf.f_ResG4[k]*(delta - cf.f_ResG5[k])^
                      2 - cf.f_ResG6[k]*(tau - cf.f_ResG7[k])^2)*((cf.f_ResG2[k]-
                      2*cf.f_ResG4[k]*delta*(delta-cf.f_ResG5[k]))^2-
                      cf.f_ResG2[k]-2*cf.f_ResG4[k]*delta^2);
      end for;
    end if;

  annotation(Inline=false,
             LateInline=true);
  end dd_fRes_dd;

  redeclare function extends td_fRes_td
    "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
        td_fRes_td := td_fRes_td + cf.f_ResP1[k]*cf.f_ResP2[k]*cf.f_ResP3[k]*
                      delta^cf.f_ResP2[k]*tau^cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        td_fRes_td := td_fRes_td + cf.f_ResB1[k]*cf.f_ResB3[k]*delta^
                      cf.f_ResB2[k]*tau^cf.f_ResB3[k]*exp(-delta^cf.f_ResB4[k])*
                      (cf.f_ResB2[k]-cf.f_ResB4[k]*delta^cf.f_ResB4[k]);
      end for;
    end if;
    if not cf.f_ResNG == 0 then
      for k in 1:cf.f_ResNG loop
        td_fRes_td := td_fRes_td + cf.f_ResG1[k]*delta^cf.f_ResG2[k]*tau^
                      cf.f_ResG3[k]*exp(-cf.f_ResG4[k]*(delta - cf.f_ResG5[k])^
                      2 - cf.f_ResG6[k]*(tau - cf.f_ResG7[k])^2)*(cf.f_ResG3[k]-
                      2*cf.f_ResG6[k]*tau*(tau-cf.f_ResG7[k]))*(cf.f_ResG2[k]-2*
                      cf.f_ResG4[k]*delta*(delta-cf.f_ResG5[k]));
      end for;
    end if;

  annotation(Inline=false,
             LateInline=true);
  end td_fRes_td;

  redeclare function extends ttt_fIdg_ttt
    "Short form for tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.f_IdgNl == 0 then
      for k in 1:cf.f_IdgNl loop
        ttt_fIdg_ttt := ttt_fIdg_ttt + 2*cf.f_IdgL1[k]*cf.f_IdgL2[k];
      end for;
    end if;
    if not cf.f_IdgNp == 0 then
      for k in 1:cf.f_IdgNp loop
        ttt_fIdg_ttt := ttt_fIdg_ttt + cf.f_IdgP1[k]*cf.f_IdgP2[k]*
                        (cf.f_IdgP2[k]-1)*(cf.f_IdgP2[k]-2)*tau^cf.f_IdgP2[k];
      end for;
    end if;
    if not cf.f_IdgNe == 0 then
      for k in 1:cf.f_IdgNe loop
        ttt_fIdg_ttt := ttt_fIdg_ttt + tau^3*cf.f_IdgE1[k]*cf.f_IdgE2[k]^3*
                        exp(cf.f_IdgE2[k]*tau)*(exp(cf.f_IdgE2[k]*tau)+1)/
                        ((exp(cf.f_IdgE2[k]*tau)-1)^3);
      end for;
    end if;

    annotation(Inline=false,
               LateInline=true);
  end ttt_fIdg_ttt;

  redeclare function extends ttt_fRes_ttt
    "Short form for tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
        ttt_fRes_ttt := ttt_fRes_ttt + cf.f_ResP1[k]*cf.f_ResP3[k]*
                        (cf.f_ResP3[k]-1)*(cf.f_ResP3[k]-2)*delta^cf.f_ResP2[k]*
                        tau^cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        ttt_fRes_ttt := ttt_fRes_ttt + cf.f_ResB1[k]*cf.f_ResB3[k]*
                        (cf.f_ResB3[k]-1)*(cf.f_ResB3[k]-2)*delta^cf.f_ResB2[k]*
                        tau^cf.f_ResB3[k]*exp(-delta^cf.f_ResB4[k]);
      end for;
    end if;
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNG loop
        ttt_fRes_ttt := ttt_fRes_ttt - cf.f_ResG1[k]*delta^cf.f_ResG2[k]*tau^
                        cf.f_ResG3[k]*(8*cf.f_ResG6[k]^3*tau^6-24*cf.f_ResG6[k]^
                        3*cf.f_ResG7[k]*tau^5+12*cf.f_ResG6[k]^2*(2*
                        cf.f_ResG6[k]*cf.f_ResG7[k]^2-cf.f_ResG3[k]-1)*tau^4-4*
                        cf.f_ResG6[k]^2*cf.f_ResG7[k]*(2*cf.f_ResG6[k]*
                        cf.f_ResG7[k]^2-6*cf.f_ResG3[k]-3)*tau^3-6*cf.f_ResG3[k]*
                        cf.f_ResG6[k]*(2*cf.f_ResG6[k]*cf.f_ResG7[k]^2-
                        cf.f_ResG3[k])*tau^2-6*(cf.f_ResG3[k]-1)*cf.f_ResG3[k]*
                        cf.f_ResG6[k]*cf.f_ResG7[k]*tau-cf.f_ResG3[k]^3+3*
                        cf.f_ResG3[k]^2-2*cf.f_ResG3[k])*exp(-cf.f_ResG6[k]*
                        (tau-cf.f_ResG7[k])^2-cf.f_ResG4[k]*(delta-
                        cf.f_ResG5[k])^2);
      end for;
    end if;
    annotation(Inline=false,
          LateInline=true);
  end ttt_fRes_ttt;

  redeclare function extends ddd_fRes_ddd
    "Short form for delta*delta*delta*
  (dddalpha_r/(ddelta*ddelta*ddelta))_tau=const"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
        ddd_fRes_ddd := ddd_fRes_ddd + cf.f_ResP1[k]*cf.f_ResP2[k]*
                        (cf.f_ResP2[k]-1)*(cf.f_ResP2[k]-2)*delta^cf.f_ResP2[k]*
                        tau^cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        ddd_fRes_ddd := ddd_fRes_ddd - cf.f_ResB1[k]*delta^cf.f_ResB2[k]*tau^
                        cf.f_ResB3[k]*exp(-delta^cf.f_ResB4[k])*(cf.f_ResB4[k]*
                        delta^cf.f_ResB4[k]*(cf.f_ResB4[k]*(delta^cf.f_ResB4[k]*
                        (cf.f_ResB4[k]*(delta^cf.f_ResB4[k]-3)-3*cf.f_ResB2[k]+3)+
                        cf.f_ResB4[k]+3*cf.f_ResB2[k]-3)+3*cf.f_ResB2[k]^2-6*
                        cf.f_ResB2[k]+2)-(cf.f_ResB2[k]-2)*(cf.f_ResB2[k]-1)*
                        cf.f_ResB2[k]);
      end for;
    end if;
    if not cf.f_ResNG == 0 then
      for k in 1:cf.f_ResNG loop
        ddd_fRes_ddd := ddd_fRes_ddd - cf.f_ResG1[k]*tau^cf.f_ResG3[k]*delta^
                        cf.f_ResG2[k]*(8*cf.f_ResG4[k]^3*delta^6-24*cf.f_ResG4[k]^
                        3*cf.f_ResG5[k]*delta^5+12*cf.f_ResG4[k]^2*(2*
                        cf.f_ResG4[k]*cf.f_ResG5[k]^2-cf.f_ResG2[k]-1)*delta^4-4*
                        cf.f_ResG4[k]^2*cf.f_ResG5[k]*(2*cf.f_ResG4[k]*
                        cf.f_ResG5[k]^2-6*cf.f_ResG2[k]-3)*delta^3-6*
                        cf.f_ResG2[k]*cf.f_ResG4[k]*(2*cf.f_ResG4[k]*
                        cf.f_ResG5[k]^2-cf.f_ResG2[k])*delta^2-6*(cf.f_ResG2[k]-1)
                        *cf.f_ResG2[k]*cf.f_ResG4[k]*cf.f_ResG5[k]*delta-
                        cf.f_ResG2[k]^3+3*cf.f_ResG2[k]^2-2*cf.f_ResG2[k])*
                        exp(-cf.f_ResG4[k]*(delta-cf.f_ResG5[k])^2-cf.f_ResG6[k]*
                        (tau-cf.f_ResG7[k])^2);
      end for;
    end if;

    annotation(Inline=false,
               LateInline=true);
  end ddd_fRes_ddd;

  redeclare function extends tdd_fRes_tdd
    "Short form for tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
        tdd_fRes_tdd := tdd_fRes_tdd + cf.f_ResP1[k]*cf.f_ResP2[k]*(
                        cf.f_ResP2[k]-1)*cf.f_ResP3[k]*delta^cf.f_ResP2[k]*tau^
                        cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        tdd_fRes_tdd := tdd_fRes_tdd + cf.f_ResB1[k]*cf.f_ResB3[k]*delta^
                        cf.f_ResB2[k]*tau^cf.f_ResB3[k]*exp(-delta^cf.f_ResB4[k])*
                        (cf.f_ResB4[k]*delta^cf.f_ResB4[k]*(cf.f_ResB4[k]*(delta^
                        cf.f_ResB4[k]-1)-2*cf.f_ResB2[k]+1)+cf.f_ResB2[k]*
                        (cf.f_ResB2[k]-1));
      end for;
    end if;
    if not cf.f_ResNG == 0 then
      for k in 1:cf.f_ResNG loop
        tdd_fRes_tdd := tdd_fRes_tdd + cf.f_ResG1[k]*delta^cf.f_ResG2[k]*tau^
                        cf.f_ResG3[k]*exp(-cf.f_ResG4[k]*(delta-cf.f_ResG5[k])^
                        2 - cf.f_ResG6[k]*(tau - cf.f_ResG7[k])^2)*
                        (cf.f_ResG3[k]-2*cf.f_ResG6[k]*tau*(tau-cf.f_ResG7[k]))*
                        ((cf.f_ResG2[k]-2*cf.f_ResG4[k]*delta*(delta-
                        cf.f_ResG5[k]))^2-cf.f_ResG2[k]-2*cf.f_ResG4[k]*delta^2);
      end for;
    end if;

    annotation(Inline=false,
               LateInline=true);
  end tdd_fRes_tdd;

  redeclare function extends ttd_fRes_ttd
    "Short form for tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))"
  protected
    EoS cf;

  algorithm
    if not cf.f_ResNp == 0 then
      for k in 1:cf.f_ResNp loop
        ttd_fRes_ttd := ttd_fRes_ttd + cf.f_ResP1[k]*cf.f_ResP2[k]*cf.f_ResP3[k]*
                        (cf.f_ResP3[k]-1)*delta^cf.f_ResP2[k]*tau^cf.f_ResP3[k];
      end for;
    end if;
    if not cf.f_ResNb == 0 then
      for k in 1:cf.f_ResNb loop
        ttd_fRes_ttd := ttd_fRes_ttd + cf.f_ResB1[k]*cf.f_ResB3[k]*(
                        cf.f_ResB3[k]-1)*delta^cf.f_ResB2[k]*tau^cf.f_ResB3[k]*
                        exp(-delta^cf.f_ResB4[k])*(cf.f_ResB2[k]-cf.f_ResB4[k]*
                        delta^cf.f_ResB4[k]);
      end for;
    end if;
    if not cf.f_ResNG == 0 then
      for k in 1:cf.f_ResNG loop
        ttd_fRes_ttd := ttd_fRes_ttd + cf.f_ResG1[k]*delta^cf.f_ResG2[k]*tau^
                        cf.f_ResG3[k]*exp(-cf.f_ResG4[k]*(delta-cf.f_ResG5[k])^
                        2 - cf.f_ResG6[k]*(tau-cf.f_ResG7[k])^2)*(cf.f_ResG2[k]-
                        2*cf.f_ResG4[k]*delta*(delta-cf.f_ResG5[k]))*((
                        cf.f_ResG3[k]-2*cf.f_ResG6[k]*tau*(tau-cf.f_ResG7[k]))^
                        2-cf.f_ResG3[k]-2*cf.f_ResG6[k]*tau^2);
      end for;
    end if;

    annotation(Inline=false,
               LateInline=true);
  end ttd_fRes_ttd;
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
      for k in 1:cf.psat_Nt loop
        p_1 :=p_1 + cf.psat_N[k]*OM^cf.psat_E[k];
      end for;
      p := fluidConstants[1].criticalPressure *
           exp(fluidConstants[1].criticalTemperature/T * p_1);
    end if;

    annotation(smoothOrder = 2,
               Inline=false,
               LateInline=true);
  end saturationPressure;

  redeclare function extends saturationTemperature
    "Saturation temperature of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real T_1 = 0;
    Real x = 0;

  algorithm
    x := (p - cf.Tsat_IO[1])/cf.Tsat_IO[2];
    for k in 1:cf.Tsat_Nt-1 loop
      T_1 := T_1 + cf.Tsat_N[k]*x^(cf.Tsat_Nt - k);
    end for;
    T_1 := T_1 + cf.Tsat_N[cf.Tsat_Nt];
    T := T_1*cf.Tsat_IO[4] + cf.Tsat_IO[3];

    annotation(smoothOrder = 2,
               Inline=false,
               LateInline=true);
  end saturationTemperature;

  redeclare function extends bubbleDensity
    "Boiling curve specific density of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real dl_1 = 0;
    Real x = 0;

  algorithm
    x := (sat.Tsat - cf.dl_IO[1])/cf.dl_IO[2];
    for k in 1:cf.dl_Nt-1 loop
      dl_1 := dl_1 + cf.dl_N[k]*x^(cf.dl_Nt - k);
    end for;
    dl_1 := dl_1 + cf.dl_N[cf.dl_Nt];
    dl := dl_1*cf.dl_IO[4] + cf.dl_IO[3];

    annotation(smoothOrder = 2,
               Inline=false,
               LateInline=true);
  end bubbleDensity;

  redeclare function extends dewDensity
    "Dew curve specific density of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real dv_1 = 0;
    Real x = 0;

  algorithm
    x := (sat.Tsat - cf.dv_IO[1])/cf.dv_IO[2];
    for k in 1:cf.dv_Nt-1 loop
      dv_1 := dv_1 + cf.dv_N[k]*x^(cf.dv_Nt - k);
    end for;
    dv_1 := dv_1 + cf.dv_N[cf.dv_Nt];
    dv := dv_1*cf.dv_IO[4] + cf.dv_IO[3];

    annotation(smoothOrder = 2,
               Inline=false,
               LateInline=true);
  end dewDensity;

  redeclare function extends bubbleEnthalpy
    "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real hl_1 = 0;
    Real x = 0;

  algorithm
    x := (sat.psat - cf.hl_IO[1])/cf.hl_IO[2];
    for k in 1:cf.hl_Nt-1 loop
      hl_1 := hl_1 + cf.hl_N[k]*x^(cf.hl_Nt - k);
    end for;
    hl_1 := hl_1 + cf.hl_N[cf.hl_Nt];
    hl := hl_1*cf.hl_IO[4] + cf.hl_IO[3];

    annotation(smoothOrder = 2,
               Inline=false,
               LateInline=true);
  end bubbleEnthalpy;

  redeclare function extends dewEnthalpy
    "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real hv_1 = 0;
    Real x = 0;

  algorithm
    x := (sat.psat - cf.hv_IO[1])/cf.hv_IO[2];
    for k in 1:cf.hv_Nt-1 loop
      hv_1 := hv_1 + cf.hv_N[k]*x^(cf.hv_Nt - k);
    end for;
    hv_1 := hv_1 + cf.hv_N[cf.hv_Nt];
    hv := hv_1*cf.hv_IO[4] + cf.hv_IO[3];

    annotation(smoothOrder = 2,
               Inline=false,
               LateInline=true);
  end dewEnthalpy;

  redeclare function extends bubbleEntropy
    "Boiling curve specific entropy of refrigerant (Ancillary equation)"
  protected
    BDSP cf;
    Real sl_1 = 0;
    Real x = 0;

  algorithm
    x := (sat.psat - cf.sl_IO[1])/cf.sl_IO[2];
    for k in 1:cf.sl_Nt-1 loop
      sl_1 := sl_1 + cf.sl_N[k]*x^(cf.sl_Nt - k);
    end for;
    sl_1 := sl_1 + cf.sl_N[cf.sl_Nt];
    sl := sl_1*cf.sl_IO[4] + cf.sl_IO[3];

    annotation(smoothOrder = 2,
               Inline=false,
               LateInline=true);
  end bubbleEntropy;

  redeclare function extends dewEntropy
    "Dew curve specific entropy of propane (Ancillary equation)"
  protected
    BDSP cf;
    Real sv_1 = 0;
    Real x = 0;

  algorithm
    x := (sat.psat - cf.sv_IO[1])/cf.sv_IO[2];
    for k in 1:cf.sv_Nt-1 loop
      sv_1 := sv_1 + cf.sv_N[k]*x^(cf.sv_Nt - k);
    end for;
    sv_1 := sv_1 + cf.sv_N[cf.sv_Nt];
    sv := sv_1*cf.sv_IO[4] + cf.sv_IO[3];

    annotation(smoothOrder = 2,
               Inline=false,
               LateInline=true);
  end dewEntropy;
  /*Provide functions to calculate thermodynamic properties depending on the
    independent variables. Moreover, these functions may depend on the
    Helmholtz EoS. Just change these functions if needed.
  */
  redeclare function temperature_ph
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
    SpecificEnthalpy h_dew = 0;
    SpecificEnthalpy h_bubble = 0;

    Real x1 = 0;
    Real y1 = 0;
    Real T1 = 0;
    Real x2 = 0;
    Real y2 = 0;
    Real T2 = 0;
    Integer count = 0;

  algorithm
    h_dew := dewEnthalpy(sat = setSat_p(p=p));
    h_bubble := bubbleEnthalpy(sat = setSat_p(p=p));

    if h<h_bubble-dh then
      x1 := (p-cf.T_phIO[1])/cf.T_phIO[2];
      y1 := (h-cf.T_phIO[3])/cf.T_phIO[4];
      T1 := cf.Tl_phD[1];
      for i in 1:cf.T_phNt[1] loop
        T1 := T1 + cf.Tl_phA[i]*x1^i;
      end for;
      for j in 1:cf.T_phNt[2] loop
        T1 := T1 + cf.Tl_phB[j]*y1^j;
      end for;
      if cf.T_phNt[1] >= cf.T_phNt[2] then
        for i in 1:cf.T_phNt[1]-1 loop
          for j in 1:min(i,cf.T_phNt[2]) loop
            count :=count + 1;
            T1 := T1 + cf.Tl_phC[count]*
                  x1^(cf.T_phNt[1] - i)*y1^j;
          end for;
        end for;
      else
        for j in 1:cf.T_phNt[2]-1 loop
          for i in 1:min(j,cf.T_phNt[1]) loop
            count :=count + 1;
            T1 := T1 + cf.Tl_phC[count]*
                  y1^(cf.T_phNt[2] - j)*x1^i;
          end for;
        end for;
      end if;
      T := T1*cf.T_phIO[6]+cf.T_phIO[5];
    elseif h>h_dew+dh then
       x2 := (p-cf.T_phIO[7])/cf.T_phIO[8];
       y2 := (h-cf.T_phIO[9])/cf.T_phIO[10];
       T2 := cf.Tv_phD[1];
       for i in 1:cf.T_phNt[4] loop
         T2:= T2 + cf.Tv_phA[i]*x2^i;
       end for;
       for j in 1:cf.T_phNt[5] loop
         T2:= T2 + cf.Tv_phB[j]*y2^j;
       end for;
       if cf.T_phNt[4] >= cf.T_phNt[5] then
         for i in 1:cf.T_phNt[4]-1 loop
           for j in 1:min(i, cf.T_phNt[5]) loop
             count :=count + 1;
             T2 := T2 + cf.Tv_phC[count]*
                   x2^(cf.T_phNt[4] - i)*y2^j;
           end for;
         end for;
       else
         for j in 1:cf.T_phNt[5]-1 loop
           for i in 1:min(j,cf.T_phNt[4]) loop
             count :=count + 1;
             T2 := T2 + cf.Tv_phC[count]*
                   y2^(cf.T_phNt[5] - j)*x2^i;
           end for;
         end for;
       end if;
       T := T2*cf.T_phIO[12]+cf.T_phIO[11];
    else
      if h<h_bubble then
        x1 := (p-cf.T_phIO[1])/cf.T_phIO[2];
        y1 := (h-cf.T_phIO[3])/cf.T_phIO[4];
        T1 := cf.Tl_phD[1];
        for i in 1:cf.T_phNt[1] loop
          T1 := T1 + cf.Tl_phA[i]*x1^i;
        end for;
        for j in 1:cf.T_phNt[2] loop
          T1 := T1 + cf.Tl_phB[j]*y1^j;
        end for;
        if cf.T_phNt[1] >= cf.T_phNt[2] then
          for i in 1:cf.T_phNt[1]-1 loop
            for j in 1:min(i, cf.T_phNt[2]) loop
              count :=count + 1;
              T1 := T1 + cf.Tl_phC[count]*
                    x1^(cf.T_phNt[1] - i)*y1^j;
            end for;
          end for;
        else
          for j in 1:cf.T_phNt[2]-1 loop
            for i in 1:min(j,cf.T_phNt[1]) loop
              count :=count + 1;
              T1 := T1 + cf.Tl_phC[count]*
                    y1^(cf.T_phNt[2] - j)*x1^i;
            end for;
          end for;
        end if;
        T1 := T1*cf.T_phIO[6]+cf.T_phIO[5];
        T := saturationTemperature(p)*(1 - (h_bubble - h)/dh) +
          T1*(h_bubble - h)/dh;
      elseif h>h_dew then
        x2 := (p-cf.T_phIO[7])/cf.T_phIO[8];
        y2 := (h-cf.T_phIO[9])/cf.T_phIO[10];
        T2 := cf.Tv_phD[1];
        for i in 1:cf.T_phNt[4] loop
          T2:= T2 + cf.Tv_phA[i]*x2^i;
        end for;
        for j in 1:cf.T_phNt[5] loop
          T2:= T2 + cf.Tv_phB[j]*y2^j;
        end for;
        if cf.T_phNt[4] >= cf.T_phNt[5] then
          for i in 1:cf.T_phNt[4]-1 loop
            for j in 1:min(i, cf.T_phNt[5]) loop
              count :=count + 1;
              T2 := T2 + cf.Tv_phC[count]*
                    x2^(cf.T_phNt[4] - i)*y2^j;
            end for;
          end for;
        else
          for j in 1:cf.T_phNt[5]-1 loop
            for i in 1:min(j,cf.T_phNt[4]) loop
              count :=count + 1;
              T2 := T2 + cf.Tv_phC[count]*
                    y2^(cf.T_phNt[5] - j)*x2^i;
            end for;
          end for;
        end if;
        T2 := T2*cf.T_phIO[12]+cf.T_phIO[11];
        T := saturationTemperature(p)*(1 - (h - h_dew)/dh) +
             T2*(h - h_dew)/dh;
      else
        T := saturationTemperature(p);
      end if;
    end if;

    annotation(derivative(noDerivative=phase)=temperature_ph_der,
               inverse(h=specificEnthalpy_pT(p=p,T=T,phase=phase)),
               Inline=false,
               LateInline=false);
  end temperature_ph;

  redeclare function temperature_ps
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
    SpecificEntropy s_dew = 0;
    SpecificEntropy s_bubble = 0;

    Real x1 = 0;
    Real y1 = 0;
    Real T1 = 0;
    Real x2 = 0;
    Real y2 = 0;
    Real T2 = 0;
    Integer count = 0;

  algorithm
    s_dew := dewEntropy(sat = setSat_p(p=p));
    s_bubble := bubbleEntropy(sat = setSat_p(p=p));

    if s<s_bubble-ds then
      x1 := (log(p)-cf.T_psIO[1])/cf.T_psIO[2];
      y1 := (s-cf.T_psIO[3])/cf.T_psIO[4];
      T1 := cf.Tl_psD[1];
      for i in 1:cf.T_psNt[1] loop
        T1:= T1 + cf.Tl_psA[i]*x1^i;
      end for;
      for j in 1:cf.T_psNt[2] loop
        T1:= T1 + cf.Tl_psB[j]*y1^j;
      end for;
      if cf.T_psNt[1] >= cf.T_psNt[2] then
        for i in 1:cf.T_psNt[1]-1 loop
          for j in 1:min(i,cf.T_psNt[2]) loop
            count :=count + 1;
            T1 := T1 + cf.Tl_psC[count]*
                  x1^(cf.T_psNt[1] - i)*y1^j;
          end for;
        end for;
      else
        for j in 1:cf.T_psNt[2]-1 loop
          for i in 1:min(j,cf.T_psNt[1]) loop
            count :=count + 1;
            T1 := T1 + cf.Tl_psC[count]*
                  y1^(cf.T_psNt[2] - j)*x1^i;
          end for;
        end for;
      end if;
      T := T1;
      T := T1*cf.T_psIO[6]+cf.T_psIO[5];
    elseif s>s_dew+ds then
        x2 := (log(p)-cf.T_psIO[7])/cf.T_psIO[8];
        y2 := (s-cf.T_psIO[9])/cf.T_psIO[10];
        T2 := cf.Tv_psD[1];
        for i in 1:cf.T_psNt[4] loop
          T2:= T2 + cf.Tv_psA[i]*x2^i;
        end for;
        for j in 1:cf.T_psNt[5] loop
          T2:= T2 + cf.Tv_psB[j]*y2^j;
        end for;
        if cf.T_psNt[4] >= cf.T_psNt[5] then
          for i in 1:cf.T_psNt[4]-1 loop
            for j in 1:min(i,cf.T_psNt[5]) loop
              count :=count + 1;
              T2 := T2 + cf.Tv_psC[count]*
                    x2^(cf.T_psNt[4] - i)*y2^j;
            end for;
          end for;
        else
          for j in 1:cf.T_psNt[5]-1 loop
            for i in 1:min(j,cf.T_psNt[4]) loop
              count :=count + 1;
              T2 := T2 + cf.Tv_psC[count]*
                    y2^(cf.T_psNt[5] - j)*x2^i;
            end for;
          end for;
        end if;
        T := T2*cf.T_psIO[12]+cf.T_psIO[11];
    else
      if s<s_bubble then
        x1 := (log(p)-cf.T_psIO[1])/cf.T_psIO[2];
        y1 := (s-cf.T_psIO[3])/cf.T_psIO[4];
        T1 := cf.Tl_psD[1];
        for i in 1:cf.T_psNt[1] loop
          T1:= T1 + cf.Tl_psA[i]*x1^i;
        end for;
        for j in 1:cf.T_psNt[2] loop
          T1:= T1 + cf.Tl_psB[j]*y1^j;
        end for;
        if cf.T_psNt[1] >= cf.T_psNt[2] then
          for i in 1:cf.T_psNt[1]-1 loop
            for j in 1:min(i,cf.T_psNt[2]) loop
              count :=count + 1;
              T1 := T1 + cf.Tl_psC[count]*
                    x1^(cf.T_psNt[1] - i)*y1^j;
            end for;
          end for;
        else
          for j in 1:cf.T_psNt[2]-1 loop
            for i in 1:min(j,cf.T_psNt[1]) loop
              count :=count + 1;
              T1 := T1 + cf.Tl_psC[count]*
                    y1^(cf.T_psNt[2] - j)*x1^i;
            end for;
          end for;
        end if;
        T1 := T1*cf.T_psIO[6]+cf.T_psIO[5];
        T := saturationTemperature(p)*(1 - (s_bubble - s)/ds) +
             T1*(s_bubble - s)/ds;
      elseif s>s_dew then
        x2 := (log(p)-cf.T_psIO[7])/cf.T_psIO[8];
        y2 := (s-cf.T_psIO[9])/cf.T_psIO[10];
        T2 := cf.Tv_psD[1];
        for i in 1:cf.T_psNt[4] loop
          T2:= T2 + cf.Tv_psA[i]*x2^i;
        end for;
        for j in 1:cf.T_psNt[5] loop
          T2:= T2 + cf.Tv_psB[j]*y2^j;
        end for;
        if cf.T_psNt[4] >= cf.T_psNt[5] then
          for i in 1:cf.T_psNt[4]-1 loop
            for j in 1:min(i,cf.T_psNt[5]) loop
              count :=count + 1;
              T2 := T2 + cf.Tv_psC[count]*
                    x2^(cf.T_psNt[4] - i)*y2^j;
            end for;
          end for;
        else
          for j in 1:cf.T_psNt[5]-1 loop
            for i in 1:min(j,cf.T_psNt[4]) loop
              count :=count + 1;
              T2 := T2 + cf.Tv_psC[count]*
                    y2^(cf.T_psNt[5] - j)*x2^i;
            end for;
          end for;
        end if;
        T2 := T2*cf.T_psIO[12]+cf.T_psIO[11];
        T := saturationTemperature(p)*(1 - (s - s_dew)/ds) +
             T2*(s - s_dew)/ ds;
      else
        T := saturationTemperature(p);
      end if;
    end if;

    annotation(derivative(noDerivative=phase)=temperature_ps_der);
  end temperature_ps;

  redeclare function density_pT
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

    Real x1 = 0;
    Real y1 = 0;
    Real d1 = 0;
    Real x2 = 0;
    Real y2 = 0;
    Real d2 = 0;
    Integer count = 0;

  algorithm
    if p<sat.psat-dp then
      x1 := (p-cf.d_pTIO[7])/cf.d_pTIO[8];
      y1 := (T-cf.d_pTIO[9])/cf.d_pTIO[10];
      d1 := cf.dv_pTD[1];
      for i in 1:cf.d_pTNt[4] loop
        d1:= d1 + cf.dv_pTA[i]*x1^i;
      end for;
      for j in 1:cf.d_pTNt[5] loop
        d1:= d1 + cf.dv_pTB[j]*y1^j;
      end for;
      if cf.d_pTNt[4] >= cf.d_pTNt[5] then
        for i in 1:cf.d_pTNt[4]-1 loop
          for j in 1:min(i,cf.d_pTNt[5]) loop
            count :=count + 1;
            d1 := d1 + cf.dv_pTC[count]*
                  x1^(cf.d_pTNt[4] - i)*y1^j;
          end for;
        end for;
      else
        for j in 1:cf.d_pTNt[5]-1 loop
          for i in 1:min(j,cf.d_pTNt[4]) loop
            count :=count + 1;
            d1 := d1 + cf.dv_pTC[count]*
                  y1^(cf.d_pTNt[5] - j)*x1^i;
          end for;
        end for;
      end if;
      d := d1*cf.d_pTIO[12]+cf.d_pTIO[11];
    elseif p>sat.psat+dp then
      x2 := (p-cf.d_pTIO[1])/cf.d_pTIO[2];
      y2 := (T-cf.d_pTIO[3])/cf.d_pTIO[4];
      d2 := cf.dl_pTD[1];
      for i in 1:cf.d_pTNt[1] loop
        d2:= d2 + cf.dl_pTA[i]*x2^i;
      end for;
      for j in 1:cf.d_pTNt[2] loop
        d2:= d2 + cf.dl_pTB[j]*y2^j;
      end for;
      if cf.d_pTNt[1] >= cf.d_pTNt[2] then
        for i in 1:cf.d_pTNt[1]-1 loop
          for j in 1:min(i,cf.d_pTNt[2]) loop
            count :=count + 1;
            d2 := d2 + cf.dl_pTC[count]*
                  x2^(cf.d_pTNt[1] - i)*y2^j;
          end for;
        end for;
      else
        for j in 1:cf.d_pTNt[2]-1 loop
          for i in 1:min(j,cf.d_pTNt[1]) loop
            count :=count + 1;
            d2 := d2 + cf.dl_pTC[count]*
                  y2^(cf.d_pTNt[2] - j)*x2^i;
          end for;
        end for;
      end if;
      d := d2*cf.d_pTIO[6]+cf.d_pTIO[5];
    else
      if p<sat.psat then
        x1 := (p-cf.d_pTIO[7])/cf.d_pTIO[8];
        y1 := (T-cf.d_pTIO[9])/cf.d_pTIO[10];
        d1 := cf.dv_pTD[1];
        for i in 1:cf.d_pTNt[4] loop
          d1:= d1 + cf.dv_pTA[i]*x1^i;
        end for;
        for j in 1:cf.d_pTNt[5] loop
          d1:= d1 + cf.dv_pTB[j]*y1^j;
        end for;
        if cf.d_pTNt[4] >= cf.d_pTNt[5] then
          for i in 1:cf.d_pTNt[4]-1 loop
            for j in 1:min(i,cf.d_pTNt[5]) loop
              count :=count + 1;
              d1 := d1 + cf.dv_pTC[count]*
                    x1^(cf.d_pTNt[4] - i)*y1^j;
            end for;
          end for;
        else
          for j in 1:cf.d_pTNt[5]-1 loop
            for i in 1:min(j,cf.d_pTNt[4]) loop
              count :=count + 1;
              d1 := d1 + cf.dv_pTC[count]*
                    y1^(cf.d_pTNt[5] - j)*x1^i;
            end for;
          end for;
        end if;
        d1 := d1*cf.d_pTIO[12]+cf.d_pTIO[11];
        d := bubbleDensity(sat)*(1 -(sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
      elseif p>=sat.psat then
        x2 := (p-cf.d_pTIO[1])/cf.d_pTIO[2];
        y2 := (T-cf.d_pTIO[3])/cf.d_pTIO[4];
        d2 := cf.dl_pTD[1];
        for i in 1:cf.d_pTNt[1] loop
          d2:= d2 + cf.dl_pTA[i]*x2^i;
        end for;
        for j in 1:cf.d_pTNt[2] loop
          d2:= d2 + cf.dl_pTB[j]*y2^j;
        end for;
        if cf.d_pTNt[1] >= cf.d_pTNt[2] then
          for i in 1:cf.d_pTNt[1]-1 loop
            for j in 1:min(i,cf.d_pTNt[2]) loop
              count :=count + 1;
              d2 := d2 + cf.dl_pTC[count]*
                    x2^(cf.d_pTNt[1] - i)*y2^j;
            end for;
          end for;
        else
          for j in 1:cf.d_pTNt[2]-1 loop
            for i in 1:min(j,cf.d_pTNt[1]) loop
              count :=count + 1;
              d2 := d2 + cf.dl_pTC[count]*
                    y2^(cf.d_pTNt[2] - j)*x2^i;
            end for;
          end for;
        end if;
        d2 := d2*cf.d_pTIO[6]+cf.d_pTIO[5];
        d := dewDensity(sat)*(1 -(p - sat.psat)/dp) + d2*(p - sat.psat)/dp;
      end if;
    end if;

    annotation(derivative(noDerivative=phase)=density_pT_der,
          inverse(p=pressure_dT(d=d,T=T,phase=phase)));
  end density_pT;
  annotation (Documentation(revisions="<html><ul>
  <li>June 6, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package provides the implementation of a refrigerant modelling
  approach using a hybrid approach. The hybrid approach is developed by
  Sangi et al. and consists of both the Helmholtz equation of state and
  fitted formula for thermodynamic state properties at bubble or dew
  line (e.g. p<sub>sat</sub> or h<sub>l,sat</sub>) and thermodynamic
  state properties depending on two independent state properties (e.g.
  T_ph or T_ps). In the following, the basic formulas of the hybrid
  approach are given.
</p>
<p>
  <b>The Helmholtz equation of state</b>
</p>
<p>
  The Helmholtz equation of state (EoS) allows the accurate description
  of fluids' thermodynamic behaviour and uses the Helmholtz energy as
  fundamental thermodynamic relation with temperature and density as
  independent variables. Furthermore, the EoS allows determining all
  thermodynamic state properties from its partial derivatives and its
  <b>general formula</b> is given below:
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_EoS.png\"
  alt=\"Calculation procedure of dimensionless Helmholtz energy\">
</p>
<p>
  As it can be seen, the general formula of the EoS can be divided in
  two part: The <b>ideal gas part (left summand)</b> and the
  <b>residual part (right summand)</b>. Both parts' formulas are given
  below:
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_IdealGasPart.png\"
  alt=
  \"Calculation procedure of dimensionless ideal gas Helmholtz energy\">
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/Helmholtz_ResidualPart.png\"
  alt=
  \"Calculation procedure of dimensionless residual Helmholtz energy\">
</p>
<p>
  Both, the ideal gas part and the residual part can be divided in
  three subparts (i.e. the summations) that contain different
  coefficients (e.g. nL, l<sub>i</sub>, p<sub>i</sub> or
  e<sub>i</sub>). These coefficients are fitting coefficients and must
  be obtained during a fitting procedure. While the fitting procedure,
  the general formula of the EoS is fitted to external data (e.g.
  obtained from measurements or external media libraries) and the
  fitting coefficients are determined. In order to keep the package
  clear and easy to extend, the fitting coefficients are stored in
  records inherited from the base data definition <a href=
  \"modelica://AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition\">
  AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition</a>
  .
</p>
<p>
  For further information of <b>the EoS and its partial
  derivatives</b>, please read the paper \" <a href=
  \"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia - A
  fluid properties library</a>\" by Thorade and Saadat as well as the
  paper\" <a href=
  \"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
  Partial derivatives of thermodynamic state properties for dynamic
  simulation</a>\" by Thorade and Saadat.
</p>
<p>
  <b>Fitted formulas</b>
</p>
<p>
  Fitted formulas allow to reduce the overall computing time of the
  refrigerant model. Therefore, both thermodynamic state properties at
  bubble and dew line and thermodynamic state properties depending on
  two independent state properties are expresses as fitted formulas.
  The fitted formulas' approaches implemented in this package are
  developed by Sangi et al. within their \"Fast_Propane\" model and given
  below:<br/>
</p>
<table summary=\"Formulas for calculating saturation properties\"
cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\" style=
\"border-collapse:collapse;\">
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Saturation pressure</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationPressure.png\"
        alt=\"Formula to calculate saturation pressure\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Saturation temperature</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/SaturationTemperature.png\"
        alt=\"Formula to calculate saturation temperature\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Bubble density</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleDensity.png\"
        alt=\"Formula to calculate bubble density\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Dew density</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewDensity.png\"
        alt=\"Formula to calculate dew density\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Bubble Enthalpy</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEnthalpy.png\"
        alt=\"Formula to calculate bubble enthalpy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Dew Enthalpy</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEnthalpy.png\"
        alt=\"Formula to calculate dew enthalpy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Bubble Entropy</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/BubbleEntropy.png\"
        alt=\"Formula to calculate bubble entropy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Dew Entropy</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/DewEntropy.png\"
        alt=\"Formula to calculate dew entropy\">
      </p>
    </td>
  </tr>
</table>
<table summary=
\"Formulas for calculating thermodynamic properties at superheated and supercooled regime\"
cellspacing=\"0\" cellpadding=\"3\" border=\"1\" width=\"80%\" style=
\"border-collapse:collapse;\">
  <tr>
    <td valign=\"middle\" rowspan=\"2\">
      <p>
        <i>Temperature_ph</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        First Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input1.png\"
        alt=
        \"First input required to calculate temperature by pressure and specific enthalpy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        Second Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ph_Input2.png\"
        alt=
        \"Second input required to calculate temperature by pressure and specific enthalpy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\" rowspan=\"2\">
      <p>
        <i>Temperature_ps</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        First Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input1.png\"
        alt=
        \"First input required to calculate temperature by pressure and specific entropy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        Second Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Temperature_ps_Input2.png\"
        alt=
        \"Second input required to calculate temperature by pressure and specific entropy\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\" rowspan=\"2\">
      <p>
        <i>Density_pT</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        First Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input1.png\"
        alt=
        \"First input required to calculate density by pressure and temperature\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        Second Input
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/Density_pT_Input2.png\"
        alt=
        \"Second input required to calculate density by pressure and temperature\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>Functional approach</i>
      </p>
    </td>
    <td valign=\"middle\" colspan=\"2\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/DataBase/Media/Refrigerants/StateProperties_Approach.png\"
        alt=
        \"Calculation procedure for supercooled and superheated region\">
      </p>
    </td>
  </tr>
</table>
<p>
  As it can be seen, the fitted formulas consist basically of the
  coefficients e<sub>i</sub>, c<sub>i</sub> as well as of the
  parameters Mean<sub>i</sub> and Std<sub>i</sub>. These coefficients
  are the fitting coefficients and must be obtained during a fitting
  procedure. While the fitting procedure, the formulas presented above
  are fitted to external data (e.g. obtained from measurements or
  external media libraries) and the fitting coefficients are
  determined. In order to keep the package clear and easy to extend,
  the fitting coefficients are stored in records inherited from the
  base data definition <a href=
  \"modelica://AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition\">
  AixLib.DataBase.Media.Refrigerants.BubbleDewStatePropertiesBaseDataDefinition</a>
  and <a href=
  \"modelica://AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition\">
  AixLib.DataBase.Media.Refrigerants.ThermodynamicStatePropertiesBaseDataDefinition</a>
  .
</p>
<p>
  For further information of <b>the hybrid approach</b>, please read
  the paper \" <a href=\"http://dx.doi.org/10.3384/ecp14096\">A Medium
  Model for the Refrigerant Propane for Fast and Accurate Dynamic
  Simulations</a>\" by Sangi et al..
</p>
<p>
  <b>Smooth transition</b>
</p>
<p>
  To ensure a smooth transition between different regions (e.g. from
  supercooled region to two-phase region) and, therefore, to avoid
  discontinuities as far as possible, Sangi et al. implemented
  functions for a smooth transition between the regions. An example
  (i.e. specificEnthalpy_ps) of these functions is given below:<br/>
</p>
<table summary=
\"Calculation procedures to avoid numerical instability at phase change\"
cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"80%\" style=
\"border-collapse:collapse;\">
  <tr>
    <td valign=\"middle\">
      <p>
        <i>From supercooled region to bubble line and vice versa</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SupercooledToTwoPhase.png\"
        alt=
        \"Calculation procedure for change from supercooled to two-phase\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>From dew line to superheated region and vice versa</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/TwoPhaseToSuperheated.png\"
        alt=
        \"Calculation procedure for change from superheated to two-phase\">
      </p>
    </td>
  </tr>
  <tr>
    <td valign=\"middle\">
      <p>
        <i>From bubble or dew line to two-phase region and vice
        versa</i>
      </p>
    </td>
    <td valign=\"middle\">
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images/Media/Refrigerants/Interfaces/SaturationToTwoPhase.png\"
        alt=
        \"Calculation procedure for change from saturation to two-phase\">
      </p>
    </td>
  </tr>
</table>
<h4>
  Assumptions and limitations
</h4>
<p>
  Two limitations are known for this package:
</p>
<ol>
  <li>The modelling approach implemented in this package is a hybrid
  approach and, therefore, is based on the Helmholtz equation of state
  as well as on fitted formula. Hence, the refrigerant model is just
  valid within the valid range of the fitted formula.
  </li>
  <li>It may be possible to have discontinuities when moving from one
  region to another (e.g. from supercooled region to two-phase region).
  However, functions are implemented to reach a smooth transition
  between the regions and to avoid these discontinuities as far as
  possible. (Sangi et al., 2014)
  </li>
</ol>
<h4>
  Typical use and important parameters
</h4>
<p>
  The refrigerant models provided in this package are typically used
  for heat pumps and refrigerating machines. However, it is just a
  partial package and, hence, it must be completed before usage. In
  order to allow an easy completion of the package, a template is
  provided in <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>.
</p>
<h4>
  References
</h4>
<p>
  Thorade, Matthis; Saadat, Ali (2012): <a href=
  \"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">HelmholtzMedia - A
  fluid properties library</a>. In: <i>Proceedings of the 9th
  International Modelica Conference</i>; September 3-5; 2012; Munich;
  Germany. Linköping University Electronic Press, S. 63–70.
</p>
<p>
  Thorade, Matthis; Saadat, Ali (2013): <a href=
  \"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
  Partial derivatives of thermodynamic state properties for dynamic
  simulation</a>. In: <i>Environmental earth sciences 70 (8)</i>, S.
  3497–3503.
</p>
<p>
  Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita;
  Müller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">A
  Medium Model for the Refrigerant Propane for Fast and Accurate
  Dynamic Simulations</a>. In: <i>The 10th International Modelica
  Conference</i>. Lund, Sweden, March 10-12, 2014: Linköping University
  Electronic Press (Linköping Electronic Conference Proceedings), S.
  1271–1275
</p>
<p>
  Klasing,Freerk: A New Design for Direct Exchange Geothermal Heat
  Pumps - Modeling, Simulation and Exergy Analysis. <i>Master
  thesis</i>
</p>
</html>"));
end PartialHybridTwoPhaseMediumRecord;
