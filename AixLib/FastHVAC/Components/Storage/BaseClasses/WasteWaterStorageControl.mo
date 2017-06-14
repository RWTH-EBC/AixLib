within AixLib.FastHVAC.Components.Storage.BaseClasses;
model WasteWaterStorageControl

  parameter Modelica.SIunits.Length s_biofilm_max = 0.005
    "max thickness of biofilm, when cleaning should be started";
  parameter Modelica.SIunits.Length s_biofilm_min= 0.0005
    "min thickness of biofilm, that could be reached by cleaning";
  parameter Modelica.SIunits.Temperature T_WasteWater_min_cleaning = 237.15 + 10
    "min Temperature of incoming wastewater for starting cleaning process";
  parameter Modelica.SIunits.Temperature T_WasteWater_upper_min = 237.15 + 15
    "min Temperature of highest layer in wastewaterstorage for leaving heatpump on";
  parameter Modelica.SIunits.Temperature T_HeatingWater_min_cleaning = 237.15 + 45
    "min Temperature of highest layer of heatingwater in storage for starting cleaning process";
  parameter Modelica.SIunits.Temperature T_HeatingWater_lower_max = 237.15 + 30
    "highest Temperature of lowest layer of heatingwater in storage for leaving heatpump on";
  parameter Modelica.SIunits.Density rho_WasteWater = 995
    "density wastewater - should be taken from model !-!-!";
  parameter Modelica.SIunits.Volume V_storage = 5
    "Volume of wastewater storage";
  parameter Modelica.SIunits.MassFlowRate dot_m_cond_pump_fix = 0.07
    "Massflowrate of condensor Pump if HP is on";
  parameter Modelica.SIunits.MassFlowRate dot_m_evap_pump_fix = 0.07
    "Massflowrate of evaporator Pump if HP is on";
  parameter Integer n_WasteWater_layers = 10
    "number of layers in wastewater storage";
  parameter Integer n_HeatingWater_layers = 10
    "number of layers in wastewater storage";
  inner parameter Integer t_cleaning = 600 "time duration of realeasing water + cleaning process";
  Boolean iscleaning "true if cleaning is necessary";
  Boolean cleaning_finished( start=false) "true if cleaning is finished";
  Integer time_0 "time when cleaning starts";
  Modelica.SIunits.Volume V_WasteWater( start=0)
    "Volume to simulate growing water level during fill process";
  Boolean bypass_forced_opened_value;
  Boolean bypass_forced_closed_value;
//   Real time_refill;
//   Real time_refill_0;
//   Real refill_mean_temperature_sum                    "mean temperature during refill";

//  Modelica.SIunits.Temperature T_mean_cleaning
//   "Mean temperature of incoming wastewater during refill process after cleaning";

  Interfaces.EnthalpyPort_a WW_control_in
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
  Interfaces.EnthalpyPort_b WW_control_out_storage
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));
  Interfaces.EnthalpyPort_b WW_control_out_bypass
    annotation (Placement(transformation(extent={{-76,-108},{-56,-88}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={88,-44})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{54,-62},{66,-50}})));
  Valves.ThreeWayValve            threeWayValve annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-68})));
  Modelica.Blocks.Logical.Less less annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={24,-42})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{100,-30},{90,-20}})));
  Modelica.Blocks.Interfaces.RealInput T_WasteWaterStorage[n_WasteWater_layers]
    annotation (Placement(transformation(extent={{-116,-84},{-88,-54}})));
  Modelica.Blocks.Interfaces.RealOutput dot_m_evap_pump
    annotation (Placement(transformation(extent={{-96,-48},{-116,-28}})));
  Modelica.Blocks.Interfaces.RealInput T_HeatingWaterStorage[n_HeatingWater_layers]
    annotation (Placement(transformation(extent={{-118,18},{-94,44}})));

  Modelica.Blocks.Interfaces.RealInput s_biofilm
    annotation (Placement(transformation(extent={{126,16},{86,56}})));
  Sensors.TemperatureSensor wastewatertemperature annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-2,-14})));
  Sensors.MassFlowSensor wastewatermassFlowRate annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,38})));
  Modelica.Blocks.Interfaces.RealOutput dot_m_cond_pump
    annotation (Placement(transformation(extent={{-98,-16},{-118,4}})));

  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{66,-16},{76,-6}})));
  Modelica.Blocks.Logical.Nor nor
    annotation (Placement(transformation(extent={{38,-30},{50,-18}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{54,-38},{64,-28}})));
  Modelica.Blocks.Interfaces.BooleanOutput HP_ison annotation (Placement(transformation(extent={{-94,58},{-114,78}})));
  Modelica.Blocks.Interfaces.BooleanOutput biofilm_removing(start=false) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={30,-104})));


  Modelica.Blocks.Sources.BooleanExpression bypass_forced_opened(y=
        bypass_forced_opened_value)
    annotation (Placement(transformation(extent={{10,6},{30,26}})));
  Modelica.Blocks.Sources.BooleanExpression bypass_forced_closed(y=
        bypass_forced_closed_value)
    annotation (Placement(transformation(extent={{12,-20},{32,0}})));

