within AixLib.FastHVAC.Components.HeatGenerators.HeatPump;
model HeatPumpWasteWater_driven

  extends Modelica.Icons.Example;

  // Medium definition

  parameter FastHVAC.Media.BaseClasses.Medium Medium_WasteWater = FastHVAC.Media.WasteWater();
  parameter Integer n_HeatingWater_layers=10;
  parameter Modelica.SIunits.Density rho_WasteWater = 995;

  Components.HeatGenerators.HeatPump.HeatPump heatPump
    annotation (Placement(transformation(extent={{-36,-76},{-66,-56}})));
  Components.Storage.WasteWaterStorage wasteWaterStorage(
    n_load_cycles=1,
    n_unload_cycles=1,
    data=AixLib.DataBase.Storage.Wastewater_500l(),
    load_cycles=[10,2],
    unload_cycles=[1,10],
    n_HC1_up=10,
    n_HC1_low=1,
    n=10,
    alpha_HC1=450,
    Up_to_down_HC1=true,
    T_start=295.15,
    T_start_HC=295.15,
    T_start_wall=295.15,
    T_start_ins=295.15)
    annotation (Placement(transformation(extent={{50,-68},{96,-20}})));
  Components.Sinks.Vessel          vessel annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={49,-90})));
  Components.Sinks.Vessel          vessel1
                                          annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=0,
        origin={103,-12})));
  Pumps.FluidSource fluidSource1(medium=AixLib.FastHVAC.Media.WaterSimple())
    annotation (Placement(transformation(extent={{90,-94},{78,-82}})));
  Modelica.Blocks.Sources.Constant T_unload(k=273.15 + 10)
    annotation (Placement(transformation(extent={{126,-78},{112,-68}})));
  Modelica.Blocks.Sources.Constant dotm_unload(k=0)
    annotation (Placement(transformation(extent={{124,-100},{112,-90}})));
  Components.Sensors.TemperatureSensor T_return_water_cond
    annotation (Placement(transformation(extent={{-58,-36},{-78,-16}})));
  Components.Sensors.TemperatureSensor T_return_water_evap
    annotation (Placement(transformation(extent={{-32,-82},{-12,-62}})));
  Pumps.Pump evap_pump
    annotation (Placement(transformation(extent={{2,-52},{22,-32}})));
  Components.Sinks.Vessel          vessel2
                                          annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={35,-92})));
  Components.Storage.BaseClasses.WasteWaterStorageControl
    wasteWaterStorageControl(
    n_WasteWater_layers=wasteWaterStorage.n,
    V_storage=wasteWaterStorage.data.hTank*wasteWaterStorage.data.dTank^2*
        Modelica.Constants.pi/4,
    rho_WasteWater=rho_WasteWater,
    n_HeatingWater_layers=n_HeatingWater_layers)
    annotation (Placement(transformation(extent={{56,28},{90,62}})));
  Interfaces.EnthalpyPort_a enthalpyPort_a
    annotation (Placement(transformation(extent={{-106,-78},{-98,-70}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b
    annotation (Placement(transformation(extent={{-106,-30},{-98,-22}})));
  Interfaces.EnthalpyPort_a WW_in
    annotation (Placement(transformation(extent={{64,96},{76,108}})));
  Modelica.Blocks.Interfaces.RealInput T_HeatingWaterStorage[
    n_HeatingWater_layers]
    annotation (Placement(transformation(extent={{-112,36},{-96,62}})));
  Pumps.Pump cond_pump
    annotation (Placement(transformation(extent={{-82,-34},{-96,-18}})));
equation
  connect(fluidSource1.enthalpyPort_b, wasteWaterStorage.UnloadingCycle_In[1])
    annotation (Line(points={{78,-87.4},{77.6,-87.4},{77.6,-68}},
                                                              color={176,0,0}));
  connect(T_unload.y, fluidSource1.T_fluid)
    annotation (Line(points={{111.3,-73},{88.8,-73},{88.8,-85.48}},
                                                            color={0,0,127}));
  connect(dotm_unload.y, fluidSource1.dotm) annotation (Line(points={{111.4,-95},
          {92,-95},{92,-89.56},{88.8,-89.56}},   color={0,0,127}));
  connect(T_return_water_evap.enthalpyPort_b, evap_pump.enthalpyPort_a)
    annotation (Line(points={{-13,-72.1},{-2,-72.1},{-2,-42},{2.4,-42}}, color=
          {176,0,0}));
  connect(wasteWaterStorage.port_HC1_out, heatPump.enthalpyPort_inEv)
    annotation (Line(points={{54.14,-56.96},{-3.93,-56.96},{-3.93,-57.8},{-38.6,
          -57.8}}, color={176,0,0}));
  connect(wasteWaterStorage.LoadingCycle_Out[1], vessel.enthalpyPort_a)
    annotation (Line(points={{68.4,-68},{68.4,-73},{49,-73},{49,-81.6}}, color=
          {176,0,0}));
  connect(wasteWaterStorage.UnloadingCycle_Out[1], vessel1.enthalpyPort_a)
    annotation (Line(points={{77.6,-20},{74,-20},{74,-12},{94.6,-12}}, color={
          176,0,0}));
  connect(evap_pump.enthalpyPort_b, wasteWaterStorage.port_HC1_in) annotation (
      Line(points={{21.6,-42},{40,-42},{40,-26},{54.6,-26},{54.6,-29.6}}, color=
         {176,0,0}));
  connect(heatPump.enthalpyPort_outEv, T_return_water_evap.enthalpyPort_a)
    annotation (Line(points={{-38.6,-74.2},{-38.3,-74.2},{-38.3,-72.1},{-30.8,-72.1}},
                   color={176,0,0}));
  connect(enthalpyPort_a, heatPump.enthalpyPort_inCo) annotation (Line(points={{-102,
          -74},{-63.6,-74},{-63.6,-74.2}},      color={176,0,0}));
  connect(wasteWaterStorageControl.HP_ison, heatPump.onOff_in) annotation (Line(
        points={{55.32,56.56},{-46,56.56},{-46,-57}}, color={255,0,255}));
  connect(wasteWaterStorageControl.WW_control_out_bypass, vessel2.enthalpyPort_a)
    annotation (Line(points={{61.78,28.34},{61.78,-12},{35,-12},{35,-83.6}},
        color={176,0,0}));
  connect(wasteWaterStorageControl.WW_control_out_storage, wasteWaterStorage.LoadingCycle_In[
    1]) annotation (Line(points={{73,28.34},{73,-1.83},{68.4,-1.83},{68.4,-20}},
        color={176,0,0}));
  connect(WW_in, wasteWaterStorageControl.WW_control_in) annotation (Line(
        points={{70,102},{70,61.66},{73,61.66}}, color={176,0,0}));
  connect(wasteWaterStorageControl.dot_m_evap_pump, evap_pump.dotm_setValue)
    annotation (Line(points={{54.98,38.54},{10,38.54},{10,-34},{12,-34}},color={
          0,0,127}));
  connect(T_return_water_cond.enthalpyPort_b, cond_pump.enthalpyPort_a)
    annotation (Line(points={{-77,-26.1},{-79.5,-26.1},{-79.5,-26},{-82.28,-26}},
        color={176,0,0}));
  connect(cond_pump.enthalpyPort_b, enthalpyPort_b)
    annotation (Line(points={{-95.72,-26},{-102,-26}}, color={176,0,0}));
  connect(wasteWaterStorageControl.dot_m_cond_pump, cond_pump.dotm_setValue)
    annotation (Line(points={{54.64,43.98},{-14,43.98},{-14,-6},{-89,-6},{-89,-19.6}},
        color={0,0,127}));
  connect(heatPump.enthalpyPort_outCo, T_return_water_cond.enthalpyPort_a)
    annotation (Line(points={{-63.2,-57.6},{-63.2,-50},{-50,-50},{-50,-26.1},{-59.2,
          -26.1}}, color={176,0,0}));
  connect(wasteWaterStorage.s_biofilm, wasteWaterStorageControl.s_biofilm)
    annotation (Line(points={{96.92,-25.28},{116,-25.28},{116,51.12},{91.02,
          51.12}},
        color={0,0,127}));
  connect(wasteWaterStorage.T_layers, wasteWaterStorageControl.T_WasteWaterStorage)
    annotation (Line(points={{52.3,-44},{46,-44},{46,33.27},{55.66,33.27}},
        color={0,0,127}));
  connect(T_HeatingWaterStorage, wasteWaterStorageControl.T_HeatingWaterStorage)
    annotation (Line(points={{-104,49},{-24,49},{-24,50.27},{54.98,50.27}},
        color={0,0,127}));
  connect(wasteWaterStorageControl.iscleaning, wasteWaterStorage.biofilm_removing)
    annotation (Line(points={{87.62,26.98},{87.62,-4},{87.49,-4},{87.49,-18.56}},
        color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end HeatPumpWasteWater_driven;
