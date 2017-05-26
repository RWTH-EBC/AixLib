within AixLib.DataBase.HeatPump;
record Galetti_Chiller_MFE005M
  extends HeatPumpBaseDataDefinition_new(
  name = "Chiller MFE 0005 M",
  manufacturer = "Galetti",
  heatSource = "air",
  TsourceMax = 318.15,
  TsourceMin = 293.15,
  TuseMax=292.15,
  TuseMin=280.15,
  Nmax=4000,
  Nmin=1500,
  Nnom = 3000,
  PelMax = 1520,
  PelMin = 0,
  QflowUseMax = 5900,
  QflowUseMin = 0,
  mFlowUseNom = 5240/4180/5,
  mFlowSourceNom = 1,
  charType = "table",
  table_QflowUse= [0, 293.15, 298.15, 303.15, 308.15, 313.15, 318.15;
  280.15,  4600,  4430, 4190, 3940, 3680, 3400;
  282.15,  5000,  4740,  4480,  4210,  3930,  3640;
  284.15,  5300,  5060,  4780,  4490,  4200,  3890;
  286.15,  5500,  5390,  5100,  4790,  4470,  4140;
  288.15,  5850,  5730,  5420,  5100,  4760,  4420;
  290.15,  5900,  5860,  5540,  5210,  4870,  4510;
  291.15,  5900,  5860,  5540,  5210,  4870,  4510;
  292.15,  5900,  5860,  5540,  5210,  4870,  4510],
 table_Pel= [0, 293.15, 298.15, 303.15, 308.15, 313.15, 318.15;
 280.15, 1100,  1250,  1360,  1480,  1600,  1720;
 282.15,  1100,  1250,  1370,  1490,  1620,  1740;
 284.15,  1100,  1250,  1380,  1500,  1630,  1760;
 286.15,  1100,  1250,  1390,  1520,  1650,  1790;
 288.15,  1100,  1250,  1390,  1530,  1670,  1810;
 290.15,  1100,  1250,  1390,  1530,  1670,  1820;
 291.15,  1100,  1250,  1390,  1530,  1670,  1820;
 292.15,  1100,  1250,  1390,  1530,  1670,  1820]);
  annotation (Documentation(revisions="<html>
<ul>
<li><i>May 26, 2017&nbsp;</i> by Ana Constantin:<br/>Initial implementation</li>
</ul>
</html>
"));
end Galetti_Chiller_MFE005M;
