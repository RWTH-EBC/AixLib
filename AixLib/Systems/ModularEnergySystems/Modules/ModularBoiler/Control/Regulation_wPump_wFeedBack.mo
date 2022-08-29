within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control;
model Regulation_wPump_wFeedBack

  parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Thermal dimension power"
    annotation (Dialog(group="Nominal condition"));
  parameter Boolean m_flowVar=false "Use variable water massflow"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
  parameter Boolean Advanced=false "dTWater is constant for different PLR"
    annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
  parameter Boolean use_advancedControl=true "Selection between two position control and flow temperature control, if true=flow temperature control is active";
  parameter Boolean severalHeatCircuits=false;
  parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
    annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";
  parameter Modelica.Units.SI.Temperature TColdNom=308.15    "Return temperature TCold"
    annotation (Dialog(group="Nominal condition"));
  parameter Real k_ControlBoilerValve(min=Modelica.Constants.small)=0.01 "Gain of controller"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));
  parameter Modelica.Units.SI.Time Ti_ControlBoilerValve(min=Modelica.Constants.small)=7 "Time constant of Integrator block"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));

  Controls.ControlBoilerNotManufacturer controlBoilerNotManufacturer(
    final DeltaTWaterNom=dTWaterNom,
    final QNom=QNom,
    final m_flowVar=m_flowVar,
    final Advanced=Advanced,
    final dTWaterSet=dTWaterSet)
    annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
  Modelica.Blocks.Interfaces.RealInput TCold
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-80,-20})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-60})));
  Modelica.Blocks.Interfaces.RealOutput dTWater
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-60})));
  Modelica.Blocks.Interfaces.RealOutput PLR
if not use_advancedControl or (use_advancedControl and severalHeatCircuits)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-60})));
  Modelica.Blocks.Interfaces.RealInput THot_Boiler
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-80,-40})));
  Modelica.Blocks.Interfaces.RealInput THot
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-80,-60})));
  Modelica.Blocks.Interfaces.RealInput dTwater_in
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-80,40})));
  Modelica.Blocks.Interfaces.RealInput PLR_in
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-80,60})));

  Modelica.Blocks.Continuous.LimPID PIValve(
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=k_ControlBoilerValve,
    final Ti=Ti_ControlBoilerValve,
    final yMax=-0.05,
    final yMin=-1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    final y_start=-0.5)
    annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={44,-16})));
  Modelica.Blocks.Interfaces.RealOutput y_valve
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-60})));
  Modelica.Blocks.Math.Gain gain(final k=-1)
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-40,-40})));
  BaseClasses.Regulation_ModularBoiler regulation_ModularBoiler(
    final PLRmin=PLRMin,
    final use_advancedControl=use_advancedControl,
    final severalHeatCircuits=severalHeatCircuits)
    annotation (Placement(transformation(extent={{-14,36},{6,56}})));
  Modelica.Blocks.Interfaces.RealInput PLR_mea
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-80,20})));

protected
  Modelica.Blocks.Sources.RealExpression TSet_Cold(final y=TColdNom)
    annotation (Placement(transformation(extent={{6,-26},{26,-6}})));

equation

  connect(TCold, controlBoilerNotManufacturer.TCold)
    annotation (Line(points={{-80,-20},
          {-62,-20},{-62,13},{-54,13}},         color={0,0,127}));
  connect(controlBoilerNotManufacturer.DeltaTWater_b, dTWater)
    annotation (Line(
        points={{-31,4.8},{-28,4.8},{-28,-32},{20,-32},{20,-60}},     color={0,0,
          127}));
  connect(THot_Boiler, controlBoilerNotManufacturer.THot)
    annotation (Line(
        points={{-80,-40},{-58,-40},{-58,10},{-54,10}},     color={0,0,127}));
  connect(dTwater_in, controlBoilerNotManufacturer.DeltaTWater_a)
    annotation (
      Line(points={{-80,40},{-60,40},{-60,7},{-54,7}},       color={0,0,127}));
  connect(TSet_Cold.y, PIValve.u_s)
    annotation (Line(points={{27,-16},{36.8,-16}},color={0,0,127}));
  connect(TCold, PIValve.u_m)
    annotation (Line(points={{-80,-20},{-20,-20},{-20,
          -28},{44,-28},{44,-23.2}}, color={0,0,127}));
  connect(gain.y, y_valve)
    annotation (Line(points={{-40,-46.6},{-40,-60}}, color={0,0,127}));
  connect(gain.u, PIValve.y)
    annotation (Line(points={{-40,-32.8},{-40,-30},{58,
          -30},{58,-16},{50.6,-16}}, color={0,0,127}));
  connect(controlBoilerNotManufacturer.mFlowRel, regulation_ModularBoiler.mFlow_rel)
    annotation (Line(points={{-31,18},{-26,18},{-26,44},{-14,44}}, color={0,0,127}));
  connect(regulation_ModularBoiler.PLRset, PLR)
    annotation (Line(points={{6.2,50},
          {28,50},{28,16},{0,16},{0,-60}},       color={0,0,127}));
  connect(regulation_ModularBoiler.mFlow_relB, y)
    annotation (Line(points={{6.2,46},
          {12,46},{12,20},{-20,20},{-20,-60}},     color={0,0,127}));
  connect(PLR_in, regulation_ModularBoiler.PLRin)
    annotation (Line(points={{-80,60},
          {-60,60},{-60,48},{-14,48}},     color={0,0,127}));
  connect(PLR_mea, regulation_ModularBoiler.PLRMea)
    annotation (Line(points={{-80,20},
          {-54,20},{-54,40},{-14,40}},     color={0,0,127}));

annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,-60},
            {60,60}})),                                          Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-80,-60},{60,60}})),
    Documentation(info="<html><p>
  A boiler model consisting of physical components. The user has the
  choice to run the model for three different setpoint options:
</p>
<ol>
  <li>Setpoint depends on part load ratio (water mass flow=dimension
  water mass flow; advanced=false & m_flowVar=false)
  </li>
  <li>Setpoint depends on part load ratio and a constant water
  temperature difference which is idependent from part load ratio
  (water mass flow is variable; advanced=false & m_flowVar=true)
  </li>
  <li>Setpoint depends on part load ratio an a variable water
  temperature difference (water mass flow is variable; advanced=true)
  </li>
</ol>
</html>"),
    experiment(StopTime=10));
end Regulation_wPump_wFeedBack;
