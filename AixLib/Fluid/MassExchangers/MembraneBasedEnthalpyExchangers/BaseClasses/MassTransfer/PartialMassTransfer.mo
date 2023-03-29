within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.MassTransfer;
partial model PartialMassTransfer
  "Common interface for mass transfer models"

  // Parameters
  replaceable package Medium=Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
    annotation(Dialog(tab="Internal Interface",enable=false),
               choices(
                 choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
                 choice(redeclare package Medium = AixLib.Media.Water "Water"),
                 choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
                    property_T=293.15,
                    X_a=0.40)
                    "Propylene glycol water, 40% mass fraction")));

  parameter Integer n=1 "Number of heat transfer segments in x-Direction"
    annotation(Dialog(tab="Internal Interface",enable=false), Evaluate=true);

  // Inputs provided to heat transfer model
  input Medium.ThermodynamicState[n] states
    "Thermodynamic states of flow segments";

  input Modelica.Units.SI.Area[n] surfaceAreas "Heat transfer areas";

  // Outputs defined by heat transfer model
  output Modelica.Units.SI.MassFlowRate[n] m_flows "Mass flow rates";

  // Heat ports
  AixLib.Utilities.MassTransfer.MassPort[n] massPorts
    "Heat port to component boundary" annotation (Placement(transformation(
          extent={{-14,56},{14,84}}), iconTransformation(extent={{-16,54},{16,
            86}})));

  // Variables
  input Modelica.Units.SI.PartialPressure[n] ps "partial pressure at states";

equation
  m_flows =massPorts.m_flow;
  annotation (Documentation(info="<html><p>
  This component is a common interface for mass transfer models. The
  mass flow rates <code>m_flows[n]</code> through the boundaries of n
  flow segments are obtained as function of the thermodynamic
  <code>states</code> of the flow segments for a given fluid
  <code>Medium</code>, the <code>surfaceAreas[n]</code> and the
  boundary mass fractions <code>massPorts[n].X</code>.
</p>An extending model implementing this interface needs to define one
equation: the relation between the predefined fluid mass fractions
<code>Xs[n]</code>, the boundary mass fractions
<code>massPorts[n].X</code>, and the mass flow rates
<code>m_flows[n]</code>.
</html>", revisions="<html>
<ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"), Icon(graphics={           Rectangle(
            extent={{-80,60},{80,-60}},
            pattern=LinePattern.None,
            fillColor={0,140,72},
            fillPattern=FillPattern.HorizontalCylinder,
          lineColor={0,0,0}),                            Text(
            extent={{-40,22},{38,-18}},
            textString="%name")}));
end PartialMassTransfer;
