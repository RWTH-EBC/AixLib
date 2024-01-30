within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.HeatGenerators.HeatPump;
model HeatPump
  extends Modelica.Icons.Example;
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{48,-70},{66,-52}})));
  FastHVAC.Components.Pumps.FluidSource fluidSource(medium=
        FastHVAC.Media.WaterSimple()) "Fluidsource for source"
    annotation (Placement(transformation(extent={{-50,-44},{-30,-24}})));
  Components.HeatGenerators.HeatPump.HeatPump heatPump(
    refIneFre_constant=1,
    Medium_con=Media.WaterSimple(),
    Medium_eva=Media.WaterSimple(),
    mFlow_conNominal=0.5,
    VCon=0.4,
    deltaM_con=0.1,
    use_ConCap=false,
    CCon=100,
    GCon=5,
    mFlow_evaNominal=0.5,
    VEva=0.04,
    deltaM_eva=0.1,
    use_EvaCap=false,
    CEva=100,
    GEva=5,
    allowFlowReversalEva=true,
    use_revHP=true,
    TCon_start(displayUnit="K"),
    TEva_start(displayUnit="K"),
    redeclare model PerDataHea =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (
         dataTable=AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    redeclare model PerDataChi =
        AixLib.DataBase.Chiller.PerformanceData.LookUpTable2D (
         dataTable=AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
    Q_useNominal=0,
    use_autoCalc=false,
    TAmbCon_nominal=288.15) annotation (Placement(transformation(
        extent={{-13,-16},{13,16}},
        rotation=-90,
        origin={3,-2})));
  FastHVAC.Components.Sinks.Vessel vessel_ev
    "vessel for open evaporator circuit" annotation (Placement(
        transformation(
        extent={{-11,-9},{11,9}},
        rotation=180,
        origin={-35,57})));
  Modelica.Blocks.Sources.Constant dotm_source(k=1) "Source mass flow signal"
    annotation (Placement(transformation(extent={{-98,-82},{-78,-62}})));
  Modelica.Blocks.Sources.Constant dotm_sink(k=0.106) "sink mass flow signal"
                                                      annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={36,38})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)"                   annotation (Placement(
        transformation(
        extent={{5,5},{-5,-5}},
        rotation=180,
        origin={-39,9})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    "Constant internal ambient temeprature"
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=-90,
        origin={3,-35})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal "on off control "
    annotation (Placement(transformation(extent={{4,4},{-4,-4}},
        rotation=90,
        origin={6,40})));
  Modelica.Blocks.Sources.Ramp TsuSourceRamp(
    duration=1000,
    startTime=1000,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the source side's ideal mass flow source"
    annotation (Placement(transformation(extent={{-96,-34},{-76,-14}})));
  BaseClasses.WorkingFluid Room(m_fluid=5*1000, T0=293.15) "Volume"
                                                           annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-26})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRateCon
    "Heat flow rate of the condenser" annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=270,
        origin={52,-18})));
  Modelica.Blocks.Math.Gain gain(k=-1) "negate sine signal"
                                       annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={54,-2})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/3600,
    amplitude=3000,
    offset=3000) "hourly sine "
    annotation (Placement(transformation(extent={{66,8},{58,16}})));
  Components.Pumps.Pump pump "sink pump"
                             annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={36,20})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=10000,
      startValue=true)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={0,78})));
  Modelica.Blocks.Logical.Hysteresis hysHeating(
    pre_y_start=true,
    uLow=273.15 + 30,
    uHigh=273.15 + 35)
    annotation (Placement(transformation(extent={{66,58},{56,68}})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        origin={45,63},
        rotation=180)));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{26,50},{16,60}})));
  Modelica.Blocks.Logical.Hysteresis hysCooling(
    pre_y_start=false,
    uLow=273.15 + 15,
    uHigh=273.15 + 19)
    annotation (Placement(transformation(extent={{58,42},{48,52}})));
