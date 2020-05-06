within AixLib.DataBase.HeatPump.EN14511;
record AlphaInnotec_LW80MA "Alpha Innotec LW 80 M-A"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-7,2,7,10,15,20; 35,2625,2424,2410,2395,2347,2322; 45,3136,3053,
        3000,2970,2912,2889; 50,3486,3535,3451,3414,3365,3385],
    tableQdot_con=[0,-7,2,7,10,15,20; 35,6300,8000,9400,10300,11850,13190; 45,6167,
        7733,9000,9750,11017,11730; 50,6100,7600,8800,9475,10600,11000],
    mFlow_conNom=9400/4180/5,
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
  According to manufacturer's data which was inter- and extrapolated
  linearly; EN14511
</p>
</html>"));
end AlphaInnotec_LW80MA;
