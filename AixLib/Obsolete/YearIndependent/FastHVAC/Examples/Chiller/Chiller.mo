within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Chiller;
model Chiller
  extends Modelica.Icons.Example;
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{52,-38},{66,-52}})));
  FastHVAC.Components.Pumps.FluidSource fluidSource(medium=
        FastHVAC.Media.WaterSimple()) "Fluidsource for sink"
    annotation (Placement(transformation(extent={{-50,-44},{-30,-24}})));
  Components.Chiller.Chiller chiller(
    use_revChi=true,
    redeclare model PerDataMainChi =
        AixLib.DataBase.Chiller.PerformanceData.LookUpTable2D (
          dataTable=AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
    redeclare model PerDataRevChi =
        AixLib.DataBase.HeatPump.PerformanceData.LookUpTable2D (
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, dataTable=
           AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    Q_useNominal=0,
    use_autoCalc=false,
    refIneFre_constant=1,
    Medium_con=Media.WaterSimple(),
    Medium_eva=Media.WaterSimple(),
    mFlow_conNominal=0.5,
    VCon=0.04,
    deltaM_con=0.1,
    use_ConCap=false,
    CCon=100,
    GCon=5,
    mFlow_evaNominal=0.5,
    VEva=0.4,
    deltaM_eva=0.1,
    use_EvaCap=false,
    CEva=100,
    GEva=5,
    allowFlowReversalEva=true,
    TCon_start(displayUnit="K"),
    TEva_start(displayUnit="K"),
    TAmbCon_nominal=273.15,
    TAmbEva_nominal=288.15) annotation (Placement(transformation(
        extent={{-13,-16},{13,16}},
        rotation=90,
        origin={3,-2})));
  FastHVAC.Components.Sinks.Vessel vessel_ev
    "vessel for open evaporator circuit" annotation (Placement(
        transformation(
        extent={{-11,-9},{11,9}},
        rotation=180,
        origin={-35,57})));
  Modelica.Blocks.Sources.Constant dotm_sink(k=1) "Sink mass flow signal"
    annotation (Placement(transformation(extent={{-98,-82},{-78,-62}})));
  Modelica.Blocks.Sources.Constant dotm_source(k=0.106)
    "source mass flow signal" annotation (Placement(transformation(
        extent={{-5,5},{5,-5}},
        rotation=180,
        origin={73,77})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor. 1 means no icing/frosting (full heat transfer in heat exchanger)"                   annotation (Placement(
        transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={36,-12})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    "Constant internal ambient temeprature"
    annotation (Placement(transformation(extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={3,33})));
  Modelica.Blocks.Sources.Ramp TsuSinkRamp(
    duration=1000,
    startTime=1000,
    height=25,
    offset=278)
    "Ramp signal for the temperature input of the sink side's ideal mass flow source"
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
  Modelica.Blocks.Math.Gain gain(k=1)  "negate sine signal"
                                       annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={54,-2})));
  Modelica.Blocks.Sources.Sine sine(
    f=1/3600,
    amplitude=500,
    phase=3.1415926535898,
    offset=500) "hourly sine "
    annotation (Placement(transformation(extent={{66,8},{58,16}})));
  Components.Pumps.Pump pump "source pump"
                             annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={36,20})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=270,
        origin={-3,-53})));
  Modelica.Blocks.Logical.Hysteresis hysCooling(
    pre_y_start=false,
    uHigh=273.15 + 17,
    uLow=273.15 + 14)
    annotation (Placement(transformation(extent={{46,-98},{34,-86}})));
  Modelica.Blocks.Sources.BooleanStep     booleanStep(
      startValue=true, startTime=15000)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=0,
        origin={32,-54})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        origin={24,-76},
        rotation=180)));
  Modelica.Blocks.Logical.Hysteresis hysHeating(
    pre_y_start=true,
    uLow=273.15 + 25,
    uHigh=273.15 + 30)
    annotation (Placement(transformation(extent={{46,-82},{34,-70}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{10,-78},{0,-88}})));
