within AixLib.DataBase.ThermalMachines.HeatPump;
package EN14511

  record AlphaInnotec_LW80MA "Alpha Innotec LW 80 M-A"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-7,2,7,10,15,20; 35,2625,2424,2410,2395,2347,2322; 45,
          3136,3053,3000,2970,2912,2889; 50,3486,3535,3451,3414,3365,3385],
      tableQdot_con=[0,-7,2,7,10,15,20; 35,6300,8000,9400,10300,11850,13190;
          45,6167,7733,9000,9750,11017,11730; 50,6100,7600,8800,9475,10600,
          11000],
      mFlow_conNom=9400/4180/5,
      mFlow_evaNom=1,
      tableUppBou=[-25,65; 40,65],
      tableLowBou=[-25,0; 40,0]);

      //These boundary-tables are not from the datasheet but default values.

    annotation(preferedView="text", DymolaStoredErrors,
      Icon,
      Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",   info="<html>
<p>According to manufacturer&apos;s data which was inter- and extrapolated linearly; EN14511 </p>
</html>"));
  end AlphaInnotec_LW80MA;

  record Dimplex_LA11AS "Dimplex LA 11 AS"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-7,2,7,10; 35,2444,2839,3139,3103; 45,2783,2974,3097,
          3013],
      tableQdot_con=[0,-7,2,7,10; 35,6600,8800,11300,12100; 45,6400,7898,
          9600,10145],
      mFlow_conNom=11300/4180/5,
      mFlow_evaNom=1,
      tableUppBou=[-25,58; 35,58],
      tableLowBou=[-25,18; 35,18]);

    annotation(preferedView="text", DymolaStoredErrors,
      Icon,
      Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",   info="<html>
<p>According to data from Dimplex data sheets; EN14511</p>
</html>"));
  end Dimplex_LA11AS;

  record Ochsner_GMLW_19 "Ochsner GMLW 19"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-10,2,7; 35,4300,4400,4600; 50,6300,6400,6600],
      tableQdot_con=[0,-10,2,7; 35,11600,17000,20200; 50,10200,15600,18800],
      mFlow_conNom=20200/4180/5,
      mFlow_evaNom=1,
      tableUppBou=[-15,55; 40,55],
      tableLowBou=[-15,0; 40,0]);

    annotation(preferedView="text", DymolaStoredErrors,
      Icon,
      Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",   info="<html>
<p>According to data from Ochsner data sheets; EN14511</p>
</html>"));
  end Ochsner_GMLW_19;

  record Ochsner_GMLW_19plus "Ochsner GMLW 19 plus"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-10,2,7; 35,4100,4300,4400; 50,5500,5700,5800; 60,6300,
          6500,6600],
      tableQdot_con=[0,-10,2,7; 35,12600,16800,19800; 50,11700,15900,18900;
          60,11400,15600,18600],
      mFlow_conNom=19800/4180/5,
      mFlow_evaNom=1,
      tableUppBou=[-24,52; -15,55; -10,65; 40,65],
      tableLowBou=[-24,0; 40,0]);

    annotation(preferedView="text", DymolaStoredErrors,
      Icon,
      Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",   info="<html>
<p>According to data from Ochsner data sheets; EN14511</p>
</html>"));
  end Ochsner_GMLW_19plus;

  record Ochsner_GMSW_15plus "Ochsner GMSW 15 plus"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-5,0,5; 35,3225,3300,3300; 45,4000,4000,4000; 55,4825,
          4900,4900],
      tableQdot_con=[0,-5,0,5; 35,12762,14500,16100; 45,12100,13900,15600;
          55,11513,13200,14900],
      mFlow_conNom=14500/4180/5,
      mFlow_evaNom=(14500 - 3300)/3600/3,
      tableUppBou=[-8,52; 0,65; 20,65],
      tableLowBou=[-8,10; 20,27]);

    annotation(preferedView="text", DymolaStoredErrors,
      Icon,
      Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",   info="<html>
<p>According to data from WPZ Buchs, Swiss; EN14511 </p>
</html>"));
  end Ochsner_GMSW_15plus;

  record StiebelEltron_WPL18 "Stiebel Eltron WPL 18"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-7,2,7,10,20; 35,3300,3400,3500,3700,3800; 50,4500,4400,
          4600,5000,5100],
      tableQdot_con=[0,-7,2,7,10,20; 35,9700,11600,13000,14800,16300; 50,
          10000,11200,12900,16700,17500],
      mFlow_conNom=13000/4180/5,
      mFlow_evaNom=1,
      tableUppBou=[-25,65; 40,65],
      tableLowBou=[-25,0; 40,0]);
      //These boundary-tables are not from the datasheet but default values.

    annotation(preferedView="text", DymolaStoredErrors,
      Icon,
      Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",   info="<html>
<p>According to data from WPZ Buchs, Swiss; EN14511</p>
</html>"));
  end StiebelEltron_WPL18;

  record Vaillant_VWL_101 "Vaillant VWL10-1"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-15,-7,2,7; 35,2138,2177,2444,2444; 45,2558,2673,2864,
          3055; 55,2902,3131,3360,3513],
      tableQdot_con=[0,-15,-7,2,7; 35,5842,7523,9776,10807; 45,5842,7332,
          9050,10387; 55,5728,7179,9050,10043],
      mFlow_conNom=9776/4180/5,
      mFlow_evaNom=1,
      tableUppBou=[-25,65; 40,65],
      tableLowBou=[-25,0; 40,0]);
      //These boundary-tables are not from the datasheet but default values.

    annotation(preferedView="text", DymolaStoredErrors,
      Icon,
      Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",
     info="<html>
<p>According to data from Vaillant data sheets; EN14511 </p>
</html>"));
  end Vaillant_VWL_101;

  record Vitocal200AWO201
    "Vitocal200AWO201"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-15,-7,2,7,10,20,30; 35,1290.0,1310.0,730.0,870.0,850.0,
          830.0,780.0; 45,1550.0,1600.0,870.0,1110.0,1090.0,1080.0,1040.0;
          55,1870.0,1940.0,1170.0,1370.0,1370.0,1370.0,1350.0],
      tableQdot_con=[0,-15,-7,2,7,10,20,30; 35,3020,3810,2610,3960,4340,
          5350,6610; 45,3020,3780,2220,3870,4120,5110,6310; 55,3120,3790,
          2430,3610,3910,4850,6000],
      mFlow_conNom=3960/4180/5,
      mFlow_evaNom=(2250*1.2)/3600,
      tableUppBou=[-20,50; -10,60; 30,60; 35,55],
      tableLowBou=[-20,25; 25,25; 35,35]);

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p><span style=\"font-family: Courier New; color: #006400;\">Data&nbsp;record&nbsp;for&nbsp;type&nbsp;AWO-M/AWO-M-E-AC&nbsp;201.A04, obtained from the technical guide in the UK.</span></p>
</html>",   revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"));
  end Vitocal200AWO201;
end EN14511;
