within AixLib.FastHVAC.Components.HeatGenerators.HeatPump;
model HeatPump "Simple heat pump model"

    /* *******************************************************************
      Medium
      ******************************************************************* */

     parameter FastHVAC.Media.BaseClasses.MediumSimple medium_ev=
      FastHVAC.Media.WaterSimple()
    "Standard charastics for water (heat capacity, density, thermal conductivity)"
    annotation (Evaluate=true, Dialog(tab="Evaporator, Condenser",group="Evaporator"),choicesAllMatching=true);

     parameter FastHVAC.Media.BaseClasses.MediumSimple medium_co=
      FastHVAC.Media.WaterSimple()
    "Standard charastics for water (heat capacity, density, thermal conductivity)"
    annotation (Evaluate=true, Dialog(tab="Evaporator, Condenser",group="Evaporator"),choicesAllMatching=true);

    /* *******************************************************************
      HeatPump Parameters
      ******************************************************************* */

  import SI = Modelica.SIunits;

  parameter Boolean hP_ctrlType =  true "Capacity control type"
    annotation(Dialog(group = "Heat Pump cycle", compact = true, descriptionLabel = true), choices(choice=true
        "On/off heat pump",choice = false "Speed controlled heat pump",
                              radioButtons = true));
  parameter Integer cap_calcType = 1 "Type of capacity calculation"
    annotation(Dialog(group = "Heat Pump cycle", compact = true, descriptionLabel = true, enable=hP_ctrlType), choices(choice=1
        "Polynomial", choice = 2 "Table (only on/off heat pump)",   radioButtons = true));

  parameter SI.Volume volume_ev=0.004
    "External medium volume in heat exchanger"
    annotation ( Dialog(tab="Evaporator, Condenser",group="Evaporator"));

 // Parameter Integer n_Ev=3 "External discretisation of heat exchanger" annotation ( Dialog(tab="Evaporator, Condenser",group="Evaporator"));
 parameter SI.Volume volume_co=0.004 "External medium volume in heat exchanger"
    annotation ( Dialog(tab="Evaporator, Condenser",group="Condenser"));

 // Parameter Integer n_Co=3 "External discretisation of heat exchanger" annotation ( Dialog(tab="Evaporator, Condenser",group="Condenser"));
  parameter AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition data_table=
      AixLib.DataBase.HeatPump.EN255.Vitocal350BWH110()
    "Look-up table data for on/off heat pump according to EN255" annotation (
      choicesAllMatching=true, Dialog(enable=hP_ctrlType and (cap_calcType == 2),
        group="Capacity data"));

/*  Parameter HeatPumpSystem.HeatPump.TableData.HeatPumpBaseDataDefinition        data_table_EN14511=
       HeatPumpSystem.HeatPump.TableData.EN14511.StiebelEltron_WPL18() 
    "Look-up table data for on/off heat pump according to EN14511"  annotation(choicesAllMatching=true,Dialog(enable=HP_ctrl_type and (Cap_calc_type==2),group="Capacity data"));*/

protected
  final parameter Real tableDotQ_co[:,:]=data_table.tableQdot_con;
  final parameter Real tableP_el[:,:]= data_table.tableP_ele;

