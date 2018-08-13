within AixLib.FastHVAC.Components.HeatGenerators.CHP;
model CHPCombined
  "CHP with internal combustion engine (ICE) including part load operation. To be used with dynamic mode controller (start/stop/OnOff/P_elRel)"

//    parameter Integer CHPType "CHP Type"
//     annotation(Dialog(group = "General", compact = true, descriptionLabel = true), choices(choice=1
//         "ICE",choice = 2 "PEM Fuel Cell",choice = 3 "SOFC Fuel Cell",
//                               radioButtons = true));
   parameter Integer CHPType "CHP Type"
    annotation(Dialog(group = "General", compact = true, descriptionLabel = true), choices(choice=1
        "ICE",choice = 2 "PEM Fuel Cell",radioButtons = true));
  /* *******************************************************************
  Medium
  ******************************************************************* */
  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple medium=
  AixLib.FastHVAC.Media.WaterSimple()
  "Standard flow charastics for water (heat capacity, density, thermal conductivity)"    annotation (choicesAllMatching);
  constant Modelica.SIunits.MolarMass molarMassH2 = 2.01588 "Molar Mass of H2 [kg/mol]";
  /* *******************************************************************
  BHKW Parameters
  ******************************************************************* */
  parameter Boolean EfficiencyByDatatable=true
    "Use datasheet values for efficiency calculations";
  parameter Data.CHP.Engine.BaseDataDefinition paramIFC=
      AixLib.FastHVAC.Data.CHP.Engine.AisinSeiki()
    "Record for IFC Parametrization"
    annotation (choicesAllMatching=true, Dialog(enable=EfficiencyByDatatable and CHPType==1));

  parameter
    Data.CHP.FuelcellPEM.BaseDataDefinition paramPEM=
      AixLib.FastHVAC.Data.CHP.FuelcellPEM.MorrisonPEMFC()
         "Record for PCM Parametrization"
    annotation (choicesAllMatching=true, Dialog(enable=
          EfficiencyByDatatable and CHPType == 2));
  parameter Data.CHP.FuelcellPEM.BaseDataDefinition paramSOFC=
      AixLib.FastHVAC.Data.CHP.FuelcellPEM.MorrisonPEMFC()
         "Record for SOFT Parametrization *CHANGE*";

  parameter Boolean withController=true "Use internal Start Stop Controller" annotation (Dialog(group="Control and operation"));

  parameter Modelica.SIunits.Power P_elRated_prescribed = 5000 annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Efficiency eta_el_prescribed = 0.25 "CHP's electrical efficiency  "
  annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Efficiency omega_prescribed = 0.65 "CHP's total efficiency "
  annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Power P_elStandby_prescribed=90
    "electrical consumption in standby mode"
                                            annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Power P_elStop_prescribed=190
    "electrical consumption during shutdown mode"
                                                 annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Power P_elStart_prescribed=190
      "electrical consumption during startup"
                                             annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Time tauSystem = 10 "general time constant for system to prevent discrete changes";
  parameter Modelica.SIunits.Time tauQ_th_stop_prescribed = 90
  "time constant for thermal start behavior" annotation (Dialog(tab = "ICE", group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Time tauQ_th_start_prescribed = 800
  "time constant for stop behaviour" annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Time tauP_el_prescribed = 100
  "time constant electrical power start behavior" annotation (Dialog(tab = "Prescribed CHP Model", group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Time tauQ_th_loss_prescribed = 100 annotation (Dialog(tab = "Prescribed PEM Model", group = "Prescribed PEM model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Efficiency eta_PCU_presribed = 0.95 "Efficiency of the PCU" annotation (Dialog(tab = "Prescribed PEM Model", group = "Prescribed PEM model",enable=not EfficiencyByDatatable));

  // Calculation of normative capacities for ICE and prescribed calculation to get(for PEM empirical calculation methods are used)
protected
  parameter Modelica.SIunits.Power P_elRated=if EfficiencyByDatatable and CHPType==1 then
      paramIFC.P_elRated elseif EfficiencyByDatatable and CHPType==2 then
      paramPEM.P_elRated else P_elRated_prescribed;
  parameter Modelica.SIunits.Power dotE_fuelRated=if EfficiencyByDatatable and CHPType==1
       then paramIFC.dotE_fuelRated elseif not EfficiencyByDatatable then P_elRated_prescribed/eta_el_prescribed else 0;
  parameter Modelica.SIunits.Power dotQ_thRated=if EfficiencyByDatatable and CHPType==1
      then paramIFC.dotQ_thRated elseif not EfficiencyByDatatable then dotE_fuelRated*(omega_prescribed -eta_el_prescribed) else 0;
  parameter Modelica.SIunits.Power P_elStandby=if EfficiencyByDatatable and CHPType==1 then
      paramIFC.P_elStandby else P_elStandby_prescribed;
  parameter Modelica.SIunits.Power P_elStop=if EfficiencyByDatatable then
      paramIFC.P_elStop else P_elStop_prescribed;
  parameter Modelica.SIunits.Power P_elStart=if EfficiencyByDatatable and CHPType ==1 then
      paramIFC.P_elStart elseif EfficiencyByDatatable and CHPType==2 then
      paramPEM.P_elStart else P_elStart_prescribed;
  parameter Modelica.SIunits.Power dotE_start = if EfficiencyByDatatable and CHPType==2 then paramPEM.FuelConsumptionStart else 0.4 * dotE_fuelRated "Fuel consumption during start process";
  parameter Modelica.SIunits.Power dotE_stop = if EfficiencyByDatatable and CHPType==2 then paramPEM.FuelConsumptionStop else 1/3 * dotE_fuelRated "Fuel consumption during stop process";
  parameter Modelica.SIunits.Power dotQ_stop =  0.5 * dotQ_thRated "Themal energy production during stop process";

  parameter Modelica.SIunits.Time tauQ_th_start=if EfficiencyByDatatable then
      paramIFC.tauQ_th_start else tauQ_th_stop_prescribed
    "time constant for thermal start behavior (unit=sec) ";
  parameter Modelica.SIunits.Time tauQ_th_stop=if EfficiencyByDatatable then
      paramIFC.tauQ_th_stop else tauQ_th_stop_prescribed
    "time constant for stop behaviour (unit=sec)";
  parameter Modelica.SIunits.Time tauQ_th_loss=if EfficiencyByDatatable then
      paramPEM.tauQ else tauQ_th_loss_prescribed
    "time constant for stop behaviour (unit=sec)";

  parameter Modelica.SIunits.Time tauP_el=if EfficiencyByDatatable then
  paramIFC.tauP_el else tauP_el_prescribed
    "time constant electrical power start behavior (unit=sec)";
  parameter Modelica.SIunits.Volume V_water = 3e-3;
  parameter Real LimiterPelPos = if CHPType == 1 then 760 else 0.61;
  parameter Real LimiterPelNeg = if CHPType == 1 then 760 else 0.60;
  parameter Real LHV(unit="J/kg")= if CHPType == 1 then 47300000 else 119972000 "Lower heating value [J/kg]";
//tauQ in PARAMETER !!!!
public
  parameter Modelica.SIunits.Temperature T0 = Modelica.SIunits.Conversions.from_degC(20);
  parameter Modelica.SIunits.Time WarmupTime=110
    "time until first heat is delivered by system after switched on"
                                                            annotation (Dialog(group="Control and operation", enable=withController));
  parameter Modelica.SIunits.Time CooldownTime=330
    "time until thermal output is zero after switched to standby"
                                                  annotation (Dialog(group="Control and operation", enable=withController));

  /* *******************************************************************
  Variables
  ******************************************************************* */

  //Modelica.SIunits.HeatFlowRate Q_th "Thermal power";
  Modelica.SIunits.Efficiency eff_el "CHP's electrical efficiency ";
  Modelica.SIunits.Efficiency eff_th "CHP's thermal efficiency ";
  Real sigma(start=0.4) "Nominal power to heat ratio";
  Real omega "Total efficiency";

  // Variables only for PEM fuel cell
  Modelica.SIunits.Power P_elDC "Electrical power in direct current part";
  Modelica.SIunits.Power Pel_anc
    "electrical power (AC) consumed by the ancillary units";
//   Modelica.SIunits.Power P_PCU "electrical power of the PCU";
//   Modelica.SIunits.HeatFlowRate dotQ_loss "Thermal heat loss";
  Modelica.SIunits.Efficiency eta_PCU "Efficiency of the pcu unit";

  /* *******************************************************************
  Components
  ******************************************************************* */

  Modelica.Blocks.Interfaces.RealInput PelRel "[0 to 1]" annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-164,36}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-92,98})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff
    annotation (Placement(transformation(extent={{14,14},{-14,-14}},
        rotation=90,
        origin={-154,108}),
                         iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={32,98})));
  Modelica.Blocks.Interfaces.RealOutput Capacity[3]( unit="W")
    "1=P_el 2=dotQ_th 3=dotE_fuel(incl. calorific value)"
    annotation (Placement(transformation(extent={{156,78},
            {180,102}}),
        iconTransformation(extent={{156,78},{180,102}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow varHeatFlow
    annotation (Placement(transformation(extent={{7,-8},{-7,8}},
        rotation=90,
        origin={2,-65})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor T_flow
    annotation (Placement(transformation(extent={{-48,-88},{-28,-68}})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor T_return
    annotation (Placement(transformation(extent={{36,-88},{56,-68}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1
                                                    "Output connector"
    annotation (Placement(transformation(extent={{152,-12},
            {172,8}}),
        iconTransformation(extent={{152,-12},{172,
            8}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1
                                                    "Input connector"
    annotation (Placement(transformation(extent={{-170,-10},{-150,10}}),
        iconTransformation(extent={{-170,-10},{-150,
            10}})));
  AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate
    annotation (Placement(transformation(extent={{-84,-88},{-64,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Energy[3](unit="J") "1=W_el 2=Q_th 3=E_fuel"
    annotation (Placement(transformation(extent={{156,16},
            {180,40}}),
        iconTransformation(extent={{156,16},{180,40}})));
  Modelica.Blocks.Continuous.Integrator integrator[3]
    annotation (Placement(transformation(extent={{130,20},{150,40}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(
    medium=medium,
    T0=T0,
    m_fluid=V_water*medium.rho)
    annotation (Placement(transformation(extent={{-8,-98},{12,-78}})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter LimiterPel(Rising=
        LimiterPelPos, Falling=-LimiterPelNeg) annotation (Placement(
        transformation(extent={{-16,84},{-4,96}})));
  input
  Modelica.Blocks.Interfaces.BooleanInput StartIn if not withController
    annotation (Placement(transformation(
        extent={{-14,14},{14,-14}},
        rotation=-90,
        origin={-126,108}),iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-58,98})));
  input
  Modelica.Blocks.Interfaces.BooleanInput StopIn if not withController
    annotation (Placement(transformation(extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-102,108}),
        iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-14,98})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderPel(T=tauP_el)
    annotation (Placement(transformation(extent={{-46,74},{-34,86}})));

  Modelica.Blocks.Nonlinear.SlewRateLimiter LimiterEFuel(Rising=2554.2, Falling=-2554.2)
    annotation (Placement(transformation(extent={{6,40},{26,60}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderEFuel(T=5)
    annotation (Placement(transformation(extent={{-46,54},{-34,66}})));
  Modelica.Blocks.Math.Gain PelDemand(k=P_elRated)
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-134,36})));
  Modelica.Blocks.Interfaces.RealOutput dotmFuel(  unit="kg/s") "Fuel consumption " annotation (
     Placement(transformation(extent={{156,50},{180,
            74}}),                                        iconTransformation(
          extent={{94,90},{118,114}})));
  Modelica.Blocks.Math.Gain Gain_LHV(k=1/LHV)
    annotation (Placement(transformation(extent={{132,52},{148,68}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_start(T=tauQ_th_start)
    annotation (Placement(transformation(extent={{-46,34},{-34,46}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_stop(T=tauQ_th_stop)
    annotation (Placement(transformation(extent={{-46,14},{-34,26}})));
  Modelica.Blocks.Logical.Switch Qth(y( unit="W")) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={16,20})));
  BaseClasses.StartStopController StartStopController(StartTime=WarmupTime,
      StopTime=CooldownTime) if                             withController
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-142,66})));
protected
  Modelica.Blocks.Interfaces.BooleanInput Start                       annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-98,50}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-98,78})), Dialog(enable=false));
  Modelica.Blocks.Interfaces.BooleanInput Stop                       annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-98,68}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-68,108})), Dialog(enable=false));
public
  Controller.SwitchCounter                     switchCounter
    annotation (Placement(transformation(extent={{-152,72},
            {-132,92}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_loss(T=tauQ_th_loss)
    annotation (Placement(transformation(extent={{-46,-6},{-34,6}})));
  Modelica.Blocks.Sources.RealExpression AncillaryConsumption(y=Pel_anc)
    annotation (Placement(transformation(extent={{72,62},{88,78}})));
  Modelica.Blocks.Math.Add sub(k2=-1) annotation (
     Placement(transformation(extent={{93,73},{107,87}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{14,74},{26,86}})));
  Modelica.Blocks.Sources.RealExpression EfficiencyPCU(y=eta_PCU)
    annotation (Placement(transformation(extent={{-16,62},{-4,78}})));
equation
  // Calculated efficiencies

  if EfficiencyByDatatable then
    // If IFC
      if CHPType == 1 then
        sigma = eff_el/eff_th;
        omega = eff_el+eff_th;
        eff_el = paramIFC.a_0 + paramIFC.a_1*(PelDemand.y/1000)^2 +
        paramIFC.a_2*(PelDemand.y/1000) + paramIFC.a_3*
        massFlowRate.dotm^2 + paramIFC.a_4*
        massFlowRate.dotm + paramIFC.a_5*
        Modelica.SIunits.Conversions.to_degC(T_return.T)^2 + paramIFC.a_6*
        Modelica.SIunits.Conversions.to_degC(T_return.T);
        eff_th =paramIFC.b_0 + paramIFC.b_1*(
        PelDemand.y/1000)^2 + paramIFC.b_2*(PelDemand.y/1000) + paramIFC.b_3*
        massFlowRate.dotm^2 + paramIFC.b_4*
        massFlowRate.dotm + paramIFC.b_5*
        Modelica.SIunits.Conversions.to_degC(T_return.T)^2 + paramIFC.b_6*
        Modelica.SIunits.Conversions.to_degC(T_return.T);
        eta_PCU = 1; // dummy
     // If PEM
      else
      //elseif CHPType ==2 then
        eff_el = paramPEM.eta_0  + paramPEM.eta_1 * P_elDC + paramPEM.eta_2 *P_elDC^2;
        eta_PCU = paramPEM.u_0  + paramPEM.u_1 * P_elDC + paramPEM.u_2 *P_elDC^2;
        eff_th = 0; //dummy
        sigma = 0; //dummy
        omega = 0; //dummy
      end if;

  // fixed efficiencies
  else
    if PelRel > 0.1 then
      eff_el =eta_el_prescribed*(0.261 + 0.161*Modelica.Math.log(PelRel*100));
    else
      eff_el = eta_el_prescribed * 0.261;
    end if;
    eff_th = omega_prescribed - eff_el;
    eta_PCU = eta_PCU_presribed;
  end if;

  // Operation conditions

  /* *******************************************************************
  Internal Combustion Engine (ICE)
  ******************************************************************* */
  if CHPType == 1 then //
     Pel_anc = 0; // no AC ancillary consumption for ICE units
     P_elDC = 0; // no split between AC and DC circuit for ICE units
     firstOrderQ_loss.u = 0; // there's no empirical formula to calculate heat losses for the ICE
       if OnOff then
         if Start then                                           //Startvorgang
           firstOrderQ_start.u = 0;
           firstOrderQ_stop.u = 0;
           firstOrderPel.u = P_elStart;
           firstOrderEFuel.u = dotE_start;
         else                                                            //Normalbetrieb
           firstOrderQ_start.u =PelDemand.y/sigma;
           firstOrderQ_stop.u = firstOrderQ_start.y;
           firstOrderPel.u =PelDemand.y;
           firstOrderEFuel.u = PelDemand.y/eff_el;
         end if;
       else
         if Stop then                                            //Stoppvorgang
            firstOrderQ_start.u = 0;
            firstOrderQ_stop.u = dotQ_stop;
            firstOrderPel.u = P_elStop;
            firstOrderEFuel.u = dotE_stop;
         else                                                    //Standby
            firstOrderQ_start.u = 0;
            firstOrderQ_stop.u = 0;
            firstOrderPel.u = P_elStandby;
            firstOrderEFuel.u = 0;
         end if;
     end if;
  /* *******************************************************************
  Proton Exchange Membran Fuel Cell (PEMFC)
  ******************************************************************* */
  elseif CHPType == 2 then
    P_elDC = LimiterPel.y;
     if OnOff then
         if Start then
           firstOrderPel.u = P_elStart;
           firstOrderQ_start.u = 0;
           firstOrderQ_stop.u = 0;
           firstOrderQ_loss.u = 0;
           Pel_anc = paramPEM.PelStartANC;
           firstOrderEFuel.u = dotE_start;
         else
           firstOrderPel.u = PelDemand.y;
           firstOrderQ_start.u = paramPEM.r_0 + paramPEM.r_1*(P_elDC)^paramPEM.alpha_0 + paramPEM.r_2*(Modelica.SIunits.Conversions.to_degC(T_flow.T) - paramPEM.T_0)^paramPEM.alpha_1;
           firstOrderQ_stop.u = paramPEM.r_0 + paramPEM.r_1*(P_elDC)^paramPEM.alpha_0 + paramPEM.r_2*(Modelica.SIunits.Conversions.to_degC(T_flow.T) - paramPEM.T_0)^paramPEM.alpha_1;
           firstOrderQ_loss.u = paramPEM.s_0 + paramPEM.s_1 * P_elDC^paramPEM.beta_0 + paramPEM.s_2 * (Modelica.SIunits.Conversions.to_degC(T_flow.T) - paramPEM.T_1)^paramPEM.beta_1;
           Pel_anc = paramPEM.anc_0 + paramPEM.anc_1 * firstOrderEFuel.y / (molarMassH2 * LHV);
           firstOrderEFuel.u = P_elDC/eff_el;
         end if;
     else
         if Stop then
           firstOrderPel.u = 0;
           firstOrderQ_start.u = 0;
           firstOrderQ_stop.u = 0;
           firstOrderQ_loss.u = 0;
           Pel_anc = paramPEM.PelStopANC;
           firstOrderEFuel.u = dotE_stop;
         else
           firstOrderPel.u = 0;
           firstOrderQ_start.u = 0;
           firstOrderQ_stop.u = 0;
           firstOrderQ_loss.u = 0;
           Pel_anc = paramPEM.anc_0 + paramPEM.anc_1 * firstOrderEFuel.y / (molarMassH2 * LHV);
           firstOrderEFuel.u = 0;
         end if;
     end if;
  else
    //dummys following
    P_elDC = LimiterPel.y;
    firstOrderPel.u = P_elStart; // !!! P_elStart noch nicht angepasst für PEM
    firstOrderQ_start.u = 0;
    firstOrderQ_stop.u = 0;
    firstOrderQ_loss.u = 0;
    Pel_anc = paramPEM.PelStartANC;
    firstOrderEFuel.u = dotE_start;
  end if;
  connect(varHeatFlow.port, workingFluid.heatPort)
    annotation (Line(points={{2,-72},{2,-78.6}},          color={191,0,0}));
  connect(enthalpyPort_a1, massFlowRate.enthalpyPort_a) annotation (Line(points={{-160,0},
          {-154,0},{-154,-78.1},{-82.8,-78.1}},            color={176,0,0}));
  connect(massFlowRate.enthalpyPort_b, T_flow.enthalpyPort_a) annotation (Line(
        points={{-65,-78.1},{-46.8,-78.1}},                             color={176,
          0,0}));
  connect(T_flow.enthalpyPort_b, workingFluid.enthalpyPort_a) annotation (Line(
        points={{-29,-78.1},{-17.5,-78.1},{-17.5,-88},{-7,-88}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b, T_return.enthalpyPort_a) annotation (
      Line(points={{11,-88},{24,-88},{24,-78.1},{37.2,-78.1}}, color={176,0,0}));
  connect(T_return.enthalpyPort_b, enthalpyPort_b1) annotation (Line(points={{55,
          -78.1},{146,-78.1},{146,-2},{162,-2}},     color={176,0,0}));
  connect(integrator.y, Energy) annotation (Line(points={{151,30},{160,30},{160,
          28},{168,28}},
                     color={0,0,127}));
  connect(firstOrderPel.y, LimiterPel.u)
    annotation (Line(points={{-33.4,80},{-28.7,80},{-28.7,90},{-17.2,90}},
                        color={0,0,127}));
  connect(firstOrderEFuel.y, LimiterEFuel.u) annotation (Line(points={{-33.4,60},
          {-23.3,60},{-23.3,50},{4,50}},                                               color={0,0,127}));
  connect(LimiterEFuel.y, integrator[3].u) annotation (Line(points={{27,50},{49.5,
          50},{49.5,51},{61.5,51},{61.5,30},{128,30}},                                                color={0,0,127}));
  connect(Gain_LHV.y, dotmFuel)
    annotation (Line(points={{148.8,60},{158,60},{158,62},{168,62}},
                                                  color={0,0,127}));
  connect(firstOrderQ_start.y, Qth.u1)
    annotation (Line(points={{-33.4,40},{-17.3,40},{-17.3,28},{4,28}},
                                                            color={0,0,127}));
  connect(firstOrderQ_stop.y, Qth.u3)
    annotation (Line(points={{-33.4,20},{-15.3,20},{-15.3,12},{4,12}},
                                                          color={0,0,127}));
  connect(Qth.y, Capacity[2])
    annotation (Line(points={{27,20},{52.5,20},{52.5,90},{168,90}},
                                                                  color={0,0,127}));
  connect(Qth.y, integrator[2].u) annotation (Line(points={{27,20},{57.5,20},{57.5,
          45},{62,45},{62,30},{128,30}},
                    color={0,0,127}));
  connect(LimiterEFuel.y, Gain_LHV.u) annotation (Line(points={{27,50},{69.3,50},
          {69.3,60},{130.4,60}},                                                                   color={0,0,127}));
  connect(Qth.y, varHeatFlow.Q_flow) annotation (Line(points={{27,20},{57,20},{57,
          -55},{2,-55},{2,-58}},
                   color={0,0,127}));
  connect(PelRel, PelDemand.u) annotation (Line(
        points={{-164,36},{-143.6,36}}, color={0,0,
          127}));

  if withController then
    connect(StartStopController.Stop, Stop)
    annotation (Line(points={{-130.8,61.8},{-110,61.8},
            {-110,68},{-98,68}},                                         color={255,0,255}));
    connect(StartStopController.Start, Start)
    annotation (Line(points={{-130.8,70.8},{-116,70.8},
            {-116,50},{-98,50}},                                         color={255,0,255}));
  else
    connect(StartIn, Start) annotation (Line(points={{-126,
            108},{-126,88},{-116,88},{-116,50},{-98,
            50}},                                                                                    color={255,0,255}));
  end if;
  connect(OnOff, switchCounter.u) annotation (Line(points={{-154,
          108},{-154,82},{-151,82}},                                                              color={255,0,255}));
  connect(OnOff, StartStopController.OnOff) annotation (Line(points={{-154,
          108},{-154,82},{-156,82},{-156,66},{-152,
          66}},                                color={255,0,255}));
  connect(Qth.u2, StartStopController.OnOff) annotation (Line(points={{4,20},{-4,
          20},{-4,-32},{-148,-32},{-148,20},{-156,20},{-156,66},{-152,66}},
                                                               color={255,0,255}));
  connect(StopIn, Stop)
    annotation (Line(points={{-102,108},{-102,68},
          {-98,68}},                                       color={255,0,255}));
  connect(LimiterEFuel.y, Capacity[3])
    annotation (Line(points={{27,50},{52.5,50},{52.5,98},{168,98}},
                     color={0,0,127}));
  connect(AncillaryConsumption.y, sub.u2) annotation (Line(points={{88.8,70},{89.3,
          70},{89.3,75.8},{91.6,75.8}},
                                      color={0,0,127}));
  connect(sub.y, Capacity[1]) annotation (Line(
        points={{107.7,80},{113.65,80},{113.65,82},{168,82}},
                color={0,0,127}));
  connect(sub.y, integrator[1].u) annotation (
      Line(points={{107.7,80},{114.65,80},{114.65,30},{128,30}},
                color={0,0,127}));
  connect(EfficiencyPCU.y, product.u2) annotation (Line(points={{-3.4,70},{1.3,70},
          {1.3,76.4},{12.8,76.4}},
                                 color={0,0,127}));
  connect(LimiterPel.y, product.u1) annotation (Line(points={{-3.4,90},{-0.7,90},
          {-0.7,83.6},{12.8,83.6}},
                              color={0,0,127}));
  connect(product.y, sub.u1) annotation (Line(points={{26.6,80},{36.4,80},{36.4,
          84.2},{91.6,84.2}},
                        color={0,0,127}));
  annotation (
    Icon(coordinateSystem(initialScale=0.2, extent={
            {-160,-100},{160,100}}),         graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillPattern=FillPattern.Solid,
          fillColor={247,247,247},
          lineColor={0,0,0}),
                    Text(
          extent={{-138,-98},{162,-138}},
          textString="%name",
          lineColor={0,0,255}),
        Rectangle(
          extent={{-64,34},{-14,-34}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-8,80},{66,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="On/Off"),
    Rectangle(
          extent={{-64,24},{-14,18}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,16},{-14,10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,42},{4,-42}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-40,-12},
          rotation=180),
        Ellipse(
          extent={{-60,-36},{-20,-76}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,8},{-14,2}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,32},{-14,26}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Bitmap(extent={{66,-16},{94,-100}}, fileName=
              "modelica://FastHVAC/Images/Blitz-T-Shirts.jpg"),
        Bitmap(extent={{16,56},{74,-38}}, fileName=
              "modelica://FastHVAC/Images/10_metaheiss.jpg"),
        Ellipse(
          extent={{-44,-52},{-36,-60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,30},{-14,2}},
          lineColor={0,0,0},
          lineThickness=1),
        Polygon(
          points={{20,-16},{68,32},{68,-16},{60,-16},{68,-16},{20,-16}},
          lineColor={0,0,0},
          lineThickness=0.5,
          smooth=Smooth.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-78,-24},{12,-90}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{26,-36},{70,-78}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid,
          fillColor={135,135,135}),
        Text(
          extent={{32,-42},{64,-74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          textString="G"),
        Line(
          points={{12,-54},{26,-54}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.None),
        Line(
          points={{12,-56},{26,-56}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.None),
        Rectangle(
          extent={{-14,22},{16,20}},
          lineThickness=1,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{16,18},{-14,16}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-50,-42},{-18,-74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          textString="M"),
        Line(
          points={{-14,22},{-14,14}},
          thickness=1,
          smooth=Smooth.None,
          color={0,0,0}),
        Text(
          extent={{-70,80},{4,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Start/Stop")}),
    Diagram(coordinateSystem(initialScale=0.2, extent={
            {-160,-100},{160,100}}),            graphics={Rectangle(
          extent={{-56,100},{-24,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-58,99},{-26,93}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="PT1 Delay")}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  <br/>
  Model for a electricity driven CHP.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  There are two possibilities for parameterization. The first is based
  on records for CHP characteristics from the <a href=
  \"AixLib.FastHVAC.Data.CHP.BaseDataDefinition\">FastHVAC.DataBase</a>. In this
  case the electrical and thermal efficiency of the CHP is a function
  of return temperature, water mass flow rate and electrical power.
</p>
<p>
  The second possibility is to set the parameters manually (compare:
  Parameters-Prescribed CHP model). In this case the set values are
  constant.
</p>
<p>
  The control strategy is pretended from an external
  controller. There is an ON/OFF switch to control the CHP. The start and stop can be either
  controlled from an internal controller that uses 
  start and stop times accroding to ROSATO, A. and SIBILIO, S. or can be pretended 
  from the outside by setting the value \"withController\". Furthermore a switch counter is implemented.
  </p>
  <p>
  The calculation of the thermal output is splitted into start and stop phase, 
  because they have different time constants (see ROSATO, A. ; SIBILIO, S) which 
  are taken into account by the two PT1 Elements.
  The other two PT1 Elements for fuel and electric energy are only integrated to
  avoid discrete changes to decrease simulation time.
  </p>
  <h4>
  <span style=\"color:#008000\">References</span>
  </h4>
  
  
  <p>Operation range: 15-60C Tin Pac: 250-1000W</p>
<ul>
  <li>ROSATO, A. ; SIBILIO, S.:: <i>Calibration and validation of a
model for simulating thermal and electric performance of an internal combustion
engine-based micro-cogeneration device.</i>. Applied Thermal Engineering 45-46 (2012),
S. 79–98.  </li>
  <li>ROSATO, A. ; SIBILIO, S.: <i>Energy performance of a microcogeneration
device during transient and steady-state operation: Experiments and simulations.</i>.
  Applied Thermal Engineering 52 (2013), Nr. 2, S. 478–491
  </li>
</ul>
  
  
  
  
  
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=\"FastHVAC.Examples.HeatGenerators.CHP.CHP\">CHP</a>
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 09, 2015&#160;</i> Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html>"));
end CHPCombined;
