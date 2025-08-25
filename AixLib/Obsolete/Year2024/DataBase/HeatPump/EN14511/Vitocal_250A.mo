within AixLib.DataBase.HeatPump.EN14511;
record Vitocal_250A "Vitocal_250A"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[
      0, -20, -15, -7, 2, 7, 10, 20, 30, 35;
      35, 2128, 2238, 2396, 1835, 1633, 2006, 1720, 1465, 1558;
      45, 2299, 2402, 2641, 2173, 2244, 2462, 2110, 1734, 1584;
      55, 2305, 2631, 2899, 2493, 2669, 2915, 2556, 2164, 2081;
      65, 0, 2032, 2478, 2760, 3095, 3375, 3085, 2521, 2511;
      70, 0, 0, 2201, 2699, 3193, 3398, 3330, 2822, 2817],
    tableQdot_con=[
      0, -20, -15, -7, 2, 7, 10, 20, 30, 35;
      35, 4490, 5170, 6470, 6790, 8000, 10210, 12330, 12310, 13090;
      45, 4230, 4900, 6260, 6780, 8370, 9970, 11520, 13040, 12640;
      55, 3780, 4710, 6030, 6830, 8380, 9940, 11500, 13070, 13110;
      65, 0, 3170, 4610, 6320, 8140, 9550, 11290, 12100, 12180;
      70, 0, 0, 3830, 5560, 7600, 8700, 11290, 12500, 12590],
    mFlow_conNom=5600/5/4184,
    mFlow_evaNom=2125/3600/1.204,
    tableUppBou=[-20,60; -10,90; 40,90]);

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
end Vitocal_250A;
