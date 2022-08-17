within AixLib.Controls.HVACAgentBasedControl.CostFunctions.Exergy;
model MixingValveAndHEX_ExergyDestruction
  extends HVACAgentBasedControl.BaseClasses.PartialCostFunction;
  parameter Real T_0 = 298.15 "Exergy reference temperature";
  parameter Real T_circuit_hot = 273.15+80
    "Temperature of the hot water circuit";
  parameter Real m_flow_hot = 0.2 "Mass flow in the hot temperature circuit";

  Real T1(start=271.15+40) "Inlet cold temperature";
  Real T2(start=273.15+40, fixed=true) "Outlet cold temperature";
  Real T3(start=273.15+40) "Inlet hot temperature";
  Real T4(start=273.15+40) "Outlet hot temperature";
  Real m_flow_hot_actual(start=0.2);

  Modelica.Blocks.Interfaces.RealInput T_cold_in annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,10}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,30})));
  Modelica.Blocks.Interfaces.RealInput m_flow_cold annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-50}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,-32})));
equation

  m_flow_hot_actual = (capacity/4000)*m_flow_hot;
  T1 = T_cold_in;
  T2 = T1 + capacity/(m_flow_cold*4182);
  T3 = T_circuit_hot;
  T4 = T3 - capacity/(m_flow_hot*4182);

  cost = - (m_flow_cold * T_0 * 4182 * log( T1/T2)) - (m_flow_hot_actual * T_0 * 4182 * log(T3/T4));

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
          textString="HEX")}),              Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html><h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span>
</h4>
<ul>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">This model determines
    the exergy destruction of a mixing valve and a heat exchanger based
    on the inputs of the component.</span>
  </li>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">It is used together with
    an IntermediateAgent.</span>
  </li>
</ul>
<h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">Concept</span>
</h4>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\"><img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/HEX.png\"
  alt=\"Heat exchanger\"></span>
</p>
<p>
  <span style=\"font-family: MS Shell Dlg 2;\">The figure above shows the
  control volume for the mixing valve and heat exchanger. Based on this
  volume the following function for exergy destruction has been
  developed. Details can be found in the reference.</span>
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Controls/HVACAgentBasedControl/HEXCostfkt2.PNG\"
  alt=\"Heat excahnger cost function\">
</p>
<h4>
  <span style=
  \"font-family: MS Shell Dlg 2; color: #008000;\">References</span>
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
end MixingValveAndHEX_ExergyDestruction;
