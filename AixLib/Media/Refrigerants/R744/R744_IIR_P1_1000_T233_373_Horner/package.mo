within AixLib.Media.Refrigerants.R744;
package R744_IIR_P1_1000_T233_373_Horner "Refrigerant model for R744 using a hybrid approach with explicit horner formulas"

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
      start=0,
      nominal=0,
      min=-3.958414680723884e+05,
      max=6.915853192761162e+04),
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
      min=233.15,
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
  final constant Real idealAlpha0[8]={
      8.37304456,
      -3.70454304,
      2.5,
      1.99427042,
      0.62105248,
      0.41195293,
      1.04028922,
      0.08327678};
  final constant Real idealPhi0[8]={
      0,
      0,
      0,
      3.15163,
      6.11190,
      6.77708,
      11.32384,
      27.08792};

  redeclare function extends f_Idg
    "Dimensionless Helmholtz energy (Ideal gas contribution alpha_0)"

  algorithm
       f_Idg :=
         log(delta) +
         idealAlpha0[1] + idealAlpha0[2]*tau + idealAlpha0[3]*log(tau) +
         sum(idealAlpha0[i]*log(1 - exp(-tau*idealPhi0[i])) for i in 4:8);

  // protected
  //     final constant Integer nLog = 1;
  //     final constant Integer nPower = 2;
  //     final constant Integer nEinstein = 5;
  //     final constant Real[nLog, 2] l=[
  //         +2.50000,         1.];
  //     final constant Real[nPower, 2] p=[
  //         -6.124871062444266,         0;
  //          5.115596317997826,         1];
  //     final constant Real[nEinstein, 2] e=[
  //         +1.994270420,       -3.15163;
  //         +0.621052475,       -6.11190;
  //         +0.411952928,       -6.77708;
  //         +1.040289220,      -11.32384;
  //         +0.0832767753,     -27.08792];
  //
  // algorithm
  //
  //       f_Idg :=
  //         log(delta)
  //         + sum(l[i,1]*log(tau^l[i,2]) for i in 1:nLog)
  //         + sum(p[i,1]*tau^p[i,2] for i in 1:nPower)
  //         + sum(e[i,1]*log(1 - exp(e[i,2]*tau)) for i in 1:nEinstein);

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
  // protected
  //    Real[3] Theta = {  (1-tau) + residualNaA[i] * ((delta-1)^2)^(0.5 / residualNaBeta[i]) for i in 1:3} "Theta";
  //    Real[3] Dis = { Theta[i]^2 + residualNaB[i] * ((delta-1)^2)^(residualNaa[i]) for i in 1:3} "Dis";
  //    Real[3] Psi = { exp(-residualNaC[i] * (delta-1)^2 - residualNaD[i] * (tau-1)^2) for i in 1:3}  "Psi";
  //
  // algorithm
  //
  //  f_Res :=
  //  sum(residualPolN[i] * delta^(residualPolD[i]) * tau^(residualPolT[i]) for i in 1:7) +
  //  sum(residualExpN[i] * delta^(residualExpD[i]) * tau^(residualExpT[i]) * exp(-delta^(residualExpC[i])) for i in 1:27) +
  //  sum(residualGbsN[i] * delta^(residualGbsD[i]) * tau^(residualGbsT[i]) * exp(-residualGbsAlpha[i] * (delta - residualGbsEpsilon[i])^2 - residualGbsBeta[i] * (tau - residualGbsGamma[i])^2) for i in 1:5)+
  //  sum(residualNaN[i] * Dis[i]^(residualNab[i]) * delta * Psi[i] for i in 1:3);
protected
     final constant Real[7,3] p = [
          0.388568232032E+00,  0.000,   1.00;
          0.293854759427E+01,  0.750,   1.00;
         -0.558671885349E+01,  1.000,   1.00;
         -0.767531995925E+00,  2.000,   1.00;
          0.317290055804E+00,  0.750,   2.00;
          0.548033158978E+00,  2.000,   2.00;
          0.122794112203E+00,  0.750,   3.00];
     final constant Real[27,4] b = [
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
     final constant Real[3,12] a = [
         -0.666422765408E+00,  0.000,   1.00,    2, 2,  0.875,  0.300, 0.70, 10.0, 275., 0.3, 3.5;
          0.726086323499E+00,  0.000,   1.00,    2, 2,  0.925,  0.300, 0.70, 10.0, 275., 0.3, 3.5;
          0.550686686128E-01,  0.000,   1.00,    2, 2,  0.875,  0.300, 0.70, 12.5, 275., 1.0, 3.];

     Real[3] Psi = {exp(-a[i,9]*(delta-1)^2 -a[i,10]*(tau-1)^2) for i in 1:3} "Psi";
     Real[3] Theta = {(1-tau) + a[i,8]*((delta-1)^2)^(0.5/a[i,7]) for i in 1:3} "Theta";
     Real[3] Dis = {Theta[i]^2 +a[i,11]*((delta-1)^2)^a[i,12] for i in 1:3} "Distance function";
     Real[3] Disb = {Dis[i]^a[i,6] for i in 1:3} "Distance function to the power of b";

  algorithm
     f_Res :=
       sum(p[i,1]*tau^p[i,2]*delta^p[i,3] for i in 1:7)
     + sum(b[i,1]*tau^b[i,2]*delta^b[i,3]*exp(-delta^b[i,4]) for i in 1:27)
     + sum(g[i,1]*tau^g[i,2]*delta^g[i,3]*exp(g[i,6]*(delta - g[i,9])^g[i,4] + g[i,7]*(tau - g[i,8])^g[i,5]) for i in 1:5)
     + sum(a[i,1]*Disb[i]*delta*Psi[i] for i in 1:3);

  end f_Res;

 redeclare function extends t_fIdg_t
    "Short form for tau*(dalpha_0/dtau)_delta=const"
 algorithm
   t_fIdg_t :=
   tau * idealAlpha0[2] + idealAlpha0[3] +
   tau * sum(idealAlpha0[i] * idealPhi0[i] *((1-exp(-tau*idealPhi0[i]))^(-1) -1) for i in 4:8);

 // protected
 //   final constant Real[1, 2] l=[+2.50000,         1.];
 //   final constant Real[2, 2] p=[
 //       -6.124871062444266,         0;
 //        5.115596317997826,         1];
 //   final constant Real[5, 2] e=[
 //       +1.994270420,       -3.15163;
 //       +0.621052475,       -6.11190;
 //       +0.411952928,       -6.77708;
 //       +1.040289220,      -11.32384;
 //       +0.0832767753,     -27.08792];
 //
 // algorithm
 //   t_fIdg_t :=
 //       sum((l[i,1]*l[i,2]) for i in 1:1)
 //     + sum(p[i,1]*tau^(p[i,2])*p[i,2] for i in 1:2)
 //     + sum(tau*(e[i,1]*(-e[i,2])*((1 - exp(e[i,2]*tau))^(-1) - 1)) for i in 1:5);

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

// protected
//   final constant Real[7,3] p = [0.388568232032E+00,  0.000,   1.00;
//        0.293854759427E+01,  0.750,   1.00;
//       -0.558671885349E+01,  1.000,   1.00;
//       -0.767531995925E+00,  2.000,   1.00;
//        0.317290055804E+00,  0.750,   2.00;
//        0.548033158978E+00,  2.000,   2.00;
//        0.122794112203E+00,  0.750,   3.00];
//   final constant Real[27,4] b = [
//        0.216589615432E+01,  1.500,   1.00,    1;
//        0.158417351097E+01,  1.500,   2.00,    1;
//       -0.231327054055E+00,  2.500,   4.00,    1;
//        0.581169164314E-01,  0.000,   5.00,    1;
//       -0.553691372054E+00,  1.500,   5.00,    1;
//        0.489466159094E+00,  2.000,   5.00,    1;
//       -0.242757398435E-01,  0.000,   6.00,    1;
//        0.624947905017E-01,  1.000,   6.00,    1;
//       -0.121758602252E+00,  2.000,   6.00,    1;
//       -0.370556852701E+00,  3.000,   1.00,    2;
//       -0.167758797004E-01,  6.000,   1.00,    2;
//       -0.119607366380E+00,  3.000,   4.00,    2;
//       -0.456193625088E-01,  6.000,   4.00,    2;
//        0.356127892703E-01,  8.000,   4.00,    2;
//       -0.744277271321E-02,  6.000,   7.00,    2;
//       -0.173957049024E-02,  0.000,   8.00,    2;
//       -0.218101212895E-01,  7.000,   2.00,    3;
//        0.243321665592E-01, 12.000,   3.00,    3;
//       -0.374401334235E-01, 16.000,   3.00,    3;
//        0.143387157569E+00, 22.000,   5.00,    4;
//       -0.134919690833E+00, 24.000,   5.00,    4;
//       -0.231512250535E-01, 16.000,   6.00,    4;
//        0.123631254929E-01, 24.000,   7.00,    4;
//        0.210583219729E-02,  8.000,   8.00,    4;
//       -0.339585190264E-03,  2.000,  10.00,    4;
//        0.559936517716E-02, 28.000,   4.00,    5;
//       -0.303351180556E-03, 14.000,   8.00,    6];
//   final constant Real[5,9] g = [
//       -0.213654886883E+03,  1.000,   2.00,    2, 2,  -25.,  -325.,  1.16, 1.;
//        0.266415691493E+05,  0.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
//       -0.240272122046E+05,  1.000,   2.00,    2, 2,  -25.,  -300.,  1.19, 1.;
//       -0.283416034240E+03,  3.000,   3.00,    2, 2,  -15.,  -275.,  1.25, 1.;
//        0.212472844002E+03,  3.000,   3.00,    2, 2,  -20.,  -275.,  1.22, 1.];
//   final constant Real[3,12] a = [
//       -0.666422765408E+00,  0.000,   1.00,    2, 2,  0.875,  0.300, 0.70, 10.0, 275., 0.3, 3.5;
//        0.726086323499E+00,  0.000,   1.00,    2, 2,  0.925,  0.300, 0.70, 10.0, 275., 0.3, 3.5;
//        0.550686686128E-01,  0.000,   1.00,    2, 2,  0.875,  0.300, 0.70, 12.5, 275., 1.0, 3.];
//
//   Real[3] Psi = {exp(-a[i,9]*(delta-1)^2 -a[i,10]*(tau-1)^2) for i in 1:3} "Psi";
//   Real[3] Theta = {(1-tau) + a[i,8]*((delta-1)^2)^(0.5/a[i,7]) for i in 1:3} "Theta";
//   Real[3] Dis = {Theta[i]^2 +a[i,11]*((delta-1)^2)^a[i,12] for i in 1:3} "Distance function";
//   Real[3] Disb = {Dis[i]^a[i,6] for i in 1:3} "Distance function to the power of b";
//
//   Real[3] Psi_t = {-a[i,10]*(2*tau-2)*Psi[i] for i in 1:3};
//   Real[3] Theta_t = {-1 for i in 1:3};
//   Real[3] Dis_t = {2*Theta[i]*Theta_t[i] for i in 1:3};
//   Real[3] Disb_t = {if Dis[i]<>0 then a[i,6]*Dis[i]^(a[i,6]-1)*Dis_t[i] else 0 for i in 1:3};
//
// algorithm
//   t_fRes_t :=
//       sum(p[i,1]*p[i,2]*tau^(p[i,2])*delta^p[i,3] for i in 1:7)
//     + sum(b[i,1]*b[i,2]*tau^(b[i,2])*delta^b[i,3]*exp(-delta^b[i,4]) for i in 1:27)
//     + sum(tau*g[i,1]*tau^g[i,2]*delta^g[i,3]*exp(g[i,6]*(delta - g[i,9])^2 + g[i,7]*(tau - g[i,8])^2)*(g[i,2]/tau + 2*g[i,7]*(tau - g[i,8])) for i in 1:5)
//     + sum(tau*a[i,1]*delta*(Disb[i]*Psi_t[i] + Psi[i]*Disb_t[i]) for i in 1:3);

protected
     Real[3] Theta = {  (1-tau) + residualNaA[i] * ((delta-1)^2)^(0.5 / residualNaBeta[i]) for i in 1:3} "Theta";
     Real[3] Dis = { Theta[i]^2 + residualNaB[i] * ((delta-1)^2)^(residualNaa[i]) for i in 1:3} "Dis";
     Real[3] Psi = { exp(-residualNaC[i] * (delta-1)^2 - residualNaD[i] * (tau-1)^2) for i in 1:3}  "Psi";
algorithm
     t_fRes_t :=
     sum(residualPolN[i] * residualPolT[i] * delta^(residualPolD[i]) * tau^(residualPolT[i]) for i in 1:7) +
     sum(residualExpN[i] * residualExpT[i] * delta^(residualExpD[i]) * tau^(residualExpT[i]) * exp(-delta^(residualExpC[i])) for i in 1:27) +
     sum(residualGbsN[i] * delta^(residualGbsD[i]) * tau^(residualGbsT[i]) * exp(-residualGbsAlpha[i]*(delta-residualGbsEpsilon[i])^2 - residualGbsBeta[i] * (tau - residualGbsGamma[i])^2) * (residualGbsT[i] - 2*tau*residualGbsBeta[i]*(tau-residualGbsGamma[i])) for i in 1:5)+
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
// protected
//      Real[3] Theta = {  (1-tau) + residualNaA[i] * ((delta-1)^2)^(0.5 / residualNaBeta[i]) for i in 1:3} "Theta";
//      Real[3] Dis = { Theta[i]^2 + residualNaB[i] * ((delta-1)^2)^(residualNaa[i]) for i in 1:3} "Theta";
//      Real[3] Psi = { exp(-residualNaC[i] * (delta-1)^2 - residualNaD[i] * (tau-1)^2) for i in 1:3}  "Psi";
//      Real[3] Psi_d= { -2*residualNaC[i] * (delta-1)*Psi[i] for i in 1:3} "(dPsi/dd)";
//      Real[3] Dis_d= { (delta-1) * ( residualNaA[i] * Psi[i] * 0.5 * residualNaBeta[i] * ((delta-1)^2)^((0.5/residualNaBeta[i])-1) + 2*residualNaB[i]*residualNaa[i]*((delta-1)^2)^(residualNaa[i]-1)) for i in 1:3} "(dDis/dd)";
//      Real[3] Dis_d_b = { residualNab[i] * Dis[i]^(residualNab[i]-1) * Dis_d[i] for i in 1:3} "(dDis^b/dd)";
// algorithm
//    d_fRes_d :=
//    sum(residualPolN[i] * residualPolD[i] * delta^(residualPolD[i]) * tau^(residualPolT[i]) for i in 1:7) +
//    sum(residualExpN[i] * exp(-delta ^ (residualExpC[i])) * (delta^(residualExpD[i]) * tau^(residualExpT[i]) * (residualExpD[i]-residualExpC[i]*delta^(residualExpC[i]))) for i in 1:27) +
//    sum(residualGbsN[i] * delta^(residualGbsD[i]+1) * tau^(residualGbsT[i]) * exp(-residualGbsAlpha[i] * (delta-residualGbsEpsilon[i])^2 - residualGbsBeta[i]*(tau-residualGbsGamma[i])^2) * ((residualGbsD[i] / delta) - 2*residualGbsAlpha[i] * (delta-residualGbsEpsilon[i])) for i in 1:5) +
//    sum(residualNaN[i] * delta * ( Dis[i]^(residualNab[i]) * ( Psi[i]+delta*Psi_d[i])  + Dis_d_b[i] * delta * Psi_d[i]) for i in 1:3);
protected
   final constant Real[7,3] p = [
        0.388568232032E+00,  0.000,   1.00;
        0.293854759427E+01,  0.750,   1.00;
       -0.558671885349E+01,  1.000,   1.00;
       -0.767531995925E+00,  2.000,   1.00;
        0.317290055804E+00,  0.750,   2.00;
        0.548033158978E+00,  2.000,   2.00;
        0.122794112203E+00,  0.750,   3.00];
   final constant Real[27,4] b = [
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
   final constant Real[3,12] a = [
       -0.666422765408E+00,  0.000,   1.00,    2, 2,  0.875,  0.300, 0.70, 10.0, 275., 0.3, 3.5;
        0.726086323499E+00,  0.000,   1.00,    2, 2,  0.925,  0.300, 0.70, 10.0, 275., 0.3, 3.5;
        0.550686686128E-01,  0.000,   1.00,    2, 2,  0.875,  0.300, 0.70, 12.5, 275., 1.0, 3.];
   final constant Integer nPoly=7;
   final constant Integer nBwr=27;
   final constant Integer nGauss=5;
   final constant Integer nNonAna=3;

   Real[nNonAna] Psi = {exp(-a[i,9]*(delta-1)^2 -a[i,10]*(tau-1)^2) for i in 1:nNonAna} "Psi";
   Real[nNonAna] Theta = {(1-tau) + a[i,8]*((delta-1)^2)^(0.5/a[i,7]) for i in 1:nNonAna} "Theta";
   Real[nNonAna] Dis = {Theta[i]^2 +a[i,11]*((delta-1)^2)^a[i,12] for i in 1:nNonAna} "Distance function";
   Real[nNonAna] Disb = {Dis[i]^a[i,6] for i in 1:nNonAna} "Distance function to the power of b";

   Real[nNonAna] Psi_d = {-a[i,9]*(2*delta-2)*Psi[i] for i in 1:nNonAna};
   Real[nNonAna] Theta_d = {if (delta-1)<>0 then (a[i,8]*(2*delta-2)*((delta-1)^2)^(0.5/a[i,7])) / (2*a[i,7]*(delta-1)^2) else 0 for i in 1:nNonAna};
   Real[nNonAna] Dis_d = {if (delta-1)<>0 then (2*a[i,11]*a[i,12]*((delta-1)^2)^a[i,12]) / (delta-1) +2*Theta[i]*Theta_d[i] else 0 for i in 1:nNonAna};
   Real[nNonAna] Disb_d = {if Dis[i]<>0 then a[i,6]*Dis[i]^(a[i,6]-1)*Dis_d[i] else 0 for i in 1:nNonAna};

algorithm
   d_fRes_d :=
       sum(p[i,1]*p[i,3]*delta^(p[i,3])*tau^p[i,2] for i in 1:nPoly)
     + sum(delta*(b[i,1]*exp(-delta^b[i,4])*(delta^(b[i,3] - 1)*tau^b[i,2]*(b[i,3] - b[i,4]*delta^b[i,4]))) for i in 1:nBwr)
     + sum(delta*(g[i,1]*delta^g[i,3]*tau^g[i,2]*exp(g[i,6]*(delta - g[i,9])^2 + g[i,7]*(tau - g[i,8])^2)*(g[i,3]/delta + 2*g[i,6]*(delta - g[i,9]))) for i in 1:nGauss)
     + sum(delta*(a[i,1]*(delta*Disb[i]*Psi_d[i] + delta*Psi[i]*Disb_d[i] + Disb[i]*Psi[i])) for i in 1:nNonAna);

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
  Real OM=abs(1 - T/304.1282);

algorithm
  if T>304.1282 then //if T >= 304.1282 then
    p := 7377300;
  elseif T <= 216.55 then
    p := 518000;
  else
    p := 7377300*exp((304.1282/T)*((-10.8874701459618) .* (OM) .^ (1.02777903636517) + (-2.53014476472302)
       .* (OM) .^ (3.04857880618312) + (4.85976334934365) .* (OM) .^ (1.12780675832611)));
  end if;
end saturationPressure;

redeclare function extends saturationTemperature
    "Saturation temperature of refrigerant (Ancillary equation)"
protected
  Real x;
algorithm
  if p >=  7377300 then
    T:= 304.1282;
  elseif p <= 518000 then
    T :=216.55;
  else
  x := (p - 3445540.85867591) ./ 1822725.70538495;
  T :=268.600000000000 + 20.5103632342287 * (x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*(x*((-1.06584203525244e-06)
      *x + (5.77175283129492e-06)) + (-4.6244025542171e-06)) + (-1.55649714573718e-05))
       + (-5.67729643824132e-06)) + (7.84687400408321e-05)) + (2.54822197136637e-05))
       + (-0.000123533921282085)) + (-0.000337725889546381)) + (0.000675120780717472))
       + (-0.000400215031011729)) + (0.00114310539368957)) + (-0.00369132626395774))
       + (0.00842457137711057)) + (-0.020714524035119)) + (0.0563877648731632)) +
      (-0.189436119639029)) + (0.971452596229363)) + (0.200822882160402));

  end if;