// initial equation
// refill_mean_temperature_sum=0;
equation
  ////////////////////////////////////////////////// Heatpump control

  //  if lowest temperature in heatingstorage is lower than a specified max temperature and  wastewater temperature is high enough and no cleaning is in procedure than set heatingpump on
 if T_HeatingWaterStorage[1]<T_HeatingWater_lower_max and  T_WasteWaterStorage[n_WasteWater_layers]>T_WasteWater_upper_min and not iscleaning then
   HP_ison=true;
 else
   HP_ison=false;
 end if;

  ////////////////////////////////////////////////// Evaporator and condensor pump control

if HP_ison then
  dot_m_cond_pump = dot_m_cond_pump_fix;
  dot_m_evap_pump = dot_m_evap_pump_fix;
else
  dot_m_cond_pump = 0;
  dot_m_evap_pump = 0;
end if;

  ////////////////////////////////////////////////// Cleaning

   // iniate cleaning if conditions are ok
when T_HeatingWaterStorage[n_HeatingWater_layers] > T_HeatingWater_min_cleaning and (rho_WasteWater * V_storage)/wastewatermassFlowRate.dotm < 600 and  wastewatertemperature.T > T_WasteWater_min_cleaning and not (pre(iscleaning)) and s_biofilm>s_biofilm_max then
   iscleaning =true;
   time_0=time;
   V_WasteWater = 0;
   // reinitialize after cleaning is done
elsewhen cleaning_finished then
  iscleaning=false;
  time_0=0;
  V_WasteWater = V_storage;
end when;

   // cleaning procedure itself
 when iscleaning then
   //first release wastewater from tank and clean (fixed time)
   if time < time_0 + t_cleaning then
     cleaning_finished=false;
     der(V_WasteWater)=0;
     bypass_forced_opened_value=true;
     bypass_forced_closed_value=false;
       if s_biofilm>s_biofilm_min then
         biofilm_removing=true;
       else
         biofilm_removing=false;
       end if;
    else
   // after releasing wastewater and cleaning: start refill
    biofilm_removing=false;
    bypass_forced_opened_value= false;
      if V_WasteWater < V_storage then
        cleaning_finished=false;
        der(V_WasteWater) = wastewatermassFlowRate.dotm/rho_WasteWater;
        bypass_forced_closed_value=true;

    // after refill go back to normal operation mode
      else

        cleaning_finished=true;
        der(V_WasteWater)=0;
        bypass_forced_closed_value=false;
      end if;
   end if;
 end when;




  connect(const.y, switch1.u1) annotation (Line(points={{89.5,-25},{78.4,-25},{78.4,
          -37.6}}, color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{66.6,-56},{72,-56},{72,
          -50},{76,-50},{76,-50.4},{78.4,-50.4}},
                                color={0,0,127}));
  connect(switch1.y, threeWayValve.opening) annotation (Line(points={{96.8,-44},
          {94,-44},{94,-68},{9,-68}},          color={0,0,127}));
  connect(threeWayValve.enthalpyPort_a, WW_control_out_storage)
    annotation (Line(points={{0,-78},{0,-98}}, color={176,0,0}));
  connect(threeWayValve.enthalpyPort_b, WW_control_out_bypass) annotation (Line(
        points={{-10,-68},{-38,-68},{-66,-68},{-66,-98}}, color={176,0,0}));
  connect(wastewatertemperature.enthalpyPort_b, threeWayValve.enthalpyPort_ab)
    annotation (Line(points={{-2.1,-23},{-2.1,-17.5},{1.77636e-015,-17.5},{1.77636e-015,
          -58.2}}, color={176,0,0}));
  connect(wastewatertemperature.T, less.u1)
    annotation (Line(points={{9,-15},{9,-42},{16.8,-42}},   color={0,0,127}));
  connect(WW_control_in, wastewatermassFlowRate.enthalpyPort_a)
    annotation (Line(points={{0,98},{-0.1,98},{-0.1,46.8}}, color={176,0,0}));
  connect(wastewatermassFlowRate.enthalpyPort_b, wastewatertemperature.enthalpyPort_a)
    annotation (Line(points={{-0.1,29},{-0.1,12},{-0.1,-5.2},{-2.1,-5.2}},
                                                                 color={176,0,0}));
  connect(T_WasteWaterStorage[1], less.u2) annotation (Line(points={{-102,-82.5},
          {-72,-82.5},{-72,-50},{16.8,-50},{16.8,-46.8}},
                                                       color={0,0,127}));
  connect(bypass_forced_closed.y, nor.u2) annotation (Line(points={{33,-10},{34,
          -10},{34,-28.8},{36.8,-28.8}}, color={255,0,255}));
  connect(bypass_forced_opened.y, nor.u1) annotation (Line(points={{31,16},{36,16},
          {36,0},{36.8,0},{36.8,-24}},    color={255,0,255}));
  connect(less.y, and2.u2) annotation (Line(points={{30.6,-42},{44,-42},{44,-37},
          {53,-37}}, color={255,0,255}));
  connect(nor.y, and2.u1) annotation (Line(points={{50.6,-24},{54,-24},{54,-33},
          {53,-33}}, color={255,0,255}));
  connect(bypass_forced_opened.y, or1.u1) annotation (Line(points={{31,16},{42,16},
          {42,-11},{65,-11}},    color={255,0,255}));
  connect(and2.y, or1.u2) annotation (Line(points={{64.5,-33},{64.5,-20},{62,-20},
          {62,-15},{65,-15}}, color={255,0,255}));
  connect(or1.y, switch1.u2) annotation (Line(points={{76.5,-11},{78,-11},{78,-22},
          {68,-22},{68,-44},{78.4,-44}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end WasteWaterStorageControl;
