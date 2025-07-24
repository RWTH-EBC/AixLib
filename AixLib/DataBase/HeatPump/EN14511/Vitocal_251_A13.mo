within AixLib.DataBase.HeatPump.EN14511;
record Vitocal_251_A13 "Vitocal_251_A13"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[
  0, -20, -15, -7, 2, 7, 10, 20, 30, 35;
  35, 3370, 3510, 3660, 3750, 1680, 1560, 1550, 1430, 1370, 1370;
  45, 3660, 3840, 4040, 4160, 1970, 1890, 1910, 1880, 1700, 1700;
  55, 3870, 4200, 4450, 4600, 2250, 2230, 2270, 2330, 2270, 2270;
  65,    0, 3420, 3980, 4310, 2510, 2690, 2760, 2930, 2960, 2960;
  70,    0,    0, 3240, 3540, 2770, 2970, 3050, 3280, 3380, 3380],
    tableQdot_con=[
  0, -20, -15, -7, 2, 7, 10, 20, 30, 35;
  35, 7770, 8900, 10300, 11130, 6700, 8130, 8820, 11650, 11950, 11950;
  45, 7320, 8440, 9820, 10660, 6480, 7750, 8330, 11070, 14370, 14370;
  55, 7000, 8290, 9730, 10600, 6370, 7560, 8280, 11160, 14460, 14460;
  65,    0, 6120, 7990, 9110, 6280, 7610, 8300, 10970, 14030, 14030;
  70,    0,    0, 5960, 6930, 6250, 7580, 8270, 10900, 13900, 13900],
    mFlow_conNom=6700/5/4184,
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
end Vitocal_251_A13;
