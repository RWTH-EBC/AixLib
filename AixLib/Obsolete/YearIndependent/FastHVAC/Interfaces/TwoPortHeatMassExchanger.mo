within AixLib.Obsolete.YearIndependent.FastHVAC.Interfaces;
model TwoPortHeatMassExchanger
  "Model transporting one enthalpy stream with storing mass or energy"
  parameter Modelica.Media.Interfaces.Types.Temperature T_start = workingFluid.T0;
  parameter Modelica.Units.SI.Mass m_fluid "Mass of working fluid";
  parameter Media.BaseClasses.MediumSimple medium=
      AixLib.Obsolete.YearIndependent.FastHVAC.Media.WaterSimple()
    "Mediums charastics (heat capacity, density, thermal conductivity)";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_small(min=0) = 1E-4*abs(
    m_flow_nominal) "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));
  final parameter Modelica.Units.SI.MassFlowRate m_flow_start=0
    "Start value for m_flow, used to avoid a warning if not set in m_flow, and to avoid m_flow.start in parameter window";
  Modelica.Units.SI.MassFlowRate m_flow(start=m_flow_start) = enthalpyPort_a.m_flow
    "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
    Interfaces.EnthalpyPort_a             enthalpyPort_a
    "FastHVAC connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-104,-4},{-96,4}})));
    Interfaces.EnthalpyPort_b             enthalpyPort_b
    "FastHVAC connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{104,-4},{96,4}})));
    BaseClasses.WorkingFluid workingFluid(m_fluid=m_fluid, medium=medium, T0=T_start)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,0})));
equation
  connect(workingFluid.enthalpyPort_b, enthalpyPort_b)
    annotation (Line(points={{9,0},{100,0}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_a, enthalpyPort_a)
    annotation (Line(points={{-9,0},{-100,0}}, color={176,0,0}));
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{-70,60},{70,-60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-101,5},{100,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-4},{100,5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
   Documentation(info="<html><p>
  This component transports one fluid stream.<br/>
  It is based on the Fluid model <a href=
  \"modelica://AixLib.Fluid.Interfaces.TwoPortHeatMassExchanger\">AixLib.Fluid.Interfaces.TwoPortHeatMassExchanger</a>
  and was adapted to the FastHVAC library.
</p>
<ul>
  <li>
    <i>January 22, 2019&#160;</i> Niklas Hülsenbeck:<br/>
    Moved into AixLib
  </li>
</ul>
</html>"));
end TwoPortHeatMassExchanger;
