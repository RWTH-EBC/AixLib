within AixLib.Media.Refrigerants.R744;
package R744_IIR_P1_1000_T233_373_Formula "Refrigerant model for R744 using a hybrid approach with explicit formulas"

  /*Provide basic definitions of the refrigerant. Therefore, fill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
    */
  constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1]
    refrigerantConstants(
    each chemicalFormula="CO2",
    each structureFormula="CO2",
    each casRegistryNumber="124-38-9",
    each iupacName="Carbon dioxide",
    each molarMass=0.0440098,
    each criticalTemperature=304.1282,
    each criticalPressure=7377300,
    each criticalMolarVolume=0.0021*0.044,
    each triplePointTemperature=216.55,
    each triplePointPressure=518000,
    each normalBoilingPoint=195.15,
    each meltingPoint=216.6,
    each acentricFactor=0.22394,
    each dipoleMoment=0,
    each hasCriticalData=true) "Thermodynamic constants for R744";
  //(sublimes)

  /*Provide basic information about the refrigerant. These basic information
    are the refrigerant name as well as the valid refrigerant limits in terms
    of specific enthalpy, density, absolute pressure and temperature.
  */
  extends
    AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula(
    mediumName="R744",
    substanceNames={"R744"},
    singleState=false,
    SpecificEnthalpy(
      start=2.0e5,
      nominal=2.0e5,
      min=110000,
      max=503750),
    Density(
      start=500,
      nominal=350,
      min=14.53,
      max=1139),
    AbsolutePressure(
      start=10e5,
      nominal=50e5,
      min=10e5,
      max=100e5),
    Temperature(
      start=268.37,
      nominal=333.15,
      min=243.15,
      max=373.15),
    smoothModel=true,
    onePhase=false,
    ThermoStates=Choices.IndependentVariables.phX,
    fluidConstants=refrigerantConstants);
  /*The vector substanceNames is mandatory, as the number of
      substances is determined based on its size. Here we assume
      a single-component medium.
      singleState is true if u and d do not depend on pressure, but only
      on a thermal variable (temperature or enthalpy). Otherwise, set it
      to false.
      For a single-substance medium, just set reducedX and fixedX to true,
      and there's no need to bother about medium compositions at all. Otherwise,
      set final reducedX = true if the medium model has nS-1 independent mass
      fraction, or reducedX = false if the medium model has nS independent
      mass fractions (nS = number of substances).
      If a mixture has a fixed composition set fixedX=true, otherwise false.
      The modifiers for reducedX and fixedX should normally be final
      since the other equations are based on these values.

      It is also possible to redeclare the min, max, and start attributes of
      Medium types, defined in the base class Interfaces.PartialMedium
      (the example of Temperature is shown here). Min and max attributes
      should be set in accordance to the limits of validity of the medium
      model, while the start attribute should be a reasonable default value
      for the initialization of nonlinear solver iterations.
    */
  /*Provide records thats contain the coefficients for the smooth transition
    between different regions.
  */
  redeclare record SmoothTransition "Record that contains ranges to calculate a smooth transition between
    different regions"
    SpecificEnthalpy T_ph=2.5;
    SpecificEntropy T_ps=2.5;
    AbsolutePressure d_pT=2.5;
    SpecificEnthalpy d_ph=2.5;
    Real d_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
    Real h_ps(unit="J/(Pa.K.kg)") = 25/(39.5e5 - 1e5);
  end SmoothTransition;
  /*Provide Helmholtz equations of state (EoS) using an explicit formula.
  */
  final constant Real idealAlpha0[8]={8.37304456,-3.70454304,2.5,1.99427042,0.62105248,
      0.41195293,1.04028922,0.08327678};
  final constant Real idealPhi0[8]={0,0,0,3.15163,6.11190,6.77708,11.32384,27.08792};

  redeclare function extends f_Idg
    "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"

  algorithm
    f_Idg :=
      log(delta) + idealAlpha0[1] - idealAlpha0[2]*tau + idealAlpha0[3]*
      log(tau) +
      sum(idealAlpha0[i]*log(1 - exp(-tau*idealPhi0[i])) for i in 4:8);
  end f_Idg;
