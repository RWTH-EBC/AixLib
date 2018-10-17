within AixLib.Utilities.Sources.InternalGains.Machines;
model Machines_simple
  "Heat source with convective and radiative component and connector for power input signal."
  extends BaseClasses.PartialInternalGain(RadiativeHeat(T_ref=T0));
  parameter Modelica.SIunits.Area SurfaceArea_Machines=2
    "surface area of radiative heat source";
  parameter Real Emissivity_Machines = 0.98;

  Utilities.HeatTransfer.HeatToStar
                                  RadiationConvertor(
                              eps=Emissivity_Machines, A=max(1e-4,
        SurfaceArea_Machines))
    annotation (Placement(transformation(extent={{52,-70},{72,-50}})));
equation
  connect(RadiativeHeat.port, RadiationConvertor.Therm) annotation (Line(
      points={{40,-10},{40,-60},{52.8,-60}},
      color={191,0,0}));
  connect(RadiationConvertor.Star, RadHeat) annotation (Line(
      points={{71.1,-60},{90,-60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(Schedule, gain.u) annotation (Line(
      points={{-100,0},{-60,0},{-60,30},{3.2,30}},
      color={0,0,127}));
  connect(Schedule, gain1.u) annotation (Line(
      points={{-100,0},{-60,0},{-60,-10},{3.2,-10}},
      color={0,0,127}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-60,60},{60,-38}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-56,56},{56,-34}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-90,-86},{-58,-42},{60,-42},{98,-86},{-90,-86}},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,-48},{-46,-54}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-42,-48},{-34,-54}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-30,-48},{-22,-54}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-18,-48},{-10,-54}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-6,-48},{2,-54}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{6,-48},{14,-54}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{18,-48},{26,-54}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{30,-48},{38,-54}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{42,-48},{50,-54}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-62,-58},{-54,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-50,-58},{-42,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-38,-58},{-30,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-26,-58},{-18,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-14,-58},{-6,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-2,-58},{6,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{10,-58},{18,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{22,-58},{30,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{34,-58},{42,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{46,-58},{54,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{58,-58},{66,-64}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-72,-68},{-64,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-60,-68},{-52,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-48,-68},{-40,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-36,-68},{-28,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-24,-68},{-16,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-12,-68},{-4,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{0,-68},{8,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{12,-68},{20,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{24,-68},{32,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{36,-68},{44,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{48,-68},{56,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{60,-68},{68,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{72,-68},{80,-74}},
          pattern=LinePattern.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Text(
          extent={{-54,30},{58,-8}},
          lineColor={255,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="simple")}),    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Heat source with convective and radiative component. The load is determined by a power input signal. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The input signal can take values from 0 to an arbitrary maximum value. </p>
<h4><span style=\"color:#008000\">Known limitation</span></h4>
<p>The parameter A cannot be set by default since other models must be able to implement their own equations for A. For example in the model <a href=\"Building.Components.Sources.InternalGains.Machines.Machines_Avar\">Machines_Avar</a> a changing radiative area is implemented.</p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>The surface for radiation exchange is computed from the schedule, which leads to a surface area of zero, when no activity takes place. In particular cases this might lead to an error as depending of the rest of the system a division by this surface will be introduced in the system of equations -&gt; division by zero. For this reason a lower limitation of 1e-4 m2 has been introduced.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Building.Examples.Sources.InternalGains.Machines\">AixLib.Building.Examples.Sources.InternalGains.Machines </a></p>
</html>",
    revisions="<html>
<ul>
<li><i>October 21, 2014&nbsp;</i> by Ana Constantin:<br/>Added a lower positive limit to the surface area, so it will not lead to a division by zero</li>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>"));
end Machines_simple;
