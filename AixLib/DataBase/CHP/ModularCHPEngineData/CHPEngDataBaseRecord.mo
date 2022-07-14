within AixLib.DataBase.CHP.ModularCHPEngineData;
record CHPEngDataBaseRecord "Base record for CHP engine data"
  extends Modelica.Icons.Record;

  //Engine parameters

  constant Boolean SIEngine = true "Default:True=SI-Engine(Otto) / False=DI-Engine(Diesel)";
  constant String EngMat = "CastIron" "Name of the engine material(Choices: CastIron, SpheroidalGraphiteIron, CastAluminium)";
  type RotationSpeed=Real(final unit="1/s", min=0);
  constant RotationSpeed nEngMax = nEngNominal "Engine speed at full load (default=nEngNominal)";
  constant RotationSpeed nEngNominal "Nominal engine speed at nominal operating point";
  constant Real QuoDCyl = dCyl/ref_dCyl "Comparison of cylinder diameter to the reference";
  constant Real xO2Exh = 0.05 "Residual oxygen content in the exhaust gas(default value is 5%)";
  type AirRatio=Real(final unit="1", min=1.01);
  constant Real Lambda = 0.21 / (0.21 - xO2Exh) "Engine air ratio (default value is 1.31; min=1.01)";
  constant Real z "Number of cylinders";
  constant Real eps = if SIEngine then 12 else 21 "Compression ratio (default values are 12(SI) and 21(DI))";
  constant Real i "Number of combustion for one operating cycle (1->two-stroke, 0.5->four-stroke)";
  constant Modelica.Units.SI.Mass mEng=70389*VEng + 17.913
    "Total dry weight of the engine block";
  constant Modelica.Units.SI.Volume VEng=0.25*hStr*Modelica.Constants.pi*dCyl^2
      *z "Engine displacement";
  constant Modelica.Units.SI.Length hStr "Stroke";
  constant Modelica.Units.SI.Length dCyl(min=0.01) "Cylinder diameter";
  constant Modelica.Units.SI.Length ref_dCyl=0.091
    "Reference cylinder diameter for friction calculation";
  constant Modelica.Units.SI.Pressure ref_p_mfNominal=if SIEngine then 75000
       else 110000
    "Friction mean pressure of reference engine for calculation(dCyl=91mm & nEng=3000rpm & TEng=90°C)";
  constant Modelica.Units.SI.Pressure p_meNominal=P_mecNominal/(i*nEngNominal*
      VEng) "Nominal mean effective cylinder pressure";
  constant Modelica.Units.SI.Efficiency etaCHP
    "Nominal efficiency of the power unit referring to the fuel input";
  constant Modelica.Units.SI.Efficiency etaGen=0.92 "Generator efficiency";
  constant Modelica.Units.SI.Power P_mecNominal=P_elNominal/etaGen
    "Mechanical power output of the engine at nominal operating point";
  constant Modelica.Units.SI.Power P_FueNominal=(P_elNominal + Q_MaxHea)/etaCHP
    "Nominal fuel expenses";
  constant Modelica.Units.SI.Power Q_MaxHea "Maximum of usable heat";
  constant Modelica.Units.SI.Temperature T_ExhPowUniOut=373.15
    "Exhaust gas temperature after exhaust heat exchanger (default=100°C)";

  //General CHP parameters

  constant Modelica.Units.SI.Diameter dExh=0.0612 + (Lambda*P_FueNominal)*10^(-7)
    "Exhaust pipe diameter for heat transfer calculation";
  constant Modelica.Units.SI.Diameter dCoo=0.0224 + Q_MaxHea*2*10^(-7)
    "Coolant circle pipe diameter for heat transfer calculation";
  constant Modelica.Units.SI.Thickness dInn
    "Thickness of the cylinder wall between combustion chamber and cooling circle (default value is 5mm)";
  constant Modelica.Units.SI.MassFlowRate m_floCooNominal=0.00003*Q_MaxHea -
      0.2043
    "Nominal mass flow rate of coolant inside the engine cooling circle (default density of coolant is 1kg/l)";
  constant Modelica.Units.SI.Pressure dp_Coo=15000
    "Pressure loss between coolant supply and return flow (default value is 0.15bar)";

  //Electric power converter (as an induction machine)

  constant Real cosPhi=0.8 "Power factor of electric machine (default=0.8)";
  constant Real p=f_1/n0 "Number of pole pairs";
  constant Real gearRatio=1 "Gear ratio: engine speed to generator speed (default=1)";
  constant Boolean useHeat=false "Is the thermal loss energy of the elctric machine used?";
  constant Modelica.Units.SI.Frequency n0=f_1/p
    "Idling speed of the electric machine";
  constant Modelica.Units.SI.Frequency n_nominal "Rated rotor speed [1/s]";
  constant Modelica.Units.SI.Frequency f_1 "Source frequency";
  constant Modelica.Units.SI.Voltage U_1 "Rated voltage";
  constant Modelica.Units.SI.Current I_elNominal=P_elNominal/(sqrt(3)*U_1*
      cosPhi) "Rated current";
  constant Modelica.Units.SI.Power P_elNominal
    "Nominal electrical power of electric machine";

  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Data base record for CHP power units. The nominal / rated operation
  point most likely corresponds to the given full load performance.
