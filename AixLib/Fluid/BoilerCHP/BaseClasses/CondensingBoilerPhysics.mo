within AixLib.Fluid.BoilerCHP.BaseClasses;
model CondensingBoilerPhysics
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  import SI = Modelica.SIunits;
  import AixLib.Fluid.BoilerCHP.BaseClasses.Psat;

  redeclare replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater
    "Medium in the component" annotation (choicesAllMatching=true);

  parameter AixLib.Fluid.BoilerCHP.BoilerData.CondensingBoilerdatadef
    BoilerType=AixLib.Fluid.BoilerCHP.BoilerData.CondensingBoilerdatadef()
    "Basic boiler data" annotation (Dialog(group="Parameters", enable=
          selectable), choicesAllMatching=true);

  parameter Modelica.SIunits.Time tau=1
    "Time constant of the temperature sensors at nominal flow rate"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (InitialState and InitialOutput are identical)"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature T_start=Medium.T_default
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.SIunits.Temperature T_ref=288.15 "Reference temperature";
  parameter Modelica.SIunits.Efficiency eta_ref=1
    "Nominal net heating value efficiency";
  parameter Real PLR_delta=0.01
    "Efficiency gap at T_int between PLR_nom (Part Load Ratio) and PLR_int (between 0 and 2% depending on the machine)";
  parameter Real lambda=0.01 "Offset variable of weighting coefficients sigmas";
  parameter Boolean transferHeat=false
    "If true, temperature T converges towards T_amb when no flow"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Temperature T_amb=Medium.T_default
    "Fixed ambient temperature for heat transfer"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.SIunits.Time tauHeaTra=1200
    "Time constant for heat transfer, default 20 minutes"
    annotation (Dialog(tab="Advanced", group="Sensor Properties"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=0
    "Guess value of dp = port_a.p - port_b.p"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
    "Guess value of m_flow = port_a.m_flow"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
    "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  Sensors.TemperatureTwoPort senTCold(
    redeclare final package Medium = Medium,
    final tau=tau,
    final m_flow_nominal=m_flow_nominal,
    final initType=initType,
    final T_start=T_start,
    final transferHeat=transferHeat,
    final TAmb=T_amb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=m_flow_small)
    "Temperature sensor of cold side of heat generator (return)"
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Sensors.TemperatureTwoPort senTHot(
    redeclare final package Medium = Medium,
    final tau=tau,
    final m_flow_nominal=m_flow_nominal,
    final initType=initType,
    final T_start=T_start,
    final transferHeat=transferHeat,
    final TAmb=T_amb,
    final tauHeaTra=tauHeaTra,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_small=m_flow_small)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Sensors.MassFlowRate senMasFlo(
    redeclare final package Medium = Medium,
    final allowFlowReversal=allowFlowReversal)
    "Sensor for mass flwo rate"
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,0})));
  MixingVolumes.MixingVolume vol(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=m_flow_small,
    final allowFlowReversal=allowFlowReversal,
    final nPorts=2,
    final p_start=p_start,
    final T_start=T_start,
    V=BoilerType.V_water)
    "Fluid volume"
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate pressureDrop(
    redeclare final package Medium = Medium,
    final b=0,
    final m_flow_small=m_flow_small,
    final show_T=false,
    final show_V_flow=false,
    final allowFlowReversal=allowFlowReversal,
    final dp_start=dp_start,
    final m_flow_start=m_flow_start,
    a=1e10)
    "Pressure drop"
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Boilerstorage(C=500*
        BoilerType.mDry, T(start=T_start))
    "Boiler thermal capacity (dry weight)" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={0,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(G=
        UA) "Thermal resistance of the boiler casing" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-20,0})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor senQ_flow annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={10,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={40,0})));
  Modelica.Blocks.Math.Product PgasCalculation
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{34,54},{46,66}})));
  Modelica.Blocks.Sources.RealExpression NominalGasConsumption(y=P_nom/(eta_nom*
        PLR_nom)) "etaRP is calculated in the algorithm section"
    annotation (Placement(transformation(extent={{16,32},{44,48}})));
  Modelica.Blocks.Sources.RealExpression Q_flowCalculation(y=PgasCalculation.y*
        etaRP)
    annotation (Placement(transformation(extent={{-64,32},{-36,48}})));
  BoilerBus boilerBus
    annotation (Placement(transformation(extent={{-18,84},{18,116}})));

