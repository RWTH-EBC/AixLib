within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Pumps;
model FluidSource
  extends Modelica.Icons.Example;

  Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));
  Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{60,-36},{82,-14}})));
  Modelica.Blocks.Sources.Constant dotm_source(k=2)
    annotation (Placement(transformation(extent={{-84,-52},{-64,-32}})));
  Modelica.Blocks.Sources.Constant T_source(k=333.15)
    annotation (Placement(transformation(extent={{-84,-22},{-64,-2}})));
equation
  connect(T_source.y, fluidSource.T_fluid) annotation (Line(
      points={{-63,-12},{-36,-12},{-36,-21.8},{-8,-21.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(fluidSource.enthalpyPort_b, vessel.enthalpyPort_a) annotation (Line(
      points={{10,-25},{63.3,-25}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(dotm_source.y, fluidSource.dotm) annotation (Line(
      points={{-63,-42},{-36,-42},{-36,-28.6},{-8,-28.6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Rectangle(
          extent={{40,40},{-42,-60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-22,30},{22,22}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          fontSize=10,
          textString="Fluid source model accepts real input values.
 The output connector creates a fluid with 
the properties temperature [K], mass flow 
rate [kg/s], specific heat capacity [J/kgK] 
and specific enthalpy [J/kg]"),
        Rectangle(
          extent={{100,100},{-100,70}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-72,88},{76,80}},
          lineColor={0,0,0},
          textString="Test fluid source model 
(inclusive vessel model and real input values)")}));
end FluidSource;
