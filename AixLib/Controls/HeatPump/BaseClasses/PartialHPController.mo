within AixLib.Controls.HeatPump.BaseClasses;
partial model PartialHPController
  "Base class of a heat pump controller with bus interface"
  AixLib.Controls.Interfaces.VapourCompressionMachineControlBus heatPumpControlBus
    annotation (Placement(transformation(
        extent={{-29.5,-29.5},{29.5,29.5}},
        rotation=270,
        origin={99.5,0.5})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(extent={{-80,80},{80,-80}},      lineColor = {135, 135, 135}, fillColor = {255, 255, 170},
            fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
              -58,30},{62,-22}},                                                                                                                                                      lineColor = {175, 175, 175}, textString = "%name")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><p>
  March 31, 2017, by Marc Baranski:
</p>
<p>
  First implementation.
</p>
</html>", info="<html>
<p>
  Base class for heat pump controllers that contains the <a href=
  \"modelica://AixLib.Controls.Interfaces.HeatPumpControlBus\">AixLib.Controls.Interfaces.HeatPumpControlBus</a>.
</p>
</html>"));
end PartialHPController;