end saturationTemperature;

redeclare function extends bubbleDensity
    "Boiling curve specific density of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x := abs(1 - (sat.Tsat ./ 304.128200000000));
    dl := (478.968682010804 + (495.683257706123).*x.^(1/3) + (3543.67960624232).*x.^(2/3) + (-16584.0906529594).*x.^(3/3) + (39329.3130708854).*x.^(4/3) + (7445.88449470718).*x.^(5/3) + (-254232.892949454).*x.^(6/3) + (489081.275821062).*x.^(7/3) + (-51539.65263982).*x.^(8/3) + (-948816.669406408).*x.^(9/3) + (1205337.05384885).*x.^(10/3) + (-479896.34391407).*x.^(11/3));

end bubbleDensity;

redeclare function extends dewDensity
    "Dew curve specific density of refrigerant (Ancillary equation)"
protected
    Real x;
algorithm
    x := abs(1 - (sat.Tsat ./ 304.128200000000));
    dv := (462.48836810312 + (-610.315494915381).*x.^(1/3) + (-2823.72517117551).*x.^(2/3) + (16650.8365223046).*x.^(3/3) + (-49525.3789777128).*x.^(4/3) + (52571.1979874299).*x.^(5/3) + (74412.4761984176).*x.^(6/3) + (-159900.265678589).*x.^(7/3) + (-119473.839067579).*x.^(8/3) + (203760.826571182).*x.^(9/3) + (280692.836303772).*x.^(10/3) + (40256.3509590889).*x.^(11/3) + (-336116.042618752).*x.^(12/3) + (-570463.466661569).*x.^(13/3) + (-382871.321141713).*x.^(14/3) + (211234.622165815).*x.^(15/3) + (1120586.29646474).*x.^(16/3) + (2579594.67174698).*x.^(17/3) + (-856309.127058874).*x.^(18/3) + (-1480616.80660559).*x.^(19/3) + (-1952678.05291741).*x.^(20/3) + (-1966218.66650212).*x.^(21/3) + (-1411789.30657025).*x.^(22/3) + (204923.572495633).*x.^(23/3) + (7059952.78039912).*x.^(24/3));
end dewDensity;

redeclare function extends bubbleEnthalpy
    "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x;
    Real hl_IIR;
algorithm
    x := sat.psat ./ 7377300;
    if x >= 1 then
      x:=7.377284304216208e+06 ./ 7377300;
    end if;
    hl_IIR := 194327.316977888 .* exp((1./x) .* ((-0.769139700781037).*(1-x).^(0.722830089188778) + (0.460882432656297).*(1-x).^(-0.0152191856879518) + (0.22272419609671).*(1-x).^(3.00703720797531) + (0.141897620188616).*(1-x).^(50.6995880180848) + (0.0519530578466151).*(1-x).^(9.69794921193602)));
    hl :=hl_IIR - 505.8414680723884e+03;
end bubbleEnthalpy;

redeclare function extends dewEnthalpy
    "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
protected
    Real x;
    Real hv_IIR;
algorithm
    x := sat.psat ./ 7377300;
    hv_IIR := 424562.952802457.*(-103.443830399603 + (798.531276359906).*x.^(1/3) + (-2016.96831340003).*x.^(2/3) + (839.988263280569).*x.^(3/3) + (4278.00109616943).*x.^(4/3) + (-6098.57015815342).*x.^(5/3) + (1780.68613765026).*x.^(6/3) + (-2418.01704526953).*x.^(7/3) + (6114.3000653877).*x.^(8/3) + (-2318.06423869379).*x.^(9/3) + (644.02003265782).*x.^(10/3) + (-2758.10371042978).*x.^(11/3) + (-1473.01876196517).*x.^(12/3) + (4497.50879221731).*x.^(13/3) + (-1240.70114507868).*x.^(14/3) + (-620.781932531012).*x.^(15/3) + (-3613.82139176729).*x.^(16/3) + (5608.17107066454).*x.^(17/3) + (463.44851295393).*x.^(18/3) + (-3248.00120191089).*x.^(19/3) + (-976.409582464897).*x.^(20/3) + (-304.50206372898).*x.^(21/3) + (9048.69452029705).*x.^(22/3) + (-2424.01900336071).*x.^(23/3) + (-10138.6108741398).*x.^(24/3) + (8364.19417557509).*x.^(25/3) + (-4076.27821934385).*x.^(26/3) + (-4174.91489500871).*x.^(27/3) + (-290.125169860409).*x.^(28/3) + (3529.10689732294).*x.^(29/3) + (5173.96993434184).*x.^(30/3) + (3635.30103017327).*x.^(31/3) + (-3504.65733876607).*x.^(32/3) + (3004.55491495939).*x.^(33/3) + (-2241.40409555241).*x.^(34/3) + (-5682.56832761244).*x.^(35/3) + (-7158.70194114246).*x.^(36/3) + (1460.05936697027).*x.^(37/3) + (8502.97020219723).*x.^(38/3) + (5568.34835163651).*x.^(39/3) + (-6429.35768622983).*x.^(40/3));
    hv :=hv_IIR - 505.8414680723884e+03;
end dewEnthalpy;

redeclare function extends bubbleEntropy
    "Boiling curve specific entropy of refrigerant (Ancillary equation)"
protected
    Real x;
    Real sl_IIR;
algorithm
  x := sat.psat ./ 7377300;
  if x >= 1 then
      x:=7.377284304216208e+06 ./ 7377300;
    end if;
  sl_IIR := 971.502865291826 .* exp((1./x) .* ((0.332362265133049).*(1-x).^(-0.0157738143026104) + (-0.53827965447008).*(1-x).^(0.710529444013852) + (0.0376198585567208).*(1-x).^(10.3660660062362) + (0.146071000768772).*(1-x).^(3.14098135792114)));
  sl :=sl_IIR - 2.736808957627727E3;
end bubbleEntropy;

redeclare function extends dewEntropy
    "Dew curve specific entropy of refrigerant (Ancillary equation)"
protected
    Real x;
    Real sv_IIR;
algorithm
  x := sat.psat ./ 7377300;
  if x >= 1 then
      x:=7.377284304216208e+06 ./ 7377300;
    end if;
  sv_IIR := 1852.51697191582 .* exp((1./x) .* ((-0.104686424493378).*(1-x).^(1.91767692218586) + (-0.231351021595994).*(1-x).^(-0.00970758719031325) + (0.350507795905541).*(1-x).^(0.456797862631896) + (-0.0111283896749802).*(1-x).^(8.11458177168435)));
  sv :=sv_IIR - 2.736808957627727E3;
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
    Real h_IIR;

