within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.HeatTransfer;
partial model PartialHeatTransfer
  "Common interface for heat transfer models"

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
  output Modelica.Units.SI.HeatFlowRate[n] Q_flows "Heat flow rates";

  // Heat ports
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[n] heatPorts
    "Heat port to component boundary" annotation (Placement(transformation(
          extent={{-10,60},{10,80}}), iconTransformation(extent={{-10,60},{10,80}})));

  // Variables
  Modelica.Units.SI.Temperature[n] Ts=Medium.temperature(states)
    "Temperature at states";
equation
  Q_flows =heatPorts.Q_flow;
  annotation (Documentation(info="<html><p>
  This component is a common interface for heat transfer models. The
  heat flow rates <code>Q_flows[n]</code> through the boundaries of n
  flow segments are obtained as function of the thermodynamic
  <code>states</code> of the flow segments for a given fluid
  <code>Medium</code>, the <code>surfaceAreas[n]</code> and the
  boundary temperatures <code>heatPorts[n].T</code>.
</p>
<p>
  The heat loss coefficient <code>k</code> can be used to model a
  thermal isolation between <code>heatPorts.T</code> and
  <code>T_ambient</code>.
</p>
<p>
  An extending model implementing this interface needs to define one
  equation: the relation between the predefined fluid temperatures
  <code>Ts[n]</code>, the boundary temperatures
  <code>heatPorts[n].T</code>, and the heat flow rates
  <code>Q_flows[n]</code>.
</p>
</html>", revisions="<html>
<ul>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"),
         Icon(graphics={             Rectangle(
            extent={{-80,60},{80,-60}},
            pattern=LinePattern.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.HorizontalCylinder), Text(
            extent={{-40,22},{38,-18}},
            textString="%name")}));
end PartialHeatTransfer;
