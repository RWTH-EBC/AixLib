within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
record CHPEngDataBaseRecord_MaterialData "Base record for CHP engine data"
  extends Modelica.Icons.Record;

  constant Boolean SIEngine = true "Default:True=SI-Engine(Otto) / False=DI-Engine(Diesel)";
  constant String EngMat = "CastIron" "Name of the engine material(Choices: CastIron, SpheroidalGraphiteIron, CastAluminium)";
  type RotationSpeed=Real(final unit="1/s", min=0);
  constant RotationSpeed nEngMax = nEngNominal "Engine speed at full load (default=nEngNominal)";
  constant RotationSpeed nEngNominal "Nominal engine speed at nominal operating point";
  constant Real QuoDCyl = dCyl/ref_dCyl "Comparison of cylinder diameter to the reference";
  constant Real xO2Exh = 0.05 "Residual oxygen content in the exhaust gas(default value is 5%)";
  constant Real Lambda = 0.21 / (0.21 - xO2Exh) "Engine air ratio (default value is 1.31)";
  constant Real z "Number of cylinders";
  constant Real eps = if SIEngine then 12 else 21 "Compression ratio (default values are 12(SI) and 21(DI))";
  constant Real i "Number of combustion for one operating cycle (1->two-stroke, 0.5->four-stroke)";
  constant Modelica.SIunits.Volume VEng = 0.25*hStr*Modelica.Constants.pi*dCyl^2*z "Engine displacement";
  constant Modelica.SIunits.Length hStr "Stroke";
  constant Modelica.SIunits.Length dCyl(min=0.01) "Cylinder diameter";
  constant Modelica.SIunits.Length ref_dCyl=0.091 "Reference cylinder diameter for friction calculation";
  constant Modelica.SIunits.Diameter dExh = 0.06 "Exhaust pipe diameter for heat transfer calculation";
  constant Modelica.SIunits.Diameter dCoo = 0.03175 "Coolant circle pipe diameter for heat transfer calculation";
  constant Modelica.SIunits.Thickness dInn "Thickness of the cylinder wall between combustion chamber and cooling circle (default value is 5mm)";
  constant Modelica.SIunits.ThermalConductivity lambda = 44.5 "Thermal conductivity of the engine block material (default value is 44.5)";
  constant Modelica.SIunits.Density rhoEngWall = 72000 "Density of the the engine block material (default value is 72000)";
  constant Modelica.SIunits.SpecificHeatCapacity c = 535 "Specific heat capacity of the cylinder wall material (default value is 535)";
  constant Modelica.SIunits.MassFlowRate m_floCooNominal = 0.00003*Q_MaxHea-0.2043 "Nominal mass flow rate of coolant inside the engine cooling circle (default value is 0,5556kg/s)";
  constant Modelica.SIunits.Mass mEng = 70389*VEng+17.913 "Total dry weight of the engine block";
  constant Modelica.SIunits.Pressure ref_p_mfNominal = if SIEngine then 75000 else 110000 "Friction mean pressure of reference engine for calculation(dCyl=91mm & nEng=3000rpm & TEng=90°C)";
  constant Modelica.SIunits.Pressure p_meNominal = P_mecNominal/(i*nEngNominal*VEng) "Nominal mean effective cylinder pressure";
  constant Modelica.SIunits.Pressure dp_Coo = 15000 "Pressure loss between coolant supply and return flow (default value is 0.15bar)";
  constant Modelica.SIunits.Efficiency etaCHP "Nominal efficiency of the power unit referring to the fuel input";
  constant Modelica.SIunits.Efficiency etaGen = 0.92 "Generator efficiency";
  constant Modelica.SIunits.Power P_mecNominal = P_elNominal/etaGen "Mechanical power output at nominal operating point";
  constant Modelica.SIunits.Power P_elNominal "Electrical power output at nominal operating point";
  constant Modelica.SIunits.Power P_FueNominal = (P_elNominal+Q_MaxHea)/etaCHP "Nominal fuel expenses";
  constant Modelica.SIunits.Power Q_MaxHea "Maximum of usable heat";
  constant Modelica.SIunits.Temperature T_ExhPowUniOut "Exhaust gas temperature after exhaust heat exchanger";

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Data base record for CHP power units.</p>
<h4><span style=\"color: #008000\">Requirements</span></h4>
<p>These quantities <u><b>must</b></u> be known for reliable simulation (by value, variable relation etc.):</p>
<p>- <u>Heat and Power:</u> <b>P_elNominal</b>, <b>Q_MaxHea</b>, <b>etaCHP(Hi)</b></p>
<p>- <u>Engine Geometry:</u> <b>hStr</b>, <b>dCyl</b>, <b>z</b>, <b>i</b></p>
<p>- <b>Lambda</b> or <b>xO2Exh</b>: Required for calculation of the engine combustion, heat flow and the exhaust gas composition (Lambda = 0.21 / (0.21 - xO2Exh))</p>
<p>- <b>nEngNominal</b></p>
<p><b>- T_ExhPowOut </b>(typical values around 373K, needed for calculation of exhaust gas enthalpy)</p>
<p>- <b>dInn</b> (typical values around 0.005m, important for heat transfer from engine to cooling)</p>
<h4><span style=\"color: #008000\">Default values and variable relations </span></h4>
<p>These are the default values or relations in case that there is no information available:</p>
<p>- <b>nEngMax</b>: Engine&nbsp;speed&nbsp;at&nbsp;full&nbsp;load (=nEngNominal)</p>
<p>- <b>etaGen</b>: Generator efficiency (default=0.92)</p>
<p>- <b>P_mecNominal</b> (=P_elNominal/etaGen)</p>
<p>- <b>P_FueNominal</b> (=(P_elNominal+Q_MaxHea)/etaCHP)</p>
<p>- <b>VEng</b> (default=0.25*hStr*Modelica.Constants.pi*dCyl^2*z)</p>
<p>- <b>mEng</b> (default=70389*VEng+17.913, for first appraisal of the heat capacities of engine housing, should be calibrated)</p>
<p>- <b>eps</b> (typical values around 12 (SI) and 21 (DI))</p>
<p>- <u>Exhaust and Coolant:</u> <b>dExh</b>(default=0.06m), <b>dCoo</b>(default=0.04m), <b>dp_Coo</b>(default=0.15bar)<b>, m_flowCooNominal</b>(default=0.00003*Q_MaxHea-0.2043)</p>
<p>- <u>Engine material:</u> <b>lambda</b>, <b>rhoEngWall</b>, <b>c </b>(default is cast iron(most common))</p>
</html>"));
end CHPEngDataBaseRecord_MaterialData;
