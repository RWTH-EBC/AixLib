within AixLib.Electrical.Machines;
model InductionMachine
  "Model of a general induction machine working as generator or electric motor"
  import AixLib;
  extends Modelica.Electrical.Machines.Icons.TransientMachine;

  parameter Modelica.Units.SI.Frequency n0=f_1/p
    "Idling speed of the electric machine"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.Units.SI.Frequency n_nominal=1530/60 "Rated rotor speed"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.Units.SI.Frequency f_1=50 "Frequency"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.Units.SI.Voltage U_1=400 "Rated voltage"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.Units.SI.Current I_elNominal=P_elNominal/(sqrt(3)*U_1*
      cosPhi) "Rated current"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.Units.SI.Current I_1_start=if P_Mec_nominal <= 15000 then
      7.2*I_elNominal else 8*I_elNominal
    "Motor start current (realistic factors used from DIN VDE 2650/2651)"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.Units.SI.Power P_elNominal=15000
    "Nominal electrical power of electric machine"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.Units.SI.Power P_Mec_nominal=P_elNominal*(1 + s_nominal/
      0.22) "Nominal mechanical power of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.Units.SI.Torque M_nominal=P_Mec_nominal/(2*Modelica.Constants.pi
      *n_nominal) "Nominal torque of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.Units.SI.Torque M_til=2*M_nominal
    "Tilting torque of electric machine (realistic factor used from DIN VDE 2650/2651)"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.Units.SI.Torque M_start=if P_Mec_nominal <= 4000 then 1.6*
      M_nominal elseif P_Mec_nominal >= 22000 then 1*M_nominal else 1.25*
      M_nominal
    "Starting torque of electric machine (realistic factor used from DIN VDE 2650/2651)"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.Units.SI.Inertia J_Gen=1
    "Moment of inertia of the electric machine (default=0.5kg.m2)"
    annotation (Dialog(group="Calibration"));
  parameter Real s_nominal=abs(1-n_nominal*p/f_1) "Nominal slip of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Real s_til=abs((s_nominal*(M_til/M_nominal)+s_nominal*sqrt(abs(((M_til/M_nominal)^2)-1+2*s_nominal*((M_til/M_nominal)-1))))/(1-2*s_nominal*((M_til/M_nominal)-1)))
   "Tilting slip of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Real p=2 "Number of pole pairs"
    annotation (Dialog(group="Machine specifications"));
  parameter Real cosPhi=0.8 "Power factor of electric machine (default=0.8)"
    annotation (Dialog(group="Machine specifications"));
  parameter Real calFac=1
    "Calibration factor for electric power outuput (default=1)"
    annotation (Dialog(group="Calibration"));
  parameter Real gearRatio=1 "Transmission ratio (engine speed / generator speed)"
    annotation (Dialog(group="Machine specifications"));

  Modelica.Units.SI.Frequency n=inertia.w/(2*Modelica.Constants.pi)
    "Speed of machine rotor [1/s]";
  Modelica.Units.SI.Current I_1 "Electric current of machine stator";
  Modelica.Units.SI.Power P_E "Electrical power at the electric machine";
  Modelica.Units.SI.Power P_Mec "Mechanical power at the electric machine";
  Modelica.Units.SI.Power CalQ_Loss
    "Calculated heat flow from electric machine";
  Modelica.Units.SI.Torque M "Torque at electric machine";
  Real s=1-n*p/f_1 "Current slip of electric machine";
  Real eta "Total efficiency of the electric machine (as motor)";
  Real calI_1 = 1/(1+((k-1)/((s_nominal^2)-k))*((s^2)+rho1*abs(s)+rho0));
  Boolean OpMode = (n<=n0) "Operation mode (true=motor, false=generator)";
  Boolean SwitchOnOff = isOn "Operation of electric machine (true=On, false=Off)";
  Modelica.Mechanics.Rotational.Components.Inertia inertia(       w(fixed=false), J=J_Gen)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression electricTorque(y=M)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_Machine
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Mechanics.Rotational.Components.IdealGear transmission(ratio=
        gearRatio)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-106,0}), iconTransformation(extent={{-100,-20},{-60,20}})));
  Modelica.Blocks.Interfaces.RealOutput electricCurrent annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,74}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,74})));
  Modelica.Blocks.Interfaces.RealOutput electricPower annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,74}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,74})));
  Modelica.Blocks.Interfaces.RealOutput rotationalSpeed annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,74}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,74})));
  Modelica.Blocks.Sources.RealExpression current(y=I_1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,34})));
  Modelica.Blocks.Sources.RealExpression power(y=P_E) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,34})));
  Modelica.Blocks.Sources.RealExpression speed(y=n) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,34})));