equation
  connect(dotm_sink.y, fluidSource.dotm) annotation (Line(points={{-77,-72},{-64,
          -72},{-64,-36.6},{-48,-36.6}}, color={0,0,127}));
  connect(TsuSinkRamp.y, fluidSource.T_fluid) annotation (Line(points={{-75,-24},
          {-54,-24},{-54,-29.8},{-48,-29.8}}, color={0,0,127}));
  connect(dotm_source.y, pump.dotm_setValue)
    annotation (Line(points={{67.5,77},{36,77},{36,28}}, color={0,0,127}));
  connect(sine.y, gain.u)
    annotation (Line(points={{57.6,12},{54,12},{54,2.8}}, color={0,0,127}));
  connect(gain.y, heatFlowRateCon.Q_flow)
    annotation (Line(points={{54,-6.4},{54,-12},{52,-12}}, color={0,0,127}));
  connect(temperatureSensor.enthalpyPort_b, Room.enthalpyPort_a) annotation (
      Line(points={{65.3,-44.93},{90,-44.93},{90,-35}}, color={176,0,0}));
  connect(Room.enthalpyPort_b, pump.enthalpyPort_a)
    annotation (Line(points={{90,-17},{90,20},{45.6,20}}, color={176,0,0}));
  connect(heatFlowRateCon.port, Room.heatPort)
    annotation (Line(points={{52,-24},{52,-26},{80.6,-26}}, color={191,0,0}));
  connect(pump.enthalpyPort_b, chiller.enthalpyPort_a1)
    annotation (Line(points={{26.4,20},{11,20},{11,11}}, color={176,0,0}));
  connect(fluidSource.enthalpyPort_b, chiller.enthalpyPort_a)
    annotation (Line(points={{-30,-33},{-5,-33},{-5,-15}}, color={176,0,0}));
  connect(vessel_ev.enthalpyPort_a, chiller.enthalpyPort_b) annotation (Line(
        points={{-27.3,57},{-20,57},{-20,18},{-5,18},{-5,11}}, color={176,0,0}));
  connect(iceFac.y, chiller.iceFac_in) annotation (Line(points={{29.4,-12},{
          26.75,-12},{26.75,-11.88},{21.1333,-11.88}},
                                                 color={0,0,127}));
  connect(hysHeating.y,not2. u)
    annotation (Line(points={{33.4,-76},{28.8,-76}}, color={255,0,255}));
  connect(logicalSwitch.y,booleanToReal. u) annotation (Line(points={{-0.5,-83},
          {-3,-83},{-3,-61.4}}, color={255,0,255}));
  connect(not2.y,logicalSwitch. u3) annotation (Line(points={{19.6,-76},{16,-76},
          {16,-79},{11,-79}}, color={255,0,255}));
  connect(hysCooling.y,logicalSwitch. u1) annotation (Line(points={{33.4,-92},{16,
          -92},{16,-87},{11,-87}}, color={255,0,255}));
  connect(booleanStep.y,logicalSwitch. u2) annotation (Line(points={{23.2,-54},{
          14,-54},{14,-83},{11,-83}}, color={255,0,255}));
  connect(chiller.enthalpyPort_b1, temperatureSensor.enthalpyPort_a)
    annotation (Line(points={{11,-15},{11,-30},{44,-30},{44,-44.93},{52.84,-44.93}},
        color={176,0,0}));
  connect(temperatureSensor.T, hysHeating.u) annotation (Line(points={{59.7,-52.7},
          {59.7,-76},{47.2,-76}}, color={0,0,127}));
  connect(temperatureSensor.T, hysCooling.u) annotation (Line(points={{59.7,-52.7},
          {59.7,-92},{47.2,-92}}, color={0,0,127}));
  connect(booleanStep.y, chiller.modeSet) annotation (Line(points={{23.2,-54},{12,
          -54},{12,-36},{5.4,-36},{5.4,-17.08}}, color={255,0,255}));
  connect(chiller.nSet, booleanToReal.y) annotation (Line(points={{0.333333,-17.08},
          {0.333333,-38},{-3,-38},{-3,-45.3}}, color={0,0,127}));
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
          textString="FastHVAC Chiller")}),
    experiment(StopTime=30000, Interval=60),
    __Dymola_experimentSetupOutput,
  Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Example Setup is based on fluid example of <a href=
  \"modelica://AixLib.Fluid.Chillers.Examples.Chiller\">AixLib.Fluid.Chillers.Examples.Chiller</a>
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
end Chiller;
