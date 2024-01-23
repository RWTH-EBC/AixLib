within AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn;
model IdealSinkHeatInputTemperature
  "Demand node as an ideal sink without return flow, using input connector"
  extends
    AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.NoReturn.PartialDemand(
    redeclare AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.SubstationDirectThrough substation);

  parameter Modelica.SIunits.Temp_C T_return(
    displayUnit="°C")
    "Prescribed temperature of return line after substation's heat exchanger";

  Modelica.Blocks.Math.Gain changeSign(k=-1)
    "Changes sign of prescribed flow for extraction from network" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,74})));

  Modelica.Blocks.Interfaces.RealInput Q_flow_input
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Modelica.Blocks.Math.Add deltaT(k2=-1)
    "Differernce of flow and return line temperature in K" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,50})));
  Modelica.Blocks.Math.Division heat2massFlow
    annotation (Placement(transformation(extent={{20,64},{40,84}})));
  Modelica.Blocks.Math.Gain gain(k=cp_default)
    annotation (Placement(transformation(extent={{-12,58},{8,78}})));
  Modelica.Blocks.Sources.Constant temperatureReturn(k=T_return)
    "Temperature of return line in °C"
    annotation (Placement(transformation(extent={{20,20},{0,40}})));
  Modelica.Blocks.Interfaces.RealOutput p_out
    annotation (Placement(transformation(extent={{100,80},{80,100}}),
        iconTransformation(extent={{80,40},{120,80}})));
equation

  connect(changeSign.y, sink.m_flow_in) annotation (Line(points={{81,74},{84,74},
          {84,8},{70,8}},  color={0,0,127}));
  connect(senT_supply.T, deltaT.u1) annotation (Line(points={{-50,11},{-50,20},{
          -36,20},{-36,38}}, color={0,0,127}));
  connect(deltaT.y, gain.u)
    annotation (Line(points={{-30,61},{-30,68},{-14,68}}, color={0,0,127}));
  connect(Q_flow_input, heat2massFlow.u1)
    annotation (Line(points={{-108,80},{18,80}}, color={0,0,127}));
  connect(gain.y, heat2massFlow.u2)
    annotation (Line(points={{9,68},{18,68}}, color={0,0,127}));
  connect(heat2massFlow.y, changeSign.u)
    annotation (Line(points={{41,74},{58,74}}, color={0,0,127}));
  connect(temperatureReturn.y, deltaT.u2)
    annotation (Line(points={{-1,30},{-24,30},{-24,38}}, color={0,0,127}));
  connect(senPre_supply.p, p_out) annotation (Line(points={{-69,20},{-66,20},{-66,
          90},{90,90}},   color={0,0,127}));
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
</html>", revisions="<html>
<ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end IdealSinkHeatInputTemperature;