algorithm
    h_IIR :=h + 505.8414680723884e+03;
    h_dew := dewEnthalpy(sat = setSat_p(p=p))+505.8414680723884e+03;
    h_bubble := bubbleEnthalpy(sat = setSat_p(p=p))+505.8414680723884e+03;
    x_scr := (p-8689000) / 757339.201855197;
    h_scr := 284773.077243989 + 8625.39176119581 * ( x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*((-0.00935823150820951)*x_scr + (0.0112418969238134)) + (0.116029826531554)) + (-0.130769568314684)) + (-0.606654645116181)) + (0.634400227016547)) + (1.73431739837587)) + (-1.65772169673076)) + (-2.94309246578317)) + (2.5191621143989)) + (3.01031299057939)) + (-2.23879529796539)) + (-1.8049309139747)) + (1.11768878334674)) + (0.571531783870116)) + (-0.251951854627595)) + (-0.142034551199029)) + (0.192604296642739)) + (-0.686038150275524)) + (-0.26968374724995));
    if p<7377300 then
      if h_IIR<h_bubble-dh then //SC
        x1 := (p-6097764.94682380) / 2585452.16490808;
        y1 := (h_IIR-153365.801954585) / 65673.4529788826;
        T := 250.119094022263 + 27.8301755311303 * ( y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(-9.41546201977270e-05*y1  -0.000259913572675876+0.00114111755205254*x1) + 0.00812800759555890 + x1*(-0.00208685488221609*x1-0.00888450759269475))  -0.0381143725065783 + x1*(0.0112452499058972*x1+0.0278960316992357)) + 0.0708210077537962 + x1*(-0.0196830066253284*x1-0.0394466728409158))  -0.0331034211216830 + x1*(0.00266275029347203*x1+0.0147652303732295))  -0.0619825116126630 + x1*(0.0298953638879228*x1+0.0181578424828338)) + 0.0661811304570504 + x1*(-0.0270609660358611*x1 -0.0100341747271017)) + 0.00879891946010096 + x1*(-0.00807933082815375*x1  -0.00184545542883243))  -0.0562686778415428 + x1*(0.0148022794963983*x1 + 0.00568705359482330))  -0.0703431345975040 + x1*(-0.00137103728603173*x1 + 0.0134565003032703)) + 1.14592228930160 + x1*(-0.00459360679387857*x1 + 0.0267940317659499))+x1*(-0.00204989599989688*x1+0.00389756589392757)+0.0984832309267652);
      elseif h_IIR>h_dew+dh then //SH
        x2 := (p-4742415.01272265)/2338206.42191283;
        y2 := (h_IIR-485679.617572220)/49740.9272100767;
        T := 325.770836615015 + 45.8537417710473 * ( x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*((-3.20429644832931e-05)*x2 + (-0.000117019357467813) + (-0.00116092378210656)*y2) + (0.00111300232860791) + y2*((-0.00298788587186705)*y2 + (-0.00233608836377314))) + (0.00242118584189930) + y2*(y2*((-0.00568837228275852)*y2 + (-0.00133146318650065)) + (0.00806608261834735)))  + (-0.00584990443240667) + y2*(y2*(y2*((0.000208301251904854)*y2 + (-0.0145834870786212)) + (0.0257266792132771)) + (0.0185469324339728)))  + (-0.0112129614107892) + y2*(y2*(y2*(y2*((0.00132457553597643)*y2 + (-0.00176016596448422)) + (0.0180795600719053)) + (0.0131347761181012)) + (-0.0165728737378510)))  + (0.0136176749179793) + y2*(y2*(y2*(y2*(y2*((5.20988964635086e-05)*y2 + (0.00289939602202290)) + (-0.00575732208592028)) + (0.0619474741849220)) + (-0.0777820483376422)) + (-0.0490929689741519)))  + (0.0227130869300610) + y2*(y2*(y2*(y2*(y2*(y2*((-6.00904996718504e-05)*y2 + (5.51773352489347e-05)) + (-0.00363140821310015)) + (0.00393767013775708)) + (-0.0200555153646824)) + (-0.0318185996209532)) + (0.0107088107250875)))  + (-0.0168720406747937) + y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000159484042662665)*y2 + (-0.000478722193048678)) + (-0.000510794675874849)) + (-0.00902205584903315)) + (0.0177109878896820)) + (-0.101410426217775)) + (0.116211454372248)) + (0.0564015649305773)))  + (-0.0236760630222917) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000185649477412129)*y2 + (0.000565553736578638)) + (-0.00279434195063629)) + (0.000582968772193570)) + (0.00721355108320489)) + (-0.00313612659494668)) + (0.0113064405062100)) + (0.0274642225330768)) + (0.00165601255693273)))  + (0.0105752427479749) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000353019886328202)*y2 + (-0.000301527813376657)) + (-0.00165289152199580)) + (0.000707730613885534)) + (0.00369435121533928)) + (0.0127657381034912)) + (-0.0217028472001825)) + (0.0735659308834566)) + (-0.0926726814977050)) + (-0.0237743395012459)))  + (0.0132656103773099) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000379524824737720)*y2 + (-0.00137226225896949)) + (0.00114045574733164)) + (-0.00173556260432616)) + (0.00501342324148632)) + (-0.000791594933192776)) + (-0.00431833380078860)) + (0.00123472853074749)) + (-0.0163674489867880)) + (-0.00379412653336120)) + (0.00200090742302188)))  + (-0.00176224711211021) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((8.78046888345559e-05)*y2 + (-0.000700754393245700)) + (0.000998864592646648)) + (-0.000608254569666560)) + (0.00273322888722273)) + (-0.000963184828529965)) + (-0.00590910281966607)) + (-0.00556082895705846)) + (0.00862362389750097)) + (-0.0187682285365427)) + (0.0387517167083185)) + (-0.00518905655947852)))  + (-0.00461920614601444) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((4.95666855068354e-05)*y2 + (-0.00112358749371662)) + (0.00366757356902761)) + (-0.00271032446076790)) + (-0.00258555229224404)) + (0.00224153137219189)) + (0.00852496642629238)) + (-0.0168402572851104)) + (-0.00602505449699182)) + (0.0338321480469933)) + (-0.00513202654010906)) + (-0.0108537264305888)))  + (0.00274245407717317) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((-0.000779545644811908)*y2 + (0.00495906324016952)) + (-0.00869557457099743)) + (-0.000495536068926341)) + (0.00980435683857743)) + (0.00201976666145268)) + (-0.00593874435918624)) + (-0.00780964044175517)) + (0.00891459432121028)) + (0.000415552432675825)) + (-0.00609103745602836)) + (0.000904216747891165)))  + (-0.0427212246316783) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.00125819952363372)*y2 + (-0.00643247113942379)) + (0.00850206980246039)) + (0.00594081462490066)) + (-0.0163567605252973)) + (-0.000433840684470545)) + (6.09276078122551e-05)) + (0.0194955159561419)) + (0.00618076894733697)) + (-0.0256234101385242))+ (-0.0125696480634520)) + (0.0415192402574172)))  + (0.444339343950006) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((-0.000822508284396234)*y2 + (0.00381965826823239)) + (-0.00469195213648668)) + (-0.00400769308934593)) + (0.0153938291781470)) + (-0.0118328037065763)) + (-0.00825234493717037)) + (0.0191596225278170)) + (-0.00793609151097170)) + (-0.00105100101152042)) + (0.0204087567923358)) + (-0.140009686882945)))  + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000206196177257671)*y2 + (-0.000915758584624007)) + (0.00121343128586345)) + (0.000974745324996649)) + (-0.00611036225015518)) + (0.00627822681033568)) + (0.00746574972430255)) + (-0.0145584955227089)) + (0.00236628672143450)) + (-0.0192570270037383)) + (0.0965962834229711)) + (0.837110380684298)) + (-0.0314099744127785));
      elseif h_IIR<h_bubble then //SC + smooth
        x1 := (p-6097764.94682380) / 2585452.16490808;
        y1 := (h_IIR-153365.801954585) / 65673.4529788826;
        T1 := 250.119094022263 + 27.8301755311303 * ( y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(-9.41546201977270e-05*y1  -0.000259913572675876+0.00114111755205254*x1) + 0.00812800759555890 + x1*(-0.00208685488221609*x1-0.00888450759269475))  -0.0381143725065783 + x1*(0.0112452499058972*x1+0.0278960316992357)) + 0.0708210077537962 + x1*(-0.0196830066253284*x1-0.0394466728409158))  -0.0331034211216830 + x1*(0.00266275029347203*x1+0.0147652303732295))  -0.0619825116126630 + x1*(0.0298953638879228*x1+0.0181578424828338)) + 0.0661811304570504 + x1*(-0.0270609660358611*x1 -0.0100341747271017)) + 0.00879891946010096 + x1*(-0.00807933082815375*x1  -0.00184545542883243))  -0.0562686778415428 + x1*(0.0148022794963983*x1 + 0.00568705359482330))  -0.0703431345975040 + x1*(-0.00137103728603173*x1 + 0.0134565003032703)) + 1.14592228930160 + x1*(-0.00459360679387857*x1 + 0.0267940317659499))+x1*(-0.00204989599989688*x1+0.00389756589392757)+0.0984832309267652);
        T := saturationTemperature(p) * (1-(h_bubble-h_IIR)/dh) + T1*(h_bubble - h_IIR) / dh;
      elseif h_IIR>h_dew then //SH + smooth
        x2 := (p-4742415.01272265)/2338206.42191283;
        y2 := (h_IIR-485679.617572220)/49740.9272100767;
        T2 := 325.770836615015 + 45.8537417710473 * ( x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*((-3.20429644832931e-05)*x2 + (-0.000117019357467813) + (-0.00116092378210656)*y2) + (0.00111300232860791) + y2*((-0.00298788587186705)*y2 + (-0.00233608836377314))) + (0.00242118584189930) + y2*(y2*((-0.00568837228275852)*y2 + (-0.00133146318650065)) + (0.00806608261834735)))  + (-0.00584990443240667) + y2*(y2*(y2*((0.000208301251904854)*y2 + (-0.0145834870786212)) + (0.0257266792132771)) + (0.0185469324339728)))  + (-0.0112129614107892) + y2*(y2*(y2*(y2*((0.00132457553597643)*y2 + (-0.00176016596448422)) + (0.0180795600719053)) + (0.0131347761181012)) + (-0.0165728737378510)))  + (0.0136176749179793) + y2*(y2*(y2*(y2*(y2*((5.20988964635086e-05)*y2 + (0.00289939602202290)) + (-0.00575732208592028)) + (0.0619474741849220)) + (-0.0777820483376422)) + (-0.0490929689741519)))  + (0.0227130869300610) + y2*(y2*(y2*(y2*(y2*(y2*((-6.00904996718504e-05)*y2 + (5.51773352489347e-05)) + (-0.00363140821310015)) + (0.00393767013775708)) + (-0.0200555153646824)) + (-0.0318185996209532)) + (0.0107088107250875)))  + (-0.0168720406747937) + y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000159484042662665)*y2 + (-0.000478722193048678)) + (-0.000510794675874849)) + (-0.00902205584903315)) + (0.0177109878896820)) + (-0.101410426217775)) + (0.116211454372248)) + (0.0564015649305773)))  + (-0.0236760630222917) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000185649477412129)*y2 + (0.000565553736578638)) + (-0.00279434195063629)) + (0.000582968772193570)) + (0.00721355108320489)) + (-0.00313612659494668)) + (0.0113064405062100)) + (0.0274642225330768)) + (0.00165601255693273)))  + (0.0105752427479749) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000353019886328202)*y2 + (-0.000301527813376657)) + (-0.00165289152199580)) + (0.000707730613885534)) + (0.00369435121533928)) + (0.0127657381034912)) + (-0.0217028472001825)) + (0.0735659308834566)) + (-0.0926726814977050)) + (-0.0237743395012459)))  + (0.0132656103773099) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000379524824737720)*y2 + (-0.00137226225896949)) + (0.00114045574733164)) + (-0.00173556260432616)) + (0.00501342324148632)) + (-0.000791594933192776)) + (-0.00431833380078860)) + (0.00123472853074749)) + (-0.0163674489867880)) + (-0.00379412653336120)) + (0.00200090742302188)))  + (-0.00176224711211021) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((8.78046888345559e-05)*y2 + (-0.000700754393245700)) + (0.000998864592646648)) + (-0.000608254569666560)) + (0.00273322888722273)) + (-0.000963184828529965)) + (-0.00590910281966607)) + (-0.00556082895705846)) + (0.00862362389750097)) + (-0.0187682285365427)) + (0.0387517167083185)) + (-0.00518905655947852)))  + (-0.00461920614601444) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((4.95666855068354e-05)*y2 + (-0.00112358749371662)) + (0.00366757356902761)) + (-0.00271032446076790)) + (-0.00258555229224404)) + (0.00224153137219189)) + (0.00852496642629238)) + (-0.0168402572851104)) + (-0.00602505449699182)) + (0.0338321480469933)) + (-0.00513202654010906)) + (-0.0108537264305888)))  + (0.00274245407717317) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((-0.000779545644811908)*y2 + (0.00495906324016952)) + (-0.00869557457099743)) + (-0.000495536068926341)) + (0.00980435683857743)) + (0.00201976666145268)) + (-0.00593874435918624)) + (-0.00780964044175517)) + (0.00891459432121028)) + (0.000415552432675825)) + (-0.00609103745602836)) + (0.000904216747891165)))  + (-0.0427212246316783) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.00125819952363372)*y2 + (-0.00643247113942379)) + (0.00850206980246039)) + (0.00594081462490066)) + (-0.0163567605252973)) + (-0.000433840684470545)) + (6.09276078122551e-05)) + (0.0194955159561419)) + (0.00618076894733697)) + (-0.0256234101385242))+ (-0.0125696480634520)) + (0.0415192402574172)))  + (0.444339343950006) + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((-0.000822508284396234)*y2 + (0.00381965826823239)) + (-0.00469195213648668)) + (-0.00400769308934593)) + (0.0153938291781470)) + (-0.0118328037065763)) + (-0.00825234493717037)) + (0.0191596225278170)) + (-0.00793609151097170)) + (-0.00105100101152042)) + (0.0204087567923358)) + (-0.140009686882945)))  + y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.000206196177257671)*y2 + (-0.000915758584624007)) + (0.00121343128586345)) + (0.000974745324996649)) + (-0.00611036225015518)) + (0.00627822681033568)) + (0.00746574972430255)) + (-0.0145584955227089)) + (0.00236628672143450)) + (-0.0192570270037383)) + (0.0965962834229711)) + (0.837110380684298)) + (-0.0314099744127785));
        T := saturationTemperature(p) * (1- (h_IIR-h_dew)/dh) + T2*(h_IIR-h_dew)/dh;
      else T := saturationTemperature(p);
    end if;
    elseif h_IIR<h_scr then //SC
        x1 := (p-6097764.94682380) / 2585452.16490808;
        y1 := (h_IIR-153365.801954585) / 65673.4529788826;
        T := 250.119094022263 + 27.8301755311303 * ( y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(-9.41546201977270e-05*y1  -0.000259913572675876+0.00114111755205254*x1) + 0.00812800759555890 + x1*(-0.00208685488221609*x1-0.00888450759269475))  -0.0381143725065783 + x1*(0.0112452499058972*x1+0.0278960316992357)) + 0.0708210077537962 + x1*(-0.0196830066253284*x1-0.0394466728409158))  -0.0331034211216830 + x1*(0.00266275029347203*x1+0.0147652303732295))  -0.0619825116126630 + x1*(0.0298953638879228*x1+0.0181578424828338)) + 0.0661811304570504 + x1*(-0.0270609660358611*x1 -0.0100341747271017)) + 0.00879891946010096 + x1*(-0.00807933082815375*x1  -0.00184545542883243))  -0.0562686778415428 + x1*(0.0148022794963983*x1 + 0.00568705359482330))  -0.0703431345975040 + x1*(-0.00137103728603173*x1 + 0.0134565003032703)) + 1.14592228930160 + x1*(-0.00459360679387857*x1 + 0.0267940317659499))+x1*(-0.00204989599989688*x1+0.00389756589392757)+0.0984832309267652);
    elseif h_IIR>h_scr then //SCr
        x3 := (p-8180784.97222942)/876732.836302901;
        y3 := (h_IIR-441803.785720452)/85518.0223361212;
        T  :=  342.072675763187 + 33.8095274165374 * ( x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*(x3*((-0.000134960473379243)*x3 + (0.000912087839627738) + (6.52927521755538e-05)*y3)  + (-0.00161788619447214) + y3*((4.84048599642259e-05)*y3 + (-0.000228746786374095)))  + (-0.00141395081798396) + y3*(y3*((-3.76259515604045e-05)*y3 + (-0.000109706576388026)) + (-9.66961743054448e-07)))  + (0.00629940481774520) + y3*(y3*(y3*((5.78244914512302e-05)*y3 + (0.000223883095936380)) + (-0.000887652462542966)) + (4.18682029956124e-05)))  + (-0.00374016542380580) + y3*(y3*(y3*(y3*((6.63399967701277e-05)*y3 + (-0.000160326619346241)) + (-0.000317447409565445)) + (0.00359192219395953)) + (0.00154438521063997)))  + (0.000754350903212885) + y3*(y3*(y3*(y3*(y3*((0.000184264071453486)*y3 + (-0.000249330471376903)) + (-0.000670530325315454)) + (-0.000301457687009814)) + (-0.00335630302705239)) + (-0.000439515466685735)))  + (-0.00458510492375029) + y3*(y3*(y3*(y3*(y3*(y3*((0.000186935963061179)*y3 + (-0.000921005217335436)) + (-0.000351282588772839)) + (0.00242702823714127)) + (0.000445821171561984)) + (-0.000526014953057334)) + (-0.000729927374909142)))  + (-1.36335660276188e-05) + y3*(y3*(y3*(y3*(y3*(y3*(y3*((0.000310313440720990)*y3 + (-0.000506941763481144)) + (0.00109690031687782)) + (0.00139047376234800)) + (-0.00157008016141059)) + (0.00103067686727741)) + (-0.00188513244270913)) + (-0.00598792567811923)))  + (-0.000714018575115048) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((0.000196875815161446)*y3 + (-0.00123600788349534)) + (-0.000583719307267534)) + (0.000754527158402127)) + (0.000591292237064542)) + (0.000801408045350607)) + (7.07033218025586e-05)) + (0.00291534137658930)) + (0.000124429307535701)))  + (0.00722487231726519) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((0.000203667250888369)*y3 + (-0.000935234660115079)) + (-0.000703209181687488)) + (0.00186145337972818)) + (0.00120098364502860)) + (0.00190421447473792)) + (-0.00302585744539260)) + (-0.00267240816398529)) + (0.00496303206577283)) + (0.00380044493346123)))  + (0.0105030000139537) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((5.87086924296170e-05)*y3 + (-0.000299650787550143)) + (0.00111239835699947)) + (0.00449260250113669)) + (-0.000855893989110677)) + (-0.00500921639770386)) + (-0.00734459051852670)) + (-8.43847741048851e-05)) + (0.000329006684597273)) + (-0.00818812037800784)) + (0.0106659639988337)))  + (-0.0161170367950099) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((0.000534798167576235)*y3 + (7.72268376568344e-05)) + (-0.00203006374062569)) + (-0.000839040399526666)) + (0.00375590191450383)) + (-0.00276075196202092)) + (-0.00426860641060154)) + (-0.000815912894445721)) + (-0.00681840801267117)) + (0.0181125184727566)) + (0.0183627675476041)))  + (0.0149064639999978) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((-0.00311353805189556)*y3 + (-0.00292695974154900)) + (0.0112302188135100)) + (0.00881129178892725)) + (-0.00999085220932562)) + (-0.00674064250933813)) + (-0.00182778396568752)) + (0.00163484569319947)) + (0.0130602077606936)) + (-0.0137121623908754)) + (-0.0145730582986078)))  + (-0.0176244041862670) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((0.00320560368638064)*y3 + (0.00198861923176935)) + (-0.0168505684359423)) + (-0.00720342673496588)) + (0.0240704131569734)) + (0.00708064555931057)) + (-0.00430491633941875)) + (0.00876399878409160)) + (0.00928311812740982)) + (-0.00771448830115744)) + (-0.0340904070711478)))  + (-0.0239350232349048) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((0.00137973202655612)*y3 + (0.00583056184722675)) + (0.00482109745470120)) + (-0.0220578149926647)) + (-0.0383668927215687)) + (0.0124384366085440)) + (0.0474148094342795)) + (0.0249048463428635)) + (0.0101626108596939)) + (-0.00292860496367932)) + (-0.0275031823868320)))  + (0.0332141526303160) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((-0.00115250368703464)*y3 + (0.000694382558799458)) + (0.00120993001888118)) + (-0.00807481128478462)) + (0.0144128702839588)) + (0.0233909999913352)) + (-0.0264332100642564)) + (-0.0171022816166191)) + (-0.00997359896963252)) + (-0.0229929195758871)) + (0.0314814644212330)))  + (0.00773171857463359) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((0.00229347921973128)*y3 + (0.000508695109111385)) + (-0.0151843652445462)) + (-0.0141805427205494)) + (0.0210713242099877)) + (0.0667916336666754)) + (0.0357669797606521)) + (-0.108642233847166)) + (-0.0986540182445699)) + (0.0514922694917240)) + (0.0593338253821483)))  + (0.178728629037837) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((-0.00386698346449585)*y3 + (-0.00374673469020785)) + (0.0228543689845373)) + (0.0207285720583207)) + (-0.0400845772819634)) + (-0.0374590033508690)) + (0.00429635559125250)) + (0.0237555068200844)) + (0.0550950502218550)) + (-0.0371576175395440)) + (-0.0469459016702578))) + y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((-0.00104047063354730)*y3 + (-0.00657396283222445)) + (0.00137322151172405)) + (0.0423680150841570)) + (0.0137512817839854)) + (-0.0906671502459144)) + (-0.0259063468625705)) + (0.00684214366735070)) +  (-0.00276938731969825)) + (0.577306997583531)) + (1.05605170092997)) + (-0.461528781943788));
    end if;

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
    SmoothTransition st;
    SpecificEntropy ds = st.T_ps;
    SpecificEntropy s_dew;
    SpecificEntropy s_bubble;
    Real x1;
    Real y1;
    Real T1;
    Real x2;
    Real x3;
    Real y2;
    Real y3;
    Real T2;
    Real T3;
    Real x_scr;
    Real s_scr;
    Real s_IIR;

