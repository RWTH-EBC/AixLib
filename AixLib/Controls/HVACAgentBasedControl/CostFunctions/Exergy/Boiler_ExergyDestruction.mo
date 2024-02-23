within AixLib.Controls.HVACAgentBasedControl.CostFunctions.Exergy;
model Boiler_ExergyDestruction
  extends HVACAgentBasedControl.BaseClasses.PartialCostFunction;
  parameter Real T_0 = 298.15 "Exergy reference temperature";
  parameter Real eta = 0.84 "Overall efficiency of the boiler";

  Real m_flow "mass flow";

  Modelica.Blocks.Interfaces.RealInput T_in annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-10}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,-26})));
  Modelica.Blocks.Interfaces.RealInput T_out annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-50}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,26})));

equation
  m_flow = capacity/(4182*(T_out-T_in));
  cost= -capacity - (m_flow*T_0*4182*log(T_in/T_out)) + 0.9257 * capacity/eta;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={129,162,193},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-50,48},{46,-78}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="$"),
        Text(
          extent={{-60,94},{60,42}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Boiler")}),           Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html><h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span>
</h4>
<ul>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">This model determines
    the exergy destruction of a boiler based on the inputs of the
    component.</span>
  </li>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">It is used together with
    a HeatProducerAgent.</span>
  </li>
</ul>
<h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Concept</span>
</h4>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\"><img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/Boiler.png\"
  alt=\"Boiler\"></span>
</p>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\">The figure above shows the
  control volume for the boiler. Based on this volume the following
  function for exergy destruction has been developed. Details can be
  found in the reference.</span>
</p>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\"><img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/boilerCostfkt.PNG\"
  alt=\"Boiler cost function\"></span>
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<ul>
  <li>Felix Bünning. Development of a Modelica-library for agent-based
  control of HVAC systems. Bachelor thesis, 2016, RWTH Aachen
  University, Aachen, Germany.
  </li>
</ul>
<ul>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"));
end Boiler_ExergyDestruction;
