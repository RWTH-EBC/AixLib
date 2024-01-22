within AixLib.DataBase.HeatPump.EN14511;
record Vitocal200AWO201
  "Vitocal200AWO201"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0, -15, -7, 2, 7, 10, 20, 30; 35, 1290.0, 1310.0, 730.0, 870.0, 850.0, 830.0, 780.0; 45, 1550.0, 1600.0, 870.0, 1110.0, 1090.0, 1080.0, 1040.0; 55, 1870.0, 1940.0, 1170.0, 1370.0, 1370.0, 1370.0, 1350.0],
    tableQdot_con=[0, -15, -7, 2, 7, 10, 20, 30; 35, 3020, 3810, 2610, 3960, 4340, 5350, 6610; 45, 3020, 3780, 2220, 3870, 4120, 5110, 6310; 55, 3120, 3790, 2430, 3610, 3910, 4850, 6000],
    mFlow_conNom=3960/4180/5,
    mFlow_evaNom=(2250*1.2)/3600,
    tableUppBou=[-20, 50;-10, 60;30, 60;35,55]);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  <span style=
  \"font-family: Courier New; color: #006400;\">Data&#160;record&#160;for&#160;type&#160;AWO-M/AWO-M-E-AC&#160;201.A04,
  obtained from the technical guide in the UK.</span>
</p>
<ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
end Vitocal200AWO201;