public
  replaceable function data_poly =
  AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.ConstantQualityGrade
    constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.PartialBaseFct
    "Polynomial heat pump characteristics for inverter heat pump"
    annotation(choicesAllMatching = true,Dialog(enable=(cap_calcType==1),group="Capacity data"));

  parameter SI.Temperature T_startEv=273.15 "Initial evaporator temperature"
    annotation (Evaluate=true, Dialog(tab="Evaporator, Condenser", group="Initialization", enable=initEvaporatorVol));
  parameter SI.Temperature T_startCo=308.15 "Initial condenser temperature"
    annotation (Evaluate=true, Dialog(tab="Evaporator, Condenser", group="Initialization", enable=initCondenserVol));
  replaceable function corr_icing =
  AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.NoModel
    constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.PartialBaseFct
    "Frost/Defrost model (only air-to-water heat pumps)"
    annotation(choicesAllMatching = true,Dialog(enable=(cap_calcType==1),group="Defrosting/Icing correction",tab="Advanced"));

  parameter Real N_max=4200 "Maximum speed of compressor in 1/min"  annotation(Dialog(enable=not
                                                                                              (hP_ctrlType),group="Capacity data"));
  parameter Real N_min=1500 "Minimum speed of compressor in 1/min"  annotation(Dialog(enable=not
                                                                                              (hP_ctrlType),group="Capacity data"));
  parameter Real N_nom=3600 "Nominal speed of compressor in 1/min"  annotation(Dialog(enable=hP_ctrlType and (cap_calcType == 1),group="Capacity data"));
  parameter Boolean Pel_ouput=false "Electric power consumption"
    annotation (Dialog(group="Optional outputs",tab="Advanced", descriptionLabel = true), choices(checkBox=true));
  parameter Boolean CoP_output=false "CoP"
    annotation (Dialog(group="Optional outputs",tab="Advanced", descriptionLabel = true), choices(checkBox=true));
  parameter Boolean PT1_cycle=false "First Order model for capacity"
    annotation(Dialog(group = "Start/stop behavior",tab="Advanced"), choices(checkBox=true));
  parameter SI.Time T_hpCycle=1 "Time constant for first order model"
    annotation(Dialog(group = "Start/stop behavior",tab="Advanced", enable=PT1_cycle));

  parameter Real eta_el( unit="1")=1
    "Assumption of P_tech/P_el (for calculation of Evaporator load)"
     annotation(Dialog(group="Assumptions",tab="Advanced"));
  parameter Real factor_scale=1
    "Scaling factor (Attention: not physically correct)"
     annotation(Dialog(group="Assumptions",tab="Advanced"));
  parameter SI.Power Pel_add=0
    "Additional electric power when heat pump is on (not influenced through scaling factor)"
     annotation(Dialog(group="Assumptions",tab="Advanced"));
  parameter Boolean corrFlowCo=false
    "Correction of mass flow different from nominal flow in condenser"
     annotation(Dialog(group="Mass flow correction",tab="Advanced"), choices(checkBox=true));
  parameter SI.MassFlowRate dotm_nominalCo=0.5
    "Nominal mass flow rate in condenser, only for polynomials, as already included in data tables"
    annotation(Dialog(group="Mass flow correction",tab="Advanced",enable=(corrFlowCo and cap_calcType==1)));
  parameter Boolean corrFlowEv=false
    "Correction of mass flow different from nominal flow in evaporator"
     annotation(Dialog(group="Mass flow correction",tab="Advanced"), choices(checkBox=true));
  parameter SI.MassFlowRate dotm_nominalEv=0.5
    "Nominal mass flow rate in evaporator, only for polynomials, as already included in data tables"
    annotation(Dialog(group="Mass flow correction",tab="Advanced",enable=(corrFlowEv and cap_calcType==1)));

  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"
    annotation(Dialog(group = "Assumptions",tab="Advanced", enable=not
                                                                      (cap_calcType==1)));

  parameter Boolean heatLossesCo=false
    "Consider heat losses of condenser to ambient"
  annotation(Dialog(group="Heat losses of condenser",tab="Advanced"), choices(checkBox=true));
  parameter SI.ThermalConductance R_loss=1
    "Thermal conductance of heat loss to ambient"
    annotation(Dialog(group = "Heat losses of condenser",tab="Advanced", enable=heatLossesCo));

  /* *******************************************************************
      Components
     ******************************************************************* */

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                heatFlow_dotQCo
                                 annotation (Placement(transformation(
        origin={93,3},
        extent={{9,-9},{-9,9}},
        rotation=180)));
public
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
                                heatFlow_dotQEv
                                 annotation (Placement(transformation(extent={{-82,-22},{-102,-2}},
          rotation=0)));
FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_outEv annotation (Placement(
        transformation(extent={{-134,-92},{-114,-72}}), iconTransformation(
          extent={{-134,-92},{-114,-72}})));
     FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_inCo annotation (Placement(
        transformation(extent={{116,-92},{136,-72}}), iconTransformation(extent=
           {{116,-92},{136,-72}})));
    FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_outCo annotation (Placement(
        transformation(extent={{112,74},{132,94}}), iconTransformation(extent={{
            112,74},{132,94}})));
    FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_inEv annotation (Placement(
        transformation(extent={{-134,72},{-114,92}}), iconTransformation(extent=
           {{-134,72},{-114,92}})));
    Modelica.Blocks.Interfaces.RealOutput Pel_out( unit="W") if Pel_ouput annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-84})));
  Modelica.Blocks.Interfaces.RealOutput CoP_out( unit="1") if CoP_output annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-8,-84})));

  Fluid.HeatPumps.BaseClasses.CycleHP                   cycle(
    HPctrlType=hP_ctrlType,
    capCalcType=cap_calcType,
    dataTable=data_table,
    redeclare function data_poly = data_poly,
    N_max=N_max,
    N_min=N_min,
    N_nom=N_nom,
    redeclare function Corr_icing=corr_icing,
    eta_ele=eta_el,
    factorScale=factor_scale,
    P_eleAdd=Pel_add,
    CorrFlowCo=corrFlowCo,
    CorrFlowEv=corrFlowEv,
    timeConstantCycle=T_hpCycle,
    smoothness=smoothness,
    PT1_cycle=true,
    mFlow_conNominal=dotm_nominalCo,
    mFlow_evaNominal=dotm_nominalEv,
    T_conMax=T_maxCo)
    annotation (Placement(transformation(extent={{-48,-18},
            {42,42}})));
  Modelica.Blocks.Interfaces.BooleanInput onOff_in annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,90})));
  Modelica.Blocks.Interfaces.RealInput N_in(unit="1/min") if not hP_ctrlType annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,90})));

  Modelica.Blocks.Sources.RealExpression dummy_zero(y=0)            annotation (Placement(transformation(extent={{0,60},{
            20,80}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
                                heatConv(G=R_loss)
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Modelica.Blocks.Interfaces.RealInput T_amb(unit="K") if
                                               heatLossesCo annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,90})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
                          varTemp
    annotation (Placement(transformation(extent={{80,76},{100,96}})));
  FastHVAC.Components.Sensors.MassFlowSensor dotm_ev annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-130,50})));

  FastHVAC.Components.Sensors.TemperatureSensor T_inEv annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-130,26})));
  FastHVAC.BaseClasses.WorkingFluid evFluid(
  medium=medium_ev,
  m_fluid=volume_ev*medium_ev.rho,
  T0=T_startEv) annotation (Placement(transformation(
        extent={{-15,-16},{15,16}},
        rotation=270,
        origin={-130,-11})));
  FastHVAC.Components.Sensors.TemperatureSensor T_outEv annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-130,-44})));

  FastHVAC.Components.Sensors.MassFlowSensor dotm_co annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,-56})));
  FastHVAC.Components.Sensors.TemperatureSensor T_inCo annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,-32})));
  FastHVAC.BaseClasses.WorkingFluid coFluid(
  medium=medium_co,
  m_fluid=volume_co*medium_co.rho,
  T0=T_startCo) annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=90,
        origin={130,2})));
  FastHVAC.Components.Sensors.TemperatureSensor T_outCo annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,36})));

 parameter SI.Temperature T_maxCo=338.15 "Maximum condenser outlet temperature";
protected
  Modelica.Blocks.Interfaces.RealInput N_inInternal
    "Needed to connect to conditional connector";
  Modelica.Blocks.Interfaces.RealInput T_ambInternal if heatLossesCo
    "Needed to connect to conditional connector";

