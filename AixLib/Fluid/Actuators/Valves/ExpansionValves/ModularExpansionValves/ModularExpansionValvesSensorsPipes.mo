within AixLib.Fluid.Actuators.Valves.ExpansionValves.ModularExpansionValves;
model ModularExpansionValvesSensorsPipes
  "Model of modular expansion valves, i.g. each valves is in front 
  of an evaporator, combined with sensors and simple pipes"
  extends BaseClasses.PartialModularExpansionVavles;

   // Definition of parameters
  //
  parameter Modelica.SIunits.Time tau = 1
    "Time constant at nominal flow rate"
    annotation(Dialog(tab="General",group="Sensors"),
               HideResult=not show_parSen);

  parameter Boolean transferHeat = false
    "if true, temperature T converges towards TAmb when no flow"
    annotation(Dialog(tab="General",group="Sensors"),
               HideResult=not show_parSen);
  parameter Modelica.SIunits.Temperature TAmb = Medium.T_default
    "Fixed ambient temperature for heat transfer"
    annotation(Dialog(tab="General",group="Sensors"),
               HideResult=not show_parSen);
  parameter Modelica.SIunits.Time tauHeaTra = 1200
    "Time constant for heat transfer, default 20 minutes"
    annotation(Dialog(tab="General",group="Sensors"),
               HideResult=not show_parSen);

  parameter Modelica.Blocks.Types.Init initTypeSen=
    Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation(Dialog(tab="Advanced",group="Initialisation Sensors"),
               HideResult=not show_parSen);
  parameter Modelica.SIunits.Temperature T_start = Medium.T_default
    "Initial or guess value of output (= state)"
    annotation(Dialog(tab="Advanced",group="Initialisation Sensors"),
               HideResult=not show_parSen);
  parameter Modelica.SIunits.SpecificEnthalpy h_out_start=
      Medium.specificEnthalpy_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
      "Initial or guess value of output (= state)"
    annotation(Dialog(tab="Advanced",group="Initialisation Sensors"),
               HideResult=not show_parSen);

  parameter Modelica.SIunits.PressureDifference dpNomPip[nVal] = fill(100,nVal)
    "Pressure loss due to pipe at nominal conditions"
    annotation(Dialog(tab="General",group="Pipes"),
               HideResult=not show_parPip);
  parameter Real deltaM[nVal] = fill(0.3,nVal)
    "Fraction of nominal mass flow rate where transition to turbulent occurs"
    annotation(Dialog(tab="General",group="Pipes"),
               HideResult=not show_parPip);

  parameter Boolean show_parSen = false
    "= true, if sensors' input parameters are shown in results"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));
  parameter Boolean show_parPip = false
    "= true, if pipes' input parameters are shown in results"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  // Definition of models
  //
  Utilities.ModularSensors modularSensors(
    redeclare final package Medium = Medium,
    final nPorts=nVal,
    final dp_start=dp_start,
    final m_flow_start=m_flow_start,
    final dp_nominal=dp_nominal,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=1e-6*m_flow_nominal,
    final tau=tau,
    final transferHeat=transferHeat,
    final TAmb=TAmb,
    final tauHeaTra=tauHeaTra,
    final initType=initTypeSen,
    final T_start=T_start,
    final h_out_start=h_out_start)
    "Model that contains different sensors located behind expansion valves"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  FixedResistances.PressureDrop modularPipes[nVal](
    redeclare package Medium = Medium,
    each final m_flow_nominal=m_flow_nominal,
    dp_nominal=dpNomPip,
    deltaM=deltaM) "Models of simple pipes to consider pressure losses"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

equation
  // Connect expansion valves with sensors and sensors with ports_b
  //
  for i in 1:nVal loop
    connect(expansionValves[i].port_b,modularSensors.ports_a[i]);
    connect(modularSensors.ports_b[i],modularPipes[i].port_a);
    connect(modularPipes[i].port_b,ports_b[i]);
  end for;

  // Connect sensors with data bus
  //
  connect(modularSensors.preMea, dataBus.senPreValve)
    annotation (Line(points={{34,-10},{34,-90},{0.05,-90},{0.05,-99.95}},
                color={0,0,127}));
  connect(modularSensors.temMea, dataBus.senTemValve)
    annotation (Line(points={{38,-10},{38,-90},{0.05,-90},{0.05,-99.95}},
                color={0,0,127}));
  connect(modularSensors.masFloMea, dataBus.senMasFloValve)
    annotation (Line(points={{42,-10},{42,-90},{0.05,-90},{0.05,-99.95}},
                color={0,0,127}));
  connect(modularSensors.quaMea, dataBus.senPhaValve)
    annotation (Line(points={{46,-10},{46,-10},{46,-20},{46,-90},
                {0.05,-90},{0.05,-99.95}},
                color={0,0,127}));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 17, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>"));
end ModularExpansionValvesSensorsPipes;
