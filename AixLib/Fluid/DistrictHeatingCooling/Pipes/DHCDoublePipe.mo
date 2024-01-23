within AixLib.Fluid.DistrictHeatingCooling.Pipes;
model DHCDoublePipe "Generic pipe model for DHC applications"

  replaceable package Medium =
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
          property_T=293.15,
          X_a=0.40)
          "Propylene glycol water, 40% mass fraction")));
  parameter Integer nPorts "Number of ports pipe"
    annotation(Evaluate=true, Dialog(connectorSizing=true, tab="General",group="Ports"));
  parameter Integer nPorts1 "Number of ports pipe1"
    annotation(Evaluate=true, Dialog(connectorSizing=true, tab="General",group="Ports"));

  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);



  parameter Boolean use_zeta=false
    "= true HydraulicResistance is implemented, zeta value has to be given next"
    annotation(Dialog(group="Additional pressurelosses"));

  parameter Boolean use_soil=false
    "= true 3 cylindric heat transfers are implemented, representing the soil around the pipe, otherwise direct heat throughzeta value has to be given next"
    annotation(Dialog(group="Soil"));

  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.SIunits.Length dh=sqrt(4*m_flow_nominal/rho_default/v_nominal/Modelica.Constants.pi)
    "Hydraulic diameter (assuming a round cross section area)"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Velocity v_nominal = 1.5
    "Velocity at m_flow_nominal (used to compute default value for hydraulic diameter dh)"
    annotation(Dialog(group="Nominal condition"));

  parameter Real ReC=4000
    "Reynolds number where transition to turbulent starts";

  parameter Modelica.SIunits.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Length length "Pipe length"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.MassFlowRate m_flow_small = 1E-4*abs(
    m_flow_nominal) "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.SIunits.Length dIns
    "Thickness of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.SIunits.ThermalConductivity kIns
    "Heat conductivity of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.SIunits.SpecificHeatCapacity cPip=2300
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Density rhoPip(displayUnit="kg/m3")=930
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Length thickness = 0.0035
    "Pipe wall thickness"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Temperature T_start_in(start=Medium.T_default)=
    Medium.T_default "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Temperature T_start_out(start=Medium.T_default)=
    T_start_in "Initialization temperature at pipe outlet"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean initDelay(start=false) = false
    "Initialize delay for a constant mass flow rate if true, otherwise start from 0"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.MassFlowRate m_flow_start=0 "Initial value of mass flow rate through pipe"
    annotation (Dialog(tab="Initialization", enable=initDelay));

  parameter Real R(unit="(m.K)/W")=1/(kIns*2*Modelica.Constants.pi/
    Modelica.Math.log((dh/2 + dIns)/(dh/2)))
    "Thermal resistance per unit length from fluid to boundary temperature"
    annotation (Dialog(group="Thermal resistance"));

  parameter Real fac= 1.0
    "Factor to take into account flow resistance of bends etc., fac=dp_nominal/dpStraightPipe_nominal"
    annotation (Dialog(group="Additional pressurelosses", enable=not use_zeta));

  parameter Real sum_zetas=0
    "Sum of all zeta values. Takes into account additional pressure drops due to bends/valves/etc. if use_zeta"
    annotation (Dialog(group="Additional pressurelosses", enable=use_zeta));

  parameter Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  parameter Boolean linearized = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  //Ground/Soil: values for sandy soil with clay content based on "SIMULATIONSMODELL
  //"ERDWÄRMEKOLLEKTOR" zur wärmetechnischen Beurteilung von Wärmequellen,
  //Wärmesenken und Wärme-/Kältespeichern" by Bernd Glück --> move to docu

  parameter Modelica.SIunits.Density rhoSoi=1630   "Density of material/soil"
  annotation(Dialog(tab="Soil", enable=use_soil));

  parameter Modelica.SIunits.SpecificHeatCapacity c = 1046
    "Specific heat capacity of material/soil"
    annotation(Dialog(tab="Soil", enable=use_soil));
  parameter Modelica.SIunits.Length thickness_ground = 0.6 "thickness of soil layer for heat loss calulcation"
  annotation(Dialog(tab="Soil", enable=use_soil));

  parameter Modelica.SIunits.ThermalConductivity lambda = 1.5
    "Heat conductivity of material/soil"
    annotation(Dialog(tab="Soil", enable=use_soil));

  final parameter Modelica.SIunits.Length d_in = dh + 2 * thickness "Inner diameter of pipe"
  annotation(Dialog(tab="Soil", enable=use_soil));

  final parameter Modelica.SIunits.Temperature T0=289.15 "Initial temperature"
  annotation(Dialog(tab="Soil"));

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Dialog(tab="Dynamics", group="Equations"));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat transfer to or from surroundings (heat loss from pipe results in a positive heat flow)"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  replaceable AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore pipCor(
    redeclare final package Medium = Medium,
    final dh=dh,
    final v_nominal=v_nominal,
    final length=length,
    final C=C,
    final R=R,
    final m_flow_small=m_flow_small,
    final m_flow_nominal=m_flow_nominal,
    final T_start_in=T_start_in,
    final T_start_out=T_start_out,
    final m_flow_start=m_flow_start,
    final initDelay=initDelay,
    final from_dp=from_dp,
    final fac=if not use_zeta then fac else 1.0,
    final ReC=ReC,
    final thickness=thickness,
    final roughness=roughness,
    final allowFlowReversal=allowFlowReversal,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized) constrainedby Interfaces.PartialTwoPort(
    redeclare package Medium = Medium,
    dh=dh,
    v_nominal=v_nominal,
    length=length,
    C=C,
    R=R,
    m_flow_small=m_flow_small,
    m_flow_nominal=m_flow_nominal,
    T_start_in=T_start_in,
    T_start_out=T_start_out,
    m_flow_start=m_flow_start,
    initDelay=initDelay,
    from_dp=from_dp,
    fac=if not use_zeta then fac else 1.0,
    ReC=ReC,
    thickness=thickness,
    roughness=roughness,
    allowFlowReversal=allowFlowReversal,
    homotopyInitialization=homotopyInitialization,
    linearized=linearized) "Describing the pipe behavior" annotation (choices(
        choice(redeclare
          AixLib.Fluid.DistrictHeatingCooling.Pipes.BaseClassesStatic.StaticCore
          pipCor "Static core"), choice(redeclare
          AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore pipCor
          "PlugFlow core")), Placement(transformation(extent={{-10,-10},{10,10}})));

  // In the volume, below, we scale down V and use
  // mSenFac. Otherwise, for air, we would get very large volumes
  // which affect the delay of water vapor and contaminants.
  // See also AixLib.Fluid.FixedResistances.Validation.PlugFlowPipes.TransportWaterAir
  // for why mSenFac is 10 and not 1000, as this gives more reasonable
  // temperature step response

  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer cylHeaTra1(
    final energyDynamics=energyDynamics,
    final rho=rhoSoi,
    final c=c,
    final d_in=dh + 2*thickness,
    final d_out=d_in + thickness_ground/3,
    final length=length,
    final lambda=lambda,
    T0=283.15) if use_soil
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));

  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer cylHeaTra2(
    final energyDynamics=energyDynamics,
    final rho=rhoSoi,
    final c=c,
    final d_in=dh + 2*thickness + thickness_ground/3,
    final d_out=d_in + 2*thickness_ground/3,
    final length=length,
    final lambda=lambda,
    T0=283.15) if use_soil
    annotation (Placement(transformation(extent={{-10,46},{10,66}})));
  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer cylHeaTra3(
    final energyDynamics=energyDynamics,
    final rho=rhoSoi,
    final c=c,
    final d_in=dh + 2*thickness + 2*thickness_ground/3,
    final d_out=d_in + thickness_ground,
    final length=length,
    final lambda=lambda,
    T0=283.15) if use_soil
    annotation (Placement(transformation(extent={{-10,72},{10,92}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to ports_b)"
    annotation (Placement(transformation(extent={{-112,40},{-92,60}}),
        iconTransformation(extent={{-112,40},{-92,60}})));

  Modelica.Fluid.Interfaces.FluidPorts_b ports_b[nPorts](
    redeclare each package Medium = Medium,
    each m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    each h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connectors b (positive design flow direction is from port_a to ports_b)"
    annotation (Placement(transformation(extent={{88,10},{108,90}}),
        iconTransformation(extent={{88,10},{108,90}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
    redeclare final package Medium = Medium,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connector a (positive design flow direction is from port_a to ports_b)"
    annotation (Placement(transformation(extent={{90,-60},{110,-40}}),
        iconTransformation(extent={{90,-60},{110,-40}})));

  Modelica.Fluid.Interfaces.FluidPorts_b ports_b1[nPorts](
    redeclare each package Medium = Medium,
    each m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    each h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    "Fluid connectors b (positive design flow direction is from port_a to ports_b)"
    annotation (Placement(transformation(extent={{-110,-90},{-90,-10}}),
        iconTransformation(extent={{-110,-90},{-90,-10}})));


  // Diagnostics
   parameter Boolean show_T = false
    "= true, if actual temperature at port is computed"
    annotation(Dialog(tab="Advanced",group="Diagnostics"));

  Medium.ThermodynamicState sta_a=
      Medium.setState_phX(port_a.p,
                          noEvent(actualStream(port_a.h_outflow)),
                          noEvent(actualStream(port_a.Xi_outflow))) if
         show_T "Medium properties in port_a";

  Medium.ThermodynamicState sta_b[nPorts]=
      Medium.setState_phX(ports_b.p,
                          noEvent(actualStream(ports_b.h_outflow)),
                          noEvent(actualStream(ports_b.Xi_outflow))) if
         show_T "Medium properties in ports_b";

   Medium.ThermodynamicState sta_a1=
      Medium.setState_phX(port_a1.p,
                          noEvent(actualStream(port_a1.h_outflow)),
                          noEvent(actualStream(port_a1.Xi_outflow))) if
         show_T "Medium properties in port_a1";

  Medium.ThermodynamicState sta_b1[nPorts]=
      Medium.setState_phX(ports_b1.p,
                          noEvent(actualStream(ports_b1.h_outflow)),
                          noEvent(actualStream(ports_b1.Xi_outflow))) if
         show_T "Medium properties in ports_b1";





protected
  parameter Modelica.SIunits.HeatCapacity CPip=
    length*((dh + 2*thickness)^2 - dh^2)*Modelica.Constants.pi/4*cPip*rhoPip "Heat capacity of pipe wall";

  final parameter Modelica.SIunits.Volume VEqu=CPip/(rho_default*cp_default)
    "Equivalent water volume to represent pipe wall thermal inertia";

  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";

  parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";

  parameter Real C(unit="J/(K.m)")=
    rho_default*Modelica.Constants.pi*(dh/2)^2*cp_default
    "Thermal capacity per unit length of water in pipe";

  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));

  Modelica.SIunits.Velocity v_med "Velocity of the medium in the pipe";

  Modelica.SIunits.Heat Q_los "Integrated heat loss of the pipe";
  Modelica.SIunits.Heat Q_gai "Integrated heat gain of the pipe";

public
  FixedResistances.HydraulicResistance hydRes(
    diameter=dh,
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    zeta=sum_zetas,
    allowFlowReversal=allowFlowReversal,
    from_dp=from_dp,
    homotopyInitialization=homotopyInitialization,
    linearized=linearized,
    m_flow_start=m_flow_start) if use_zeta
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thePasThr(final m=1) if
       not use_soil "Thermal pass through if there is no soil activated"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-16,54})));
  Interfaces.PassThroughMedium pasThrMed(redeclare package Medium = Medium) if
                                                    not use_zeta
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  replaceable FixedResistances.BaseClasses.PlugFlowCore              pipCor1(
    redeclare final package Medium = Medium,
    final dh=dh,
    final v_nominal=v_nominal,
    final length=length,
    final C=C,
    final R=R,
    final m_flow_small=m_flow_small,
    final m_flow_nominal=m_flow_nominal,
    final T_start_in=T_start_in,
    final T_start_out=T_start_out,
    final m_flow_start=m_flow_start,
    final initDelay=initDelay,
    final from_dp=from_dp,
    final fac=if not use_zeta then fac else 1.0,
    final ReC=ReC,
    final thickness=thickness,
    final roughness=roughness,
    final allowFlowReversal=allowFlowReversal,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized) constrainedby
    FixedResistances.BaseClasses.PlugFlowCore(
    redeclare package Medium = Medium,
    dh=dh,
    v_nominal=v_nominal,
    length=length,
    C=C,
    R=R,
    m_flow_small=m_flow_small,
    m_flow_nominal=m_flow_nominal,
    T_start_in=T_start_in,
    T_start_out=T_start_out,
    m_flow_start=m_flow_start,
    initDelay=initDelay,
    from_dp=from_dp,
    fac=if not use_zeta then fac else 1.0,
    ReC=ReC,
    thickness=thickness,
    roughness=roughness,
    allowFlowReversal=allowFlowReversal,
    homotopyInitialization=homotopyInitialization,
    linearized=linearized) "Describing the pipe behavior" annotation (choices(
        choice(redeclare
          AixLib.Fluid.DistrictHeatingCooling.Pipes.BaseClassesStatic.StaticCore
          pipCor1 "Static core"), choice(redeclare
          AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore pipCor1
          "PlugFlow core")), Placement(transformation(extent={{10,-50},{-10,-70}})));
  MixingVolumes.MixingVolume       vol1(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final V=if rho_default > 500 then VEqu else VEqu/1000,
    final nPorts=nPorts,
    final T_start=T_start_out,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final mSenFac=if rho_default > 500 then 1 else 10)
    "Control volume connected to ports_b. Represents equivalent pipe wall thermal capacity."
    annotation (Placement(transformation(extent={{-60,-80},{-40,-100}})));
  Utilities.HeatTransfer.CylindricHeatTransfer        cylHeaTra4(
    final energyDynamics=energyDynamics,
    final rho=rhoSoi,
    final c=c,
    final d_in=dh + 2*thickness,
    final d_out=d_in + thickness_ground/3,
    final length=length,
    final lambda=lambda,
    T0=283.15) if use_soil
    annotation (Placement(transformation(extent={{-10,-80},{10,-100}})));
  Utilities.HeatTransfer.CylindricHeatTransfer        cylHeaTra5(
    final energyDynamics=energyDynamics,
    final rho=rhoSoi,
    final c=c,
    final d_in=dh + 2*thickness + thickness_ground/3,
    final d_out=d_in + 2*thickness_ground/3,
    final length=length,
    final lambda=lambda,
    T0=283.15) if use_soil
    annotation (Placement(transformation(extent={{-10,-102},{10,-122}})));
  Utilities.HeatTransfer.CylindricHeatTransfer        cylHeaTra6(
    final energyDynamics=energyDynamics,
    final rho=rhoSoi,
    final c=c,
    final d_in=dh + 2*thickness + 2*thickness_ground/3,
    final d_out=d_in + thickness_ground,
    final length=length,
    final lambda=lambda,
    T0=283.15) if use_soil
    annotation (Placement(transformation(extent={{-10,-122},{10,-142}})));
public
  FixedResistances.HydraulicResistance hydRes1(
    diameter=dh,
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    zeta=sum_zetas,
    allowFlowReversal=allowFlowReversal,
    from_dp=from_dp,
    homotopyInitialization=homotopyInitialization,
    linearized=linearized,
    m_flow_start=m_flow_start) if use_zeta
    annotation (Placement(transformation(extent={{80,-70},{60,-50}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thePasThr1(final m=1) if
       not use_soil "Thermal pass through if there is no soil activated"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,-114})));
  Interfaces.PassThroughMedium pasThrMed1(redeclare package Medium = Medium)
    if                                              not use_zeta
    annotation (Placement(transformation(extent={{80,-100},{60,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1
    "Heat transfer to or from surroundings (heat loss from pipe results in a positive heat flow)"
    annotation (Placement(transformation(extent={{-10,-162},{10,-142}})));
  MixingVolumes.MixingVolume       vol2(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final V=if rho_default > 500 then VEqu else VEqu/1000,
    final T_start=T_start_out,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final mSenFac=if rho_default > 500 then 1 else 10,
    nPorts=nPorts)
    "Control volume connected to ports_b. Represents equivalent pipe wall thermal capacity."
    annotation (Placement(transformation(extent={{52,-2},{72,-22}})));
equation
  //calculation of the flow velocity of water in the pipes
  v_med = (4 * port_a.m_flow) / (Modelica.Constants.pi * rho_default * dh * dh);

  //calculation of heat losses and heat gains of pipe
  der(Q_los) =min(0, pipCor.heatPort.Q_flow);
  der(Q_gai) =max(0, pipCor.heatPort.Q_flow);

  for i in 1:nPorts loop
  end for;

  connect(pipCor.heatPort, cylHeaTra1.port_a)
    annotation (Line(points={{0,10},{0,30}}, color={191,0,0},
      pattern=LinePattern.Dash));
  connect(cylHeaTra1.port_b, cylHeaTra2.port_a)
    annotation (Line(points={{0,38.8},{0,56}}, color={191,0,0},
      pattern=LinePattern.Dash));
  connect(cylHeaTra2.port_b, cylHeaTra3.port_a)
    annotation (Line(points={{0,64.8},{0,82}}, color={191,0,0},
      pattern=LinePattern.Dash));
  connect(cylHeaTra3.port_b, heatPort)
    annotation (Line(points={{0,90.8},{0,90.8},{0,100}}, color={191,0,0},
      pattern=LinePattern.Dash));
  connect(pipCor.heatPort, thePasThr.port_a[1]) annotation (Line(points={{0,10},
          {0,20},{-16,20},{-16,44}}, color={191,0,0},
      pattern=LinePattern.Dash));
  connect(thePasThr.port_b, heatPort) annotation (Line(points={{-16,64},{-16,94},
          {0,94},{0,100}}, color={191,0,0},
      pattern=LinePattern.Dash));
  connect(hydRes.port_b, pipCor.port_a) annotation (Line(
      points={{-40,20},{-20,20},{-20,0},{-10,0}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(port_a, port_a)
    annotation (Line(points={{-102,50},{-104,50},{-104,116},{-104,116},{-104,50},
          {-102,50}},                            color={0,127,255}));
  connect(pasThrMed.port_b, pipCor.port_a) annotation (Line(
      points={{-40,-20},{-20,-20},{-20,0},{-10,0}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(pipCor1.port_b, vol1.ports[1]) annotation (Line(points={{-10,-60},{-50,
          -60},{-50,-80}},  color={0,127,255}));
  connect(pipCor1.heatPort, cylHeaTra4.port_a) annotation (Line(
      points={{0,-70},{0,-90}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(cylHeaTra4.port_b,cylHeaTra5. port_a)
    annotation (Line(points={{0,-98.8},{0,-112}},
                                               color={191,0,0},
      pattern=LinePattern.Dash));
  connect(cylHeaTra5.port_b,cylHeaTra6. port_a)
    annotation (Line(points={{0,-120.8},{0,-132}},
                                               color={191,0,0},
      pattern=LinePattern.Dash));
  connect(cylHeaTra6.port_b, heatPort1) annotation (Line(
      points={{0,-140.8},{0,-152}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(pipCor1.heatPort, thePasThr1.port_a[1]) annotation (Line(
      points={{0,-70},{0,-80},{-20,-80},{-20,-104}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(thePasThr1.port_b, heatPort1) annotation (Line(
      points={{-20,-124},{-20,-142},{0,-142},{0,-152}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(hydRes1.port_b, pipCor1.port_a) annotation (Line(
      points={{60,-60},{10,-60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(pasThrMed1.port_b, pipCor1.port_a) annotation (Line(
      points={{60,-90},{44,-90},{44,-60},{10,-60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(heatPort1, cylHeaTra5.port_a)
    annotation (Line(points={{0,-152},{0,-112}}, color={191,0,0}));
  connect(pipCor.port_b, vol2.ports[1]) annotation (Line(points={{10,0},{42,0},{
          42,-2},{62,-2}}, color={0,127,255}));
  connect(vol2.ports, ports_b) annotation (Line(points={{62,-2},{80,-2},{80,50},
          {98,50}}, color={0,127,255}));
  connect(port_a1, hydRes1.port_a) annotation (Line(
      points={{100,-50},{106,-50},{106,-60},{80,-60}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(port_a, hydRes.port_a) annotation (Line(
      points={{-102,50},{-81,50},{-81,20},{-60,20}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(port_a, pasThrMed.port_a) annotation (Line(
      points={{-102,50},{-80,50},{-80,-20},{-60,-20}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(port_a1, pasThrMed1.port_a) annotation (Line(
      points={{100,-50},{90,-50},{90,-90},{80,-90}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(ports_b1, vol1.ports) annotation (Line(points={{-100,-50},{-76,-50},{
          -76,-80},{-50,-80}}, color={0,127,255}));
    annotation (
    Dialog(group="Additional pressurelosses"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,90},{100,10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,80},{100,20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-100,100},{100,90}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,10},{100,0}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-26,80},{32,20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,202,187}),
        Rectangle(
          extent={{-100,-50},{100,-80}},
          lineColor={28,108,200},
          fillColor={162,29,33},
          fillPattern=FillPattern.Forward,
          visible=use_soil),
        Rectangle(
          extent={{-100,-10},{100,-90}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,-20},{100,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-100,0},{100,-10}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-90},{100,-100}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-26,-20},{32,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,202,187})}),
    Documentation(revisions="<html><ul>
  <li>November 12, 2020, by Michael Mans:<br/>
    First implementation
  </li>
</ul>
</html>", info="<html>
<p>
  This pipe aims to enable the representation of all one pipe district
  heating and cooling pipe applications for dynamic simulation of
  district heating and cooling grids.
</p>
<p>
  Pipe with heat loss using the wether the time delay based heat losses
  and transport of the fluid using a plug flow model, applicable for
  simulation of long pipes such as in district heating and cooling
  systems, or the more staty-state based approach with the static core.
</p>
<p>
  This model takes into account transport delay along the pipe length
  idealized as a plug flow. The model also includes thermal inertia of
  the pipe wall. This model determines the pressure drop either through
  a static factor or using the sum of zeta values.
</p>
<p>
  In addition this model is able to represent a very simplified ground
  around the pipe. With 3 capacities and the possibility to define the
  soil properties, this enables the user of this pipe model to account
  for heat losses in a more accurate way.
</p>
<h4>
  Implementation
</h4>
<p>
  This model is based on <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore\">AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore</a>
  or on <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Pipes.BaseClassesStatic.StaticCore\">
  AixLib.Fluid.DistrictHeatingCooling.Pipes.BaseClassesStatic.StaticCore</a>
  .
</p>
<p>
  The spatialDistribution operator is used for the temperature wave
  propagation through the length of the pipe.
</p>
<p>
  Heat losses are implemented by <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowHeatLoss\">
  AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowHeatLoss</a> at
  each end of the pipe (see <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore\">AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore</a>).
  Depending on the flow direction, the temperature difference due to
  heat losses is subtracted at the right fluid port.
</p>
<p>
  The pressure drop is implemented using <a href=
  \"modelica://AixLib.Fluid.FixedResistances.HydraulicDiameter\">AixLib.Fluid.FixedResistances.HydraulicDiameter</a>.
</p>
<p>
  The thermal capacity of the pipe wall is implemented as a mixing
  volume of the fluid in the pipe, of which the thermal capacity is
  equal to that of the pipe wall material. In addition, this mixing
  volume allows the hydraulic separation of subsequent pipes. Thanks to
  the vectorized implementation of the (design) outlet port, splits and
  junctions of pipes can be handled in a numerically efficient way.
</p>
<p>
  This mixing volume is not present in the <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore\">PlugFlowCore</a>
  model, which can be used in cases where mixing volumes at pipe
  junctions need to be added manually.
</p>
<p>
  If Boolean use_zeta is set \"true\" <a href=
  \"modelica://AixLib.Fluid.FixedResistances.HydraulicResistance\">HydraulicResistance</a>
  is used.
</p>
<p>
  <a href=
  \"modelica://AixLib.Fluid.FixedResistances.HydraulicResistance\">HydraulicResistance</a>
  takes into account additional pressure drops due to bends/valves/etc.
  Therefore the sum of zeta values has to be given prior.
</p>
<p>
  If Boolean use_zeta is set \"false\" the pressureloss is determine
  through a static factor which has to given prior.
</p>
<p>
  The Soil model is represented by three capacities which can be
  parameterized in the Soil Tab of the model.
</p>
<h4>
  Assumptions
</h4>
<ul>
  <li>Heat losses are for steady-state operation.
  </li>
  <li>The axial heat diffusion in the fluid, the pipe wall and the
  ground are neglected.
  </li>
  <li>The boundary temperature is uniform.
  </li>
  <li>The thermal inertia of the pipe wall material is lumped on the
  side of the pipe that is connected to <span style=
  \"font-family: Courier New;\">ports_b</span>.
  </li>
</ul>
</html>"));
end DHCDoublePipe;
