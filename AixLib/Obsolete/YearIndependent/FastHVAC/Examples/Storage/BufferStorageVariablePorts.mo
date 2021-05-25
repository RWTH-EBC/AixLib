within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Storage;
model BufferStorageVariablePorts

  extends Modelica.Icons.Example;

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T=288.15)
    annotation (Placement(transformation(extent={{56,6},{76,26}})));
  Modelica.Blocks.Sources.Constant T_load1(k=273.15 + 85)
    annotation (Placement(transformation(extent={{-100,74},{-80,94}})));
  Modelica.Blocks.Sources.Constant dotmUnload1(k=0.03) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-12})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow heatingRod(Q_flow=2000)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-42,28})));
  Components.Storage.HeatStorageVariablePorts heatStorageVariablePorts(
    load_cycles=[10,4; 6,1],
    n_HC1_up=10,
    n_HC1_low=6,
    n_HC2_up=4,
    n_HR=10,
    unload_cycles=[1,10; 4,10],
    T_start_wall=323.15,
    T_start_ins=323.15,
    n=10)
    annotation (Placement(transformation(extent={{-6,-40},{48,20}})));
  FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-70,50},{-50,70}})));
  Modelica.Blocks.Sources.Constant dotmLoad1(k=0.007)
    annotation (Placement(transformation(extent={{-100,42},{-80,62}})));
  Modelica.Blocks.Sources.Constant T_load2(k=273.15 + 60) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,90})));
  Modelica.Blocks.Sources.Constant dotmLoad2(k=0.01)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-24,90})));
  Modelica.Blocks.Sources.Constant T_unload1(k=273.15 + 40) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-48})));
  Modelica.Blocks.Sources.Constant T_unload2(k=273.15 + 10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={18,-90})));
  Modelica.Blocks.Sources.Constant dotmUnload2(k=0.03) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={52,-90})));
  FastHVAC.Components.Pumps.FluidSource fluidSource1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,-44})));
  FastHVAC.Components.Sinks.Vessel vessel annotation (Placement(
        transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={-19,-82})));
  FastHVAC.Components.Pumps.FluidSource fluidSource2 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={28,-62})));
  FastHVAC.Components.Pumps.FluidSource fluidSource3 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-2,60})));
  FastHVAC.Components.Pumps.FluidSource fluidSource4
    annotation (Placement(transformation(extent={{-68,-8},{-48,12}})));
  FastHVAC.Components.Pumps.FluidSource fluidSource5
    annotation (Placement(transformation(extent={{-68,-80},{-48,-60}})));
  Modelica.Blocks.Sources.Constant T_HC1(k=273.15 + 90)
    annotation (Placement(transformation(extent={{-100,8},{-80,28}})));
  Modelica.Blocks.Sources.Constant dotmHC1(k=0.01)
    annotation (Placement(transformation(extent={{-100,-24},{-80,-4}})));
  Modelica.Blocks.Sources.Constant T_HC2(k=273.15 + 50)
    annotation (Placement(transformation(extent={{-100,-62},{-80,-42}})));
  Modelica.Blocks.Sources.Constant dotmHC2(k=0.01)
    annotation (Placement(transformation(extent={{-100,-96},{-80,-76}})));
  FastHVAC.Components.Sinks.Vessel vessel1 annotation (Placement(
        transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={-29,-82})));
  FastHVAC.Components.Sinks.Vessel vessel2 annotation (Placement(
        transformation(
        extent={{-12,-7},{12,7}},
        rotation=90,
        origin={67,82})));
  FastHVAC.Components.Sinks.Vessel vessel3 annotation (Placement(
        transformation(
        extent={{-12,-7},{12,7}},
        rotation=90,
        origin={57,82})));
  FastHVAC.Components.Sinks.Vessel vessel4 annotation (Placement(
        transformation(
        extent={{-12,-7},{12,7}},
        rotation=180,
        origin={-25,-4})));
  FastHVAC.Components.Sinks.Vessel vessel5 annotation (Placement(
        transformation(
        extent={{-12,-7},{12,7}},
        rotation=180,
        origin={-25,-28})));