//Constants for Dimensionsless Helmholtz energy (Residual part alpha_r)
  final constant Real residualPolN[7] = {
    0.38856823203161,
    0.29385475942740E+01,
   -0.55867188534934E+01,
   -0.76753199592477E+00,
    0.31729005580416E+00,
    0.54803315897737E+00,
    0.12279411220335E+00};
   final constant Real residualExpN[27]= {
    0.21658961543220E+01,
    0.15841735109724E+01,
   -0.23132705405503E+00,
    0.58116916431436E-01,
   -0.55369137205382E+00,
    0.48946615909422E+00,
   -0.24275739843501E-01,
    0.62494790501678E-01,
   -0.12175860225246E+00,
   -0.37055685270086E+00,
   -0.16775879700426E-01,
   -0.11960736637987E+00,
   -0.45619362508778E-01,
    0.35612789270346E-01,
   -0.74427727132052E-02,
   -0.17395704902432E-02,
   -0.21810121289527E-01,
    0.24332166559236E-01,
   -0.37440133423463E-01,
    0.14338715756878E+00,
   -0.13491969083286E+00,
   -0.23151225053480E-01,
    0.12363125492901E-01,
    0.21058321972940E-02,
   -0.33958519026368E-03,
    0.55993651771592E-02,
   -0.30335118055646E-03};
   final constant Real residualGbsN[5] = {
   -0.21365488688320E+03,
    0.26641569149272E+05,
   -0.24027212204557E+05,
   -0.28341603423999E+03,
    0.21247284400179E+03};
    final constant Real residualNaN[3] = {
   -0.66642276540751E+00,
    0.72608632349897E+00,
    0.550686686128E-01};

 final constant Integer residualPolD[7] = {
    1,1,1,1,2,2,3};
 final constant Integer residualExpD[27] = {
    1,2,4,5,5,5,6,6,6,1,1,4,4,
    4,7,8,2,3,3,5,5,6,7,
    8,10,4,8};
  final constant Integer residualGbsD[5] = {
    2,2,2,3,3};

 final constant Real residualNaa[3] = {
   3.5,3.5,3};

 final constant Real residualPolT[7] = {
   0,0.75,1,2,0.75,2,0.75};
 final constant Real residualExpT[27] = {
   1.5,1.5,2.5,0,1.5,2,0,1,2,3,
   6,3,6,8,6,0,7,12,16,22,
   24,16,24,8,2,28,14};
 final constant Integer residualGbsT[5] = {
   1,0,1,3,3};

 final constant Real residualNab[3] = {
   0.875,0.925,0.875};

 final constant Integer residualExpC[27] = {
   1,1,1,1,1,1,1,1,1,2,
   2,2,2,2,2,2,3,3,3,4,
   4,4,4,4,4,5,6};

 final constant Integer residualGbsAlpha[5] = {
   25,25,25,15,20};

 final constant Integer residualGbsBeta[5] = {
   325,300,300,275,275};
 final constant Real residualNaBeta[3] = {
   0.3,0.3,0.3};

 final constant Real residualGbsGamma[5] = {
   1.16,1.19,1.19,1.25,1.22};

 final constant Integer residualGbsEpsilon[5] = {
   1,1,1,1,1};

 final constant Real residualNaA[3] = {
   0.7,0.7,0.7};

 final constant Real residualNaB[3] = {
   0.3,0.3,1};

 final constant Real residualNaC[3] =  {
   10,10,12.5};

 final constant Integer residualNaD[3] = {
   275,275,275};

  redeclare function extends f_Res
    "Dimensionless Helmholtz energy (Residual part alpha_r)"
