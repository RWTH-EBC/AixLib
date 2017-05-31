within AixLib.FastHVAC.Components.Storage.BaseClasses;
model WasteWaterStorageControl

  parameter Modelica.SIunits.Length s_biofilm_max = 0.005
    "max thickness of biofilm, when cleaning should be started";
  parameter Modelica.SIunits.Length s_biofilm_min= 0.0005
    "min thickness of biofilm, that could be reached by cleaning";
  parameter Modelica.SIunits.Temperature T_WasteWater_min = 237.15 + 15
    "min Temperature of incoming wastewater for starting cleaning process";
    parameter Modelica.SIunits.Temperature T_HeatingWater_min = 237.15 + 45
    "min Temperature of heatingwater in storage for starting cleaning process";
  parameter Modelica.SIunits.Density rho_WasteWater = 995
    "density wastewater - should be taken from model !-!-!";
  parameter Modelica.SIunits.Volume V_storage = 995
    "Volume of wastewater storage";
  parameter Modelica.SIunits.MassFlowRate dot_m_cond_pump_fix = 0.07
    "Massflowrate of condensor Pump if HP is on";
  parameter Modelica.SIunits.MassFlowRate dot_m_evap_pump_fix = 0.07
    "Massflowrate of evaporator Pump if HP is on";
  parameter Integer n_WasteWater_layers = 10
    "number of layers in wastewater storage";
  parameter Integer n_HeatingWater_layers = 10
    "number of layers in wastewater storage";
  Integer time_0 "time when cleaning starts";
  parameter Integer t_cleaning = 600 "time duration of cleaning process";
  Interfaces.EnthalpyPort_a WW_control_in
    annotation (Placement(transformation(extent={{-10,88},{10,108}})));
  Interfaces.EnthalpyPort_b WW_control_out_storage
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));
  Interfaces.EnthalpyPort_b WW_control_out_bypass
    annotation (Placement(transformation(extent={{-76,-108},{-56,-88}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={84,-44})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{32,-64},{44,-52}})));
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
    annotation (Placement(transformation(extent={{94,-28},{84,-18}})));
  Modelica.Blocks.Interfaces.RealInput T_WasteWaterStorage[n_WasteWater_layers]
    annotation (Placement(transformation(extent={{-136,-82},{-96,-42}})));
  Modelica.Blocks.Interfaces.RealOutput dot_m_evap_pump
    annotation (Placement(transformation(extent={{-100,-48},{-120,-28}})));
  Modelica.Blocks.Interfaces.RealInput T_HeatingWaterStorage[n_HeatingWater_layers]
    annotation (Placement(transformation(extent={{-116,20},{-92,46}})));
  Modelica.Blocks.Interfaces.BooleanOutput iscleaning annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={86,-106})));
  Modelica.Blocks.Interfaces.RealInput s_biofilm
    annotation (Placement(transformation(extent={{128,66},{88,106}})));
  Modelica.Blocks.Interfaces.BooleanOutput HP_ison
    annotation (Placement(transformation(extent={{-98,62},{-118,82}})));
  Sensors.TemperatureSensor wastewatertemperature annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-14})));
  Sensors.MassFlowSensor wastewatermassFlowRate annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,38})));
  Modelica.Blocks.MathBoolean.And and1(nu=2)
    annotation (Placement(transformation(extent={{-72,66},{-84,78}})));
  Modelica.Blocks.Logical.Less less1
    annotation (Placement(transformation(extent={{-32,74},{-52,94}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-44,48},{-54,58}})));
  Modelica.Blocks.Interfaces.RealOutput dot_m_cond_pump
    annotation (Placement(transformation(extent={{-98,-16},{-118,4}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-76,-14},{-90,0}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-76,-44},{-90,-30}})));
  Modelica.Blocks.Sources.Constant dot_m_cond_pump_on(k=dot_m_cond_pump_fix)
    annotation (Placement(transformation(extent={{-50,-8},{-62,4}})));
  Modelica.Blocks.Sources.Constant dot_m_evap_pump_on(k=dot_m_evap_pump_fix)
    annotation (Placement(transformation(extent={{-50,-36},{-62,-24}})));
  Modelica.Blocks.Sources.Constant dot_m_off(k=0)
    annotation (Placement(transformation(extent={{-24,-24},{-36,-12}})));
  Modelica.Blocks.Sources.BooleanConstant bypass_forced_opened
    annotation (Placement(transformation(extent={{6,-2},{18,10}})));
  Modelica.Blocks.Sources.BooleanConstant bypass_forced_closed
    annotation (Placement(transformation(extent={{14,-22},{26,-10}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{66,-16},{76,-6}})));
  Modelica.Blocks.Logical.Nor nor
    annotation (Placement(transformation(extent={{38,-30},{50,-18}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{56,-32},{66,-22}})));
equation

  // check if cleaning should be done
 if T_HeatingWaterStorage[10] < T_HeatingWater_min and (rho_WasteWater * V_storage)/wastewatermassFlowRate.dotm > 300 and  wastewatertemperature.T < T_WasteWater_min and (s_biofilm>=s_biofilm_min and s_biofilm<s_biofilm_max and pre(iscleaning)==false or s_biofilm<s_biofilm_min) then
  iscleaning=false;
else
  iscleaning=true;
end if;
// cleaning procedure
 if iscleaning then
   HP_ison = false;
   time=time_0;
for i in time:time_0 + t_cleaning loop
  bypass_forced_opened=true;
end for;
 end if;

//
//   sleep
//    bypass schließen

