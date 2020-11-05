within AixLib.DataBase.HeatPump.EN14511;
record StiebelEltron_WPL18 "Stiebel Eltron WPL 18"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-7,2,7,10,20; 35,3300,3400,3500,3700,3800; 50,4500,4400,4600,5000,
        5100],
    tableQdot_con=[0,-7,2,7,10,20; 35,9700,11600,13000,14800,16300; 50,10000,11200,
        12900,16700,17500],
    mFlow_conNom=13000/4180/5,
    mFlow_evaNom=1,
    tableUppBou=[-25, 65; 40, 65]);
    //These boundary-tables are not from the datasheet but default values.

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(revisions="<html><ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>", info="<html>
<p>
  According to data from WPZ Buchs, Swiss; EN14511
</p>
</html>"));
end StiebelEltron_WPL18;
