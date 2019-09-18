within AixLib.Systems.EONERC_MainBuilding;
model HighTemperatureSystem
  "High temperature generation system of the E.ON ERC main building"
   replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);
  Fluid.MixingVolumes.HydraulicSeparator hydraulicSeparator(
    m_flow_nominal=1,
    pumpMaxVolumeFlow=0.01,
    DFlange=0.1)
    annotation (Placement(transformation(extent={{60,28},{86,56}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_secondary1
                       "Top-flange secondary circuit"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_secondary1
                       "Bottom-flange secondary circuit"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  HydraulicModules.Admix admix2 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,3.55271e-15})));
  HydraulicModules.Admix admix1 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,3.55271e-15})));
  HydraulicModules.ThrottlePump throttlePump annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,3.55271e-15})));
equation
  connect(hydraulicSeparator.port_b_secondary, port_b_secondary1)
    annotation (Line(points={{86,49},{86,60},{100,60}}, color={0,127,255}));
  connect(hydraulicSeparator.port_a_secondary, port_a_secondary1)
    annotation (Line(points={{86,35},{86,20},{100,20}}, color={0,127,255}));
  connect(admix1.port_a1, hydraulicSeparator.port_b_primary)
    annotation (Line(points={{52,20},{52,35},{60,35}}, color={0,127,255}));
  connect(admix2.port_a1, hydraulicSeparator.port_b_primary)
    annotation (Line(points={{-8,20},{-8,35},{60,35}}, color={0,127,255}));
  connect(admix1.port_b2, hydraulicSeparator.port_a_primary)
    annotation (Line(points={{28,20},{28,49},{60,49}}, color={0,127,255}));
  connect(admix2.port_b2, hydraulicSeparator.port_a_primary)
    annotation (Line(points={{-32,20},{-32,49},{60,49}}, color={0,127,255}));
  connect(throttlePump.port_a1, hydraulicSeparator.port_b_primary)
    annotation (Line(points={{-68,20},{-68,35},{60,35}}, color={0,127,255}));
  connect(throttlePump.port_b2, hydraulicSeparator.port_a_primary)
    annotation (Line(points={{-92,20},{-92,49},{60,49}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighTemperatureSystem;
