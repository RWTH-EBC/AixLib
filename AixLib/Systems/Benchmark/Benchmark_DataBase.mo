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
      mFlow_evaNom=1000);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));

  end Benchmark_Heatpump_Big;
end Benchmark_DataBase;
