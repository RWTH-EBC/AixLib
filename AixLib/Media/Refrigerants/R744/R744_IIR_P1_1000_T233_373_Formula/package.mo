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

redeclare function extends ttt_fIdg_ttt
    "Short form for tau*tau*tau*(dddalpha_0/(dtau*dtau*dtau))_delta=const"
algorithm
    ttt_fIdg_ttt :=
    2*idealAlpha0[3] +
    sum(tau^3 * idealAlpha0[i] * idealPhi0[i]^3*exp(-idealPhi0[i]*tau)*(exp(idealPhi0[i]*tau)+1)/((exp(-idealPhi0[i]*tau)-1)^3) for i in 4:8);
end ttt_fIdg_ttt;

redeclare function extends ttt_fRes_ttt
    "Short form for tau*tau*tau*(dddalpha_r/(dtau*dtau*dtau))_delta=const"
protected
  final constant Real [7,3] p=[
       0.388568232032E+00,  0.000,   1.00;
       0.293854759427E+01,  0.750,   1.00;
      -0.558671885349E+01,  1.000,   1.00;
      -0.767531995925E+00,  2.000,   1.00;
       0.317290055804E+00,  0.750,   2.00;
       0.548033158978E+00,  2.000,   2.00;
       0.122794112203E+00,  0.750,   3.00];

  final constant Real[27,4] b= [
       0.216589615432E+01,  1.500,   1.00,    1;
       0.158417351097E+01,  1.500,   2.00,    1;
      -0.231327054055E+00,  2.500,   4.00,    1;
       0.581169164314E-01,  0.000,   5.00,    1;
      -0.553691372054E+00,  1.500,   5.00,    1;
       0.489466159094E+00,  2.000,   5.00,    1;
      -0.242757398435E-01,  0.000,   6.00,    1;
       0.624947905017E-01,  1.000,   6.00,    1;
      -0.121758602252E+00,  2.000,   6.00,    1;
      -0.370556852701E+00,  3.000,   1.00,    2;
      -0.167758797004E-01,  6.000,   1.00,    2;
      -0.119607366380E+00,  3.000,   4.00,    2;
      -0.456193625088E-01,  6.000,   4.00,    2;
       0.356127892703E-01,  8.000,   4.00,    2;
      -0.744277271321E-02,  6.000,   7.00,    2;
      -0.173957049024E-02,  0.000,   8.00,    2;
      -0.218101212895E-01,  7.000,   2.00,    3;
       0.243321665592E-01, 12.000,   3.00,    3;
      -0.374401334235E-01, 16.000,   3.00,    3;
       0.143387157569E+00, 22.000,   5.00,    4;
      -0.134919690833E+00, 24.000,   5.00,    4;
      -0.231512250535E-01, 16.000,   6.00,    4;
       0.123631254929E-01, 24.000,   7.00,    4;
       0.210583219729E-02,  8.000,   8.00,    4;
      -0.339585190264E-03,  2.000,  10.00,    4;
       0.559936517716E-02, 28.000,   4.00,    5;
      -0.303351180556E-03, 14.000,   8.00,    6];

  final constant Real[5,9] g = [
      -0.213654886883E+03,  1.000,   2.00,    2, 2,  -25.,  -325.,  1.16, 1.;
       0.266415691493E+05,  0.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
      -0.240272122046E+05,  1.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
      -0.283416034240E+03,  3.000,   3.00,    2, 2,  -15.,  -275.,  1.25, 1.;
       0.212472844002E+03,  3.000,   3.00,    2, 2,  -20.,  -275.,  1.22, 1.];

algorithm
  ttt_fRes_ttt :=
      sum(delta^p[i,3]*p[i,1]*p[i,2]*tau^(p[i,2])*(p[i,2] - 1)*(p[i,2] - 2) for i in 1:7)
    + sum(b[i,1]*b[i,2]*delta^b[i,3]*tau^(b[i,2])*exp(-delta^b[i,4])*(b[i,2] - 1)*(b[i,2] - 2) for i in 1:27)
    + sum(tau^3*(delta^g[i,3]*g[i,1]*tau^(g[i,2] - 3)*exp(g[i,6]*(delta - g[i,9])^2 + g[i,7]*(g[i,8] - tau)^2)*(g[i,2]^3 - 6*g[i,2]^2*g[i,7]*g[i,8]*tau + 6*g[i,2]^2*g[i,7]*tau^2 - 3*g[i,2]^2 + 12*g[i,2]*g[i,7]^2*g[i,8]^2*tau^2 - 24*g[i,2]*g[i,7]^2*g[i,8]*tau^3 + 12*g[i,2]*g[i,7]^2*tau^4 + 6*g[i,2]*g[i,7]*g[i,8]*tau + 2*g[i,2] - 8*g[i,7]^3*g[i,8]^3*tau^3 + 24*g[i,7]^3*g[i,8]^2*tau^4 - 24*g[i,7]^3*g[i,8]*tau^5 + 8*g[i,7]^3*tau^6 - 12*g[i,7]^2*g[i,8]*tau^3 + 12*g[i,7]^2*tau^4)) for i in 1:5);

end ttt_fRes_ttt;

redeclare function extends ddd_fRes_ddd
    "Short form for delta*delta*delta*
    (dddalpha_r/(ddelta*ddelta*ddelta))_tau=const"
protected
final constant Real [7,3] p=[
       0.388568232032E+00,  0.000,   1.00;
       0.293854759427E+01,  0.750,   1.00;
      -0.558671885349E+01,  1.000,   1.00;
      -0.767531995925E+00,  2.000,   1.00;
       0.317290055804E+00,  0.750,   2.00;
       0.548033158978E+00,  2.000,   2.00;
       0.122794112203E+00,  0.750,   3.00];

  final constant Real[27,4] b= [
       0.216589615432E+01,  1.500,   1.00,    1;
       0.158417351097E+01,  1.500,   2.00,    1;
      -0.231327054055E+00,  2.500,   4.00,    1;
       0.581169164314E-01,  0.000,   5.00,    1;
      -0.553691372054E+00,  1.500,   5.00,    1;
       0.489466159094E+00,  2.000,   5.00,    1;
      -0.242757398435E-01,  0.000,   6.00,    1;
       0.624947905017E-01,  1.000,   6.00,    1;
      -0.121758602252E+00,  2.000,   6.00,    1;
      -0.370556852701E+00,  3.000,   1.00,    2;
      -0.167758797004E-01,  6.000,   1.00,    2;
      -0.119607366380E+00,  3.000,   4.00,    2;
      -0.456193625088E-01,  6.000,   4.00,    2;
       0.356127892703E-01,  8.000,   4.00,    2;
      -0.744277271321E-02,  6.000,   7.00,    2;
      -0.173957049024E-02,  0.000,   8.00,    2;
      -0.218101212895E-01,  7.000,   2.00,    3;
       0.243321665592E-01, 12.000,   3.00,    3;
      -0.374401334235E-01, 16.000,   3.00,    3;
       0.143387157569E+00, 22.000,   5.00,    4;
      -0.134919690833E+00, 24.000,   5.00,    4;
      -0.231512250535E-01, 16.000,   6.00,    4;
       0.123631254929E-01, 24.000,   7.00,    4;
       0.210583219729E-02,  8.000,   8.00,    4;
      -0.339585190264E-03,  2.000,  10.00,    4;
       0.559936517716E-02, 28.000,   4.00,    5;
      -0.303351180556E-03, 14.000,   8.00,    6];

  final constant Real[5,9] g = [
      -0.213654886883E+03,  1.000,   2.00,    2, 2,  -25.,  -325.,  1.16, 1.;
       0.266415691493E+05,  0.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
      -0.240272122046E+05,  1.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
      -0.283416034240E+03,  3.000,   3.00,    2, 2,  -15.,  -275.,  1.25, 1.;
       0.212472844002E+03,  3.000,   3.00,    2, 2,  -20.,  -275.,  1.22, 1.];

