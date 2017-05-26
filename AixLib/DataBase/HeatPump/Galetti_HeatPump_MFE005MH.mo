within AixLib.DataBase.HeatPump;
record Galetti_HeatPump_MFE005MH
  extends HeatPumpBaseDataDefinition_new(
  name = "HeatPump MFE 005 MH",
  manufacturer = "Galetti",
  heatSource = "air",
  TsourceMax= 293.15,
  TsourceMin = 268.15,
  TuseMax=313.15,
  TuseMin=300.15,
  Nmax=4000,
  Nmin=1500,
  Nnom = 3000,
  PelMax = 1500,
  PelMin = 0,
  QflowUseMax = 6000,
  QflowUseMin = 0,
  mFlowUseNom = 4910/4180/5,
  mFlowSourceNom = 1,
  charType = "table",
  table_QflowUse= [0, 268.15, 273.15, 280.15, 288.15, 293.15;
  300.15,  3090,  4120, 5110, 5740, 0;
  302.15,  3080,  4090,  5060,  5690,  0;
  304.15,  3070,  4060,  5010,  5630,  6060;
  306.15,  3060,  4020,  4960,  5570,  5990;
  308.15,  3050,  3990,  4910,  5510,  5920;
  310.15,  3030,  3995,  4850,  5440,  5850;
  313.15,  3010,  3890,  4770,  5340,  5740],
 table_Pel= [0, 268.15, 273.15, 280.15, 288.15, 293.15;
  300.15,  1170,  1200, 1200, 1180, 0;
  302.15,  1200,  1240,  1240,  1230,  0;
  304.15,  1220,  1270,  1280,  1280,  1270;
  306.15,  1250,  1310,  1330,  1330,  1320;
  308.15,  1270,  1350,  1370,  1370,  1370;
  310.15,  1300,  1380,  1410,  1420,  1420;
  313.15,  1340,  1440,  1480,  1500,  1500]);
  annotation (Documentation(revisions="<html>
<ul>
<li><i>May 26, 2017&nbsp;</i> by Ana Constantin:<br/>Initial implementation</li>
</ul>
</html>
"));
end Galetti_HeatPump_MFE005MH;