protected
    Real[3] Theta = {  (1-tau) + residualNaA[i] * ((delta-1)^2)^(0.5 / residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis = { Theta[i]^2 + residualNaB[i] * ((delta-1)^2)^(residualNaa[i]) for i in 1:3} "Theta";
    Real[3] Psi = { exp(-residualNaC[i] * (delta-1)^2 - residualNaD[i] * (tau-1)^2) for i in 1:3}  "Psi";

  algorithm

  f_Res :=
  sum(residualPolN[i] * delta^(residualPolD[i]) * tau^(residualPolT[i]) for i in 1:7) +
  sum(residualExpN[i] * delta^(residualExpD[i]) * tau^(residualExpT[i]) * exp(-delta^(residualExpC[i])) for i in 1:27) +
  sum(residualGbsN[i] * delta^(residualGbsD[i]) * tau^(residualGbsT[i]) * exp(-residualGbsAlpha[i] * (delta - residualGbsEpsilon[i])^2 - residualGbsBeta[i] * (tau - residualGbsGamma[i])^2) for i in 1:5)+
  sum(residualNaN[i] * Dis[i]^(residualNab[i]) * delta * Psi[i] for i in 1:3);
  end f_Res;

 redeclare function extends t_fIdg_t
    "Short form for tau*(dalpha_0/dtau)_delta=const"
 algorithm
  t_fIdg_t :=
  tau * idealAlpha0[2] + idealAlpha0[3] +
  tau * sum(idealAlpha0[i] * idealPhi0[i] *((1-exp(-tau*idealPhi0[i]))^(-1) -1) for i in 4:8);
 end t_fIdg_t;

 redeclare function extends tt_fIdg_tt
    "Short form for tau*tau*(ddalpha_0/(dtau*dtau))_delta=const"
 algorithm
   tt_fIdg_tt :=
  -idealAlpha0[3] -
  tau^2 * sum(idealAlpha0[i] * idealPhi0[i]^2 * exp(-tau*idealPhi0[i]) * (1-exp(-tau*idealPhi0[i]))^(-2) for i in 4:8);
 end tt_fIdg_tt;

redeclare function extends t_fRes_t
    "Short form for tau*(dalpha_r/dtau)_delta=const"
protected
    Real[3] Theta = {  (1-tau) + residualNaA[i] * ((delta-1)^2)^(0.5 / residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis = { Theta[i]^2 + residualNaB[i] * ((delta-1)^2)^(residualNaa[i]) for i in 1:3} "Theta";
    Real[3] Psi = { exp(-residualNaC[i] * (delta-1)^2 - residualNaD[i] * (tau-1)^2) for i in 1:3}  "Psi";
algorithm
    t_fRes_t :=
    sum(residualPolN[i] * residualPolT[i] * delta^(residualPolD[i]) * tau^(residualPolT[i]) for i in 1:7) +
    sum(residualExpN[i] * residualExpT[i] * delta^(residualExpD[i]) * tau^(residualExpT[i]) * exp(-delta^(residualExpC[i])) for i in 1:27) +
    sum(residualGbsN[i] * residualGbsT[i] * delta^(residualGbsD[i]) * tau^(residualGbsT[i]) * exp(-residualGbsAlpha[i]*(delta-residualGbsEpsilon[i])^2 - residualGbsBeta[i] * (tau - residualGbsGamma[i])^2) * (residualGbsT[i] - 2*tau*residualGbsBeta[i]*(tau-residualGbsGamma[i])) for i in 1:5) +
    sum(residualNaN[i] * delta * tau * (( -2*Theta[i]*residualNab[i]*Dis[i]^(residualNab[i]-1)) * Psi[i] + Dis[i]^(residualNab[i]) * (-2) * residualNaD[i]*(tau-1)*Psi[i]) for i in 1:3);

end t_fRes_t;

redeclare function extends tt_fRes_tt
    "Short form for tau*tau*(ddalpha_r/(dtau*dtau))_delta=const"
protected
    Real[3] Theta = {  (1-tau) + residualNaA[i] * ((delta-1)^2)^(0.5 / residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis = { Theta[i]^2 + residualNaB[i] * ((delta-1)^2)^(residualNaa[i]) for i in 1:3} "Theta";
    Real[3] Psi = { exp(-residualNaC[i] * (delta-1)^2 - residualNaD[i] * (tau-1)^2) for i in 1:3}  "Psi";
    Real[3] Dis_tt_b = { 2*residualNab[i] * Dis[i]^(residualNab[i]-1) + 4*Theta[i]^2*residualNab[i]*(residualNab[i]-1)*Dis[i]^(residualNab[i]-2) for i in 1:3} "(ddDis^b/dtdt)";
    Real[3] Dis_t_b = { -2*Theta[i]*residualNab[i]*Dis[i]^(residualNab[i]-1) for i in 1:3} "(dDis^b/dt)";
    Real[3] Psi_t = { -2*residualNaD[i]*(tau-1)*Psi[i] for i in 1:3} "(dPsi/dt)";
    Real[3] Psi_tt = { ( 2*residualNaD[i]*(tau-1)^2-1) * 2*residualNaD[i] * Psi[i] for i in 1:3} "(ddPsi/dtdt)";

algorithm
  tt_fRes_tt :=
  sum(residualPolN[i] * residualPolT[i] * (residualPolT[i]-1) * delta^(residualPolD[i]) * tau^(residualPolT[i]) for i in 1:7) +
  sum(residualExpN[i] * residualExpT[i] * (residualExpT[i]-1) * delta^(residualExpD[i]) * tau^(residualExpT[i]) * exp(-delta^(residualExpC[i])) for i in 1:27) +
  sum(residualGbsN[i] * delta^(residualGbsD[i]) * tau^(residualGbsT[i]+2) * exp(-residualGbsAlpha[i]*(delta-residualGbsEpsilon[i])^2 - residualGbsBeta[i] * (tau-residualGbsGamma[i])^2) * ((residualGbsT[i] / tau - 2* residualGbsBeta[i] * (tau - residualGbsGamma[i]))^2 - residualGbsT[i]/tau^2 - 2*residualGbsBeta[i]) for i in 1:5) +
  sum(tau^2*residualNaN[i]*delta*( Dis_tt_b[i] * Psi[i] + 2*Dis_t_b[i] * Psi_t[i] + Dis[i]^residualNab[i] * Psi_tt[i]) for i in 1:3);
end tt_fRes_tt;

redeclare function extends d_fRes_d
    "Short form for delta*(dalpha_r/(ddelta))_tau=const"
protected
    Real[3] Theta = {  (1-tau) + residualNaA[i] * ((delta-1)^2)^(0.5 / residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis = { Theta[i]^2 + residualNaB[i] * ((delta-1)^2)^(residualNaa[i]) for i in 1:3} "Theta";
    Real[3] Psi = { exp(-residualNaC[i] * (delta-1)^2 - residualNaD[i] * (tau-1)^2) for i in 1:3}  "Psi";
    Real[3] Psi_d= { -2*residualNaC[i] * (delta-1)*Psi[i] for i in 1:3} "(dPsi/dd)";
    Real[3] Dis_d= { (delta-1) * ( residualNaA[i] * Psi[i] * 0.5 * residualNaBeta[i] * ((delta-1)^2)^((0.5/residualNaBeta[i])-1) + 2*residualNaB[i]*residualNaa[i]*((delta-1)^2)^(residualNaa[i]-1)) for i in 1:3} "(dDis/dd)";
    Real[3] Dis_d_b = { residualNab[i] * Dis[i]^(residualNab[i]-1) * Dis_d[i] for i in 1:3} "(dDis^b/dd)";
algorithm
  d_fRes_d :=
  sum(residualPolN[i] * residualPolD[i] * delta^(residualPolD[i]) * tau^(residualPolT[i]) for i in 1:7) +
  sum(residualExpN[i] * exp(-delta ^ (residualExpC[i])) * (delta^(residualExpD[i]) * tau^(residualExpT[i]) * (residualExpD[i]-residualExpC[i]*delta^(residualExpC[i]))) for i in 1:27) +
  sum(residualGbsN[i] * delta^(residualGbsD[i]+1) * tau^(residualGbsT[i]) * exp(-residualGbsAlpha[i] * (delta-residualGbsEpsilon[i])^2 - residualGbsBeta[i]*(tau-residualGbsGamma[i])^2) * ((residualGbsD[i] / delta) - 2*residualGbsAlpha[i] * (delta-residualGbsEpsilon[i])) for i in 1:5) +
  sum(residualNaN[i] * delta * ( Dis[i]^(residualNab[i]) * ( Psi[i]+delta*Psi_d[i])  + Dis_d_b[i] * delta * Psi_d[i]) for i in 1:3);
end d_fRes_d;

redeclare function extends dd_fRes_dd
    "Short form for delta*delta(ddalpha_r/(ddelta*delta))_tau=const"
protected
    Real[3] Theta = {  (1-tau) + residualNaA[i] * ((delta-1)^2)^(0.5 / residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis = { Theta[i]^2 + residualNaB[i] * ((delta-1)^2)^(residualNaa[i]) for i in 1:3} "Theta";
    Real[3] Psi = { exp(-residualNaC[i] * (delta-1)^2 - residualNaD[i] * (tau-1)^2) for i in 1:3}  "Psi";
    Real[3] Psi_d= { -2*residualNaC[i] * (delta-1)*Psi[i] for i in 1:3} "(dPsi/dd)";
    Real[3] Dis_d= { (delta-1) * ( residualNaA[i] * Psi[i] * 0.5 * residualNaBeta[i] * ((delta-1)^2)^((0.5/residualNaBeta[i])-1) + 2*residualNaB[i]*residualNaa[i]*((delta-1)^2)^(residualNaa[i]-1)) for i in 1:3} "(dDis/dd)";
    Real[3] Dis_d_b = { residualNab[i] * Dis[i]^(residualNab[i]-1) * Dis_d[i] for i in 1:3} "(dDis^b/dd)";
    Real[3] Psi_dd = { (2*residualNaC[i]*(delta-1)^2-1)*2*residualNaC[i]*Psi[i] for i in 1:3} "(ddPsi/dddd)";
    Real[3] Dis_dd = { (1/(delta-1)) * Dis_d[i] + (delta-1)^2 *( 4*residualNaB[i]*residualNaa[i]*(residualNaa[i]-1) * ( (delta-1)^2) ^(residualNaa[i]-2) + 2*residualNaA[i]^2 *(1/residualNaBeta[i])^2 * (( (delta-1)^2)^(1/(2*residualNaBeta[i]) -1))^2 + residualNaA[i]*Theta[i]* 4/residualNaBeta[i] * (1/(2*residualNaBeta[i])-1) * ((delta-1)^2)^(1/(2*residualNaBeta[i]) -2)) for i in 1:3} "(ddDis/dddd)";
    Real[3] Dis_dd_b = { residualNab[i]*( Dis[i]^(residualNab[i]-1) * Dis_dd[i] + (residualNab[i]-1)*Dis[i]^(residualNab[i]-2) * Dis_d[i]^2) for i in 1:3} "(ddDis^b/dddd)";

algorithm
  dd_fRes_dd :=
  sum(residualPolN[i] * residualPolD[i] * (residualPolD[i]-1) * delta^(residualPolD[i]) * tau^(residualPolT[i]) for i in 1:7) +
  sum(residualExpN[i] * exp( -delta^(residualExpC[i])) * ( delta^(residualExpD[i]) * tau^(residualExpT[i]) * (( residualExpD[i] - residualExpC[i]*delta^(residualExpC[i])) * (residualExpD[i]-1-residualExpC[i]*delta^(residualExpC[i])) - residualExpC[i]^2*delta^(residualExpC[i]))) for i in 1:27) +
  sum(delta^2 * residualGbsN[i] * tau^(residualGbsT[i]) * exp( -residualGbsAlpha[i] * (delta-residualGbsEpsilon[i])^2 - residualGbsBeta[i]*(tau-residualGbsGamma[i])^2)  * ( -2*residualGbsAlpha[i]*delta^(residualGbsD[i]) + 4*residualGbsAlpha[i]^2*delta^(residualGbsD[i])*(delta-residualGbsEpsilon[i])^2 - 4*residualGbsD[i]*residualGbsAlpha[i]*delta^(residualGbsD[i]-1) * (delta-residualGbsEpsilon[i]) + residualGbsD[i]*(residualGbsD[i]-1)*delta^(residualGbsD[i]-2)) for i in 1:5) +
  sum(delta^2 * residualNaN[i] * (Dis[i]^(residualNab[i]) * (2*Psi_d[i] + delta*Psi_dd[i]) + 2*Dis_d_b[i] *( Psi[i] + delta*Psi_d[i]) + Dis_dd_b[i] * delta * Psi[i]) for i in 1:3);
end dd_fRes_dd;

redeclare function extends td_fRes_td
    "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
protected
    Real[3] Theta = {  (1-tau) + residualNaA[i] * ((delta-1)^2)^(0.5 / residualNaBeta[i]) for i in 1:3} "Theta";
    Real[3] Dis = { Theta[i]^2 + residualNaB[i] * ((delta-1)^2)^(residualNaa[i]) for i in 1:3} "Theta";
    Real[3] Psi = { exp(-residualNaC[i] * (delta-1)^2 - residualNaD[i] * (tau-1)^2) for i in 1:3}  "Psi";
    Real[3] Psi_d= { -2*residualNaC[i] * (delta-1)*Psi[i] for i in 1:3} "(dPsi/dd)";
    Real[3] Dis_d= { (delta-1) * ( residualNaA[i] * Psi[i] * 0.5 * residualNaBeta[i] * ((delta-1)^2)^((0.5/residualNaBeta[i])-1) + 2*residualNaB[i]*residualNaa[i]*((delta-1)^2)^(residualNaa[i]-1)) for i in 1:3} "(dDis/dd)";
    Real[3] Dis_d_b = { residualNab[i] * Dis[i]^(residualNab[i]-1) * Dis_d[i] for i in 1:3} "(dDis^b/dd)";
    Real[3] Dis_t_b = { -2*Theta[i]*residualNab[i]*Dis[i]^(residualNab[i]-1) for i in 1:3} "(dDis^b/dt)";
    Real[3] Psi_t = { -2*residualNaD[i]*(tau-1)*Psi[i] for i in 1:3} "(dPsi/dt)";
    Real[3] Psi_dt = { 4*residualNaC[i]*residualNaD[i]*(delta-1)*(tau-1)*Psi[i] for i in 1:3} "(ddPsi/dtdd)";
    Real[3] Dis_dt_b = { 2*residualNab[i]*(2/residualNaBeta[i])*Dis[i]^(residualNab[i]-1)*(delta-1)* ((delta-1)^2)^(0.5/(residualNaBeta[i])-1) - 2*Theta[i]*residualNab[i]*(residualNab[i]-1)*Dis[i]^(residualNab[i]-2)*Dis_d[i] for i in 1:3} "(ddDis^b/dddt)";

algorithm
  td_fRes_td :=
  sum(residualPolN[i]*residualPolD[i]*residualPolT[i]*delta^(residualPolD[i]) * tau^(residualPolT[i]) for i in 1:7) +
  sum(residualExpN[i] * exp(-delta^(residualExpC[i])) * delta^(residualExpD[i]) * residualExpT[i]*tau^(residualExpT[i]) * (residualExpD[i]-residualExpC[i]*delta^(residualExpC[i])) for i in 1:27) +
  sum(delta*tau*residualGbsN[i] * delta^(residualGbsD[i]) * tau^(residualGbsT[i]) * exp(-residualGbsAlpha[i]*(delta-residualGbsEpsilon[i])^2 - residualGbsBeta[i]*(tau-residualGbsGamma[i])^2) * ( (residualGbsD[i]/delta) - 2*residualGbsAlpha[i]*(delta-residualGbsEpsilon[i])) * ( (residualGbsT[i]/tau) - 2*residualGbsBeta[i]*(tau-residualGbsGamma[i])) for i in 1:5) +
  sum(tau*delta*residualNaN[i]*( Dis[i]^(residualNab[i]) * (Psi_t[i] + delta*Psi_dt[i]) + delta * Dis_d_b[i]*Psi_t[i] + Dis_t_b[i] *( Psi[i] + delta*Psi_d[i]) + Dis_dt_b[i]*delta*Psi[i]) for i in 1:3);
end td_fRes_td;
end R744_IIR_P1_1000_T233_373_Formula;
