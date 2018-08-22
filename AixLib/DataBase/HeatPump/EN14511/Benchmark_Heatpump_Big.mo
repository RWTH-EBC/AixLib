within AixLib.DataBase.HeatPump.EN14511;
record Benchmark_Heatpump_Big "Benchmark Heatpump Big"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-5,0,5; 35,19350,19800,19800; 45,24000,24000,24000; 55,28950,29400,29400],
    tableQdot_con=[0,-5,0,5; 35,76572,87000,96600; 45,72600,83400,93600; 55,69078,
        79200,89400],
    mFlow_conNom=12,
    mFlow_evaNom=1000);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Benchmark_Heatpump_Big;
