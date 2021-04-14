within AixLib.Systems.Benchmark.BaseClasses;
record HeatpumpBenchmarkSystem "Benchmark Heatpump Big"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0,-5,0,5; 35,19350,19800,19800; 45,24000,24000,24000; 55,28950,29400,29400],
    tableQdot_con=[0,-5,0,5; 35,76572,87000,96600; 45,72600,83400,93600; 55,69078,
        79200,89400],
    mFlow_conNom=12,
    mFlow_evaNom=1000,
    tableUppBou=[-20, 50;-10, 60; 30, 60; 35,55]);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatpumpBenchmarkSystem;
