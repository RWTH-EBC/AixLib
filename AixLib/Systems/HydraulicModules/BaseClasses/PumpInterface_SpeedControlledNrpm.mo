within AixLib.Systems.HydraulicModules.BaseClasses;
model PumpInterface_SpeedControlledNrpm
  "Interface for the SpeedControlled_Nrpm pump model"
  extends AixLib.Systems.HydraulicModules.BaseClasses.BasicPumpInterface;
  parameter Modelica.Units.NonSI.AngularVelocity_rpm speed_rpm_nominal=1500 "Nominal rotational speed";

  Fluid.Movers.SpeedControlled_y pump(
    redeclare package Medium = Medium,
    final energyDynamics=energyDynamics,
    T_start=T_start) annotation (Dialog(enable=true), Placement(transformation(
          extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Logical.Switch switchToZero
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270,
        origin={0,36})));
  Modelica.Blocks.Sources.Constant constZero(final k=0)
    annotation (Placement(transformation(extent={{-40,60},{-19,80}})));

  Modelica.Blocks.Math.Gain gaiSpe(final k=1/speed_rpm_nominal) "Pressure gain"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={10,70})));
equation
  connect(pump.port_a, port_a)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,127,255}));
  connect(pump.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(pump.P, pumpBus.PelMea) annotation (Line(points={{11,9},{11,14},{22,14},
          {22,100.5},{0.1,100.5},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pump.y_actual, pumpBus.rpmMea) annotation (Line(points={{11,7},{26,7},
          {26,100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(constZero.y, switchToZero.u3) annotation (Line(points={{-17.95,70},{-8,70},{-8,48}}, color={0,0,127}));
  connect(switchToZero.u2, pumpBus.onSet) annotation (Line(points={{2.22045e-15,
          48},{2.22045e-15,100.1},{0.1,100.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(gaiSpe.u, pumpBus.rpmSet) annotation (Line(points={{10,82},{10,96},{
          0.1,96},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(switchToZero.u1, gaiSpe.y)
    annotation (Line(points={{8,48},{8,58},{10,58},{10,59}}, color={0,0,127}));
  connect(switchToZero.y, pump.y) annotation (Line(points={{-1.9984e-15,25},{
          -1.9984e-15,18.5},{0,18.5},{0,12}}, color={0,0,127}));
  annotation (Documentation(revisions="<html><ul>
  <li>May 20, 2018, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Pump container for the SpeedControlled_Nrpm pump.
</p>
</html>"));
end PumpInterface_SpeedControlledNrpm;
