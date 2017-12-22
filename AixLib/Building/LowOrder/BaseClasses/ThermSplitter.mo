within AixLib.Building.LowOrder.BaseClasses;
model ThermSplitter
  "A simple model which weights a given set of therm inputs to calculate an average temperature or heat flow and the other way around"

parameter Integer dimension "Dimension of the splitter";

parameter Real splitFactor[dimension]= fill(1/dimension, dimension)
    "split factor for outputs (between 0 and 1)";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a signalInput
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a signalOutput[dimension]
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));

equation
  signalOutput.Q_flow = - splitFactor * signalInput.Q_flow
    "Connecting the output vector according to desired dimension";

  signalInput.T = signalOutput.T * splitFactor
    "Equivalent building temperature rerouted to SignalInput";

  annotation ( Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-2,4},{26,-30}},
          lineColor={255,0,0},
          textString="%",
          textStyle={TextStyle.Bold}),
        Line(
          points={{-80,0},{14,80},{14,80}},
          color={0,0,255}),
        Line(
          points={{-80,0},{18,48},{18,48}},
          color={0,0,255}),
        Line(
          points={{-80,0},{16,18},{16,18}},
          color={0,0,255}),
        Line(
          points={{-80,0},{12,-78},{12,-78}},
          color={0,0,255}),
        Line(
          points={{-80,0},{12,-46},{12,-46}},
          color={0,0,255}),
        Line(
          points={{-80,0},{12,-18},{12,-18}},
          color={0,0,255}),
        Text(
          extent={{-48,-82},{52,-100}},
          lineColor={0,0,255},
          textString="ThermSplitter")}),
    Documentation(info="<html>
<p>ThermSplitter is a simple model which weights a given set of therm inputs to calculate an average temperature or heat flow and the other way around</p>
<h4>Main equations</h4>
<p><img src=\"modelica://AixLib/Resources/Images/Building/LowOrder/BaseClasses/ThermSplitter/equation-ShHZPTo9.png\" alt=\"signalOutput.Q_flow = splitFactor .* (signalInput.Q_flow * unitvec) \"/></p>
<p><img src=\"modelica://AixLib/Resources/Images/Building/LowOrder/BaseClasses/ThermSplitter/equation-BtreVeqi.png\" alt=\"signalInput.T = sum(signalOutput.T * splitFactor) \"/></p>
<h4>Assumptions and limitations</h4>
<h4>Typical use and important parameters</h4>
<p>This model is used to weight therm ports according to given split factors.</p>
<p>The model needs the dimension of the splitted therm port and the split factors, which are between 0 and 1.</p>
<h4>Options</h4>
<h4>Validation</h4>
<h4>Implementation</h4>
<p>In ReducedOrderModelVDI and ReducedOrderModelEBCMod</p>
<h4>References</h4>
</html>", revisions="<html>
<ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
<li><i>January 2015,&nbsp;</i> by Peter Remmen:<br/>changed name and vectorized equation, added documentation</li>
</ul>
</html>"));
end ThermSplitter;
