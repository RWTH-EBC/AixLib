within AixLib.DataBase.HeatPump.EN14511;
record Ochsner_GMLW_19plus "Ochsner GMLW 19 plus"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-10,2,7; 35,4100,4300,4400; 50,5500,5700,5800; 60,6300,6500,6600],
    tableQdot_con=[0,-10,2,7; 35,12600,16800,19800; 50,11700,15900,18900; 60,11400,
        15600,18600],
    mFlow_conNom=19800/4180/5,
    mFlow_evaNom=1,
    tableUppBou=[-24,52;-15, 55;-10,65; 40, 65]);

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
  According to data from Ochsner data sheets; EN14511
</p>
</html>"));
end Ochsner_GMLW_19plus;
