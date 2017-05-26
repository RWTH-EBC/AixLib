within AixLib.Controls.Types;
type OperationMode_HP = enumeration(
    heatPump
           "machine works only as heat pump",
    chiller
          "machine works only as chiller",
    reversible
             "machine works both as heat pump and chiller")
  "operation modes of a heat pump" annotation (Documentation(info="<html>
<p>Enumeration to define the different operation modes of a heat pump</p>
</html>", revisions="<html>
<ul>
<li>
Mai 26, 2017, by Ana Constantin:<br/>
First implementation.
</li>
</ul>
</html>"));
