within AixLib.DataBase.Chiller.EN14511;
record Vitocal200AWO201 "Vitocal200AWO201"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0, 20, 25, 27, 30, 35; 7,1380.0, 1590.0, 1680.0, 1800.0, 1970.0;  18,950.0, 1060.0, 1130.0, 1200.0, 1350.0],
    tableQdot_con=[0, 20, 25, 27, 30, 35; 7,2540.0, 2440.0, 2370.0, 2230.0, 2170.0;  18, 5270.0, 5060.0, 4920.0, 4610.0, 4500.0],
    mFlow_conNom=3960/4180/5,
    mFlow_evaNom=(2250*1.2)/3600,
    tableUppBou=[20, 20; 35, 20],
    tableLowBou=[20, 5; 35, 5]);

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Courier New; color: #006400;\">Data&nbsp;record&nbsp;for&nbsp;type&nbsp;AWO-M/AWO-M-E-AC&nbsp;201.A04, obtained from the technical guide in the UK.</span></p>
</html>"));
end Vitocal200AWO201;