algorithm
    s_IIR :=s + 2.736808957627727E3;
    s_dew := dewEntropy(sat = setSat_p(p=p))+ 2.736808957627727E3;
    s_bubble := bubbleEntropy(sat = setSat_p(p=p))+ 2.736808957627727E3;
    x_scr := (log(p) -  15.9737451344477) / 0.0876291056536608;
    s_scr := 1271.18991015299 + 31.6158276743894 * ( x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*(x_scr*((-0.0693083941975675)*x_scr + (-0.0433875271986535)) + (0.913548979443457)) + (0.492023438569825)) + (-5.07489232309945)) + (-2.2957976898621)) + (15.4214777750273)) + (5.69068924735857)) + (-27.8354882948879)) + (-8.07302046371493)) + (30.3233775210149)) + (6.58168042042789)) + (-19.3613495658065)) + (-2.93033262430351)) + (6.66822473831742)) + (0.64986780713796)) + (-1.08621654427118)) + (0.0767031043759982)) + (-0.695040296083562)) + (-0.211615238120171));

if p<7377300 then
  if s_IIR<s_bubble-ds then //SC
    x1 := (log(p) - 15.4659744379055) / 0.570086745208579;
    y1 := (s_IIR-690.083971553611) / 257.741313505105;
    T := 237.773569203860 + 29.9013115665379 * ( y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*((-0.000407464137871825)*y1 + (0.00579559144612026) + (-0.00126793167840070)*x1)  + (-0.0312549550494376) + x1*((0.00165786352974735)*x1 + (0.00980308384470109)))  + (0.0720228816964693) + x1*(x1*((0.0212406826365093)*x1 + (-0.0615897553214999)) + (0.00953434347169057)))  + (-0.0575917408804803) + x1*(x1*(x1*((-0.0733986171576310)*x1 + (0.0789137879311679)) + (0.117406763333374)) + (-0.0983846089625151)))  + (-0.0323632662220968) + x1*(x1*(x1*(x1*((0.109724544680481)*x1 + (-0.0263578130023818)) + (-0.228461656266479)) + (0.0611752532336594)) + (0.0970414204139203)))  + (0.0659997607583463) + x1*(x1*(x1*(x1*(x1*((-0.0962393999777624)*x1 + (-0.00486123102410811)) + (0.246631425316431)) + (-0.0683189232949799)) + (-0.157912979100403)) + (0.0635920487027199)))  + (-0.00828281662087413) + x1*(x1*(x1*(x1*(x1*(x1*((0.0529022997592714)*x1 + (-0.00567963332242039)) + (-0.222239059379547)) + (0.0730784271531593)) + (0.259855489926179)) + (-0.0747550185729336)) + (-0.0889658480657323)))  + (-0.0264644143207841) + x1*(x1*(x1*(x1*(x1*(x1*(x1*((-0.0159284363200894)*x1 + (0.0205374264488603)) + (0.134186505281863)) + (-0.0581800145079780)) + (-0.224921719234958)) + (0.0698394554910627)) + (0.0952431584414644)) + (-0.0177429946256117)))  + (-0.0143650676978548) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.00176647696804449)*x1 + (-0.0166986185097119)) + (-0.0529661534499776)) + (0.0508940119284918)) + (0.140263116310967)) + (-0.0791969606272540)) + (-0.112651093458106)) + (0.0491942360544333)) + (0.0287592512544731)))  + (0.0322865666650518) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.00352442504613421)*x1 + (0.00659980651152344)) + (-0.0236820513068561)) + (-0.0383463117593314)) + (0.0456788056781579)) + (0.0541253384686689)) + (-0.0322994481146215)) + (-0.0179971244252732)) + (0.0124152784209372)))  + (1.03089400550965) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.00183100126500413)*x1 + (0.00848748804094358)) + (0.00462649266914588)) + (-0.0232882406743500)) + (-0.0197488167296418)) + (0.0235508330883492)) + (0.0164369361357800)) + (-0.00489205577886678)) + (0.0163022160812854)))  + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.000179029664496414)*x1 + (0.000936458432247542)) + (0.000863446951870381)) + (-0.00217211266237801)) + (-0.00285990159484531)) + (0.00193486385069378)) + (0.00381361486468428)) + (0.00972661642336815)) + (0.0375567079196747)) + (-0.00525956394114347));
  elseif s_IIR>s_dew+ds then //SH
    x2 := (log(p) - 15.3277337030617) / 0.621120317258441;
    y2 := (s_IIR-2354.62309776343)/368.384949113833;
    T  := 477.564423674341 + 167.046899022306 * ( y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((-1.89254817525203e-05)*y2 + (1.80552297476392e-05) + x1*(-6.07234524403335e-05))  + (0.000122950368672675) + x2*((-0.000149174219683957)*x2 + (0.000212341445729102)))  + (-6.00371076374742e-05) + x2*(x2*((-5.02631131875637e-05)*x2 + (0.000470816396590746)) + (-9.11733428849876e-05)))  + (-0.000385005336459925) + x2*(x2*(x2*((-1.52516334992849e-05)*x2 + (0.000235306131520488)) + (1.47062985772559e-05)) + (-0.000394507431163453)))  + (0.000288678780790623) + x2*(x2*(x2*((3.07496495612071e-05)*x2 + (-0.000348458707983049)) + (-0.00113338308665754)) + (0.000368301152506869)))  + (-0.000679995762371423) + x2*(x2*(x2*((-1.45202120736564e-05)*x2 + (-3.08278835931454e-05)) + (0.000489630054511040)) + (0.000489108570627152)))  + (0.00554031098787947) + x2*(x2*(x2*((4.17805354167385e-05)*x2 + (0.000477377154969465)) + (0.000828572831707275)) + (-0.000971295227211896)))  + (-0.00821751740744134) + x2*(x2*(x2*((-4.38144207776239e-05)*x2 + (-0.000103826446087262)) + (-0.000278806520235111)) + (0.000459558933317606)))  + (0.157946589333349) + x2*(x2*(x2*((-4.24737984512163e-05)*x2 + (-0.000380156226912084)) + (0.000430539993332003)) + (0.0116613992466142)))  +  (0.920077717547061) + x2*(x2*(x2*((5.02059371747915e-05)*x2 + (0.000201074897751942)) + (6.48796001281074e-05)) + (0.0622335598206458)))  + x2*(x2*(x2*((2.01944545092901e-05)*x2 + (0.000724427476874153)) + (0.0178236658542171)) + (0.343613906426244)) + (-0.190630753743194));
  elseif s_IIR<s_bubble then //SC+smooth
    x1 := (log(p) - 15.4659744379055) / 0.570086745208579;
    y1 := (s_IIR-690.083971553611) / 257.741313505105;
    T1 := 237.773569203860 + 29.9013115665379 * ( y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*((-0.000407464137871825)*y1 + (0.00579559144612026) + (-0.00126793167840070)*x1)  + (-0.0312549550494376) + x1*((0.00165786352974735)*x1 + (0.00980308384470109)))  + (0.0720228816964693) + x1*(x1*((0.0212406826365093)*x1 + (-0.0615897553214999)) + (0.00953434347169057)))  + (-0.0575917408804803) + x1*(x1*(x1*((-0.0733986171576310)*x1 + (0.0789137879311679)) + (0.117406763333374)) + (-0.0983846089625151)))  + (-0.0323632662220968) + x1*(x1*(x1*(x1*((0.109724544680481)*x1 + (-0.0263578130023818)) + (-0.228461656266479)) + (0.0611752532336594)) + (0.0970414204139203)))  + (0.0659997607583463) + x1*(x1*(x1*(x1*(x1*((-0.0962393999777624)*x1 + (-0.00486123102410811)) + (0.246631425316431)) + (-0.0683189232949799)) + (-0.157912979100403)) + (0.0635920487027199)))  + (-0.00828281662087413) + x1*(x1*(x1*(x1*(x1*(x1*((0.0529022997592714)*x1 + (-0.00567963332242039)) + (-0.222239059379547)) + (0.0730784271531593)) + (0.259855489926179)) + (-0.0747550185729336)) + (-0.0889658480657323)))  + (-0.0264644143207841) + x1*(x1*(x1*(x1*(x1*(x1*(x1*((-0.0159284363200894)*x1 + (0.0205374264488603)) + (0.134186505281863)) + (-0.0581800145079780)) + (-0.224921719234958)) + (0.0698394554910627)) + (0.0952431584414644)) + (-0.0177429946256117)))  + (-0.0143650676978548) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.00176647696804449)*x1 + (-0.0166986185097119)) + (-0.0529661534499776)) + (0.0508940119284918)) + (0.140263116310967)) + (-0.0791969606272540)) + (-0.112651093458106)) + (0.0491942360544333)) + (0.0287592512544731)))  + (0.0322865666650518) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.00352442504613421)*x1 + (0.00659980651152344)) + (-0.0236820513068561)) + (-0.0383463117593314)) + (0.0456788056781579)) + (0.0541253384686689)) + (-0.0322994481146215)) + (-0.0179971244252732)) + (0.0124152784209372)))  + (1.03089400550965) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.00183100126500413)*x1 + (0.00848748804094358)) + (0.00462649266914588)) + (-0.0232882406743500)) + (-0.0197488167296418)) + (0.0235508330883492)) + (0.0164369361357800)) + (-0.00489205577886678)) + (0.0163022160812854)))  + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.000179029664496414)*x1 + (0.000936458432247542)) + (0.000863446951870381)) + (-0.00217211266237801)) + (-0.00285990159484531)) + (0.00193486385069378)) + (0.00381361486468428)) + (0.00972661642336815)) + (0.0375567079196747)) + (-0.00525956394114347));
    T := saturationTemperature(p)*(1 - (s_bubble - s_IIR)/ds) + T1*(s_bubble - s_IIR)/ds;
  elseif s_IIR>s_dew then //SH+smooth
    x2 := (log(p) - 15.3277337030617) / 0.621120317258441;
    y2 := (s_IIR-2354.62309776343)/368.384949113833;
    T2  := 477.564423674341 + 167.046899022306 * ( y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*(y2*((-1.89254817525203e-05)*y2 + (1.80552297476392e-05) + x1*(-6.07234524403335e-05))  + (0.000122950368672675) + x2*((-0.000149174219683957)*x2 + (0.000212341445729102)))  + (-6.00371076374742e-05) + x2*(x2*((-5.02631131875637e-05)*x2 + (0.000470816396590746)) + (-9.11733428849876e-05)))  + (-0.000385005336459925) + x2*(x2*(x2*((-1.52516334992849e-05)*x2 + (0.000235306131520488)) + (1.47062985772559e-05)) + (-0.000394507431163453)))  + (0.000288678780790623) + x2*(x2*(x2*((3.07496495612071e-05)*x2 + (-0.000348458707983049)) + (-0.00113338308665754)) + (0.000368301152506869)))  + (-0.000679995762371423) + x2*(x2*(x2*((-1.45202120736564e-05)*x2 + (-3.08278835931454e-05)) + (0.000489630054511040)) + (0.000489108570627152)))  + (0.00554031098787947) + x2*(x2*(x2*((4.17805354167385e-05)*x2 + (0.000477377154969465)) + (0.000828572831707275)) + (-0.000971295227211896)))  + (-0.00821751740744134) + x2*(x2*(x2*((-4.38144207776239e-05)*x2 + (-0.000103826446087262)) + (-0.000278806520235111)) + (0.000459558933317606)))  + (0.157946589333349) + x2*(x2*(x2*((-4.24737984512163e-05)*x2 + (-0.000380156226912084)) + (0.000430539993332003)) + (0.0116613992466142)))  +  (0.920077717547061) + x2*(x2*(x2*((5.02059371747915e-05)*x2 + (0.000201074897751942)) + (6.48796001281074e-05)) + (0.0622335598206458)))  + x2*(x2*(x2*((2.01944545092901e-05)*x2 + (0.000724427476874153)) + (0.0178236658542171)) + (0.343613906426244)) + (-0.190630753743194));
    T := saturationTemperature(p)*(1 - (s_IIR - s_dew)/ds) + T2*(s_IIR - s_dew)/ ds;
  else
    T := saturationTemperature(p);
  end if;