//   if s_biofilm>=s_biofilm_min and s_biofilm<s_biofilm_max and pre(iscleaning)==false or s_biofilm<s_biofilm_min then
//     iscleaning=false;
//   else
//     iscleaning=true;
//   end if;

  connect(const.y, switch1.u1) annotation (Line(points={{83.5,-23},{74.4,-23},{74.4,
          -37.6}}, color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{44.6,-58},{46,-58},{46,
          -50.4},{74.4,-50.4}}, color={0,0,127}));
  connect(switch1.y, threeWayValve.opening) annotation (Line(points={{92.8,-44},
          {94,-44},{94,-68},{9,-68}},          color={0,0,127}));
  connect(threeWayValve.enthalpyPort_a, WW_control_out_storage)
    annotation (Line(points={{0,-78},{0,-98}}, color={176,0,0}));
  connect(threeWayValve.enthalpyPort_b, WW_control_out_bypass) annotation (Line(
        points={{-10,-68},{-38,-68},{-66,-68},{-66,-98}}, color={176,0,0}));
  connect(wastewatertemperature.enthalpyPort_b, threeWayValve.enthalpyPort_ab)
    annotation (Line(points={{-0.1,-23},{-0.1,-17.5},{1.77636e-015,-17.5},{1.77636e-015,
          -58.2}}, color={176,0,0}));
  connect(wastewatertemperature.T, less.u1)
    annotation (Line(points={{11,-15},{11,-42},{16.8,-42}}, color={0,0,127}));
  connect(WW_control_in, wastewatermassFlowRate.enthalpyPort_a)
    annotation (Line(points={{0,98},{-0.1,98},{-0.1,46.8}}, color={176,0,0}));
  connect(wastewatermassFlowRate.enthalpyPort_b, wastewatertemperature.enthalpyPort_a)
    annotation (Line(points={{-0.1,29},{-0.1,-5.2}},             color={176,0,0}));
  connect(HP_ison, and1.y) annotation (Line(points={{-108,72},{-96,72},{-84.9,72}},
        color={255,0,255}));
  connect(less1.y, and1.u[1]) annotation (Line(points={{-53,84},{-62,84},{-62,74.1},
          {-72,74.1}}, color={255,0,255}));
  connect(not1.y, and1.u[2]) annotation (Line(points={{-54.5,53},{-62,53},{-62,69.9},
          {-72,69.9}}, color={255,0,255}));
  connect(not1.u, iscleaning) annotation (Line(points={{-43,53},{-43,26},{96,26},
          {96,-106},{86,-106}},        color={255,0,255}));
  connect(switch2.y, dot_m_cond_pump) annotation (Line(points={{-90.7,-7},{-91.35,
          -7},{-91.35,-6},{-108,-6}}, color={0,0,127}));
  connect(switch3.y, dot_m_evap_pump) annotation (Line(points={{-90.7,-37},{-95.35,
          -37},{-95.35,-38},{-110,-38}}, color={0,0,127}));
  connect(HP_ison, switch2.u2) annotation (Line(points={{-108,72},{-110,72},{-110,
          60},{-110,56},{-68,56},{-68,-7},{-74.6,-7}}, color={255,0,255}));
  connect(HP_ison, switch3.u2) annotation (Line(points={{-108,72},{-110,72},{-110,
          56},{-68,56},{-68,-37},{-74.6,-37}}, color={255,0,255}));
  connect(dot_m_cond_pump_on.y, switch2.u1) annotation (Line(points={{-62.6,-2},
          {-68,-2},{-68,-1.4},{-74.6,-1.4}}, color={0,0,127}));
  connect(dot_m_evap_pump_on.y, switch3.u1) annotation (Line(points={{-62.6,-30},
          {-70,-30},{-70,-31.4},{-74.6,-31.4}}, color={0,0,127}));
  connect(dot_m_off.y, switch2.u3) annotation (Line(points={{-36.6,-18},{-60,-18},
          {-60,-12.6},{-74.6,-12.6}}, color={0,0,127}));
  connect(dot_m_off.y, switch3.u3) annotation (Line(points={{-36.6,-18},{-46,-18},
          {-46,-42.6},{-74.6,-42.6}}, color={0,0,127}));
  connect(T_WasteWaterStorage[1], less.u2) annotation (Line(points={{-116,-80},{
          -72,-80},{-72,-50},{16.8,-50},{16.8,-46.8}}, color={0,0,127}));
  connect(bypass_forced_closed.y, nor.u2) annotation (Line(points={{26.6,-16},{34,
          -16},{34,-28.8},{36.8,-28.8}}, color={255,0,255}));
  connect(bypass_forced_opened.y, nor.u1) annotation (Line(points={{18.6,4},{34,
          4},{34,0},{36.8,0},{36.8,-24}}, color={255,0,255}));
  connect(less.y, and2.u2) annotation (Line(points={{30.6,-42},{44,-42},{44,-31},
          {55,-31}}, color={255,0,255}));
  connect(nor.y, and2.u1) annotation (Line(points={{50.6,-24},{54,-24},{54,-27},
          {55,-27}}, color={255,0,255}));
  connect(bypass_forced_opened.y, or1.u1) annotation (Line(points={{18.6,4},{42,
          4},{42,-11},{65,-11}}, color={255,0,255}));
  connect(and2.y, or1.u2) annotation (Line(points={{66.5,-27},{66.5,-20},{62,-20},
          {62,-15},{65,-15}}, color={255,0,255}));
  connect(or1.y, switch1.u2) annotation (Line(points={{76.5,-11},{78,-11},{78,-22},
          {68,-22},{68,-44},{74.4,-44}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end WasteWaterStorageControl;
