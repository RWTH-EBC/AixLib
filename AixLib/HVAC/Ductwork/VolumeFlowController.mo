within AixLib.HVAC.Ductwork;
model VolumeFlowController

extends BaseClasses.SimplePressureLoss;
  outer BaseParameters baseParameters annotation (Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics), Icon(graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={170,255,255},
                fillPattern=FillPattern.HorizontalCylinder)}));

  Modelica.Blocks.Sources.RealExpression Volumeflow(y=Volflow)
    annotation (Placement(transformation(extent={{-88,-38},{-56,-6}})));
  Modelica.Blocks.Interfaces.RealInput VolumeFlowSet
    annotation (Placement(transformation(extent={{-126,4},{-90,38}})));

Real angle "current angle of Flap";

  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=0,
    yMin=-90,
    k=100,
    Ti=20,
    Td=1)  annotation (Placement(transformation(extent={{-22,2},{16,40}})));
equation
  angle = -PID.y;
  zeta_var = 0.25*exp(0.1*angle);
  connect(VolumeFlowSet, PID.u_s) annotation (Line(
      points={{-108,21},{-25.8,21}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID.u_m, Volumeflow.y) annotation (Line(
      points={{-3,-1.8},{-3,-22},{-54.4,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -50},{100,50}}),   graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-50},{100,50}}), graphics={
        Rectangle(
          extent={{-100,50},{100,-50}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,4},{4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.Solid),
        Line(
          points={{26,40},{-28,-40},{-28,-40}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-68,0},{-30,0}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled})}),    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Volume Flow Controler which is based on a PI controller</p>
<p>The Controller Influences the zeta-value of the component.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Ductwork.Examples.VolumeFlowController\">AixLib.HVAC.Ductwork.Examples.VolumeFlowController</a> </p>
</html>", revisions="<html>
<p>30.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,
            40}}),
            graphics));
end VolumeFlowController;
