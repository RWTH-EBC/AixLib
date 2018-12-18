within AixLib.Fluid.BoilerCHP.ModularCHP.MediaModelsAndEngineRecords;
record CHPEngDataBaseRecord "Base record for CHP engine data"
  extends Modelica.Icons.Record;

  constant Boolean SIEngine = true "Default:True=SI-Engine(Otto) / False=DI-Engine(Diesel)";
  constant Modelica.SIunits.Volume VEng  "Engine displacement";
  constant Modelica.SIunits.Length hStr    "Stroke";
  constant Modelica.SIunits.Length dCyl(min=0.01)=0.091 "Cylinder diameter";
  constant Modelica.SIunits.Length ref_dCyl=0.091 "Reference cylinder diameter for friction calculation";
  constant Real QuoDCyl = dCyl/ref_dCyl "Comparison of cylinder diameter to the reference";
  constant Modelica.SIunits.Thickness dInn = 0.005 "Thickness of the cylinder wall between combustion chamber and cooling circle (default value is 5mm)";
  constant Modelica.SIunits.ThermalConductivity lambda=44.5 "Thermal conductivity of the engine block material (default value is 44.5)";
  constant Modelica.SIunits.Density rhoEngWall=72000 "Density of the the engine block material (default value is 72000)";
  constant Modelica.SIunits.SpecificHeatCapacity c=535 "Specific heat capacity of the cylinder wall material (default value is 535)";
  type RotationSpeed=Real(final unit="1/s", min=0);
  constant RotationSpeed nEngMax "Engine speed at full load";
  constant RotationSpeed nEngNom "Nominal engine speed at nominal operating point";
  constant Real xO2Exh = 0.05 "Residual oxygen content in the exhaust gas(default value is 5%)";
  constant Real z "Number of cylinders";
  constant Real eps "Compression ratio";
  constant Real i "Number of combustion for one operating cycle (1->two-stroke, 0.5->four-stroke)";
  constant Modelica.SIunits.Mass mEng "Total dry weight of the engine block";
  constant Modelica.SIunits.Pressure ref_p_mfNom = if SIEngine then 75000 else 110000 "Friction mean pressure of reference engine for calculation(dCyl=91mm & nEng=3000rpm & TEng=90°C)";
  constant Modelica.SIunits.Pressure p_meNom = P_mecNom/(i*nEngNom*VEng) "Nominal mean effective cylinder pressure";
  constant Modelica.SIunits.Efficiency etaMecEng "Nominal mechanical efficiency of the engine referring to the fuel input";
  constant Modelica.SIunits.Power P_mecNom "Mechanical power output at nominal operating point";
  constant Modelica.SIunits.Power P_MaxFue "Maximum fuel expenses";
  constant Modelica.SIunits.Power Q_MaxHea "Maximum of usable heat";
  constant Modelica.SIunits.Temperature T_ExhPowUniOut   "Exhaust gas temperature after exhaust heat exchanger";

end CHPEngDataBaseRecord;