algorithm
    ddd_fRes_ddd :=
      sum(delta^(p[i,3])*p[i,1]*p[i,3]*tau^p[i,2]*(p[i,3] - 1)*(p[i,3] - 2) for i in 1:7)
    + sum(-b[i,1]*delta^(b[i,3])*tau^b[i,2]*exp(-delta^b[i,4])*(b[i,4]^3*delta^b[i,4] - 3*b[i,4]^2*delta^b[i,4] - 2*b[i,3] + 3*b[i,4]^2*delta^(2*b[i,4]) - 3*b[i,4]^3*delta^(2*b[i,4]) + b[i,4]^3*delta^(3*b[i,4]) + 3*b[i,3]^2 - b[i,3]^3 + 2*b[i,4]*delta^b[i,4] - 3*b[i,3]*b[i,4]^2*delta^(2*b[i,4]) - 6*b[i,3]*b[i,4]*delta^b[i,4] + 3*b[i,3]*b[i,4]^2*delta^b[i,4] + 3*b[i,3]^2*b[i,4]*delta^b[i,4]) for i in 1:27)
    + sum(delta^(g[i,3])*g[i,1]*tau^g[i,2]*exp(g[i,6]*(delta - g[i,9])^2 + g[i,7]*(g[i,8] - tau)^2)*(8*delta^6*g[i,6]^3 - 24*delta^5*g[i,6]^3*g[i,9] + 12*delta^4*g[i,3]*g[i,6]^2 + 24*delta^4*g[i,6]^3*g[i,9]^2 + 12*delta^4*g[i,6]^2 - 24*delta^3*g[i,3]*g[i,6]^2*g[i,9] - 8*delta^3*g[i,6]^3*g[i,9]^3 - 12*delta^3*g[i,6]^2*g[i,9] + 6*delta^2*g[i,3]^2*g[i,6] + 12*delta^2*g[i,3]*g[i,6]^2*g[i,9]^2 - 6*delta*g[i,3]^2*g[i,6]*g[i,9] + 6*delta*g[i,3]*g[i,6]*g[i,9] + g[i,3]^3 - 3*g[i,3]^2 + 2*g[i,3]) for i in 1:5);
end ddd_fRes_ddd;

redeclare function extends tdd_fRes_tdd
    "Short form for tau*delta*delta*(dddalpha_r/(dtau*ddelta*ddelta))"
protected
  final constant Real [7,3] p=[
       0.388568232032E+00,  0.000,   1.00;
       0.293854759427E+01,  0.750,   1.00;
      -0.558671885349E+01,  1.000,   1.00;
      -0.767531995925E+00,  2.000,   1.00;
       0.317290055804E+00,  0.750,   2.00;
       0.548033158978E+00,  2.000,   2.00;
       0.122794112203E+00,  0.750,   3.00];

  final constant Real[27,4] b= [
       0.216589615432E+01,  1.500,   1.00,    1;
       0.158417351097E+01,  1.500,   2.00,    1;
      -0.231327054055E+00,  2.500,   4.00,    1;
       0.581169164314E-01,  0.000,   5.00,    1;
      -0.553691372054E+00,  1.500,   5.00,    1;
       0.489466159094E+00,  2.000,   5.00,    1;
      -0.242757398435E-01,  0.000,   6.00,    1;
       0.624947905017E-01,  1.000,   6.00,    1;
      -0.121758602252E+00,  2.000,   6.00,    1;
      -0.370556852701E+00,  3.000,   1.00,    2;
      -0.167758797004E-01,  6.000,   1.00,    2;
      -0.119607366380E+00,  3.000,   4.00,    2;
      -0.456193625088E-01,  6.000,   4.00,    2;
       0.356127892703E-01,  8.000,   4.00,    2;
      -0.744277271321E-02,  6.000,   7.00,    2;
      -0.173957049024E-02,  0.000,   8.00,    2;
      -0.218101212895E-01,  7.000,   2.00,    3;
       0.243321665592E-01, 12.000,   3.00,    3;
      -0.374401334235E-01, 16.000,   3.00,    3;
       0.143387157569E+00, 22.000,   5.00,    4;
      -0.134919690833E+00, 24.000,   5.00,    4;
      -0.231512250535E-01, 16.000,   6.00,    4;
       0.123631254929E-01, 24.000,   7.00,    4;
       0.210583219729E-02,  8.000,   8.00,    4;
      -0.339585190264E-03,  2.000,  10.00,    4;
       0.559936517716E-02, 28.000,   4.00,    5;
      -0.303351180556E-03, 14.000,   8.00,    6];

  final constant Real[5,9] g = [
      -0.213654886883E+03,  1.000,   2.00,    2, 2,  -25.,  -325.,  1.16, 1.;
       0.266415691493E+05,  0.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
      -0.240272122046E+05,  1.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
      -0.283416034240E+03,  3.000,   3.00,    2, 2,  -15.,  -275.,  1.25, 1.;
       0.212472844002E+03,  3.000,   3.00,    2, 2,  -20.,  -275.,  1.22, 1.];
algorithm
  tdd_fRes_tdd :=
      sum(delta^(p[i,3])*p[i,1]*p[i,2]*p[i,3]*tau^(p[i,2])*(p[i,3] - 1) for i in 1:7)
    + sum(-b[i,1]*b[i,2]*delta^(b[i,3])*tau^(b[i,2])*exp(-delta^b[i,4])*(b[i,3] + b[i,4]^2*delta^b[i,4] - b[i,4]^2*delta^(2*b[i,4]) - b[i,3]^2 - b[i,4]*delta^b[i,4] + 2*b[i,3]*b[i,4]*delta^b[i,4]) for i in 1:27)
    + sum(delta^(g[i,3])*g[i,1]*tau^(g[i,2])*exp(g[i,6]*(delta - g[i,9])^2 + g[i,7]*(g[i,8] - tau)^2)*(2*g[i,7]*tau^2 - 2*g[i,7]*g[i,8]*tau + g[i,2])*(4*delta^4*g[i,6]^2 - 8*delta^3*g[i,6]^2*g[i,9] + 4*delta^2*g[i,3]*g[i,6] + 4*delta^2*g[i,6]^2*g[i,9]^2 + 2*delta^2*g[i,6] - 4*delta*g[i,3]*g[i,6]*g[i,9] + g[i,3]^2 - g[i,3]) for i in 1:5);
end tdd_fRes_tdd;

redeclare function extends ttd_fRes_ttd
    "Short form for tau*tau*delta*(dddalpha_r/(dtau*dtau*ddelta))"
protected
  final constant Real [7,3] p=[
       0.388568232032E+00,  0.000,   1.00;
       0.293854759427E+01,  0.750,   1.00;
      -0.558671885349E+01,  1.000,   1.00;
      -0.767531995925E+00,  2.000,   1.00;
       0.317290055804E+00,  0.750,   2.00;
       0.548033158978E+00,  2.000,   2.00;
       0.122794112203E+00,  0.750,   3.00];

  final constant Real[27,4] b= [
       0.216589615432E+01,  1.500,   1.00,    1;
       0.158417351097E+01,  1.500,   2.00,    1;
      -0.231327054055E+00,  2.500,   4.00,    1;
       0.581169164314E-01,  0.000,   5.00,    1;
      -0.553691372054E+00,  1.500,   5.00,    1;
       0.489466159094E+00,  2.000,   5.00,    1;
      -0.242757398435E-01,  0.000,   6.00,    1;
       0.624947905017E-01,  1.000,   6.00,    1;
      -0.121758602252E+00,  2.000,   6.00,    1;
      -0.370556852701E+00,  3.000,   1.00,    2;
      -0.167758797004E-01,  6.000,   1.00,    2;
      -0.119607366380E+00,  3.000,   4.00,    2;
      -0.456193625088E-01,  6.000,   4.00,    2;
       0.356127892703E-01,  8.000,   4.00,    2;
      -0.744277271321E-02,  6.000,   7.00,    2;
      -0.173957049024E-02,  0.000,   8.00,    2;
      -0.218101212895E-01,  7.000,   2.00,    3;
       0.243321665592E-01, 12.000,   3.00,    3;
      -0.374401334235E-01, 16.000,   3.00,    3;
       0.143387157569E+00, 22.000,   5.00,    4;
      -0.134919690833E+00, 24.000,   5.00,    4;
      -0.231512250535E-01, 16.000,   6.00,    4;
       0.123631254929E-01, 24.000,   7.00,    4;
       0.210583219729E-02,  8.000,   8.00,    4;
      -0.339585190264E-03,  2.000,  10.00,    4;
       0.559936517716E-02, 28.000,   4.00,    5;
      -0.303351180556E-03, 14.000,   8.00,    6];

  final constant Real[5,9] g = [
      -0.213654886883E+03,  1.000,   2.00,    2, 2,  -25.,  -325.,  1.16, 1.;
       0.266415691493E+05,  0.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
      -0.240272122046E+05,  1.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
      -0.283416034240E+03,  3.000,   3.00,    2, 2,  -15.,  -275.,  1.25, 1.;
       0.212472844002E+03,  3.000,   3.00,    2, 2,  -20.,  -275.,  1.22, 1.];