</p>
<h4>
  <span style=\"color: #008000\">Requirements</span>
</h4>
<p>
  These quantities <u><b>must</b></u> be known for reliable simulation
  (by value, variable relation etc.):
</p>
<p>
  - <u>Heat and Power:</u> <b>Q_MaxHea</b>, <b>etaCHP(Hi)</b>
</p>
<p>
  - <u>Engine Geometry:</u> <b>hStr</b>, <b>dCyl</b>, <b>z</b>,
  <b>i</b>
</p>
<p>
  - <u>Generator specification:</u> <b>p</b> or <b>n0, n_nominal, U_1,
  P_elNominal, f_1</b>
</p>
<p>
  - <b>Lambda</b> or <b>xO2Exh</b>: Required for calculation of the
  engine combustion, heat flow and the exhaust gas composition (Lambda
  = 0.21 / (0.21 - xO2Exh))
</p>
<p>
  - <b>nEngNominal</b>
</p>
<p>
  - <b>dInn</b> (typical values around 0.005m, important for heat
  transfer from engine to cooling)
</p>
<h4>
  <span style=\"color: #008000\">Default values and variable
  relations</span>
</h4>
<p>
  These are the default values or relations in case that there is no
  information available:
</p>
<p>
  - <b>nEngMax</b>: Engine&#160;speed&#160;at&#160;full&#160;load
  (=nEngNominal)
</p>
<p>
  - <b>etaGen</b>: Generator efficiency (default=0.92)
</p>
<p>
  - <b>I_elNominal</b> (=P_elNominal/(sqrt(3)*U_1*cosPhi))
</p>
<p>
  - <b>P_mecNominal</b> (=P_elNominal/etaGen)
</p>
<p>
  - <b>P_FueNominal</b> (=(P_elNominal+Q_MaxHea)/etaCHP)
</p>
<p>
  - <b>VEng</b> (default=0.25*hStr*Modelica.Constants.pi*dCyl^2*z)
</p>
<p>
  - <b>mEng</b> (default=70389*VEng+17.913, for first appraisal of the
  heat capacities of engine housing, should be calibrated)
</p>
<p>
  - <b>eps</b> (typical values around 12 (SI) and 21 (DI))
</p>
<p>
  - <b>T_ExhPowOut</b> (default=373.15K)
</p>
<p>
  - <b>gearRatio</b> (default=1)
</p>
<p>
  - <b>cosPhi</b> (default=0.8)
</p>
<p>
  - <b>useGenHeat</b> (default=false)
</p>
<p>
  - <u>Exhaust and Coolant:</u> <b>dExh</b>(default=0.06m),
  <b>dCoo</b>(default=0.04m), <b>dp_Coo</b>(default=0.15bar)<b>,
  m_flowCooNominal</b>(default=0.00003*Q_MaxHea-0.2043)
</p>
<p>
  - <u>Engine material:</u> <b>lambda</b>, <b>rhoEngWall</b>, <b>c</b>
  (default is cast iron(most common))
</p>
</html>"));
end CHPEngDataBaseRecord;
