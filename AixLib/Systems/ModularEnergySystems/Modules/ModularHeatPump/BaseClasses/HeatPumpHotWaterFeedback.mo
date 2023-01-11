within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
model HeatPumpHotWaterFeedback

  extends
    AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses.HeatPumpTConInControl(
      one2(y=0), conPID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=20,
      yMax=1,
      yMin=0))
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

    parameter Boolean EnableFeedback=true;
parameter Real PLRMin=0.4 "Limit of PLR; less =0";
    parameter Modelica.Units.SI.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation ();
  parameter Modelica.Units.SI.HeatFlowRate QNom=150000 "Nominal heat flow"
   annotation ();
  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation ();


  Fluid.Sensors.MassFlowRate mFlowBypass(redeclare final package Medium =
        Media.Water, final allowFlowReversal=true)
    "Mass flow sensor bypass"        annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput mFlowCon "m_flow Condenser" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = AixLib.Media.Water,
    riseTime=30,
    m_flow_nominal=QNom/4180/DeltaTCon,
    dpValve_nominal=6000,
    fraK=1) annotation (Placement(transformation(extent={{12,-48},{-12,-72}})));
equation
  connect(mFlowMainOutlet_a.m_flow, mFlowCon) annotation (Line(points={{-42,
          66.6},{-42,80},{0,80},{0,110}}, color={0,0,127}));
  connect(mFlowMainInlet_a.port_b, val.port_1)
    annotation (Line(points={{56,-60},{12,-60}}, color={0,127,255}));
  connect(mFlowMainOutlet_a.port_b, mFlowBypass.port_a)
    annotation (Line(points={{-36,60},{0,60},{0,8}}, color={0,127,255}));
  connect(mFlowMainOutlet_a.port_b, mFlowMainOutlet_b.port_a)
    annotation (Line(points={{-36,60},{36,60}}, color={0,127,255}));
  connect(mFlowBypass.port_b, val.port_3)
    annotation (Line(points={{0,-8},{0,-48},{0,-48}}, color={0,127,255}));
  connect(val.port_2, mFlowMainInlet_b.port_a)
    annotation (Line(points={{-12,-60},{-52,-60}}, color={0,127,255}));
  connect(conPID.y, val.y)
    annotation (Line(points={{-93,-94},{0,-94},{0,-74.4}}, color={0,0,127}));
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