protected
  parameter Real PLR_nom=BoilerType.PLR_nom/100 "Nominal loading rate (1)";
  parameter Real PLR_int=BoilerType.PLR_int/100 "Intermediate loading rate (1)";
  parameter Real PLR_min=BoilerType.PLR_int/100 "Minimum loading rate"
    annotation (Dialog(tab="Other parameters", group="Performance"));
  parameter Modelica.SIunits.Temperature T_nom=BoilerType.T_nom
    "Nominal temperature";
  parameter Modelica.SIunits.Temperature T_int=BoilerType.T_int
    "Intermediate temperature";
  parameter Modelica.SIunits.Efficiency eta_nom=BoilerType.eta_nom/100
    "Nominal net heating value efficiency";
  parameter Modelica.SIunits.Efficiency eta_part=BoilerType.eta_part/100
    "Intermediate net heating value efficiency";
  parameter Real eta_max=1.11
    "Ratio gross (high) heating value / net (low) heating value defined according to the fuel";
  parameter Modelica.SIunits.Power P_nom=BoilerType.P_nom "Nominal power";
  parameter SI.VolumeFlowRate V_flow=BoilerType.V_flow
    "Volume of water in the boiler" annotation (Dialog(group="Characteristics"));
  parameter SI.Density rhoW=1000 "Density of water"
    annotation (Dialog(tab="Other parameters", group="Fluids properties"));
  parameter SI.ThermalConductance UA=BoilerType.P_loss/30
    "Conduction through the envelope. Q30=UA*dT30.";
  parameter Real ak=(eta_nom - eta_ref)/(T_nom - T_ref);
  Real etaSens;
  Real etaCond30;
  Real etaCond;
  Real sigmaSens;
  Real sigmaCond;
  Real etaRP;
  Modelica.SIunits.Temperature Tc(start=360, max=380, min=323, nominal=360)
    "Temperature of Sensitive and Latent characteristic intersection";
  //start value is important: equation below has two solutions

algorithm
  //The boiler is launched for partLoadRate (boilerBus.PLR) > PLR_min, if partLoadRate < PLR_min there is no combustion and the efficiency etaRP is zero
  //Determination of the efficiency for the law without condensation
  etaSens := eta_nom + ak*(senTCold.T - T_nom);
  //Determination of the efficiency for the law characterizing the condensation
  etaCond := eta_part + (eta_max - eta_part)*(1 - Psat(senTCold.T)/Psat(T_int)*T_int/senTCold.T);
  //Determination of the efficiency in steady state
  sigmaCond := 1/(1 + exp(senTCold.T - Tc - lambda));
  sigmaSens := 1 - 1/(1 + exp(senTCold.T - Tc + lambda));
  if boilerBus.PLR > PLR_min then
    etaRP := sigmaSens*etaSens + sigmaCond*etaCond;
  else
    etaRP := 0;
  end if;

