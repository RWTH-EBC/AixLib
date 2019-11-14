within AixLib.Utilities.MassTransfer;
connector MassPort "connector for mass transfer"

  Modelica.SIunits.MassFlowRate m_flow "mass flow rate";
  Modelica.SIunits.MassFraction X "mass fraction";
  Modelica.SIunits.Pressure p "pressure";

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
          textStyle={TextStyle.Bold})}));
end MassPort;
