within AixLib.Fluid.Movers.PumpsPolynomialBased.Controls;
model CtrlPassThroughN "'n_set' passhrough for PumpSpeedControlled"
  extends BaseClasses.PumpController;
equation
  connect(pumpBus, pumpControllerBus) annotation (Line(
      points={{0,-100},{0,100}},
      color={255,204,51},
      thickness=0.5));
  annotation (Documentation(revisions="<html><ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming and bug fixes.
  </li>
  <li>
    <span style=\"font-family: MS Shell Dlg 2;\">2018-03-01 by Peter
    Matthes:<br/>
    Simplified doc string to \"'n_set' for PumpN\".</span>
  </li>
  <li>2018-02-05 by Peter Matthes:<br/>
    Adds pass through for rpm_Act signal. Some controllers need the
    current speed signal for anti-windup.
  </li>
  <li>2018-01-26 by Peter Matthes:<br/>
    Changes icon to reflect relationship with red pump (speed control).
  </li>
  <li>2018-01-10 by Peter Matthes:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  Simple Controller that passes the pump speed signal on the
  pumpControllerBus (rpm_input) to the pumpBus. This way the pump
  speed, computed somewhere else, can be applied directly to the
  PumpPhysics model.
</p>
</html>"), Icon(graphics={
        Rectangle(
          extent={{-80,50},{76,-8}},
          lineColor={0,0,0},
          fillColor={254,178,76},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{-70,38},{64,8}},
          lineColor={240,59,32},
          fillColor={0,216,108},
          fillPattern=FillPattern.Solid,
          textString="n_set")}));
end CtrlPassThroughN;
