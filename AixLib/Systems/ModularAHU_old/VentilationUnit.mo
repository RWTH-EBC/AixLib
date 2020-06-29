within AixLib.Systems.ModularAHU_old;
model VentilationUnit "Ventilation unit for a room"
  replaceable package Medium1 =
    Modelica.Media.Interfaces.PartialCondensingGases "Medium in air canal in the component"    annotation (choices(
      choice(redeclare package Medium = AixLib.Media.Air "Moist air")));
replaceable package Medium2 =
      Modelica.Media.Interfaces.PartialMedium "Medium in hydraulic circuits"
    annotation (choices(
      choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
      choice(redeclare package Medium = AixLib.Media.Water "Water"),
      choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (property_T=293.15,
              X_a=0.40) "Propylene glycol water, 40% mass fraction")));
  parameter  Modelica.SIunits.Temperature T_amb "Ambient temperature";
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal(min=0)
    "Nominal mass flow rate in air canal";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal(min=0)
    "Nominal mass flow rate in hydraulics";
  parameter Boolean allowFlowReversal1=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium in air canal" annotation(Dialog(tab="Assumptions"), Evaluate=true);
  parameter Boolean allowFlowReversal2=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium in hydraulics" annotation(Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors" annotation(Dialog(tab="Advanced"));
  ModularAHU_old.BaseClasses.GenericAHUBus genericAHUBus annotation (Placement(
        transformation(extent={{-18,82},{18,118}}), iconTransformation(extent={
            {-14,108},{14,134}})));
  ModularAHU_old.RegisterModule cooler(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal2,
    final m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    T_start=T_start,
    tau=tau,
    T_amb=T_amb) annotation (Dialog(enable=true, group="Cooler"), Placement(
        transformation(extent={{-72,-46},{-28,14}})));
  ModularAHU_old.RegisterModule heater(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal2,
    final m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    T_start=T_start,
    tau=tau,
    T_amb=T_amb) annotation (Dialog(enable=true, group="Heater"), Placement(
        transformation(extent={{6,-46},{50,14}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare package Medium =
        Medium2)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}}),
        iconTransformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium =
        Medium2)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),
        iconTransformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a4(redeclare package Medium =
        Medium2)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}}),
        iconTransformation(extent={{10,-110},{30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b4(redeclare package Medium =
        Medium2)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{50,-110},{70,-90}}),
        iconTransformation(extent={{48,-110},{68,-90}})));
  Fluid.Actuators.Dampers.Exponential flapSup(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{76,-8},{92,8}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium1)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium1)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Fluid.FixedResistances.PressureDrop      res(
    redeclare package Medium = Medium1,
    allowFlowReversal=allowFlowReversal1,
    m_flow_nominal=m1_flow_nominal,
    final dp_nominal=dp2_nominal)
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,60})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium1)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{90,50},{110,70}}),
        iconTransformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium1)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,50},{-90,70}}),
        iconTransformation(extent={{-108,50},{-88,70}})));
  parameter Modelica.SIunits.PressureDifference dp2_nominal=10
    "Pressure drop at nominal mass flow rate of duct 2 (return)";
  Fluid.Sensors.TemperatureTwoPort senTRet(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal,
    T_start=T_start)
    annotation (Placement(transformation(extent={{40,52},{24,68}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRelHumSup(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{56,-6},{68,6}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRelHumSup1(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{6,54},{-6,66}})));
protected
  Modelica.Blocks.Continuous.FirstOrder PT1_airIn3(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=270,
        origin={35,83})));
equation
  connect(cooler.port_b1,heater. port_a1)
    annotation (Line(points={{-28,0.15385},{6,0.15385}},   color={0,127,255}));
  connect(cooler.port_a2,port_a3)  annotation (Line(points={{-72,-27.5385},{-72,
          -100},{-60,-100}},   color={0,127,255}));
  connect(cooler.port_b2,port_b3)  annotation (Line(points={{-28,-27.5385},{-28,
          -28},{-12,-28},{-12,-100},{-20,-100}},
                                         color={0,127,255}));
  connect(heater.port_a2,port_a4)  annotation (Line(points={{6,-27.5385},{6,
          -100},{20,-100}},                       color={0,127,255}));
  connect(heater.port_b2,port_b4)  annotation (Line(points={{50,-27.5385},{62,
          -27.5385},{62,-100},{60,-100}},                       color={0,127,255}));
  connect(cooler.registerBus, genericAHUBus.coolerBus) annotation (Line(
      points={{-71.78,-13.9231},{-78,-13.9231},{-78,-106},{114,-106},{114,
          100.09},{0.09,100.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heater.registerBus, genericAHUBus.heaterBus) annotation (Line(
      points={{6.22,-13.9231},{-2,-13.9231},{-2,-108},{114,-108},{114,100},{
          0.09,100},{0.09,100.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(flapSup.y, genericAHUBus.flapSupSet) annotation (Line(points={{84,9.6},
          {84,100.09},{0.09,100.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(flapSup.y_actual, genericAHUBus.flapSupMea) annotation (Line(points={{88,5.6},
          {88,100},{0.09,100},{0.09,100.09}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(cooler.port_a1, port_a1) annotation (Line(points={{-72,0.153846},{-80,
          0.153846},{-80,0},{-100,0}}, color={0,127,255}));
  connect(res.port_b, port_b2)
    annotation (Line(points={{-80,60},{-100,60}}, color={0,127,255}));
  connect(senTRet.T,PT1_airIn3. u) annotation (Line(points={{32,68.8},{32,74},{
          35,74},{35,77}},   color={0,0,127}));
  connect(PT1_airIn3.y, genericAHUBus.TRetAirMea) annotation (Line(points={{35,88.5},
          {35,100.09},{0.09,100.09}},         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTRet.port_a, port_a2)
    annotation (Line(points={{40,60},{100,60}}, color={0,127,255}));
  connect(senRelHumSup1.phi, genericAHUBus.relHumRetMea) annotation (Line(
        points={{-0.06,66.6},{-0.06,88},{0.09,88},{0.09,100.09}},     color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTRet.port_b, senRelHumSup1.port_a)
    annotation (Line(points={{24,60},{6,60}}, color={0,127,255}));
  connect(senRelHumSup1.port_b, res.port_a)
    annotation (Line(points={{-6,60},{-60,60}}, color={0,127,255}));
  connect(heater.port_b1, senRelHumSup.port_a) annotation (Line(points={{50,
          0.153846},{54,0.153846},{54,0},{56,0}}, color={0,127,255}));
  connect(senRelHumSup.port_b, flapSup.port_a)
    annotation (Line(points={{68,0},{76,0}}, color={0,127,255}));
  connect(flapSup.port_b, port_b1)
    annotation (Line(points={{92,0},{102,0}}, color={0,127,255}));
  connect(senRelHumSup.phi, genericAHUBus.relHumSupMea) annotation (Line(points=
         {{62.06,6.6},{62.06,100.09},{0.09,100.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,0},{92,0}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-88,60},{94,60}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-66,36},{-20,-36}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-66,36},{-20,-36}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{8,36},{54,-36}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{8,36},{54,-36}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{66,8},{84,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{68,-6},{80,6}},
          color={0,0,0},
          thickness=0.5),
        Ellipse(
          extent={{72,0},{74,-2}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end VentilationUnit;
