within AixLib.DataBase.HeatPump.EN14511;
record AutarkPower_APHM_70_016_P "AutarkPower_APHM_70_016_P"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
tableP_ele=[0,-15,-7,2,7,12;
                35,3561.366244,3813.559735,4527.229346,4199.462528,3479.877275;
                45,3954.813568,4289.436933,4768.786728,4784.764688,4209.300974;
                55,4323.993328,4774.955965,5263.033011,5464.471599,4792.398618],

    tableQdot_con=[0,-15,-7,2,7,12;
                   35,9081.483923,11326.27241,14441.86162,16713.86086,16564.21583;
                   45,8700.589849,10809.38107,13924.85725,15598.33288,15911.15768;
                   55,8129.107456,9884.158847,12999.69154,14918.00746,14904.3597],

    mFlow_conNom=14441.86162/4180/5,
    mFlow_evaNom=1,
    tableUppBou=[-25, 65; 40, 65]);

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
end AutarkPower_APHM_70_016_P;
