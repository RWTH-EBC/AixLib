within AixLib.FastHVAC.Examples.HeatGenerators.HeatPump;
model WasteWaterHeatPump
  extends Modelica.Icons.Example;
  Components.HeatGenerators.HeatPump.HeatPump heatPump
    annotation (Placement(transformation(extent={{-36,-44},{-66,-24}})));
  Components.Pumps.FluidSource WasteWater_in(medium=
        AixLib.FastHVAC.Media.WaterSimple()) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={28,64})));
  Modelica.Blocks.Sources.Constant dotm_wastewater(k=0.007)
    annotation (Placement(transformation(extent={{-7,-6},{7,6}},
        rotation=-90,
        origin={1,90})));
  Modelica.Blocks.Sources.Constant T_wastewater(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-6,-7},{6,7}},
        rotation=-90,
        origin={48,91})));
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
    annotation (Placement(transformation(extent={{50,-66},{96,-18}})));
  Components.Sinks.Vessel          vessel annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={49,-90})));
  Components.Sinks.Vessel          vessel1
                                          annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=0,
        origin={103,-12})));
  Components.Pumps.FluidSource fluidSource1(medium=
        AixLib.FastHVAC.Media.WaterSimple())
    annotation (Placement(transformation(extent={{90,-94},{78,-82}})));
  Modelica.Blocks.Sources.Constant T_unload(k=273.15 + 10)
    annotation (Placement(transformation(extent={{106,-84},{92,-74}})));
  Modelica.Blocks.Sources.Constant dotm_unload(k=0)
    annotation (Placement(transformation(extent={{106,-112},{94,-102}})));
  Components.Sensors.TemperatureSensor T_return_water_cond
    annotation (Placement(transformation(extent={{-68,-10},{-88,10}})));
  Modelica.Blocks.Sources.Constant dotm_water_evap(k=0.003)
    annotation (Placement(transformation(extent={{2,-6},{14,6}})));
  Components.Pumps.FluidSource fluidSource3(medium=
        AixLib.FastHVAC.Media.WaterSimple()) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-76,-58})));
  Components.Sinks.Vessel          vessel3
                                          annotation (Placement(transformation(
        extent={{12,-7},{-12,7}},
        rotation=-90,
        origin={-95,42})));
  Modelica.Blocks.Sources.Constant T_flow_water_cond(k=273.15 + 10)
    annotation (Placement(transformation(extent={{-104,-96},{-84,-76}})));
  Modelica.Blocks.Sources.Constant dotm__water_cond(k=0.007)
    annotation (Placement(transformation(extent={{-40,-96},{-60,-76}})));
  Components.Sensors.TemperatureSensor T_return_water_evap
    annotation (Placement(transformation(extent={{-26,-60},{-6,-40}})));
  Components.Pumps.Pump evap_pump
    annotation (Placement(transformation(extent={{16,-30},{36,-10}})));
  Components.Sensors.TemperatureSensor temperature annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-14,32})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={102,38})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{78,56},{88,66}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{78,14},{90,26}})));
  Modelica.Blocks.Logical.Less less annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={58,42})));
  Components.Valves.ThreeWayValve threeWayValve annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={62,8})));
  Components.Sinks.Vessel          vessel2
                                          annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={35,-92})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(period=1000, width=20)
    annotation (Placement(transformation(extent={{-52,-14},{-32,6}})));
  Components.Storage.BaseClasses.WasteWaterStorageControl
    wasteWaterStorageControl
    annotation (Placement(transformation(extent={{-72,56},{-38,90}})));
