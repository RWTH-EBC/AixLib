within AixLib.Fluid.DistrictHeatingCooling.Pipes.BaseClassesStatic;
model StaticTransportDelay "Delay time for given current velocity"

  parameter Modelica.Units.SI.Length length "Pipe length";
  parameter Modelica.Units.SI.Length dh
    "Hydraulic diameter (assuming a round cross section area)";
  parameter Modelica.Units.SI.Density rho "Standard density of fluid";
  parameter Boolean initDelay=false
    "Initialize delay for a constant m_flow_start if true, otherwise start from 0"
    annotation (Dialog(group="Initialization"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_start=0
    "Initialization of mass flow rate to calculate initial time delay"
    annotation (Dialog(group="Initialization", enable=initDelay));

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

  final parameter Modelica.Units.SI.Time t_in_start=if initDelay and (abs(
      m_flow_start) > 1E-10*m_flow_nominal) then min(length/m_flow_start*(rho*
      dh^2/4*Modelica.Constants.pi), 0) else 0
    "Initial value of input time at inlet";
  final parameter Modelica.Units.SI.Time t_out_start=if initDelay and (abs(
      m_flow_start) > 1E-10*m_flow_nominal) then min(-length/m_flow_start*(rho*
      dh^2/4*Modelica.Constants.pi), 0) else 0
    "Initial value of input time at outlet";

  Modelica.Units.SI.Velocity velocity "Flow velocity within pipe";

  Modelica.Blocks.Interfaces.RealInput m_flow "Mass flow of fluid" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.RealOutput tau
    "Time delay for design flow direction"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput tauRev "Time delay for reverse flow"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));

equation
  velocity = abs(m_flow)/(rho*(dh^2)/4*Modelica.Constants.pi);

  tau = length*(
    AixLib.Utilities.Math.Functions.inverseXRegularized(
       x=velocity,
       delta=0.0001));
  tauRev = tau;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-92,0},{-80.7,34.2},{-73.5,53.1},{-67.1,66.4},{-61.4,74.6},{-55.8,
              79.1},{-50.2,79.8},{-44.6,76.6},{-38.9,69.7},{-33.3,59.4},{-26.9,44.1},
              {-18.83,21.2},{-1.9,-30.8},{5.3,-50.2},{11.7,-64.2},{17.3,-73.1},{
              23,-78.4},{28.6,-80},{34.2,-77.6},{39.9,-71.5},{45.5,-61.9},{51.9,
              -47.2},{60,-24.8},{68,0}},
          color={0,0,127},
          smooth=Smooth.Bezier),
        Line(points={{-64,0},{-52.7,34.2},{-45.5,53.1},{-39.1,66.4},{-33.4,74.6},
              {-27.8,79.1},{-22.2,79.8},{-16.6,76.6},{-10.9,69.7},{-5.3,59.4},{1.1,
              44.1},{9.17,21.2},{26.1,-30.8},{33.3,-50.2},{39.7,-64.2},{45.3,-73.1},
              {51,-78.4},{56.6,-80},{62.2,-77.6},{67.9,-71.5},{73.5,-61.9},{79.9,
              -47.2},{88,-24.8},{96,0}}, smooth=Smooth.Bezier),
        Text(
          extent={{20,100},{82,30}},
          lineColor={0,0,255},
          textString="static"),
        Text(
          extent={{-82,-30},{-20,-100}},
          lineColor={0,0,255},
          textString="tau"),
        Text(
          extent={{-100,140},{100,100}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(info="<html><p>
  This is a copy of the PlugFlowTransportDelay modified to react
  directly on the current velocity. This gives a static behavior
  similar to quasi-static DHC models for comparison. Note that this is
  only included for some legacy testing.
</p>
<ul>
  <li>Dec 8, 2017 by Marcus Fuchs:<br/>
    Temporarily re-introducing the static pipe model
  </li>
</ul>
</html>"));
end StaticTransportDelay;
