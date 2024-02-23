within AixLib.Controls.HVACAgentBasedControl.CostFunctions.Exergy;
model MixingValveAndHEX_ExergyDestruction_Simplified
  extends HVACAgentBasedControl.BaseClasses.PartialCostFunction;
  parameter Real T_0 = 298.15 "Exergy reference temperature";
  Real T_hot(start=273.15+90) "Hot temperature";
  Real T_cold(start=273.15+50) "Cold temperature";

  Modelica.Blocks.Interfaces.RealInput T_cold_in annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,10}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,30})));
  Modelica.Blocks.Interfaces.RealInput T_hot_in annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-70}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,-70})));
  Modelica.Blocks.Interfaces.RealInput T_cold_out
                                                 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,50}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,78})));
  Modelica.Blocks.Interfaces.RealInput T_hot_out
                                                annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-30}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,-20})));
equation

  T_hot= (T_hot_in+T_hot_out)/2;
  T_cold= (T_cold_in+T_cold_out)/2;
  cost = capacity*(1-T_0/T_hot)-capacity*(1-T_0/T_cold);
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
    Documentation(revisions="<html><ul>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
  <li>December 2016, by Roozbeh Sangi:<br/>
    revised
  </li>
</ul>
</html>",
    info="<html><h4>
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
  <span style=\"font-family: MS Shell Dlg 2;\">Instead of a calculation
  with the help of inflowing and outflowing enthaplies, this cost
  function calculates the exergy product based on a heat flux. The
  estimation of the average temperature of the heat flux causes a small
  uncertainty compared to the other approach. However, this cost
  function leads to a more stable and reliable simulation. Details can
  be found in the reference.</span>
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
</html>"));
end MixingValveAndHEX_ExergyDestruction_Simplified;