protected
  parameter Real rho0=s_til^2 "Calculation variable for analytical approach (Aree, 2017)"
    annotation (Dialog(tab="Calculations"));
  parameter Real rho1=(M_start*(1+s_til^2)-2*s_til*M_til)/(M_til-M_start) "Calculation variable for analytical approach (Aree, 2017)"
    annotation (Dialog(tab="Calculations"));
  parameter Real rho3=(M_til*M_start*(1-s_til)^2)/(M_til-M_start) "Calculation variable for analytical approach (Aree, 2017)"
    annotation (Dialog(tab="Calculations"));
  parameter Real k=((I_elNominal/I_1_start)^2)*(((s_nominal^2)+rho1*s_nominal+rho0)/(1+rho1+rho0)) "Calculation variable for analytical approach (Aree, 2017)"
    annotation (Dialog(tab="Calculations"));

equation

if noEvent(SwitchOnOff) then

  I_1=sign(s)*I_1_start*sqrt(abs((1+((k-1)/((s_nominal^2)-k))*(s^2)*(1+rho1+rho0))*calI_1));
  P_E=if noEvent(s>0) then sqrt(3)*I_1*U_1*cosPhi elseif noEvent(s<0) then calFac*(P_Mec+CalQ_Loss) else 1;
  P_Mec=2*Modelica.Constants.pi*M*n;
  CalQ_Loss= (calFac-1)*P_E + 2*Modelica.Constants.pi*M*(s*n0)/0.22;
  M=sign(s)*(rho3*abs(s))/((s^2)+rho1*abs(s)+rho0);
  eta=if noEvent(s>0) then abs(P_Mec/(P_E+1))
  elseif noEvent(s<0) then abs(P_E/(P_Mec-1)) else 0;

else

  I_1=0;
  P_E=0;
  P_Mec=0;
  CalQ_Loss=0;
  M=if noEvent(s<0) then sign(s)*(rho3*abs(s))/((s^2)+rho1*abs(s)+rho0) else 0;
  eta=0;

  end if;

  connect(electricTorque.y, torque.tau)
    annotation (Line(points={{-39,0},{-22,0}}, color={0,0,127}));
  connect(torque.flange, inertia.flange_a)
    annotation (Line(points={{0,0},{20,0}}, color={0,0,0}));
  connect(inertia.flange_b, transmission.flange_b)
    annotation (Line(points={{40,0},{60,0}}, color={0,0,0}));
  connect(transmission.flange_a, flange_Machine)
    annotation (Line(points={{80,0},{100,0}}, color={0,0,0}));
  connect(current.y, electricCurrent)
    annotation (Line(points={{-40,45},{-40,74}}, color={0,0,127}));
  connect(power.y, electricPower)
    annotation (Line(points={{0,45},{0,74}}, color={0,0,127}));
  connect(speed.y, rotationalSpeed)
    annotation (Line(points={{40,45},{40,74}}, color={0,0,127}));
  annotation (Documentation(info="<html><p>
  Model of an electric induction machine that includes the calculation
  of:
</p>
<p>
  -&gt; mechanical output (torque and speed)
</p>
<p>
  -&gt; electrical output (current and power)
</p>
<p>
  It delivers positive torque and negative electrical power when
  operating below the synchronous speed (motor) and can switch into
  generating electricity (positive electrical power and negative
  torque) when operating above the synchronous speed (generator).
</p>
<p>
  The calculations are based on simple electrical equations and an
  analytical approach by Pichai Aree (2017) that determinates stator
  current and torque depending on the slip.
</p>
<p>
  The parameters rho0, rho1, rho3 and k are used for the calculation of
  the characteristic curves. They are determined from the general
  machine data at nominal operation and realistic assumptions about the
  ratio between starting torque, starting current, breakdown torque,
  breakdown slip and nominal current and torque. These assumptions are
  taken from DIN VDE 2650/2651. It shows good agreement for machines up
  to 100kW of mechanical power operating at a speed up to 3000rpm and
  with a rated voltage up to 500V.
</p>
<p>
  The only data required is:
</p>
<p>
  - number of polepairs or synchronous speed (<b>p</b> or <b>n0</b>)
</p>
<p>
  - voltage and frequence of the electric power supply (<b>U_1</b> and
  <b>f_1</b>)
</p>
<p>
  - nominal current and speed (<b>I_elNominal</b> and <b>n_nominal</b>
  )
</p>
<p>
  - power factor if available (default=0.8)
</p>
<p>
  <br/>
  Additional Information:
</p>
<p>
  <br/>
  - Electric power calculation as a generator from mechanical input
  speed can be further approached by small changes to the speed.
</p>
<p>
  - The electric losses are calculated from the slip depending rotor
  loss which corresponds to roughly 22% of the total losses according
  to Almeida (DOI: 10.1109/MIAS.2010.939427).
</p>
</html>",
        revisions="<html><ul>
  <li>January, 2019, by Julian Matthes:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">issue
    6</a><u><span style=\"color: #0000ff;\">67</span></u>).
  </li>
</ul>
</html>"), Icon(graphics={
        Text(
          extent={{-40,24},{80,8}},
          lineColor={0,0,0},
          textStyle={TextStyle.Bold},
          textString="%name")}));
end InductionMachine;
