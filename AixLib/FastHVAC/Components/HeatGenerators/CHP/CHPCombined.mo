within AixLib.FastHVAC.Components.HeatGenerators.CHP;
model CHPCombined
  "CHP with internal combustion engine (ICE) including part load operation. To be used with dynamic mode controller (start/stop/OnOff/P_elRel)"

   parameter Integer CHPType "CHP Type"
    annotation(Dialog(group = "General", compact = true, descriptionLabel = true), choices(choice=1
        "Combustion",choice = 2 "PEM Fuel Cell",choice = 3 "SOFC Fuel Cell",
                              radioButtons = true));


  /* *******************************************************************
  Medium
  ******************************************************************* */
  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple medium=
  AixLib.FastHVAC.Media.WaterSimple()
  "Standard flow charastics for water (heat capacity, density, thermal conductivity)"    annotation (choicesAllMatching);
  constant Real LHV(unit="J/kg")=47300000 "Lower heating value [J/kg]";

  /* *******************************************************************
  BHKW Parameters
  ******************************************************************* */
  parameter Boolean EfficiencyByDatatable=true
    "Use datasheet values for efficiency calculations";
  parameter Data.CHP.Engine.BaseDataDefinition paramIFC=
      AixLib.FastHVAC.Data.CHP.Engine.AisinSeiki()
    "Record for IFC Parametrization"
    annotation (choicesAllMatching=true, Dialog(enable=EfficiencyByDatatable and CHPType==1));

  parameter Data.CHP.FuelcellPEM.BaseDataDefinition paramPCM=
      AixLib.FastHVAC.Data.CHP.FuelcellPEM.MorrisonPEMFC()
    "Record for PCM Parametrization"
    annotation (choicesAllMatching=true, Dialog(enable=EfficiencyByDatatable and CHPType==2));

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
  "time constant for thermal start behavior" annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Time tauQ_th_start_prescribed = 800
  "time constant for stop behaviour" annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Time tauP_el_prescribed = 100
  "time constant electrical power start behavior" annotation (Dialog(tab = "Prescribed CHP Model", group = "Prescribed CHP model",enable=not EfficiencyByDatatable));


  // Parameters and variables only for PEM fuel cell
  Modelica.SIunits.Power P_anc "electrical power (AC) consumed by the ancillary units";
  Modelica.SIunits.Power P_PCU "electrical power of the PCU";
  Modelica.SIunits.HeatFlowRate dotQ_loss "Thermal heat loss";

