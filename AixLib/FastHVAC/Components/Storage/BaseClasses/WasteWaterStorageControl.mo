within AixLib.FastHVAC.Components.Storage.BaseClasses;
model WasteWaterStorageControl

  parameter Modelica.SIunits.Length s_biofilm_max = 0.005
    "max thickness of biofilm, when cleaning should be started";
  parameter Modelica.SIunits.Length s_biofilm_min= 0.0005
    "min thickness of biofilm, that could be reached by cleaning";

  parameter Modelica.SIunits.Temperature T_HeatingWater_set = 273.15 + 61
    "max Temperature of third highest layer of heatingwater in storage for leaving heatpump on";
  parameter Modelica.SIunits.Temperature T_WasteWater_upper_min = 273.15 + 15
    "min Temperature of highest layer in wastewaterstorage for leaving heatpump on";
      parameter Modelica.SIunits.Temperature T_WasteWater_min_cleaning = 273.15 + 10
    "min Temperature of incoming wastewater for starting cleaning process";
  parameter Modelica.SIunits.Temperature T_HeatingWater_min_cleaning = 273.15 + 45
    "min Temperature of highest layer of heatingwater in storage for starting cleaning process";

  parameter Modelica.SIunits.Density rho_WasteWater = 995
    "density wastewater";
   Modelica.SIunits.Volume V_storage "Volume of wastewater storage";
  parameter Modelica.SIunits.Length d_storage = 1 "Diameter of wastewater storage";
  parameter Modelica.SIunits.Length h_storage = 1 "Height of wastewater storage";
  parameter Modelica.SIunits.MassFlowRate dot_m_cond_pump_fix = 0.07
    "Massflowrate of condensor Pump if HP is on";
  parameter Modelica.SIunits.MassFlowRate dot_m_evap_pump_fix = 0.07
    "Massflowrate of evaporator Pump if HP is on";
  parameter Integer n_WasteWater_layers = 10
    "number of layers in wastewater storage";
  parameter Integer n_HeatingWater_layers = 10
    "number of layers in wastewater storage";
  Integer t_releasing "time duration of realeasing water + cleaning process";
  parameter Integer t_cleaning = 3600 "time duration of cleaning process";
  Integer t_cleaning_end "";
  //Boolean iscleaning "true if cleaning is started";
  Boolean cleaning_finished "true if cleaning is finished";
  Integer time_cleaning_start "time when cleaning starts";
  Modelica.SIunits.Volume V_WasteWater
    "Volume to simulate growing water level during fill process";
  Boolean bypass_forced_opened_value "true if bypass if forced to keep opened";
  Boolean bypass_forced_closed_value
                                    "true if bypass if forced to keep closed";


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
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{100,-30},{90,-20}})));
  Modelica.Blocks.Interfaces.RealInput T_WasteWaterStorage[n_WasteWater_layers]
    annotation (Placement(transformation(extent={{-116,36},{-92,68}})));
  Modelica.Blocks.Interfaces.RealOutput dot_m_evap_pump
    annotation (Placement(transformation(extent={{-98,-102},{-118,-82}})));
  Modelica.Blocks.Interfaces.RealInput T_HeatingWaterStorage[n_HeatingWater_layers]
    annotation (Placement(transformation(extent={{-116,60},{-92,86}})));

  Modelica.Blocks.Interfaces.RealInput s_biofilm
    annotation (Placement(transformation(extent={{128,-112},{88,-72}})));
  Sensors.TemperatureSensor wastewatertemperature annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-4,0})));
  Sensors.MassFlowSensor wastewatermassFlowRate annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,42})));
  Modelica.Blocks.Interfaces.RealOutput dot_m_cond_pump
    annotation (Placement(transformation(extent={{-98,-80},{-118,-60}})));

  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{72,-14},{82,-4}})));
  Modelica.Blocks.Logical.Nor nor
    annotation (Placement(transformation(extent={{38,-36},{50,-24}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{56,-44},{66,-34}})));
  Modelica.Blocks.Interfaces.BooleanOutput HP_ison annotation (Placement(transformation(extent={{-100,86},
            {-120,106}})));


  Modelica.Blocks.Sources.BooleanExpression bypass_forced_opened(y=
        bypass_forced_opened_value)
    annotation (Placement(transformation(extent={{14,-18},{34,2}})));
  Modelica.Blocks.Sources.BooleanExpression bypass_forced_closed(y=
        bypass_forced_closed_value)
    annotation (Placement(transformation(extent={{12,-42},{32,-22}})));

  Modelica.Blocks.Interfaces.BooleanOutput iscleaning(start=false) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={50,-106})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{22,72},{12,84}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=5)
    annotation (Placement(transformation(extent={{-38,34},{-58,54}})));
  Modelica.Blocks.Sources.Constant const2(k=273.15 + 61)
    annotation (Placement(transformation(extent={{-16,50},{-28,62}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-34,76},{-54,96}})));
  Modelica.Blocks.Logical.OnOffController onOffController1(bandwidth=2)
    annotation (Placement(transformation(extent={{-30,-56},{-10,-36}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-64,-22},{-52,-10}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{-18,-26},{-30,-14}})));
