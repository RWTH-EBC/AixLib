within AixLib.Systems.ModularAHU;
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
  ModularAHU.BaseClasses.GenericAHUBus
                            genericAHUBus annotation (Placement(transformation(
          extent={{-18,82},{18,118}}),  iconTransformation(extent={{-14,108},{14,
            134}})));
  ModularAHU.RegisterModule
                 cooler(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal2,
    final m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    T_start=T_start,
    tau=tau,
    T_amb=T_amb)
    annotation (Dialog(enable=true, group="Cooler"),Placement(transformation(extent={{-58,-46},
            {-14,14}})));
  ModularAHU.RegisterModule
                 heater(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal2,
    final m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    T_start=T_start,
    tau=tau,
    T_amb=T_amb)
    annotation (Dialog(enable=true, group="Heater"),Placement(transformation(extent={{16,-46},
            {60,14}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium2)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}}),
        iconTransformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium2)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),
        iconTransformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare package Medium =
        Medium2)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}}),
        iconTransformation(extent={{10,-110},{30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium =
        Medium2)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{50,-110},{70,-90}}),
        iconTransformation(extent={{48,-110},{68,-90}})));
  Fluid.Actuators.Dampers.Exponential flapSup(
    redeclare package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final m_flow_nominal=m1_flow_nominal)
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium1)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium1)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(cooler.port_b1,heater. port_a1)
    annotation (Line(points={{-14,0.15385},{16,0.15385}},  color={0,127,255}));
  connect(cooler.port_a2,port_a2)  annotation (Line(points={{-58,-27.5385},{-64,
          -27.5385},{-64,-100},{-60,-100}},
                               color={0,127,255}));
  connect(cooler.port_b2,port_b2)  annotation (Line(points={{-14,-27.5385},{-14,
          -28},{-12,-28},{-12,-100},{-20,-100}},
                                         color={0,127,255}));
  connect(heater.port_a2,port_a3)  annotation (Line(points={{16,-27.5385},{16,
          -100},{20,-100}},                       color={0,127,255}));
  connect(heater.port_b2,port_b3)  annotation (Line(points={{60,-27.5385},{62,
          -27.5385},{62,-100},{60,-100}},                       color={0,127,255}));
  connect(cooler.registerBus, genericAHUBus.coolerBus) annotation (Line(
      points={{-57.78,-13.9231},{-76,-13.9231},{-76,-120},{194,-120},{194,
          100.09},{0.09,100.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heater.registerBus, genericAHUBus.heaterBus) annotation (Line(
      points={{16.22,-13.9231},{8,-13.9231},{8,-146},{192,-146},{192,134},{0.09,
          134},{0.09,100.09}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heater.port_b1, flapSup.port_a) annotation (Line(points={{60,0.153846},
          {64,0.153846},{64,0},{66,0}}, color={0,127,255}));
  connect(flapSup.y, genericAHUBus.flapSupSet) annotation (Line(points={{76,12},
          {76,100.09},{0.09,100.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(flapSup.y_actual, genericAHUBus.flapSupMea) annotation (Line(points={{
          81,7},{81,94},{0.09,94},{0.09,100.09}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(flapSup.port_b, port_b1)
    annotation (Line(points={{86,0},{102,0}}, color={0,127,255}));
  connect(cooler.port_a1, port_a1) annotation (Line(points={{-58,0.153846},{-80,
          0.153846},{-80,0},{-100,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end VentilationUnit;
