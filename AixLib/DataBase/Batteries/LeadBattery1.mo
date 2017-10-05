within AixLib.DataBase.Batteries;
record LeadBattery1 "Lead Battery 1"
  import AixLib;
    extends AixLib.DataBase.Batteries.BatteryBaseDataDefinition(
    height=1,
    width=0.5,
    length=0.2,
    cp=1100,
    massBat=130,
    radiationArea=12,
    eps=0.95);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,60},{150,100}},
          textString="%name"),
        Rectangle(
          origin={0.0,-25.0},
          lineColor={64,64,64},
          fillColor={255,215,136},
          fillPattern=FillPattern.Solid,
          extent={{-100.0,-75.0},{100.0,75.0}},
          radius=25.0),
        Line(
          points={{-100.0,0.0},{100.0,0.0}},
          color={64,64,64}),
        Line(
          origin={0.0,-50.0},
          points={{-100.0,0.0},{100.0,0.0}},
          color={64,64,64}),
        Line(
          origin={0.0,-25.0},
          points={{0.0,75.0},{0.0,-75.0}},
          color={64,64,64})}),
        Documentation(info="<html>
    <p><b><font style=\"color: #008000; \">Overview</font></b> </p>
    <p>This record is an example for a lead battery.</p>
    <p><b><font style=\"color: #008000; \">References</font></b> </p>
    <p><a href=\"AixLib.DataBase.Batteries.BatteryBaseDataDefinition\">
    AixLib.DataBase.Batteries.BatteryBaseDataDefinition</a></p>
    </html>",  revisions="<html>
    <ul>
    <li><i>July 26, 2017&nbsp;</i> by Paul Thiele:<br/>Implemented. </li>
    </ul>
</html>"));
end LeadBattery1;