initial equation
time_cleaning_start = 0;
cleaning_finished=true;
iscleaning=false;
bypass_forced_opened_value=false;
bypass_forced_closed_value=false;
V_WasteWater = 0;
equation
  V_storage=Modelica.Constants.pi * d_storage^2/4*h_storage;

  // Calculation of release time (Torricelli)  --  0.1 =^d_outlet
 t_releasing = integer((d_storage/0.1)^2*(2*h_storage/Modelica.Constants.g_n*(1-(0.1/d_storage)^4))^0.5);
 t_cleaning_end = time_cleaning_start + t_releasing +  t_cleaning;

//   ////////////////////////////////////////////////// Heatpump control
//   //  if lowest temperature in heatingstorage is lower than a specified max temperature and  wastewater temperature is high enough and no cleaning is in procedure than set heatingpump on
//  if T_WasteWaterStorage[n_WasteWater_layers]>T_WasteWater_upper_min and T_HeatingWaterStorage[n_HeatingWater_layers-5]<T_HeatingWater_lower_max and not iscleaning then
//                                                                       /**/
//    HP_ison=true;
//  else
//    HP_ison=false;
//  end if;

  ////////////////////////////////////////////////// Evaporator and condensor pump control

if HP_ison then
  dot_m_cond_pump = dot_m_cond_pump_fix;
  dot_m_evap_pump = dot_m_evap_pump_fix;
else
  dot_m_cond_pump = 0;
  dot_m_evap_pump = 0;
end if;

   // iniate cleaning if conditions are ok
   when wastewatermassFlowRate.dotm/(rho_WasteWater * V_storage) > 1/6000 and not (pre(iscleaning)) and s_biofilm>s_biofilm_max then
        /**/
        /*T_HeatingWaterStorage[10] > T_HeatingWater_min_cleaning and*/

                                                                                                                                                       /*and  wastewatertemperature.T > T_WasteWater_min_cleaning*/
                                                                                /**/
   iscleaning =true;
   time_cleaning_start=time;
   // reinitialize after cleaning is done
  reinit( V_WasteWater,0);
elsewhen pre(cleaning_finished) then
  iscleaning=false;
  time_cleaning_start=0;
  reinit( V_WasteWater,0);
