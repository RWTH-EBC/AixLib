within AixLib.DataBase.HeatPump.EN255;
record Vitocal350BWH113 "Vitocal 350 BWH 113"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-5.0,0.0,5.0,10.0,15.0; 35,3750,3750,3750,3750,3833; 45,4833,4917,
        4958,5042,5125; 55,5583,5667,5750,5833,5958; 65,7000,7125,7250,7417,7583],
    tableQdot_con=[0,-5.0,0.0,5.0,10.0,15.0; 35,14500,16292,18042,19750,21583; 45,
        15708,17167,18583,20083,21583; 55,15708,17167,18583,20083,21583; 65,15708,
        17167,18583,20083,21583],
    mFlow_conNom=16292/4180/10,
    mFlow_evaNom=12300/3600/3,
    tableUppBou=[-5, 55; 25, 55]);

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(info="<html><p>
  Data from manufacturer's data sheet (Viessmann). These exact curves
  are given in the data sheet for measurement procedure according to EN
  255.
</p>
<ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>"));
end Vitocal350BWH113;
