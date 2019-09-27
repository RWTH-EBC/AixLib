within AixLib.FastHVAC.Examples.HeatExchangers.BoreHoleHeatExchanger;
model VDI_Verification_EnergyPileGroupExample
  extends Modelica.Icons.Example;
  AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger.EnergyPileGroup
    energyPileGroup(
    withTemperatureInputs=true,
    TGroundTop=284.15,
    TGroundUndisturbed=286.15,
    TGroundBottom=287.15,
    noOfBoreholes=3,
    n=10,
    boreholeDiameter=0.15,
    pipeType=AixLib.DataBase.Pipes.Copper.Copper_54x1(
        d_i=0.032,
        d_o=0.035,
        d=983,
        lambda=0.8,
        c=1500),
    nParallel=2,
    T0=[305.15,305.15,305.15,305.15,305.15,305.15,305.15,305.15,305.15,305.15;
        289.15,289.15,289.15,289.15,289.15,289.15,289.15,289.15,289.15,289.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15;
        285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15,285.15],
    pipeCentreReferenceCircle=energyPileGroup.boreholeDiameter/2,
    nRad=10,
    medium=AixLib.FastHVAC.Media.DC20(),
    groundVolumeDiamter=100) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-6,16})));

  AixLib.FastHVAC.Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{-7.5,-5.5},{7.5,5.5}},
        rotation=0,
        origin={57.5,42.5})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor temperature
    annotation (Placement(transformation(extent={{-4,4},{4,-4}},
        rotation=0,
        origin={20,38})));
public
  AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-36,54},{-18,72}})));
public
Modelica.Blocks.Sources.Constant Massflow_2Pipes(k=2.349)
    annotation (Placement(transformation(extent={{-100,52},{-92,60}})));
Modelica.Blocks.Sources.Pulse    FlowTemperature(
    amplitude=-11,
    width=20.55,
    period(displayUnit="d") = 31536000,
    offset=11)
    annotation (Placement(transformation(extent={{-100,68},{-92,76}})));
Modelica.Blocks.Sources.Constant TUndisturbedGround_input1(k=11)
    annotation (Placement(transformation(extent={{-92,0},{-84,8}})));
Modelica.Blocks.Sources.Constant TUndisturbedSurface_input(k=11)
    annotation (Placement(transformation(extent={{-92,18},{-84,26}})));
protected
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{-58,66},{-48,76}})));
protected
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
    annotation (Placement(transformation(extent={{-60,14},{-50,24}})));
protected
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2
    annotation (Placement(transformation(extent={{-60,-2},{-50,8}})));
equation
  connect(vessel.enthalpyPort_a,temperature. enthalpyPort_b) annotation (Line(
        points={{52.25,42.5},{43.375,42.5},{43.375,38.04},{23.6,38.04}},
        color={176,0,0}));
  connect(temperature.enthalpyPort_a, energyPileGroup.enthalpyPort_b1)
    annotation (Line(points={{16.48,38.04},{6,38.04},{6,26},{2.2,26}}, color={
          176,0,0}));
  connect(FlowTemperature.y,toKelvin. Celsius) annotation (Line(
      points={{-91.6,72},{-86,72},{-86,71},{-59,71}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(toKelvin.Kelvin,fluidSource. T_fluid) annotation (Line(points={{-47.5,
          71},{-40.75,71},{-40.75,66.78},{-34.2,66.78}},
                                                      color={0,0,127}));
  connect(Massflow_2Pipes.y,fluidSource. dotm) annotation (Line(points={{-91.6,
          56},{-62,56},{-62,60.66},{-34.2,60.66}},
                                              color={0,0,127}));
  connect(fluidSource.enthalpyPort_b, energyPileGroup.enthalpyPort_a1)
    annotation (Line(points={{-18,63.9},{-16,63.9},{-16,26},{-13.8,26}}, color=
          {176,0,0}));
  connect(toKelvin1.Kelvin, energyPileGroup.groundTopTemp_input) annotation (
      Line(points={{-49.5,19},{-33.75,19},{-33.75,18.2},{-18,18.2}}, color={0,0,
          127}));
  connect(TUndisturbedGround_input1.y, toKelvin2.Celsius) annotation (Line(
        points={{-83.6,4},{-72,4},{-72,3},{-61,3}}, color={0,0,127}));
  connect(toKelvin2.Kelvin, energyPileGroup.groundUndisturbedTemp_input)
    annotation (Line(points={{-49.5,3},{-34,3},{-34,8.2},{-18,8.2}}, color={0,0,
          127}));
  connect(toKelvin2.Kelvin, energyPileGroup.groundBottomTemp_input) annotation (
     Line(points={{-49.5,3},{-49.5,-6},{-7.2,-6},{-7.2,4}}, color={0,0,127}));
  connect(TUndisturbedSurface_input.y, toKelvin1.Celsius) annotation (Line(
        points={{-83.6,22},{-72,22},{-72,19},{-61,19}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, Interval=86400), Documentation(info
        ="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>Simple test set-up for the EnergyPileGroup model: <a href=\"modelica://AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger.EnergyPileGroup\">AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger.EnergyPileGroup</a></p>
<p>This model of a group of geothermal probes was validated using VDI 4640. The selected setup includes the geothermal probes and the forward and backward flow of the system. In addition, the following model parameters are taken from VDI 4640 for a comparison of the determined specific heat flow over the probe length:</p>
<p>- 1 single double U-tube probe</p>
<p>- Temperature over entire probe length: 11&deg;C</p>
<p>- Probe input temperature: 1&deg;C (&gt; 0&deg;C -&gt; VDI Appendix B4)</p>
<p>- Plausible flow conditions (Re=2400)</p>
<p>- Probe parameter (d_i=0.032m; d_a=0.035m, lambda=0.8W/(m.K))</p>
<p>- 100m probe depth with drill hole diameter D=0,15m</p>
<p>- Heat conduction of soil with lambda=2W/(m.K)</p>
</html>"));
end VDI_Verification_EnergyPileGroupExample;
