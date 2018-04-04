within AixLib.Fluid.HeatPumps;
model HeatPumpDetailed
  "Heat pump model with good level of detail. Mainly fed with manufacturing data."
  import SI = Modelica.SIunits;
  parameter Boolean HPctrlType=true "Capacity control type" annotation (Dialog(
      group="Heat Pump cycle",
      compact=true,
      descriptionLabel=true), choices(
      choice=true "On/off heat pump",
      choice=false "Speed controlled heat pump",
      radioButtons=true));
  parameter Integer capCalcType=1 "Type of capacity calculation" annotation (
      Dialog(
      group="Heat Pump cycle",
      compact=true,
      descriptionLabel=true,
      enable=HPctrlType), choices(
      choice=1 "Polynomial",
      choice=2 "Table (only on/off heat pump)",
      radioButtons=true));
  replaceable package Medium_con = Modelica.Media.Interfaces.PartialMedium
    "Medium outside the refrigerant cycle (Condenser)" annotation (
    Evaluate=true,
    Dialog(tab="Evaporator, Condenser", group="Condenser"),
    choicesAllMatching=true);
  parameter SI.PressureDifference dp_conNominal=0
    "Pressure loss at nominal mass flow in condenser"
    annotation (Dialog(tab="Evaporator, Condenser", group="Condenser"));

  replaceable package Medium_eva = Modelica.Media.Interfaces.PartialMedium
    "Medium outside the refrigerant cycle (Evaporator)" annotation (
    Evaluate=true,
    Dialog(tab="Evaporator, Condenser", group="Evaporator"),
    choicesAllMatching=true);

  parameter SI.PressureDifference dp_evaNominal=0
    "Pressure loss at nominal mass flow in evaporator"
    annotation (Dialog(tab="Evaporator, Condenser", group="Evaporator"));

  parameter SI.Volume volume_eva=0.004
    "External medium volume in heat exchanger"
    annotation (Dialog(tab="Evaporator, Condenser", group="Evaporator"));
  parameter SI.Volume volume_con=0.004
    "External medium volume in heat exchanger"
    annotation (Dialog(tab="Evaporator, Condenser", group="Condenser"));
  parameter AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable=
      AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113()
    "Look-up table data for on/off heat pump according to EN255 or EN14511"
    annotation (choicesAllMatching=true, Dialog(enable=HPctrlType and (
          capCalcType == 2), group="Capacity data"));

  replaceable function data_poly =
      AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.constantQualityGrade
    constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.baseFct
    "Polynomial heat pump characteristics for inverter heat pump" annotation (
      choicesAllMatching=true, Dialog(enable=(capCalcType == 1), group="Capacity data"));

  parameter SI.Temperature T_startEva=273.15 "initial evaporator temperature"
    annotation (Evaluate=true, Dialog(
      tab="Evaporator, Condenser",
      group="Initialization",
      enable=initEvaporatorVol));
  parameter SI.Temperature T_startCon=308.15 "initial condenser temperature"
    annotation (Evaluate=true, Dialog(
      tab="Evaporator, Condenser",
      group="Initialization",
      enable=initCondenserVol));
  replaceable function Corr_icing =
      AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.noModel
    constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.baseFct
    "Frost/Defrost model (only air-to-water heat pumps)" annotation (
      choicesAllMatching=true, Dialog(
      enable=(capCalcType == 1),
      group="Defrosting/Icing correction",
      tab="Advanced"));

  parameter Real N_max=4200
    "Maximum speed of compressor in 1/min (only used if used in polynom)"
    annotation (Dialog(enable=not (HPctrlType), group="Capacity data"));
  parameter Real N_min=1500
    "Minimum speed of compressor in 1/min (only used if used in polynom)"
    annotation (Dialog(enable=not (HPctrlType), group="Capacity data"));
  parameter Real N_nom=3600
    "Nominal speed of compressor in 1/min (only used if used in polynom)"
    annotation (Dialog(enable=HPctrlType and (capCalcType == 1), group="Capacity data"));
  parameter Boolean P_eleOutput=false "Electric power consumption" annotation (
      Dialog(
      group="Optional outputs",
      tab="Advanced",
      descriptionLabel=true), choices(checkBox=true));
  parameter Boolean CoP_output=false "CoP" annotation (Dialog(
      group="Optional outputs",
      tab="Advanced",
      descriptionLabel=true), choices(checkBox=true));
  parameter Boolean PT1_cycle=false "First Order model for capacity"
    annotation (Dialog(group="Start/stop behavior", tab="Advanced"), choices(
        checkBox=true));
  parameter SI.Time timeConstantCycle=1 "Time constant for first order model"
    annotation (Dialog(
      group="Start/stop behavior",
      tab="Advanced",
      enable=PT1_cycle));

  parameter Real eta_ele=1
    "assumption of P_tech/P_el (for calculation of Evaporator load)"
    annotation (Dialog(group="Assumptions", tab="Advanced"));
  parameter Real factorScale=1
    "scaling factor (Attention: not physically correct)"
    annotation (Dialog(group="Assumptions", tab="Advanced"));
  parameter SI.Power P_eleAdd=0
    "additional electric power when heat pump is on (not influenced through 
    scaling factor)"
    annotation (Dialog(group="Assumptions", tab="Advanced"));

  parameter Boolean CorrFlowCo=false
    "Correction of mass flow different from nominal flow in condenser 
    (polynomials: make sure mass flow rate is not corrected in polynomials)"
    annotation (Dialog(group="Mass flow correction", tab="Advanced"), choices(
        checkBox=true));
  parameter SI.MassFlowRate mFlow_conNominal=0.5
    "Nominal mass flow rate in condenser (only with polynomials, as already 
    given in data tables)"
    annotation (Dialog(
      group="Mass flow correction",
      tab="Advanced",
      enable=(CorrFlowCo and capCalcType == 1)));

  parameter Boolean CorrFlowEv=false
    "Correction of mass flow different from nominal flow in evaporator 
    (polynomials: make sure mass flow rate is not corrected in polynomials)"
    annotation (Dialog(group="Mass flow correction", tab="Advanced"), choices(
        checkBox=true));
  parameter SI.MassFlowRate mFlow_evaNominal=0.5
    "Nominal mass flow rate in evaporator (only for polynomials, as already 
    given in data tables)"
    annotation (Dialog(
      group="Mass flow correction",
      tab="Advanced",
      enable=(CorrFlowEv and capCalcType == 1)));

  Modelica.Fluid.Interfaces.FluidPort_b port_evaOut(redeclare package Medium =
        Medium_eva) "Evaporator fluid output port" annotation (Placement(
        transformation(extent={{-140,-80},{-120,-60}}, rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_a port_evaIn(redeclare package Medium =
        Medium_eva) "Evaporator fluid input port" annotation (Placement(
        transformation(extent={{-140,60},{-120,80}}, rotation=0)));
  Sensors.TemperatureTwoPort T_evaIn(
    redeclare package Medium = Medium_eva,
    m_flow_nominal=mFlow_evaNominal,
    T_start=T_startEva) "Temperature sensor at inlet of the evaporator"
    annotation (Placement(transformation(
        origin={-130,26},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Sensors.TemperatureTwoPort T_conIn(
    redeclare package Medium = Medium_con,
    m_flow_nominal=mFlow_conNominal,
    T_start=T_startCon) "Temperature sensor at inlet of the condenser"
    annotation (Placement(transformation(
        origin={130,-26},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Fluid.Interfaces.FluidPort_a port_conIn(redeclare package Medium =
        Medium_con) "Condenser fluid input port" annotation (Placement(
        transformation(extent={{120,-80},{140,-60}}, rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_b port_conOut(redeclare package Medium =
        Medium_con) "Condenser fluid ouput port" annotation (Placement(
        transformation(extent={{120,60},{140,80}}, rotation=0)));
  Sensors.TemperatureTwoPort T_conOut(
    redeclare package Medium = Medium_con,
    m_flow_nominal=mFlow_conNominal,
    T_start=T_startCon) "Temperature sensor at outlet of the condenser"
    annotation (Placement(transformation(
        origin={130,48},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Sensors.TemperatureTwoPort T_evaOut(
    redeclare package Medium = Medium_eva,
    m_flow_nominal=mFlow_evaNominal,
    T_start=T_startEva) "Temperature sensor at outlet of the evaporator"
    annotation (Placement(transformation(
        origin={-130,-46},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Sensors.MassFlowRate mFlow_con(redeclare package Medium = Medium_con)
    "Mass flow sensor at the condenser" annotation (Placement(transformation(
        origin={130,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput P_eleOut(unit="W") if
                                                   P_eleOutput
    "Electical power consumption" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-90})));
  Modelica.Blocks.Interfaces.RealOutput CoP_out if CoP_output
    "Coefficient of Performance" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-90})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRate_con
    "Heat flow rate of the condenser" annotation (Placement(transformation(
        origin={95,1},
        extent={{9,-9},{-9,9}},
        rotation=180)));

public
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlowRate_eva
    "Heat flow rate of the evaporator" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-96,2})));

  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "smoothness of table interpolation" annotation (Dialog(
      group="Assumptions",
      tab="Advanced",
      enable=not (capCalcType == 1)));

  Sensors.MassFlowRate mFlow_eva(redeclare package Medium = Medium_eva)
    "Mass flow sensor at the evaporator" annotation (Placement(transformation(
        origin={-130,52},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  HeatPumps.BaseClasses.CycleHP cycle(
    HPctrlType=HPctrlType,
    capCalcType=capCalcType,
    dataTable=dataTable,
    redeclare function data_poly = data_poly,
    N_max=N_max,
    N_min=N_min,
    N_nom=N_nom,
    Corr_icing=Corr_icing,
    eta_ele=eta_ele,
    factorScale=factorScale,
    P_eleAdd=P_eleAdd,
    CorrFlowCo=CorrFlowCo,
    CorrFlowEv=CorrFlowEv,
    timeConstantCycle=timeConstantCycle,
    smoothness=smoothness,
    PT1_cycle=PT1_cycle,
    mFlow_conNominal=mFlow_conNominal,
    mFlow_evaNominal=mFlow_evaNominal,
    T_conMax=T_conMax) "Heat pump refrigerant circuit black box model"
    annotation (Placement(transformation(extent={{-50,-20},{40,40}})));
  Modelica.Blocks.Interfaces.BooleanInput onOff_in
    "Enable or disable heat pump" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,90})));
  Modelica.Blocks.Interfaces.RealInput N_in if not HPctrlType
    "Rotational speed of compressor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,90})));

  parameter Boolean heatLosses_con=false
    "Consider heat losses of condenser to ambient" annotation (Dialog(group="Heat losses of condenser",
        tab="Advanced"), choices(checkBox=true));
  parameter SI.ThermalConductance R_loss=1
    "Thermal conductance of heat loss to ambient" annotation (Dialog(
      group="Heat losses of condenser",
      tab="Advanced",
      enable=heatLosses_con));
protected
  Modelica.Blocks.Interfaces.RealInput N_inInternal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealInput T_ambInternal
    "Needed to connect to conditional connector";
public
  Modelica.Blocks.Sources.RealExpression dummyZero(y=0)
    "Dummy value used for rotational speed"
    annotation (Placement(transformation(extent={{0,60},{20,80}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor heatConv(G=R_loss)
    "Heat flow through condenser casing with a given conductance"
    annotation (Placement(transformation(extent={{80,52},{100,72}})));
  Modelica.Blocks.Interfaces.RealInput T_amb if
                                               heatLosses_con
    "Ambient temperatur input signal" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,90})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp
    "Foreces heat losses according to ambient temperature"
    annotation (Placement(transformation(extent={{80,76},{100,96}})));
  parameter SI.Temperature T_conMax=338.15
    "Maximum condenser outlet temperature"
    annotation (Dialog(group="Capacity data"));
  Modelica.Blocks.Math.Gain gainMinusOne(k=-1)
    "Calculated heat flow in evaporator has to be withdrawn" annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-73,5})));
  MixingVolumes.MixingVolume evaporator(
    nPorts=2,
    T_start(displayUnit="K") = T_startEva,
    m_flow_nominal=mFlow_evaNominal,
    redeclare package Medium = Medium_eva,
    V=volume_eva) "Volume of evaporator" annotation (Placement(transformation(
        extent={{-7,-6.75},{7,6.75}},
        rotation=-90,
        origin={-120.75,1})));
  FixedResistances.PressureDrop hydRes_eva(
    redeclare package Medium = Medium_eva,
    m_flow_nominal=mFlow_evaNominal,
    m_flow(start=mFlow_evaNominal),
    dp_nominal=dp_evaNominal)
    "The pressure drop caused by flow resistance in the evaporator" annotation (
     Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-130,-22})));
  MixingVolumes.MixingVolume condenser(
    nPorts=2,
    redeclare package Medium = Medium_con,
    T_start(displayUnit="K") = T_startCon,
    m_flow_nominal=mFlow_conNominal,
    V=volume_con) "Volume of condenser" annotation (Placement(transformation(
        extent={{7,6.75},{-7,-6.75}},
        rotation=-90,
        origin={121.25,-1})));
  FixedResistances.PressureDrop hydRes_con(
    redeclare package Medium = Medium_con,
    m_flow_nominal=mFlow_conNominal,
    m_flow(start=mFlow_conNominal),
    dp_nominal=dp_conNominal)
    "The pressure drop caused by flow resistance in the condenser" annotation (
      Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={130,22})));
equation

  if HPctrlType then
    connect(N_inInternal, dummyZero.y);
  else
    connect(N_in, N_inInternal);
  end if;
  connect(N_inInternal, cycle.N_in);

  if heatLosses_con then
    connect(T_ambInternal, T_amb);
    connect(heatConv.port_b, condenser.heatPort);
  else
    connect(T_ambInternal, dummyZero.y);
  end if;
  connect(varTemp.T, T_ambInternal);
  connect(varTemp.port, heatConv.port_a) annotation (Line(points={{100,86},{104,
        86},{104,74},{74,74},{74,62},{80,62}}, color={191,0,0}));

  //fluid connections evaporator
  connect(T_evaOut.port_b, port_evaOut) annotation (Line(
      points={{-130,-56},{-130,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_evaIn, mFlow_eva.port_a) annotation (Line(
      points={{-130,70},{-130,62}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mFlow_eva.port_b, T_evaIn.port_a) annotation (Line(
      points={{-130,42},{-130,36}},
      color={0,127,255},
      smooth=Smooth.None));

  //fluid connections condenser
  connect(mFlow_con.port_a, port_conIn) annotation (Line(
      points={{130,-60},{130,-70}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mFlow_con.port_b, T_conIn.port_a) annotation (Line(
      points={{130,-40},{130,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_conOut.port_b, port_conOut) annotation (Line(
      points={{130,58},{130,70}},
      color={0,127,255},
      smooth=Smooth.None));
  // other connections

  connect(cycle.CoP_out, CoP_out) annotation (Line(
      points={{-8,-17},{-8,-64},{-10,-64},{-10,-90}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(heatFlowRate_eva.Q_flow, gainMinusOne.y) annotation (Line(
      points={{-86,2},{-80,2},{-80,5},{-78.5,5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_conOut.T, cycle.T_conOut) annotation (Line(
      points={{119,48},{60,48},{60,25},{34,25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cycle.Qdot_conOut, heatFlowRate_con.Q_flow) annotation (Line(
      points={{34,13},{70,13},{70,1},{86,1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cycle.T_conIn, T_conIn.T) annotation (Line(
      points={{34,1},{62,1},{62,-26},{119,-26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cycle.mFlow_con, mFlow_con.m_flow) annotation (Line(
      points={{34,7},{54,7},{54,-50},{119,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cycle.T_evaOut, T_evaOut.T) annotation (Line(
      points={{-44,25},{-48,25},{-48,24},{-58,24},{-58,-46},{-119,-46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cycle.mFlow_eva, mFlow_eva.m_flow) annotation (Line(
      points={{-44,19},{-72,19},{-72,52},{-119,52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gainMinusOne.u, cycle.Qdot_evaOut) annotation (Line(
      points={{-67,5},{-62,5},{-62,13},{-44,13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_evaIn.T, cycle.T_evaIn) annotation (Line(
      points={{-119,26},{-82,26},{-82,-8},{-50,-8},{-50,1},{-44,1}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cycle.P_eleOut, P_eleOut) annotation (Line(
      points={{-20,-17},{-18,-17},{-18,-56},{-50,-56},{-50,-90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cycle.onOff_in, onOff_in) annotation (Line(
      points={{-20,37},{-22,37},{-22,60},{-50,60},{-50,90}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(T_evaIn.port_b, evaporator.ports[1]) annotation (Line(points={{-130,16},
          {-130,2.4},{-127.5,2.4}}, color={0,127,255}));
  connect(heatFlowRate_eva.port, evaporator.heatPort) annotation (Line(points={{
          -106,2},{-110,2},{-110,12},{-120.75,12},{-120.75,8}}, color={191,0,0}));
  connect(heatFlowRate_con.port, condenser.heatPort) annotation (Line(points={{104,
          1},{110,1},{110,-10},{116,-10},{110,-10},{121.25,-10},{121.25,-8}},
        color={191,0,0}));
  connect(T_conIn.port_b, condenser.ports[1]) annotation (Line(points={{130,-16},
          {130,-2.4},{128,-2.4}}, color={0,127,255}));
  connect(condenser.ports[2], hydRes_con.port_a) annotation (Line(points={{128,0.4},
          {130,0.4},{130,14}}, color={0,127,255}));
  connect(hydRes_con.port_b, T_conOut.port_a)
    annotation (Line(points={{130,30},{130,34},{130,38}}, color={0,127,255}));
  connect(hydRes_eva.port_a, evaporator.ports[2]) annotation (Line(points={{-130,
          -14},{-130,-14},{-130,-0.4},{-127.5,-0.4}}, color={0,127,255}));
  connect(hydRes_eva.port_b, T_evaOut.port_a) annotation (Line(points={{-130,-30},
          {-130,-33},{-130,-36}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-150,-100},{150,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-150,-100},{150,100}}),
        graphics={
        Rectangle(
          extent={{-130,90},{130,-90}},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-120,80},{-80,-80}},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{80,80},{120,-80}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Text(
          extent={{-80,2},{80,-40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="%name
"),     Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),
        Line(
          points={{-88,40},{-112,40},{-94,-2},{-112,-40},{-88,-40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{88,40},{112,40},{94,-2},{112,-40},{88,-40}},
          color={0,0,0},
          smooth=Smooth.None)}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Heat pump black box model with two simple heat exchangers, no controllers included. </p>
<p>Works as on/off-controlled heat pump or heat pump with capacity control. The type of capacity and electrical power calculation can be chosen: </p>
<ol>
<li>Polynom<br/>a) depending on evaporator input temperature, condenser output temperature and variable speed (via conditional speed connector) for capacity controlled heat pumps <br/>b) depending on evaporator input temperature, condenser output temperature and nominal speed for on/off-controlled heat pump </li>
<li>Table data according for on/off-controlled heat pump, depending on evaporator input temperature, condenser output temperature </li>
</ol>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>Correction models of the calculation can be activated that effect the efficiency or the start-up and shut-off behavior of the heat pump. </p>
<ol>
<li>Icing and Defrosting: Simple model that uses the evaporator inlet temperature and calculates a factor for CoP correction (according to Wetter and Afjei, 1996). Not enabled for table data, as usually already included (data according EN255 and EN14511). </li>
<li>Mass flow in condenser/evaporator: Model according to Pahud and Lachal, 2004, that corrects the temperatures used within table and polynomial. If the mass flow rates are already taken into account in the chosen polynomial, this sould be deactivated!</li>
<li>First order behavior of heat pump capacity: Start-up and shut-off of heat pump can be modeled with a first order behavior. </li>
<li>Electric efficiency: The electric efficiency of the electric drive is implemented to calculate the evaporator heat flow </li>
<li>Scaling factor: A scaling facor is implemented for scaling of the heat pump power and capacity without effecting the heat pump efficiency which is not physically correct but may be helpful for rough calculation. </li>
<li>Additional electric power: This is a constant value that is added to the power consumption. This may be helpful if e.g. an electric drive operates together with the compressor and shall be included in overall electric power and CoP calculation. </li>
<li>The smoothness of table interpolation can be chosen. </li>
<li>Allowed sink temperature: A maximum condenser outlet temperature limits the condenser heat flow through a PID controller. </li>
</ol>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<ul>
<li>Allowed source temperature: No limits for source temperature is implemented. Though, usually this is not a problem if the heat pump is properly integrated into a system model. </li>
<li>Defrost: No direct implementation of defrost behavior. This heat pump does not operate in a defrost mode. Only a general CoP correction can be chosen therefore.</li>
</ul>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The heat pump speed is helt between the boundaries N_min and N_max even if the input speed is higher or lower. But no further controlling is implemented. The control logic is conciously not integrated into this model.</p>
<p>The calculation of the capacity and electric power does not represent any dynamic behavior of the refrigerant cycle as it occurs in real heat pumps. Therefor two possibilities exist, to add dynamic behavior: </p>
<ol>
<li>The condenser and evaporator can be parametized with a certain external fluid volume to represent their thermal inertia in the tab Evaporator/Condenser</li>
<li>A first order element can be added to the calculation in the tab Advanced if the check box PT1_cycle is enabled (see: <i>Correction models)</i></li>
</ol>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Sources:</p>
<ul>
<li>Pahud, D. and Lachal, B.: <i>Mesure des performances thermiques d?une pompe &agrave; chaleur coupl&eacute;e sur des sondes g&eacute;othermiques &agrave; Lugano (TI)</i>. Office f&eacute;d&eacute;ral de l&apos;energie, Bern, Switzerland. 2004. </li>
<li>Wetter, M. and Afjei, T.: <i>TRNSYS TYPE 401 - Kompressionsw&auml;rmepumpe inklusiv Frost- und Taktverluste</i>. Zentralschweizerisches Technikum Luzern - Ingenieruschule HTL, Switzerland. 1996. </li>
</ul>
<h4><span style=\"color:#008000\">Example</span></h4>
<p>See <a href=\"AixLib.Fluid.HeatPumps.Examples.HeatPumpDetailed\">AixLib.Fluid.HeatPumps.Examples.HeatPumpDetailed</a> </p>
</html>", revisions="<html>
<ul>
<li><i>June 23, 2015&nbsp;</i> by Kristian Huchtemann:<br/>formatted for use in AixLib</li>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
<li><i>March 27, 2013&nbsp;</i> by Kristian Huchtemann:<br/>Corrected connection of evaporator inlet and outlet temperature connectors. Added maximum condenser temperature implementation.</li>
<li><i>January 09, 2006&nbsp;</i> by Peter Matthes:<br/>V0.1: Initial configuration.</li>
</ul>
</html>"));
end HeatPumpDetailed;
