within AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn;
model IdealSinkHeatInput
  "Demand node as an ideal sink without return flow, using input connector"
  extends
    AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.NoReturn.PartialDemand(
    redeclare AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.SubstationDirectThrough substation);

  parameter Boolean isHeating = true
    "Set to true for heating substation, false for cooling";

  parameter Modelica.SIunits.TemperatureDifference dTDesign(
    displayUnit="K")
    "Design temperature difference for the substation's heat exchanger";

  Modelica.Blocks.Math.Gain changeSign(k=if isHeating then -1 else 1)
    "Changes sign of prescribed flow for extraction from network" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,80})));
  Modelica.Blocks.Math.Gain heatToMassFlow(k=1/(dTDesign*cp_default))
    "Calculates mass flow rate based on design dT from heat demand" annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,80})));

  Modelica.Blocks.Interfaces.RealInput Q_flow_input
    annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
equation

  connect(changeSign.y, sink.m_flow_in) annotation (Line(points={{21,80},{84,80},
          {84,10},{70,8}}, color={0,0,127}));
  connect(heatToMassFlow.y, changeSign.u)
    annotation (Line(points={{-19,80},{-2,80}}, color={0,0,127}));
  connect(Q_flow_input, heatToMassFlow.u)
    annotation (Line(points={{-108,80},{-42,80}}, color={0,0,127}));
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
  only an ideal flow sink discharging a prescribed heat flow rate from
  the DHC system's supply network. The <code>prescribedQ</code>
  parameter specifies the heat flow rate to be extracted from the
  network into the ideal sink depending on the design temperature
  difference over the heat exchanger of the substation.
</p>
</html>", revisions="<html>
<ul>
  <li>January 29, 2018, by Marcus Fuchs:<br/>
    Add parameter <code>isHeating</code>.
  </li>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end IdealSinkHeatInput;
