within AixLib.Systems.HydraulicModules.BaseClasses;
model PumpInterface_SpeedControlledNrpm
  "Interface for the SpeedControlled_Nrpm pump model"
  extends BasicPumpInterface;
  Fluid.Movers.SpeedControlled_Nrpm pump(redeclare package Medium = Medium)
    annotation (Dialog(enable=true), Placement(transformation(extent={{-10,-10},
            {10,10}})));
equation
  connect(pump.port_a, port_a)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,127,255}));
  connect(pump.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(pump.Nrpm, pumpBus.rpm_Input) annotation (Line(points={{0,12},{0,56},{
          0,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.P, pumpBus.power) annotation (Line(points={{11,9},{11,100.5},{0.1,
          100.5},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.y_actual, pumpBus.rpm_Act) annotation (Line(points={{11,7},{26,7},
          {26,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Documentation(revisions="<html>
<ul>
<li>May 20, 2018, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>Pump container for the SpeedControlled_Nrpm pump.</p>
</html>"));
end PumpInterface_SpeedControlledNrpm;