protected
  parameter Integer n = if CHPType ==1 then 1 elseif CHPType == 2 then 5 else 5 "Size of PT1 System array, has to be changed for different CHP Types";
  parameter Modelica.SIunits.Power P_elRated=if EfficiencyByDatatable then
      paramIFC.P_elRated else P_elRated_prescribed;
  parameter Modelica.SIunits.Power dotE_fuelRated=if EfficiencyByDatatable
       then paramIFC.dotE_fuelRated else P_elRated_prescribed/eta_el_prescribed;
  parameter Modelica.SIunits.Power dotQ_thRated=if EfficiencyByDatatable then
      paramIFC.dotQ_thRated else dotE_fuelRated*(omega_prescribed -
      eta_el_prescribed);
  parameter Modelica.SIunits.Power P_elStandby=if EfficiencyByDatatable then
      paramIFC.P_elStandby else P_elStandby_prescribed;
  parameter Modelica.SIunits.Power P_elStop=if EfficiencyByDatatable then
      paramIFC.P_elStop else P_elStop_prescribed;
  parameter Modelica.SIunits.Power P_elStart=if EfficiencyByDatatable then
      paramIFC.P_elStart else P_elStart_prescribed;
  parameter Modelica.SIunits.Power dotE_start = 0.4 * dotE_fuelRated "Fuel consumption during start process";
  parameter Modelica.SIunits.Power dotQ_stop = 0.5 * dotQ_thRated "Themal energy production during stop process";
  parameter Modelica.SIunits.Power dotE_stop = 1/3 * dotE_fuelRated "Fuel consumption during stop process";
  parameter Modelica.SIunits.Time tauQ_th_start=if EfficiencyByDatatable then
      paramIFC.tauQ_th_start else tauQ_th_stop_prescribed
    "time constant for thermal start behavior (unit=sec) ";
  parameter Modelica.SIunits.Time tauQ_th_stop=if EfficiencyByDatatable then
      paramIFC.tauQ_th_stop else tauQ_th_stop_prescribed
    "time constant for stop behaviour (unit=sec)";

  parameter Modelica.SIunits.Time tauP_el=if EfficiencyByDatatable then
      paramIFC.tauP_el else tauP_el_prescribed
    "time constant electrical power start behavior (unit=sec)";
  parameter Modelica.SIunits.Volume V_water = 3e-3;


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

  /* *******************************************************************
  Components
  ******************************************************************* */

  Modelica.Blocks.Interfaces.RealInput PelRel "[0 to 1]" annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-104,36}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-92,98})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff
    annotation (Placement(transformation(extent={{14,14},{-14,-14}},
        rotation=90,
        origin={-94,108}),
                         iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={32,98})));
  Modelica.Blocks.Interfaces.RealOutput Capacity[3]( unit="W")
    "1=P_el 2=dotQ_th 3=dotE_fuel(incl. calorific value)"
    annotation (Placement(transformation(extent={{94,78},
            {118,102}}),
        iconTransformation(extent={{94,78},{118,102}})));

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
    annotation (Placement(transformation(extent={{90,-12},{110,8}}),
        iconTransformation(extent={{90,-12},{110,8}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1
                                                    "Input connector"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate
    annotation (Placement(transformation(extent={{-84,-88},{-64,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Energy[3](unit="J") "1=W_el 2=Q_th 3=E_fuel"
    annotation (Placement(transformation(extent={{96,16},{120,40}}),
        iconTransformation(extent={{96,16},{120,40}})));
  Modelica.Blocks.Continuous.Integrator integrator[3]
    annotation (Placement(transformation(extent={{72,18},{92,38}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(
    medium=medium,
    T0=T0,
    m_fluid=V_water*medium.rho)
    annotation (Placement(transformation(extent={{-8,-98},{12,-78}})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter LimiterPel(Rising=
        760, Falling=-760) annotation (Placement(
        transformation(extent={{32,76},{52,96}})));
  input
  Modelica.Blocks.Interfaces.BooleanInput StartIn if not withController
    annotation (Placement(transformation(
        extent={{-14,14},{14,-14}},
        rotation=-90,
        origin={-68,108}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-58,98})));
  input
  Modelica.Blocks.Interfaces.BooleanInput StopIn if not withController
    annotation (Placement(transformation(extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-52,108}),
        iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-14,98})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderPel(T=tauP_el)
    annotation (Placement(transformation(extent={{
            -20,76},{-8,88}})));

  Modelica.Blocks.Nonlinear.SlewRateLimiter LimiterEFuel(Rising=2554.2, Falling=-2554.2)
    annotation (Placement(transformation(extent={{32,46},
            {52,66}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderEFuel(T=5)
    annotation (Placement(transformation(extent={{-20,56},
            {-8,68}})));
  Modelica.Blocks.Math.Gain Pel(k=P_elRated)
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-74,36})));
  Modelica.Blocks.Interfaces.RealOutput dotmFuel(  unit="kg/s") "Fuel consumption " annotation (
     Placement(transformation(extent={{96,50},{120,74}}), iconTransformation(
          extent={{94,90},{118,114}})));
  Modelica.Blocks.Math.Gain Gain_LHV(k=1/LHV)
    annotation (Placement(transformation(extent={{76,54},{92,70}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_start(T=tauQ_th_start/3)
    annotation (Placement(transformation(extent={{-20,36},
            {-8,48}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_stop(T=tauQ_th_stop/3)
    annotation (Placement(transformation(extent={{-20,16},
            {-8,28}})));
  Modelica.Blocks.Logical.Switch Qth(y( unit="W")) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={42,16})));
  BaseClasses.StartStopController StartStopController(StartTime=WarmupTime,
      StopTime=CooldownTime) if                             withController
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-82,66})));
protected
  Modelica.Blocks.Interfaces.BooleanInput Start                       annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-48,50}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-48,78})), Dialog(enable=false));
  Modelica.Blocks.Interfaces.BooleanInput Stop                       annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-48,68}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-68,108})), Dialog(enable=false));
public
  Controller.SwitchCounter                     switchCounter
    annotation (Placement(transformation(extent={{-92,72},{-72,92}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_loss(T=tauQ_th_loss/3)
    annotation (Placement(transformation(extent={{-20,-4},
            {-8,8}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderSystem[n](T=
        tauSystem) annotation (Placement(
        transformation(extent={{-20,-24},{-8,-12}})));
equation
  // Calculate efficiencies
  sigma = eff_el/eff_th;
  omega = eff_el+eff_th;
  // Calculated efficiencies
  if EfficiencyByDatatable then
    // If IFC
      if CHPType == 1 then
      eff_el =paramIFC.a_0 + paramIFC.a_1*(Pel.y/1000)^2 + paramIFC.a_2*(Pel.y/1000)
         + paramIFC.a_3*massFlowRate.dotm^2 + paramIFC.a_4*massFlowRate.dotm +
        paramIFC.a_5*Modelica.SIunits.Conversions.to_degC(T_return.T)^2 +
        paramIFC.a_6*Modelica.SIunits.Conversions.to_degC(T_return.T);
      eff_th =paramIFC.b_0 + paramIFC.b_1*(Pel.y/1000)^2 + paramIFC.b_2*(Pel.y/1000)
         + paramIFC.b_3*massFlowRate.dotm^2 + paramIFC.b_4*massFlowRate.dotm +
        paramIFC.b_5*Modelica.SIunits.Conversions.to_degC(T_return.T)^2 +
        paramIFC.b_6*Modelica.SIunits.Conversions.to_degC(T_return.T);
     // If PEM
      elseif CHPType ==2 then
        eta_el = paramPCM.eta_0 + paramPCM.eta_1*P_elDC + paramPCM.eta_2*P_elDC^2;
        eta_PCU = paramPCM.u_0 + paramPCM.u_1*P_elDC + paramPCM.u_2*P_elDC^2;
        eff_th = 1; //dummy
      end if;


  // fixed efficiencies
  else
    if PelRel > 0.1 then
      eff_el =eta_el_prescribed*(0.261 + 0.161*Modelica.Math.log(PelRel*100));
    else
      eff_el = eta_el_prescribed * 0.261;
    end if;
    eff_th = omega_prescribed - eff_el;
  end if;

  // Operation conditions
     if CHPType == 1 then // ICE Equations

       if OnOff then
         if Start then                                           //Startvorgang
           firstOrderQ_start.u = 0;
           firstOrderQ_stop.u = 0;
           firstOrderPel.u = -P_elStart;
           firstOrderEFuel.u = dotE_start;
         else                                                            //Normalbetrieb
           firstOrderQ_start.u =Pel.y/sigma;
           firstOrderQ_stop.u = firstOrderQ_start.y;
           firstOrderPel.u = Pel.y;
           firstOrderEFuel.u =Pel.y/eff_el;
         end if;
       else
         if Stop then                                            //Stoppvorgang
            firstOrderQ_start.u = 0;
            firstOrderQ_stop.u = dotQ_stop;
            firstOrderPel.u = -P_elStop;
            firstOrderEFuel.u = dotE_stop;
         else                                                    //Standby
            firstOrderQ_start.u = 0;
            firstOrderQ_stop.u = 0;
            firstOrderPel.u = -P_elStandby;
            firstOrderEFuel.u = 0;
         end if;
       end if;

   elseif CHPType == 2 then
       if OnOff then
         if Start then
           firstOrderPel.u = -P_elStart;
         else
           firstOrderPel.u = Pel.y/eta_PCU;
         end if;
       else
         if Stop then
           firstOrderPel.u = 0;
         else
           firstOrderPel.u = 0;
         end if;
       end if;
   end if;
  connect(varHeatFlow.port, workingFluid.heatPort)
    annotation (Line(points={{2,-72},{2,-78.6}},          color={191,0,0}));
  connect(enthalpyPort_a1, massFlowRate.enthalpyPort_a) annotation (Line(points={{-100,0},
          {-94,0},{-94,-78.1},{-82.8,-78.1}},              color={176,0,0}));
  connect(massFlowRate.enthalpyPort_b, T_flow.enthalpyPort_a) annotation (Line(
        points={{-65,-78.1},{-46.8,-78.1}},                             color={176,
          0,0}));
  connect(T_flow.enthalpyPort_b, workingFluid.enthalpyPort_a) annotation (Line(
        points={{-29,-78.1},{-17.5,-78.1},{-17.5,-88},{-7,-88}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b, T_return.enthalpyPort_a) annotation (
      Line(points={{11,-88},{24,-88},{24,-78.1},{37.2,-78.1}}, color={176,0,0}));
  connect(T_return.enthalpyPort_b, enthalpyPort_b1) annotation (Line(points={{55,
          -78.1},{75.5,-78.1},{75.5,-2},{100,-2}},   color={176,0,0}));
  connect(integrator.y, Energy) annotation (Line(points={{93,28},{108,28}},
                     color={0,0,127}));
  connect(firstOrderPel.y, LimiterPel.u)
    annotation (Line(points={{-7.4,82},{12,82},{12,
          86},{30,86}}, color={0,0,127}));
  connect(LimiterPel.y, integrator[1].u)
    annotation (Line(points={{53,86},{56,86},{56,56},
          {64,56},{64,28},{70,28}}, color={0,0,127}));
  connect(firstOrderEFuel.y, LimiterEFuel.u) annotation (Line(points={{-7.4,62},
          {16,62},{16,56},{30,56}},                                                    color={0,0,127}));
  connect(LimiterEFuel.y, integrator[3].u) annotation (Line(points={{53,56},
          {64,56},{64,28},{70,28}},                                                                   color={0,0,127}));
  connect(Gain_LHV.y, dotmFuel)
    annotation (Line(points={{92.8,62},{108,62}}, color={0,0,127}));
  connect(firstOrderQ_start.y, Qth.u1)
    annotation (Line(points={{-7.4,42},{10,42},{10,
          24},{30,24}},                                     color={0,0,127}));
  connect(firstOrderQ_stop.y, Qth.u3)
    annotation (Line(points={{-7.4,22},{12,22},{12,
          8},{30,8}},                                     color={0,0,127}));
  connect(Qth.y, Capacity[2])
    annotation (Line(points={{53,16},{56,16},{56,90},
          {106,90}},                                              color={0,0,127}));
  connect(Qth.y, integrator[2].u) annotation (Line(points={{53,16},
          {56,16},{56,70},{64,70},{64,28},{70,28}},
                    color={0,0,127}));
  connect(LimiterEFuel.y, Gain_LHV.u) annotation (Line(points={{53,56},
          {74,56},{74,62},{74.4,62}},                                                              color={0,0,127}));
  connect(Qth.y, varHeatFlow.Q_flow) annotation (Line(points={{53,16},
          {56,16},{56,-56},{2,-56},{2,-58}},
                   color={0,0,127}));
  connect(PelRel, Pel.u)
    annotation (Line(points={{-104,36},{-83.6,36}}, color={0,0,127}));

  if withController then
    connect(StartStopController.Stop, Stop)
    annotation (Line(points={{-70.8,61.8},{-50,61.8},{-50,68},{-48,68}}, color={255,0,255}));
    connect(StartStopController.Start, Start)
    annotation (Line(points={{-70.8,70.8},{-56,70.8},{-56,50},{-48,50}}, color={255,0,255}));
  else
    connect(StartIn, Start) annotation (Line(points={{-68,108},{-68,88},{-56,88},
            {-56,50},{-48,50}},                                                                      color={255,0,255}));
  end if;
  connect(OnOff, switchCounter.u) annotation (Line(points={{-94,108},{-94,82},{-91,
          82}},                                                                                   color={255,0,255}));
  connect(OnOff, StartStopController.OnOff) annotation (Line(points={{-94,108},{
          -94,82},{-96,82},{-96,66},{-92,66}}, color={255,0,255}));
  connect(Qth.u2, StartStopController.OnOff) annotation (Line(points={{30,16},
          {30,-54},{-88,-54},{-88,16},{-96,16},{-96,
          66},{-92,66}},                                       color={255,0,255}));
  connect(StopIn, Stop)
    annotation (Line(points={{-52,108},{-52,68},{-48,68}}, color={255,0,255}));
  connect(LimiterEFuel.y, Capacity[3])
    annotation (Line(points={{53,56},{56,56},{56,98},
          {106,98}}, color={0,0,127}));
  connect(LimiterPel.y, Capacity[1]) annotation (
      Line(points={{53,86},{56,86},{56,82},{106,82}},
        color={0,0,127}));
  annotation (
    Icon(coordinateSystem(initialScale=0.2), graphics={
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
    Diagram(coordinateSystem(initialScale=0.2), graphics={Rectangle(
          extent={{-26,100},{16,-28}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-24,98},{8,92}},
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
