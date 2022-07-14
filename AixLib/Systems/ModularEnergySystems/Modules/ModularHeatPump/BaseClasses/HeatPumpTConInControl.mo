within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
partial model HeatPumpTConInControl

   extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    redeclare final package Medium1 = AixLib.Media.Water,
    redeclare final package Medium2 = AixLib.Media.Water,
    final m1_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    final m2_flow_nominal=QNom/Medium2.cp_const/DeltaTCon);

    parameter Boolean EnableFeedback=true;
parameter Real PLRMin=0.4 "Limit of PLR; less =0";
    parameter Modelica.Units.SI.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation ();
  parameter Modelica.Units.SI.HeatFlowRate QNom=150000 "Nominal heat flow"
   annotation ();
  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation ();

  Fluid.Sensors.TemperatureTwoPort senTInlet_b(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001) "Temperature sensor inlet stream" annotation (
      Placement(transformation(
        extent={{7,8},{-7,-8}},
        rotation=0,
        origin={-81,-60})));
  Fluid.Sensors.TemperatureTwoPort senTOutlet_b(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001) "Temperature sensor outlet stream" annotation (
      Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={72,60})));
  Fluid.Sensors.TemperatureTwoPort senTInlet_a(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001) "Temperature sensor inlet stream" annotation (
      Placement(transformation(
        extent={{7,-8},{-7,8}},
        rotation=0,
        origin={81,-60})));
  Fluid.Sensors.TemperatureTwoPort senTOutlet_a(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001) "Temperature sensor outlet stream" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,60})));
  Modelica.Blocks.Logical.Switch positionBypass annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,-104})));
  Modelica.Blocks.Sources.RealExpression one(y=0)
    annotation (Placement(transformation(extent={{-42,-128},{-22,-110}})));
  Modelica.Blocks.Sources.BooleanExpression feedback1(y=EnableFeedback)
    annotation (Placement(transformation(extent={{-74,-114},{-26,-94}})));
  Fluid.Sensors.MassFlowRate mFlowMainInlet_a(redeclare final package Medium =
        AixLib.Media.Water, final allowFlowReversal=true)
    "Mass flow sensor inlet stream" annotation (Placement(transformation(
        origin={62,-60},
        extent={{-6,-6},{6,6}},
        rotation=180)));
  Fluid.Sensors.MassFlowRate mFlowMainInlet_b(redeclare final package Medium =
        AixLib.Media.Water, final allowFlowReversal=true)
    "Mass flow sensor inlet stream" annotation (Placement(transformation(
        origin={-58,-60},
        extent={{-6,-6},{6,6}},
        rotation=180)));
  Modelica.Blocks.Math.Add positionMain(k1=-1) annotation (Placement(
        transformation(
        extent={{7,-7},{-7,7}},
        rotation=0,
        origin={7,-79})));
  Fluid.Sensors.MassFlowRate mFlowMainOutlet_b(redeclare final package Medium =
        AixLib.Media.Water, final allowFlowReversal=true)
    "Mass flow sensor outlet stream" annotation (Placement(transformation(
        origin={42,60},
        extent={{-6,-6},{6,6}},
        rotation=0)));
  Fluid.Sensors.MassFlowRate mFlowMainOutlet_a(redeclare final package Medium =
        AixLib.Media.Water, final allowFlowReversal=true)
    "Mass flow sensor outlet stream" annotation (Placement(transformation(
        origin={-42,60},
        extent={{-6,-6},{6,6}},
        rotation=0)));
  AixLib.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=0.01,
    Ti=30,
    Td=1,
    yMax=0.9)
    annotation (Placement(transformation(extent={{-114,-104},{-94,-84}})));
  Modelica.Blocks.Sources.RealExpression one2(y=1)
    annotation (Placement(transformation(extent={{50,-116},{70,-98}})));
  Modelica.Blocks.Sources.RealExpression tColdNom1(y=THotNom - DeltaTCon)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{-200,-108},{-128,-78}})));
equation
  connect(one.y, positionBypass.u3) annotation (Line(points={{-21,-119},{-2,-119},
          {-2,-112}}, color={0,0,127}));
  connect(feedback1.y, positionBypass.u2)
    annotation (Line(points={{-23.6,-104},{-2,-104}}, color={255,0,255}));
  connect(port_a2, senTInlet_a.port_a)
    annotation (Line(points={{100,-60},{88,-60}}, color={0,127,255}));
  connect(port_b2, senTInlet_b.port_b)
    annotation (Line(points={{-100,-60},{-88,-60}}, color={0,127,255}));
  connect(port_a1, senTOutlet_a.port_a)
    annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
  connect(senTOutlet_b.port_b, port_b1)
    annotation (Line(points={{80,60},{100,60}}, color={0,127,255}));
  connect(senTInlet_b.port_a, mFlowMainInlet_b.port_b)
    annotation (Line(points={{-74,-60},{-64,-60}}, color={0,127,255}));
  connect(positionBypass.y, positionMain.u1) annotation (Line(points={{21,-104},
          {26,-104},{26,-74.8},{15.4,-74.8}}, color={0,0,127}));
  connect(mFlowMainOutlet_b.port_b, senTOutlet_b.port_a)
    annotation (Line(points={{48,60},{64,60}}, color={0,127,255}));
  connect(senTOutlet_a.port_b, mFlowMainOutlet_a.port_a)
    annotation (Line(points={{-60,60},{-48,60}}, color={0,127,255}));
  connect(senTInlet_a.port_b, mFlowMainInlet_a.port_a)
    annotation (Line(points={{74,-60},{68,-60}}, color={0,127,255}));
  connect(one2.y, positionMain.u2) annotation (Line(points={{71,-107},{92,-107},
          {92,-83.2},{15.4,-83.2}}, color={0,0,127}));
  connect(senTInlet_b.T, conPID.u_m) annotation (Line(points={{-81,-68.8},{-81,
          -122},{-104,-122},{-104,-106}}, color={0,0,127}));
  connect(conPID.y, positionBypass.u1)
    annotation (Line(points={{-93,-94},{-2,-94},{-2,-96}}, color={0,0,127}));
  connect(conPID.u_s, tColdNom1.y) annotation (Line(points={{-116,-94},{-116,
          -93},{-124.4,-93}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-30,30},{30,-30}},
          origin={50,62},
          rotation=90,
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-30,30},{30,-30}},
          origin={-50,-64},
          rotation=90,
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-30,30},{30,-30}},
          origin={-50,60},
          rotation=90,
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{20,-34},{80,-94}},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
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
          points={{40,82},{80,62},{40,42},{40,82}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          rotation=360),
        Rectangle(
          extent={{-57,10},{57,-10}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-16,61},
          rotation=360),
        Polygon(
          points={{-20,20},{20,0},{-20,-20},{-20,20}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-56,-60},
          rotation=180),
        Rectangle(
          extent={{-56,10},{56,-10}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={20,-62},
          rotation=180)}),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{112,-64},{160,-54}},
          lineColor={28,108,200},
          textString="Module Inlet"),                          Text(
          extent={{-162,-64},{-114,-54}},
          lineColor={28,108,200},
          textString="Condenser Inlet"),                       Text(
          extent={{-162,56},{-114,66}},
          lineColor={28,108,200},
          textString="Condenser Outlet"),                      Text(
          extent={{112,54},{160,64}},
          lineColor={28,108,200},
          textString="Module Outlet")}));
end HeatPumpTConInControl;
