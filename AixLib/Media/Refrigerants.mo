within AixLib.Media;
package Refrigerants "Package with models for different refrigerants"
  package Interfaces "Package with interfaces for refrigerant models"
    extends Modelica.Icons.InterfacesPackage;
    partial package TemplateHybridTwoPhaseMedium
      "Template for media models using a hybrid aprroach"

      /*Provide basic definitions of the refrigerent. Therefore, fullfill constants
    or parameters and may add new constants or parameters if needed. Moreover,
    provide references within the information of the package.
  */
      constant Modelica.Media.Interfaces.PartialTwoPhaseMedium.FluidConstants[1] refrigerantConstants(
         each chemicalFormula = "CXHY",
         each structureFormula = "CXHY",
         each casRegistryNumber = "xx-xx-x",
         each iupacName = "name",
         each molarMass = 1,
         each criticalTemperature = 1,
         each criticalPressure = 1,
         each criticalMolarVolume = 1,
         each normalBoilingPoint = 1,
         each triplePointTemperature = 1,
         each meltingPoint = 1,
         each acentricFactor = 1,
         each triplePointPressure = 1,
         each dipoleMoment = 1,
         each hasCriticalData=true) "Thermodynamic constants for refrigerant";

      extends  AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium(
        mediumName = "Name",
        substanceNames = {"Name"},
        singleState = false,
        SpecificEnthalpy(
          start = 1.0e5,
          nominal = 1.0e5,
          min = 50e3,
          max = 1000e3),
        Density(
          start = 500,
          nominal = 500,
          min = 0.5,
          max = 100),
        AbsolutePressure(
          start = 1e5,
          nominal = 5e5,
          min = 0.5e5,
          max = 30e5),
        Temperature(
          start = 273.15,
          nominal = 273.15,
          min = 200.15,
          max = 423.15),
        smoothModel = true,
        onePhase = false,
        ThermoStates = Choices.IndependentVariables.phX,
        fluidConstants = refrigerantConstants);
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

      //redeclare record extends ThermodynamicState "Thermodynamic state"
      //  Density d "Density";
      //  Temperature T "Temperature";
      //  AbsolutePressure p "Pressure";
      //  SpecificEnthalpy h "Enthalpy";
      //end ThermodynamicState;
      /*The record "ThermodynamicState" contains the input arguments
    of all the function and is defined together with the used
    type definitions in PartialMedium. The record most often contains two of the
    variables "p, T, d, h" (e.g., medium.T)
  */

      redeclare replaceable model extends BaseProperties(
        h(stateSelect=StateSelect.prefer),
        d(stateSelect=StateSelect.default),
        T(stateSelect=StateSelect.default),
        p(stateSelect=StateSelect.prefer)) "Base properties of refrigerant"

        Integer phase(min=0, max=2, start=1)
        "2 for two-phase, 1 for one-phase, 0 if not known";
        SaturationProperties sat(Tsat(start=300.0), psat(start=1.0e5))
        "Saturation temperature and pressure";

      equation
        MM = fluidConstants[1].molarMass;
        phase = if ((h < bubbleEnthalpy(sat) or h > dewEnthalpy(sat)) or p >
              fluidConstants[1].criticalPressure) then 1 else 2;
        phase = state.phase;

        d = state.d; //density_ph(p=p,h=h,phase=phase);
        T = state.T; //temperature_ph(p=p,h=h,phase=phase);
        d = density_ph(p=p,h=h,phase=phase);
        T = temperature_ph(p=p,h=h,phase=phase);
        p = state.p; //pressure_dT(d, T, phase);
        h = state.h; //specificEnthalpy_dT(d, T, phase);

        sat.Tsat = saturationTemperature(p=p);
        sat.psat = p; //saturationPressure(T=T);

        u = h - p/d;
        R = Modelica.Constants.R/MM;
      end BaseProperties;
      /*Provide an implementation of model BaseProperties,
    that is defined in PartialMedium. Select two independent
    variables from p, T, d, u, h. The other independent
    variables are the mass fractions "Xi", if there is more
    than one substance. Provide 3 equations to obtain the remaining
    variables as functions of the independent variables.
    It is also necessary to provide two additional equations to set
    the gas constant R and the molar mass MM of the medium.
    Finally, the thermodynamic state vector, defined in the base class
    Interfaces.PartialMedium.BaseProperties, should be set, according to
    its definition (see ThermodynamicState below).
    The computation of vector X[nX] from Xi[nXi] is already included in
    the base class Interfaces.PartialMedium.BaseProperties, so it should not
    be repeated here.
    The code fragment above is for a single-substance medium with
    p,T as independent variables.
  */


      /*Provide polynomial functions for saturation properties. These functions are
    fitted to external data (e.g. data extracted from RefProp or FluidProp). The
    code fragments below are examples for fitting aproaches.
  */
      redeclare function extends saturationPressure
      "Saturation pressure of refrigerant (Ancillary equation)"
      protected
         Real N1 = -6.7722;
         Real N2 = 1.6938;
         Real N3 = -1.3341;
         Real N4 = -3.1876;
         Real N5 = 0.94937;
         Real T_crit = fluidConstants[1].criticalTemperature;
         Real T_trip = fluidConstants[1].triplePointTemperature;
         Real p_crit = fluidConstants[1].criticalPressure;
         Real p_trip = fluidConstants[1].triplePointPressure;
         Real OM = (1 - T/T_crit);

      algorithm
         if T>T_crit then
           p := p_crit;
         elseif T<T_trip then
           p := p_trip;
         else
           p := p_crit * exp(T_crit/T * (N1*OM + N2*OM^1.5 + N3*OM^2.2 + N4*OM^4.8 + N5*OM^6.2));
         end if;
      end saturationPressure;

      redeclare function extends saturationTemperature
      "Saturation temperature of refrigerant (Ancillary equation)"
      protected
         Real N[:] = {398148862.940126,-199919955.396472,-757908233.955288,367952699.725659,667046798.608578,-312549990.204649,-357938868.077720,161410013.061604,130510724.837043,-56445981.8598188,-34132767.2831829,14097753.3378770,6597033.14683305,-2588996.07334184,-956016.453555908,354129.363109993,104671.216535750,-36365.4299997343,-8551.71765339857,2737.41277992834,548.032269738263,-169.618396241937,-14.0609083306686,-0.171965430903563,5.14960741195450,-3.21018399915220,2.10314346387695,-1.50075370184942,1.08909694031671,-0.809987090417357,0.624647765942656,-0.509758482228388,0.452113517399419,-0.485252422559269,0.812915722176255,0.0497845322480886};
         Real mean_p = 1570581.06473046;
         Real std_p = 2557900;
         Real mean_T = 314.714456959068;
         Real std_T = 89.9988984287752;
         Real T_1 = 0;
         Real x;

      algorithm
          x := (p - mean_p)/std_p;
          for k in 1:35 loop
            T_1 := T_1 + N[k]*x^(36 - k);
          end for;
          T_1 := T_1 + N[36];
          T := T_1*std_T + mean_T;
      end saturationTemperature;

      redeclare function extends bubbleDensity
      "Boiling curve specific density of refrigerant (Ancillary equation)"
      protected
         Real N[:] = {168.562039493205,102.498679842295,-417.252850518645,-379.369839448631,259.875445333347,360.650888848736,-34.2860732305720,-167.388526468939,-38.3089822429208,32.2321439731247,16.2401795687420,-1.02099838936652,-2.73648898021723,-1.28146729979824,-0.699142505344287,-0.486571806528472,-0.362711228684454,-0.295698328266597,-0.257687633710071,-0.232292001969948,-0.214228995994567,-0.205569405748410,-0.209973677149465,-0.241754621811309,-0.319880945311610,-0.921191170759037,0.0299586382685047};
         Real mean_T = 303.15;
         Real std_T = 90;
         Real mean_b = 479.636056419640;
         Real std_b = 158.710809951891;
         Real dl_1 = 0;
         Real x;

      algorithm
          x := (sat.Tsat - mean_T)/std_T;
          for k in 1:26 loop
            dl_1 := dl_1 + N[k]*x^(27 - k);
          end for;
          dl_1 := dl_1 + N[27];
          dl := dl_1*std_b + mean_b;
      end bubbleDensity;

      redeclare function extends dewDensity
      "Dew curve specific density of refrigerant (Ancillary equation)"
      protected
         Real N[:] = {24729.5537485333,-4790.47306548912,-52999.2668562323,7058.92241323013,52982.2892015502,-2370.58912808463,-31858.6373859460,-1861.34451993193,12491.6995976091,2253.53926320725,-3122.52067135369,-1051.27601610942,412.382050285300,267.637744405501,12.9822226129711,-27.0147438072994,-10.2971934822874,-0.739113632299647,1.49114325185849,1.35527523720564,0.923630488185071,0.672792235972464,0.560751132479985,0.509690199864535,0.490192151807828,0.495282411314377,0.590898303947074,0.811832008381672,0.808375476827012,-0.0754744015174044};
         Real mean_T = 303.15;
         Real std_T = 90;
         Real mean_d = 28.4811865500103;
         Real std_d = 66.6559013317995;
         Real dv_1 = 0;
         Real x;

      algorithm
          x := (sat.Tsat - mean_T)/std_T;
          for k in 1:29 loop
            dv_1 := dv_1 + N[k]*x^(30 - k);
          end for;
          dv_1 := dv_1 + N[30];
          dv := dv_1*std_d + mean_d;
      end dewDensity;

      redeclare function extends bubbleEnthalpy
      "Boiling curve specific enthalpy of refrigerant (Ancillary equation)"
      protected
         Real N[:] = {-9294767843.63885,4601044486.87677,20637884091.3137,-9916466348.59996,-21359403718.5665,9947264847.89552,13636958532.2276,-6142679157.11019,-6000574809.17466,2607836222.80069,1926833832.78873,-805551262.020446,-466601813.162386,187005402.363897,86860131.7909424,-33235234.3082519,-12561996.4230609,4567071.19402525,1416354.06388980,-486313.365924655,-124542.594195178,40167.0083231862,8397.46595050577,-2498.28167363608,-462.619336965067,137.536958919031,6.47029425217843,2.64758244293881,-5.32098880051055,3.46672373461629,-2.26302221729487,1.59069973995372,-1.13913175345066,0.832473481266347,-0.610337601733258,0.487787294421858,-0.381084129429948,0.372237411342447,-0.349666671598220,0.849926390294104,0.0361438659731507};
         Real mean_p = 1570581.06473046;
         Real std_p = 2557900;
         Real mean_b = 315624.984387066;
         Real std_b = 256478.426329608;
         Real hl_1 = 0;
         Real x;

      algorithm
          x := (sat.psat - mean_p)/std_p;
          for k in 1:40 loop
            hl_1 := hl_1 + N[k]*x^(41 - k);
          end for;
          hl_1 := hl_1 + N[41];
          hl := hl_1*std_b + mean_b;
      end bubbleEnthalpy;

      redeclare function extends dewEnthalpy
      "Dew curve specific enthalpy of refrigerant (Ancillary equation)"
      protected
         Real N[:] = {-18775386313.6055,9394086287.20505,41644196829.4943,-20247895189.1885,-43051291028.3205,20309540510.1720,27452478313.3802,-12538264110.1784,-12063991762.7160,5319760814.06607,3868950611.13826,-1641348684.22018,-936106557.039505,380310593.940752,174364505.252102,-67425029.5319391,-25335355.2373842,9258056.41821587,2898773.57918601,-997509.402878578,-263711.217390457,88279.4166642683,18539.6674822496,-7265.37195240485,-791.349145978091,783.380077339674,-118.386708715477,-87.4509889200359,28.7466309562791,22.7165909170454,-12.9134840899498,0.379188043464810,-1.09461342269619,2.21831905224981,-1.37432108544607,0.840516589045987,-0.879264408088915,0.602870738214699,-0.988765189667206,0.736977778701680,0.0980593948500622};
         Real mean_p=1570581.06473046;
         Real std_p=2557900;
         Real mean_d=611770.954390520;
         Real std_d=72569.9367503185;
         Real hv_1=0;
         Real x;

      algorithm
          x := (sat.psat - mean_p)/std_p;
          for k in 1:40 loop
            hv_1 := hv_1 + N[k]*x^(41 - k);
          end for;
          hv_1 := hv_1 + N[41];
          hv := hv_1*std_d + mean_d;
      end dewEnthalpy;

      redeclare function extends bubbleEntropy
      "Boiling curve specific entropy of refrigerant (Ancillary equation)"
      protected
         Real N[:] = {-15349607814.6221,7636274154.59154,34083168950.6415,-16468859514.8044,-35274256182.5208,16529163595.4961,22520438414.7263,-10212384678.3319,-9909434496.20396,4337708567.68782,3182094478.82347,-1340537038.41870,-770642130.029990,311344581.740643,143483390.503767,-55358907.3112437,-20756825.7164981,7610600.46375838,2341379.49521742,-810782.536880512,-205991.835180489,66975.5024566354,13911.5167143464,-4172.85884728481,-763.056131634308,226.059931948838,12.7752539636391,3.11268958206643,-7.85167676769299,5.00328992083909,-3.24391515196012,2.26101216009097,-1.60045805379047,1.15217954418816,-0.838779616598381,0.651059130787342,-0.506702271997059,0.465184273228716,-0.435627195532008,0.805470640142587,0.0457609974234471};
         Real mean_p = 1570581.06473046;
         Real std_p = 2557900;
         Real mean_b = 1376.30588505819;
         Real std_b = 826.068105213303;
         Real sl_1 = 0;
         Real x;

      algorithm
          x := (sat.psat - mean_p)/std_p;
          for k in 1:40 loop
            sl_1 := sl_1 + N[k]*x^(41 - k);
          end for;
          sl_1 := sl_1 + N[41];
          sl := sl_1*std_b + mean_b;
      end bubbleEntropy;

      redeclare function extends dewEntropy
      "Dew curve specific entropy of propane (Ancillary equation)"
      protected
         Real N[:] = {77490431827.9399,-38415276654.6987,-172242854661.379,82962121367.1925,178399484846.286,-83356734431.6106,-113970547248.801,51553752249.9676,50177422017.5857,-21921194748.1992,-16120343329.1663,6783508534.79747,3904793200.14042,-1578181058.50373,-726577962.821200,281202937.346275,104799948.851401,-38715062.2946953,-11716161.8016396,4105031.67420979,1007213.05553646,-326165.883627773,-65541.5043152719,16329.6212516804,3852.60757433586,91.0319174951408,-343.494332982509,-224.377993905924,107.459438248960,24.4635507698644,-8.50688453256311,-13.0500554559933,6.58097770859788,-1.42438707828771,1.58146106221061,-1.50959232991508,0.669411569821680,-0.759627313555789,-0.113920392204933,-0.624499077638527,-0.00619048868799449};
         Real mean_p = 1570581.06473046;
         Real std_p = 2557900;
         Real mean_d = 2335.75170536325;
         Real std_d = 97.9077112667096;
         Real sv_1 = 0;
         Real x;

      algorithm
          x := (sat.psat - mean_p)/std_p;
          for k in 1:40 loop
            sv_1 := sv_1 + N[k]*x^(41 - k);
          end for;
          sv_1 := sv_1 + N[41];
          sv := sv_1*std_d + mean_d;
      end dewEntropy;


      /*Provide Helmholtz equatos of state (EoS). These EoS must be fitted to
    different refrigerents. However, the structure will not change and, therefore,
    the coefficients, which are obtained during the fitting procedure, are 
    provided with a record.
    Just change if needed.
  */
      redeclare function extends alpha_0
      "Dimensionless Helmholz energy (Ideal gas contribution alpha_0)"
      protected
          Real a1 = -4.970583;
          Real a2 = 4.29352;
          Real a3 = 3.043;
          Real a4 = 5.874;
          Real a5 = 9.337;
          Real a6 = 7.922;
          Real b3 = 1.062478;
          Real b4 = 3.344237;
          Real b5 = 5.363757;
          Real b6 = 11.762957;

      algorithm
          alpha_0 := log(delta) + 3*log(tau) + a1 + a2*tau + a3*log(1-exp(-b3*tau)) + a4*log(1-exp(-b4*tau)) + a5*log(1-exp(-b5*tau)) + a6*log(1-exp(-b6*tau)); // verified
      end alpha_0;

      redeclare function extends alpha_r
      "Dimensionless Helmholz energy (Residual part alpha_r)"
      protected
          Real Nk[:] = {0.042910051, 1.7313671, -2.4516524, 0.34157466, -0.46047898, -0.66847295, 0.20889705, 0.19421381, -0.22917851, -0.60405866, 0.066680654, 0.017534618, 0.33874242, 0.22228777, -0.23219062, -0.092206940, -0.47575718, -0.017486824};
          Real tk[:] = {1.00, 0.33, 0.80, 0.43, 0.90, 2.46, 2.09, 0.88, 1.09, 3.25, 4.62, 0.76, 2.50, 2.75, 3.05, 2.55, 8.40, 6.75};
          Real dk[:] = {4,1,1,2,2,1,3,6,6,2,3,1,1,1,2,2,4,1};
          Real lk[:] = {0,0,0,0,0,1,1,1,1,2,2,0,0,0,0,0,0,0};
          Real eta_k[:] = {0,0,0,0,0,0,0,0,0,0,0,0.963,1.977,1.917,2.307,2.546,3.28,14.6};
          Real beta_k[:] = {0,0,0,0,0,0,0,0,0,0,0,2.33,3.47,3.15,3.19,0.92,18.8,547.8};
          Real gamma_k[:] = {0,0,0,0,0,0,0,0,0,0,0,0.684,0.829,1.419,0.817,1.500,1.426,1.093};
          Real eps_k[:] = {0,0,0,0,0,0,0,0,0,0,0,1.283,0.6936,0.788,0.473,0.8577,0.271,0.948};

      algorithm
          for k in 1:5 loop
            alpha_r :=alpha_r + Nk[k]*delta^dk[k]*tau^tk[k];
          end for;
          for k in 6:11 loop
            alpha_r :=alpha_r + Nk[k]*delta^dk[k]*tau^tk[k]*exp(-delta^lk[k]);
          end for;
          for k in 12:18 loop
            alpha_r :=alpha_r + Nk[k]*delta^dk[k]*tau^tk[k]*exp(-eta_k[k]*(delta - eps_k[k])
              ^2 - beta_k[k]*(tau - gamma_k[k])^2); // verified
          end for;
      end alpha_r;

      redeclare function extends tau_d_alpha_0_d_tau
      "Short form for tau*(dalpha_0/dtau)@delta=const"
      protected
        Real a1 = -4.970583;
        Real a2 = 4.29352;
        Real a3 = 3.043;
        Real a4 = 5.874;
        Real a5 = 9.337;
        Real a6 = 7.922;
        Real b3 = 1.062478;
        Real b4 = 3.344237;
        Real b5 = 5.363757;
        Real b6 = 11.762957;
      algorithm
        tau_d_alpha_0_d_tau := 3 + a2*tau + tau*(a3*b3*(1/(exp(b3*tau) - 1)) + a4*b4*
        (1/(exp(b4*tau) - 1)) + a5*b5*(1/(exp(b5*tau) - 1)) + a6*b6*(1/(exp(b6*tau) -
        1))); // verified
      end tau_d_alpha_0_d_tau;

      redeclare function extends tau_d_alpha_r_d_tau
      "Short form for tau*(dalpha_r/dtau)@delta=const"
      protected
        Real Nk[:] = {0.042910051, 1.7313671, -2.4516524, 0.34157466, -0.46047898, -0.66847295, 0.20889705, 0.19421381, -0.22917851, -0.60405866, 0.066680654, 0.017534618, 0.33874242, 0.22228777, -0.23219062, -0.092206940, -0.47575718, -0.017486824};
        Real tk[:] = {1.00, 0.33, 0.80, 0.43, 0.90, 2.46, 2.09, 0.88, 1.09, 3.25, 4.62, 0.76, 2.50, 2.75, 3.05, 2.55, 8.40, 6.75};
        Real dk[:] = {4,1,1,2,2,1,3,6,6,2,3,1,1,1,2,2,4,1};
        Real lk[:] = {0,0,0,0,0,1,1,1,1,2,2,0,0,0,0,0,0,0};
        Real eta_k[:] = {0,0,0,0,0,0,0,0,0,0,0,0.963,1.977,1.917,2.307,2.546,3.28,14.6};
        Real beta_k[:] = {0,0,0,0,0,0,0,0,0,0,0,2.33,3.47,3.15,3.19,0.92,18.8,547.8};
        Real gamma_k[:] = {0,0,0,0,0,0,0,0,0,0,0,0.684,0.829,1.419,0.817,1.500,1.426,1.093};
        Real eps_k[:] = {0,0,0,0,0,0,0,0,0,0,0,1.283,0.6936,0.788,0.473,0.8577,0.271,0.948};

      algorithm
        for k in 1:5 loop
          tau_d_alpha_r_d_tau :=tau_d_alpha_r_d_tau + Nk[k]*delta^dk[k]*tau^tk[k]*
          tk[k];
        end for;
        for k in 6:11 loop
          tau_d_alpha_r_d_tau :=tau_d_alpha_r_d_tau + Nk[k]*delta^dk[k]*tau^tk[k]*
          exp(-delta^lk[k])*tk[k];
        end for;
        for k in 12:18 loop
          tau_d_alpha_r_d_tau :=tau_d_alpha_r_d_tau + Nk[k]*delta^dk[k]*tau^tk[k]*
          exp(-eta_k[k]*(delta - eps_k[k])^2 - beta_k[k]*(tau - gamma_k[k])^2)*(tk[
          k] - 2*beta_k[k]*tau*(tau - gamma_k[k]));
        end for; // verified
      end tau_d_alpha_r_d_tau;

      redeclare function extends tau_delta_d2_alpha_r_d_tau_d_delta
      "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
      protected
          Real Nk[:] =   {0.042910051,1.7313671, -2.4516524, 0.34157466, -0.46047898, -0.66847295, 0.20889705, 0.19421381, -0.22917851, -0.60405866, 0.066680654, 0.017534618, 0.33874242, 0.22228777, -0.23219062, -0.092206940, -0.47575718, -0.017486824};
          Real tk[:] =   {1.00, 0.33, 0.80, 0.43, 0.90, 2.46, 2.09, 0.88, 1.09, 3.25, 4.62, 0.76, 2.50, 2.75, 3.05, 2.55, 8.40, 6.75};
          Real dk[:] =   {4,1,1,2,2,1,3,6,6,2,3,1,1,1,2,2,4,1};
          Real lk[:] =  {0,0,0,0,0,1,1,1,1,2,2,0,0,0,0,0,0,0};
          Real eta_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,0.963,1.977,1.917,2.307,2.546,3.28,14.6};
          Real beta_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,2.33,3.47,3.15,3.19,0.92,18.8,547.8};
          Real gamma_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,0.684,0.829,1.419,0.817,1.500,1.426,1.093};
          Real eps_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,1.283,0.6936,0.788,0.473,0.8577,0.271,0.948};

      algorithm
          for k in 1:5 loop
            tau_delta_d2_alpha_r_d_tau_d_delta :=tau_delta_d2_alpha_r_d_tau_d_delta +
            Nk[k]*delta^dk[k]*tau^tk[k]*dk[k]*tk[k];
          end for;
          for k in 6:11 loop
            tau_delta_d2_alpha_r_d_tau_d_delta :=tau_delta_d2_alpha_r_d_tau_d_delta +
            Nk[k]*delta^dk[k]*tau^tk[k]*exp(-delta^lk[k])*tk[k]*(dk[k] - lk[k]*delta^
            lk[k]);
          end for;
          for k in 12:18 loop
            tau_delta_d2_alpha_r_d_tau_d_delta :=tau_delta_d2_alpha_r_d_tau_d_delta +
            Nk[k]*delta^dk[k]*tau^tk[k]*exp(-eta_k[k]*(delta - eps_k[k])^2 - beta_k[k]
            *(tau - gamma_k[k])^2)*((dk[k] - 2*eta_k[k]*delta*(delta - eps_k[k]))*(tk[
             k] - 2*beta_k[k]*tau*(tau - gamma_k[k]))); // verified
          end for;
      end tau_delta_d2_alpha_r_d_tau_d_delta;

      redeclare function extends tau2_d2_alpha_r_d_tau2
      "Short form for tau*tau*(ddalpha_r/(dtau*dtau))@delta=const"
      protected
          Real Nk[:] = {0.042910051, 1.7313671, -2.4516524, 0.34157466, -0.46047898, -0.66847295, 0.20889705, 0.19421381, -0.22917851, -0.60405866, 0.066680654, 0.017534618, 0.33874242, 0.22228777, -0.23219062, -0.092206940, -0.47575718, -0.017486824};
          Real tk[:] = {1.00, 0.33, 0.80, 0.43, 0.90, 2.46, 2.09, 0.88, 1.09, 3.25, 4.62, 0.76, 2.50, 2.75, 3.05, 2.55, 8.40, 6.75};
          Real dk[:] = {4,1,1,2,2,1,3,6,6,2,3,1,1,1,2,2,4,1};
          Real lk[:] = {0,0,0,0,0,1,1,1,1,2,2,0,0,0,0,0,0,0};
          Real eta_k[:] = {0,0,0,0,0,0,0,0,0,0,0,0.963,1.977,1.917,2.307,2.546,3.28,14.6};
          Real beta_k[:] = {0,0,0,0,0,0,0,0,0,0,0,2.33,3.47,3.15,3.19,0.92,18.8,547.8};
          Real gamma_k[:] = {0,0,0,0,0,0,0,0,0,0,0,0.684,0.829,1.419,0.817,1.500,1.426,1.093};
          Real eps_k[:] = {0,0,0,0,0,0,0,0,0,0,0,1.283,0.6936,0.788,0.473,0.8577,0.271,0.948};

      algorithm
          for k in 1:5 loop
            tau2_d2_alpha_r_d_tau2 :=tau2_d2_alpha_r_d_tau2 + Nk[k]*delta^dk[k]*tau
            ^tk[k]*tk[k]*(tk[k] - 1);
          end for;
          for k in 6:11 loop
            tau2_d2_alpha_r_d_tau2 :=tau2_d2_alpha_r_d_tau2 + Nk[k]*delta^dk[k]*tau
            ^tk[k]*exp(-delta^lk[k])*tk[k]*(tk[k] - 1);
          end for;
          for k in 12:18 loop
            tau2_d2_alpha_r_d_tau2 :=tau2_d2_alpha_r_d_tau2 + Nk[k]*delta^dk[k]*tau
            ^tk[k]*exp(-eta_k[k]*(delta - eps_k[k])^2 - beta_k[k]*(tau - gamma_k[k])
            ^2)*((tk[k] - 2*beta_k[k]*tau*(tau - gamma_k[k]))^2 - tk[k] - 2*beta_k[
            k]*tau^2); // verified
          end for;
      end tau2_d2_alpha_r_d_tau2;

      redeclare function extends tau2_d2_alpha_0_d_tau2
      "Short form for tau*tau*(ddalpha_0/(dtau*dtau))@delta=const"
      protected
          Real a3 = 3.043;
          Real a4 = 5.874;
          Real a5 = 9.337;
          Real a6 = 7.922;
          Real b3 = 1.062478;
          Real b4 = 3.344237;
          Real b5 = 5.363757;
          Real b6 = 11.762957;
      algorithm
          tau2_d2_alpha_0_d_tau2 :=-3 - tau^2*(a3*b3^2*(exp(b3*tau)/(exp(b3*tau) -
          1)^2) + a4*b4^2*(exp(b4*tau)/(exp(b4*tau) - 1)^2) + a5*b5^2*(exp(b5*tau)/
          (exp(b5*tau) - 1)^2) + a6*b6^2*(exp(b6*tau)/(exp(b6*tau) - 1)^2)); // verified
      end tau2_d2_alpha_0_d_tau2;

      redeclare function extends delta_d_alpha_r_d_delta
      "Short form for delta*(dalpha_r/(ddelta))@tau=const"
      protected
          Real Nk[:] =   {0.042910051,1.7313671, -2.4516524, 0.34157466, -0.46047898, -0.66847295, 0.20889705, 0.19421381, -0.22917851, -0.60405866, 0.066680654, 0.017534618, 0.33874242, 0.22228777, -0.23219062, -0.092206940, -0.47575718, -0.017486824};
          Real tk[:] =   {1.00, 0.33, 0.80, 0.43, 0.90, 2.46, 2.09, 0.88, 1.09, 3.25, 4.62, 0.76, 2.50, 2.75, 3.05, 2.55, 8.40, 6.75};
          Real dk[:] =   {4,1,1,2,2,1,3,6,6,2,3,1,1,1,2,2,4,1};
          Real lk[:] =  {0,0,0,0,0,1,1,1,1,2,2,0,0,0,0,0,0,0};
          Real eta_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,0.963,1.977,1.917,2.307,2.546,3.28,14.6};
          Real beta_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,2.33,3.47,3.15,3.19,0.92,18.8,547.8};
          Real gamma_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,0.684,0.829,1.419,0.817,1.500,1.426,1.093};
          Real eps_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,1.283,0.6936,0.788,0.473,0.8577,0.271,0.948};

      algorithm
          for k in 1:5 loop
            delta_d_alpha_r_d_delta :=delta_d_alpha_r_d_delta + Nk[k]*delta^dk[k]*tau^
            tk[k]*dk[k];
          end for;
          for k in 6:11 loop
            delta_d_alpha_r_d_delta :=delta_d_alpha_r_d_delta + Nk[k]*delta^dk[k]*tau^
            tk[k]*exp(-delta^lk[k])*(dk[k] - lk[k]*delta^lk[k]);
          end for;
          for k in 12:18 loop
            delta_d_alpha_r_d_delta :=delta_d_alpha_r_d_delta + Nk[k]*delta^dk[k]*tau^
            tk[k]*exp(-eta_k[k]*(delta - eps_k[k])^2 - beta_k[k]*(tau - gamma_k[k])^2)
            *(dk[k] - 2*eta_k[k]*delta*(delta - eps_k[k])); // verified
          end for;
      end delta_d_alpha_r_d_delta;

      redeclare function extends delta3_d3_alpha_r_d_delta3
      "Short form for delta*delta*delta(dddalpha_r/(ddelta*delta*delta))@tau=const"
      protected
          Real Nk[:] =   {0.042910051,1.7313671, -2.4516524, 0.34157466, -0.46047898, -0.66847295, 0.20889705, 0.19421381, -0.22917851, -0.60405866, 0.066680654, 0.017534618, 0.33874242, 0.22228777, -0.23219062, -0.092206940, -0.47575718, -0.017486824};
          Real tk[:] =   {1.00, 0.33, 0.80, 0.43, 0.90, 2.46, 2.09, 0.88, 1.09, 3.25, 4.62, 0.76, 2.50, 2.75, 3.05, 2.55, 8.40, 6.75};
          Real dk[:] =   {4,1,1,2,2,1,3,6,6,2,3,1,1,1,2,2,4,1};
          Real lk[:] =  {0,0,0,0,0,1,1,1,1,2,2,0,0,0,0,0,0,0};
          Real eta_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,0.963,1.977,1.917,2.307,2.546,3.28,14.6};
          Real beta_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,2.33,3.47,3.15,3.19,0.92,18.8,547.8};
          Real gamma_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,0.684,0.829,1.419,0.817,1.500,1.426,1.093};
          Real eps_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,1.283,0.6936,0.788,0.473,0.8577,0.271,0.948};

      algorithm
          for k in 1:5 loop
            delta3_d3_alpha_r_d_delta3 :=delta3_d3_alpha_r_d_delta3 + Nk[k]*delta^dk[
            k]*tau^tk[k]*dk[k]*(dk[k] - 1)*(dk[k] - 2);
          end for;
          for k in 6:11 loop
            delta3_d3_alpha_r_d_delta3 :=delta3_d3_alpha_r_d_delta3 + Nk[k]*delta^dk[
            k]*tau^tk[k]*exp(-delta^lk[k])*(dk[k]*(dk[k] - 1)*(dk[k] - 2) + lk[k]*
            delta^lk[k]*(-2 + 6*dk[k] - 3*dk[k]^2 - 3*dk[k]*lk[k] + 3*lk[k] - lk[k]^2)
             + 3*lk[k]^2*delta^(2*lk[k])*(dk[k] - 1 + lk[k]) - lk[k]^3*delta^(3*lk[k]));
          end for;
          for k in 12:18 loop
            delta3_d3_alpha_r_d_delta3 :=delta3_d3_alpha_r_d_delta3 + Nk[k]*delta^dk[
            k]*tau^tk[k]*exp(-eta_k[k]*(delta - eps_k[k])^2 - beta_k[k]*(tau -
            gamma_k[k])^2)*((dk[k] - 2*eta_k[k]*delta*(delta - eps_k[k]))^3 - 3*dk[k]^
            2 + 2*dk[k] - 6*dk[k]*eta_k[k]*delta^2 + 6*eta_k[k]*delta*(delta - eps_k[k])*(dk[k] +
            2*eta_k[k]*delta^2)); // verified
          end for;
      end delta3_d3_alpha_r_d_delta3;

      redeclare function extends delta2_d2_alpha_r_d_delta2
      "Short form for delta*delta(ddalpha_r/(ddelta*delta))@tau=const"
      protected
          Real Nk[:] =   {0.042910051,1.7313671, -2.4516524, 0.34157466, -0.46047898, -0.66847295, 0.20889705, 0.19421381, -0.22917851, -0.60405866, 0.066680654, 0.017534618, 0.33874242, 0.22228777, -0.23219062, -0.092206940, -0.47575718, -0.017486824};
          Real tk[:] =   {1.00, 0.33, 0.80, 0.43, 0.90, 2.46, 2.09, 0.88, 1.09, 3.25, 4.62, 0.76, 2.50, 2.75, 3.05, 2.55, 8.40, 6.75};
          Real dk[:] =   {4,1,1,2,2,1,3,6,6,2,3,1,1,1,2,2,4,1};
          Real lk[:] =  {0,0,0,0,0,1,1,1,1,2,2,0,0,0,0,0,0,0};
          Real eta_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,0.963,1.977,1.917,2.307,2.546,3.28,14.6};
          Real beta_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,2.33,3.47,3.15,3.19,0.92,18.8,547.8};
          Real gamma_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,0.684,0.829,1.419,0.817,1.500,1.426,1.093};
          Real eps_k[:] =  {0,0,0,0,0,0,0,0,0,0,0,1.283,0.6936,0.788,0.473,0.8577,0.271,0.948};

      algorithm
          for k in 1:5 loop
            delta2_d2_alpha_r_d_delta2 :=delta2_d2_alpha_r_d_delta2 + Nk[k]*delta^
            dk[k]*tau^tk[k]*dk[k]*(dk[k] - 1);
          end for;
          for k in 6:11 loop
            delta2_d2_alpha_r_d_delta2 :=delta2_d2_alpha_r_d_delta2 + Nk[k]*delta^
            dk[k]*tau^tk[k]*exp(-delta^lk[k])*((dk[k] - lk[k]*delta^lk[k])*(dk[k]
             - 1 - lk[k]*delta^lk[k]) - lk[k]^2*delta^lk[k]);
          end for;
          for k in 12:18 loop
            delta2_d2_alpha_r_d_delta2 :=delta2_d2_alpha_r_d_delta2 + Nk[k]*delta^
            dk[k]*tau^tk[k]*exp(-eta_k[k]*(delta - eps_k[k])^2 - beta_k[k]*(tau -
            gamma_k[k])^2)*((dk[k] - 2*eta_k[k]*delta*(delta - eps_k[k]))^2 - dk[k]
             - 2*eta_k[k]*delta^2); // verified
          end for;
      end delta2_d2_alpha_r_d_delta2;


      /*Provide functions to calculate further thermodynamic properties like the
    dynamic viscosity or thermal concutivity. Add references.
  */
      redeclare function extends dynamicViscosity
      "Calculates dynamic viscosity of refrigerant"

      algorithm

      end dynamicViscosity;

      redeclare function extends thermalConductivity
      "Calculates thermal conductivity of refrigerant"

      algorithm

      end thermalConductivity;

      redeclare function extends surfaceTension
      "Surface tension in two phase region of refrigerant"

      algorithm

      end surfaceTension;


      /*Provide functions to calculate further thermodynamic properties depending on
    thermodynamic properties. These functions are polynomial fits in order to
    reduce computing time. Add furhter fits if necessary.
  */
      redeclare function temperature_ph "returns temperature for given p and h"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Enthalpy";
        input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "Temperature";

      protected
          Real c2[:]={291.384236041825,-0.0704729863184529,20.5578417380748,-0.00678884566695906,0.136811720776647,-0.770247506716285,0.000202836611783306,-0.00447602797382070,0.0309332207143316,-0.0386472469260710,-9.71248676197528e-06,0.000273729410002939,-0.00177519423682889,0.00767135438646387,-0.00751600683912493,7.98267274869292e-07,-1.12691051342428e-05,0.000134930636679386,-0.000392485634748443,0.00140205757787774,-0.00163000559967510};
          Real meanx2=1682457.51267010;
          Real meany2=247137.397786416;
          Real stdx2=720642.233056887;
          Real stdy2=54003.5903158973;
          Real x2=(p-meanx2)/stdx2;
          Real y2=(h-meany2)/stdy2;
          Real T2=c2[1] + c2[2]*x2 + c2[3]*y2 + c2[4]*x2^2 + c2[5]*x2*y2 + c2[6]*y2^2 + c2[7]*x2^3 + c2[8]*x2^2*y2 + c2[9]*x2*y2^2 + c2[10]*y2^3 + c2[11]*x2^4 + c2[12]*x2^3*y2 + c2[13]*x2^2*y2^2 + c2[14]*x2*y2^3 + c2[15]*y2^4 + c2[16]*x2^5 + c2[17]*x2^4*y2 + c2[18]*x2^3*y2^2 + c2[19]*x2^2*y2^3 + c2[20]*x2*y2^4 + c2[21]*y2^5;
          Real c1[:]={308.060027778396,6.59039876392094,20.7950243141380,0.0453108439023189,-1.43969687581506,-0.411365889418558,0.00540769150996739,-0.0188305448625778,0.255977908649908,-0.00497446957449581,-0.000196566506959251,-0.00847992074678385,0.00660309588666398,-0.0432200997543392,0.00465132954244280,-4.64422678045603e-05,0.000787074643540945,0.00281445602040784,-0.00176606807260317,0.00590025752789791,-0.000577281104194347};
          Real meanx1=382099.574228781;
          Real meany1=639399.497939419;
          Real stdx1=403596.556578661;
          Real stdy1=37200.2691858212;
          Real x1=(p-meanx1)/stdx1;
          Real y1=(h-meany1)/stdy1;
          Real T1=c1[1] + c1[2]*x1 + c1[3]*y1 + c1[4]*x1^2 + c1[5]*x1*y1 + c1[6]*y1^2 + c1[7]*x1^3 + c1[8]*x1^2*y1 + c1[9]*x1*y1^2 + c1[10]*y1^3 + c1[11]*x1^4 + c1[12]*x1^3*y1 + c1[13]*x1^2*y1^2 + c1[14]*x1*y1^3 + c1[15]*y1^4 + c1[16]*x1^5 + c1[17]*x1^4*y1 + c1[18]*x1^3*y1^2 + c1[19]*x1^2*y1^3 + c1[20]*x1*y1^4 + c1[21]*y1^5;
          SpecificEnthalpy dh=10;
          SaturationProperties sat;
          SpecificEnthalpy h_dew;
          SpecificEnthalpy h_bubble;

      algorithm
          sat.psat:=p;
          h_dew:=dewEnthalpy(sat);
          h_bubble:=bubbleEnthalpy(sat);

            if h<h_bubble-dh then
              T:=T2;
            elseif h>h_dew+dh then
              T:=T1;
          else
              if h<h_bubble then
                  T:=saturationTemperature(p)*(1 - (h_bubble - h)/dh) + T2*(h_bubble -
              h)/dh;
              elseif h>h_dew then
                  T:=saturationTemperature(p)*(1 - (h - h_dew)/dh) + T1*(h - h_dew)/
              dh;
              else
      //            %quality=(h-h_bubble)/(h_dew-h_bubble);
                  T:=saturationTemperature(p);
              end if;
          end if;

      annotation(derivative(noDerivative=phase)=temperature_ph_der,
          inverse(h=specificEnthalpy_pT(p=p,T=T,phase=phase)),
              Inline=false,
              LateInline=true);
      end temperature_ph;

      redeclare function temperature_ps "returns temperature for a given p and s"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Entropy";
        input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output Temperature T "specific enthalpy";

      protected
          Real c2[:]={290.574168937952,0.490828546245446,19.8608752914032,0.117871744016533,0.130154107880201,-0.0408172235661160,0.0181671755438826,0.0292848788419663,0.0324083687227166,-0.0857625427384498,0.00191602988674819,0.00377150163705040,0.00622225803519055,0.00799217399325639,-0.0124017661200968,0.000114975996621020,0.000243666235393007,0.000459514035453056,0.000907175802732240,0.00127247920370296,-0.00192723964571896};
          Real meanx2=14.225189003160570;
          Real meany2=1.152465068418020e+03;
          Real stdx2=0.499169296800688;
          Real stdy2=1.792997138404026e+02;
          Real x2=(log(p)-meanx2)/stdx2;
          Real y2=(s-meany2)/stdy2;
          Real T2=c2[1] + c2[2]*x2 + c2[3]*y2 + c2[4]*x2^2 + c2[5]*x2*y2 + c2[6]*y2^2 + c2[7]*x2^3 + c2[8]*x2^2*y2 + c2[9]*x2*y2^2 + c2[10]*y2^3 + c2[11]*x2^4 + c2[12]*x2^3*y2 + c2[13]*x2^2*y2^2 + c2[14]*x2*y2^3 + c2[15]*y2^4 + c2[16]*x2^5 + c2[17]*x2^4*y2 + c2[18]*x2^3*y2^2 + c2[19]*x2^2*y2^3 + c2[20]*x2*y2^4 + c2[21]*y2^5;

          Real c1[:]={305.667994209752,34.3546579581206,36.3220486736092,0.956829304294540,0.239229453753890,0.702977715170277,0.129780738468536,-0.303362575167080,0.000814283563881690,-0.100508863694088,0.0577060502424694,-0.0264862744961215,0.0826586807740864,-0.00125351482775024,0.0160903628800248,0.0132124973316544,-0.00720862103838031,0.00736011556482272,-0.00773556171071259,0.00365836572791750,-0.000494569833066580};
          Real meanx1=12.3876547448383;
          Real meany1=2715.65359560750;
          Real stdx1=0.961902709412239;
          Real stdy1=207.473158311391;
          Real x1=(log(p)-meanx1)/stdx1;
          Real y1=(s-meany1)/stdy1;
          Real T1=c1[1] + c1[2]*x1 + c1[3]*y1 + c1[4]*x1^2 + c1[5]*x1*y1 + c1[6]*y1^2 + c1[7]*x1^3 + c1[8]*x1^2*y1 + c1[9]*x1*y1^2 + c1[10]*y1^3 + c1[11]*x1^4 + c1[12]*x1^3*y1 + c1[13]*x1^2*y1^2 + c1[14]*x1*y1^3 + c1[15]*y1^4 + c1[16]*x1^5 + c1[17]*x1^4*y1 + c1[18]*x1^3*y1^2 + c1[19]*x1^2*y1^3 + c1[20]*x1*y1^4 + c1[21]*y1^5;

          SpecificEntropy ds=10;
          SaturationProperties sat;
          SpecificEntropy s_dew;
          SpecificEntropy s_bubble;

      algorithm
          sat:=setSat_p(p=p);
          s_dew:=dewEntropy(sat);
          s_bubble:=bubbleEntropy(sat);
          if s<s_bubble-ds then
            T:=T2;
          elseif s>s_dew+ds then
            T:=T1;
          else
            if s<s_bubble then
                T:=saturationTemperature(p)*(1 - (s_bubble - s)/ds) + T2*(s_bubble -
            s)/ds;
            elseif s>s_dew then
                T:=saturationTemperature(p)*(1 - (s - s_dew)/ds) + T1*(s - s_dew)/
            ds;
            else
                T:=saturationTemperature(p);
            end if;
          end if;

      annotation(Inline=false,
              LateInline=true);
      end temperature_ps;

      redeclare function extends density_pT
      "Computes density as a function of pressure and temperature"
      protected
          Real c2[:]={506.208387981876,1.87054256217980,-29.9062841232497,-0.0351624357762205,0.693501535440458,-2.21393734916457,0.00126962771607607,-0.0298496253585084,0.222243208624831,-0.419234944193293,7.69903677841526e-06,0.00219916470789359,-0.0156164603769147,0.0699901864638379,-0.104815271970145,1.34663813731525e-05,1.90380071619604e-06,0.00117322708291575,-0.00424731659901982,0.0141806356166424,-0.0227711391125435};
          Real meanx2=1682457.51267010;
          Real meany2=290.645659315997;
          Real stdx2=720642.233056887;
          Real stdy2=19.9347318052857;
          Real x2=(p-meanx2)/stdx2;
          Real y2=(T-meany2)/stdy2;
          Real d2=c2[1] + c2[2]*x2 + c2[3]*y2 + c2[4]*x2^2 + c2[5]*x2*y2 + c2[6]*y2^2 + c2[7]*x2^3 + c2[8]*x2^2*y2 + c2[9]*x2*y2^2 + c2[10]*y2^3 + c2[11]*x2^4 + c2[12]*x2^3*y2 + c2[13]*x2^2*y2^2 + c2[14]*x2*y2^3 + c2[15]*y2^4 + c2[16]*x2^5 + c2[17]*x2^4*y2 + c2[18]*x2^3*y2^2 + c2[19]*x2^2*y2^3 + c2[20]*x2*y2^4 + c2[21]*y2^5;
          Real c1[:]={6.99012116216078,7.85762798977443,-0.618509525341628,0.561456406237816,-0.827135398454184,0.0644646531072409,0.0745135118619033,-0.227438027200113,0.113487112138254,-0.00894774750115025,0.0141066470211284,-0.0614336770277778,0.0715858695051831,-0.0210652010997730,0.00116677386847406,0.00292620516208197,-0.0165506988456200,0.0269207717408464,-0.0137994983041971,0.00162333280148309,-2.13433530006928e-05};
          Real meanx1=382099.574228781;
          Real meany1=307.564799259815;
          Real stdx1=403596.556578661;
          Real stdy1=22.5879133275781;
          Real x1=(p-meanx1)/stdx1;
          Real y1=(T-meany1)/stdy1;
          Real d1=c1[1] + c1[2]*x1 + c1[3]*y1 + c1[4]*x1^2 + c1[5]*x1*y1 + c1[6]*y1^2 + c1[7]*x1^3 + c1[8]*x1^2*y1 + c1[9]*x1*y1^2 + c1[10]*y1^3 + c1[11]*x1^4 + c1[12]*x1^3*y1 + c1[13]*x1^2*y1^2 + c1[14]*x1*y1^3 + c1[15]*y1^4 + c1[16]*x1^5 + c1[17]*x1^4*y1 + c1[18]*x1^3*y1^2 + c1[19]*x1^2*y1^3 + c1[20]*x1*y1^4 + c1[21]*y1^5;
          AbsolutePressure dp=10;
          SaturationProperties sat;

      algorithm
          sat.Tsat:=T;
          sat.psat:=saturationPressure(T);
          if p<sat.psat-dp then
              d:=d1;
          elseif p>sat.psat+dp then
              d:=d2;
          else
              if p<sat.psat then
                  d:=bubbleDensity(sat)*(1 - (sat.psat - p)/dp) + d1*(sat.psat - p)/dp;
              elseif p>=sat.psat then
                  d:=dewDensity(sat)*(1 - (p - sat.psat)/dp) + d2*(p - sat.psat)/dp;
              end if;
          end if;
      annotation(inverse(p=pressure_dT(d=d,T=T,phase=phase)),
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
</html>",   info="<html>
<p>This package is a <b>template</b> for <b>new medium</b> models using a hybrid approach (for detailed information please see <a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium\">AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium</a>). For a new refrigerant model just make a copy of this package, remove the &QUOT;partial&QUOT; keyword from the package and provide the information that is requested in the comments of the Modelica source. A refrigerant package inherits from <b>PartialHybridTwoPhaseMedium</b> and provides the equations for the refrigerant. Moreover, the PartialHybridTwoPhaseMedium package inherits from <b>PartialMedium</b> and, therefore, the details of this package are described in <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</p>
</html>"));
    end TemplateHybridTwoPhaseMedium;

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


      /*Provide Helmholtz equations of state (EoS). These EoS must be fitted to
    different refrigerents. However, the structure will not change and, therefore,
    the coefficients, which are obtained during the fitting procedure, are 
    provided by a record. These coefficients have to be provided within the template.
    Just change if needed.
  */
      replaceable partial function alpha_0
      "Dimensionless Helmholz energy (Ideal gas contribution alpha_0)"
        input Real delta "Temperature";
        input Real tau "Density";
        output Real alpha_0 "Dimensionless ideal gas Helmholz energy";
      end alpha_0;

      replaceable partial function alpha_r
      "Dimensionless Helmholz energy (Residual part alpha_r)"
          input Real delta "Temperature";
          input Real tau "Density";
          output Real alpha_r = 0 "Dimensionless residual Helmholz energy";
      end alpha_r;

      replaceable partial function tau_d_alpha_0_d_tau
      "Short form for tau*(dalpha_0/dtau)@delta=const"
        input Real tau "Density";
        output Real tau_d_alpha_0_d_tau = 0 "Tau*(dalpha_0/dtau)@delta=const";
      end tau_d_alpha_0_d_tau;

      replaceable partial function tau_d_alpha_r_d_tau
      "Short form for tau*(dalpha_r/dtau)@delta=const"
        input Real delta "Temperature";
        input Real tau "Density";
        output Real tau_d_alpha_r_d_tau = 0 "Tau*(dalpha_r/dtau)@delta=const";
      end tau_d_alpha_r_d_tau;

      replaceable partial function tau_delta_d2_alpha_r_d_tau_d_delta
      "Short form for tau*delta*(ddalpha_r/(dtau*ddelta))"
        input Real delta "Temperature";
        input Real tau "Density";
        output Real tau_delta_d2_alpha_r_d_tau_d_delta = 0
        "Tau*delta*(ddalpha_r/(dtau*ddelta))";
      end tau_delta_d2_alpha_r_d_tau_d_delta;

      replaceable partial function tau2_d2_alpha_r_d_tau2
      "Short form for tau*tau*(ddalpha_r/(dtau*dtau))@delta=const"
          input Real delta "Temperature";
          input Real tau "Density";
          output Real tau2_d2_alpha_r_d_tau2 = 0
          "Tau*tau*(ddalpha_r/(dtau*dtau))@delta=const";
      end tau2_d2_alpha_r_d_tau2;

      replaceable partial function tau2_d2_alpha_0_d_tau2
      "Short form for tau*tau*(ddalpha_0/(dtau*dtau))@delta=const"
          input Real tau "Density";
          output Real tau2_d2_alpha_0_d_tau2 = 0
          "Tau*tau*(ddalpha_0/(dtau*dtau))@delta=const";
      end tau2_d2_alpha_0_d_tau2;

      replaceable partial function delta_d_alpha_r_d_delta
      "Short form for delta*(dalpha_r/(ddelta))@tau=const"
        input Real delta "Temperature";
        input Real tau "Density";
        output Real delta_d_alpha_r_d_delta = 0 "Delta*(dalpha_r/(ddelta))@tau=const";
      end delta_d_alpha_r_d_delta;

      replaceable partial function delta3_d3_alpha_r_d_delta3
      "Short form for delta*delta*delta(dddalpha_r/(ddelta*delta*delta))@tau=const"
        input Real delta "Temperature";
        input Real tau "Density";
        output Real delta3_d3_alpha_r_d_delta3 = 0
        "Delta*delta*delta(dddalpha_r/(ddelta*delta*delta))@tau=const";
      end delta3_d3_alpha_r_d_delta3;

      replaceable partial function delta2_d2_alpha_r_d_delta2
      "Short form for delta*delta(ddalpha_r/(ddelta*delta))@tau=const"
        input Real delta "Temperature";
        input Real tau "Density";
        output Real delta2_d2_alpha_r_d_delta2 = 0
        "Delta*delta(ddalpha_r/(ddelta*delta))@tau=const";
      end delta2_d2_alpha_r_d_delta2;


      /*Provide functions that set the actual state depending on the given input
    parameters. Additionally, state functions for the two-phase region are needed.  
    Just change these functions if needed.
  */
      redeclare replaceable function extends setDewState
      "Return thermodynamic state of refrigerant  on the dew line"
      algorithm
        state := ThermodynamicState(
           phase = phase,
           T = sat.Tsat,
           d = dewDensity(sat),
           p = saturationPressure(sat.Tsat),
           h = dewEnthalpy(sat));
      end setDewState;

      redeclare replaceable function extends setBubbleState
      "Return thermodynamic state of refrigerant on the bubble line"
      algorithm
        state := ThermodynamicState(
           phase = phase,
           T = sat.Tsat,
           d = bubbleDensity(sat),
           p = saturationPressure(sat.Tsat),
           h = bubbleEnthalpy(sat));
      end setBubbleState;

      redeclare replaceable function extends setState_dTX
      "Return thermodynamic state of refrigerant as function of d and T"
      algorithm
        state := ThermodynamicState(
          d = d,
          T = T,
          p = pressure_dT(d=d,T=T,phase=phase),
          h = specificEnthalpy_dT(d=d,T=T,phase=phase),
          phase = phase);
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
      end setState_pTX;

      redeclare replaceable function extends setState_phX
      "Return thermodynamic state of refrigerant as function of p and h"
      algorithm
        state:= ThermodynamicState(
          d = density_ph(p=p,h=h,phase=phase),
          p = p,
          T = temperature_ph(p=p,h=h,phase=phase),
          h = h,
          phase = phase);
      end setState_phX;

      redeclare replaceable function extends setState_psX
      "Return thermodynamic state of refrigerant as function of p and s"
      algorithm
        state := ThermodynamicState(
          d = density_ps(p=p,s=s,phase=phase),
          p = p,
          T = temperature_ps(p=p,s=s,phase=phase),
          h = specificEnthalpy_ps(p=p,s=s,phase=phase),
          phase = phase);
      end setState_psX;


      /*Provide functions to calculate thermodynamic properties using the EoS.
    Just change these functions if needed.
  */
      redeclare function extends specificEntropy
      "Specific entropy of refrigerant"
      protected
          Real T_crit = fluidConstants[1].criticalTemperature;
          Real d_crit = fluidConstants[1].criticalMolarVolume;
          Real MM = fluidConstants[1].molarMass;
          Real R = Modelica.Constants.R/MM;

          SpecificEntropy sl;
          SpecificEntropy sv;

          Real tau = T_crit/state.T;
          Real delta = state.d/(d_crit*MM);
          Real deltaL = bubbleDensity(setSat_T(state.T))/(d_crit*MM);
          Real deltaG = dewDensity(setSat_T(state.T))/(d_crit*MM);

          Real quality = (bubbleDensity(setSat_T(state.T))/state.d - 1)/
            (bubbleDensity(setSat_T(state.T))/dewDensity(setSat_T(state.T)) - 1);
          SaturationProperties sat = setSat_T(state.T);

      algorithm
      if state.phase==1 then
         s := R*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(delta, tau) - alpha_0(
            delta, tau) - alpha_r(delta, tau));
      elseif state.phase==2 then
         sl := R*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(deltaL, tau) - alpha_0(
            deltaL, tau) - alpha_r(deltaL, tau));
         sv := R*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(deltaG, tau) - alpha_0(
            deltaG, tau) - alpha_r(deltaG, tau));
          s := sl + quality*(sv-sl);
      end if;
      end specificEntropy;

      redeclare function extends specificHeatCapacityCp
      "Specific heat capacity at constant pressure of refrigerant"
      protected
          Real T_crit = fluidConstants[1].criticalTemperature;
          Real d_crit = fluidConstants[1].criticalMolarVolume;
          Real MM = fluidConstants[1].molarMass;
          Real R = Modelica.Constants.R/MM;

          SpecificHeatCapacity cpl;
          SpecificHeatCapacity cpv;

          Real tau = T_crit/state.T;
          Real delta = state.d/(d_crit*MM);
          Real deltaL = bubbleDensity(setSat_T(state.T))/(d_crit*MM);
          Real deltaG = dewDensity(setSat_T(state.T))/(d_crit*MM);

          Real quality = if state.phase==2 then (bubbleDensity(setSat_T(state.T))/
            state.d - 1)/(bubbleDensity(setSat_T(state.T))/dewDensity(
            setSat_T(state.T)) - 1) else 1;
          SaturationProperties sat = setSat_T(state.T);
          Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
            dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
            then 1 else 2;

      algorithm
        if state.phase==1 or phase_dT==1 then
          cp := specificHeatCapacityCv(state) + R*((1 + delta_d_alpha_r_d_delta(delta,
            tau) - tau_delta_d2_alpha_r_d_tau_d_delta(delta, tau))^2)/(1 + 2*
            delta_d_alpha_r_d_delta(delta, tau) + delta2_d2_alpha_r_d_delta2(delta, tau));
        elseif state.phase==2 or phase_dT==2 then
          cpl := specificHeatCapacityCv(setBubbleState(setSat_T(state.T))) + R*((1 +
            delta_d_alpha_r_d_delta(deltaL, tau) - tau_delta_d2_alpha_r_d_tau_d_delta(
            deltaL, tau))^2)/(1 + 2*delta_d_alpha_r_d_delta(deltaL, tau) +
            delta2_d2_alpha_r_d_delta2(deltaL, tau));
          cpv := specificHeatCapacityCv(setDewState(setSat_T(state.T))) + R*((1 +
            delta_d_alpha_r_d_delta(deltaG, tau) - tau_delta_d2_alpha_r_d_tau_d_delta(
            deltaG, tau))^2)/(1 + 2*delta_d_alpha_r_d_delta(deltaG, tau) +
            delta2_d2_alpha_r_d_delta2(deltaG, tau));
          cp := cpl + quality*(cpv-cpl);
        end if;
      end specificHeatCapacityCp;

      redeclare function extends specificHeatCapacityCv
      "Specific heat capacity at constant volume of refrigerant"
      protected
          Real T_crit = fluidConstants[1].criticalTemperature;
          Real d_crit = fluidConstants[1].criticalMolarVolume;
          Real MM = fluidConstants[1].molarMass;
          Real R = Modelica.Constants.R/MM;

          SpecificHeatCapacity cvl;
          SpecificHeatCapacity cvv;

          Real tau = T_crit/state.T;
          Real delta = state.d/(d_crit*MM);
          Real deltaL = bubbleDensity(setSat_T(state.T))/(d_crit*MM);
          Real deltaG = dewDensity(setSat_T(state.T))/(d_crit*MM);

          Real quality = if state.phase==2 then (bubbleDensity(setSat_T(state.T))/
            state.d - 1)/(bubbleDensity(setSat_T(state.T))/dewDensity(
            setSat_T(state.T)) - 1) else 1;
          SaturationProperties sat = setSat_T(state.T);
          Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
             dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
             then 1 else 2;

      algorithm
        if state.phase==1 or phase_dT==1 then
          cv := -R*(tau2_d2_alpha_0_d_tau2(tau) + tau2_d2_alpha_r_d_tau2(delta, tau));
        elseif state.phase==2 or phase_dT==2 then
          cvl := -R*(tau2_d2_alpha_0_d_tau2(tau) + tau2_d2_alpha_r_d_tau2(deltaL, tau));
          cvv := -R*(tau2_d2_alpha_0_d_tau2(tau) + tau2_d2_alpha_r_d_tau2(deltaG, tau));
          cv := cvl + quality*(cvv-cvl);
        end if;
      end specificHeatCapacityCv;

      redeclare function extends velocityOfSound
      "Velocity of sound of refrigerant"
      protected
          Real T_crit = fluidConstants[1].criticalTemperature;
          Real d_crit = fluidConstants[1].criticalMolarVolume;
          Real MM = fluidConstants[1].molarMass;
          Real R = Modelica.Constants.R/MM;

          VelocityOfSound aL;
          VelocityOfSound aG;

          Real tau = T_crit/state.T;
          Real delta = state.d/(d_crit*MM);
          Real deltaL = bubbleDensity(setSat_T(state.T))/(d_crit*MM);
          Real deltaG = dewDensity(setSat_T(state.T))/(d_crit*MM);

          Real quality = if state.phase==2 then (bubbleDensity(setSat_T(state.T))/
            state.d - 1)/(bubbleDensity(setSat_T(state.T))/dewDensity(
            setSat_T(state.T)) - 1) else 1;
          SaturationProperties sat = setSat_T(state.T);
          Real phase_dT = if not ((state.d < bubbleDensity(sat) and state.d >
            dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
            then 1 else 2;

      algorithm
      if state.phase==1 or phase_dT==1 then
          a := (R*state.T*(1+2*delta_d_alpha_r_d_delta(delta,tau)+
            delta2_d2_alpha_r_d_delta2(delta,tau)-(1+delta_d_alpha_r_d_delta(delta,tau)-
            tau_delta_d2_alpha_r_d_tau_d_delta(delta,tau))^2/(tau2_d2_alpha_0_d_tau2(tau)
            +tau2_d2_alpha_r_d_tau2(delta,tau))))^0.5;
      elseif state.phase==2 or phase_dT==2 then
          aG := (R*state.T*(1+2*delta_d_alpha_r_d_delta(deltaL,tau)+
            delta2_d2_alpha_r_d_delta2(deltaL,tau)-(1+delta_d_alpha_r_d_delta(deltaL,tau)-
            tau_delta_d2_alpha_r_d_tau_d_delta(deltaL,tau))^2/(tau2_d2_alpha_0_d_tau2(tau)+
            tau2_d2_alpha_r_d_tau2(deltaL,tau))))^0.5;
          aL := (R*state.T*(1+2*delta_d_alpha_r_d_delta(deltaG,tau)+
            delta2_d2_alpha_r_d_delta2(deltaG,tau)-(1+delta_d_alpha_r_d_delta(deltaG,tau)-
            tau_delta_d2_alpha_r_d_tau_d_delta(deltaG,tau))^2/(tau2_d2_alpha_0_d_tau2(tau)+
            tau2_d2_alpha_r_d_tau2(deltaG,tau))))^0.5;
          a:=aL + quality*(aG-aL);
      end if;
      end velocityOfSound;


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
        Real T_crit = fluidConstants[1].criticalTemperature;
        Real d_crit = fluidConstants[1].criticalMolarVolume;
        Real MM = fluidConstants[1].molarMass;
        Real R = Modelica.Constants.R/MM;
        Real delta = d/(d_crit*MM);
        Real tau = T_crit/T;

        SaturationProperties sat = setSat_T(T);
        Real phase_dT = if not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T
             < fluidConstants[1].criticalTemperature) then 1 else 2;

      algorithm
        if phase_dT == 1 or phase == 1 then
          p := d*R*T*(1+delta_d_alpha_r_d_delta(delta,tau));
        elseif phase_dT == 2 or phase == 2 then
          p := saturationPressure(T);
        end if;
      annotation(derivative(noDerivative=phase)=pressure_dT_der,
          inverse(d=density_pT(p=p,T=T,phase=phase)),
              Inline=false,
              LateInline=true);
      end pressure_dT;

      redeclare replaceable partial function density_pT
      "Computes density as a function of pressure and temperature"
          extends Modelica.Icons.Function;
          input AbsolutePressure p "Pressure";
          input Temperature T "Temperature";
          input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
          output Density d "Density";
      end density_pT;

      redeclare function density_ph
      "Computes density as a function of pressure and enthalpy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Density";

      protected
          SpecificEnthalpy dh = 10;
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
              Inline=false,
              LateInline=true);
      end density_ph;

      redeclare function density_ps
      "Computes density as a function of pressure and entropy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output Density d "Temperature";

      protected
          SpecificEntropy ds = 50*p/(30e5-0.5e5);
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
                  p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*(s_bubble - s)/ds;
            elseif s>s_dew then
                d:=dewDensity(sat)*(1 - (s - s_dew)/ds) + density_pT(
                  p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*(s - s_dew)/ds;
            else
                d:=1/((1-(s-s_bubble)/(s_dew-s_bubble))/bubbleDensity(sat) +
                  ((s-s_bubble)/(s_dew-s_bubble))/dewDensity(sat));
            end if;
          end if;
      annotation(Inline=false,
              LateInline=true);
      end density_ps;

      redeclare function specificEnthalpy_pT
      "Computes specific enthalpy as a function of pressure and temperature"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input Temperature T "Temperature";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";

      algorithm
        h := specificEnthalpy_dT(density_pT(p,T,phase),T,phase);
      annotation(inverse(T=temperature_ph(p=p,h=h,phase=phase)),
              Inline=false,
              LateInline=true);
      end specificEnthalpy_pT;

      redeclare function specificEnthalpy_dT
      "Computes specific enthalpy as a function of density and temperature"
        extends Modelica.Icons.Function;
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";

      protected
        Real T_crit = fluidConstants[1].criticalTemperature;
        Real d_crit = fluidConstants[1].criticalMolarVolume;
        Real MM = fluidConstants[1].molarMass;
        Real R = Modelica.Constants.R/MM;

        Real tau = T_crit/T;
        Real delta = d/(d_crit*MM);
        Real dewDelta = dewDensity(sat)/(d_crit*MM);
        Real bubbleDelta = bubbleDensity(sat)/(d_crit*MM);

        SaturationProperties sat = setSat_T(T);
        Real phase_dT = if not ((d < bubbleDensity(sat) and d > dewDensity(sat)) and T
             < fluidConstants[1].criticalTemperature) then 1 else 2;
        Real quality = if phase==2 or phase_dT==2 then (bubbleDensity(sat)/d - 1)/
            (bubbleDensity(sat)/dewDensity(sat) - 1) else 1;
        Real hl=0;
        Real hv=0;

      algorithm
        if phase_dT == 1 or phase == 1 then
          h := R*T*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(delta, tau) +
          delta_d_alpha_r_d_delta(delta, tau) + 1);
        elseif phase_dT == 2 or phase == 2 then
          hl := R*T*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(bubbleDelta, tau) +
          delta_d_alpha_r_d_delta(bubbleDelta, tau) + 1);
          hv := R*T*(tau_d_alpha_0_d_tau(tau) + tau_d_alpha_r_d_tau(dewDelta, tau) +
          delta_d_alpha_r_d_delta(dewDelta, tau) + 1);
          h := hl + quality*(hv-hl);
        end if;
      annotation(derivative(noDerivative=phase)=specificEnthalpy_dT_der,
              Inline=false,
              LateInline=true);
      end specificEnthalpy_dT;

      redeclare function specificEnthalpy_ps
      "Computes specific enthalpy as a function of pressure and entropy"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEntropy s "Specific entropy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        output SpecificEnthalpy h "Specific enthalpy";

      protected
          SpecificEntropy ds = 100*p/(30e5-0.5e5);
          SaturationProperties sat;
          SpecificEntropy s_dew;
          SpecificEntropy s_bubble;
          SpecificEnthalpy h_dew;
          SpecificEnthalpy h_bubble;

      algorithm
          sat:=setSat_p(p=p);
          s_dew:=dewEntropy(sat);
          s_bubble:=bubbleEntropy(sat);
          h_dew:=dewEnthalpy(sat);
          h_bubble:=bubbleEnthalpy(sat);

          if s<s_bubble-ds or s>s_dew+ds then
              h := specificEnthalpy_pT(p=p,T=temperature_ps(
                p=p,s=s,phase=phase),phase=phase);
          else
            if s<s_bubble then
                h := h_bubble*(1 - (s_bubble - s)/ds) + specificEnthalpy_pT(
                  p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*(s_bubble - s)/ds;
            elseif s>s_dew then
                h := h_dew*(1 - (s - s_dew)/ds) + specificEnthalpy_pT(
                  p=p,T=temperature_ps(p=p,s=s,phase=phase),phase=phase)*(s - s_dew)/ds;
            else
                h := h_bubble+(s-s_bubble)/(s_dew-s_bubble)*(h_dew-h_bubble);
            end if;
          end if;
      annotation(Inline=false,
              LateInline=true);
      end specificEnthalpy_ps;


      /*Provide functions partial derivatives. These functions may depend on the
    Helmholtz EoS and are needed to calculate thermodynamic properties.  
    Just change these functions if needed.
  */
      replaceable function pressure_dT_der
      "Calculates time derivative of pressure_dT"
        input Density d "Density";
        input Temperature T "Temperature";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        input Real der_d "Time derivative of density";
        input Real der_T "Time derivative of temperature";
        output Real der_p "Time derivative of pressure";

      protected
        ThermodynamicState state = setState_dTX(d=d,T=T,phase=phase);

      algorithm
        der_p := der_d*pressure_derd_T(state=state) + der_T*pressure_derT_d(state=state);
      end pressure_dT_der;

      replaceable function pressure_derd_T
      "Calculates pressure derivative (dp/dd)@T=const"
        input ThermodynamicState state "Thermodynamic state";
        output Real dpdd "Pressure derivative (dp/dd)@T=const";

      protected
        Real T_crit = fluidConstants[1].criticalTemperature;
        Real d_crit = fluidConstants[1].criticalMolarVolume;
        Real MM = fluidConstants[1].molarMass;
        Real R = Modelica.Constants.R/MM;

        Real delta = state.d/(d_crit*MM);
        Real tau = T_crit/state.T;

        SaturationProperties sat = setSat_p(state.p);
        Real phase_dT = if not ((state.d < bubbleDensity(sat) and
          state.d > dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
          then 1 else 2;
        Real phase_ph = if ((state.h <= bubbleEnthalpy(sat) or
          state.h >= dewEnthalpy(sat)) or state.p > fluidConstants[1].criticalPressure)
          then 1 else 2;

      algorithm
        if state.phase==1 then
          dpdd := R*state.T*(1 + 2*delta_d_alpha_r_d_delta(delta=delta,tau=tau) +
            delta2_d2_alpha_r_d_delta2(delta=delta,tau=tau));
        elseif state.phase==2 then
          dpdd := Modelica.Constants.small;
        end if;
      end pressure_derd_T;

      replaceable function pressure_derT_d
      "Calculates pressure derivative (dp/dT)@d=const"
        input ThermodynamicState state "Thermodynamic state";
        output Real dpdT "Pressure derivative (dp/dT)@d=const";

      protected
        Real T_crit = fluidConstants[1].criticalTemperature;
        Real d_crit = fluidConstants[1].criticalMolarVolume;
        Real MM = fluidConstants[1].molarMass;
        Real R = Modelica.Constants.R/MM;

        Real delta = state.d/(d_crit*MM);
        Real tau = T_crit/state.T;

        SaturationProperties sat = setSat_p(state.p);
        Real phase_dT = if not ((state.d < bubbleDensity(sat) and
          state.d > dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
          then 1 else 2;
        Real phase_ph = if ((state.h <= bubbleEnthalpy(sat) or
          state.h >= dewEnthalpy(sat)) or state.p > fluidConstants[1].criticalPressure)
          then 1 else 2;

      algorithm
        if state.phase==1 then
          dpdT:=R*state.d*(1 + delta_d_alpha_r_d_delta(delta=delta,tau=tau) -
            tau_delta_d2_alpha_r_d_tau_d_delta(delta=delta,tau=tau));
        elseif state.phase==2 then
          dpdT := Modelica.Constants.inf;
        end if;
      end pressure_derT_d;

      replaceable function temperature_derh_p
      "Calculates temperature derivative (dT/dh)@p=const"
        input ThermodynamicState state "Thermodynamic state";
        output Real dThp "Temperature derivative (dT/dh)@p=const";

      protected
        Real T_crit = fluidConstants[1].criticalTemperature;
        Real d_crit = fluidConstants[1].criticalMolarVolume;
        Real MM = fluidConstants[1].molarMass;
        Real R = Modelica.Constants.R/MM;

        Real delta = state.d/(d_crit*MM);
        Real tau = T_crit/state.T;

        SaturationProperties sat = setSat_p(state.p);
        Real phase_dT = if not ((state.d < bubbleDensity(sat) and
            state.d > dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
            then 1 else 2;
        Real phase_ph = if ((state.h <= bubbleEnthalpy(sat) or
            state.h >= dewEnthalpy(sat)) or state.p > fluidConstants[1].criticalPressure)
            then 1 else 2;

      algorithm
        if state.phase==1 then
          dThp := 1 / (specificEnthalpy_derT_d(state) - specificEnthalpy_derd_T(state)*
            pressure_derT_d(state)/pressure_derd_T(state));
        elseif state.phase==2 then
          dThp:=Modelica.Constants.small;
        end if;
      end temperature_derh_p;

      replaceable function temperature_derp_h
      "Calculates temperature derivative (dT/dp)@h=const"
      input ThermodynamicState state "Thermodynamic state";
      output Real dTph "Temperature derivative (dT/dp)@h=const";

      protected
        Real T_crit = fluidConstants[1].criticalTemperature;
        Real d_crit = fluidConstants[1].criticalMolarVolume;
        Real MM = fluidConstants[1].molarMass;
        Real R = Modelica.Constants.R/MM;

        Real tau = T_crit/state.T;
        Real delta = state.d/(d_crit*MM);

        SaturationProperties sat = setSat_p(state.p);
        Real phase_dT = if not ((state.d < bubbleDensity(sat) and
          state.d > dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
          then 1 else 2;
        Real phase_ph = if ((state.h <= bubbleEnthalpy(sat) or
          state.h >= dewEnthalpy(sat)) or state.p > fluidConstants[1].criticalPressure)
          then 1 else 2;

      algorithm
        if state.phase==1 then
          dTph := 1 / (pressure_derT_d(state) - pressure_derd_T(state)*
            specificEnthalpy_derT_d(state)/specificEnthalpy_derd_T(state));
        elseif state.phase==2 then
          dTph:=Modelica.Constants.small;
        end if;
      end temperature_derp_h;

      replaceable function temperature_ph_der
      "Calculates time derivative of temperature_ph"
        extends Modelica.Icons.Function;
        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific enthalpy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        input Real der_p "Time derivative of pressure";
        input Real der_h "Time derivative of specific enthalpy";
        output Real der_T "Time derivative of density";

      protected
        ThermodynamicState state = setState_phX(p=p,h=h,phase=phase);

      algorithm
          der_T := der_p*temperature_derp_h(state=state) +
            der_h*temperature_derh_p(state=state);
      end temperature_ph_der;

      replaceable function density_ph_der
      "Calculates time derivative of density_ph"

        input AbsolutePressure p "Pressure";
        input SpecificEnthalpy h "Specific Enthalpy";
        input FixedPhase phase = 0 "2 for two-phase, 1 for one-phase, 0 if not known";
        input Real der_p "Time derivative of pressure";
        input Real der_h "Time derivative of specific enthalpy";
        output Real der_d "Time derivative of density";

      protected
        ThermodynamicState state = setState_phX(p=p,h=h,phase=phase);

      algorithm
          der_d := der_p*density_derp_h(state=state) + der_h*density_derh_p(state=state);
      end density_ph_der;

      redeclare function extends density_derh_p
      "Calculates density derivative (dd/dh)@p=const"

      protected
        Real T_crit = fluidConstants[1].criticalTemperature;
        Real d_crit = fluidConstants[1].criticalMolarVolume;
        Real MM = fluidConstants[1].molarMass;
        Real R = Modelica.Constants.R/MM;

        Real tau = T_crit/state.T;
        Real delta = state.d/(d_crit*MM);

        SaturationProperties sat = setSat_p(state.p);
        Real phase_dT = if not ((state.d < bubbleDensity(sat) and
          state.d > dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
          then 1 else 2;
        Real phase_ph = if ((state.h <= bubbleEnthalpy(sat) or
          state.h >= dewEnthalpy(sat)) or state.p > fluidConstants[1].criticalPressure)
          then 1 else 2;

        AbsolutePressure dp = 0.2;

      algorithm
        if state.phase==1 then
          ddhp := 1 / (specificEnthalpy_derd_T(state) - specificEnthalpy_derT_d(state)*
            pressure_derd_T(state)/pressure_derT_d(state));
        elseif state.phase==2 then
          ddhp:=-(state.d^2)/state.T*(saturationTemperature(state.p+dp/2)-
            saturationTemperature(state.p-dp/2))/dp;
        end if;
      end density_derh_p;


      redeclare function extends density_derp_h
      "Calculates density derivative (dd/dp)@h=const"

      algorithm
          ddph := 1 / (pressure_derd_T(state) - pressure_derT_d(state)*
            specificEnthalpy_derd_T(state)/specificEnthalpy_derT_d(state));
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
      end specificEnthalpy_dT_der;

      replaceable function specificEnthalpy_derT_d
      "Calculates enthalpy derivative (dh/dT)@d=const"
        input ThermodynamicState state "Thermodynamic state";
        output Real dhTd "Enthalpy derivative (dh/dT)@d=const";

      protected
        Real T_crit = fluidConstants[1].criticalTemperature;
        Real d_crit = fluidConstants[1].criticalMolarVolume;
        Real MM = fluidConstants[1].molarMass;
        Real R = Modelica.Constants.R/MM;

        Real delta = state.d/(d_crit*MM);
        Real tau = T_crit/state.T;

        SaturationProperties sat = setSat_p(state.p);
        Real phase_dT = if not ((state.d < bubbleDensity(sat) and
          state.d > dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
          then 1 else 2;
        Real phase_ph = if ((state.h <= bubbleEnthalpy(sat) or
          state.h >= dewEnthalpy(sat)) or state.p > fluidConstants[1].criticalPressure)
          then 1 else 2;

      algorithm
        if state.phase==1 then
          dhTd := R*(-tau2_d2_alpha_0_d_tau2(tau=tau) - tau2_d2_alpha_r_d_tau2(
            delta=delta, tau=tau) + 1 + delta_d_alpha_r_d_delta(delta=delta,tau=tau) -
            tau_delta_d2_alpha_r_d_tau_d_delta(delta=delta, tau=tau));
        elseif state.phase==2 then
          dhTd:=Modelica.Constants.inf;
        end if;
      end specificEnthalpy_derT_d;

      replaceable function specificEnthalpy_derd_T
      "Calculates enthalpy derivative (dh/dd)@T=const"
        input ThermodynamicState state "Thermodynamic state";
        output Real dhdT "Enthalpy derivative (dh/dd)@T=const";

      protected
        Real T_crit = fluidConstants[1].criticalTemperature;
        Real d_crit = fluidConstants[1].criticalMolarVolume;
        Real MM = fluidConstants[1].molarMass;
        Real R = Modelica.Constants.R/MM;

        Real delta = state.d/(d_crit*MM);
        Real tau = T_crit/state.T;

        SaturationProperties sat = setSat_p(state.p);
        Real phase_dT = if not ((state.d < bubbleDensity(sat) and
            state.d > dewDensity(sat)) and state.T < fluidConstants[1].criticalTemperature)
            then 1 else 2;
        Real phase_ph = if ((state.h <= bubbleEnthalpy(sat) or
            state.h >= dewEnthalpy(sat)) or state.p > fluidConstants[1].criticalPressure)
            then 1 else 2;

      algorithm
        if state.phase==1 then
          dhdT:=R*state.T/state.d*(tau_delta_d2_alpha_r_d_tau_d_delta(
            delta=delta,tau=tau) + delta_d_alpha_r_d_delta(delta=delta,tau=tau) +
            delta2_d2_alpha_r_d_delta2(delta=delta,tau=tau));
        elseif state.phase==2 then
          dhdT := -1/state.d^2*(bubbleEnthalpy(sat)-dewEnthalpy(sat))/
            (1/bubbleDensity(sat)-1/dewDensity(sat));
        end if;
      end specificEnthalpy_derd_T;

      redeclare function extends dBubbleEnthalpy_dPressure
      "Calculates bubble point enthalpy derivative"

      protected
        ThermodynamicState state_l = setBubbleState(sat);
        ThermodynamicState state_v = setDewState(sat);
        Real dhpT = specificEnthalpy_derd_T(state_l)/pressure_derd_T(state_l);
        Real dhTp = specificEnthalpy_derT_d(state_l) - specificEnthalpy_derd_T(state_l)*
          pressure_derT_d(state_l)/pressure_derd_T(state_l);
        Real dTp = (1/state_v.d - 1/state_l.d)/
          (specificEntropy(state_v) - specificEntropy(state_l));

      algorithm
        dhldp := dhpT + dhTp*dTp;
      end dBubbleEnthalpy_dPressure;

      redeclare function extends dDewEnthalpy_dPressure
      "Calculates dew point enthalpy derivative"

      protected
        ThermodynamicState state_l = setBubbleState(sat);
        ThermodynamicState state_v = setDewState(sat);
        Real dhpT = specificEnthalpy_derd_T(state_v)/pressure_derd_T(state_v);
        Real dhTp = specificEnthalpy_derT_d(state_v) - specificEnthalpy_derd_T(state_v)*
          pressure_derT_d(state_v)/pressure_derd_T(state_v);
        Real dTp=(1.0/state_v.d - 1.0/state_l.d)/
          (specificEntropy(state_v) - specificEntropy(state_l));

      algorithm
        dhvdp := dhpT + dhTp*dTp;
      end dDewEnthalpy_dPressure;

      annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",     info="<html>
<p>A detailed documentation will follow later.</p>
<ul>
<li>Which approach is provided?</li>
<li>Source?</li>
<li>Why hybrid? (Polynomial fits and Helmholtz EoS)</li>
</ul>
<p><b>Main equations</b> </p>
<p>xxx </p>
<p><b>Assumptions and limitations</b> </p>
<p>xxx </p>
<p><b>Typical use and important parameters</b> </p>
<p>xxx </p>
<p><b>Options</b> </p>
<p>xxx </p>
<p><b>Dynamics</b> </p>
<p>Describe which states and dynamics are present in the model and which parameters may be used to influence them. This need not be added in partial classes. </p>
<p><b>Validation</b> </p>
<p>Describe whether the validation was done using analytical validation, comparative model validation or empirical validation. </p>
<p><b>Implementation</b> </p>
<p>xxx </p>
<p><b>References</b> </p>
<p>xxx </p>
</html>"));
    end PartialHybridTwoPhaseMedium;
    annotation (Documentation(info="<html>
<p>This package provides basic interfaces for the definition of new refrigerant models.</p><p>A detailed documentation will follow later (e.g. which aprroaches are provided within this package).</p>
</html>", revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
  end Interfaces;

  package R134a "Package with models for the refrigerant R134a"
    extends Modelica.Icons.VariantsPackage;
    annotation (Documentation(info="<html>
<p>A detailed documentation will follow later. </p>
<p><b>Main equations</b> </p>
<p>xxx </p>
<p><b>Assumptions and limitations</b> </p>
<p>xxx </p>
<p><b>Typical use and important parameters</b> </p>
<p>xxx </p>
<p><b>Options</b> </p>
<p>xxx </p>
<p><b>Dynamics</b> </p>
<p>Describe which states and dynamics are present in the model and which parameters may be used to influence them. This need not be added in partial classes. </p>
<p><b>Validation</b> </p>
<p>Describe whether the validation was done using analytical validation, comparative model validation or empirical validation. </p>
<p><b>Implementation</b> </p>
<p>xxx </p>
<p><b>References</b> </p>
<p>xxx </p>
</html>", revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
  end R134a;

  package R410a "Package with models for the refrigerant R410a"
    extends Modelica.Icons.VariantsPackage;
    annotation (Documentation(info="<html>
<p>A detailed documentation will follow later. </p>
<p><b>Main equations</b> </p>
<p>xxx </p>
<p><b>Assumptions and limitations</b> </p>
<p>xxx </p>
<p><b>Typical use and important parameters</b> </p>
<p>xxx </p>
<p><b>Options</b> </p>
<p>xxx </p>
<p><b>Dynamics</b> </p>
<p>Describe which states and dynamics are present in the model and which parameters may be used to influence them. This need not be added in partial classes. </p>
<p><b>Validation</b> </p>
<p>Describe whether the validation was done using analytical validation, comparative model validation or empirical validation. </p>
<p><b>Implementation</b> </p>
<p>xxx </p>
<p><b>References</b> </p>
<p>xxx </p>
</html>", revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
  end R410a;

  package R1270 "Package with models for refrigerant R1270"
    extends Modelica.Icons.VariantsPackage;
    annotation (Documentation(info="<html>
<p>A detailed documentation will follow later. </p>
<p><b>Main equations</b> </p>
<p>xxx </p>
<p><b>Assumptions and limitations</b> </p>
<p>xxx </p>
<p><b>Typical use and important parameters</b> </p>
<p>xxx </p>
<p><b>Options</b> </p>
<p>xxx </p>
<p><b>Dynamics</b> </p>
<p>Describe which states and dynamics are present in the model and which parameters may be used to influence them. This need not be added in partial classes. </p>
<p><b>Validation</b> </p>
<p>Describe whether the validation was done using analytical validation, comparative model validation or empirical validation. </p>
<p><b>Implementation</b> </p>
<p>xxx </p>
<p><b>References</b> </p>
<p>xxx </p>
</html>", revisions="<html>
<ul>
  <li>
  June 8, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
  end R1270;
  annotation (Documentation(info="<html>
<p>A detailed documentation will follow later. </p>
<ul>
<li>What is implemented so far?</li>
<li>e.g. Approaches and refrigerants</li>
<li>e.g. Limitations for implemented refrigerants</li>
<li>Main references?</li>
</ul>
<p><b>Assumptions and limitations</b> </p>
<p>xxx </p>
<p><b>Typical use and important parameters</b> </p>
<p>xxx </p>
<p><b>Dynamics</b> </p>
<p>Describe which states and dynamics are present in the model and which parameters may be used to influence them. This need not be added in partial classes. </p>
<p><b>Validation</b> </p>
<p>Describe whether the validation was done using analytical validation, comparative model validation or empirical validation. </p>
<p><b>References</b> </p>
<p>xxx </p>
</html>", revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"), Icon(graphics={
        Ellipse(
          extent={{-90,40},{-54,20}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,-50},{-54,30}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-90,-40},{-54,-60}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{6,-50},{42,30}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,40},{42,20}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,-40},{42,-60}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,-50},{-6,30}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,40},{-6,20}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-40},{-6,-60}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{54,-50},{90,30}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,40},{90,20}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,-40},{90,-60}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-88,20},{-56,0}},
          lineColor={28,108,200},
          textString="R134a"),
        Text(
          extent={{-40,20},{-8,0}},
          lineColor={28,108,200},
          textString="R410a"),
        Text(
          extent={{56,20},{88,0}},
          lineColor={28,108,200},
          textString="R1270"),
        Text(
          extent={{8,20},{40,0}},
          lineColor={28,108,200},
          textString="R744"),
        Ellipse(
          extent={{-28,-34},{-8,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{18,-20},{38,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{68,-32},{88,-52}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-40,2},{-20,-18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-86,-36},{-66,-56}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{56,-14},{76,-34}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{8,0},{28,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{68,2},{88,-18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-88,0},{-68,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-76,-18},{-56,-38}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-40,-18},{-20,-38}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{8,-38},{28,-58}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120})}));
end Refrigerants;
