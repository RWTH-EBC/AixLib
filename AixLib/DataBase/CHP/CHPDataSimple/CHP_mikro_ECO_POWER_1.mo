within AixLib.DataBase.CHP.CHPDataSimple;
record CHP_mikro_ECO_POWER_1 "Vaillant mikro CHP ecoPOWER 1.0"
  extends CHPDataSimple.CHPBaseDataDefinition(
    vol={3e-3},
    data_CHP=[0,0,0,0,0; 100,1,2.58,2.63,2.63],
    maxTFlow=353.15,
    maxTReturn=343.15,
    DPipe=0.08);
 //Matrix contains : [Capacity, Electrical Power, Total Heat Recovery,Fuel Input, Fuel Consumption]

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Vaillant mikro-BHKW ecoPOWER 1.0 (Natural Gas)
</p>
<h4>
  <span style=\"color:#008000\">Known Limitations</span>
</h4>
<p>
  Electrical output is taken from the manufacturer's website. The
  values for heat output, fuel input and fuel consumption are
  calculated with the provided efficiency. They are not given by the
  manufacturer.
</p>
<p>
  Source:
</p>
<ul>
  <li>URL:<a href=
  \"http://www.vaillant.de/Produkte/Kraft-Waerme-Kopplung/Blockheizkraftwerke/produkt_vaillant/mikro-KWK-System_ecoPOWER_1.0.html\">Vaillant
  Website</a>
  </li>
</ul>
</html>",
        revisions="<html><ul>
  <li>
    <i>July 4, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end CHP_mikro_ECO_POWER_1;
