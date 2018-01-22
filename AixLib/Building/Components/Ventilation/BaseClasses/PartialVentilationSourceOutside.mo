within AixLib.Building.Components.Ventilation.BaseClasses;
partial model PartialVentilationSourceOutside
  extends AixLib.Building.Components.Ventilation.BaseClasses.PartialVentilationOutside;
  Modelica.Fluid.Sources.MassFlowSource_T ventilationMassFlow(
    nPorts=1,
    redeclare package Medium = Medium,
    use_m_flow_in=true)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.RealExpression Realm_flow_eff(y=m_flow_eff)
    annotation (Placement(transformation(extent={{20,-2},{40,18}})));
  Modelica.SIunits.MassFlowRate m_flow_eff "effecitve mass flow";
  Real V_flow_eff(final unit="m3/h") "effecitve volume flow";
  Modelica.SIunits.Density d;
  Modelica.SIunits.Pressure ptot_ambient;
  Real dp_inPa(final unit="Pa");
equation
  d = Medium.density(state_b);
  ptot_ambient = WindDirectionPort * WindSpeedPort^2 * d / 2 + system.p_ambient;
  dp_inPa = ptot_ambient - port_b.p;
  V_flow_eff * d / 3600 = m_flow_eff;
  connect(ventilationMassFlow.ports[1], port_b) annotation (Line(points={{80,0},
          {92,0},{92,0},{100,0}}, color={0,127,255}));
  connect(ventilationMassFlow.m_flow_in, Realm_flow_eff.y)
    annotation (Line(points={{60,8},{41,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialVentilationSourceOutside;