elseif s_IIR>s_scr then //SCr
    x3 := (log(p) - 15.8892744515381) / 0.0937074664096336;
    y3 := (s_IIR-2190.89392400879)/500.554575056586;
    T := 491.726162948824 + 171.821238959322 * ( y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*(y3*((0.000141353429828573)*y3 + (-1.23955075787735e-05) + (0.000114814532676984)*x3)  + (-0.00158196362311447) + x3*((1.01897193597239e-05)*x3 + (0.000134440877196593)))  + (0.000518702830018378) + x3*((3.68371630064315e-05)*x3 + (-0.00122880962877531)))  + (0.00680848687713678) + x3*((-9.57448505200034e-05)*x3 + (-0.00112056985673112)))  + (-0.00380855316068619) + x3*((-0.000331853123775148)*x3 + (0.00535739549954502)))  + (-0.0131853911735176) + x3*((0.000383377342460482)*x3 + (0.00336015448808433)))  + (0.0100524251108083) + x3*((0.00112210642844776)*x3 + (-0.0118851548418672)))  + (0.00941445846184692) + x3*((-0.000824782672275127)*x3 + (-0.00412349177279143)))  + (-0.00648256118483747) + x3*((-0.00175498144677042)*x3 + (0.0132961615722138)))  + (-0.00625825756493832) + x3*((0.000957096123836232)*x3 + (0.00179495787236290)))  + (0.00115890003365512) + x3*((0.00125317159018973)*x3 + (-0.00589310958360566)))  + (0.0231201294635747) + x3*((-0.000531682728549153)*x3 + (-0.00214601573179719)))  + (-0.0450908633649019) + x3*((-0.000278613183577527)*x3 + (0.00297471769204135)))  + (0.333086038724616) + x3*((3.98214909498652e-06)*x3 + (0.00265502677621983)))  + (1.08339041968521) + x3*((9.21471869725526e-05)*x3 + (0.0104467160775299)))  + x3*((0.000420995208500423)*x3 + (0.0516141726877508)) + (-0.339748174975458));
elseif s_IIR<s_scr then //SC
    x1 := (log(p) - 15.4659744379055) / 0.570086745208579;
    y1 := (s_IIR-690.083971553611) / 257.741313505105;
    T := 237.773569203860 + 29.9013115665379 * ( y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*(y1*((-0.000407464137871825)*y1 + (0.00579559144612026) + (-0.00126793167840070)*x1)  + (-0.0312549550494376) + x1*((0.00165786352974735)*x1 + (0.00980308384470109)))  + (0.0720228816964693) + x1*(x1*((0.0212406826365093)*x1 + (-0.0615897553214999)) + (0.00953434347169057)))  + (-0.0575917408804803) + x1*(x1*(x1*((-0.0733986171576310)*x1 + (0.0789137879311679)) + (0.117406763333374)) + (-0.0983846089625151)))  + (-0.0323632662220968) + x1*(x1*(x1*(x1*((0.109724544680481)*x1 + (-0.0263578130023818)) + (-0.228461656266479)) + (0.0611752532336594)) + (0.0970414204139203)))  + (0.0659997607583463) + x1*(x1*(x1*(x1*(x1*((-0.0962393999777624)*x1 + (-0.00486123102410811)) + (0.246631425316431)) + (-0.0683189232949799)) + (-0.157912979100403)) + (0.0635920487027199)))  + (-0.00828281662087413) + x1*(x1*(x1*(x1*(x1*(x1*((0.0529022997592714)*x1 + (-0.00567963332242039)) + (-0.222239059379547)) + (0.0730784271531593)) + (0.259855489926179)) + (-0.0747550185729336)) + (-0.0889658480657323)))  + (-0.0264644143207841) + x1*(x1*(x1*(x1*(x1*(x1*(x1*((-0.0159284363200894)*x1 + (0.0205374264488603)) + (0.134186505281863)) + (-0.0581800145079780)) + (-0.224921719234958)) + (0.0698394554910627)) + (0.0952431584414644)) + (-0.0177429946256117)))  + (-0.0143650676978548) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.00176647696804449)*x1 + (-0.0166986185097119)) + (-0.0529661534499776)) + (0.0508940119284918)) + (0.140263116310967)) + (-0.0791969606272540)) + (-0.112651093458106)) + (0.0491942360544333)) + (0.0287592512544731)))  + (0.0322865666650518) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.00352442504613421)*x1 + (0.00659980651152344)) + (-0.0236820513068561)) + (-0.0383463117593314)) + (0.0456788056781579)) + (0.0541253384686689)) + (-0.0322994481146215)) + (-0.0179971244252732)) + (0.0124152784209372)))  + (1.03089400550965) + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.00183100126500413)*x1 + (0.00848748804094358)) + (0.00462649266914588)) + (-0.0232882406743500)) + (-0.0197488167296418)) + (0.0235508330883492)) + (0.0164369361357800)) + (-0.00489205577886678)) + (0.0163022160812854)))  + x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((0.000179029664496414)*x1 + (0.000936458432247542)) + (0.000863446951870381)) + (-0.00217211266237801)) + (-0.00285990159484531)) + (0.00193486385069378)) + (0.00381361486468428)) + (0.00972661642336815)) + (0.0375567079196747)) + (-0.00525956394114347));
end if;

end temperature_ps;

redeclare replaceable function density_pT
    "Computes density as a function of pressure and temperature"
    extends Modelica.Icons.Function;
    input AbsolutePressure p "Pressure";
    input Temperature T "Temperature";
    input FixedPhase phase = 0
      "2 for two-phase, 1 for one-phase, 0 if not known";
    output Density d "Density";

protected
    SmoothTransition st;
    AbsolutePressure dp = st.d_pT;
    SaturationProperties sat = setSat_T(T=T);
    Real x1;
    Real y1;
    Real d1;
    Real x2;
    Real y2;
    Real d2;
    Real x3;
    Real y3;
    Real x4;
    Real y4;
    Real x5;
    Real y5;
    Real x6;
    Real y6;
    Real fitSCrSH;
    Real fitSCrSC;
    Real x_SCrSH;
    Real x_SCrSC;