algorithm
    ttd_fRes_ttd :=
      sum(delta^(p[i,3])*p[i,1]*p[i,2]*p[i,3]*tau^(p[i,2])*(p[i,2] - 1) for i in 1:7)
    + sum(b[i,1]*b[i,2]*delta^(b[i,3])*tau^(b[i,2])*exp(-delta^b[i,4])*(b[i,3] - b[i,4]*delta^b[i,4])*(b[i,2] - 1) for i in 1:27)
    + sum(delta^(g[i,3])*g[i,1]*tau^(g[i,2])*exp(g[i,6]*(delta - g[i,9])^2 + g[i,7]*(g[i,8] - tau)^2)*(2*g[i,6]*delta^2 - 2*g[i,6]*g[i,9]*delta + g[i,3])*(g[i,2]^2 - 4*g[i,2]*g[i,7]*g[i,8]*tau + 4*g[i,2]*g[i,7]*tau^2 - g[i,2] + 4*g[i,7]^2*g[i,8]^2*tau^2 - 8*g[i,7]^2*g[i,8]*tau^3 + 4*g[i,7]^2*tau^4 + 2*g[i,7]*tau^2) for i in 1:5);
end ttd_fRes_ttd;
/*Provide functions for saturation properties. These functions are
    fitted to external data (e.g. data extracted from RefProp or FluidProp).
*/
redeclare function extends saturationPressure
    "Saturation pressure of refrigerant (Ancillary equation)"
protected
    Real OM = (1 - T/fluidConstants[1].criticalTemperature);

algorithm
    if T>fluidConstants[1].criticalTemperature then
      p := fluidConstants[1].criticalPressure;
    elseif T<fluidConstants[1].triplePointTemperature then
      p := fluidConstants[1].triplePointPressure;
    else
      p:= fluidConstants[1].criticalPressure * exp((fluidConstants[1].criticalTemperature/T) *((-10.8874701459618).*(OM).^(1.02777903636517) + (-2.53014476472302).*(OM).^(3.04857880618312) + (4.85976334934365).*(OM).^(1.12780675832611)));
    end if;
end saturationPressure;

redeclare function extends saturationTemperature
    "Saturation temperature of refrigerant (Ancillary equation)"
protected
  Real x;
algorithm
  x := (p - 3445540.85867591) ./ 1822725.70538495;
  T := 268.600000000000 + 20.5103632342287 .* ((0.200822882160402) + (0.971452596229363).*x.^1 + (-0.189436119639029).*x.^2 + (0.0563877648731632).*x.^3 + (-0.020714524035119).*x.^4 + (0.00842457137711057).*x.^5 + (-0.00369132626395774).*x.^6 + (0.00114310539368957).*x.^7 + (-0.000400215031011729).*x.^8 + (0.000675120780717472).*x.^9 + (-0.000337725889546381).*x.^10 + (-0.000123533921282085).*x.^11 + (2.54822197136637e-05).*x.^12 + (7.84687400408321e-05).*x.^13 + (-5.67729643824132e-06).*x.^14 + (-1.55649714573718e-05).*x.^15 + (-4.6244025542171e-06).*x.^16 + (5.77175283129492e-06).*x.^17 + (-1.06584203525244e-06).*x.^18);
end saturationTemperature;

redeclare function extends bubbleDensity
    "Boiling curve specific density of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x := 1 - (sat.Tsat ./ 304.128200000000);
    dl := (478.968682010804 + (495.683257706123).*x.^(1/3) + (3543.67960624232).*x.^(2/3) + (-16584.0906529594).*x.^(3/3) + (39329.3130708854).*x.^(4/3) + (7445.88449470718).*x.^(5/3) + (-254232.892949454).*x.^(6/3) + (489081.275821062).*x.^(7/3) + (-51539.65263982).*x.^(8/3) + (-948816.669406408).*x.^(9/3) + (1205337.05384885).*x.^(10/3) + (-479896.34391407).*x.^(11/3));

end bubbleDensity;

redeclare function extends dewDensity
    "Dew curve specific density of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x := 1 - (sat.Tsat ./ 304.128200000000);
    dv := (462.48836810312 + (-610.315494915381).*x.^(1/3) + (-2823.72517117551).*x.^(2/3) + (16650.8365223046).*x.^(3/3) + (-49525.3789777128).*x.^(4/3) + (52571.1979874299).*x.^(5/3) + (74412.4761984176).*x.^(6/3) + (-159900.265678589).*x.^(7/3) + (-119473.839067579).*x.^(8/3) + (203760.826571182).*x.^(9/3) + (280692.836303772).*x.^(10/3) + (40256.3509590889).*x.^(11/3) + (-336116.042618752).*x.^(12/3) + (-570463.466661569).*x.^(13/3) + (-382871.321141713).*x.^(14/3) + (211234.622165815).*x.^(15/3) + (1120586.29646474).*x.^(16/3) + (2579594.67174698).*x.^(17/3) + (-856309.127058874).*x.^(18/3) + (-1480616.80660559).*x.^(19/3) + (-1952678.05291741).*x.^(20/3) + (-1966218.66650212).*x.^(21/3) + (-1411789.30657025).*x.^(22/3) + (204923.572495633).*x.^(23/3) + (7059952.78039912).*x.^(24/3));
end dewDensity;

redeclare function extends bubbleEnthalpy
    "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x := sat.psat ./ 7377300;
    hl := 194327.316977888 .* exp((1./x) .* ((-0.769139700781037).*(1-x).^(0.722830089188778) + (0.460882432656297).*(1-x).^(-0.0152191856879518) + (0.22272419609671).*(1-x).^(3.00703720797531) + (0.141897620188616).*(1-x).^(50.6995880180848) + (0.0519530578466151).*(1-x).^(9.69794921193602)));
end bubbleEnthalpy;

redeclare function extends dewEnthalpy
    "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x := sat.psat ./ 7377300;
    hv := 424562.952802457.*(-103.443830399603 + (798.531276359906).*x.^(1/3) + (-2016.96831340003).*x.^(2/3) + (839.988263280569).*x.^(3/3) + (4278.00109616943).*x.^(4/3) + (-6098.57015815342).*x.^(5/3) + (1780.68613765026).*x.^(6/3) + (-2418.01704526953).*x.^(7/3) + (6114.3000653877).*x.^(8/3) + (-2318.06423869379).*x.^(9/3) + (644.02003265782).*x.^(10/3) + (-2758.10371042978).*x.^(11/3) + (-1473.01876196517).*x.^(12/3) + (4497.50879221731).*x.^(13/3) + (-1240.70114507868).*x.^(14/3) + (-620.781932531012).*x.^(15/3) + (-3613.82139176729).*x.^(16/3) + (5608.17107066454).*x.^(17/3) + (463.44851295393).*x.^(18/3) + (-3248.00120191089).*x.^(19/3) + (-976.409582464897).*x.^(20/3) + (-304.50206372898).*x.^(21/3) + (9048.69452029705).*x.^(22/3) + (-2424.01900336071).*x.^(23/3) + (-10138.6108741398).*x.^(24/3) + (8364.19417557509).*x.^(25/3) + (-4076.27821934385).*x.^(26/3) + (-4174.91489500871).*x.^(27/3) + (-290.125169860409).*x.^(28/3) + (3529.10689732294).*x.^(29/3) + (5173.96993434184).*x.^(30/3) + (3635.30103017327).*x.^(31/3) + (-3504.65733876607).*x.^(32/3) + (3004.55491495939).*x.^(33/3) + (-2241.40409555241).*x.^(34/3) + (-5682.56832761244).*x.^(35/3) + (-7158.70194114246).*x.^(36/3) + (1460.05936697027).*x.^(37/3) + (8502.97020219723).*x.^(38/3) + (5568.34835163651).*x.^(39/3) + (-6429.35768622983).*x.^(40/3));

