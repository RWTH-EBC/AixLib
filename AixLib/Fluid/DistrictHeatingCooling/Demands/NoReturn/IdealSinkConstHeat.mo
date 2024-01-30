within AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn;
model IdealSinkConstHeat
  "Demand node as an ideal sink without return flow, using demand base class"
  extends
    AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.NoReturn.PartialDemand(
    redeclare AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.SubstationDirectThrough substation);

  parameter Modelica.Units.SI.HeatFlowRate prescribedQ
    "Prescribed heat flow rate, positive values are extracted from the network";

  parameter Modelica.Units.SI.TemperatureDifference dTDesign(
    displayUnit="K")
    "Design temperature difference for the substation's heat exchanger";

  Modelica.Blocks.Sources.Constant Q_flow_set(k=prescribedQ)
    "Set the value for constant heat flow rate"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Math.Gain changeSign(k=-1)
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
equation

  connect(changeSign.y, sink.m_flow_in) annotation (Line(points={{21,80},{84,80},
          {84,8},{72,8}},  color={0,0,127}));
  connect(heatToMassFlow.y, changeSign.u)
    annotation (Line(points={{-19,80},{-2,80}}, color={0,0,127}));
  connect(Q_flow_set.y, heatToMassFlow.u)
    annotation (Line(points={{-59,80},{-42,80}}, color={0,0,127}));
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
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end IdealSinkConstHeat;
