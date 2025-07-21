within AixLib.DataBase.HeatPump.EN14511;
record Dimplex_SIH_40TE "Dimplex_SIH_40TE"
  extends AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition(
    tableP_ele=[
  0,-5,     0,       5,       10,      15,      20,      25;
  35, 8026.49007, 8350.99338, 8582.78146, 8721.85431, 8721.85431, 8860.92715, 9000.00000;
  50, 10668.87417, 10668.87417, 10761.58940, 11039.73510, 11132.45033, 11410.59603, 11596.02649;
  65, 14192.05298, 14377.48344, 14562.91391, 14562.91391, 14794.70199, 15026.49007, 15119.20530],

    tableQdot_con=[
  0,-5,     0,       5,       10,      15,      20,      25;
  35, 29609.08808, 36700.81366, 41887.77733, 47210.97328, 52397.93695, 57448.84621, 62635.98773;
  50, 29472.85581, 33163.39869, 38894.58005, 44625.93926, 50493.17505, 56360.58868, 62091.77004;
  65, 28792.58370, 31938.90890, 37806.14468, 43537.50389, 49404.91752, 55272.15331, 61139.38909],
    mFlow_conNom=37806.14468/4180/5, // A10/W55
    mFlow_evaNom=1,
    tableUppBou=[-25, 65; 25, 75]);

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
end Dimplex_SIH_40TE;