equation
  connect(fluidSource1.enthalpyPort_b, wasteWaterStorage.UnloadingCycle_In[1])
    annotation (Line(points={{78,-87.4},{77.6,-87.4},{77.6,-66}},
                                                              color={176,0,0}));
  connect(T_unload.y, fluidSource1.T_fluid)
    annotation (Line(points={{91.3,-79},{88.8,-79},{88.8,-85.48}},
                                                            color={0,0,127}));
  connect(dotm_unload.y, fluidSource1.dotm) annotation (Line(points={{93.4,-107},
          {92,-107},{92,-89.56},{88.8,-89.56}},  color={0,0,127}));
  connect(vessel3.enthalpyPort_a, T_return_water_cond.enthalpyPort_b)
    annotation (Line(points={{-95,33.6},{-87,33.6},{-87,-0.1}},
                                                           color={176,0,0}));
  connect(fluidSource3.enthalpyPort_b, heatPump.enthalpyPort_inCo) annotation (
      Line(points={{-77,-48},{-77,-42.2},{-63.6,-42.2}},             color={176,
          0,0}));
  connect(T_flow_water_cond.y, fluidSource3.T_fluid) annotation (Line(points={{-83,-86},
          {-83,-76},{-80.2,-76},{-80.2,-66}},          color={0,0,127}));
  connect(dotm__water_cond.y, fluidSource3.dotm) annotation (Line(points={{-61,-86},
          {-61,-80},{-73.4,-80},{-73.4,-66}},      color={0,0,127}));
  connect(T_return_water_evap.enthalpyPort_b, evap_pump.enthalpyPort_a)
    annotation (Line(points={{-7,-50.1},{12,-50.1},{12,-20},{16.4,-20}}, color=
          {176,0,0}));
  connect(wasteWaterStorage.port_HC1_out, heatPump.enthalpyPort_inEv)
    annotation (Line(points={{54.14,-54.96},{2.07,-54.96},{2.07,-25.8},{-38.6,
          -25.8}}, color={176,0,0}));
  connect(wasteWaterStorage.LoadingCycle_Out[1], vessel.enthalpyPort_a)
    annotation (Line(points={{68.4,-66},{68.4,-73},{49,-73},{49,-81.6}}, color=
          {176,0,0}));
  connect(wasteWaterStorage.UnloadingCycle_Out[1], vessel1.enthalpyPort_a)
    annotation (Line(points={{77.6,-18},{74,-18},{74,-12},{94.6,-12}}, color={
          176,0,0}));
  connect(dotm_water_evap.y, evap_pump.dotm_setValue)
    annotation (Line(points={{14.6,0},{26,0},{26,-12}}, color={0,0,127}));
  connect(evap_pump.enthalpyPort_b, wasteWaterStorage.port_HC1_in) annotation (
      Line(points={{35.6,-20},{40,-20},{40,-26},{54.6,-26},{54.6,-27.6}}, color=
         {176,0,0}));
  connect(heatPump.enthalpyPort_outEv, T_return_water_evap.enthalpyPort_a)
    annotation (Line(points={{-38.6,-42.2},{-32.3,-42.2},{-32.3,-50.1},{-24.8,
          -50.1}}, color={176,0,0}));
  connect(temperature.T, less.u1)
    annotation (Line(points={{-3,31},{50.8,31},{50.8,42}}, color={0,0,127}));
  connect(less.y, switch1.u2) annotation (Line(points={{64.6,42},{86,42},{86,38},
          {92.4,38}}, color={255,0,255}));
  connect(const.y, switch1.u1) annotation (Line(points={{88.5,61},{88.5,44.4},{
          92.4,44.4}}, color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{90.6,20},{92,20},{92,
          31.6},{92.4,31.6}}, color={0,0,127}));
  connect(less.u2, wasteWaterStorage.T_layers[10]) annotation (Line(points={{50.8,
          37.2},{50.23,37.2},{50.23,-42}},      color={0,0,127}));
  connect(T_return_water_cond.enthalpyPort_a, heatPump.enthalpyPort_outCo)
    annotation (Line(points={{-69.2,-0.1},{-63.2,-0.1},{-63.2,-25.6}},
                                                                     color={176,
          0,0}));
  connect(T_wastewater.y, WasteWater_in.T_fluid) annotation (Line(points={{48,
          84.4},{48,84.4},{48,78},{32.2,78},{32.2,72}}, color={0,0,127}));
  connect(dotm_wastewater.y, WasteWater_in.dotm) annotation (Line(points={{1,
          82.3},{1,78},{25.4,78},{25.4,72}}, color={0,0,127}));
  connect(WasteWater_in.enthalpyPort_b, temperature.enthalpyPort_a) annotation (
     Line(points={{29,54},{8,54},{8,38},{-14.1,38},{-14.1,40.8}}, color={176,0,
          0}));
  connect(temperature.enthalpyPort_b, threeWayValve.enthalpyPort_ab)
    annotation (Line(points={{-14.1,23},{-14.1,18},{8,18},{8,26},{62,26},{62,
          17.8}}, color={176,0,0}));
  connect(threeWayValve.enthalpyPort_a, wasteWaterStorage.LoadingCycle_In[1])
    annotation (Line(points={{62,-2},{62,-18},{68.4,-18}}, color={176,0,0}));
  connect(switch1.y, threeWayValve.opening) annotation (Line(points={{110.8,38},
          {116,38},{116,16},{116,8},{71,8}}, color={0,0,127}));
  connect(threeWayValve.enthalpyPort_b, vessel2.enthalpyPort_a) annotation (
      Line(points={{52,8},{40,8},{40,-83.6},{35,-83.6}}, color={176,0,0}));
  connect(booleanPulse.y, heatPump.onOff_in) annotation (Line(points={{-31,-4},
          {-32,-4},{-32,-12},{-32,-25},{-46,-25}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end WasteWaterHeatPump;
