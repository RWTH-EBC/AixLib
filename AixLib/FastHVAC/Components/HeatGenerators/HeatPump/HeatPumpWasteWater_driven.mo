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
    annotation (Placement(transformation(extent={{54,-68},{96,-26}})));
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
  Pumps.Pump evap_pump
    annotation (Placement(transformation(extent={{-12,-52},{8,-32}})));
  Components.Storage.BaseClasses.WasteWaterStorageControl
    wasteWaterStorageControl(
    n_WasteWater_layers=wasteWaterStorage.n,
    V_storage=wasteWaterStorage.data.hTank*wasteWaterStorage.data.dTank^2*
        Modelica.Constants.pi/4,
    rho_WasteWater=rho_WasteWater,
    n_HeatingWater_layers=n_HeatingWater_layers)
    annotation (Placement(transformation(extent={{56,26},{90,60}})));
  Interfaces.EnthalpyPort_a toHeatPump
    annotation (Placement(transformation(extent={{-104,-56},{-96,-48}})));
  Interfaces.EnthalpyPort_b fromHeatPump
    annotation (Placement(transformation(extent={{-106,66},{-98,74}})));
  Interfaces.EnthalpyPort_a WW_in
    annotation (Placement(transformation(extent={{64,96},{76,108}})));
  Modelica.Blocks.Interfaces.RealInput T_HeatingWaterStorage[
    n_HeatingWater_layers]
    annotation (Placement(transformation(extent={{-112,-104},{-96,-78}})));
  Pumps.Pump cond_pump
    annotation (Placement(transformation(extent={{-82,-34},{-96,-18}})));
  Interfaces.EnthalpyPort_b fromWasteWaterStorage
    annotation (Placement(transformation(extent={{56,-104},{64,-96}})));
equation
  //get heat transfer coefficient at the upper level for cleaning control
 // wasteWaterStorageControl.Q_wastewater_upperlevel = wasteWaterStorage.heatingCoil1.Therm1[wasteWaterStorage.n].Q_flow;

connect(  fluidSource1.enthalpyPort_b, wasteWaterStorage.UnloadingCycle_In[1])
    annotation (Line(points={{78,-87.4},{79.2,-87.4},{79.2,-68}},
                                                              color={176,0,0}));
  connect(T_unload.y, fluidSource1.T_fluid)
    annotation (Line(points={{111.3,-73},{88.8,-73},{88.8,-85.48}},
                                                            color={0,0,127}));
  connect(dotm_unload.y, fluidSource1.dotm) annotation (Line(points={{111.4,-95},
          {92,-95},{92,-89.56},{88.8,-89.56}},   color={0,0,127}));
  connect(wasteWaterStorage.port_HC1_out, heatPump.enthalpyPort_inEv)
    annotation (Line(points={{57.78,-58.34},{-3.93,-58.34},{-3.93,-57.8},{-38.6,
          -57.8}}, color={176,0,0}));
  connect(wasteWaterStorage.UnloadingCycle_Out[1], vessel1.enthalpyPort_a)
    annotation (Line(points={{79.2,-26},{74,-26},{74,-12},{94.6,-12}}, color={
          176,0,0}));
  connect(wasteWaterStorageControl.WW_control_out_storage, wasteWaterStorage.LoadingCycle_In[
    1]) annotation (Line(points={{73,26.34},{73,-1.83},{70.8,-1.83},{70.8,-26}},
        color={176,0,0}));
  connect(WW_in, wasteWaterStorageControl.WW_control_in) annotation (Line(
        points={{70,102},{70,59.66},{73,59.66}}, color={176,0,0}));
  connect(wasteWaterStorageControl.dot_m_evap_pump, evap_pump.dotm_setValue)
    annotation (Line(points={{54.64,27.36},{10,27.36},{10,-34},{-2,-34}},color={
          0,0,127}));
  connect(T_return_water_cond.enthalpyPort_b, cond_pump.enthalpyPort_a)
    annotation (Line(points={{-77,-26.1},{-79.5,-26.1},{-79.5,-26},{-82.28,-26}},
        color={176,0,0}));
  connect(cond_pump.enthalpyPort_b, fromHeatPump) annotation (Line(points={{
          -95.72,-26},{-100,-26},{-100,70},{-102,70}}, color={176,0,0}));
  connect(wasteWaterStorageControl.dot_m_cond_pump, cond_pump.dotm_setValue)
    annotation (Line(points={{54.64,31.1},{-14,31.1},{-14,-6},{-89,-6},{-89,-19.6}},
        color={0,0,127}));
  connect(heatPump.enthalpyPort_outCo, T_return_water_cond.enthalpyPort_a)
    annotation (Line(points={{-63.2,-57.6},{-63.2,-50},{-50,-50},{-50,-26.1},{-59.2,
          -26.1}}, color={176,0,0}));
  connect(wasteWaterStorage.s_biofilm, wasteWaterStorageControl.s_biofilm)
    annotation (Line(points={{96.84,-30.62},{116,-30.62},{116,49.12},{91.02,49.12}},
        color={0,0,127}));
  connect(wasteWaterStorage.T_layers, wasteWaterStorageControl.T_WasteWaterStorage)
    annotation (Line(points={{56.1,-47},{46,-47},{46,51.84},{55.32,51.84}},
        color={0,0,127}));
  connect(T_HeatingWaterStorage, wasteWaterStorageControl.T_HeatingWaterStorage)
    annotation (Line(points={{-104,-91},{-24,-91},{-24,55.41},{55.32,55.41}},
        color={0,0,127}));
  connect(wasteWaterStorageControl.biofilm_removing, wasteWaterStorage.biofilm_removing)
    annotation (Line(points={{78.1,25.32},{78.1,4.66},{84.03,4.66},{84.03,-24.74}},
                    color={255,0,255}));
  connect(toHeatPump, heatPump.enthalpyPort_inCo) annotation (Line(points={{-100,
          -52},{-94,-52},{-94,-58},{-76,-58},{-76,-74.2},{-63.6,-74.2}},
        color={176,0,0}));
  connect(wasteWaterStorageControl.HP_ison, heatPump.onOff_in) annotation (Line(
        points={{54.3,59.32},{-46,59.32},{-46,-57}}, color={255,0,255}));
  connect(evap_pump.enthalpyPort_b, wasteWaterStorage.port_HC1_in) annotation (
      Line(points={{7.6,-42},{24,-42},{24,-34.4},{58.2,-34.4}}, color={176,0,0}));
  connect(heatPump.enthalpyPort_outEv, evap_pump.enthalpyPort_a) annotation (
      Line(points={{-38.6,-74.2},{-11.6,-74.2},{-11.6,-42}}, color={176,0,0}));
  connect(wasteWaterStorage.LoadingCycle_Out[1], fromWasteWaterStorage)
    annotation (Line(points={{70.8,-68},{66,-68},{66,-100},{60,-100}}, color={176,
          0,0}));
  connect(wasteWaterStorageControl.WW_control_out_bypass, fromWasteWaterStorage)
    annotation (Line(points={{61.78,26.34},{61.78,-16},{52,-16},{52,-100},{60,-100}},
        color={176,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end HeatPumpWasteWater_driven;
