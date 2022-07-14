within AixLib.ThermalZones.ReducedOrder.Windows.Validation;
model SkylineShadowingTest
  extends Modelica.Icons.Example;

  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.SkylineShadowing
    skylineShadow(
    n=4,
    gap={false,true,false},
    deltaH={5,5,100,100},
    s={20,20,20,20},
    alpha={1.3962634015955,1.7453292519943,-1.3962634015955,-1.7453292519943})
    "Shadow due to buildings on the west and east side"
    annotation (Placement(transformation(extent={{28,-10},{48,10}})));

  Modelica.Blocks.Sources.Sine solAziSine(f=1, amplitude=Modelica.Constants.pi)
    "Solar azimuth input generated as sine"
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
equation
  connect(solAziSine.y, skylineShadow.solAzi)
    annotation (Line(points={{-27,0},{-27,0},{27,0}},color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    Documentation(revisions="<html><ul>
  <li>July 13, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>",
      info="<html>This is an example for the <a href=
\"Windows.BaseClasses.SkylineShadowing\">SkylineShadowing</a> model. It
simulates two buildings which shade the window. One smaller building is
on the east side and one bigger building on the west side. Between the
buildings there is a gap.&lt;\\p&gt;
</html>"));
end SkylineShadowingTest;
