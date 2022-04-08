within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
model HeatPumpHotWaterFeedback

  extends
    AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses.HeatPumpTConInControl
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

    parameter Boolean EnableFeedback=true;
parameter Real PLRMin=0.4 "Limit of PLR; less =0";
    parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation ();
  parameter Modelica.SIunits.HeatFlowRate QNom=150000 "Nominal heat flow"
   annotation ();
  parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation ();


  Fluid.Sensors.MassFlowRate mFlowBypass(redeclare final package Medium =
        Media.Water, final allowFlowReversal=true)
    "Mass flow sensor bypass"        annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={0,30})));
  Fluid.Actuators.Valves.TwoWayLinear valBaypass(
    allowFlowReversal=false,
    m_flow_nominal=QNom/4180/DeltaTCon,
    from_dp=false,
    redeclare package Medium = Media.Water,
    dpValve_nominal=6000,
    riseTime=60,
    y_start=0)            annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-10})));
  Fluid.Actuators.Valves.TwoWayLinear valMain(
    allowFlowReversal=false,
    m_flow_nominal=QNom/4180/DeltaTCon,
    from_dp=false,
    redeclare package Medium = AixLib.Media.Water,
    dpValve_nominal=6000,
    riseTime=60,
    y_start=0) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={20,60})));
equation
  connect(mFlowBypass.port_b, valBaypass.port_a) annotation (Line(points={{-1.4988e-15,
          22},{6.10623e-16,0}}, color={0,127,255}));
  connect(mFlowMainOutlet_a.port_b, valMain.port_a)
    annotation (Line(points={{-36,60},{10,60}}, color={0,127,255}));
  connect(mFlowMainOutlet_a.port_b, mFlowBypass.port_a)
    annotation (Line(points={{-36,60},{0,60},{0,38}}, color={0,127,255}));
  connect(valBaypass.port_b, mFlowMainInlet_b.port_a)
    annotation (Line(points={{0,-20},{0,-60},{-52,-60}}, color={0,127,255}));
  connect(mFlowMainInlet_a.port_b, mFlowMainInlet_b.port_a)
    annotation (Line(points={{56,-60},{-52,-60}}, color={0,127,255}));
  connect(positionMain.y, valMain.y) annotation (Line(points={{-0.7,-79},{-0.7,
          -48},{20,-48},{20,48}}, color={0,0,127}));
  connect(positionBypass.y, valBaypass.y) annotation (Line(points={{21,-104},{
          38,-104},{38,-40},{-28,-40},{-28,-10},{-12,-10}}, color={0,0,127}));
  connect(valMain.port_b, mFlowMainOutlet_b.port_a)
    annotation (Line(points={{30,60},{36,60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-30,30},{30,-30}},
          origin={50,62},
          rotation=90,
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-57,10},{57,-10}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-16,61},
          rotation=360),
        Rectangle(
          extent={{-16,10},{16,-10}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          rotation=90,
          origin={0,12}),
        Polygon(
          points={{-20,16},{14,1.7077e-15},{-20,-18},{-20,16}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          rotation=270,
          origin={0,-24}),
        Polygon(
          points={{40,80},{80,60},{40,40},{40,80}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          rotation=360)}),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPumpHotWaterFeedback;
