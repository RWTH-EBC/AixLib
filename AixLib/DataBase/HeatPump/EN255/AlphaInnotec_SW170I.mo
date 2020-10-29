within AixLib.DataBase.HeatPump.EN255;
record AlphaInnotec_SW170I "Alpha Innotec SW 170 I"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-5.0,0.0,5.0; 35,3700,3600,3600; 50,5100,5100,5100],
    tableQdot_con=[0,-5.0,0.0,5.0; 35,14800,17200,19100; 50,14400,16400,18300],
    mFlow_conNom=17200/4180/10,
    mFlow_evaNom=13600/3600/3,
    tableUppBou=[-22, 65; 45, 65]);

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(info="<html><p>
  According to data from WPZ Buchs, Swiss; EN 255.
</p>
<ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>"));
end AlphaInnotec_SW170I;
