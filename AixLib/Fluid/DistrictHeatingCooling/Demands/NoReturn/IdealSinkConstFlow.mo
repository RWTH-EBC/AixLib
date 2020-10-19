within AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn;
model IdealSinkConstFlow
  "Demand node as an ideal sink without return flow, using demand base class"
  extends
    AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Demands.NoReturn.PartialDemand(
    redeclare AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.SubstationDirectThrough substation);

  parameter Modelica.SIunits.MassFlowRate prescribed_m_flow
    "Prescribed mass flow rate, positive values are discharged from the network";

  Modelica.Blocks.Sources.Constant m_flow_set(k=prescribed_m_flow)
    "Set the value for constant mass flow rate"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Math.Gain changeSign(k=-1)
    "Changes sign of prescribed flow for extraction from network" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,80})));
equation

  connect(m_flow_set.y, changeSign.u)
    annotation (Line(points={{-59,80},{-2,80}}, color={0,0,127}));
  connect(changeSign.y, sink.m_flow_in) annotation (Line(points={{21,80},{84,80},
          {84,10},{70,8}}, color={0,0,127}));
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
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html><p>
  This model implements a very simple demand node representation with
  only an ideal flow sink discharging a prescribed mass flow rate from
  the DHC system's supply network. Note that the
  <code>prescribed_m_flow</code> parameter should be given as a
  positive value, specifying the mass flow rate to be extracted from
  the network into the ideal sink.
</p>
<ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end IdealSinkConstFlow;
