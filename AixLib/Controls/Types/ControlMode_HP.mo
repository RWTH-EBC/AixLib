within AixLib.Controls.Types;
type ControlMode_HP = enumeration(
    onOff  "only on/off control",
    speedControl
          "control over rotational speed")
  "control modes of a heat pump" annotation (Documentation(info="<html>
<p>Enumeration to define the different control modes of a heat pump</p>
</html>", revisions="<html>
<ul>
<li>
Mai 26, 2017, by Ana Constantin:<br/>
First implementation.
</li>
</ul>
</html>"));
