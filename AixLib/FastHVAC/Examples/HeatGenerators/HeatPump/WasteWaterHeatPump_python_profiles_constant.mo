within AixLib.FastHVAC.Examples.HeatGenerators.HeatPump;
model WasteWaterHeatPump_python_profiles_constant
  extends Modelica.Icons.Example;
  Components.HeatGenerators.HeatPump.HeatPumpWasteWater_driven
    heatPumpWasteWater_driven(n_HeatingWater_layers=10)
    annotation (Placement(transformation(extent={{-56,-64},{-92,-30}})));
  Components.Pumps.FluidSource WasteWater_in(medium=
        AixLib.FastHVAC.Media.WaterSimple()) annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={-1,-11})));
  Modelica.Blocks.Sources.Constant dotm_heatingwater_load(k=0) annotation (
      Placement(transformation(
        extent={{-3.5,-2.5},{3.5,2.5}},
        rotation=-90,
        origin={-14.5,1.5})));
  Modelica.Blocks.Sources.Constant T_heatingwater_load(k=273.15 + 20)
    annotation (Placement(transformation(
        extent={{-3.5,-4.5},{3.5,4.5}},
        rotation=-90,
        origin={11.5,1.5})));
  Components.Pumps.FluidSource WasteWater_in1(
                                             medium=
        AixLib.FastHVAC.Media.WaterSimple()) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-94})));
  Modelica.Blocks.Sources.Constant T_heatingwater_unload(k=273.15 + 10)
    annotation (Placement(transformation(
        extent={{6,-7},{-6,7}},
        rotation=0,
        origin={78,-67})));
  Components.Sinks.Vessel          vessel annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={-3,-96})));
  Components.Sinks.Vessel          vessel1
                                          annotation (Placement(transformation(
        extent={{12,-7},{-12,7}},
        rotation=270,
        origin={43,-4})));
  Components.Sinks.Vessel          vessel2
                                          annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={-93,-88})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T=288.15)
    annotation (Placement(transformation(extent={{70,-54},{50,-34}})));
  Components.Pumps.FluidSource fluidSource annotation (Placement(transformation(
        extent={{-10,-11},{10,11}},
        rotation=-90,
        origin={-92,-3})));
  Components.Sinks.Vessel          vessel3
                                          annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={-73,-88})));
  Components.Storage.HeatStorage_variablePorts heatStorage_variablePorts(
    unload_cycles=[1,10],
    n_load_cycles=1,
    n_unload_cycles=1,
    use_heatingCoil2=false,
    use_heatingRod=false,
    Up_to_down_HC1=true,
    n_HC1_low=1,
    n_HC1_up=10,
    n=10,
    load_cycles=[10,1],
    redeclare model HeatTransfer =
        Components.Storage.BaseClasses.HeatTransfer_OnlyConduction,
    alpha_HC1=200,
    T_start=323.15,
    T_start_wall=293.15,
    T_start_ins=293.15,
    data=DataBase.Storage.Generic_750l())
    annotation (Placement(transformation(extent={{-8,-80},{36,-36}})));

  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=0.0113,
    width=30,
    period=120)
    annotation (Placement(transformation(extent={{146,-130},{126,-110}})));
  Modelica.Blocks.Sources.Constant dotm_heatingwater_load1(k=0.1)
                                                               annotation (
      Placement(transformation(
        extent={{-3.5,-2.5},{3.5,2.5}},
        rotation=-90,
        origin={-94.5,21.5})));
  Modelica.Blocks.Sources.Constant dotm_heatingwater_load2(k=0.1)
                                                               annotation (
      Placement(transformation(
        extent={{3.5,-2.5},{-3.5,2.5}},
        rotation=0,
        origin={67.5,-100.5})));
  Modelica.Blocks.Sources.Constant T_heatingwater_unload1(k=273.15 + 35)
    annotation (Placement(transformation(
        extent={{6,-7},{-6,7}},
        rotation=0,
        origin={-66,11})));