end dewEnthalpy;

redeclare function extends bubbleEntropy
    "Boiling curve specific entropy of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
  x := sat.psat ./ 7377300;
  sl := 971.502865291826 .* exp((1./x) .* ((0.332362265133049).*(1-x).^(-0.0157738143026104) + (-0.53827965447008).*(1-x).^(0.710529444013852) + (0.0376198585567208).*(1-x).^(10.3660660062362) + (0.146071000768772).*(1-x).^(3.14098135792114)));
end bubbleEntropy;

redeclare function extends dewEntropy
    "Dew curve specific entropy of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
  x := sat.psat ./ 7377300;
  sv := 1852.51697191582 .* exp((1./x) .* ((-0.104686424493378).*(1-x).^(1.91767692218586) + (-0.231351021595994).*(1-x).^(-0.00970758719031325) + (0.350507795905541).*(1-x).^(0.456797862631896) + (-0.0111283896749802).*(1-x).^(8.11458177168435)));
end dewEntropy;
/*Provide functions to calculate thermodynamic properties depending on the
    independent variables. Moreover, these functions may depend on
    the Helmholtz EoS.
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
    Real x3;
    Real y3;
    Real x_scr;
    Real h_scr;

algorithm
    h_dew := dewEnthalpy(sat = setSat_p(p=p));
    h_bubble := bubbleEnthalpy(sat = setSat_p(p=p));
    x_scr := (p-8689000) / 757339.201855197;
    h_scr := 284773.077243989 + 8625.39176119581 *((-0.26968374724995) + (-0.686038150275524).*x_scr.^1 + (0.192604296642739).*x_scr.^2 + (-0.142034551199029).*x_scr.^3 + (-0.251951854627595).*x_scr.^4 + (0.571531783870116).*x_scr.^5 + (1.11768878334674).*x_scr.^6 + (-1.8049309139747).*x_scr.^7 + (-2.23879529796539).*x_scr.^8 + (3.01031299057939).*x_scr.^9 + (2.5191621143989).*x_scr.^10 + (-2.94309246578317).*x_scr.^11 + (-1.65772169673076).*x_scr.^12 + (1.73431739837587).*x_scr.^13 + (0.634400227016547).*x_scr.^14 + (-0.606654645116181).*x_scr.^15 + (-0.130769568314684).*x_scr.^16 + (0.116029826531554).*x_scr.^17 + (0.0112418969238134).*x_scr.^18 + (-0.00935823150820951).*x_scr.^19);
    if p<fluidConstants[1].criticalPressure then
      if h<h_bubble-dh then
        x1 := (p-6097764.94682380) / 2585452.16490808;
        y1 := (h-153365.801954585) / 65673.4529788826;
        T := 250.119094022263 + 27.8301755311303 * (0.0984832309267652 + (0.00389756589392757).*x1.^1 + (-0.00204989599989688).*x1.^2 + (1.1459222893016).*y1.^1 + (-0.070343134597504).*y1.^2 + (-0.0562686778415428).*y1.^3 + (0.00879891946010096).*y1.^4 + (0.0661811304570504).*y1.^5 + (-0.061982511612663).*y1.^6 + (-0.033103421121683).*y1.^7 + (0.0708210077537962).*y1.^8 + (-0.0381143725065783).*y1.^9 + (0.0081280075955589).*y1.^10 + (-0.000259913572675876).*y1.^11 + (-9.4154620197727e-05).*y1.^12 + (0.00114111755205254).*y1.^11.*x1.^1 + (-0.00888450759269475).*y1.^10.*x1.^1 + (-0.00208685488221609).*y1.^10.*x1.^2 + (0.0278960316992357).*y1.^9.*x1.^1 + (0.0112452499058972).*y1.^9.*x1.^2 + (-0.0394466728409158).*y1.^8.*x1.^1 + (-0.0196830066253284).*y1.^8.*x1.^2 + (0.0147652303732295).*y1.^7.*x1.^1 + (0.00266275029347203).*y1.^7.*x1.^2 + (0.0181578424828338).*y1.^6.*x1.^1 + (0.0298953638879228).*y1.^6.*x1.^2 + (-0.0100341747271017).*y1.^5.*x1.^1 + (-0.0270609660358611).*y1.^5.*x1.^2 + (-0.00184545542883243).*y1.^4.*x1.^1 + (-0.00807933082815375).*y1.^4.*x1.^2 + (0.0056870535948233).*y1.^3.*x1.^1 + (0.0148022794963983).*y1.^3.*x1.^2 + (0.0134565003032703).*y1.^2.*x1.^1 + (-0.00137103728603173).*y1.^2.*x1.^2 + (0.0267940317659499).*y1.^1.*x1.^1 + (-0.00459360679387857).*y1.^1.*x1.^2);
      elseif h>h_dew+dh then
        x2 := (p-4742415.01272265)/2338206.42191283;
        y2 := (h-485679.617572220)/49740.9272100767;
        T := 325.770836615015 + 45.8537417710473 * (-0.0314099744127785 + (0.444339343950006).*x2.^1 + (-0.0427212246316783).*x2.^2 + (0.00274245407717317).*x2.^3 + (-0.00461920614601444).*x2.^4 + (-0.00176224711211021).*x2.^5 + (0.0132656103773099).*x2.^6 + (0.0105752427479749).*x2.^7 + (-0.0236760630222917).*x2.^8 + (-0.0168720406747937).*x2.^9 + (0.022713086930061).*x2.^10 + (0.0136176749179793).*x2.^11 + (-0.0112129614107892).*x2.^12 + (-0.00584990443240667).*x2.^13 + (0.0024211858418993).*x2.^14 + (0.00111300232860791).*x2.^15 + (-0.000117019357467813).*x2.^16 + (-3.20429644832931e-05).*x2.^17 + (0.837110380684298).*y2.^1 + (0.0965962834229711).*y2.^2 + (-0.0192570270037383).*y2.^3 + (0.0023662867214345).*y2.^4 + (-0.0145584955227089).*y2.^5 + (0.00746574972430255).*y2.^6 + (0.00627822681033568).*y2.^7 + (-0.00611036225015518).*y2.^8 + (0.000974745324996649).*y2.^9 + (0.00121343128586345).*y2.^10 + (-0.000915758584624007).*y2.^11 + (0.000206196177257671).*y2.^12 + (-0.00116092378210656).*x2.^16.*y2.^1 + (-0.00233608836377314).*x2.^15.*y2.^1 + (-0.00298788587186705).*x2.^15.*y2.^2 + (0.00806608261834735).*x2.^14.*y2.^1 + (-0.00133146318650065).*x2.^14.*y2.^2 + (-0.00568837228275852).*x2.^14.*y2.^3 + (0.0185469324339728).*x2.^13.*y2.^1 + (0.0257266792132771).*x2.^13.*y2.^2 + (-0.0145834870786212).*x2.^13.*y2.^3 + (0.000208301251904854).*x2.^13.*y2.^4 + (-0.016572873737851).*x2.^12.*y2.^1 + (0.0131347761181012).*x2.^12.*y2.^2 + (0.0180795600719053).*x2.^12.*y2.^3 + (-0.00176016596448422).*x2.^12.*y2.^4 + (0.00132457553597643).*x2.^12.*y2.^5 + (-0.0490929689741519).*x2.^11.*y2.^1 + (-0.0777820483376422).*x2.^11.*y2.^2 + (0.061947474184922).*x2.^11.*y2.^3 + (-0.00575732208592028).*x2.^11.*y2.^4 + (0.0028993960220229).*x2.^11.*y2.^5 + (5.20988964635086e-05).*x2.^11.*y2.^6 + (0.0107088107250875).*x2.^10.*y2.^1 + (-0.0318185996209532).*x2.^10.*y2.^2 + (-0.0200555153646824).*x2.^10.*y2.^3 + (0.00393767013775708).*x2.^10.*y2.^4 + (-0.00363140821310015).*x2.^10.*y2.^5 + (5.51773352489347e-05).*x2.^10.*y2.^6 + (-6.00904996718504e-05).*x2.^10.*y2.^7 + (0.0564015649305773).*x2.^9.*y2.^1 + (0.116211454372248).*x2.^9.*y2.^2 + (-0.101410426217775).*x2.^9.*y2.^3 + (0.017710987889682).*x2.^9.*y2.^4 + (-0.00902205584903315).*x2.^9.*y2.^5 + (-0.000510794675874849).*x2.^9.*y2.^6 + (-0.000478722193048678).*x2.^9.*y2.^7 + (0.000159484042662665).*x2.^9.*y2.^8 + (0.00165601255693273).*x2.^8.*y2.^1 + (0.0274642225330768).*x2.^8.*y2.^2 + (0.01130644050621).*x2.^8.*y2.^3 + (-0.00313612659494668).*x2.^8.*y2.^4 + (0.00721355108320489).*x2.^8.*y2.^5 + (0.00058296877219357).*x2.^8.*y2.^6 + (-0.00279434195063629).*x2.^8.*y2.^7 + (0.000565553736578638).*x2.^8.*y2.^8 + (0.000185649477412129).*x2.^8.*y2.^9 + (-0.0237743395012459).*x2.^7.*y2.^1 + (-0.092672681497705).*x2.^7.*y2.^2 + (0.0735659308834566).*x2.^7.*y2.^3 + (-0.0217028472001825).*x2.^7.*y2.^4 + (0.0127657381034912).*x2.^7.*y2.^5 + (0.00369435121533928).*x2.^7.*y2.^6 + (0.000707730613885534).*x2.^7.*y2.^7 + (-0.0016528915219958).*x2.^7.*y2.^8 + (-0.000301527813376657).*x2.^7.*y2.^9 + (0.000353019886328202).*x2.^7.*y2.^10 + (0.00200090742302188).*x2.^6.*y2.^1 + (-0.0037941265333612).*x2.^6.*y2.^2 + (-0.016367448986788).*x2.^6.*y2.^3 + (0.00123472853074749).*x2.^6.*y2.^4 + (-0.0043183338007886).*x2.^6.*y2.^5 + (-0.000791594933192776).*x2.^6.*y2.^6 + (0.00501342324148632).*x2.^6.*y2.^7 + (-0.00173556260432616).*x2.^6.*y2.^8 + (0.00114045574733164).*x2.^6.*y2.^9 + (-0.00137226225896949).*x2.^6.*y2.^10 + (0.00037952482473772).*x2.^6.*y2.^11 + (-0.00518905655947852).*x2.^5.*y2.^1 + (0.0387517167083185).*x2.^5.*y2.^2 + (-0.0187682285365427).*x2.^5.*y2.^3 + (0.00862362389750097).*x2.^5.*y2.^4 + (-0.00556082895705846).*x2.^5.*y2.^5 + (-0.00590910281966607).*x2.^5.*y2.^6 + (-0.000963184828529965).*x2.^5.*y2.^7 + (0.00273322888722273).*x2.^5.*y2.^8 + (-0.00060825456966656).*x2.^5.*y2.^9 + (0.000998864592646648).*x2.^5.*y2.^10 + (-0.0007007543932457).*x2.^5.*y2.^11 + (8.78046888345559e-05).*x2.^5.*y2.^12 + (-0.0108537264305887).*x2.^4.*y2.^1 + (-0.00513202654010906).*x2.^4.*y2.^2 + (0.0338321480469933).*x2.^4.*y2.^3 + (-0.00602505449699182).*x2.^4.*y2.^4 + (-0.0168402572851103).*x2.^4.*y2.^5 + (0.00852496642629238).*x2.^4.*y2.^6 + (0.00224153137219189).*x2.^4.*y2.^7 + (-0.00258555229224404).*x2.^4.*y2.^8 + (-0.0027103244607679).*x2.^4.*y2.^9 + (0.00366757356902761).*x2.^4.*y2.^10 + (-0.00112358749371662).*x2.^4.*y2.^11 + (4.95666855068354e-05).*x2.^4.*y2.^12 + (0.000904216747891165).*x2.^3.*y2.^1 + (-0.00609103745602836).*x2.^3.*y2.^2 + (0.000415552432675825).*x2.^3.*y2.^3 + (0.00891459432121028).*x2.^3.*y2.^4 + (-0.00780964044175517).*x2.^3.*y2.^5 + (-0.00593874435918624).*x2.^3.*y2.^6 + (0.00201976666145268).*x2.^3.*y2.^7 + (0.00980435683857743).*x2.^3.*y2.^8 + (-0.000495536068926341).*x2.^3.*y2.^9 + (-0.00869557457099743).*x2.^3.*y2.^10 + (0.00495906324016952).*x2.^3.*y2.^11 + (-0.000779545644811908).*x2.^3.*y2.^12 + (0.0415192402574172).*x2.^2.*y2.^1 + (-0.012569648063452).*x2.^2.*y2.^2 + (-0.0256234101385241).*x2.^2.*y2.^3 + (0.00618076894733697).*x2.^2.*y2.^4 + (0.0194955159561419).*x2.^2.*y2.^5 + (6.09276078122551e-05).*x2.^2.*y2.^6 + (-0.000433840684470545).*x2.^2.*y2.^7 + (-0.0163567605252973).*x2.^2.*y2.^8 + (0.00594081462490066).*x2.^2.*y2.^9 + (0.00850206980246039).*x2.^2.*y2.^10 + (-0.00643247113942379).*x2.^2.*y2.^11 + (0.00125819952363372).*x2.^2.*y2.^12 + (-0.140009686882945).*x2.^1.*y2.^1 + (0.0204087567923358).*x2.^1.*y2.^2 + (-0.00105100101152042).*x2.^1.*y2.^3 + (-0.0079360915109717).*x2.^1.*y2.^4 + (0.019159622527817).*x2.^1.*y2.^5 + (-0.00825234493717037).*x2.^1.*y2.^6 + (-0.0118328037065763).*x2.^1.*y2.^7 + (0.015393829178147).*x2.^1.*y2.^8 + (-0.00400769308934593).*x2.^1.*y2.^9 + (-0.00469195213648668).*x2.^1.*y2.^10 + (0.00381965826823239).*x2.^1.*y2.^11 + (-0.000822508284396234).*x2.^1.*y2.^12);
      elseif h<h_bubble then
        x1 := (p-6097764.94682380) / 2585452.16490808;
        y1 := (h-153365.801954585) / 65673.4529788826;
        T1 := 250.119094022263 + 27.8301755311303 * (0.0984832309267652 + (0.00389756589392757).*x1.^1 + (-0.00204989599989688).*x1.^2 + (1.1459222893016).*y1.^1 + (-0.070343134597504).*y1.^2 + (-0.0562686778415428).*y1.^3 + (0.00879891946010096).*y1.^4 + (0.0661811304570504).*y1.^5 + (-0.061982511612663).*y1.^6 + (-0.033103421121683).*y1.^7 + (0.0708210077537962).*y1.^8 + (-0.0381143725065783).*y1.^9 + (0.0081280075955589).*y1.^10 + (-0.000259913572675876).*y1.^11 + (-9.4154620197727e-05).*y1.^12 + (0.00114111755205254).*y1.^11.*x1.^1 + (-0.00888450759269475).*y1.^10.*x1.^1 + (-0.00208685488221609).*y1.^10.*x1.^2 + (0.0278960316992357).*y1.^9.*x1.^1 + (0.0112452499058972).*y1.^9.*x1.^2 + (-0.0394466728409158).*y1.^8.*x1.^1 + (-0.0196830066253284).*y1.^8.*x1.^2 + (0.0147652303732295).*y1.^7.*x1.^1 + (0.00266275029347203).*y1.^7.*x1.^2 + (0.0181578424828338).*y1.^6.*x1.^1 + (0.0298953638879228).*y1.^6.*x1.^2 + (-0.0100341747271017).*y1.^5.*x1.^1 + (-0.0270609660358611).*y1.^5.*x1.^2 + (-0.00184545542883243).*y1.^4.*x1.^1 + (-0.00807933082815375).*y1.^4.*x1.^2 + (0.0056870535948233).*y1.^3.*x1.^1 + (0.0148022794963983).*y1.^3.*x1.^2 + (0.0134565003032703).*y1.^2.*x1.^1 + (-0.00137103728603173).*y1.^2.*x1.^2 + (0.0267940317659499).*y1.^1.*x1.^1 + (-0.00459360679387857).*y1.^1.*x1.^2);
        T := saturationTemperature(p) * (1-(h_bubble-h)/dh) + T1*(h_bubble - h) / dh;
      elseif h>h_dew then
        x2 := (p-4742415.01272265)/2338206.42191283;
        y2 := (h-485679.617572220)/49740.9272100767;
        T2 := 325.770836615015 + 45.8537417710473 * (-0.0314099744127785 + (0.444339343950006).*x2.^1 + (-0.0427212246316783).*x2.^2 + (0.00274245407717317).*x2.^3 + (-0.00461920614601444).*x2.^4 + (-0.00176224711211021).*x2.^5 + (0.0132656103773099).*x2.^6 + (0.0105752427479749).*x2.^7 + (-0.0236760630222917).*x2.^8 + (-0.0168720406747937).*x2.^9 + (0.022713086930061).*x2.^10 + (0.0136176749179793).*x2.^11 + (-0.0112129614107892).*x2.^12 + (-0.00584990443240667).*x2.^13 + (0.0024211858418993).*x2.^14 + (0.00111300232860791).*x2.^15 + (-0.000117019357467813).*x2.^16 + (-3.20429644832931e-05).*x2.^17 + (0.837110380684298).*y2.^1 + (0.0965962834229711).*y2.^2 + (-0.0192570270037383).*y2.^3 + (0.0023662867214345).*y2.^4 + (-0.0145584955227089).*y2.^5 + (0.00746574972430255).*y2.^6 + (0.00627822681033568).*y2.^7 + (-0.00611036225015518).*y2.^8 + (0.000974745324996649).*y2.^9 + (0.00121343128586345).*y2.^10 + (-0.000915758584624007).*y2.^11 + (0.000206196177257671).*y2.^12 + (-0.00116092378210656).*x2.^16.*y2.^1 + (-0.00233608836377314).*x2.^15.*y2.^1 + (-0.00298788587186705).*x2.^15.*y2.^2 + (0.00806608261834735).*x2.^14.*y2.^1 + (-0.00133146318650065).*x2.^14.*y2.^2 + (-0.00568837228275852).*x2.^14.*y2.^3 + (0.0185469324339728).*x2.^13.*y2.^1 + (0.0257266792132771).*x2.^13.*y2.^2 + (-0.0145834870786212).*x2.^13.*y2.^3 + (0.000208301251904854).*x2.^13.*y2.^4 + (-0.016572873737851).*x2.^12.*y2.^1 + (0.0131347761181012).*x2.^12.*y2.^2 + (0.0180795600719053).*x2.^12.*y2.^3 + (-0.00176016596448422).*x2.^12.*y2.^4 + (0.00132457553597643).*x2.^12.*y2.^5 + (-0.0490929689741519).*x2.^11.*y2.^1 + (-0.0777820483376422).*x2.^11.*y2.^2 + (0.061947474184922).*x2.^11.*y2.^3 + (-0.00575732208592028).*x2.^11.*y2.^4 + (0.0028993960220229).*x2.^11.*y2.^5 + (5.20988964635086e-05).*x2.^11.*y2.^6 + (0.0107088107250875).*x2.^10.*y2.^1 + (-0.0318185996209532).*x2.^10.*y2.^2 + (-0.0200555153646824).*x2.^10.*y2.^3 + (0.00393767013775708).*x2.^10.*y2.^4 + (-0.00363140821310015).*x2.^10.*y2.^5 + (5.51773352489347e-05).*x2.^10.*y2.^6 + (-6.00904996718504e-05).*x2.^10.*y2.^7 + (0.0564015649305773).*x2.^9.*y2.^1 + (0.116211454372248).*x2.^9.*y2.^2 + (-0.101410426217775).*x2.^9.*y2.^3 + (0.017710987889682).*x2.^9.*y2.^4 + (-0.00902205584903315).*x2.^9.*y2.^5 + (-0.000510794675874849).*x2.^9.*y2.^6 + (-0.000478722193048678).*x2.^9.*y2.^7 + (0.000159484042662665).*x2.^9.*y2.^8 + (0.00165601255693273).*x2.^8.*y2.^1 + (0.0274642225330768).*x2.^8.*y2.^2 + (0.01130644050621).*x2.^8.*y2.^3 + (-0.00313612659494668).*x2.^8.*y2.^4 + (0.00721355108320489).*x2.^8.*y2.^5 + (0.00058296877219357).*x2.^8.*y2.^6 + (-0.00279434195063629).*x2.^8.*y2.^7 + (0.000565553736578638).*x2.^8.*y2.^8 + (0.000185649477412129).*x2.^8.*y2.^9 + (-0.0237743395012459).*x2.^7.*y2.^1 + (-0.092672681497705).*x2.^7.*y2.^2 + (0.0735659308834566).*x2.^7.*y2.^3 + (-0.0217028472001825).*x2.^7.*y2.^4 + (0.0127657381034912).*x2.^7.*y2.^5 + (0.00369435121533928).*x2.^7.*y2.^6 + (0.000707730613885534).*x2.^7.*y2.^7 + (-0.0016528915219958).*x2.^7.*y2.^8 + (-0.000301527813376657).*x2.^7.*y2.^9 + (0.000353019886328202).*x2.^7.*y2.^10 + (0.00200090742302188).*x2.^6.*y2.^1 + (-0.0037941265333612).*x2.^6.*y2.^2 + (-0.016367448986788).*x2.^6.*y2.^3 + (0.00123472853074749).*x2.^6.*y2.^4 + (-0.0043183338007886).*x2.^6.*y2.^5 + (-0.000791594933192776).*x2.^6.*y2.^6 + (0.00501342324148632).*x2.^6.*y2.^7 + (-0.00173556260432616).*x2.^6.*y2.^8 + (0.00114045574733164).*x2.^6.*y2.^9 + (-0.00137226225896949).*x2.^6.*y2.^10 + (0.00037952482473772).*x2.^6.*y2.^11 + (-0.00518905655947852).*x2.^5.*y2.^1 + (0.0387517167083185).*x2.^5.*y2.^2 + (-0.0187682285365427).*x2.^5.*y2.^3 + (0.00862362389750097).*x2.^5.*y2.^4 + (-0.00556082895705846).*x2.^5.*y2.^5 + (-0.00590910281966607).*x2.^5.*y2.^6 + (-0.000963184828529965).*x2.^5.*y2.^7 + (0.00273322888722273).*x2.^5.*y2.^8 + (-0.00060825456966656).*x2.^5.*y2.^9 + (0.000998864592646648).*x2.^5.*y2.^10 + (-0.0007007543932457).*x2.^5.*y2.^11 + (8.78046888345559e-05).*x2.^5.*y2.^12 + (-0.0108537264305887).*x2.^4.*y2.^1 + (-0.00513202654010906).*x2.^4.*y2.^2 + (0.0338321480469933).*x2.^4.*y2.^3 + (-0.00602505449699182).*x2.^4.*y2.^4 + (-0.0168402572851103).*x2.^4.*y2.^5 + (0.00852496642629238).*x2.^4.*y2.^6 + (0.00224153137219189).*x2.^4.*y2.^7 + (-0.00258555229224404).*x2.^4.*y2.^8 + (-0.0027103244607679).*x2.^4.*y2.^9 + (0.00366757356902761).*x2.^4.*y2.^10 + (-0.00112358749371662).*x2.^4.*y2.^11 + (4.95666855068354e-05).*x2.^4.*y2.^12 + (0.000904216747891165).*x2.^3.*y2.^1 + (-0.00609103745602836).*x2.^3.*y2.^2 + (0.000415552432675825).*x2.^3.*y2.^3 + (0.00891459432121028).*x2.^3.*y2.^4 + (-0.00780964044175517).*x2.^3.*y2.^5 + (-0.00593874435918624).*x2.^3.*y2.^6 + (0.00201976666145268).*x2.^3.*y2.^7 + (0.00980435683857743).*x2.^3.*y2.^8 + (-0.000495536068926341).*x2.^3.*y2.^9 + (-0.00869557457099743).*x2.^3.*y2.^10 + (0.00495906324016952).*x2.^3.*y2.^11 + (-0.000779545644811908).*x2.^3.*y2.^12 + (0.0415192402574172).*x2.^2.*y2.^1 + (-0.012569648063452).*x2.^2.*y2.^2 + (-0.0256234101385241).*x2.^2.*y2.^3 + (0.00618076894733697).*x2.^2.*y2.^4 + (0.0194955159561419).*x2.^2.*y2.^5 + (6.09276078122551e-05).*x2.^2.*y2.^6 + (-0.000433840684470545).*x2.^2.*y2.^7 + (-0.0163567605252973).*x2.^2.*y2.^8 + (0.00594081462490066).*x2.^2.*y2.^9 + (0.00850206980246039).*x2.^2.*y2.^10 + (-0.00643247113942379).*x2.^2.*y2.^11 + (0.00125819952363372).*x2.^2.*y2.^12 + (-0.140009686882945).*x2.^1.*y2.^1 + (0.0204087567923358).*x2.^1.*y2.^2 + (-0.00105100101152042).*x2.^1.*y2.^3 + (-0.0079360915109717).*x2.^1.*y2.^4 + (0.019159622527817).*x2.^1.*y2.^5 + (-0.00825234493717037).*x2.^1.*y2.^6 + (-0.0118328037065763).*x2.^1.*y2.^7 + (0.015393829178147).*x2.^1.*y2.^8 + (-0.00400769308934593).*x2.^1.*y2.^9 + (-0.00469195213648668).*x2.^1.*y2.^10 + (0.00381965826823239).*x2.^1.*y2.^11 + (-0.000822508284396234).*x2.^1.*y2.^12);
        T := saturationTemperature(p) * (1- (h-h_dew)/dh) + T2*(h-h_dew)/dh;
      end if;
    elseif h<h_scr then
        x1 := (p-6097764.94682380) / 2585452.16490808;
        y1 := (h-153365.801954585) / 65673.4529788826;
        T := 250.119094022263 + 27.8301755311303 * (0.0984832309267652 + (0.00389756589392757).*x1.^1 + (-0.00204989599989688).*x1.^2 + (1.1459222893016).*y1.^1 + (-0.070343134597504).*y1.^2 + (-0.0562686778415428).*y1.^3 + (0.00879891946010096).*y1.^4 + (0.0661811304570504).*y1.^5 + (-0.061982511612663).*y1.^6 + (-0.033103421121683).*y1.^7 + (0.0708210077537962).*y1.^8 + (-0.0381143725065783).*y1.^9 + (0.0081280075955589).*y1.^10 + (-0.000259913572675876).*y1.^11 + (-9.4154620197727e-05).*y1.^12 + (0.00114111755205254).*y1.^11.*x1.^1 + (-0.00888450759269475).*y1.^10.*x1.^1 + (-0.00208685488221609).*y1.^10.*x1.^2 + (0.0278960316992357).*y1.^9.*x1.^1 + (0.0112452499058972).*y1.^9.*x1.^2 + (-0.0394466728409158).*y1.^8.*x1.^1 + (-0.0196830066253284).*y1.^8.*x1.^2 + (0.0147652303732295).*y1.^7.*x1.^1 + (0.00266275029347203).*y1.^7.*x1.^2 + (0.0181578424828338).*y1.^6.*x1.^1 + (0.0298953638879228).*y1.^6.*x1.^2 + (-0.0100341747271017).*y1.^5.*x1.^1 + (-0.0270609660358611).*y1.^5.*x1.^2 + (-0.00184545542883243).*y1.^4.*x1.^1 + (-0.00807933082815375).*y1.^4.*x1.^2 + (0.0056870535948233).*y1.^3.*x1.^1 + (0.0148022794963983).*y1.^3.*x1.^2 + (0.0134565003032703).*y1.^2.*x1.^1 + (-0.00137103728603173).*y1.^2.*x1.^2 + (0.0267940317659499).*y1.^1.*x1.^1 + (-0.00459360679387857).*y1.^1.*x1.^2);
    elseif h>h_scr then
        x3 := (p-8180784.97222942)/876732.836302901;
        y3 := (h-441803.785720452)/85518.0223361212;
        T  :=  342.072675763187 + 33.8095274165374 *(-0.461528781943788 + (0.178728629037837).*x3.^1 + (0.00773171857463359).*x3.^2 + (0.033214152630316).*x3.^3 + (-0.0239350232349048).*x3.^4 + (-0.017624404186267).*x3.^5 + (0.0149064639999978).*x3.^6 + (-0.0161170367950099).*x3.^7 + (0.0105030000139537).*x3.^8 + (0.00722487231726519).*x3.^9 + (-0.000714018575115048).*x3.^10 + (-1.36335660276188e-05).*x3.^11 + (-0.00458510492375029).*x3.^12 + (0.000754350903212885).*x3.^13 + (-0.0037401654238058).*x3.^14 + (0.0062994048177452).*x3.^15 + (-0.00141395081798396).*x3.^16 + (-0.00161788619447214).*x3.^17 + (0.000912087839627738).*x3.^18 + (-0.000134960473379243).*x3.^19 + (1.05605170092997).*y3.^1 + (0.577306997583531).*y3.^2 + (-0.00276938731969825).*y3.^3 + (0.0068421436673507).*y3.^4 + (-0.0259063468625705).*y3.^5 + (-0.0906671502459144).*y3.^6 + (0.0137512817839854).*y3.^7 + (0.042368015084157).*y3.^8 + (0.00137322151172405).*y3.^9 + (-0.00657396283222445).*y3.^10 + (-0.0010404706335473).*y3.^11 + (6.52927521755537e-05).*x3.^18.*y3.^1 + (-0.000228746786374095).*x3.^17.*y3.^1 + (4.84048599642259e-05).*x3.^17.*y3.^2 + (-9.66961743054448e-07).*x3.^16.*y3.^1 + (-0.000109706576388026).*x3.^16.*y3.^2 + (-3.76259515604045e-05).*x3.^16.*y3.^3 + (4.18682029956124e-05).*x3.^15.*y3.^1 + (-0.000887652462542966).*x3.^15.*y3.^2 + (0.00022388309593638).*x3.^15.*y3.^3 + (5.78244914512302e-05).*x3.^15.*y3.^4 + (0.00154438521063997).*x3.^14.*y3.^1 + (0.00359192219395953).*x3.^14.*y3.^2 + (-0.000317447409565445).*x3.^14.*y3.^3 + (-0.000160326619346241).*x3.^14.*y3.^4 + (6.63399967701277e-05).*x3.^14.*y3.^5 + (-0.000439515466685735).*x3.^13.*y3.^1 + (-0.00335630302705239).*x3.^13.*y3.^2 + (-0.000301457687009814).*x3.^13.*y3.^3 + (-0.000670530325315454).*x3.^13.*y3.^4 + (-0.000249330471376903).*x3.^13.*y3.^5 + (0.000184264071453486).*x3.^13.*y3.^6 + (-0.000729927374909142).*x3.^12.*y3.^1 + (-0.000526014953057334).*x3.^12.*y3.^2 + (0.000445821171561984).*x3.^12.*y3.^3 + (0.00242702823714127).*x3.^12.*y3.^4 + (-0.000351282588772839).*x3.^12.*y3.^5 + (-0.000921005217335436).*x3.^12.*y3.^6 + (0.000186935963061179).*x3.^12.*y3.^7 + (-0.00598792567811923).*x3.^11.*y3.^1 + (-0.00188513244270913).*x3.^11.*y3.^2 + (0.00103067686727741).*x3.^11.*y3.^3 + (-0.00157008016141059).*x3.^11.*y3.^4 + (0.001390473762348).*x3.^11.*y3.^5 + (0.00109690031687782).*x3.^11.*y3.^6 + (-0.000506941763481144).*x3.^11.*y3.^7 + (0.00031031344072099).*x3.^11.*y3.^8 + (0.000124429307535701).*x3.^10.*y3.^1 + (0.0029153413765893).*x3.^10.*y3.^2 + (7.07033218025586e-05).*x3.^10.*y3.^3 + (0.000801408045350607).*x3.^10.*y3.^4 + (0.000591292237064542).*x3.^10.*y3.^5 + (0.000754527158402127).*x3.^10.*y3.^6 + (-0.000583719307267534).*x3.^10.*y3.^7 + (-0.00123600788349534).*x3.^10.*y3.^8 + (0.000196875815161446).*x3.^10.*y3.^9 + (0.00380044493346123).*x3.^9.*y3.^1 + (0.00496303206577283).*x3.^9.*y3.^2 + (-0.00267240816398529).*x3.^9.*y3.^3 + (-0.0030258574453926).*x3.^9.*y3.^4 + (0.00190421447473792).*x3.^9.*y3.^5 + (0.0012009836450286).*x3.^9.*y3.^6 + (0.00186145337972818).*x3.^9.*y3.^7 + (-0.000703209181687488).*x3.^9.*y3.^8 + (-0.000935234660115079).*x3.^9.*y3.^9 + (0.000203667250888369).*x3.^9.*y3.^10 + (0.0106659639988337).*x3.^8.*y3.^1 + (-0.00818812037800784).*x3.^8.*y3.^2 + (0.000329006684597273).*x3.^8.*y3.^3 + (-8.43847741048851e-05).*x3.^8.*y3.^4 + (-0.0073445905185267).*x3.^8.*y3.^5 + (-0.00500921639770386).*x3.^8.*y3.^6 + (-0.000855893989110677).*x3.^8.*y3.^7 + (0.00449260250113669).*x3.^8.*y3.^8 + (0.00111239835699947).*x3.^8.*y3.^9 + (-0.000299650787550142).*x3.^8.*y3.^10 + (5.8708692429617e-05).*x3.^8.*y3.^11 + (0.0183627675476041).*x3.^7.*y3.^1 + (0.0181125184727566).*x3.^7.*y3.^2 + (-0.00681840801267117).*x3.^7.*y3.^3 + (-0.000815912894445721).*x3.^7.*y3.^4 + (-0.00426860641060154).*x3.^7.*y3.^5 + (-0.00276075196202092).*x3.^7.*y3.^6 + (0.00375590191450383).*x3.^7.*y3.^7 + (-0.000839040399526666).*x3.^7.*y3.^8 + (-0.00203006374062569).*x3.^7.*y3.^9 + (7.72268376568344e-05).*x3.^7.*y3.^10 + (0.000534798167576235).*x3.^7.*y3.^11 + (-0.0145730582986078).*x3.^6.*y3.^1 + (-0.0137121623908754).*x3.^6.*y3.^2 + (0.0130602077606936).*x3.^6.*y3.^3 + (0.00163484569319947).*x3.^6.*y3.^4 + (-0.00182778396568752).*x3.^6.*y3.^5 + (-0.00674064250933813).*x3.^6.*y3.^6 + (-0.00999085220932562).*x3.^6.*y3.^7 + (0.00881129178892725).*x3.^6.*y3.^8 + (0.01123021881351).*x3.^6.*y3.^9 + (-0.002926959741549).*x3.^6.*y3.^10 + (-0.00311353805189556).*x3.^6.*y3.^11 + (-0.0340904070711478).*x3.^5.*y3.^1 + (-0.00771448830115744).*x3.^5.*y3.^2 + (0.00928311812740982).*x3.^5.*y3.^3 + (0.0087639987840916).*x3.^5.*y3.^4 + (-0.00430491633941875).*x3.^5.*y3.^5 + (0.00708064555931057).*x3.^5.*y3.^6 + (0.0240704131569734).*x3.^5.*y3.^7 + (-0.00720342673496588).*x3.^5.*y3.^8 + (-0.0168505684359423).*x3.^5.*y3.^9 + (0.00198861923176935).*x3.^5.*y3.^10 + (0.00320560368638064).*x3.^5.*y3.^11 + (-0.027503182386832).*x3.^4.*y3.^1 + (-0.00292860496367932).*x3.^4.*y3.^2 + (0.0101626108596939).*x3.^4.*y3.^3 + (0.0249048463428635).*x3.^4.*y3.^4 + (0.0474148094342794).*x3.^4.*y3.^5 + (0.012438436608544).*x3.^4.*y3.^6 + (-0.0383668927215687).*x3.^4.*y3.^7 + (-0.0220578149926647).*x3.^4.*y3.^8 + (0.0048210974547012).*x3.^4.*y3.^9 + (0.00583056184722675).*x3.^4.*y3.^10 + (0.00137973202655612).*x3.^4.*y3.^11 + (0.031481464421233).*x3.^3.*y3.^1 + (-0.0229929195758871).*x3.^3.*y3.^2 + (-0.00997359896963252).*x3.^3.*y3.^3 + (-0.0171022816166191).*x3.^3.*y3.^4 + (-0.0264332100642564).*x3.^3.*y3.^5 + (0.0233909999913352).*x3.^3.*y3.^6 + (0.0144128702839588).*x3.^3.*y3.^7 + (-0.00807481128478462).*x3.^3.*y3.^8 + (0.00120993001888118).*x3.^3.*y3.^9 + (0.000694382558799458).*x3.^3.*y3.^10 + (-0.00115250368703464).*x3.^3.*y3.^11 + (0.0593338253821483).*x3.^2.*y3.^1 + (0.051492269491724).*x3.^2.*y3.^2 + (-0.0986540182445699).*x3.^2.*y3.^3 + (-0.108642233847166).*x3.^2.*y3.^4 + (0.0357669797606521).*x3.^2.*y3.^5 + (0.0667916336666754).*x3.^2.*y3.^6 + (0.0210713242099877).*x3.^2.*y3.^7 + (-0.0141805427205494).*x3.^2.*y3.^8 + (-0.0151843652445462).*x3.^2.*y3.^9 + (0.000508695109111385).*x3.^2.*y3.^10 + (0.00229347921973128).*x3.^2.*y3.^11 + (-0.0469459016702578).*x3.^1.*y3.^1 + (-0.037157617539544).*x3.^1.*y3.^2 + (0.055095050221855).*x3.^1.*y3.^3 + (0.0237555068200844).*x3.^1.*y3.^4 + (0.0042963555912525).*x3.^1.*y3.^5 + (-0.037459003350869).*x3.^1.*y3.^6 + (-0.0400845772819634).*x3.^1.*y3.^7 + (0.0207285720583207).*x3.^1.*y3.^8 + (0.0228543689845373).*x3.^1.*y3.^9 + (-0.00374673469020785).*x3.^1.*y3.^10 + (-0.00386698346449585).*x3.^1.*y3.^11);
    end if;

end temperature_ph;
end R744_IIR_P1_1000_T233_373_Formula;