public
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={-70,-12})));
equation
  if hP_ctrlType then
    connect(N_inInternal,dummy_zero.y);
  else
    connect(N_in,N_inInternal);
  end if;
  connect(N_inInternal,cycle.N_in);

  if heatLossesCo then
    connect(T_ambInternal, T_amb);
  else  connect(varTemp.T,dummy_zero.y);
  end if;

  connect(varTemp.port, heatConv.port_a);
  connect(varTemp.T, T_ambInternal);

  //fluid connections evaporator

  connect(T_outEv.enthalpyPort_b, enthalpyPort_outEv) annotation (Line(
      points={{-130.1,-53},{-130.1,-54.5},{-124,-54.5},{-124,-82}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(dotm_ev.enthalpyPort_a, enthalpyPort_inEv) annotation (Line(
      points={{-130.1,58.8},{-130.1,65.4},{-124,65.4},{-124,82}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(dotm_ev.enthalpyPort_b,T_inEv. enthalpyPort_a) annotation (Line(
      points={{-130.1,41},{-130.1,34.8}},
      color={176,0,0},
      smooth=Smooth.None));

  //fluid connections condenser

  connect(T_outCo.enthalpyPort_b, enthalpyPort_outCo) annotation (Line(
      points={{130.1,45},{130.1,84},{122,84}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(dotm_co.enthalpyPort_a, enthalpyPort_inCo) annotation (Line(
      points={{130.1,-64.8},{130.1,-70.4},{126,-70.4},{126,-82}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(dotm_co.enthalpyPort_b,T_inCo. enthalpyPort_a) annotation (Line(
      points={{130.1,-47},{130.1,-40.8}},
      color={176,0,0},
      smooth=Smooth.None));

  // other connections

  connect(enthalpyPort_outCo, enthalpyPort_outCo) annotation (Line(
      points={{122,84},{122,84}},
      color={176,0,0},
      smooth=Smooth.None));

  connect(cycle.CoP_out, CoP_out) annotation (Line(
      points={{-6,-15},{-6,-48.5},{-8,-48.5},{-8,-84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(evFluid.enthalpyPort_b, T_outEv.enthalpyPort_a) annotation (Line(
      points={{-130,-24.5},{-130,-35.2},{-130.1,-35.2}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(evFluid.enthalpyPort_a, T_inEv.enthalpyPort_b) annotation (Line(
      points={{-130,2.5},{-130,17},{-130.1,17}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(coFluid.enthalpyPort_a, T_inCo.enthalpyPort_b) annotation (Line(
      points={{130,-12.4},{130,-17.25},{130.1,-17.25},{130.1,-23}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(coFluid.enthalpyPort_b, T_outCo.enthalpyPort_a) annotation (Line(
      points={{130,16.4},{130,19.25},{130.1,19.25},{130.1,27.2}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(evFluid.heatPort, heatFlow_dotQEv.port) annotation (Line(
      points={{-114.96,-11},{-99.48,-11},{-99.48,-12},{-102,-12}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatFlow_dotQCo.port, coFluid.heatPort) annotation (Line(
      points={{102,3},{102,2},{114.96,2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatFlow_dotQEv.Q_flow, gain.y) annotation (Line(
      points={{-82,-12},{-74.4,-12}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(onOff_in, cycle.onOff_in) annotation (
      Line(points={{-50,90},{-50,60},{-18,60},{-18,
          39}}, color={255,0,255}));
  connect(T_inEv.T, cycle.T_evaIn) annotation (
      Line(points={{-119,25},{-60,25},{-60,3},{-42,
          3}}, color={0,0,127}));
  connect(dotm_ev.dotm, cycle.mFlow_eva)
    annotation (Line(points={{-121,49},{-60,49},{-60,
          21},{-42,21}}, color={0,0,127}));
  connect(T_outEv.T, cycle.T_evaOut) annotation (
      Line(points={{-119,-45},{-60,-45},{-60,27},{
          -42,27}}, color={0,0,127}));
  connect(gain.u, cycle.Qdot_evaOut) annotation (
      Line(points={{-65.2,-12},{-60,-12},{-60,15},
          {-42,15}}, color={0,0,127}));
  connect(cycle.P_eleOut, Pel_out) annotation (
      Line(points={{-18,-15},{-18,-15},{-18,-56},{
          -50,-56},{-50,-84}}, color={0,0,127}));
  connect(T_outCo.T, cycle.T_conOut) annotation (
      Line(points={{119,37},{60,37},{60,27},{36,27}},
        color={0,0,127}));
  connect(cycle.Qdot_conOut, heatFlow_dotQCo.Q_flow)
    annotation (Line(points={{36,15},{60,15},{60,3},
          {84,3}}, color={0,0,127}));
  connect(dotm_co.dotm, cycle.mFlow_con)
    annotation (Line(points={{121,-55},{60,-55},{60,
          9},{36,9}}, color={0,0,127}));
  connect(T_inCo.T, cycle.T_conIn) annotation (
      Line(points={{119,-31},{90,-31},{90,-32},{60,
          -32},{60,3},{36,3}}, color={0,0,127}));
                                                                                          annotation (Evaluate=true, Dialog(tab="Evaporator, Condenser",group="Condenser"),choicesAllMatching=true,
                 Dialog(group="Mass flow correction",tab="Advanced",enable=(corrFlowEv and cap_calcType==1)),
              Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,-100},
            {150,100}})),           Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-150,-100},{150,100}}), graphics={
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
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,0}),
        Line(
          points={{-88,40},{-112,40},{-94,-2},{-112,-40},{-88,-40}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{88,40},{112,40},{94,-2},{112,-40},{88,-40}},
          color={0,0,0},
          smooth=Smooth.None),
          Text(
          extent={{-78,12},{78,-10}},
          lineColor={0,0,255},
          textString="%name")}),
             Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Heat pump black box model with two simple heat exchangers, no
  controllers included.
</p>
<p>
  Works as on/off-controlled heat pump or heat pump with capacity
  control. The type of capacity and electrical power calculation can be
  chosen:
</p>
<ol>
  <li>Polynom<br/>
    a) depending on evaporator input temperature, condenser output
    temperature and variable speed (via conditional speed connector)
    for capacity controlled heat pumps<br/>
    b) depending on evaporator input temperature, condenser output
    temperature and nominal speed for on/off-controlled heat pump
  </li>
  <li>Table data according for on/off-controlled heat pump, depending
  on evaporator input temperature, condenser output temperature
  </li>
</ol>
<h4>
  <span style=\"color:#008000\">Assumptions</span>
</h4>
<p>
  Correction models of the calculation can be activated that effect the
  efficiency or the start-up and shut-off behavior of the heat pump.
</p>
<ol>
  <li>Icing and Defrosting: Simple model that use the evaporator inlet
  temperature and calculates a factor for CoP correction (according to
  Wetter and Afjei, 1996). Not enabled for table data, as usually
  already included (data according EN255 and EN14511).
  </li>
  <li>Mass flow in condenser/evaporator: Model according to Pahud and
  Lachal, 2004, that corrects the temperatures used within table and
  polynomial.
  </li>
  <li>First order behavior of heat pump capacity: Start-up and shut-off
  of heat pump can be modeled with a first order behavior.
  </li>
  <li>Delay of heat pump capacity: Start-up and shut-off of heat pump
  can be modeled with a delay time.
  </li>
  <li>Electric efficiency: The electric efficiency of the electric
  drive is implemented to calculate the evaporator heat flow
  </li>
  <li>Scaling factor: A scaling facor is implemented for scaling of the
  heat pump power and capacity without effecting the heat pump
  efficiency which might not be physically correct but may be helpful
  for rough calculation.
  </li>
  <li>Additional electric power: This is a constant value that is added
  to the power consumption. This may be helpful if e.g. an electric
  drive operates together with the compressor and shall be included in
  overall electric power and CoP calculation.
  </li>
  <li>The smoothness of table interpolation can be chosen.
  </li>
</ol>
<h4>
  <span style=\"color:#008000\">Known Limitations</span>
</h4>
<ul>
  <li>Allowed source temperature: No limits for source temperature is
  implemented. Though, usually this is not a problem if the heat pump
  is properly integrated into a system model.
  </li>
  <li>Allowed sink temperature: No limits for sink temperature is
  implemented. Be careful when setting up the heat pump control.
  </li>
  <li>Defrost: No direct implementation of dynamic defrost behavior.
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The heat pump speed is helt between the boundaries N_min and N_max
  even if the input speed is higher or lower. But no further
  controlling is implemented. The control logic is conciously not
  integrated into this model.
</p>
<p>
  The calculation of the capacity and electric power does not represent
  any dynamic behavior of the refrigerant cycle as it occurs in real
  heat pumps. Therefor two possibilities exist, to add dynamic
  behavior:
</p>
<ol>
  <li>The condenser and evaporator can be parametized with a certain
  external fluid volume to represent their thermal inertia in the tab
  Evaporator/Condenser
  </li>
  <li>A first order element can be added to the calculation in the tab
  Advanced if the check box PT1_cycle is enabled (see: <i>Correction
  models)</i>
  </li>
</ol>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<ul>
  <li>Pahud, D. and Lachal, B.: <i>Mesure des performances thermiques
  d?une pompe à chaleur couplée sur des sondes géothermiques à Lugano
  (TI)</i>. Office fédéral de l'energie, Bern, Switzerland. 2004.
  </li>
  <li>Wetter, M. and Afjei, T.: <i>TRNSYS TYPE 401 -
  Kompressionswärmepumpe inklusiv Frost- und Taktverluste</i>.
  Zentralschweizerisches Technikum Luzern - Ingenieruschule HTL,
  Switzerland. 1996.
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  See <a href=
  \"FastHVAC.Examples.HeatGenerators.HeatPump.ValidationHeatPump\">ValidationHeatPump</a>
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>November 28, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>January 12, 2015&#160;</i> by Konstantin Finkbeiner:<br/>
    Addapted to FastHVAC.
  </li>
  <li>
    <i>December 10, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>April 23, 2013&#160;</i>by Kristian Huchtemann:<br/>
    implemented
  </li>
</ul>
</html>"));
end HeatPump;
