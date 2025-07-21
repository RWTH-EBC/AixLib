within AixLib.DataBase.HeatPump.EN14511;
record Hansetherm_HT_R290G_8_B "Hansetherm_HT_R290G_8_B"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[0, -20, -15, -10, -7, -5, 0, 2, 7, 10, 15, 20;
                35, 2.00, 2.05, 2.10, 2.15, 2.18, 1.87, 1.88, 1.91, 1.94, 1.79, 1.83;
                45, 2.20, 2.28, 2.14, 2.18, 2.21, 2.02, 2.03, 2.05, 2.08, 1.92, 1.96;
                50, 2.30, 2.42, 2.15, 2.19, 2.22, 2.06, 2.07, 2.08, 2.11, 1.95, 1.99;
                55, 2.44, 2.56, 2.20, 2.28, 2.31, 2.15, 2.16, 2.18, 2.21, 2.05, 2.09;
                60, 2.50, 2.71, 2.22, 2.29, 2.34, 2.14, 2.17, 2.19, 2.22, 2.03, 2.10;
                65, 0.00, 2.82, 2.45, 2.53, 2.58, 2.36, 2.38, 2.40, 2.44, 2.23, 2.30],

    tableQdot_con=[0, -20, -15, -10, -7, -5, 0, 2, 7, 10, 15, 20;
                   35, 3.70, 4.35, 5.13, 5.50, 5.75, 5.95, 6.35, 7.80, 8.19, 8.56, 9.58;
                   45, 3.30, 3.88, 4.69, 4.95, 5.17, 5.38, 5.80, 6.60, 6.93, 7.24, 8.19;
                   50, 3.10, 3.69, 4.25, 4.59, 4.80, 4.95, 5.00, 6.06, 6.36, 6.65, 7.52;
                   55, 2.86, 3.35, 4.06, 4.38, 4.56, 4.65, 4.80, 5.90, 6.20, 6.47, 7.32;
                   60, 2.53, 2.92, 3.41, 3.65, 3.80, 3.60, 3.85, 4.81, 5.05, 5.28, 5.97;
                   65, 0.00, 2.83, 3.10, 3.30, 3.43, 3.20, 3.35, 4.26, 4.47, 4.67, 5.29],

    mFlow_conNom=7.8/4180/5, //A7W35
    mFlow_evaNom=1,
    tableUppBou=[-25, 65; 40, 70]);

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(revisions="<html><ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>", info="<html>
<p>
  According to manufacturer's data which was inter- and extrapolated
  linearly; EN14511
</p>
</html>"));
end Hansetherm_HT_R290G_8_B;
