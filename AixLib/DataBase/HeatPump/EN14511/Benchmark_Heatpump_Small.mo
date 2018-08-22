within AixLib.DataBase.HeatPump.EN14511;
record Benchmark_Heatpump_Small "Benchmark Heatpump Small"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-5,0,5; 35,9675,9900,9900; 45,12000,12000,12000; 55,14475,14700,14700],
    tableQdot_con=[0,-5,0,5; 35,38286,43500,48300; 45,36300,41700,46800; 55,34539,
        39600,44700],
    mFlow_conNom=12,
    mFlow_evaNom=1000);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

end Benchmark_Heatpump_Small;
