within AixLib.Fluid.Movers.Data.Fans;
record GenericFan "Generic Fan data"
  extends Generic(
    use_powerCharacteristic=false,
    speed_rpm_nominal=1000,
    power(V_flow={0,5}, P={0,5000}),
    pressure(V_flow={0,5}, dp={20000,15000}));
  annotation (
defaultComponentPrefixes="parameter",
defaultComponentName="per",
Documentation(info="<html>
<p>Generic fan data with constant efficiency.</p>
</html>",   revisions="<html>
<ul>
<li>Mai 06, 2021, by Alexander K&uuml;mpel:<br/>First implementation</li>
</ul>
</html>"));
end GenericFan;