equation
  eta_nom + ak*(Tc - T_nom) = eta_part + (eta_max - eta_part)*(1 - Psat(Tc)/Psat(T_int)*
    T_int/Tc);

  connect(port_a, senTCold.port_a) annotation (Line(points={{-100,0},{-90,0},{-90,
          -80},{-80,-80}}, color={0,127,255},
      thickness=1));
  connect(senTCold.port_b, vol.ports[1])
    annotation (Line(points={{-60,-80},{-42,-80}}, color={0,127,255},
      thickness=1));
  connect(vol.ports[2], pressureDrop.port_a) annotation (Line(
      points={{-38,-80},{-20,-80}},
      color={0,127,255},
      thickness=1));
  connect(senMasFlo.port_b, port_b) annotation (Line(points={{80,-80},{90,-80},{
          90,0},{100,0}}, color={0,127,255},
      thickness=1));
  connect(pressureDrop.port_b, senTHot.port_a) annotation (Line(
      points={{0,-80},{20,-80}},
      color={0,127,255},
      thickness=1));
  connect(senTHot.port_b, senMasFlo.port_a)
    annotation (Line(points={{40,-80},{60,-80}},          color={0,127,255},
      thickness=1));
  connect(heater.port, vol.heatPort) annotation (Line(points={{-60,-10},{-60,-70},
          {-50,-70}},                     color={191,0,0}));
  connect(prescribedTemperature.port, senQ_flow.port_b)
    annotation (Line(points={{34,0},{20,0}}, color={191,0,0}));
  connect(senQ_flow.port_a, ConductanceToEnv.port_b)
    annotation (Line(points={{0,0},{-10,0}}, color={191,0,0}));
  connect(NominalGasConsumption.y, PgasCalculation.u2) annotation (Line(points=
          {{45.4,40},{52,40},{52,44},{58,44}}, color={0,0,127}));
  connect(limiter.y, PgasCalculation.u1) annotation (Line(points={{46.6,60},{52,
          60},{52,56},{58,56}}, color={0,0,127}));
  connect(heater.Q_flow, Q_flowCalculation.y) annotation (Line(points={{-60,10},
          {-60,20},{-20,20},{-20,40},{-34.6,40}}, color={0,0,127}));
  connect(vol.heatPort, ConductanceToEnv.port_a) annotation (Line(points={{-50,-70},
          {-60,-70},{-60,-20},{-40,-20},{-40,0},{-30,0}},      color={191,0,0}));
  connect(vol.heatPort, Boilerstorage.port) annotation (Line(points={{-50,-70},{
          -60,-70},{-60,-40},{-10,-40}}, color={191,0,0}));
  connect(limiter.u, boilerBus.PLR) annotation (Line(points={{32.8,60},{30,60},{
          30,100.08},{0.09,100.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-9,3},{-9,3}}));
  connect(senMasFlo.m_flow, boilerBus.m_flow) annotation (Line(points={{70,-69},
          {70,-60},{80,-60},{80,20},{100,20},{100,100.08},{0.09,100.08}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{2,6},{2,6}}));
  connect(PgasCalculation.y, boilerBus.Pgas) annotation (Line(points={{81,50},{100,
          50},{100,100.08},{0.09,100.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senTCold.T, boilerBus.T_in) annotation (Line(points={{-70,-69},{-70,100.08},
          {0.09,100.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{2,6},{2,6}}));
  connect(senTHot.T, boilerBus.T_out) annotation (Line(points={{30,-69},{30,-60},
          {80,-60},{80,20},{100,20},{100,100.08},{0.09,100.08}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{2,6},{2,6}}));
  connect(Q_flowCalculation.y, boilerBus.Q_flow) annotation (Line(points={{-34.6,
          40},{-34,40},{-34,100.08},{0.09,100.08}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{2,6},{2,6}}));
  connect(prescribedTemperature.T, boilerBus.T_amb) annotation (Line(points={{47.2,
          0},{80,0},{80,20},{100,20},{100,100.08},{0.09,100.08}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255})}),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<ul>
<li>This is a model of a Condensing Boiler referred from the <a href=\"https://github.com/edf-enerbat/BuildSysPro\">BuildSysPro</a> modeling library</li>
<li>The model represents the physical behavior without any controllers</li>
<li>The BuildSysPro model is based upon the literature <i><a href=\"https://core.ac.uk/download/pdf/46816799.pdf\">R&egrave;gles de mod&eacute;lisation des syst&egrave;mes &eacute;nerg&eacute;tiques dans les b&acirc;timents basse consommation</a></i></li>
<li>It is used to heat water in an HVAC system</li>
<li>It uses different manufacturers database from <a href=\"https://rt2012-chauffage.com/\">ATITA</a></li>
</ul>
<h4><span style=\"color: #008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars4.png\"/></p>
<p><br><b><span style=\"color: #008000;\">Concept</span></b></p>
<p>The power of the boiler is given by the part load rate (from the boilerBus). The part load rate (value 0 - 1) is the ratio of the actual and the nominal gas consumption. The heatflow depends on the gas consumption and is calculated by using a grey box model. </p>
<p>This model requires a limited amount of input data accessible from the normative tests.</p>
<p>The parameter &Delta;&eta; (representing the decrease in performance depending on the load at a return of water temperature equal to 30&deg;C) has nearly no effects on the results for the temperature levels of the water law in question (between 35 and 45&deg;C). In the case of modelling a system requiring water temperatures higher than 35&deg;C, the user can leave the default value, especially since this parameter is not provided in the ATITA basis;</p>
<h4><span style=\"color: #008000\">Functioning</span></h4>
<ul>
<li>The boiler needs the part load rate and the ambient temperature as an input.</li>
<li>The model measures the inlet and outlet temperature, the massflow and the consumed gas.</li>
</ul>
<h4><span style=\"color: #008000\">Examples</span></h4>
<p>One example has been provided for this boiler model:</p>
<ul>
<li><a href=\"Zugabe.Fluid.Boilers.Examples.CondensingBoilerPhysicsTest\">CondensingBoilerPhysicsTest</a></li>
</ul>
<p>The example results have been explained in the respective models</p>
</html>", revisions="<html>
<ul>
<li>2018-08-14 by Luca Vedda:<br>Transfer to AixLib.</li>
<li><i>June, 2017&nbsp;</i> by Alexander Kuempel:<br>V0.4: Separation of boiler physics and controller</li>
<li><i>November, 2016&nbsp;</i> by Rohit Lad:<br>V0.3: Made changes from the BuildSyspro model to a generic model.</li>
<li><i>January, 2016&nbsp;</i> by Beno&icirc;t Charrier:<br>V0.2: Transition from flow calculation to equation for OpenModelica compatibility</li>
<li><i>May, 2015&nbsp;</i> by Beno&icirc;t Charrier:<br>V0.1: Removal of T &amp; m_flow connectors.</li>
</ul>
</html>"));
end CondensingBoilerPhysics;
