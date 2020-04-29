within AixLib.Fluid.Examples.GeothermalHeatPump.Components;
model BoilerExternalControl
  "Model containing the simple boiler model and the bus connector for external control"
  extends BaseClasses.BoilerBase;
  Controls.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-20,80},{20,118}})));
equation
  connect(boiler.TAmbient, boilerControlBus.TAmbient) annotation (Line(points={
          {-7,7},{-20,7},{-20,60},{0.1,60},{0.1,99.095}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(boiler.switchToNightMode, boilerControlBus.switchToNightMode)
    annotation (Line(points={{-7,4},{-24,4},{-24,64},{0.1,64},{0.1,99.095}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(boiler.isOn, boilerControlBus.isOn) annotation (Line(points={{5,-9},{
          5,-22},{-24,-22},{-24,64},{0.1,64},{0.1,99.095}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(chemicalEnergyFlowRateSource.y, boilerControlBus.chemicalEnergyFlowRate)
    annotation (Line(points={{-39,-56},{-20,-56},{-20,60},{0.1,60},{0.1,99.095}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Documentation(revisions="<html><ul>
  <li>May 19, 2017, by Marc Baranski:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Model containing the simple boiler model <a href=
  \"modelica://AixLib.Fluid.BoilerCHP.Boiler\">AixLib.Fluid.BoilerCHP.Boiler</a>
  and interfaces for external control.
</p>
</html>"));
end BoilerExternalControl;
