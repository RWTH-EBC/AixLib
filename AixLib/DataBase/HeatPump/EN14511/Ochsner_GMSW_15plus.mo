within AixLib.DataBase.HeatPump.EN14511;
record Ochsner_GMSW_15plus "Ochsner GMSW 15 plus"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-5,0,5; 35,3225,3300,3300; 45,4000,4000,4000; 55,4825,4900,4900],
    tableQdot_con=[0,-5,0,5; 35,12762,14500,16100; 45,12100,13900,15600; 55,11513,
        13200,14900],
    mFlow_conNom=14500/4180/5,
    mFlow_evaNom=(14500 - 3300)/3600/3,
    tableUppBou=[-8, 52; 0, 65; 20, 65]);

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
end Ochsner_GMSW_15plus;