equation
  connect(dotm_heatingwater_load.y, WasteWater_in.dotm) annotation (Line(points=
         {{-14.5,-2.35},{-5.5,-2.35},{-5.5,-5.4},{-2.82,-5.4}}, color={0,0,127}));
  connect(T_heatingwater_load.y, WasteWater_in.T_fluid) annotation (Line(points=
         {{11.5,-2.35},{11.5,-2.35},{11.5,-5.4},{1.94,-5.4}}, color={0,0,127}));
  connect(T_heatingwater_unload.y, WasteWater_in1.T_fluid) annotation (Line(
        points={{71.4,-67},{78,-67},{78,-89.8},{48,-89.8}}, color={0,0,127}));
  connect(fluidSource.enthalpyPort_b, heatPumpWasteWater_driven.WW_in)
    annotation (Line(points={{-90.9,-13},{-90.9,-22.5},{-86.6,-22.5},{-86.6,
          -29.66}}, color={176,0,0}));
  connect(heatPumpWasteWater_driven.fromWasteWaterStorage, vessel3.enthalpyPort_a)
    annotation (Line(points={{-82.28,-64.34},{-82.28,-71.17},{-73,-71.17},{-73,
          -79.6}}, color={176,0,0}));
  connect(heatPumpWasteWater_driven.fromWasteWaterStorage1, vessel2.enthalpyPort_a)
    annotation (Line(points={{-86.6,-64},{-93,-64},{-93,-79.6}}, color={176,0,0}));
  connect(heatStorage_variablePorts.LoadingCycle_Out[1], vessel.enthalpyPort_a)
    annotation (Line(points={{9.6,-80},{3.8,-80},{3.8,-87.6},{-3,-87.6}}, color=
         {176,0,0}));
  connect(heatStorage_variablePorts.UnloadingCycle_In[1], WasteWater_in1.enthalpyPort_b)
    annotation (Line(points={{18.4,-80},{24,-80},{24,-93},{30,-93}}, color={176,
          0,0}));
  connect(WasteWater_in.enthalpyPort_b, heatStorage_variablePorts.LoadingCycle_In[
    1]) annotation (Line(points={{-0.3,-18},{6,-24},{6,-36},{9.6,-36}}, color={
          176,0,0}));
  connect(heatStorage_variablePorts.UnloadingCycle_Out[1], vessel1.enthalpyPort_a)
    annotation (Line(points={{18.4,-36},{29.2,-36},{29.2,-12.4},{43,-12.4}},
        color={176,0,0}));
  connect(heatStorage_variablePorts.out, ambient.port) annotation (Line(points=
          {{27.2,-40.4},{38.6,-40.4},{38.6,-44},{50,-44}}, color={191,0,0}));
  connect(heatStorage_variablePorts.T_layers, heatPumpWasteWater_driven.T_HeatingWaterStorage)
    annotation (Line(points={{-5.8,-58},{-30,-58},{-30,-62.47},{-55.28,-62.47}},
        color={0,0,127}));
  connect(heatStorage_variablePorts.port_HC1_in, heatPumpWasteWater_driven.fromHeatPump)
    annotation (Line(points={{-3.6,-44.8},{-29.8,-44.8},{-29.8,-35.1},{-55.64,
          -35.1}}, color={176,0,0}));
  connect(heatStorage_variablePorts.port_HC1_out, heatPumpWasteWater_driven.toHeatPump)
    annotation (Line(points={{-4.04,-53.6},{-18,-53.6},{-18,-54},{-30,-54},{-30,
          -55.84},{-56,-55.84}},
                    color={176,0,0}));
  connect(dotm_heatingwater_load1.y, fluidSource.dotm) annotation (Line(points=
          {{-94.5,17.65},{-94.5,11.825},{-94.86,11.825},{-94.86,5}}, color={0,0,
          127}));
  connect(dotm_heatingwater_load2.y, WasteWater_in1.dotm) annotation (Line(
        points={{63.65,-100.5},{56.825,-100.5},{56.825,-96.6},{48,-96.6}},
        color={0,0,127}));
  connect(T_heatingwater_unload1.y, fluidSource.T_fluid) annotation (Line(
        points={{-72.6,11},{-79.3,11},{-79.3,5},{-87.38,5}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=5.256e+006),
    __Dymola_experimentSetupOutput(outputs=false, events=false));
end WasteWaterHeatPump_python_profiles_constant;
