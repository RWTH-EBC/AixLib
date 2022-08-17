within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Valves;
model ThreeWayValve
  extends Modelica.Icons.Example;
  Components.Valves.ThreeWayValve threeWayValve
    annotation (Placement(transformation(extent={{-6,-6},{14,14}})));
  Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-58,-8},{-38,12}})));
  Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{74,-6},{94,14}})));
  Components.Sinks.Vessel vessel1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={8,-54})));
  Modelica.Blocks.Sources.Constant dotm(k=1.0)
    annotation (Placement(transformation(extent={{-94,-28},{-74,-8}})));
  Modelica.Blocks.Sources.Constant temp(k=293.15)
    annotation (Placement(transformation(extent={{-94,2},{-74,22}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=0.5,
    f=1/3600,
    offset=0.5)
    annotation (Placement(transformation(extent={{-36,44},{-16,64}})));
equation
  connect(vessel1.enthalpyPort_a, threeWayValve.enthalpyPort_b)
    annotation (Line(points={{8,-47},{6,-47},{6,-6},{4,-6}}, color={176,0,0}));
  connect(threeWayValve.enthalpyPort_a, vessel.enthalpyPort_a)
    annotation (Line(points={{14,4},{77,4}}, color={176,0,0}));
  connect(fluidSource.enthalpyPort_b, threeWayValve.enthalpyPort_ab)
    annotation (Line(points={{-38,3},{-38,4},{-5.8,4}}, color={176,0,0}));
  connect(temp.y, fluidSource.T_fluid) annotation (Line(points={{-73,12},{-66,
          12},{-66,6.2},{-56,6.2}}, color={0,0,127}));
  connect(dotm.y, fluidSource.dotm) annotation (Line(points={{-73,-18},{-73,-9},
          {-56,-9},{-56,-0.6}}, color={0,0,127}));
  connect(sine.y, threeWayValve.opening)
    annotation (Line(points={{-15,54},{4,54},{4,13}}, color={0,0,127}));
end ThreeWayValve;
