within AixLib.DataBase.HeatPump.EN14511;
record Vaillant_VWL_101 "Vaillant VWL10-1"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-15,-7,2,7; 35,2138,2177,2444,2444; 45,2558,2673,2864,3055; 55, 2902,3131,3360,3513],
    tableQdot_con=[0,-15,-7,2,7; 35,5842,7523,9776,10807; 45,5842,7332,9050,10387; 55, 5728,7179,9050,10043],
    mFlow_conNom=9776/4180/5,
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
</html>",
   info="<html><p>
  According to data from Vaillant data sheets; EN14511
</p>
</html>"));
end Vaillant_VWL_101;
