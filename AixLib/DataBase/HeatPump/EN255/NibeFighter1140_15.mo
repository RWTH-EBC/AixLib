within AixLib.DataBase.HeatPump.EN255;
record NibeFighter1140_15 "Nibe Fighter 1140-15"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-5.0,0.0,2,5.0,10; 35,3360,3380,3380,3390,3400; 55,4830,4910,4940,
        4990,5050],
    tableQdot_con=[0,-5.0,0.0,2,5.0,10; 35,13260,15420,16350,17730,19930; 55,12560,
        14490,15330,16590,18900],
    mFlow_conNom=15420/4180/10,
    mFlow_evaNom=(15420 - 3380)/3600/3,
    tableUppBou=[-35, 65; 50, 65]);

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(info="<html><p>
  According to manufacturer's data; EN 255.
</p>
<ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>"));
end NibeFighter1140_15;
