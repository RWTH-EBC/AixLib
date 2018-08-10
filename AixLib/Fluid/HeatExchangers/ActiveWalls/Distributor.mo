within AixLib.Fluid.HeatExchangers.ActiveWalls;
model Distributor
replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"                                                                  annotation(Dialog(group="Medium"),choicesAllMatching=true);

  Modelica.Fluid.Interfaces.FluidPort_a MAIN_FLOW(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-112,10},{-92,30}})));
  Modelica.Fluid.Interfaces.FluidPort_b MAIN_RETURN(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_b Flow_1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-72,40},{-52,60}})));
  Modelica.Fluid.Interfaces.FluidPort_b Flow_2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Fluid.Interfaces.FluidPort_b Flow_3(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-8,40},{12,60}})));
  Modelica.Fluid.Interfaces.FluidPort_b Flow_4(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{22,40},{42,60}})));
  Modelica.Fluid.Interfaces.FluidPort_b Flow_5(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{54,40},{74,60}})));
  Modelica.Fluid.Interfaces.FluidPort_b Flow_6(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{82,40},{102,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a Return_1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-72,-62},{-52,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_a Return_2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-40,-62},{-20,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_a Return_3(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-8,-62},{12,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_a Return_4(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{22,-62},{42,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_a Return_5(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{52,-62},{72,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_a Return_6(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{78,-62},{98,-42}})));
  Modelica.Fluid.Vessels.ClosedVolume volume(
    redeclare package Medium = Medium,
    use_portsData=false,
    V=0.001,
    nPorts=7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-72,10})));
  Modelica.Fluid.Vessels.ClosedVolume volume1(
    redeclare package Medium = Medium,
    use_portsData=false,
    V=0.001,
    nPorts=7) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-72,-10})));
equation
  connect(MAIN_RETURN, volume1.ports[1]) annotation (Line(
      points={{-100,-20},{-75.4286,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(MAIN_FLOW, volume.ports[1]) annotation (Line(
      points={{-102,20},{-68.5714,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume.ports[2], Flow_1) annotation (Line(
      points={{-69.7143,20},{-62,20},{-62,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume.ports[3], Flow_2) annotation (Line(
      points={{-70.8571,20},{-30,20},{-30,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume.ports[4], Flow_3) annotation (Line(
      points={{-72,20},{2,20},{2,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume.ports[5], Flow_4) annotation (Line(
      points={{-73.1429,20},{32,20},{32,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume.ports[6], Flow_5) annotation (Line(
      points={{-74.2857,20},{63.8572,20},{63.8572,50},{64,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume.ports[7], Flow_6) annotation (Line(
      points={{-75.4286,20},{90,20},{90,50},{92,50}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1.ports[2], Return_6) annotation (Line(
      points={{-74.2857,-20},{-74.2857,-28},{88,-28},{88,-52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1.ports[3], Return_5) annotation (Line(
      points={{-73.1429,-20},{-73.1429,-28},{62,-28},{62,-52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1.ports[4], Return_4) annotation (Line(
      points={{-72,-20},{-72,-28},{32,-28},{32,-52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1.ports[5], Return_3) annotation (Line(
      points={{-70.8571,-20},{-70.8571,-28},{4,-28},{4,-52},{2,-52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1.ports[6], Return_2) annotation (Line(
      points={{-69.7143,-20},{-69.7143,-28},{-30,-28},{-30,-52}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume1.ports[7], Return_1) annotation (Line(
      points={{-68.5714,-20},{-74,-20},{-74,-28},{-62,-28},{-62,-52}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -50},{100,50}}),
                      graphics), Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-50},{100,50}}), graphics={
        Line(
          points={{-98,20},{94,20},{98,20}},
          color={255,0,0},
          smooth=Smooth.None,
          thickness=5),
        Line(
          points={{-62,46},{-62,20}},
          color={255,0,0},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{-30,46},{-30,20}},
          color={255,0,0},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{2,46},{2,20}},
          color={255,0,0},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{32,46},{32,20}},
          color={255,0,0},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{64,46},{64,20}},
          color={255,0,0},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{92,42},{92,20}},
          color={255,0,0},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{-62,-18},{-62,-44}},
          color={0,0,255},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{-98,-20},{94,-20},{98,-20}},
          color={0,0,255},
          smooth=Smooth.None,
          thickness=5),
        Line(
          points={{-30,-20},{-30,-46}},
          color={0,0,255},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{2,-20},{2,-46}},
          color={0,0,255},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{34,-22},{34,-48}},
          color={0,0,255},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{62,-22},{62,-48}},
          color={0,0,255},
          thickness=4,
          smooth=Smooth.None),
        Line(
          points={{88,-20},{88,-46}},
          color={0,0,255},
          thickness=4,
          smooth=Smooth.None)}),
    Documentation(revisions="<html>
<ul>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>",
        info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a contributor for different floor heating circuits in a house.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The contributor is built to connect six floor heating circuits together. The volume is used for nummerical reasons, to have a point where all the flows mix together. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test\">AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test</a></p>
</html>"));
end Distributor;
