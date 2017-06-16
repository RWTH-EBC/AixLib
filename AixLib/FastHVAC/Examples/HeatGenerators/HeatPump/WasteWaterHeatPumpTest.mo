within AixLib.FastHVAC.Examples.HeatGenerators.HeatPump;
model WasteWaterHeatPumpTest
  extends Modelica.Icons.Example;
  Components.HeatGenerators.HeatPump.HeatPumpWasteWater_driven
    heatPumpWasteWater_driven(n_HeatingWater_layers=10)
    annotation (Placement(transformation(extent={{-56,-64},{-92,-30}})));
  Components.Storage.HeatStorage heatStorage(
    n=10,
    use_heatingCoil2=false,
    use_heatingRod=false)
    annotation (Placement(transformation(extent={{-12,-80},{36,-34}})));
  Components.Pumps.FluidSource WasteWater_in(medium=
        AixLib.FastHVAC.Media.WaterSimple()) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={2,-14})));
  Modelica.Blocks.Sources.Constant dotm_wastewater(k=0)
    annotation (Placement(transformation(extent={{-7,-6},{7,6}},
        rotation=-90,
        origin={-11,8})));
  Modelica.Blocks.Sources.Constant T_wastewater(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-6,-7},{6,7}},
        rotation=-90,
        origin={18,5})));
  Components.Pumps.FluidSource WasteWater_in1(
                                             medium=
        AixLib.FastHVAC.Media.WaterSimple()) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={40,-94})));
  Modelica.Blocks.Sources.Constant dotm_wastewater1(
                                                   k=0.007)
    annotation (Placement(transformation(extent={{7,-6},{-7,6}},
        rotation=0,
        origin={91,-98})));
  Modelica.Blocks.Sources.Constant T_wastewater1(k=273.15 + 10)
    annotation (Placement(transformation(extent={{6,-7},{-6,7}},
        rotation=0,
        origin={90,-73})));
  Components.Sinks.Vessel          vessel annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={-3,-96})));
  Components.Sinks.Vessel          vessel1
                                          annotation (Placement(transformation(
        extent={{12,-7},{-12,7}},
        rotation=270,
        origin={39,-18})));
  Components.Pumps.FluidSource WasteWater_in2(
                                             medium=
        AixLib.FastHVAC.Media.WaterSimple()) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,-4})));
  Modelica.Blocks.Sources.Constant dotm_wastewater2(k=0.1)
    annotation (Placement(transformation(extent={{-7,-6},{7,6}},
        rotation=-90,
        origin={-101,34})));
  Modelica.Blocks.Sources.Constant T_wastewater2(k=273.15 + 15)
    annotation (Placement(transformation(extent={{-6,-7},{6,7}},
        rotation=-90,
        origin={-50,31})));
  Components.Sinks.Vessel          vessel2
                                          annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={-87,-84})));
equation
  connect(heatStorage.T_layers, heatPumpWasteWater_driven.T_HeatingWaterStorage)
    annotation (Line(points={{-9.6,-57},{-31.8,-57},{-31.8,-62.47},{-55.28,
          -62.47}}, color={0,0,127}));
  connect(heatPumpWasteWater_driven.toHeatPump, heatStorage.port_HC1_out)
    annotation (Line(points={{-56,-55.84},{-32,-55.84},{-32,-52.4},{-7.68,-52.4}},
        color={176,0,0}));
  connect(heatPumpWasteWater_driven.fromHeatPump, heatStorage.port_HC1_in)
    annotation (Line(points={{-55.64,-35.1},{-31.82,-35.1},{-31.82,-43.2},{-7.2,
          -43.2}}, color={176,0,0}));
  connect(dotm_wastewater.y, WasteWater_in.dotm) annotation (Line(points={{-11,
          0.3},{-5.5,0.3},{-5.5,-6},{-0.6,-6}}, color={0,0,127}));
  connect(T_wastewater.y, WasteWater_in.T_fluid) annotation (Line(points={{18,
          -1.6},{12,-1.6},{12,-6},{6.2,-6}}, color={0,0,127}));
  connect(dotm_wastewater1.y, WasteWater_in1.dotm) annotation (Line(points={{
          83.3,-98},{76.5,-98},{76.5,-96.6},{48,-96.6}}, color={0,0,127}));
  connect(T_wastewater1.y, WasteWater_in1.T_fluid) annotation (Line(points={{
          83.4,-73},{78,-73},{78,-89.8},{48,-89.8}}, color={0,0,127}));
  connect(WasteWater_in1.enthalpyPort_b, heatStorage.UnloadingCycle_In)
    annotation (Line(points={{30,-93},{24,-93},{24,-80},{16.8,-80}}, color={176,
          0,0}));
  connect(WasteWater_in.enthalpyPort_b, heatStorage.LoadingCycle_In)
    annotation (Line(points={{3,-24},{6,-24},{6,-34},{7.2,-34}}, color={176,0,0}));
  connect(heatStorage.LoadingCycle_Out, vessel.enthalpyPort_a)
    annotation (Line(points={{7.2,-80},{-3,-80},{-3,-87.6}}, color={176,0,0}));
  connect(heatStorage.UnloadingCycle_Out, vessel1.enthalpyPort_a) annotation (
      Line(points={{16.8,-34},{28.4,-34},{28.4,-26.4},{39,-26.4}}, color={176,0,
          0}));
  connect(dotm_wastewater2.y, WasteWater_in2.dotm) annotation (Line(points={{
          -101,26.3},{-97.5,26.3},{-97.5,4},{-92.6,4}}, color={0,0,127}));
  connect(T_wastewater2.y, WasteWater_in2.T_fluid) annotation (Line(points={{
          -50,24.4},{-80,24.4},{-80,4},{-85.8,4}}, color={0,0,127}));
  connect(WasteWater_in2.enthalpyPort_b, heatPumpWasteWater_driven.WW_in)
    annotation (Line(points={{-89,-14},{-88,-14},{-88,-29.66},{-86.6,-29.66}},
        color={176,0,0}));
  connect(heatPumpWasteWater_driven.fromWasteWaterStorage, vessel2.enthalpyPort_a)
    annotation (Line(points={{-84.8,-64},{-87,-64},{-87,-75.6}}, color={176,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WasteWaterHeatPumpTest;
