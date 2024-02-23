within AixLib.Controls.HVACAgentBasedControl.CostFunctions.Exergy;
model HeatingRod_ExergyDestruction
  extends HVACAgentBasedControl.BaseClasses.PartialCostFunction;
  parameter Real T_0 = 298.15 "Exergy reference temperature";
  parameter Real eta = 0.97 "Overall efficiency of the boiler";

  Real T_in "Inlet temperature";

  Modelica.Blocks.Interfaces.RealInput T_below
    "Temperature of the storage water layer below the heating rod"                                            annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-70}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,-22})));
  Modelica.Blocks.Interfaces.RealInput m_flow(start=0.5, fixed=true) annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-10}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,30})));

equation
  T_in = T_below;

  cost= -(m_flow*T_0*4182*log(T_in/(T_in+capacity/(4182*m_flow))));

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
          extent={{-64,94},{56,42}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Heating Rod")}),      Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html><h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span>
</h4>
<ul>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">This model determines
    the exergy destruction of a heating rod based on the inputs of the
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
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/HeatingRod.png\"
  alt=\"Heating rod\"></span>
</p>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\">The figure above shows the
  control volume for the heating rod. Based on this volume the
  following function for exergy destruction has been developed. Details
  can be found in the reference.</span>
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/heatingRodCostfkt.PNG\"
  alt=\"Heating rod cost function\">
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
</html>",
    revisions="<html><ul>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>"));
end HeatingRod_ExergyDestruction;
