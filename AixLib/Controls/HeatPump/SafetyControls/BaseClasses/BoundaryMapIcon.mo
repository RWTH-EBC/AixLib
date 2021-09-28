within AixLib.Controls.HeatPump.SafetyControls.BaseClasses;
partial block BoundaryMapIcon "PartialModel for the icon of a boundary map"

  parameter Boolean use_opeEnvFroRec=true
    "Use a the operational envelope given in the datasheet" annotation(Dialog(tab="Safety Control", group="Operational Envelope"),choices(checkBox=true));
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition
    dataTable "Data Table of HP" annotation (choicesAllMatching=true, Dialog(
      tab="Safety Control",
      group="Operational Envelope",
      enable=use_opeEnvFroRec));
  parameter Real tableUpp[:,2] "Table matrix (grid = first column; e.g., table=[0,2])"
    annotation (Dialog(tab="Safety Control", group="Operational Envelope", enable=not use_opeEnvFroRec));
  parameter Real iconMin=-70
    "Used to set the frame where the icon should appear"
    annotation (Dialog(tab="Dynamic Icon"));
  parameter Real iconMax = 70
    "Used to set the frame where the icon should appear"
    annotation (Dialog(tab="Dynamic Icon"));
protected
  parameter Real tableUpp_internal[:,2] = if use_opeEnvFroRec then dataTable.tableUppBou else tableUpp;
  parameter Real xMax=tableUpp_internal[end, 1]
    "Maximal value of lower and upper table data";
  parameter Real xMin=tableUpp_internal[1, 1]
    "Minimal value of lower and upper table data";
  parameter Real yMax=max(tableUpp_internal[:, 2])
    "Maximal value of lower and upper table data";
  parameter Real yMin=0
    "Minimal value of lower and upper table data";
  final Real[size(scaledX, 1), 2] points=transpose({unScaledX,unScaledY}) annotation(Hide=false);
  Real tableMerge[:,2] = tableUpp_internal;
  input Real scaledX[:] = tableMerge[:,1];
  input Real scaledY[:] = tableMerge[:,2];
  Real unScaledX[size(scaledX, 1)](min=-100, max=100) = (scaledX - fill(xMin, size(scaledX, 1)))*(iconMax-iconMin)/(xMax - xMin) + fill(iconMin, size(scaledX,1));
  Real unScaledY[size(scaledX, 1)](min=-100, max=100) = (scaledY - fill(yMin, size(scaledY, 1)))*(iconMax-iconMin)/(yMax - yMin) + fill(iconMin, size(scaledY,1));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                        graphics={
        Rectangle(
          extent={{iconMin-25,iconMax+25},{iconMax+25,iconMin-25}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(points=DynamicSelect({{-66,-66},{-66,50},{-44,66},
              {68,66},{68,-66},{-66,-66}},points),                          color={238,46,47},
          thickness=0.5),
        Polygon(
          points={{iconMin-20,iconMax},{iconMin-20,iconMax},{iconMin-10,iconMax},{iconMin-15,iconMax+20}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{iconMax+20,iconMin-10},{iconMax,iconMin-4},{iconMax,iconMin-16},{iconMax+20,iconMin-10}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{iconMin-15,iconMax},{iconMin-15,iconMin-15}}, color={95,95,95}),
        Line(points={{iconMin-20,iconMin-10},{iconMax+10,iconMin-10}}, color={95,95,95})}), coordinateSystem(preserveAspectRatio=false), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  Icon block used for the icon of the dynamic icon of the model
  <a href=\"modelica://AixLib.Controls.HeatPump.SafetyControls.BaseClasses.BoundaryMap\">
  BoundaryMap</a>. Extending this model will display the used
  operational envelope in the top-layer of the used models.
</p>
</html>"));
end BoundaryMapIcon;
