within AixLib.Systems.HydraulicModules.BaseClasses;
model PumpInterface_SpeedControlledNrpm
  "Interface for the SpeedControlled_Nrpm pump model"
  extends BasicPumpInterface;
  Fluid.Movers.SpeedControlled_Nrpm pump(redeclare package Medium = Medium)
    annotation (Dialog(enable=true), Placement(transformation(extent={{-10,-10},
            {10,10}})));
public
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,50})));
  Modelica.Blocks.Sources.Constant ConstZero(k=0)
    annotation (Placement(transformation(extent={{-40,60},{-19,80}})));
equation
  connect(pump.port_a, port_a)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,127,255}));
  connect(pump.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(pump.P, pumpBus.power) annotation (Line(points={{11,9},{11,100.5},{
          0.1,100.5},{0.1,100.1}},
                               color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.y_actual, pumpBus.rpm_Act) annotation (Line(points={{11,7},{26,7},
          {26,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ConstZero.y, switch1.u3)
    annotation (Line(points={{-17.95,70},{-8,70},{-8,62}}, color={0,0,127}));
  connect(switch1.u2, pumpBus.onOff_Input) annotation (Line(points={{
          2.22045e-015,62},{2.22045e-015,100.1},{0.1,100.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(switch1.y, pump.Nrpm) annotation (Line(points={{-1.9984e-015,39},{0,
          39},{0,12}}, color={0,0,127}));
  connect(switch1.u1, pumpBus.rpm_Input) annotation (Line(points={{8,62},{8,92},
          {0.1,92},{0.1,100.1}}, color={0,0,127}), Text(
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
