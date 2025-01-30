within AixLib.Fluid.Examples.ERCBuilding.Control.SupervisoryControl;
model HeatingMode1

  AverageTemperatures CalcAvTemp_warm1(
    n=n_warm,
    bottom=false,
    top=true) annotation (Placement(transformation(extent={{-72,-51},{-46,
            -29}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=273.15
         + 30) annotation (Placement(transformation(extent={{-32,-46},{
            -20,-34}})));
  Modelica.Blocks.Logical.GreaterThreshold lessThreshold1(threshold=
        273.15 + 35) annotation (Placement(transformation(extent={{-32,
            -64},{-20,-52}})));
  Modelica.Blocks.Logical.GreaterThreshold lessThreshold2(threshold=
        273.15 + 6.5) annotation (Placement(transformation(extent={{-32,
            -96},{-20,-84}})));
  Modelica.Blocks.Logical.RSFlipFlop rSFlipFlop
    annotation (Placement(transformation(extent={{-4,-62},{16,-42}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{26,-51},{36,-41}})));
  parameter Integer n_warm = 5
    "number of discretization layers in heat storage";
  Modelica.Blocks.Interfaces.RealInput temperatures(
    final quantity="Temperature",
    final unit="K",
    min=0) annotation (Placement(transformation(rotation=0, extent={{
            -110,10},{-90,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput y annotation (Placement(
        transformation(rotation=0, extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(
        transformation(rotation=0, extent={{-110,-30},{-90,-10}})));
  Modelica.Blocks.Interfaces.RealInput u2 annotation (Placement(
        transformation(rotation=0, extent={{-110,-90},{-90,-70}})));
equation
  connect(CalcAvTemp_warm1.averageTemperature,lessThreshold. u) annotation (
      Line(
      points={{-46,-40},{-33.2,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(lessThreshold.y, rSFlipFlop.S) annotation (Line(
      points={{-19.4,-40},{-12,-40},{-12,-46},{-6,-46}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lessThreshold1.y, rSFlipFlop.R) annotation (Line(
      points={{-19.4,-58},{-6,-58}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(rSFlipFlop.Q, and1.u1) annotation (Line(
      points={{17,-46},{25,-46}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(lessThreshold2.y, and1.u2) annotation (Line(
      points={{-19.4,-90},{22,-90},{22,-50},{25,-50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(temperatures, CalcAvTemp_warm1.temperatures) annotation (Line(
        points={{-100,20},{-86,20},{-86,-40},{-72,-40}}, color={0,0,127}));
  connect(y, and1.y) annotation (Line(points={{100,0},{68,0},{68,-46},{
          36.5,-46}}, color={255,0,255}));
  connect(u1, lessThreshold1.u) annotation (Line(points={{-100,-20},{
          -66,-20},{-66,-58},{-33.2,-58}}, color={0,0,127}));
  connect(u2, lessThreshold2.u) annotation (Line(points={{-100,-80},{
          -66,-80},{-66,-90},{-33.2,-90}}, color={0,0,127}));

          annotation (
  Documentation(info="<html><p>
  <b>HeatingMode</b>
</p>When the HeatingMode is activated by a incomming transition it is
controlled wether the average temperature of the upper two tmeperature
sensors in the hot storage is below a limit value. If this is the case
and the evaporater temperatur is above the limite values the heatpump
is switched on in heatingMode. It remains there still the temperature
at the lowest temperature sensor in the hot storage reaches a limit
value.
</html>"));
end HeatingMode1;