end when;

    // cleaning procedure itself
  when iscleaning and time <= t_cleaning_end then
    //first release wastewater from tank and clean (fixed time) and hold bypass opened
      cleaning_finished=false;
      bypass_forced_opened_value=true;
      bypass_forced_closed_value=false;
     // after releasing wastewater and cleaning: start refill and hold bypass closed
  elsewhen iscleaning and time >t_cleaning_end  and V_WasteWater < V_storage then
     bypass_forced_opened_value= false;
         cleaning_finished=false;
         bypass_forced_closed_value=true;
     // after refill go back to normal operation mode
  elsewhen iscleaning and V_WasteWater >=V_storage then
         bypass_forced_opened_value= false;
         cleaning_finished=true;
         bypass_forced_closed_value=false;
 end when;

  if iscleaning and time >t_cleaning_end  and V_WasteWater < V_storage then
    der(V_WasteWater) = wastewatermassFlowRate.dotm/rho_WasteWater;
  else
    der(V_WasteWater) = 0;
  end if;

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
    annotation (Line(points={{-4.1,-9},{-4.1,-17.5},{1.77636e-015,-17.5},{1.77636e-015,
          -58.2}}, color={176,0,0}));
  connect(WW_control_in, wastewatermassFlowRate.enthalpyPort_a)
    annotation (Line(points={{0,98},{-0.1,98},{-0.1,50.8}}, color={176,0,0}));
  connect(wastewatermassFlowRate.enthalpyPort_b, wastewatertemperature.enthalpyPort_a)
    annotation (Line(points={{-0.1,33},{-0.1,33},{-0.1,8.8},{-4.1,8.8}},
                                                                 color={176,0,0}));
  connect(bypass_forced_closed.y, nor.u2) annotation (Line(points={{33,-32},{34,
          -32},{34,-34.8},{36.8,-34.8}}, color={255,0,255}));
  connect(nor.y, and2.u1) annotation (Line(points={{50.6,-30},{54,-30},{54,-39},
          {55,-39}}, color={255,0,255}));
  connect(and2.y, or1.u2) annotation (Line(points={{66.5,-39},{66.5,-20},{62,-20},
          {62,-13},{71,-13}}, color={255,0,255}));
  connect(or1.y, switch1.u2) annotation (Line(points={{82.5,-9},{86,-9},{86,-22},
          {76,-22},{76,-44},{78.4,-44}}, color={255,0,255}));
  connect(bypass_forced_opened.y, nor.u1) annotation (Line(points={{35,-8},{36,-8},
          {36,-30},{36.8,-30}}, color={255,0,255}));
  connect(bypass_forced_opened.y, or1.u1) annotation (Line(points={{35,-8},{52,-8},
          {52,-9},{71,-9}}, color={255,0,255}));
  connect(T_HeatingWaterStorage[8], onOffController.u) annotation (Line(points=
          {{-104,79.5},{-60,79.5},{-60,22},{-18,22},{-18,38},{-36,38}}, color={
          0,0,127}));
  connect(const2.y, onOffController.reference) annotation (Line(points={{-28.6,
          56},{-32,56},{-32,50},{-36,50}}, color={0,0,127}));
  connect(not1.y, and1.u2)
    annotation (Line(points={{11.5,78},{-32,78}}, color={255,0,255}));
  connect(onOffController.y, and1.u1) annotation (Line(points={{-59,44},{-58,44},
          {-58,70},{-22,70},{-22,86},{-32,86}}, color={255,0,255}));
  connect(and1.y, HP_ison) annotation (Line(points={{-55,86},{-78,86},{-78,96},
          {-110,96}}, color={255,0,255}));
  connect(onOffController1.y, and2.u2) annotation (Line(points={{-9,-46},{24,
          -46},{24,-43},{55,-43}}, color={255,0,255}));
  connect(add.y, onOffController1.u) annotation (Line(points={{-51.4,-16},{-48,
          -16},{-48,-18},{-42,-18},{-42,-52},{-32,-52}}, color={0,0,127}));
  connect(const3.y, onOffController1.reference) annotation (Line(points={{-30.6,
          -20},{-32,-20},{-32,-40}}, color={0,0,127}));
  connect(wastewatertemperature.T, add.u1) annotation (Line(points={{7,-1},{7,
          10},{-70,10},{-70,-12.4},{-65.2,-12.4}}, color={0,0,127}));
  connect(T_WasteWaterStorage[1], add.u2) annotation (Line(points={{-104,37.6},
          {-76,37.6},{-76,-19.6},{-65.2,-19.6}}, color={0,0,127}));
  connect(iscleaning, not1.u) annotation (Line(points={{50,-106},{50,-70},{116,
          -70},{116,78},{23,78}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end WasteWaterStorageControl;
