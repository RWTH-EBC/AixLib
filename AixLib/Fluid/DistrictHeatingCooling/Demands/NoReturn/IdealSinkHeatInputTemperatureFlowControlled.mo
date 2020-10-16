within AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn;
model IdealSinkHeatInputTemperatureFlowControlled
  "Demand node as an ideal sink without return flow, using input connector. With input for set supply temperature."
  extends
    AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.NoReturn.PartialDemandFlowControlled(
    redeclare AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.SubstationDirectThrough substation);

  parameter Modelica.SIunits.Temp_C T_return(
    displayUnit="°C")
    "Prescribed temperature of return line after substation's heat exchanger";

  Modelica.Blocks.Interfaces.RealInput Q_flow_input
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Modelica.Blocks.Math.Add deltaT(k2=-1)
    "Differernce of flow and return line temperature in K" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-26,56})));
  Modelica.Blocks.Math.Division heat2massFlow
    annotation (Placement(transformation(extent={{36,64},{56,84}})));
  Modelica.Blocks.Math.Gain gain(k=cp_default)
    annotation (Placement(transformation(extent={{4,58},{24,78}})));
  Modelica.Blocks.Sources.Constant temperatureReturn(k=10)
    "Temperature of return line in °C"
    annotation (Placement(transformation(extent={{20,24},{0,44}})));
  Modelica.Blocks.Interfaces.RealOutput p_out
    annotation (Placement(transformation(extent={{100,80},{80,100}}),
        iconTransformation(extent={{80,40},{120,80}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-46,28},{-36,38}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=time > 3600)
    annotation (Placement(transformation(extent={{-64,24},{-54,40}})));
  Modelica.Blocks.Sources.Constant temperatureSupplyInitial(k=T_return + 10)
    "Initial temperature of supply line in °C"
    annotation (Placement(transformation(extent={{-62,48},{-52,58}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-51,21})));
equation

  connect(deltaT.y, gain.u)
    annotation (Line(points={{-26,67},{-26,68},{2,68}},   color={0,0,127}));
  connect(Q_flow_input, heat2massFlow.u1)
    annotation (Line(points={{-108,80},{34,80}}, color={0,0,127}));
  connect(gain.y, heat2massFlow.u2)
    annotation (Line(points={{25,68},{34,68}},color={0,0,127}));
  connect(temperatureReturn.y, deltaT.u2)
    annotation (Line(points={{-1,34},{-20,34},{-20,44}}, color={0,0,127}));
  connect(senPre_supply.p, p_out) annotation (Line(points={{-69,20},{-66,20},{-66,
          90},{90,90}},   color={0,0,127}));
  connect(heat2massFlow.y, sink.m_flow_in)
    annotation (Line(points={{57,74},{60,74},{60,12}}, color={0,0,127}));
  connect(switch1.y, deltaT.u1)
    annotation (Line(points={{-35.5,33},{-32,33},{-32,44}}, color={0,0,127}));
  connect(switch1.u2, booleanExpression.y) annotation (Line(points={{-47,33},{
          -54,33},{-54,32},{-53.5,32}}, color={255,0,255}));
  connect(senT_supply.T, fromKelvin.Kelvin)
    annotation (Line(points={{-50,11},{-50,15},{-51,15}}, color={0,0,127}));
  connect(temperatureSupplyInitial.y, switch1.u3) annotation (Line(points={{
          -51.5,53},{-50,53},{-50,29},{-47,29}}, color={0,0,127}));
  connect(fromKelvin.Celsius, switch1.u1)
    annotation (Line(points={{-51,26.5},{-51,37},{-47,37}}, color={0,0,127}));
  annotation (Icon(graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-86,38},{-86,-42},{-26,-2},{-86,38}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
                             Ellipse(
          extent={{-8,40},{72,-40}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-46,-32},{-6,-92}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html><p>
  This model implements a very simple demand node representation with
  only an ideal flow sink discharging an imported heat flow rate from
  the DHC system's supply network. <code>Q_flow_input</code> specifies
  the heat flow rate to be extracted from the network into the ideal
  sink depending on the difference between flow temperature and
  prescribded return temperature over the heat exchanger of the
  substation.
</p>
<ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end IdealSinkHeatInputTemperatureFlowControlled;
