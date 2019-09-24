within AixLib.Fluid.Examples.ERCBuilding.BaseClasses;
model SwitchingUnit

  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening
                                            HK13Y3(redeclare package Medium =
        Medium,
    m_flow_nominal=2,
    dpValve_nominal=6000)           annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={54,60})));

  AixLib.Fluid.Movers.FlowControlled_m_flow pumpColdCooler1(redeclare package
      Medium = Medium, m_flow_nominal=10,
    allowFlowReversal=false,
    addPowerToMedium=false)
    "Mass flow-controlled pump connecting CC to Glycol cooler" annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={130,20})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening
                                            HK13K3(redeclare package Medium =
        Medium,
    m_flow_nominal=2,
    dpValve_nominal=6000)           annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={100,44})));
   replaceable package Medium =
      AixLib.Media.Water;
  Modelica.Blocks.Interfaces.RealInput openingHK13K3 annotation (Placement(
        transformation(
        rotation=270,
        extent={{-10,-10},{10,10}},
        origin={110,140})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare final package Medium
      = Medium) annotation (Placement(transformation(rotation=0, extent={{90,-70},
            {110,-50}})));
  Modelica.Blocks.Interfaces.RealInput openingHK13Y2 annotation (Placement(
        transformation(
        rotation=270,
        extent={{-10,-10},{10,10}},
        origin={0,140})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare final package Medium
      = Medium) annotation (Placement(transformation(rotation=0, extent={{-10,-70},
            {10,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare final package Medium
      = Medium) annotation (Placement(transformation(rotation=0, extent={{-30,90},
            {-10,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare final package Medium
      = Medium) annotation (Placement(transformation(rotation=0, extent={{170,90},
            {190,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare final package Medium
      = Medium) annotation (Placement(transformation(rotation=0, extent={{170,10},
            {190,30}})));
  Modelica.Blocks.Interfaces.RealInput openingHK13Y3 annotation (Placement(
        transformation(
        rotation=270,
        extent={{-10,-10},{10,10}},
        origin={54,140})));
  Modelica.Blocks.Interfaces.RealInput massFlowHK13P3(
    final quantity="MassFlow",
    final unit="kg/s",
    min=0,
    max=30) annotation (Placement(transformation(
        rotation=270,
        extent={{-10,-10},{10,10}},
        origin={154,140})));
  AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance(
    redeclare package Medium = Medium,
    m_flow_nominal=5,
    dp_nominal=20000)
           annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={154,20})));

  Modelica.Blocks.Interfaces.RealInput openingHK13Y1 "valve opening"
    annotation (Placement(transformation(extent={{-29,-8},{-11,10}})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening
                                            HK13Y1(redeclare package Medium =
        Medium,
    m_flow_nominal=2,
    dpValve_nominal=6000)           annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,0})));
  AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening
                                            HK13Y2(redeclare package Medium =
        Medium,
    m_flow_nominal=2,
    dpValve_nominal=6000)           annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,40})));
equation
  connect(HK13Y3.port_b,HK13K3. port_a) annotation (Line(
      points={{60,60},{100,60},{100,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b, HK13K3.port_b)
    annotation (Line(points={{100,-60},{100,-12},{100,38}},
                                                  color={0,127,255}));
  connect(port_b2, HK13Y3.port_b) annotation (Line(points={{180,100},{68,100},{68,
          60},{60,60}}, color={0,127,255}));
  connect(massFlowHK13P3, pumpColdCooler1.m_flow_in) annotation (Line(
      points={{154,140},{154,118},{130,118},{130,27.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(port_b3, hydraulicResistance.port_b) annotation (Line(
      points={{180,20},{160,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(hydraulicResistance.port_a, pumpColdCooler1.port_b) annotation (Line(
      points={{148,20},{136,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(openingHK13Y3, HK13Y3.y) annotation (Line(
      points={{54,140},{54,67.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(openingHK13K3, HK13K3.y) annotation (Line(
      points={{110,140},{110,44},{107.2,44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HK13Y3.port_a, port_b1) annotation (Line(
      points={{48,60},{0,60},{0,100},{-20,100}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(openingHK13Y1, HK13Y1.y) annotation (Line(points={{-20,1},{-14,1},{-14,
          4.44089e-016},{-7.2,4.44089e-016}}, color={0,0,127}));
  connect(HK13Y1.port_a, port_a)
    annotation (Line(points={{-4.44089e-016,-6},{0,-6},{0,-60}},
                                                     color={0,127,255}));
  connect(HK13Y1.port_b, pumpColdCooler1.port_a)
    annotation (Line(points={{4.44089e-016,6},{4.44089e-016,20},{124,20}},
                                                     color={0,127,255}));
  connect(openingHK13Y2, HK13Y2.y) annotation (Line(points={{0,140},{0,120},{
          -10,120},{-10,40},{-7.2,40}}, color={0,0,127}));
  connect(HK13Y1.port_b, HK13Y2.port_a)
    annotation (Line(points={{0,6},{0,34}},        color={0,127,255}));
  connect(HK13Y2.port_b, port_b1)
    annotation (Line(points={{0,46},{0,100},{-20,100}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-20,-60},{180,140}},
          preserveAspectRatio=false)),           Icon(coordinateSystem(extent={{
            -20,-60},{180,140}}), graphics={Bitmap(extent={{-20,-66},{184,150}},
            fileName=
              "N:/Forschung/EBC0155_PTJ_Exergiebasierte_regelung_rsa/Students/Students-Exchange/Photos Dymola/Splitter.jpg"),
          Text(
          extent={{18,112},{156,-38}},
          lineColor={255,255,255},
          textString="Switching
Unit")}),
    Documentation(info="<html>
<p>Pump prevents flow reversal</p>
</html>"));
end SwitchingUnit;