equation
  connect(dotm_source.y, fluidSource.dotm) annotation (Line(points={{-77,-72},{-64,
          -72},{-64,-36.6},{-48,-36.6}}, color={0,0,127}));
  connect(iceFac.y, heatPump.iceFac_in) annotation (Line(points={{-33.5,9},{
          -15.1333,9},{-15.1333,7.88}},
                               color={0,0,127}));
  connect(TsuSourceRamp.y, fluidSource.T_fluid) annotation (Line(points={{-75,-24},
          {-54,-24},{-54,-29.8},{-48,-29.8}}, color={0,0,127}));
  connect(dotm_sink.y, pump.dotm_setValue)
    annotation (Line(points={{36,33.6},{36,28}},         color={0,0,127}));
  connect(sine.y, gain.u)
    annotation (Line(points={{57.6,12},{54,12},{54,2.8}}, color={0,0,127}));
  connect(gain.y, heatFlowRateCon.Q_flow)
    annotation (Line(points={{54,-6.4},{54,-12},{52,-12}}, color={0,0,127}));
  connect(temperatureSensor.enthalpyPort_b, Room.enthalpyPort_a) annotation (
      Line(points={{65.1,-61.09},{90,-61.09},{90,-35}}, color={176,0,0}));
  connect(Room.enthalpyPort_b, pump.enthalpyPort_a)
    annotation (Line(points={{90,-17},{90,20},{45.6,20}}, color={176,0,0}));
  connect(heatFlowRateCon.port, Room.heatPort)
    annotation (Line(points={{52,-24},{52,-26},{80.6,-26}}, color={191,0,0}));
  connect(hysHeating.y, not2.u)
    annotation (Line(points={{55.5,63},{51,63}}, color={255,0,255}));
  connect(logicalSwitch.u1, not2.y) annotation (Line(points={{27,59},{36,59},{
          36,63},{39.5,63}}, color={255,0,255}));
  connect(hysCooling.y, logicalSwitch.u3) annotation (Line(points={{47.5,47},{
          36,47},{36,51},{27,51}}, color={255,0,255}));
  connect(logicalSwitch.y, booleanToReal.u)
    annotation (Line(points={{15.5,55},{6,55},{6,44.8}}, color={255,0,255}));
  connect(booleanToReal.y, heatPump.nSet) annotation (Line(points={{6,35.6},{6,
          24},{6,13.08},{5.66667,13.08}}, color={0,0,127}));
  connect(booleanStep.y, heatPump.modeSet) annotation (Line(points={{
          -1.11022e-015,71.4},{-1.11022e-015,13.08},{0.6,13.08}}, color={255,0,
          255}));
  connect(booleanStep.y, logicalSwitch.u2) annotation (Line(points={{
          -1.11022e-015,71.4},{-1.11022e-015,66},{32,66},{32,55},{27,55}},
        color={255,0,255}));
  connect(temperatureSensor.T, hysHeating.u) annotation (Line(points={{57.9,
          -51.1},{57.9,-40},{72,-40},{72,63},{67,63}}, color={0,0,127}));
  connect(temperatureSensor.T, hysCooling.u) annotation (Line(points={{57.9,
          -51.1},{57.9,-40},{72,-40},{72,47},{59,47}}, color={0,0,127}));
  connect(heatPump.enthalpyPort_b, temperatureSensor.enthalpyPort_a)
    annotation (Line(points={{11,-15},{22,-15},{22,-61.09},{49.08,-61.09}},
        color={176,0,0}));
  connect(pump.enthalpyPort_b, heatPump.enthalpyPort_a)
    annotation (Line(points={{26.4,20},{11,20},{11,11}}, color={176,0,0}));
  connect(fluidSource.enthalpyPort_b, heatPump.enthalpyPort_a1)
    annotation (Line(points={{-30,-33},{-30,-15},{-5,-15}}, color={176,0,0}));
  connect(heatPump.enthalpyPort_b1, vessel_ev.enthalpyPort_a)
    annotation (Line(points={{-5,11},{-5,57},{-27.3,57}}, color={176,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={215,215,215},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,96},{30,80}},
          lineColor={0,0,255},
          fillColor={213,170,255},
          fillPattern=FillPattern.Solid,
          textString="FastHVAC HeatPump
")}),
    experiment(StopTime=20000, Interval=60),
    __Dymola_experimentSetupOutput,
  Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Example Setup is based on fluid example of <a href=
  \"modelica://AixLib.Fluid.HeatPumps.Examples.HeatPump\">AixLib.Fluid.HeatPumps.Examples.HeatPump</a>
</p>
</html>",
  revisions="<html><ul>
  <li>
    <i>May 22, 2019</i> by Julian Matthes:<br/>
    Rebuild due to the introducion of the thermal machine partial model
    (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
  <li>
    <i>January 22, 2019&#160;</i> Niklas Hülsenbeck:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end HeatPump;
