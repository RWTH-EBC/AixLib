within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model FanSimple
  "model of a simple fan"
  extends Components.BaseClasses.PartialComponent;

  parameter Real eta = 0.7 "efficiency of fan";

  // variables
  Modelica.Units.SI.Power P_el
    "electrical power of fan";
  Modelica.Units.SI.HeatFlowRate Q_flow
    "heat flow rate added to air flow";

  // objects
  Modelica.Blocks.Interfaces.RealInput dpIn "Prescribed pressure rise"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,110})));
  Modelica.Blocks.Interfaces.RealOutput PelFan(
    final quantity="Power",
    final unit="W")
    "electrical power of fan"
    annotation (Placement(
        transformation(extent={{100,-90},{120,-70}}), iconTransformation(extent={{100,-90},
            {120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput temIncFan(
    final quantity="ThermodynamicTemperatureDifference",
    final unit="K")
    "temperature increase over fan"
    annotation (Placement(
        transformation(extent={{100,-50},{120,-30}}), iconTransformation(extent
          ={{100,-60},{120,-40}})));
equation
  // mass balance
  mAirIn_flow - mAirOut_flow = 0;
  mDryAirIn_flow - mDryAirOut_flow = 0;
  mDryAirIn_flow * (1 + XAirIn) = mAirIn_flow;
  XAirIn = XAirOut;

  // Power of fan
  P_el = mAirIn_flow / rhoAir * dpIn / eta;
  PelFan = P_el;

  // heat added to air
  Q_flow = P_el;

  // energy balance
  Q_flow = mDryAirOut_flow * hAirOut - mDryAirIn_flow * hAirIn;

  // temperature increase
  temIncFan = TAirOut - TAirIn;

  dp = dpIn;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-50,62},{78,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-48,-64},{78,-20}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>April, 2020 by Martin Kremer:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end FanSimple;