algorithm

 if T<293.48 then
   fitSCrSH :=999E5;
   fitSCrSC :=0;
 elseif T>335 then
   fitSCrSH :=999E5;
   fitSCrSC :=999E5;
 else
   x_SCrSH := (T-310.6101043643270)/ 8.76584320026567;
   fitSCrSH := 7892500 + 1217198.69646113 *(x_SCrSH*(x_SCrSH*(x_SCrSH*(x_SCrSH*(x_SCrSH*(x_SCrSH*(x_SCrSH*((0.00188719085040888)*x_SCrSH +(0.0124350377093051)) +(0.0137074261256939)) + (-0.0194093733616778)) + (-0.0159253973725892)) + (0.0482368799973961)) + (0.134678047836633)) + (0.960326246865776)) + (-0.137487708236514));
   x_SCrSC := (T-302.260412713472)/5.61368969154838;
   fitSCrSC := 7892500 + 1217198.69646113 * (x_SCrSC*(x_SCrSC*(x_SCrSC*(x_SCrSC*(x_SCrSC*(x_SCrSC*(x_SCrSC*((0.000119724593648295)*x_SCrSC + (-0.000333709955125262)) + (-0.000492485309735125)) + (0.000188842225009553)) + (-0.00341321580455679)) + (-0.00943221113935049)) + (-0.0847871234324372)) + (1.0454687249959)) + (0.096352688710157));
 end if;

  if p< 5784000 then
    if p<sat.psat-dp then //"SH"
       x1 := ( p - 5519495.79447002) / 2567703.39184083;
       y1 := (T-323.196143266723)/28.5422300266500;
       d := 132.091744019263 + 76.6522972242426 * (x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((7.15487921614317e-05)*x1 + (-0.000186293075538892) + (0.000158640337862594)*y1)  + (-0.00265011383145745) + y1*((-0.00177261351999400)*y1 + (0.00417487913241615)))  + (0.000495265054733816) + y1*(y1*((0.00595637375150662)*y1 + (-0.0149332490903717)) + (0.00824627937624933)))  + (0.0174512144655053) + y1*(y1*(y1*((0.00644113577382396)*y1 + (-0.0294054443156379)) + (0.0547644631894267)) + (-0.0490519008171776)))  + (0.0171500109603422) + y1*(y1*(y1*(y1*((-0.0445539243958295)*y1 + (0.199845308894148)) + (-0.361637858402444)) + (0.331124788177358)) + (-0.141050144830697)))  + (0.00697505645251303) + y1*(y1*(y1*(y1*(y1*((0.0587289941449000)*y1 + (-0.349305438078168)) + (0.794279259209092)) + (-0.855765252276763)) + (0.435000419295625)) + (-0.0895191026576243)))  + (0.0637721470284816) + y1*(y1*(y1*(y1*(y1*(y1*((-0.0305980756691320)*y1 + (0.284103442427349)) + (-0.852220059293641)) + (1.12099169078695)) + (-0.658989014138355)) + (0.152276713823781)) + (-0.0673246981760775)))  + (0.232721507740677) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.00553839782424903)*y1 + (-0.109623517792320)) + (0.473195595542273)) + (-0.805704737418588)) + (0.540205525921847)) + (-0.0817699019842939)) + (0.105216593274550)) + (-0.274835535466439)))  + (1.01926707118493) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0155731352048423)*y1 + (-0.124499607368792)) + (0.301605652645551)) + (-0.243348931432783)) + (-0.00617607581669293)) + (-0.0207597004660533)) + (0.257424821666076)) + (-0.456453407756215)))  + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0105926422069889)*y1 + (-0.0445413553535566)) + (0.0503931240863202)) + (0.00878813080312919)) + (-0.0180496910371365)) + (-0.0626747233532592)) + (0.145751418029237)) + (-0.348266420768099)) + (-0.159545317255397));
    elseif p>sat.psat+dp then //"SC"
      x2 := ( p - 6580996.33416770) / 2214553.60520798;
      y2 := ( T - 267.837445960128) / 20.0905008530052;
      d := 965.064886068137 + 111.097344509587 * ( x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*((-5.33640713220979e-07)*x2 + (9.90491511851455e-07) + (2.74502945704711e-06)*y2)  + (3.25771277715757e-06) + y2*((-5.38064234037705e-06)*y2 + (-3.61748982871047e-06)))  + (-1.53083535813930e-05) + y2*(y2*((-4.58516940835320e-06)*y2 + (-2.41498361533748e-05)) + (-4.30487707250530e-05)))  + (8.97167217021812e-06) + y2*(y2*(y2*((0.000141735440416280)*y2 + (0.000479178921972304)) + (0.000544157521874485)) + (0.000210275056813108)))  + (1.21319825925124e-05) + y2*(y2*(y2*(y2*((-0.000645016467225130)*y2 + (-0.00251687289333307)) + (-0.00329032034031329)) + (-0.00151824979097779)) + (-8.16597159954310e-05)))  + (0.000909338872673313) + y2*(y2*(y2*(y2*(y2*((0.00181838166402227)*y2 + (0.00783557504988342)) + (0.0108011510380893)) + (0.00420529704478072)) + (-0.000605795165620560)) + (0.000810430503323910)))  + (-0.00776505941118675) + y2*(y2*(y2*(y2*(y2*(y2*((-0.00268476903693715)*y2 + (-0.0130316521317318)) + (-0.0198586589754445)) + (-0.00737438124522966)) + (0.00209527098025530)) + (-0.00721185526704901)) + (-0.0126008967427799)))  + (0.116294045193668) + y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.00138543647533724)*y2 + (0.0105534402562103)) + (0.0215232833104674)) + (0.00826556767652560)) + (-0.00631626007050606)) + (0.0197031757182000)) + (0.0528486800895992)) + (0.0790651759889045)))  + y2*(y2*(y2*(y2*(y2*(y2*(y2*((-0.00330937382644560)*y2 + (-0.00984303685396187)) + (-0.00353615752892107)) + (0.00548909064326438)) + (-0.0165198662527552)) + (-0.0570877777084003)) + (-0.146272750957203)) + (-0.943249296676852)) + (0.146947556383107));
    elseif p<sat.psat then //"SH + smooth"
       x1 := ( p - 5519495.79447002) / 2567703.39184083;
       y1 := (T-323.196143266723)/28.5422300266500;
       d1 := 132.091744019263 + 76.6522972242426 * (x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((7.15487921614317e-05)*x1 + (-0.000186293075538892) + (0.000158640337862594)*y1)  + (-0.00265011383145745) + y1*((-0.00177261351999400)*y1 + (0.00417487913241615)))  + (0.000495265054733816) + y1*(y1*((0.00595637375150662)*y1 + (-0.0149332490903717)) + (0.00824627937624933)))  + (0.0174512144655053) + y1*(y1*(y1*((0.00644113577382396)*y1 + (-0.0294054443156379)) + (0.0547644631894267)) + (-0.0490519008171776)))  + (0.0171500109603422) + y1*(y1*(y1*(y1*((-0.0445539243958295)*y1 + (0.199845308894148)) + (-0.361637858402444)) + (0.331124788177358)) + (-0.141050144830697)))  + (0.00697505645251303) + y1*(y1*(y1*(y1*(y1*((0.0587289941449000)*y1 + (-0.349305438078168)) + (0.794279259209092)) + (-0.855765252276763)) + (0.435000419295625)) + (-0.0895191026576243)))  + (0.0637721470284816) + y1*(y1*(y1*(y1*(y1*(y1*((-0.0305980756691320)*y1 + (0.284103442427349)) + (-0.852220059293641)) + (1.12099169078695)) + (-0.658989014138355)) + (0.152276713823781)) + (-0.0673246981760775)))  + (0.232721507740677) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.00553839782424903)*y1 + (-0.109623517792320)) + (0.473195595542273)) + (-0.805704737418588)) + (0.540205525921847)) + (-0.0817699019842939)) + (0.105216593274550)) + (-0.274835535466439)))  + (1.01926707118493) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0155731352048423)*y1 + (-0.124499607368792)) + (0.301605652645551)) + (-0.243348931432783)) + (-0.00617607581669293)) + (-0.0207597004660533)) + (0.257424821666076)) + (-0.456453407756215)))  + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0105926422069889)*y1 + (-0.0445413553535566)) + (0.0503931240863202)) + (0.00878813080312919)) + (-0.0180496910371365)) + (-0.0626747233532592)) + (0.145751418029237)) + (-0.348266420768099)) + (-0.159545317255397));
       d := 0.995*bubbleDensity(sat)*(1 -(sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
    elseif p>sat.psat then //"SC+smooth"
      x2 := ( p - 6580996.33416770) / 2214553.60520798;
      y2 := ( T - 267.837445960128) / 20.0905008530052;
      d2 := 965.064886068137 + 111.097344509587 * ( x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*((-5.33640713220979e-07)*x2 + (9.90491511851455e-07) + (2.74502945704711e-06)*y2)  + (3.25771277715757e-06) + y2*((-5.38064234037705e-06)*y2 + (-3.61748982871047e-06)))  + (-1.53083535813930e-05) + y2*(y2*((-4.58516940835320e-06)*y2 + (-2.41498361533748e-05)) + (-4.30487707250530e-05)))  + (8.97167217021812e-06) + y2*(y2*(y2*((0.000141735440416280)*y2 + (0.000479178921972304)) + (0.000544157521874485)) + (0.000210275056813108)))  + (1.21319825925124e-05) + y2*(y2*(y2*(y2*((-0.000645016467225130)*y2 + (-0.00251687289333307)) + (-0.00329032034031329)) + (-0.00151824979097779)) + (-8.16597159954310e-05)))  + (0.000909338872673313) + y2*(y2*(y2*(y2*(y2*((0.00181838166402227)*y2 + (0.00783557504988342)) + (0.0108011510380893)) + (0.00420529704478072)) + (-0.000605795165620560)) + (0.000810430503323910)))  + (-0.00776505941118675) + y2*(y2*(y2*(y2*(y2*(y2*((-0.00268476903693715)*y2 + (-0.0130316521317318)) + (-0.0198586589754445)) + (-0.00737438124522966)) + (0.00209527098025530)) + (-0.00721185526704901)) + (-0.0126008967427799)))  + (0.116294045193668) + y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.00138543647533724)*y2 + (0.0105534402562103)) + (0.0215232833104674)) + (0.00826556767652560)) + (-0.00631626007050606)) + (0.0197031757182000)) + (0.0528486800895992)) + (0.0790651759889045)))  + y2*(y2*(y2*(y2*(y2*(y2*(y2*((-0.00330937382644560)*y2 + (-0.00984303685396187)) + (-0.00353615752892107)) + (0.00548909064326438)) + (-0.0165198662527552)) + (-0.0570877777084003)) + (-0.146272750957203)) + (-0.943249296676852)) + (0.146947556383107));
      d := dewDensity(sat)*(1 -(p - sat.psat)/dp) + d2*(p - sat.psat)/dp;
    end if;
  elseif p < 7377300 then
    if p > sat.psat then
      if p > fitSCrSC then //SC
        x2 := ( p - 6580996.33416770) / 2214553.60520798;
        y2 := ( T - 267.837445960128) / 20.0905008530052;
        d := 965.064886068137 + 111.097344509587 * ( x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*((-5.33640713220979e-07)*x2 + (9.90491511851455e-07) + (2.74502945704711e-06)*y2)  + (3.25771277715757e-06) + y2*((-5.38064234037705e-06)*y2 + (-3.61748982871047e-06)))  + (-1.53083535813930e-05) + y2*(y2*((-4.58516940835320e-06)*y2 + (-2.41498361533748e-05)) + (-4.30487707250530e-05)))  + (8.97167217021812e-06) + y2*(y2*(y2*((0.000141735440416280)*y2 + (0.000479178921972304)) + (0.000544157521874485)) + (0.000210275056813108)))  + (1.21319825925124e-05) + y2*(y2*(y2*(y2*((-0.000645016467225130)*y2 + (-0.00251687289333307)) + (-0.00329032034031329)) + (-0.00151824979097779)) + (-8.16597159954310e-05)))  + (0.000909338872673313) + y2*(y2*(y2*(y2*(y2*((0.00181838166402227)*y2 + (0.00783557504988342)) + (0.0108011510380893)) + (0.00420529704478072)) + (-0.000605795165620560)) + (0.000810430503323910)))  + (-0.00776505941118675) + y2*(y2*(y2*(y2*(y2*(y2*((-0.00268476903693715)*y2 + (-0.0130316521317318)) + (-0.0198586589754445)) + (-0.00737438124522966)) + (0.00209527098025530)) + (-0.00721185526704901)) + (-0.0126008967427799)))  + (0.116294045193668) + y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.00138543647533724)*y2 + (0.0105534402562103)) + (0.0215232833104674)) + (0.00826556767652560)) + (-0.00631626007050606)) + (0.0197031757182000)) + (0.0528486800895992)) + (0.0790651759889045)))  + y2*(y2*(y2*(y2*(y2*(y2*(y2*((-0.00330937382644560)*y2 + (-0.00984303685396187)) + (-0.00353615752892107)) + (0.00548909064326438)) + (-0.0165198662527552)) + (-0.0570877777084003)) + (-0.146272750957203)) + (-0.943249296676852)) + (0.146947556383107));
      else //Tra1
        x3 := (p-6852709.62095200)/368334.615439319;
        y3 := (T-299.418336363026)/2.21937025952538;
        d  := 704.553008244752 + 36.8808678865484* ( x3*(x3*(x3*(x3*(x3*(x3*(x3*((0.0540217241160661)*x3 + (-0.0935289303414976) + (-0.445670051500448)*y3)  + (-0.0740896896224486) + y3*((1.16228220696106)*y3 + (0.958356384051139)))  + (0.233529934336029) + y3*(y3*((-0.129004399097506)*y3 + (-3.58998939194579)) + (-0.0289855154958683)))  + (-0.109142075831824) + y3*(y3*(y3*((-5.23306951084057)*y3 + (6.76812384148731)) + (1.82138920162200)) + (-1.34128011032576)))  + (-0.00677428020013625) + y3*(y3*(y3*(y3*((11.6298156931156)*y3 + (-7.10506535963415)) + (-5.97180879788860)) + (3.05418767658433)) + (0.864800512536852)))  + (-0.143832578521546) + y3*(y3*(y3*(y3*(y3*((-11.8052993172531)*y3 + (4.21455824466763)) + (8.53277971454368)) + (-3.50168825072889)) + (-2.22377895823628)) + (-0.0715583711854990)))  + (0.719363093970298) + y3*(y3*(y3*(y3*(y3*(y3*((6.01402520105134)*y3 + (-1.33702583693465)) + (-5.86951993520384)) + (2.06839758499470)) + (2.38287869606990)) + (0.192788001262791)) + (0.454694815193594)))  + y3*(y3*(y3*(y3*(y3*(y3*(y3*((-1.24718938847469)*y3 + (0.184986377272869)) + (1.59172469974569)) + (-0.516879765074009)) + (-0.923034152303040)) + (-0.110733593564551)) + (-0.346423384032589)) + (-1.47039015151112)) + (0.135845880999374));
      end if;
    elseif p<sat.psat then
      if p<fitSCrSH then //SH
        x1 := ( p - 5519495.79447002) / 2567703.39184083;
        y1 := (T-323.196143266723)/28.5422300266500;
        d := 132.091744019263 + 76.6522972242426 * (x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((7.15487921614317e-05)*x1 + (-0.000186293075538892) + (0.000158640337862594)*y1)  + (-0.00265011383145745) + y1*((-0.00177261351999400)*y1 + (0.00417487913241615)))  + (0.000495265054733816) + y1*(y1*((0.00595637375150662)*y1 + (-0.0149332490903717)) + (0.00824627937624933)))  + (0.0174512144655053) + y1*(y1*(y1*((0.00644113577382396)*y1 + (-0.0294054443156379)) + (0.0547644631894267)) + (-0.0490519008171776)))  + (0.0171500109603422) + y1*(y1*(y1*(y1*((-0.0445539243958295)*y1 + (0.199845308894148)) + (-0.361637858402444)) + (0.331124788177358)) + (-0.141050144830697)))  + (0.00697505645251303) + y1*(y1*(y1*(y1*(y1*((0.0587289941449000)*y1 + (-0.349305438078168)) + (0.794279259209092)) + (-0.855765252276763)) + (0.435000419295625)) + (-0.0895191026576243)))  + (0.0637721470284816) + y1*(y1*(y1*(y1*(y1*(y1*((-0.0305980756691320)*y1 + (0.284103442427349)) + (-0.852220059293641)) + (1.12099169078695)) + (-0.658989014138355)) + (0.152276713823781)) + (-0.0673246981760775)))  + (0.232721507740677) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.00553839782424903)*y1 + (-0.109623517792320)) + (0.473195595542273)) + (-0.805704737418588)) + (0.540205525921847)) + (-0.0817699019842939)) + (0.105216593274550)) + (-0.274835535466439)))  + (1.01926707118493) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0155731352048423)*y1 + (-0.124499607368792)) + (0.301605652645551)) + (-0.243348931432783)) + (-0.00617607581669293)) + (-0.0207597004660533)) + (0.257424821666076)) + (-0.456453407756215)))  + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0105926422069889)*y1 + (-0.0445413553535566)) + (0.0503931240863202)) + (0.00878813080312919)) + (-0.0180496910371365)) + (-0.0626747233532592)) + (0.145751418029237)) + (-0.348266420768099)) + (-0.159545317255397));
      else //Tra2
        x4 := (p-6861842.26287351)/347737.370667184;
        y4 := (T-302.285863550535)/2.84807263925339;
        d  := 257.726989037258 + 26.6787183136241 * ( x4*(x4*(x4*(x4*(x4*(x4*(x4*((2.32643489453363)*x4 + (1.05490116604965) + (-11.8920334966292)*y4)  + (1.27563381891941) + y4*((21.3850074890077)*y4 + (-7.94604371709061)))  + (1.34425793259501) + y4*(y4*((-12.0832489291568)*y4 + (20.9408663247199)) + (-8.19255600923722)))  + (0.806681869840231) + y4*(y4*(y4*((-7.03634003588980)*y4 + (-22.2703898711861)) + (19.5456217495361)) + (-8.26459985905333)))  + (0.681752653361671) + y4*(y4*(y4*(y4*((7.21891450978607)*y4 + (1.98016683621984)) + (-20.7750562890685)) + (19.9983534650838)) + (-3.80930033551582)))  + (1.01975258967193) + y4*(y4*(y4*(y4*(y4*((5.22137734349163)*y4 + (15.3453351868259)) + (7.84741270356864)) + (-23.8010751630800)) + (6.79031350570749)) + (-1.94317929696452)))  + (2.22649996975207) + y4*(y4*(y4*(y4*(y4*(y4*((-7.21436484271673)*y4 + (-11.9582623667767)) + (1.75632331127751)) + (13.9194740586787)) + (-5.42171296492636)) + (1.77417183954536)) + (-1.92418534367314)))  + y4*(y4*(y4*(y4*(y4*(y4*(y4*((2.07427827128384)*y4 + (2.85349024893583)) + (-1.45763557058898)) + (-3.19700566121067)) + (1.63459388173288)) + (-0.519440286366421)) + (0.857703105187753)) + (-1.60187112581113)) + (-0.0742000467430081));
      end if;
    end if;
  elseif p < 7596000 then //SC, SCr1 or SH
    if p > fitSCrSC then //SC
      x2 := ( p - 6580996.33416770) / 2214553.60520798;
      y2 := ( T - 267.837445960128) / 20.0905008530052;
      d := 965.064886068137 + 111.097344509587 * ( x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*((-5.33640713220979e-07)*x2 + (9.90491511851455e-07) + (2.74502945704711e-06)*y2)  + (3.25771277715757e-06) + y2*((-5.38064234037705e-06)*y2 + (-3.61748982871047e-06)))  + (-1.53083535813930e-05) + y2*(y2*((-4.58516940835320e-06)*y2 + (-2.41498361533748e-05)) + (-4.30487707250530e-05)))  + (8.97167217021812e-06) + y2*(y2*(y2*((0.000141735440416280)*y2 + (0.000479178921972304)) + (0.000544157521874485)) + (0.000210275056813108)))  + (1.21319825925124e-05) + y2*(y2*(y2*(y2*((-0.000645016467225130)*y2 + (-0.00251687289333307)) + (-0.00329032034031329)) + (-0.00151824979097779)) + (-8.16597159954310e-05)))  + (0.000909338872673313) + y2*(y2*(y2*(y2*(y2*((0.00181838166402227)*y2 + (0.00783557504988342)) + (0.0108011510380893)) + (0.00420529704478072)) + (-0.000605795165620560)) + (0.000810430503323910)))  + (-0.00776505941118675) + y2*(y2*(y2*(y2*(y2*(y2*((-0.00268476903693715)*y2 + (-0.0130316521317318)) + (-0.0198586589754445)) + (-0.00737438124522966)) + (0.00209527098025530)) + (-0.00721185526704901)) + (-0.0126008967427799)))  + (0.116294045193668) + y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.00138543647533724)*y2 + (0.0105534402562103)) + (0.0215232833104674)) + (0.00826556767652560)) + (-0.00631626007050606)) + (0.0197031757182000)) + (0.0528486800895992)) + (0.0790651759889045)))  + y2*(y2*(y2*(y2*(y2*(y2*(y2*((-0.00330937382644560)*y2 + (-0.00984303685396187)) + (-0.00353615752892107)) + (0.00548909064326438)) + (-0.0165198662527552)) + (-0.0570877777084003)) + (-0.146272750957203)) + (-0.943249296676852)) + (0.146947556383107));
    elseif p>fitSCrSH then //SCr1
      x5 :=  (p-7488199.23411845)/62889.7280539712;
      y5 :=  (T-304.404980852962)/2.55548710649952;
      d  := 502.791087299023 + 188.231268663898 * ( y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*(y5*((-0.000818109462178529)*y5 + (1.73816994693414e-05) + (-0.0239025875618387)*x5)  + (0.0659469270328488) + x5*((0.0305228166295861)*x5 + (-0.0248343008319824)))  + (0.0402498048273301) + x5*(x5*((0.00893272176390704)*x5 + (0.0347421699645147)) + (0.213695776602700)))  + (-0.729412055372201) + x5*(x5*(x5*((-0.0256046029848927)*x5 + (-0.0312504060728272)) + (-0.205605014972184)) + (0.227531425062744)))  + (-0.478740266813957) + x5*(x5*(x5*(x5*((0.00701444241949667)*x5 + (0.0142981113546490)) + (-0.271377999899265)) + (-0.234933726127396)) + (-0.736131347013044)))  + (3.42182835468905) + x5*(x5*(x5*(x5*((-0.00107109438495431)*x5 + (0.365550705913221))+  (0.177261013514976)) + (0.282465436357707)) + (-0.774801202977496)))  + (2.26477397092984) + x5*(x5*(x5*(x5*((-0.0822378521404984)*x5 + (-0.0673602700761091)) + (1.97881417864990)) + (0.341745751204790)) + (1.57501823250900)))  + (-8.01534032361643) + x5*(x5*(x5*(x5*((-0.00804555257078432)*x5 + (-1.93915329996032)) + (-0.132068917685318)) + (0.927542830337458)) + (1.21666014254253)))  + (-5.28003080295355) + x5*(x5*(x5*(x5*((0.361364635947953)*x5 + (0.0209572814353715)) + (-6.44231807936063)) + (1.00968201809870)) + (-4.19589209577525)))  + (8.39699311793481) + x5*(x5*(x5*(x5*((0.0792432987181176)*x5 + (5.11004587796163)) + (-1.04676941730794)) + (-3.10023370075194)) + (-1.23313630320879)))  + (5.64427079559404) + x5*(x5*(x5*(x5*((-0.793258492917212)*x5 + (0.365516248648382)) + (10.9274847631813)) + (-3.87239796148213)) + (11.6861174882345)))  + (0.827021438967501) + x5*(x5*(x5*(x5*((-0.209281771480703)*x5 + (-7.27894300795405)) + (2.86977312307346)) + (2.42389847805002)) + (2.43430754002441)))  + (-0.294534601533758) + x5*(x5*(x5*(x5*((0.965432496999922)*x5 + (-0.756621067273977)) + (-9.96178366405222)) + (4.60782809076787)) + (-19.8119932825305)))  + (-10.7619841720735) + x5*(x5*(x5*(x5*((0.241149293198011)*x5 + (5.57528840859557)) + (-2.90724949919789)) + (1.29511905647798)) + (-4.91432521097021)))  + (-5.33332570627995) + x5*(x5*(x5*(x5*((-0.669399393217854)*x5 + (0.591116013386306)) + (4.67455981856453)) + (-1.99484644810224))+  (17.6421086915984)))  + (9.85914701294718) + x5*(x5*(x5*(x5*((-0.127494532880646)*x5 + (-2.09911501799096)) + (1.22666540502198)) + (-2.59565656168885)) + (4.89206083764975)))  + (5.17072673723431) + x5*(x5*(x5*(x5*((0.243235539839399)*x5 + (-0.186803461740571)) + (-0.981586537819711)) + (-0.0316179463436961)) + (-7.49233157081911)))  + (-3.41417202599996) + x5*(x5*(x5*(x5*((0.0269323343731469)*x5 + (0.303414854100221)) + (-0.161725072484494)) + (1.01411931124914)) + (-2.15407355519074)))  + (-2.81967837176570) + x5*(x5*(x5*(x5*((-0.0316155978449693)*x5 + (0.0181643295574899)) + (0.0591984575408013)) + (0.148171677668715)) + (1.18489138901916)))  + x5*(x5*(x5*(x5*((-0.00105687890148851)*x5 + (-0.00723892174894502)) + (-0.000223893287424328)) + (-0.0750567550491341)) + (0.382682749064843)) + (0.304013073549779));
    else //SH
      x1 := ( p - 5519495.79447002) / 2567703.39184083;
      y1 := (T-323.196143266723)/28.5422300266500;
      d := 132.091744019263 + 76.6522972242426 * (x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((7.15487921614317e-05)*x1 + (-0.000186293075538892) + (0.000158640337862594)*y1)  + (-0.00265011383145745) + y1*((-0.00177261351999400)*y1 + (0.00417487913241615)))  + (0.000495265054733816) + y1*(y1*((0.00595637375150662)*y1 + (-0.0149332490903717)) + (0.00824627937624933)))  + (0.0174512144655053) + y1*(y1*(y1*((0.00644113577382396)*y1 + (-0.0294054443156379)) + (0.0547644631894267)) + (-0.0490519008171776)))  + (0.0171500109603422) + y1*(y1*(y1*(y1*((-0.0445539243958295)*y1 + (0.199845308894148)) + (-0.361637858402444)) + (0.331124788177358)) + (-0.141050144830697)))  + (0.00697505645251303) + y1*(y1*(y1*(y1*(y1*((0.0587289941449000)*y1 + (-0.349305438078168)) + (0.794279259209092)) + (-0.855765252276763)) + (0.435000419295625)) + (-0.0895191026576243)))  + (0.0637721470284816) + y1*(y1*(y1*(y1*(y1*(y1*((-0.0305980756691320)*y1 + (0.284103442427349)) + (-0.852220059293641)) + (1.12099169078695)) + (-0.658989014138355)) + (0.152276713823781)) + (-0.0673246981760775)))  + (0.232721507740677) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.00553839782424903)*y1 + (-0.109623517792320)) + (0.473195595542273)) + (-0.805704737418588)) + (0.540205525921847)) + (-0.0817699019842939)) + (0.105216593274550)) + (-0.274835535466439)))  + (1.01926707118493) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0155731352048423)*y1 + (-0.124499607368792)) + (0.301605652645551)) + (-0.243348931432783)) + (-0.00617607581669293)) + (-0.0207597004660533)) + (0.257424821666076)) + (-0.456453407756215)))  + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0105926422069889)*y1 + (-0.0445413553535566)) + (0.0503931240863202)) + (0.00878813080312919)) + (-0.0180496910371365)) + (-0.0626747233532592)) + (0.145751418029237)) + (-0.348266420768099)) + (-0.159545317255397));
    end if;
  elseif p> 7596000 then //SC or SCr2 or SH
    if p > fitSCrSC then //SC
      x2 := ( p - 6580996.33416770) / 2214553.60520798;
      y2 := ( T - 267.837445960128) / 20.0905008530052;
      d := 965.064886068137 + 111.097344509587 * ( x2*(x2*(x2*(x2*(x2*(x2*(x2*(x2*((-5.33640713220979e-07)*x2 + (9.90491511851455e-07) + (2.74502945704711e-06)*y2)  + (3.25771277715757e-06) + y2*((-5.38064234037705e-06)*y2 + (-3.61748982871047e-06)))  + (-1.53083535813930e-05) + y2*(y2*((-4.58516940835320e-06)*y2 + (-2.41498361533748e-05)) + (-4.30487707250530e-05)))  + (8.97167217021812e-06) + y2*(y2*(y2*((0.000141735440416280)*y2 + (0.000479178921972304)) + (0.000544157521874485)) + (0.000210275056813108)))  + (1.21319825925124e-05) + y2*(y2*(y2*(y2*((-0.000645016467225130)*y2 + (-0.00251687289333307)) + (-0.00329032034031329)) + (-0.00151824979097779)) + (-8.16597159954310e-05)))  + (0.000909338872673313) + y2*(y2*(y2*(y2*(y2*((0.00181838166402227)*y2 + (0.00783557504988342)) + (0.0108011510380893)) + (0.00420529704478072)) + (-0.000605795165620560)) + (0.000810430503323910)))  + (-0.00776505941118675) + y2*(y2*(y2*(y2*(y2*(y2*((-0.00268476903693715)*y2 + (-0.0130316521317318)) + (-0.0198586589754445)) + (-0.00737438124522966)) + (0.00209527098025530)) + (-0.00721185526704901)) + (-0.0126008967427799)))  + (0.116294045193668) + y2*(y2*(y2*(y2*(y2*(y2*(y2*((0.00138543647533724)*y2 + (0.0105534402562103)) + (0.0215232833104674)) + (0.00826556767652560)) + (-0.00631626007050606)) + (0.0197031757182000)) + (0.0528486800895992)) + (0.0790651759889045)))  + y2*(y2*(y2*(y2*(y2*(y2*(y2*((-0.00330937382644560)*y2 + (-0.00984303685396187)) + (-0.00353615752892107)) + (0.00548909064326438)) + (-0.0165198662527552)) + (-0.0570877777084003)) + (-0.146272750957203)) + (-0.943249296676852)) + (0.146947556383107));
    elseif p>fitSCrSH then //SCr2
      x6 := (p-8748123.91098647)/655717.790955289;
      y6 := (T-311.141099137607)/5.06539198333898;
      d  := 520.141191712727 + 132.771461173216 * ( y6*(y6*(y6*(y6*(y6*(y6*(y6*(y6*(y6*(y6*(y6*(y6*(y6*((-0.298178012233055)*y6 + (0.747849771197210) + x6*(1.16803534940368))  + (0.847537393484354) + x6*((-1.45567554833954)*x6 + (-2.81913154341892)))  + (-3.22187841503096) + x6*(x6*((0.0212016834650578)*x6 + (2.92431738126174)) + (-2.05116651593688)))  + (-0.0748785506661268) + x6*(x6*(x6*((1.21023719392890)*x6 + (1.84204174205785)) + (0.290430870605899)) + (9.91417869978960)))  + (4.55019400389451) + x6*(x6*(x6*(x6*((-0.177511479328071)*x6 + (-5.12275362933523)) + (2.76788877452717)) + (-7.69716462462876)) + (-3.09479174637471)))  + (-1.29920307304523) + x6*(x6*(x6*(x6*(x6*((-1.34439362630212)*x6 + (-0.0171595988573145)) + (-1.02954630612805)) + (-5.39472655492837)) + (9.02247377259854)) + (-8.79851794598821)))  + (-1.86393630103613) + x6*(x6*(x6*(x6*(x6*(x6*((1.24058029448972)*x6 + (7.52724517163994)) + (-3.35935525540068)) + (8.20950433571891)) + (-7.34127944833216)) + (-1.05851644958068)) + (5.18924490728675)))  + (0.627207010277484) + x6*(x6*(x6*(x6*(x6*(x6*(x6*((-0.382571152053025)*x6 + (-8.24946254733588)) + (3.75118458994685)) + (5.12492667983285)) + (-2.03601598635689)) + (11.2340232855916)) + (-2.83198221818727)) + (-1.51000934887228)))  + (-1.25055432090773) + x6*(x6*(x6*(x6*(x6*(x6*(x6*(x6*((0.0158676162432742)*x6 + (3.91207074919363)) + (-1.07829273027014)) + (-14.6494439545351)) + (6.08562473730137)) + (-1.45436694920430)) + (-9.19751576616594)) + (9.17603160047254)) + (1.67824241809135)))  + (0.609537441023140) + x6*(x6*(x6*(x6*(x6*(x6*(x6*(x6*((-0.745510861965781)*x6 + (-0.371767827147198)) + (11.2826357473987)) + (-2.68514348775898)) + (-12.9208249362613)) + (15.4783630576435)) + (-4.80746878494690)) + (-10.6595314290636)) + (5.52339218082805)))  + (1.83013675295057) + x6*(x6*(x6*(x6*(x6*(x6*(x6*(x6*((0.264503945768068)*x6 + (-4.38494526711220)) + (-0.271657627960563)) + (12.9949902203968)) + (-9.88933800795835)) + (-6.28598799206508)) + (15.7111663368957)) + (-5.12291744036501)) + (-4.38544686982793)))  + (-0.496057269759184) + x6*(x6*(x6*(x6*(x6*(x6*(x6*(x6*((0.821094599023782)*x6 + (0.448421804508581)) + (-5.40265226218143)) + (3.05561780651464)) + (7.74864183860309)) + (-10.1711899596684)) + (-0.428254216413120)) + (7.18430003854582)) + (-3.17235241931712)))  + (-2.12109458913731) + x6*(x6*(x6*(x6*(x6*(x6*(x6*(x6*((-0.216082822197661)*x6 + (1.00687697904626)) + (-0.215034001696591)) + (-3.17735080554194)) + (2.91186503856618)) + (2.30992667422972)) + (-4.31300591444439)) + (1.17919337426358)) + (1.69343393778883)))  + x6*(x6*(x6*(x6*(x6*(x6*(x6*(x6*((-0.157700659582568)*x6 + (0.1370155888406198)) + (0.689084577961732)) + (-0.660869409286897)) + (-0.937244770015876)) + (1.17253738535760)) + (0.175752018382295)) + (-1.01704457103339)) + (1.37348576442167)) +(0.0139611877532139));
    else //SH
      x1 := ( p - 5519495.79447002) / 2567703.39184083;
      y1 := (T-323.196143266723)/28.5422300266500;
      d := 132.091744019263 + 76.6522972242426 * (x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*(x1*((7.15487921614317e-05)*x1 + (-0.000186293075538892) + (0.000158640337862594)*y1)  + (-0.00265011383145745) + y1*((-0.00177261351999400)*y1 + (0.00417487913241615)))  + (0.000495265054733816) + y1*(y1*((0.00595637375150662)*y1 + (-0.0149332490903717)) + (0.00824627937624933)))  + (0.0174512144655053) + y1*(y1*(y1*((0.00644113577382396)*y1 + (-0.0294054443156379)) + (0.0547644631894267)) + (-0.0490519008171776)))  + (0.0171500109603422) + y1*(y1*(y1*(y1*((-0.0445539243958295)*y1 + (0.199845308894148)) + (-0.361637858402444)) + (0.331124788177358)) + (-0.141050144830697)))  + (0.00697505645251303) + y1*(y1*(y1*(y1*(y1*((0.0587289941449000)*y1 + (-0.349305438078168)) + (0.794279259209092)) + (-0.855765252276763)) + (0.435000419295625)) + (-0.0895191026576243)))  + (0.0637721470284816) + y1*(y1*(y1*(y1*(y1*(y1*((-0.0305980756691320)*y1 + (0.284103442427349)) + (-0.852220059293641)) + (1.12099169078695)) + (-0.658989014138355)) + (0.152276713823781)) + (-0.0673246981760775)))  + (0.232721507740677) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.00553839782424903)*y1 + (-0.109623517792320)) + (0.473195595542273)) + (-0.805704737418588)) + (0.540205525921847)) + (-0.0817699019842939)) + (0.105216593274550)) + (-0.274835535466439)))  + (1.01926707118493) + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0155731352048423)*y1 + (-0.124499607368792)) + (0.301605652645551)) + (-0.243348931432783)) + (-0.00617607581669293)) + (-0.0207597004660533)) + (0.257424821666076)) + (-0.456453407756215)))  + y1*(y1*(y1*(y1*(y1*(y1*(y1*((0.0105926422069889)*y1 + (-0.0445413553535566)) + (0.0503931240863202)) + (0.00878813080312919)) + (-0.0180496910371365)) + (-0.0626747233532592)) + (0.145751418029237)) + (-0.348266420768099)) + (-0.159545317255397));
    end if;
  end if;
