within AixLib.FastHVAC.Components.HeatGenerators.HeatPump;
model HeatPumpWasteWater_driven

  extends Modelica.Icons.Example;

  // Medium definition

  parameter FastHVAC.Media.BaseClasses.Medium Medium_WasteWater = FastHVAC.Media.WasteWater();
  parameter Integer n_HeatingWater_layers=10;
  parameter Modelica.SIunits.Density rho_WasteWater = 995;
  parameter Modelica.SIunits.Temperature T_ambient=273.15+15;
    parameter Modelica.SIunits.Length s_biofilm_max = 0.005
    "max thickness of biofilm, when cleaning should be started";
  parameter Modelica.SIunits.Length s_biofilm_min= 0.0005
    "min thickness of biofilm, that could be reached by cleaning";
    Modelica.SIunits.HeatFlowRate total_heat;

  Components.HeatGenerators.HeatPump.HeatPump heatPump(cap_calcType=2,
    Pel_ouput=true,
    CoP_output=true,
    data_table=DataBase.HeatPump.EN255.Vitocal350BWH110())
    annotation (Placement(transformation(extent={{-36,-76},{-66,-56}})));
  Components.Storage.WasteWaterStorage wasteWaterStorage(
    n_load_cycles=1,
    n_unload_cycles=1,
    data=AixLib.DataBase.Storage.Wastewater_500l(),
    unload_cycles=[1,10],
    n_HC1_low=1,
    n=10,
    Up_to_down_HC1=true,
    n_HC1_up=10,
    load_cycles=[10,1],
    alpha_HC1=200,
    T_start=303.15,
    T_start_HC=273.15,
    T_start_wall=293.15,
    T_start_ins=293.15)
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
    rho_WasteWater=rho_WasteWater,
    n_HeatingWater_layers=n_HeatingWater_layers,
    s_biofilm_max=s_biofilm_max,
    s_biofilm_min=s_biofilm_min,
    dot_m_cond_pump_fix=0.3,
    dot_m_evap_pump_fix=0.3,
    d_storage=wasteWaterStorage.data.dTank,
    h_storage=wasteWaterStorage.data.hTank,
    t_cleaning=600,
    T_WasteWater_upper_min=273.15 + 10)
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
    annotation (Placement(transformation(extent={{-84,-32},{-98,-16}})));
  Interfaces.EnthalpyPort_b fromWasteWaterStorage
    annotation (Placement(transformation(extent={{42,-106},{50,-98}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T=T_ambient)
    annotation (Placement(transformation(extent={{112,0},{92,20}})));
  Interfaces.EnthalpyPort_b fromWasteWaterStorage1
    annotation (Placement(transformation(extent={{66,-104},{74,-96}})));
  Utilities.Sensors.FuelCounter fuelCounter
    annotation (Placement(transformation(extent={{-12,-98},{8,-78}})));
equation
   total_heat = sum(wasteWaterStorage.heatingCoil1.Therm1[k].Q_flow for k in 1:10);
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
    annotation (Line(points={{-77,-26.1},{-79.5,-26.1},{-79.5,-24},{-84.28,-24}},
        color={176,0,0}));
  connect(cond_pump.enthalpyPort_b, fromHeatPump) annotation (Line(points={{-97.72,
          -24},{-100,-24},{-100,70},{-102,70}},        color={176,0,0}));
  connect(wasteWaterStorageControl.dot_m_cond_pump, cond_pump.dotm_setValue)
    annotation (Line(points={{54.64,31.1},{-14,31.1},{-14,-6},{-91,-6},{-91,-17.6}},
        color={0,0,127}));
  connect(heatPump.enthalpyPort_outCo, T_return_water_cond.enthalpyPort_a)
    annotation (Line(points={{-63.2,-57.6},{-63.2,-50},{-50,-50},{-50,-26.1},{-59.2,
          -26.1}}, color={176,0,0}));
  connect(wasteWaterStorage.T_layers, wasteWaterStorageControl.T_WasteWaterStorage)
    annotation (Line(points={{56.1,-47},{46,-47},{46,51.84},{55.32,51.84}},
        color={0,0,127}));
  connect(T_HeatingWaterStorage, wasteWaterStorageControl.T_HeatingWaterStorage)
    annotation (Line(points={{-104,-91},{-24,-91},{-24,55.41},{55.32,55.41}},
        color={0,0,127}));
  connect(toHeatPump, heatPump.enthalpyPort_inCo) annotation (Line(points={{-100,
          -52},{-94,-52},{-94,-58},{-76,-58},{-76,-74.2},{-63.6,-74.2}},
        color={176,0,0}));
  connect(wasteWaterStorageControl.HP_ison, heatPump.onOff_in) annotation (Line(
        points={{54.3,59.32},{-46,59.32},{-46,-57}}, color={255,0,255}));
  connect(evap_pump.enthalpyPort_b, wasteWaterStorage.port_HC1_in) annotation (
      Line(points={{7.6,-42},{24,-42},{24,-34.4},{58.2,-34.4}}, color={176,0,0}));
  connect(heatPump.enthalpyPort_outEv, evap_pump.enthalpyPort_a) annotation (
      Line(points={{-38.6,-74.2},{-11.6,-74.2},{-11.6,-42}}, color={176,0,0}));
  connect(ambient.port, wasteWaterStorage.out) annotation (Line(points={{92,10},
          {87.6,10},{87.6,-30.2}}, color={191,0,0}));
  connect(wasteWaterStorageControl.WW_control_out_bypass, fromWasteWaterStorage)
    annotation (Line(points={{61.78,26.34},{61.78,-18},{52,-18},{52,-102},{46,-102}},
        color={176,0,0}));
  connect(wasteWaterStorage.LoadingCycle_Out[1], fromWasteWaterStorage1)
    annotation (Line(points={{70.8,-68},{70,-68},{70,-100}}, color={176,0,0}));
  connect(wasteWaterStorageControl.iscleaning, wasteWaterStorage.biofilm_removing)
    annotation (Line(points={{81.16,26.34},{81.16,2.17},{84.03,2.17},{84.03,
          -24.74}}, color={255,0,255}));
  connect(wasteWaterStorage.s_biofilm, wasteWaterStorageControl.s_biofilm)
    annotation (Line(points={{96.84,-30.62},{120,-30.62},{120,46},{91.02,46},{
          91.02,49.12}}, color={0,0,127}));
  connect(heatPump.Pel_out, fuelCounter.fuel_in) annotation (Line(points={{-46,
          -74.4},{-46,-88},{-12,-88}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end HeatPumpWasteWater_driven;
