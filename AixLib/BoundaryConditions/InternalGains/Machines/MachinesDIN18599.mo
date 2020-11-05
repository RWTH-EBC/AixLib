within AixLib.BoundaryConditions.InternalGains.Machines;
model MachinesDIN18599 "Heat flow due to machines based on DIN 18599 (number of people and activity type of machines)"
  extends BaseClasses.PartialInternalGain(
    emissivity=0.98,
    productHeatOutput(nu=2),
    gain(final k=nrPeople),
    gainSurfaces(final k=areaSurfaceMachinesTotal));

  parameter Integer activityType=2 "Machine activity" annotation(Dialog( compact = true, descriptionLabel = true), choices(choice=1 "low", choice = 2 "middle",  choice = 3 "high", radioButtons = true));
  parameter Real nrPeople=1.0 "Number of people with machines"  annotation(Dialog(descriptionLabel = true));
  parameter Modelica.SIunits.Area areaSurfaceMachinesTotal=max(
   1e-4, surfaceMachine*nrPeople)
   "Total surface area of all machines (radiative heat source) (for a room in a single-family hous e.g. 2 m2)";

protected
  parameter Modelica.SIunits.Area surfaceMachine = 2.0 "Surface area of one machine";
  Modelica.Blocks.Tables.CombiTable1D tableHeatOutput(
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    tableOnFile=false,
    table=[1,50; 2,100; 3,150],
    columns={2})
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.Constant activity(k=activityType)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
equation
  connect(activity.y, tableHeatOutput.u[1]) annotation (Line(points={{-69,50},{-62,50}}, color={0,0,127}));
  connect(tableHeatOutput.y[1], productHeatOutput.u[2]) annotation (Line(points={{-39,50},{-30,50},{-30,0},{-20,0}}, color={0,0,127}));
  annotation (Icon(graphics={
        Text(
          extent={{-40,-20},{44,-62}},
          lineColor={255,255,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          textString="ERC"),
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
        Text(
          extent={{-58,30},{58,-10}},
          lineColor={255,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="DIN")}),    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Heat source with convective and radiative component. The load is
  determined by a schedule and the type of activity.
</p>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The schedule sets the times when the machines are used. They tend to
  be used more when people are present in the room, and go on stand-by
  when people are absent from the room.
</p>
<p>
  The schedule describes the machines corresponding to only one person,
  and can take values from 0 to 1. For more people, a factor,
  <b>nrPeople</b>, is provided as parameter.
</p>
<p>
  The type of activity determines the load for machines in the room for
  one person according to DIN 18599-10. The following values are used:
</p>
<table summary=\"DIN 18599-10 activity level and produces heat output\"
cellspacing=\"2\" cellpadding=\"0\" border=\"0\">
  <tr>
    <td style=\"background-color: #dcdcdc\">
      Activity Type
    </td>
    <td style=\"background-color: #dcdcdc\">
      Heat Load [W]
    </td>
  </tr>
  <tr>
    <td>
      <p>
        1
      </p>
    </td>
    <td>
      <p>
        50
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        2
      </p>
    </td>
    <td>
      <p>
        100
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        3
      </p>
    </td>
    <td>
      <p>
        150
      </p>
    </td>
  </tr>
</table>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  DIN 18599-10
</p>
</html>",
    revisions="<html><ul>
  <li>
    <i>March 30, 2020</i> by Philipp Mehrfeld:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/886\">#886</a>:
    Summarize models to partial model. Make all models dependant from a
    relative input 0..1. Many refactorings.
  </li>
  <li>
    <i>October 19, 2016&#160;</i> by Ana Constantin:<br/>
    Corrected documentation to refer to machines directly
  </li>
  <li>
    <i>October 21, 2014&#160;</i> by Ana Constantin:<br/>
    Added a lower positive limit to the surface area, so it will not
    lead to a division by zero
  </li>
  <li>
    <i>Mai 19, 2014&#160;</i> by Ana Constantin:<br/>
    Uses components from MSL and respects the naming conventions
  </li>
  <li>
    <i>May 07, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end MachinesDIN18599;