end density_pT;

redeclare function extends dynamicViscosity
    "Calculates dynamic viscosity of refrigerant"

  /*The functional form of the dynamic viscosity is implented as presented in
  Huber et al. (2003), Model for the Viscosity and Thermal Conductivity of
  Refrigerants, Including a New Correlation for the Viscosity of R134a.
  Ind. Eng. Chem. Res(42)
  Afterwards, the coefficients are adapted to the HelmholtzMedia libary.
*/
protected
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Real phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";

    Real Tred = state.T/251.196 "Reduced temperature for lower density terms";
    Real omegaEta "Reduced effective collision cross section";
    Real etaZd "Dynamic viscosity for the limit of zero density";
    Real etaL "Dynamic viscosity for the limit of high density at bubble line";
    Real etaG "Dynamic viscosity for the limit of high density at dew line";
    Real etaExc;
    Real etaExcL;
    Real etaExcG;
algorithm
    // Check phase
    if state.phase == 0 then
      phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(
        sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase_dT :=state.phase;
    end if;
if (state.phase == 1 or phase_dT == 1) then

      // Calculate the dynamic visocity near the limit of zero density
      if abs(Tred)<1E-20 then
        Tred := 1E-20;
      end if;
      omegaEta := exp(0.235156-0.491266*Tred+0.05211155*Tred^2+0.05347906*Tred^3-0.1537102*Tred^4);
      etaZd := 1.00697*sqrt(state.T) / omegaEta;

      //Calculate excess viscosity
      etaExc := 0.4071119E-2 * state.d + 0.7198037E-4 * state.d^2 + 0.2411697E-16 * state.d^6 / Tred^3 + 0.2971072E-22 * state.d^8 - 0.1627888E-22 * state.d^8 / Tred;

      //Calculate the final dynamic viscosity
      eta := (etaExc+etaZd)*1e-6;

else
      // Calculate properties at bubble and dew line
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);

      // Calculate the dynamic visocity near the limit of zero density
      if abs(Tred)<1E-20 then
        Tred := 1E-20;
      end if;
      omegaEta := exp(0.235156-0.491266*Tred+0.05211155*Tred^2+0.05347906*Tred^3-0.1537102*Tred^4);
      etaZd := 1.00697*sqrt(state.T) / omegaEta;

      //Calculate excess viscosity
      etaExcL := 0.4071119E-2 * bubbleState.d + 0.7198037E-4 * bubbleState.d^2 + 0.2411697E-16 * bubbleState.d^6 / Tred^3 + 0.2971072E-22 * bubbleState.d^8 - 0.1627888E-22 * bubbleState.d^8 / Tred;
      etaExcG := 0.4071119E-2 * dewState.d + 0.7198037E-4 * dewState.d^2 + 0.2411697E-16 * dewState.d^6 / Tred^3 + 0.2971072E-22 * dewState.d^8 - 0.1627888E-22 * dewState.d^8 / Tred;

      //Calculate the final dynamic viscosity
      etaL := (etaExcL+etaZd)*1e-6;
      etaG := (etaExcG+etaZd)*1e-6;

      // Calculate the final dynamic visocity
      eta := (quality/etaG + (1 - quality)/etaL)^(-1);
