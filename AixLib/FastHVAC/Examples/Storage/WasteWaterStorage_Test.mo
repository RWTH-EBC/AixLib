within AixLib.FastHVAC.Examples.Storage;
model WasteWaterStorage_Test

  extends Modelica.Icons.Example;

  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T=288.15)
    annotation (Placement(transformation(extent={{56,6},{76,26}})));
  Components.Storage.WasteWaterStorage WasteWaterStorage(
    n=10,
    n_HC1_up=10,
    alpha_HC1=450,
    Up_to_down_HC1=true,
    load_cycles=[10,2],
    unload_cycles=[1,10],
    n_load_cycles=1,
    n_unload_cycles=1,
    n_HC1_low=1,
    data=AixLib.DataBase.Storage.Wastewater_500l(),
    T_start=293.15,
    T_start_HC=293.15,
    T_start_wall=293.15,
    T_start_ins=293.15)
    annotation (Placement(transformation(extent={{-8,-40},{46,20}})));
  Components.Pipes.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-42,54},{-22,74}})));
  Modelica.Blocks.Sources.Constant tLoad1(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-102,76},{-82,96}})));
  Modelica.Blocks.Sources.Constant T_unload2(k=273.15 + 10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={18,-90})));
  Modelica.Blocks.Sources.Constant dotmUnload2(k=0)    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={52,-90})));
  FastHVAC.Components.Sinks.Vessel vessel annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=270,
        origin={-19,-82})));
  Components.Pipes.Pumps.FluidSource fluidSource2 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={28,-62})));
  Components.Pipes.Pumps.FluidSource fluidSource4
    annotation (Placement(transformation(extent={{-70,8},{-50,28}})));
  Modelica.Blocks.Sources.Constant T_HC1(k=273.15 + 10)
    annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
  Modelica.Blocks.Sources.Constant dotmHC1(k=0.01)
    annotation (Placement(transformation(extent={{-98,-22},{-78,-2}})));
  FastHVAC.Components.Sinks.Vessel vessel2 annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=90,
        origin={67,82})));
  FastHVAC.Components.Sinks.Vessel vessel4 annotation (Placement(transformation(
        extent={{-12,-7},{12,7}},
        rotation=180,
        origin={-83,-46})));
  Components.Sensors.TemperatureSensor Temperature_Heatpump_flow
    annotation (Placement(transformation(extent={{-18,-24},{-38,-4}})));
  Modelica.Blocks.Sources.Pulse pulse(
    offset=0,
    period=300,
    startTime=0,
    amplitude=0.007,
    width=70)
    annotation (Placement(transformation(extent={{-102,46},{-82,66}})));
equation

  connect(T_unload2.y, fluidSource2.T_fluid) annotation (Line(
      points={{18,-79},{18,-70},{23.8,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotmUnload2.y, fluidSource2.dotm) annotation (Line(
      points={{52,-79},{52,-70},{30.6,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_HC1.y, fluidSource4.T_fluid) annotation (Line(
      points={{-79,24},{-68,24},{-68,22.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dotmHC1.y, fluidSource4.dotm) annotation (Line(
      points={{-77,-12},{-68,-12},{-68,15.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(WasteWaterStorage.out, ambient.port) annotation (Line(points={{35.2,
          14},{56,14},{56,16},{76,16}}, color={191,0,0}));
  connect(fluidSource4.enthalpyPort_b, WasteWaterStorage.port_HC1_in)
    annotation (Line(points={{-50,19},{-26,19},{-26,8},{-2.6,8}}, color={176,0,
          0}));
  connect(Temperature_Heatpump_flow.enthalpyPort_a, WasteWaterStorage.port_HC1_out)
    annotation (Line(points={{-19.2,-14.1},{-19.2,-26.2},{-3.14,-26.2}},
                                                                   color={176,0,
          0}));
  connect(vessel4.enthalpyPort_a, Temperature_Heatpump_flow.enthalpyPort_b)
    annotation (Line(points={{-74.6,-46},{-56,-46},{-56,-14.1},{-37,-14.1}},
        color={176,0,0}));
  connect(WasteWaterStorage.LoadingCycle_Out[1], vessel.enthalpyPort_a)
    annotation (Line(points={{13.6,-40},{-2,-40},{-2,-73.6},{-19,-73.6}}, color=
         {176,0,0}));
  connect(WasteWaterStorage.UnloadingCycle_In[1], fluidSource2.enthalpyPort_b)
    annotation (Line(points={{24.4,-40},{24.4,-47},{27,-47},{27,-52}}, color={176,
          0,0}));
  connect(fluidSource.enthalpyPort_b, WasteWaterStorage.LoadingCycle_In[1])
    annotation (Line(points={{-22,65},{-20,65},{-20,20},{13.6,20}}, color={176,0,
          0}));
  connect(vessel2.enthalpyPort_a, WasteWaterStorage.UnloadingCycle_Out[1])
    annotation (Line(points={{67,73.6},{24.4,73.6},{24.4,20}}, color={176,0,0}));
  connect(tLoad1.y, fluidSource.T_fluid) annotation (Line(points={{-81,86},{-62,
          86},{-62,68.2},{-40,68.2}}, color={0,0,127}));
  connect(pulse.y, fluidSource.dotm) annotation (Line(points={{-81,56},{-60,56},
          {-60,61.4},{-40,61.4}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=72000, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(revisions="<html>
    <p><ul>
    
    asdfasdf
    <li><i>12.05.2017 &nbsp; </i> David Jansen:<br/>Wastewater storage</li>
</ul></p>
</html>"));
end WasteWaterStorage_Test;
