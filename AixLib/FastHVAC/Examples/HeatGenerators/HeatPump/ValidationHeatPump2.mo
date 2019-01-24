within AixLib.FastHVAC.Examples.HeatGenerators.HeatPump;
model ValidationHeatPump2
  extends Modelica.Icons.Example;
  FastHVAC.Components.Sinks.Vessel vessel_co
    annotation (Placement(transformation(extent={{72,-56},{94,-38}})));
  FastHVAC.Components.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{26,-82},{44,-64}})));
  FastHVAC.Components.Pumps.FluidSource fluidSource(medium=
        FastHVAC.Media.WaterSimple())
    annotation (Placement(transformation(extent={{-50,-44},{-30,-24}})));
  Components.HeatGenerators.HeatPump2                  heatPump2(
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
    redeclare model PerDataHea =
        Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D,
    use_revHP=true,
    redeclare model PerDataChi =
        Fluid.HeatPumps.BaseClasses.PerformanceData.LookUpTable2D,
    TAmbCon_nominal=288.15)
    annotation (Placement(transformation(extent={{-13,-16},{13,16}},
        rotation=-90,
        origin={3,-2})));
  FastHVAC.Components.Pumps.FluidSource fluidSource1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={44,30})));
  FastHVAC.Components.Sinks.Vessel vessel_ev annotation (Placement(
        transformation(
        extent={{-11,-9},{11,9}},
        rotation=180,
        origin={-35,57})));
  Modelica.Blocks.Sources.Ramp TsuSourceRamp1(
    startTime=1000,
    height=25,
    offset=278,
    duration=36000)
    annotation (Placement(transformation(extent={{-98,-32},{-78,-12}})));
  Modelica.Blocks.Sources.BooleanPulse    booleanConstant1(period=10000)
    annotation (Placement(transformation(extent={{-92,64},{-72,84}})));
  Modelica.Blocks.Sources.Constant dotm_ev2(k=0.5)
    annotation (Placement(transformation(extent={{-98,-82},{-78,-62}})));
  Modelica.Blocks.Sources.Constant T2(k=308.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,26})));
  Modelica.Blocks.Sources.Constant dotm_co2(k=0.5) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,84})));
  Modelica.Blocks.Sources.Constant iceFac(final k=1) annotation (Placement(
        transformation(
        extent={{5,-5},{-5,5}},
        rotation=180,
        origin={-39,9})));
  Modelica.Blocks.Sources.Constant T_amb_internal(k=291.15)
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=-90,
        origin={3,-35})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{28,34},{8,54}})));
  Modelica.Blocks.Logical.Not not2 "Negate output of hysteresis"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        origin={78,-12},
        rotation=0)));
  Modelica.Blocks.Logical.Hysteresis hys(
    pre_y_start=true,
    uLow=273.15 + 35,
    uHigh=273.15 + 40)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={52,-12})));
equation
  connect(dotm_ev2.y, fluidSource.dotm) annotation (Line(points={{-77,-72},{-64,
          -72},{-64,-36.6},{-48,-36.6}}, color={0,0,127}));
  connect(fluidSource.enthalpyPort_b, heatPump2.enthalpyPort_a1)
    annotation (Line(points={{-30,-33},{-30,-15},{-5,-15}}, color={176,0,0}));
  connect(T_amb_internal.y, heatPump2.T_amb_eva) annotation (Line(points={{3,-27.3},
          {-10.3333,-27.3},{-10.3333,-16.3}}, color={0,0,127}));
  connect(T_amb_internal.y, heatPump2.T_amb_con) annotation (Line(points={{3,-27.3},
          {16.3333,-27.3},{16.3333,-16.3}}, color={0,0,127}));
  connect(heatPump2.enthalpyPort_b, temperatureSensor.enthalpyPort_a)
    annotation (Line(points={{11,-15},{27.08,-15},{27.08,-73.09}}, color={176,0,
          0}));
  connect(temperatureSensor.T, hys.u) annotation (Line(points={{35.9,-63.1},{35.9,
          -12},{40,-12}}, color={0,0,127}));
  connect(temperatureSensor.enthalpyPort_b, vessel_co.enthalpyPort_a)
    annotation (Line(points={{43.1,-73.09},{70,-73.09},{70,-47},{75.3,-47}},
        color={176,0,0}));
  connect(hys.y, not2.u)
    annotation (Line(points={{63,-12},{73.2,-12}}, color={255,0,255}));
  connect(not2.y, booleanToReal.u) annotation (Line(points={{82.4,-12},{92,-12},
          {92,2},{60,2},{60,44},{30,44}}, color={255,0,255}));
  connect(T2.y, fluidSource1.T_fluid) annotation (Line(points={{75,26},{64,26},{
          64,25.8},{52,25.8}}, color={0,0,127}));
  connect(dotm_co2.y, fluidSource1.dotm) annotation (Line(points={{77,84},{68,84},
          {68,32.6},{52,32.6}}, color={0,0,127}));
  connect(fluidSource1.enthalpyPort_b, heatPump2.enthalpyPort_a)
    annotation (Line(points={{34,29},{34,11},{11,11}}, color={176,0,0}));
  connect(booleanToReal.y, heatPump2.nSet) annotation (Line(points={{7,44},{
          5.66667,44},{5.66667,13.08}},
                                color={0,0,127}));
  connect(heatPump2.modeSet, booleanConstant1.y) annotation (Line(points={{0.6,
          13.08},{0.6,74},{-71,74}}, color={255,0,255}));
  connect(heatPump2.enthalpyPort_b1, vessel_ev.enthalpyPort_a)
    annotation (Line(points={{-5,11},{-5,57},{-27.3,57}}, color={176,0,0}));
  connect(iceFac.y, heatPump2.iceFac_in) annotation (Line(points={{-33.5,9},{
          -15.1333,9},{-15.1333,7.88}},
                               color={0,0,127}));
  connect(TsuSourceRamp1.y, fluidSource.T_fluid) annotation (Line(points={{-77,-22},
          {-54,-22},{-54,-29.8},{-48,-29.8}}, color={0,0,127}));
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
    experiment(StopTime=72000, Interval=60),
    __Dymola_experimentSetupOutput,
  Documentation(info="<html>
  <h4><span style=\"color: #008000\">Overview</span></h4>
  <p>Simple test set-up for the HeatPump2 model.<br>
  The heat pump is turned on and off while the source temperature increases linearly. Outputs are the electric power consumption of the heat pump and the supply temperature. <br> 
  Example Setup is based on FastHVAC part from <a href=\"modelica://AixLib.FastHVAC.Examples.HeatGenerators.HeatPump.ValidationHeatPump\">AixLib.FastHVAC.Examples.HeatGenerators.HeatPump.ValidationHeatPump</a> </p>
  </html>",
  revisions="<html><ul>
    <li>
    <i>January 22, 2019&#160;</i> Niklas Hülsenbeck:<br/>
    Moved into AixLib
    </li>
  </ul>
  </html>"));
end ValidationHeatPump2;
