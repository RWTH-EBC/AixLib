within AixLib.Utilities.MassTransfer;
connector MassPort "connector for mass transfer"

  flow Modelica.Units.SI.MassFlowRate m_flow "mass flow rate of sub-component";
  Modelica.Units.SI.PartialPressure p "partial pressure of sub-component";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,140,72},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid), Text(
          extent={{-42,88},{42,70}},
          lineColor={0,140,72},
          fillColor={0,140,72},
          fillPattern=FillPattern.None,
          textString="")}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,140,72},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid), Text(
          extent={{-68,110},{68,32}},
          lineColor={0,140,72},
          fillColor={0,140,72},
          fillPattern=FillPattern.None,
          textString="%name",
          textStyle={TextStyle.Bold})}),
    Documentation(info="<html>Connector for mass transfer of one component of a multicomponent
mixture.
</html>", revisions="<html>
<ul>
  <li>November 15, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end MassPort;