equation

  connect(T_load2.y, fluidSource3.T_fluid) annotation (Line(
      points={{10,79},{10,68},{2.2,68}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fluidSource1.T_fluid, T_unload1.y) annotation (Line(
      points={{66,-48.2},{66,-48},{79,-48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotmUnload1.y, fluidSource1.dotm) annotation (Line(
      points={{79,-12},{66,-12},{66,-41.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_unload2.y, fluidSource2.T_fluid) annotation (Line(
      points={{18,-79},{18,-70},{23.8,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotmUnload2.y, fluidSource2.dotm) annotation (Line(
      points={{52,-79},{52,-70},{30.6,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_HC1.y, fluidSource4.T_fluid) annotation (Line(
      points={{-79,18},{-66,18},{-66,6.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotmHC1.y, fluidSource4.dotm) annotation (Line(
      points={{-79,-14},{-66,-14},{-66,-0.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_HC2.y, fluidSource5.T_fluid) annotation (Line(
      points={{-79,-52},{-66,-52},{-66,-65.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotmHC2.y, fluidSource5.dotm) annotation (Line(
      points={{-79,-86},{-66,-86},{-66,-72.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotmLoad1.y, fluidSource.dotm) annotation (Line(
      points={{-79,52},{-68,52},{-68,57.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_load1.y, fluidSource.T_fluid) annotation (Line(
      points={{-79,84},{-68,84},{-68,64.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fluidSource5.enthalpyPort_b, heatStorageVariablePorts.port_HC2_in)
    annotation (Line(points={{-48,-69},{-46,-69},{-46,-18},{-46,-15.7},{-1.41,-15.7}},
        color={176,0,0}));
  connect(heatStorageVariablePorts.out, ambient.port) annotation (Line(points={
          {37.2,14},{56,14},{56,16},{76,16}}, color={191,0,0}));
  connect(dotmLoad2.y, fluidSource3.dotm) annotation (Line(points={{-24,79},{
          -24,79},{-24,72},{-24,72},{-4.6,72},{-4.6,68}}, color={0,0,127}));
  connect(vessel4.enthalpyPort_a, heatStorageVariablePorts.port_HC1_out)
    annotation (Line(points={{-16.6,-4},{-1.14,-4}}, color={176,0,0}));
  connect(vessel5.enthalpyPort_a, heatStorageVariablePorts.port_HC2_out)
    annotation (Line(points={{-16.6,-28},{-1.41,-28},{-1.41,-27.7}}, color={176,
          0,0}));
  connect(heatingRod.port, heatStorageVariablePorts.heatingRod) annotation (
      Line(points={{-52,28},{-24,28},{4.8,28},{4.8,14}}, color={191,0,0}));
  connect(fluidSource4.enthalpyPort_b, heatStorageVariablePorts.port_HC1_in)
    annotation (Line(points={{-48,3},{-48,8},{-0.6,8}}, color={176,0,0}));
  connect(vessel3.enthalpyPort_a, heatStorageVariablePorts.UnloadingCycle_Out[1])
    annotation (Line(points={{57,73.6},{57,56},{26,56},{26,38},{26,22},{26,20},
          {26.4,20}}, color={176,0,0}));
  connect(vessel2.enthalpyPort_a, heatStorageVariablePorts.UnloadingCycle_Out[2])
    annotation (Line(points={{67,73.6},{67,56},{58,56},{26.4,56},{26.4,20}},
        color={176,0,0}));
  connect(vessel.enthalpyPort_a, heatStorageVariablePorts.LoadingCycle_Out[2])
    annotation (Line(points={{-19,-73.6},{-19,-52},{15.6,-52},{15.6,-40}},
        color={176,0,0}));
  connect(vessel1.enthalpyPort_a, heatStorageVariablePorts.LoadingCycle_Out[1])
    annotation (Line(points={{-29,-73.6},{-29,-52},{16,-52},{16,-46},{15.6,-46},
          {15.6,-40}}, color={176,0,0}));
  connect(fluidSource.enthalpyPort_b, heatStorageVariablePorts.LoadingCycle_In[
    1]) annotation (Line(points={{-50,61},{-40,61},{-40,40},{15.6,40},{15.6,20}},
        color={176,0,0}));
  connect(fluidSource3.enthalpyPort_b, heatStorageVariablePorts.LoadingCycle_In[
    2]) annotation (Line(points={{-1,50},{-1,40},{16,40},{16,30},{15.6,30},{
          15.6,20}}, color={176,0,0}));
  connect(heatStorageVariablePorts.UnloadingCycle_In[1], fluidSource1.enthalpyPort_b)
    annotation (Line(points={{26.4,-40},{26,-40},{26,-45},{48,-45}}, color={176,
          0,0}));
  connect(fluidSource2.enthalpyPort_b, heatStorageVariablePorts.UnloadingCycle_In[
    2]) annotation (Line(points={{27,-52},{26.4,-52},{26.4,-40}}, color={176,0,
          0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=72000, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html><ul>
  <li>
    <i>December 20, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end BufferStorageVariablePorts;
