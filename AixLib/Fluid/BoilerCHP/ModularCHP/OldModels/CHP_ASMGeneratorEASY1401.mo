within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model CHP_ASMGeneratorEASY1401
  "Model of an asynchronous electric machine working as a starter generator"
  extends Modelica.Electrical.Machines.Icons.TransientMachine;

  parameter Modelica.SIunits.Frequency n0=f_1/p
    "Idling speed of the electric machine"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Frequency n_nominal=1530/60 "Rated rotor speed"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Power PRef=0 annotation (Dialog(tab="Advanced"));
  parameter Modelica.SIunits.AngularFrequency wRef=2*Modelica.Constants.pi*f_1/
      p annotation (Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Frequency f_1=50 "Frequency"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Voltage U_1=400 "Rated voltage"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Current I_1_nominal=27.4 "Rated current"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Current I_1_start=7.2*I_1_nominal
    "Motor start current (realistic factor used from DIN VDE 2650/2651)"
    annotation (Dialog(                           tab="Calculations"));
  parameter Modelica.SIunits.Inductance X_1=1.74 "Stator inductance"
    annotation (Dialog(tab="Advanced", group="Equivalent circle"));
  parameter Modelica.SIunits.Inductance X_2=1.69 "Rotor inductance"
    annotation (Dialog(tab="Advanced", group="Equivalent circle"));
  parameter Modelica.SIunits.Resistance R_2=0.58 "Rotor resistance"
    annotation (Dialog(tab="Advanced", group="Equivalent circle"));
  parameter Modelica.SIunits.Power P_E_nominal=sqrt(3)*U_1*I_1_nominal*cosPhi "Nominal electrical power of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.SIunits.Power P_Mec_nominal=P_E_nominal*(1-s_nominal) "Nominal mechanical power of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.SIunits.Power Q_Therm=1500 "Heat flow from electric machine"
    annotation (Dialog(group="Machine specifications"));
  parameter Modelica.SIunits.Torque M_nominal=P_Mec_nominal/(2*Modelica.Constants.pi*n_nominal) "Nominal torque of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Modelica.SIunits.Torque M_til=2.25*M_nominal "Tilting torque of electric machine (realistic factor used from DIN VDE 2650/2651)"
    annotation (Dialog(tab="Calculations"));
  parameter Real s_nominal=1-n_nominal*p/f_1 "Nominal slip of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Real s_til=R_2/X_2 "Tilting slip of electric machine"
    annotation (Dialog(tab="Calculations"));
  parameter Real p=2 "Number of pole pairs"
    annotation (Dialog(group="Machine specifications"));
  parameter Real cosPhi=0.8 "Power factor of electric machine"
    annotation (Dialog(group="Machine specifications"));

  Modelica.SIunits.Frequency n=inertia.w/(2*Modelica.Constants.pi) "Speed of machine rotor [1/s]";
  Modelica.SIunits.Current I_1 "Electric current of machine stator";
  Modelica.SIunits.Power P_E "Electrical power at the electric machine";
  Modelica.SIunits.Power P_Mec "Mechanical power at the electric machine";
  Modelica.SIunits.Torque M "Torque at electric machine";
  Real s=1-n*p/f_1 "Current slip of electric machine";
  Boolean OpMode = (n<=n0) "Operation mode (true=motor, false=generator)";
  Boolean SwitchOnOff=isOn "Operation of electric machine (true=On, false=Off)";
  Real eta "Total efficiency of the electric machine (as motor)";

  Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.3, w(fixed=false))
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.RealExpression electricTorque(y=M)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,62})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_electricMachine
    annotation (Placement(transformation(extent={{-12,88},{12,112}})));
  Modelica.Blocks.Sources.RealExpression machineHeat(y=if SwitchOnOff then
        Q_Therm else 0)
    annotation (Placement(transformation(extent={{-22,20},{-2,40}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
equation

if SwitchOnOff then

  I_1=if noEvent(s>s_til)                  then I_1_start else
  sign(n0-n)*I_1_nominal*sqrt(((M*cosPhi/M_nominal)^2)+1-cosPhi^2);
                          /*and der(n)>0*/
  P_E=sqrt(3)*U_1*I_1*cosPhi;
  P_Mec=2*Modelica.Constants.pi*n*abs(M);
  M=if noEvent(s>0) then 2*M_til/((s/s_til)+(s_til/s))
  elseif noEvent(s<0) then 2*M_til/((s/s_til)+(s_til/s)) else 0;
  eta=if noEvent(s>0) then abs(P_Mec/P_E)
  elseif noEvent(s<0) then abs(P_E/P_Mec) else 0;

else

  I_1=0;
  P_E=0;
  P_Mec=0;
  M=0;
  eta=0;

  end if;

  connect(electricTorque.y, torque.tau)
    annotation (Line(points={{-39,0},{-2,0}},  color={0,0,127}));
  connect(prescribedHeatFlow.port, port_electricMachine)
    annotation (Line(points={{0,72},{0,100}},color={191,0,0}));
  connect(machineHeat.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-1,30},{0,30},{0,52}}, color={0,0,127}));
  connect(inertia.flange_b, flange_a)
    annotation (Line(points={{80,0},{100,0}}, color={0,0,0}));
  connect(torque.flange, inertia.flange_a)
    annotation (Line(points={{20,0},{60,0}}, color={0,0,0}));
end CHP_ASMGeneratorEASY1401;