end if;

end dynamicViscosity;

redeclare function extends thermalConductivity
    "Calculates thermal conductivity of refrigerant"
    /*The functional form of the thermal conductivity is implented as presented in
    G. Scalabrin et al (2006), A Reference Multiparameter Thermal Conductivity
    Equation for Carbon Dioxide with an Optimized Functional Form*/
protected
    SaturationProperties sat = setSat_T(state.T) "Saturation properties";
    Integer phase_dT "Phase calculated by density and temperature";

    ThermodynamicState bubbleState "Thermodynamic state at bubble line";
    ThermodynamicState dewState "Thermodynamic state at dew line";
    Real quality "Vapour quality";
    Real delta "Reduced density";
    Real deltaG "Reduced density at dew line";
    Real deltaL "Reduced density at bubble line";
    Real tau "Reduced temperature";
    Real lambdaG "thermal conductivity at bubble dew line";
    Real lambdaL "thermal conductivity at bubble dew line";
    Real lambdaR "Reduced thermal conductivity";
    Real lambdaRCri "Reduced thermal conductivity in critical region";
    Real lambdaRNonCri "Reduced thermal conductivity without critical region";
    Real lambdaRG "Reduced thermal conductivity";
    Real lambdaRCriG "Reduced thermal conductivity in critical region";
    Real lambdaRNonCriG "Reduced thermal conductivity without critical region";
    Real lambdaRL "Reduced thermal conductivity";
    Real lambdaRCriL "Reduced thermal conductivity in critical region";
    Real lambdaRNonCriL "Reduced thermal conductivity without critical region";
    Real alpha "coefficient for the critical region term";
    Real small = Modelica.Constants.small;

    final constant Real lambdaC = 4.81384;
    final constant Real n[11] = {
    7.69857587,
    0.159885811,
    1.56918621,
    -6.73400790,
    16.3890156,
    3.69415242,
    22.3205514,
    66.1420950,
    -0.171779133,
    0.00433043347,
    0.775547504};
    final constant Real g[10]= {
    0,
    0,
    1.5,
    0,
    1,
    1.5,
    1.5,
    1.5,
    3.5,
    5.5};
    final constant Integer h[10]= {
    1,
    5,
    1,
    1,
    2,
    0,
    5,
    9,
    0,
    0};
    final constant Real a[12]={
    3,
    6.70697,
    0.94604,
    0.3,
    0.3,
    0.39751,
    0.33791,
    0.77963,
    0.79857,
    0.90,
    0.02,
    0.20};

algorithm
  // Check phase
    if state.phase == 0 then
      phase_dT :=if not ((state.d < bubbleDensity(sat) and state.d > dewDensity(
        sat)) and state.T < fluidConstants[1].criticalTemperature) then 1 else 2;
    else
      phase_dT :=state.phase;
    end if;
      delta := state.d/467.6;
      tau   := state.T/304.1282;
    if (state.phase == 1 or phase_dT == 1) then
      // Calculate properties

      alpha := 1-a[10]*Modelica.Math.acosh(1+a[11]*((1-tau)^2)^a[12]);
      lambdaRNonCri :=
      sum(n[i] * tau^g[i] * delta^h[i] for i in 1:3)+
      exp(-5*delta^2)*sum(n[i]*tau^g[i]*delta^h[i] for i in 4:10);
      //Calculate correction term for critical region
      lambdaRCri :=
      (delta * exp(-delta^a[1]/a[1] - (a[2]*(tau-1))^2-(a[3]*(delta-1))^2))/
      ( ((((1-1/tau)+a[4]*((delta-1)^2)^(0.5/a[5]))^2)^a[6] + ((a[7]*(delta-alpha))^2)^a[8])^a[9]);
      lambdaR := lambdaRNonCri+n[11]*lambdaRCri;
      //Calculate the final thermal conductivity
      lambda :=lambdaC*lambdaR;
    else
      // Calculate properties
      bubbleState := setBubbleState(setSat_T(state.T));
      dewState := setDewState(setSat_T(state.T));
      quality := (bubbleState.d/state.d - 1)/(bubbleState.d/dewState.d - 1);
      deltaL :=bubbleState.d/467.6;
      deltaG :=dewState.d/467.6;

      alpha := 1-a[10]*Modelica.Math.acosh(1+a[11]*((1-tau)^2)^a[12]);
      lambdaRNonCriG :=
      sum(n[i] * tau^g[i] * deltaG^h[i] for i in 1:3)+
      exp(-5*deltaG^2)*sum(n[i]*tau^g[i]*deltaG^h[i] for i in 4:10);
      lambdaRNonCriL :=
      sum(n[i] * tau^g[i] * deltaL^h[i] for i in 1:3)+
      exp(-5*deltaL^2)*sum(n[i]*tau^g[i]*deltaL^h[i] for i in 4:10);
      //Calculate correction term for critical region
      lambdaRCriL :=
      (delta * exp(-deltaL^a[1]/a[1] - (a[2]*(tau-1))^2-(a[3]*(deltaL-1))^2))/
      ( ((((1-1/tau)+a[4]*((deltaL-1)^2)^(0.5/a[5]))^2)^a[6] + ((a[7]*(deltaL-alpha))^2)^a[8])^a[9]);
      lambdaRCriG :=
      (delta * exp(-deltaG^a[1]/a[1] - (a[2]*(tau-1))^2-(a[3]*(deltaG-1))^2))/
      ( ((((1-1/tau)+a[4]*((deltaG-1)^2)^(0.5/a[5]))^2)^a[6] + ((a[7]*(deltaG-alpha))^2)^a[8])^a[9]);
      lambdaRG := lambdaRNonCriG+lambdaRCriG;
      lambdaRL := lambdaRNonCriL+lambdaRCriL;
      //Calculate the final thermal conductivity
      lambdaG :=lambdaC*lambdaRG;
      lambdaL :=lambdaC*lambdaRL;
      // Calculate the final dynamic visocity
      lambda := (quality/lambdaG + (1 - quality)/lambdaL)^(-1);

    end if;
end thermalConductivity;

 redeclare function extends surfaceTension
    "Surface tension in two phase region of refrigerant"

  /*The functional form of the surface tension is implented as presented in
  Mulero and Cachadiña (2012), Recommended Correlations for the Surface Tension
  of Common Fluids. Journal of Physical and Chemical Reference Data 41,
  */
 algorithm
    sigma := 0.07863*(1-sat.Tsat/304.1282)^1.254;
 end surfaceTension;
end R744_IIR_P1_1000_T233_373_Horner;
