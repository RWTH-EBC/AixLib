within AixLib.FastHVAC.Examples.HeatGenerators.HeatPump;
model HeatPump
  extends Modelica.Icons.Example;
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{26,-82},{44,-64}})));
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
        Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (dataTable=
            AixLib.DataBase.HeatPump.EN14511.Vitocal200AWO201()),
    redeclare model PerDataChi =
        Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D (dataTable=
            AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()),
    TAmbCon_nominal=288.15) annotation (Placement(transformation(
        extent={{-13,-16},{13,16}},
        rotation=-90,
        origin={3,-2})));
  FastHVAC.Components.Sinks.Vessel vessel_ev
    "vessel for open evaporator circuit"     annotation (Placement(
        transformation(
        extent={{-11,-9},{11,9}},
        rotation=180,
        origin={-35,57})));
  Modelica.Blocks.Sources.Constant dotm_source(k=1) "Source mass flow signal"
    annotation (Placement(transformation(extent={{-98,-82},{-78,-62}})));
  Modelica.Blocks.Sources.Constant dotm_sink(k=0.106) "sink mass flow signal"
                                                      annotation (Placement(
        transformation(
        extent={{-5,5},{5,-5}},
        rotation=180,
        origin={73,77})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1)
    "Fixed value for icing factor"                   annotation (Placement(
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
    annotation (Placement(transformation(extent={{18,48},{8,58}})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        origin={62,-54},
        rotation=0)));
  Modelica.Blocks.Logical.Hysteresis hys(
    pre_y_start=true,
    uLow=273.15 + 35,
    uHigh=273.15 + 40) "hysteresis controller for on off control"
    annotation (Placement(transformation(extent={{5,-4},{-5,4}},
        rotation=180,
        origin={49,-54})));
  Modelica.Blocks.Sources.BooleanStep     booleanStep(startTime=10000,
      startValue=true)
    "boolean signal to switch from heating to cooling operation"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-80,76})));
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
    freqHz=1/3600,
    amplitude=3000,
    offset=3000) "hourly sine "
    annotation (Placement(transformation(extent={{66,8},{58,16}})));
  Components.Pumps.Pump pump "sink pump"
                             annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={36,20})));
equation
  connect(dotm_source.y, fluidSource.dotm) annotation (Line(points={{-77,-72},{-64,
          -72},{-64,-36.6},{-48,-36.6}}, color={0,0,127}));
  connect(fluidSource.enthalpyPort_b, heatPump.enthalpyPort_a1)
    annotation (Line(points={{-30,-33},{-30,-15},{-5,-15}}, color={176,0,0}));
  connect(T_amb_internal.y, heatPump.T_amb_eva) annotation (Line(points={{3,-27.3},
          {-10.3333,-27.3},{-10.3333,-16.3}}, color={0,0,127}));
  connect(T_amb_internal.y, heatPump.T_amb_con) annotation (Line(points={{3,-27.3},
          {16.3333,-27.3},{16.3333,-16.3}}, color={0,0,127}));
  connect(heatPump.enthalpyPort_b, temperatureSensor.enthalpyPort_a)
    annotation (Line(points={{11,-15},{27.08,-15},{27.08,-73.09}}, color={176,0,
          0}));
  connect(temperatureSensor.T, hys.u) annotation (Line(points={{35.9,-63.1},{35.9,
          -54},{43,-54}}, color={0,0,127}));
  connect(booleanToReal.y, heatPump.nSet) annotation (Line(points={{7.5,53},{5.66667,
          53},{5.66667,13.08}}, color={0,0,127}));
  connect(heatPump.enthalpyPort_b1, vessel_ev.enthalpyPort_a)
    annotation (Line(points={{-5,11},{-5,57},{-27.3,57}}, color={176,0,0}));
  connect(iceFac.y, heatPump.iceFac_in) annotation (Line(points={{-33.5,9},{
          -15.1333,9},{-15.1333,7.88}},
                               color={0,0,127}));
  connect(booleanStep.y, heatPump.modeSet) annotation (Line(points={{-75.6,76},{
          0.6,76},{0.6,13.08}}, color={255,0,255}));
  connect(TsuSourceRamp.y, fluidSource.T_fluid) annotation (Line(points={{-75,-24},
          {-54,-24},{-54,-29.8},{-48,-29.8}}, color={0,0,127}));
  connect(pump.enthalpyPort_b, heatPump.enthalpyPort_a)
    annotation (Line(points={{26.4,20},{11,20},{11,11}}, color={176,0,0}));
  connect(dotm_sink.y, pump.dotm_setValue)
    annotation (Line(points={{67.5,77},{36,77},{36,28}}, color={0,0,127}));
  connect(sine.y, gain.u)
    annotation (Line(points={{57.6,12},{54,12},{54,2.8}}, color={0,0,127}));
  connect(gain.y, heatFlowRateCon.Q_flow)
    annotation (Line(points={{54,-6.4},{54,-12},{52,-12}}, color={0,0,127}));
  connect(temperatureSensor.enthalpyPort_b, Room.enthalpyPort_a) annotation (
      Line(points={{43.1,-73.09},{90,-73.09},{90,-35}}, color={176,0,0}));
  connect(hys.y, not2.u)
    annotation (Line(points={{54.5,-54},{57.2,-54}}, color={255,0,255}));
  connect(not2.y, booleanToReal.u) annotation (Line(points={{66.4,-54},{68,-54},
          {68,53},{19,53}}, color={255,0,255}));
  connect(Room.enthalpyPort_b, pump.enthalpyPort_a)
    annotation (Line(points={{90,-17},{90,20},{45.6,20}}, color={176,0,0}));
  connect(heatFlowRateCon.port, Room.heatPort)
    annotation (Line(points={{52,-24},{52,-26},{80.6,-26}}, color={191,0,0}));
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
          textString="FastHVAC HeatPump2
")}),
    experiment(StopTime=20000, Interval=60),
    __Dymola_experimentSetupOutput,
  Documentation(info="<html>
  <h4><span style=\"color: #008000\">Overview</span></h4>
  <p>Simple test set-up for the HeatPump model.<br/>
  The heat pump is turned on and off while the source temperature increases
  linearly. Outputs are the electric power consumption of the heat pump and 
  the supply temperature. <br/> 
  Example Setup is based on FastHVAC part of
  <a href=\"modelica://AixLib.FastHVAC.Examples.
  HeatGenerators.HeatPump.ValidationHeatPump\">
  AixLib.FastHVAC.Examples.HeatGenerators.HeatPump.
  ValidationHeatPump</a> </p>
  </html>",
  revisions="<html><ul>
    <li>
    <i>January 22, 2019&#160;</i> Niklas Hülsenbeck:<br/>
    Moved into AixLib
    </li>
  </ul>
  </html>"));
end HeatPump;
