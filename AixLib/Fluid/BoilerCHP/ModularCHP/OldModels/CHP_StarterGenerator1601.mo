within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model CHP_StarterGenerator1601
  "Model of a general induction machine working as a starter generator"
  extends Modelica.Electrical.Machines.Icons.TransientMachine;

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngData=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "Needed engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  parameter Modelica.SIunits.Frequency n0=CHPEngData.n0
    "Idling speed of the electric machine"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Frequency n_nominal=CHPEngData.n_nominal
                                                         "Rated rotor speed"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Frequency f_1=CHPEngData.f_1
                                              "Frequency"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Voltage U_1=CHPEngData.U_1
                                             "Rated voltage"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Current I_elNominal=CHPEngData.I_elNominal
                                                      "Rated current"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Current I_1_start=if P_Mec_nominal<=15000 then 7.2*I_elNominal else 8*I_elNominal
    "Motor start current (realistic factors used from DIN VDE 2650/2651)"
    annotation (Dialog(                           tab="Calculations"));
  parameter Modelica.SIunits.Power P_elNominal=CHPEngData.P_elNominal
    "Nominal electrical power of electric machine"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Power P_Mec_nominal=P_elNominal*(1-s_nominal) "Nominal mechanical power of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.SIunits.Torque M_nominal=P_Mec_nominal/(2*Modelica.Constants.pi*n_nominal) "Nominal torque of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.SIunits.Torque M_til=2*M_nominal "Tilting torque of electric machine (realistic factor used from DIN VDE 2650/2651)"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.SIunits.Torque M_start=if P_Mec_nominal<=4000 then 1.6*M_nominal
  elseif P_Mec_nominal>=22000 then 1*M_nominal else 1.25*M_nominal
   "Tilting torque of electric machine (realistic factor used from DIN VDE 2650/2651)"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.SIunits.Inertia J_Gen=0.3
    "Moment of inertia of the electric machine (default=0.5kg.m2)"
    annotation (Dialog(group="Calibration"));
  parameter Boolean useHeat=CHPEngData.useHeat
    "Is the thermal loss energy of the elctric machine used?"
    annotation (Dialog(group="Machine specifications"));
  parameter Real s_nominal=abs(1-n_nominal*p/f_1) "Nominal slip of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Real s_til=abs((s_nominal*(M_til/M_nominal)+s_nominal*sqrt(abs(((M_til/M_nominal)^2)-1+2*s_nominal*((M_til/M_nominal)-1))))/(1-2*s_nominal*((M_til/M_nominal)-1)))
   "Tilting slip of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Real p=CHPEngData.p
                     "Number of pole pairs"
    annotation (Dialog(group="Machine specifications"));
  parameter Real cosPhi=CHPEngData.cosPhi
                            "Power factor of electric machine (default=0.8)"
    annotation (Dialog(group="Machine specifications"));
  parameter Real gearRatio=CHPEngData.gearRatio
                             "Transmission ratio (engine speed / generator speed)"
    annotation (Dialog(group="Machine specifications"));
  parameter Real rho0=s_til^2 "Calculation variable for analytical approach (Aree, 2017)"
    annotation (Dialog(tab="Calculations"));
  parameter Real rho1=(M_start*(1+s_til^2)-2*s_til*M_til)/(M_til-M_start) "Calculation variable for analytical approach (Aree, 2017)"
    annotation (Dialog(tab="Calculations"));
  parameter Real rho3=(M_til*M_start*(1-s_til^2))/(M_til-M_start) "Calculation variable for analytical approach (Aree, 2017)"
    annotation (Dialog(tab="Calculations"));
  parameter Real k=((I_elNominal/I_1_start)^2)*(((s_nominal^2)+rho1*s_nominal+rho0)/(1+rho1+rho0)) "Calculation variable for analytical approach (Aree, 2017)"
    annotation (Dialog(tab="Calculations"));

  Modelica.SIunits.Frequency n=inertia.w/(2*Modelica.Constants.pi) "Speed of machine rotor [1/s]";
  Modelica.SIunits.Current I_1 "Electric current of machine stator";
  Modelica.SIunits.Power P_E "Electrical power at the electric machine";
  Modelica.SIunits.Power P_Mec "Mechanical power at the electric machine";
  Modelica.SIunits.Power CalQ_Therm
    "Calculated heat flow from electric machine";
  Modelica.SIunits.Power Q_Therm=if useHeat then CalQ_Therm else 0
    "Heat flow from electric machine"
    annotation (Dialog(group="Machine specifications"));
  Modelica.SIunits.Torque M "Torque at electric machine";
  Real s=1-n*p/f_1 "Current slip of electric machine";
  Real eta "Total efficiency of the electric machine (as motor)";
  Real calI_1 = 1/(1+((k-1)/((s_nominal^2)-k))*((s^2)+rho1*abs(s)+rho0));
  Boolean OpMode = (n<=n0) "Operation mode (true=motor, false=generator)";
  Boolean SwitchOnOff=isOn "Operation of electric machine (true=On, false=Off)";
  Modelica.Mechanics.Rotational.Components.Inertia inertia(       w(fixed=false), J=J_Gen)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.RealExpression electricTorque(y=M)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-8,-36})));
  Modelica.Blocks.Sources.RealExpression machineHeat(y=if SwitchOnOff then
        Q_Therm else 0)
    annotation (Placement(transformation(extent={{48,-46},{28,-26}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-126,-20},{-86,20}}),
        iconTransformation(extent={{-112,-14},{-84,14}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_GeneratorHeat
    annotation (Placement(transformation(extent={{-110,-108},{-90,-88}})));
  Modelica.Mechanics.Rotational.Components.IdealGear gearEngineToGenerator(
      ratio=gearRatio)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));

equation

if SwitchOnOff then

  I_1=sign(s)*I_1_start*sqrt(abs((1+((k-1)/((s_nominal^2)-k))*(s^2)*(1+rho1+rho0))*calI_1));
  P_E=if noEvent(s>0) then sqrt(3)*I_1*U_1*cosPhi elseif noEvent(s<0) then P_Mec-CalQ_Therm else 1;
  P_Mec=if noEvent(s>0) then 2*Modelica.Constants.pi*n*M-CalQ_Therm else 2*Modelica.Constants.pi*n*M;
  CalQ_Therm=s*P_E;
  M=sign(s)*(rho3*abs(s))/((s^2)+rho1*abs(s)+rho0);
  eta=if noEvent(s>0) then abs(P_Mec/(P_E+1))
  elseif noEvent(s<0) then abs(P_E/(P_Mec+1)) else 0;

else

  I_1=0;
  P_E=0;
  P_Mec=0;
  CalQ_Therm=0;
  M=0;
  eta=0;

  end if;

  connect(electricTorque.y, torque.tau)
    annotation (Line(points={{-39,0},{-22,0}}, color={0,0,127}));
  connect(machineHeat.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{27,-36},{2,-36}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, port_GeneratorHeat) annotation (Line(points={
          {-18,-36},{-100,-36},{-100,-98}}, color={191,0,0}));
  connect(torque.flange, inertia.flange_a)
    annotation (Line(points={{0,0},{20,0}}, color={0,0,0}));
  connect(inertia.flange_b, gearEngineToGenerator.flange_b)
    annotation (Line(points={{40,0},{60,0}}, color={0,0,0}));
  connect(gearEngineToGenerator.flange_a, flange_a)
    annotation (Line(points={{80,0},{100,0}}, color={0,0,0}));
  annotation (Documentation(info="<html>
<p>Model of an electric induction machine that includes the calculation of:</p>
<p>-&gt; mechanical output (torque and speed)</p>
<p>-&gt; electrical output (current and power)</p>
<p>It delivers positive torque and negative electrical power when operating below the synchronous speed (motor) and can switch into generating electricity (positive electrical power and negative torque) when operating above the synchronous speed (generator).</p>
<p>The calculations are based on simple electrical equations and an analytical approach by Pichai Aree (2017) that determinates stator current and torque depending on the slip.</p>
<p>The parameters rho0, rho1, rho3 and k are used for the calculation of the characteristic curves. They are determined from the general machine data at nominal operation and realistic assumptions about the ratio between starting torque, starting current, breakdown torque, breakdown slip and nominal current and torque. These assumptions are taken from DIN VDE 2650/2651. It shows good agreement for machines up to 100kW of mechanical power operating at a speed up to 3000rpm and with a rated voltage up to 500V.</p>
<p>The only data required is:</p>
<p>- number of polepairs or synchronous speed</p>
<p>- voltage and frequence of the electric power supply</p>
<p>- nominal current, speed</p>
<p>- power factor if available (default=0.8)</p>
<p><br>- Electric power calculation as a generator from mechanical input speed can be further approached by small changes to the speed.</p>
</html>"));
end CHP_StarterGenerator1601;
