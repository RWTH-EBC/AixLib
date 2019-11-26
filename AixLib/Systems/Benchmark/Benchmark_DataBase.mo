within AixLib.Systems.Benchmark;
package Benchmark_DataBase
  extends Modelica.Icons.Package;
  record Benchmark_22000l
    extends Modelica.Icons.Record;

      extends AixLib.DataBase.Storage.BufferStorageBaseDataDefinition(
      hTank=3,
      hLowerPorts=0.05,
      hUpperPorts=2.95,
      hHC1Up=2.9,
      hHC1Low=0.1,
      hHC2Up=2.9,
      hHC2Low=0.1,
      hHR=1,
      dTank=6.111,
      sWall=0.005,
      sIns=0.14,
      lambdaWall=60,
      lambdaIns=0.040,
      hTS1=0.05,
      hTS2=2.95,
      rhoIns=45,
      cIns=1400,
      rhoWall=7850,
      cWall=400,
      roughness=2.5e-5,
      pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
      pipeHC2=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
      lengthHC1=150,
      lengthHC2=275);

    annotation (Icon(graphics),               Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Buffer Storage: Generic 2000 l</p>
<h4><font color=\"#008000\">References</font></h4>
<p>Base data definition for record used with <a
href=\"AixLib.Fluid.Storage.Storage\">AixLib.Fluid.Storage.Storage</a> and <a
href=\"AixLib.Fluid.Storage.BufferStorage\">AixLib.Fluid.Storage.BufferStorage</a> </p>
</html>"));



  end Benchmark_22000l;

  record Benchmark_46000l
    extends Modelica.Icons.Record;
      extends AixLib.DataBase.Storage.BufferStorageBaseDataDefinition(
      hTank=3,
      hLowerPorts=0.05,
      hUpperPorts=2.95,
      hHC1Up=2.9,
      hHC1Low=0.1,
      hHC2Up=2.9,
      hHC2Low=0.1,
      hHR=1,
      dTank=8.837,
      sWall=0.005,
      sIns=0.1,
      lambdaWall=60,
      lambdaIns=0.040,
      hTS1=0.05,
      hTS2=2.95,
      rhoIns=45,
      cIns=1400,
      rhoWall=7850,
      cWall=400,
      roughness=2.5e-5,
      pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
      pipeHC2=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
      lengthHC1=250,
      lengthHC2=250);

    annotation (Icon(graphics),               Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Buffer Storage: Generic 2000 l</p>
<h4><font color=\"#008000\">References</font></h4>
<p>Base data definition for record used with <a
href=\"AixLib.Fluid.Storage.Storage\">AixLib.Fluid.Storage.Storage</a> and <a
href=\"AixLib.Fluid.Storage.BufferStorage\">AixLib.Fluid.Storage.BufferStorage</a> </p>
</html>"));

  end Benchmark_46000l;

  record CE_RO_EnEV2009_SM_TBA
    extends Modelica.Icons.Record;

      //"Ceiling and Roof for a TBA after EnEV 2009, for building of type S (schwer) and M (mittel)"
    extends AixLib.DataBase.Walls.WallBaseDataDefinition(
      n(min=1) = 7 "Number of wall layers",
      d={0.02,0.08,0.08,0.015,0.22,0.0125,0.015} "Thickness of wall layers",
      rho={120,2300,2300,1200,194,800,1200} "Density of wall layers",
      lambda={0.045,2.3,2.3,0.51,0.045,0.25,0.51} "Thermal conductivity of wall layers",
      c={1030,1000,1000,1000,1301,1000,1000} "Specific heat capacity of wall layers",
      eps=0.95 "Emissivity of inner wall surface");
    annotation(Documentation(revisions = "<html>
 <ul>
 <li><i>September 5, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
 <li><i>Juni 1, 2011</i> by Ana Constantin:<br/>implemented</li>
 </ul>
 </html>",   info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Wall definition according to EnEV 2009. For detailed wall type see above. </p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p><b><font style=\"color: #ff0000; \">Attention:</font></b> The first element in each vector represents the layer connected to <code>port_a</code>(outside), the last element represents the layer connected to <code>port_b</code>(surface facing the room). </p>
 <h4><span style=\"color:#008000\">References</span></h4>
 <p>Record is used in model <a href=\"Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar\">Building.Components.Walls.BaseClasses.ConvNLayerClearanceStar</a></p>
 <p>Norm: </p>
 <ul>
 <li>Bundesregierung (Veranst.): Verordnung &uuml;ber energiesparenden W&auml;rmeschutz und energiesparende Anlagentechnik bei Geb&auml;uden. Berlin, 2009 </li>
 </ul>
 </html>"));

  end CE_RO_EnEV2009_SM_TBA;

  record Benchmark_Heatpump_Big
    extends Modelica.Icons.Record;

    extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
      tableP_ele=[0,-5,0,5; 35,19350,19800,19800; 45,24000,24000,24000; 55,28950,29400,29400],
      tableQdot_con=[0,-5,0,5; 35,76572,87000,96600; 45,72600,83400,93600; 55,69078,
          79200,89400],
      mFlow_conNom=12,
      mFlow_evaNom=1000,
       tableUppBou=[-25, 65; 40, 65]);



    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));

  end Benchmark_Heatpump_Big;

  record ThermalZone_Record
    extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
      T_start=293.15,
      VAir=2700,
      AZone=900,
      hRad=5,
      lat=0.8386499043,
      nOrientations=2,
      AWin={90,90},
      ATransparent={72,72},
      hConWin=1.3,
      RWin=0.01282,
      gWin=1,
      UWin=1.08337,
      ratioWinConRad=0.09,
      AExt={45,45},
      hConExt=2.5,
      nExt=4,
      RExt={0.00056,0.03175,0.00533,0.00033},
      RExtRem=0.0001,
      CExt={8100000,1112400,21600000,1620000},
      AInt=90,
      hConInt=2.5,
      nInt=2,
      RInt={0.00194,0.00033},
      CInt={7875000,1620000},
      AFloor=900,
      hConFloor=2.5,
      nFloor=4,
      RFloor={0.00167,0.00012,0.00127,0.00005},
      RFloorRem=0.00001,
      CFloor={756000,817500000,4449600,108000000},
      ARoof=900,
      hConRoof=2.5,
      nRoof=4,
      RRoof={0.00049,0.00008,0.00003,0.00001},
      RRoofRem=0.00001,
      CRoof={2224800,331200000,16200000,0.09},
      nOrientationsRoof=1,
      tiltRoof={0},
      aziRoof={0},
      wfRoof={1},
      aRoof=0.7,
      aExt=0.7,
      TSoil=283.15,
      hConWallOut=25.0,
      hRadWall=5,
      hConWinOut=25.0,
      hConRoofOut=25,
      hRadRoof=5,
      tiltExtWalls={1.5707963267949,1.5707963267949},
      aziExtWalls={0,1.5707963267949},
      wfWall={0.5,0.5},
      wfWin={0.5,0.5},
      wfGro=0.1,
      internalGainsPeopleSpecific=3.5,
      ratioConvectiveHeatPeople=0.5,
      internalGainsMachinesSpecific=7.0,
      ratioConvectiveHeatMachines=0.6,
      lightingPowerSpecific=12.5,
      ratioConvectiveHeatLighting=0.6,
      useConstantACHrate=false,
      baseACH=0.2,
      maxUserACH=1,
      maxOverheatingACH={3.0,2.0},
      maxSummerACH={1.0,273.15 + 10,273.15 + 17},
      winterReduction={0.2,273.15,273.15 + 10},
      withAHU=true,
      minAHU=0,
      maxAHU=12,
      hHeat=167500,
      lHeat=0,
      KRHeat=1000,
      TNHeat=1,
      HeaterOn=true,
      hCool=0,
      lCool=-1,
      KRCool=1000,
      TNCool=1,
      CoolerOn=false);
    annotation (Documentation(revisions="<html>
 <ul>
  <li>
  February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
  Adapting nrPeople and nrPeopleMachines to area specific approach 
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation.
  </li>
  <li>
  June, 2015, by Moritz Lauster:<br/>
  Implemented.
  </li>
 </ul>
 </html>",   info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &quot;Office&quot; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"),      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ThermalZone_Record;
end Benchmark_DataBase;
