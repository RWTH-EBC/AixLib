within AixLib.Fluid.HeatGenerators;
model HeatGeneratorNoControl
  extends AixLib.Fluid.HeatGenerators.BaseClasses.PartialHeatGenerator(
      pressureDrop(
             a=coeffPresLoss),                                         vol(V=V));
  Modelica.Blocks.Interfaces.RealInput Q_flow
    annotation (Placement(transformation(extent={{-100,40},{-60,80}}),
        iconTransformation(extent={{-100,40},{-60,80}})));
  Modelica.Blocks.Interfaces.RealOutput Tcold
    "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{44,76},{64,96}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,90})));
  Modelica.Blocks.Interfaces.RealOutput Thot "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,50},{120,70}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,90})));
  Modelica.Blocks.Interfaces.RealOutput massFlow
    "Mass flow rate from port_a to port_b"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,90})));
  parameter Modelica.SIunits.Volume V=0.002
    "Volume of the heat exchanger inside the heat generator";
  parameter Real coeffPresLoss=1e10 "Pressure loss coefficient of the heat generator";
equation
  connect(heater.Q_flow, Q_flow) annotation (Line(points={{-60,-40},{-60,-40},{
          -60,60},{-80,60}},
                          color={0,0,127}));
  connect(senTCold.T, Tcold) annotation (Line(points={{-70,-69},{-70,-69},{-70,
          86},{54,86}},
                     color={0,0,127}));
  connect(senTHot.T, Thot) annotation (Line(points={{40,-69},{40,-69},{40,60},{110,
          60}}, color={0,0,127}));
  connect(senMasFlo.m_flow, massFlow) annotation (Line(points={{70,-69},{70,-69},
          {70,40},{110,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The model uses the <a href=\"HVAC.Components.HeatGenerators.BaseClasses.PartialHeatGenerator\">PartialHeatGenerator</a>
in the most simple setup in order either test its functionalities or to use in cases where
the controller is modelled outside the heat generator.
</p>
</html>",
        revisions="<html>
<p><ul>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>First implementation</li>
</ul></p>
</html>"));
end HeatGeneratorNoControl;
