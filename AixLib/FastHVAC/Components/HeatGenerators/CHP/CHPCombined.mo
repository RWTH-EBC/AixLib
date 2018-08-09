within AixLib.FastHVAC.Components.HeatGenerators.CHP;
model CHPCombined
  "CHP with internal combustion engine (ICE) including part load operation. To be used with dynamic mode controller (start/stop/OnOff/P_elRel)"

   parameter Boolean CHPType =  true "CHP Type"
    annotation(Dialog(group = "General", compact = true, descriptionLabel = true), choices(choice=true
        "Combustion",choice = false "PEM Fuel Cell",choice = false "SOFC Fuel Cell",
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
  parameter AixLib.FastHVAC.Data.CHP.Engine.BaseDataDefinition param=
      AixLib.FastHVAC.Data.CHP.Engine.AisinSeiki()
    "Paramter contains data from CHP records"
    annotation (choicesAllMatching=true, Dialog(enable=EfficiencyByDatatable));

  parameter Boolean withController=true "Use internal Start Stop Controller" annotation (Dialog(group="Control and operation"));

  parameter Modelica.SIunits.Power P_elRated_prescribed = 5000 annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Efficiency eta_el_prescribed = 0.25 "CHP's electrical efficiency  "
  annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Efficiency omega_prescribed = 0.65 "CHP's total efficiency "
  annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Time tauQ_th_stop_prescribed = 90
  "time constant for thermal start behavior" annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Time tauQ_th_start_prescribed = 800
  "time constant for stop behaviour" annotation (Dialog(group = "Prescribed CHP model",enable=not EfficiencyByDatatable));
  parameter Modelica.SIunits.Time tauP_el_prescribed = 100
  "time constant electrical power start behavior" annotation (Dialog(tab = "Prescribed CHP Model", group = "Prescribed CHP model",enable=not EfficiencyByDatatable));

protected
  parameter Modelica.SIunits.Power P_elRated = if EfficiencyByDatatable then param.P_elRated else P_elRated_prescribed;
  parameter Modelica.SIunits.Power dotE_fuelRated = if EfficiencyByDatatable then param.dotE_fuelRated else P_elRated_prescribed/eta_el_prescribed;
  parameter Modelica.SIunits.Power dotQ_thRated = if EfficiencyByDatatable then param.dotQ_thRated else dotE_fuelRated*(omega_prescribed-eta_el_prescribed);
  parameter Modelica.SIunits.Power dotE_start = 0.4 * dotE_fuelRated "Fuel consumption during start process";
  parameter Modelica.SIunits.Power dotQ_stop = 0.5 * dotQ_thRated "Themal energy production during stop process";
  parameter Modelica.SIunits.Power dotE_stop = 1/3 * dotE_fuelRated "Fuel consumption during stop process";
  parameter Modelica.SIunits.Time tauQ_th_start = if EfficiencyByDatatable then param.tauQ_th_start else tauQ_th_stop_prescribed
  "time constant for thermal start behavior (unit=sec) ";
  parameter Modelica.SIunits.Time tauQ_th_stop = if EfficiencyByDatatable then param.tauQ_th_stop else tauQ_th_stop_prescribed
  "time constant for stop behaviour (unit=sec)";
  parameter Modelica.SIunits.Time tauP_el = if EfficiencyByDatatable then param.tauP_el else tauP_el_prescribed
  "time constant electrical power start behavior (unit=sec)";
  parameter Modelica.SIunits.Volume V_water = 3e-3;
public
  parameter Modelica.SIunits.Power P_elStandby=90
    "electrical consumption in standby mode";
  parameter Modelica.SIunits.Power P_elStop=190
    "electrical consumption during shutdown mode";
  parameter Modelica.SIunits.Power P_elStart=190
    "electrical consumption during startup";
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

  Modelica.Blocks.Interfaces.RealInput P_elRel "[0 to 1]" annotation (
      Placement(transformation(extent={{-14,-14},{14,14}},
        rotation=-90,
        origin={-96,108}),
        iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-92,98})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff
    annotation (Placement(transformation(extent={{14,14},{-14,-14}},
        rotation=180,
        origin={-110,30}),
                         iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={32,98})));
  Modelica.Blocks.Interfaces.RealOutput Capacity[3]( unit="W")
    "1=P_el 2=dotQ_th 3=dotE_fuel(incl. calorific value)"
    annotation (Placement(transformation(extent={{94,90},{118,114}}),
        iconTransformation(extent={{94,90},{118,114}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow varHeatFlow
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={2,-56})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor T_flow
    annotation (Placement(transformation(extent={{-48,-84},{-28,-64}})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor T_return
    annotation (Placement(transformation(extent={{36,-84},{56,-64}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1
                                                    "Output connector"
    annotation (Placement(transformation(extent={{90,-12},{110,8}}),
        iconTransformation(extent={{90,-12},{110,8}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1
                                                    "Input connector"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  AixLib.FastHVAC.Components.Sensors.MassFlowSensor massFlowRate
    annotation (Placement(transformation(extent={{-84,-84},{-64,-64}})));
  Modelica.Blocks.Interfaces.RealOutput Energy[3](unit="J") "1=W_el 2=Q_th 3=E_fuel"
    annotation (Placement(transformation(extent={{96,16},{120,40}}),
        iconTransformation(extent={{96,16},{120,40}})));
  Modelica.Blocks.Continuous.Integrator integrator[3]
    annotation (Placement(transformation(extent={{72,18},{92,38}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(
    medium=medium,
    T0=T0,
    m_fluid=V_water*medium.rho)
    annotation (Placement(transformation(extent={{-8,-94},{12,-74}})));
  Modelica.Blocks.Nonlinear.SlewRateLimiter LimiterP(Rising=760, Falling=-760)
    annotation (Placement(transformation(extent={{20,76},{40,96}})));
  input
  Modelica.Blocks.Interfaces.BooleanInput StartIn if not withController
    annotation (Placement(transformation(
        extent={{-14,14},{14,-14}},
        rotation=-90,
        origin={-70,108}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-58,98})));
  input
  Modelica.Blocks.Interfaces.BooleanInput StopIn if not withController
    annotation (Placement(transformation(extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-42,108}),
        iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-14,98})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderP(T=tauP_el/3)
    annotation (Placement(transformation(extent={{-20,76},{0,96}})));

  Modelica.Blocks.Nonlinear.SlewRateLimiter LimiterEFuel(Rising=2554.2, Falling=-2554.2)
    annotation (Placement(transformation(extent={{20,46},{40,66}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderEFuel(T=5)
    annotation (Placement(transformation(extent={{-20,46},{0,66}})));
  Modelica.Blocks.Math.Gain Pel(k=P_elRated)
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-96,72})));
  Modelica.Blocks.Interfaces.RealOutput dotmFuel(  unit="kg/s") "Fuel consumption " annotation (
     Placement(transformation(extent={{96,50},{120,74}}), iconTransformation(
          extent={{94,90},{118,114}})));
  Modelica.Blocks.Math.Gain Gain_LHV(k=1/LHV)
    annotation (Placement(transformation(extent={{76,54},{92,70}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_start(T=tauQ_th_start/3)
    annotation (Placement(transformation(extent={{-18,14},{2,34}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderQ_stop(T=tauQ_th_stop/3)
    annotation (Placement(transformation(extent={{-18,-20},{2,0}})));
  Modelica.Blocks.Logical.Switch Qth(y( unit="W")) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,6})));
  BaseClasses.StartStopController StartStopController(StartTime=WarmupTime,
      StopTime=CooldownTime) if                             withController
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-74,30})));
protected
  Modelica.Blocks.Interfaces.BooleanInput Start                       annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-44,20}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-44,48})), Dialog(enable=false));
  Modelica.Blocks.Interfaces.BooleanInput Stop                       annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-44,54}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={-68,108})), Dialog(enable=false));
public
  Controller.SwitchCounter                     switchCounter
    annotation (Placement(transformation(extent={{-90,38},{-70,58}})));
equation
  // Calculate efficiencies
  sigma = eff_el/eff_th;
  omega = eff_el+eff_th;
  // Calculated efficiencies
  if EfficiencyByDatatable then
      eff_el =param.a_0 + param.a_1*(Pel.y/1000)^2 + param.a_2*(Pel.y/1000) + param.a_3*massFlowRate.dotm^2 + param.a_4*
      massFlowRate.dotm + param.a_5*Modelica.SIunits.Conversions.to_degC(T_return.T)^2 + param.a_6*
      Modelica.SIunits.Conversions.to_degC(T_return.T);
      eff_th =param.b_0 + param.b_1*(Pel.y/1000)^2 + param.b_2*(Pel.y/1000) + param.b_3*massFlowRate.dotm^2 + param.b_4*
      massFlowRate.dotm + param.b_5*Modelica.SIunits.Conversions.to_degC(T_return.T)^2 + param.b_6*
      Modelica.SIunits.Conversions.to_degC(T_return.T);
  // fixed efficiencies
  else
    if P_elRel > 0.1 then
      eff_el =eta_el_prescribed*(0.261 + 0.161*Modelica.Math.log(P_elRel*100));
    else
      eff_el = eta_el_prescribed * 0.261;
    end if;
    eff_th = omega_prescribed - eff_el;
  end if;

  // Operation conditions
     if OnOff then
       if Start then                                           //Startvorgang
         firstOrderQ_start.u = 0;
         firstOrderQ_stop.u = 0;
         firstOrderP.u =-P_elStart;
         firstOrderEFuel.u = dotE_start;
       else                                                            //Normalbetrieb
         firstOrderQ_start.u =Pel.y/sigma;
         firstOrderQ_stop.u = firstOrderQ_start.y;
         firstOrderP.u =Pel.y;
         firstOrderEFuel.u =Pel.y/eff_el;
       end if;
     else
       if Stop then                                            //Stoppvorgang
         firstOrderQ_start.u = 0;
         firstOrderQ_stop.u = dotQ_stop;
         firstOrderP.u =-P_elStop;
         firstOrderEFuel.u = dotE_stop;
       else                                                    //Standby
         firstOrderQ_start.u = 0;
         firstOrderQ_stop.u = 0;
         firstOrderP.u =-P_elStandby;
         firstOrderEFuel.u = 0;
       end if;
     end if;

  connect(varHeatFlow.port, workingFluid.heatPort)
    annotation (Line(points={{2,-66},{2,-74.6}},          color={191,0,0}));
  connect(enthalpyPort_a1, massFlowRate.enthalpyPort_a) annotation (Line(points={{-100,0},
          {-94,0},{-94,-74.1},{-82.8,-74.1}},              color={176,0,0}));
  connect(massFlowRate.enthalpyPort_b, T_flow.enthalpyPort_a) annotation (Line(
        points={{-65,-74.1},{-56.5,-74.1},{-56.5,-74.1},{-46.8,-74.1}}, color={176,
          0,0}));
  connect(T_flow.enthalpyPort_b, workingFluid.enthalpyPort_a) annotation (Line(
        points={{-29,-74.1},{-17.5,-74.1},{-17.5,-84},{-7,-84}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b, T_return.enthalpyPort_a) annotation (
      Line(points={{11,-84},{24,-84},{24,-74.1},{37.2,-74.1}}, color={176,0,0}));
  connect(T_return.enthalpyPort_b, enthalpyPort_b1) annotation (Line(points={{55,
          -74.1},{75.5,-74.1},{75.5,-2},{100,-2}},   color={176,0,0}));
  connect(LimiterP.y, Capacity[1]) annotation (Line(points={{41,86},{48,86},{48,
          102},{106,102},{106,94}},               color={0,0,127}));
  connect(integrator.y, Energy) annotation (Line(points={{93,28},{108,28}},
                     color={0,0,127}));
  connect(firstOrderP.y, LimiterP.u) annotation (Line(points={{1,86},{18,86}}, color={0,0,127}));
  connect(LimiterP.y, integrator[1].u)
    annotation (Line(points={{41,86},{48,86},{48,56},{56,56},{56,28},{70,28}}, color={0,0,127}));
  connect(firstOrderEFuel.y, LimiterEFuel.u) annotation (Line(points={{1,56},{18,56}}, color={0,0,127}));
  connect(LimiterEFuel.y, Capacity[3]) annotation (Line(points={{41,56},{48,56},{48,102},{80,102},{80,102},{94,102},{94,102},{106,
          102},{106,102},{106,102},{106,110},{106,110}}, color={0,0,127}));
  connect(LimiterEFuel.y, integrator[3].u) annotation (Line(points={{41,56},{56,56},{56,28},{70,28}}, color={0,0,127}));
  connect(Gain_LHV.y, dotmFuel)
    annotation (Line(points={{92.8,62},{108,62}}, color={0,0,127}));
  connect(firstOrderQ_start.y, Qth.u1)
    annotation (Line(points={{3,24},{6,24},{6,14},{18,14}}, color={0,0,127}));
  connect(firstOrderQ_stop.y, Qth.u3)
    annotation (Line(points={{3,-10},{8,-10},{8,-2},{18,-2}},
                                                          color={0,0,127}));
  connect(Qth.y, Capacity[2])
    annotation (Line(points={{41,6},{48,6},{48,102},{106,102}},   color={0,0,127}));
  connect(Qth.y, integrator[2].u) annotation (Line(points={{41,6},{48,6},{48,70},{56,70},{56,28},
          {70,28}}, color={0,0,127}));
  connect(LimiterEFuel.y, Gain_LHV.u) annotation (Line(points={{41,56},{66,56},{66,62},{74.4,62}}, color={0,0,127}));
  connect(Qth.y, varHeatFlow.Q_flow) annotation (Line(points={{41,6},{48,6},{48,
          -36},{2,-36},{2,-46}},
                   color={0,0,127}));
  connect(P_elRel, Pel.u) annotation (Line(points={{-96,108},{-96,81.6}}, color={0,0,127}));
  connect(OnOff, Qth.u2) annotation (Line(points={{-110,30},{-94,30},{-94,16},{-72,
          16},{-72,-32},{14,-32},{14,6},{18,6}},                                      color={255,0,255}));
  connect(OnOff, StartStopController.OnOff) annotation (Line(points={{-110,30},{
          -84,30}},                                                                       color={255,0,255}));

  if withController then
    connect(StartStopController.Stop, Stop)
    annotation (Line(points={{-62.8,25.8},{-50,25.8},{-50,54},{-44,54}}, color={255,0,255}));
    connect(StartStopController.Start, Start)
    annotation (Line(points={{-62.8,34.8},{-56,34.8},{-56,20},{-44,20}}, color={255,0,255}));
  else
    connect(StopIn, Stop) annotation (Line(points={{-42,108},{-42,76},{-50,76},{
            -50,54},{-44,54}},                                                                     color={255,0,255}));
    connect(StartIn, Start) annotation (Line(points={{-70,108},{-70,56},{-56,56},{-56,20},{-44,20}}, color={255,0,255}));
  end if;
  connect(OnOff, switchCounter.u) annotation (Line(points={{-110,30},{-98,30},{-98,48},{-89,48}}, color={255,0,255}));
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
          extent={{-26,108},{12,-28}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-24,106},{8,100}},
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
