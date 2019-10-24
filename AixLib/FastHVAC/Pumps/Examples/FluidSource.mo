within AixLib.FastHVAC.Pumps.Examples;
model FluidSource
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Constant dotm_source(k=2)
    annotation (Placement(transformation(extent={{-84,-52},{-64,-32}})));
  Modelica.Blocks.Sources.Constant T_source(k=333.15)
    annotation (Placement(transformation(extent={{-84,-22},{-64,-2}})));
  AixLib.FastHVAC.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-36,-34},{-16,-14}})));
  AixLib.FastHVAC.Pumps.FluidSource fluidSource1
    annotation (Placement(transformation(extent={{-40,-96},{-20,-76}})));
  Modelica.Blocks.Sources.Constant T_source1(k=310.15)
    annotation (Placement(transformation(extent={{-88,-84},{-68,-64}})));
  Modelica.Blocks.Sources.Constant dotm_source1(k=2)
    annotation (Placement(transformation(extent={{-88,-114},{-68,-94}})));
  Sinks.Vessel vessel2
    annotation (Placement(transformation(extent={{80,-18},{100,2}})));
  BaseClasses.WorkingFluid workingFluid(T0=293.15, m_fluid=1)
    annotation (Placement(transformation(extent={{-6,-34},{14,-14}})));
equation
  connect(T_source.y, fluidSource.T_fluid) annotation (Line(points={{-63,-12},{
          -48,-12},{-48,-19.8},{-34,-19.8}}, color={0,0,127}));
  connect(dotm_source.y, fluidSource.m_flow) annotation (Line(points={{-63,-42},
          {-50,-42},{-50,-26.6},{-34,-26.6}}, color={0,0,127}));
  connect(dotm_source1.y, fluidSource1.m_flow) annotation (Line(points={{-67,
          -104},{-54,-104},{-54,-88.6},{-38,-88.6}}, color={0,0,127}));
  connect(T_source1.y, fluidSource1.T_fluid) annotation (Line(points={{-67,-74},
          {-52,-74},{-52,-81.8},{-38,-81.8}}, color={0,0,127}));
  connect(fluidSource.enthalpyPort_b, workingFluid.enthalpyPort_a) annotation (
      Line(points={{-17,-22},{-12,-22},{-12,-24},{-5,-24}}, color={176,0,0}));
  connect(fluidSource1.enthalpyPort_b, workingFluid.enthalpyPort_a) annotation
    (Line(points={{-21,-84},{-14,-84},{-14,-24},{-5,-24}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b, vessel2.enthalpyPort_a) annotation (Line(
        points={{13,-24},{48,-24},{48,-8},{83,-8}}, color={176,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),      graphics={
        Rectangle(
          extent={{46,40},{-36,-60}},
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
