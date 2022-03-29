within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
model HeatPumpHotWaterReturn

  extends AixLib.Fluid.Interfaces.PartialFourPortInterface(
    redeclare final package Medium1 = AixLib.Media.Water,
    redeclare final package Medium2 = AixLib.Media.Water,
    final m1_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    final m2_flow_nominal=QNom/Medium2.cp_const/DeltaTCon);

    parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
   annotation ();
  parameter Modelica.SIunits.HeatFlowRate QNom=150000 "Nominal heat flow"
   annotation ();
  parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
   annotation ();

parameter Modelica.SIunits.TemperatureDifference Bandwith=5 "Bandwith of condenser inlet temperature for variable return flow"
   annotation ();

  Fluid.Actuators.Valves.ThreeWayLinear val_a(
    redeclare package Medium = AixLib.Media.Water,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=0.5,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    dpValve_nominal=6000,
    fraK=0.5)
    annotation (Placement(transformation(extent={{13,13},{-13,-13}},
        rotation=90,
        origin={-55,41})));
  Modelica.Blocks.Sources.RealExpression valveMax(y=0.5) "max. y of valves"
    annotation (Placement(transformation(extent={{44,-16},{26,2}})));
  Fluid.Actuators.Valves.ThreeWayLinear val_b(
    redeclare package Medium = AixLib.Media.Water,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=0.5,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=QNom/Medium1.cp_const/DeltaTCon,
    dpValve_nominal=6000,
    fraK=0.5) annotation (Placement(transformation(extent={{54,50},{74,70}})));
  Modelica.Blocks.Sources.RealExpression tColdNom(y=THotNom - DeltaTCon)
    "Nominal TCold"
    annotation (Placement(transformation(extent={{-100,-14},{-66,10}})));
  AixLib.Controls.Continuous.LimPID valveControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=1,
    Ti=10,
    yMax=0.5,
    yMin=0) annotation (Placement(transformation(extent={{-40,-12},{-20,8}})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,16})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=Bandwith)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-22})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{-38,-86},{-26,-74}})));
  Modelica.Blocks.Sources.RealExpression tHotMax4(y=THotNom - DeltaTCon -
        Bandwith/2)
    "Maximal THot"
    annotation (Placement(transformation(extent={{-96,-92},{-54,-68}})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={6,-48})));
  Modelica.Blocks.Interfaces.RealInput tCold annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={6,-120})));
  Modelica.Blocks.Sources.RealExpression valveMax1(y=0)  "max. y of valves"
    annotation (Placement(transformation(extent={{42,32},{24,50}})));
equation
  connect(val_b.port_1, val_a.port_1) annotation (Line(points={{54,60},{-55,60},
          {-55,54}},                                                color={0,127,
          255}));
  connect(onOffController.y, switch2.u2) annotation (Line(points={{7.21645e-16,-11},
          {-6.66134e-16,4}},
        color={255,0,255}));
  connect(onOffController.reference, gain2.y) annotation (Line(points={{-6,-34},
          {-6,-50},{-20,-50},{-20,-80},{-25.4,-80}},
                                            color={0,0,127}));
  connect(tHotMax4.y, gain2.u) annotation (Line(points={{-51.9,-80},{-39.2,-80}},
                                        color={0,0,127}));
  connect(gain1.y, onOffController.u) annotation (Line(points={{6,-41.4},{6,-34}},
                                                        color={0,0,127}));
  connect(port_a2, val_b.port_3)
    annotation (Line(points={{100,-60},{64,-60},{64,50}}, color={0,127,255}));
  connect(val_a.port_2, port_b2) annotation (Line(points={{-55,28},{-55,-60},{-100,
          -60}}, color={0,127,255}));
  connect(port_a1, val_a.port_3) annotation (Line(points={{-100,60},{-72,60},{-72,
          41},{-68,41}}, color={0,127,255}));
  connect(val_b.port_2, port_b1)
    annotation (Line(points={{74,60},{100,60}}, color={0,127,255}));
  connect(tColdNom.y, valveControl.u_s) annotation (Line(points={{-64.3,-2},{
          -42,-2}},                        color={0,0,127}));
  connect(tCold, valveControl.u_m) annotation (Line(points={{6,-120},{6,-60},{
          -30,-60},{-30,-14}},color={0,0,127}));
  connect(tCold, gain1.u)
    annotation (Line(points={{6,-120},{6,-55.2}}, color={0,0,127}));
  connect(valveMax.y, switch2.u3)
    annotation (Line(points={{25.1,-7},{8,-7},{8,4}}, color={0,0,127}));
  connect(valveControl.y, switch2.u1)
    annotation (Line(points={{-19,-2},{-8,-2},{-8,4}}, color={0,0,127}));
  connect(switch2.y, val_a.y)
    annotation (Line(points={{0,27},{0,41},{-39.4,41}}, color={0,0,127}));
  connect(switch2.y, val_b.y)
    annotation (Line(points={{0,27},{0,78},{64,78},{64,72}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{20,-34},{80,-94}},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-30,30},{30,-30}},
          origin={-50,60},
          rotation=90,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-38,36},{40,-40}},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          lineThickness=1,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-30,30},{30,-30}},
          origin={50,60},
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
          extent={{-60,70},{26,48}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,80},{60,60},{20,40},{20,80}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-41,11},{41,-11}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={19,-61},
          rotation=180),
        Polygon(
          points={{-20,20},{20,0},{-20,-20},{-20,20}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-40,-60},
          rotation=180)}),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-28,98},{24,82}},
          lineColor={28,108,200},
          textString="0= Durchfluss
1= Zirkulation"),                                              Text(
          extent={{112,56},{160,66}},
          lineColor={28,108,200},
          textString="Module Outlet"),                         Text(
          extent={{112,-64},{160,-54}},
          lineColor={28,108,200},
          textString="HeatPump Outlet"),                       Text(
          extent={{-160,-64},{-112,-54}},
          lineColor={28,108,200},
          textString="HeatPump Inlet"),                        Text(
          extent={{-160,56},{-112,66}},
          lineColor={28,108,200},
          textString="Module Inlet")}),
    Documentation(info="<html>
<p>Implemetiert durch Moritz; Idee R&uuml;cklauf David</p>
</html>"));
end HeatPumpHotWaterReturn;
