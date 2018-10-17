within AixLib.Fluid.HeatPumps.BaseClasses;
model CycleHP
  import SI = Modelica.SIunits;
  parameter Boolean HPctrlType =  true "Capacity control type"
    annotation(Dialog(group = "Heat Pump cycle", compact = true, descriptionLabel = true), choices(choice=true
        "On/off heat pump",choice = false "Speed controlled heat pump",
                              radioButtons = true));
  parameter Integer capCalcType = 1 "Type of capacity calculation"
    annotation(Dialog(group = "Heat Pump cycle", compact = true, descriptionLabel = true, enable=HPctrlType), choices(choice=1
        "Polynomial", choice = 2 "Table (only on/off heat pump)",   radioButtons = true));

  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable=
      AixLib.DataBase.HeatPump.EN255.Vitocal350BWH113()
    "Look-up table data for on/off heat pump according to EN255/EN14511"
    annotation (choicesAllMatching=true, Dialog(enable=HPctrlType and (
          capCalcType == 2), group="Capacity data"));
protected
  final parameter Real tableQdot_con[:,:]=dataTable.tableQdot_con;
  final parameter Real tableP_ele[:,:]= dataTable.tableP_ele;
public
  replaceable function data_poly =
  AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.ConstantQualityGrade
    constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.PartialBaseFct
    "Polynomial heat pump characteristics"
   annotation(choicesAllMatching = true,Dialog(enable=(capCalcType==1),group="Capacity data"));

  replaceable function Corr_icing =
  AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.NoModel
                                                                 constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.PartialBaseFct
    "Frost/Defrost model (only air-to-water heat pumps)"
   annotation(choicesAllMatching = true,Dialog(enable=(capCalcType==1),group="Defrosting/Icing correction",tab="Advanced"));
parameter SI.Temperature T_conMax=338.15 "Maximum condenser outlet temperature"   annotation(Dialog(group="Heat Pump cycle"));
  parameter Real N_max=4200
    "Maximum speed of compressor in 1/min (only used if used in polynom)"                          annotation(Dialog(enable=not
                                                                                            (HPctrlType),group="Capacity data"));
  parameter Real N_min=1500
    "Minimum speed of compressor in 1/min (only used if used in polynom)"                          annotation(Dialog(enable=not
                                                                                            (HPctrlType),group="Capacity data"));
  parameter Real N_nom=3600
    "Nominal speed of compressor in 1/min (only used if used in polynom)"                          annotation(Dialog(enable=HPctrlType and (capCalcType == 1),group="Capacity data"));
  parameter Boolean PT1_cycle=false "First Order model for capacity" annotation(Dialog(group = "Start/stop behavior",tab="Advanced"), choices(checkBox=true));
  parameter SI.Time timeConstantCycle=1 "Time constant for first order model" annotation(Dialog(group = "Start/stop behavior",tab="Advanced", enable=PT1_cycle));
  parameter Real eta_ele=1
    "Assumption of P_tech/P_el (for calculation of Evaporator load)"                         annotation(Dialog(group="Assumptions",tab="Advanced"));
  parameter Real factorScale=1
    "Scaling factor (Attention: not physically correct)"
     annotation(Dialog(group="Assumptions",tab="Advanced"));
  parameter SI.Power P_eleAdd=0
    "Additional electric power when heat pump is on (not influenced through scaling factor)"
    annotation(Dialog(group="Assumptions",tab="Advanced"));

  parameter Boolean CorrFlowCo=false
    "Correction of mass flow different from nominal flow in condenser (use only if not included in polynom)"
    annotation(Dialog(group="Mass flow correction",tab="Advanced"), choices(checkBox=true));

  parameter SI.MassFlowRate mFlow_conNominal=0.5
    "Nominal mass flow rate in condenser"
  annotation(Dialog(group="Mass flow correction",tab="Advanced", enable=(CorrFlowCo and capCalcType==1)));

  parameter Boolean CorrFlowEv=false
    "Correction of mass flow different from nominal flow in evaporator  (use only if not included in polynom)"
    annotation(Dialog(group="Mass flow correction",tab="Advanced"), choices(checkBox=true));

  parameter SI.MassFlowRate mFlow_evaNominal=0.5
    "Nominal mass flow rate in evaporator"
  annotation(Dialog(group="Mass flow correction",tab="Advanced",enable=(CorrFlowEv and capCalcType==1)));

  SI.Power P_ele;
  SI.Power P_eleChar;
  SI.HeatFlowRate Qdot_eva;
  SI.HeatFlowRate Qdot_con;
  SI.HeatFlowRate Qdot_conChar;
  Real CoP;
  Real CoP_corr;
  Real CoP_char;
  Real N;
  Real factorCoP_icing;
  Real Char[2];
  Real T_conOutCorr;
  Real T_evaInCorr;

  Modelica.Blocks.Interfaces.RealOutput P_eleOut annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-90})));
  Modelica.Blocks.Interfaces.BooleanInput onOff_in annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,90})));
  Modelica.Blocks.Interfaces.RealOutput CoP_out annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-90})));
  Modelica.Blocks.Interfaces.RealInput N_in  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,90})));

protected
  Modelica.Blocks.Interfaces.RealInput firstOrder_outInternal
    "Needed to connect to conditional model";
  Modelica.Blocks.Interfaces.RealOutput firstOrder_inInternal
    "Needed to connect to conditional model";
  Modelica.Blocks.Interfaces.RealInput Qdot_conTableInternal
    "Needed to connect to conditional model";
  Modelica.Blocks.Interfaces.RealInput P_eleTableInternal
    "Needed to connect to conditional model";
  SI.MassFlowRate mFlow_conNom;
  SI.MassFlowRate mFlow_evaNom;

public
  Modelica.Blocks.Sources.RealExpression realQdot_con(y=Qdot_con)
    annotation (Placement(transformation(extent={{40,24},{60,44}},
          rotation=0)));
public
  Modelica.Blocks.Sources.RealExpression realQdot_eva(y=Qdot_eva)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
        origin={-110,-10})));
public
  Modelica.Blocks.Sources.RealExpression realPel(y=P_ele) annotation (Placement(
        transformation(extent={{-92,-40},{-72,-20}}, rotation=0)));
public
  Modelica.Blocks.Sources.RealExpression realCoP(y=CoP) annotation (Placement(
        transformation(extent={{-32,-66},{-12,-46}}, rotation=0)));

  Modelica.Blocks.Tables.CombiTable2D Qdot_ConTable(
    tableName="NoName",
    fileName="NoName",
    table=tableQdot_con,
    smoothness=smoothness) if
                            not (capCalcType == 1)
    annotation (extent=[-60,40; -40,60], Placement(transformation(extent={{-40,20},
            {-20,40}})));

  Modelica.Blocks.Tables.CombiTable2D P_eleTable(
    tableName="NoName",
    fileName="NoName",
    table=tableP_ele,
    smoothness=smoothness) if
                        not (capCalcType == 1) "Electrical power table"
    annotation (extent=[-60,-20; -40,0], Placement(transformation(extent={{-40,-10},
            {-20,10}})));
public
  Modelica.Blocks.Sources.RealExpression realT_evaIn(y=T_evaInCorr)
    annotation (Placement(transformation(extent={{-94,26},{-74,46}}, rotation=0)));
public
  Modelica.Blocks.Sources.RealExpression realT_conOut(y=T_conOutCorr)
    annotation (Placement(transformation(extent={{-94,6},{-74,26}}, rotation=0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=timeConstantCycle) if
                                                                    PT1_cycle
    annotation (Placement(transformation(extent={{42,-6},{62,14}})));
public
  Modelica.Blocks.Math.Product productPelCoP1 annotation (Placement(
        transformation(extent={{8,-46},{28,-26}}, rotation=0)));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-68,30},
            {-56,42}})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_out
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-68,10},
            {-56,22}})));
public
  Modelica.Blocks.Sources.RealExpression dummyZero(y=0) annotation (Placement(
        transformation(extent={{40,-86},{60,-66}}, rotation=0)));
public
  Modelica.Blocks.Sources.RealExpression realCoP_corr(y=CoP_corr) annotation (
      Placement(transformation(extent={{-32,-50},{-12,-30}}, rotation=0)));
  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation" annotation(Dialog(group = "Assumptions",tab="Advanced", enable=not
                                                                                            (capCalcType==1)));
public
  Modelica.Blocks.Logical.TriggeredTrapezoid realP_eleAdd(amplitude=P_eleAdd)
    annotation (Placement(transformation(extent={{-72,-54},{-64,-46}},
          rotation=0)));
public
  Modelica.Blocks.Logical.GreaterThreshold greaterZero annotation (Placement(
        transformation(extent={{-88,-54},{-80,-46}}, rotation=0)));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-56,-52},{-46,-42}})));

public
  Modelica.Blocks.Sources.RealExpression dummyOne(y=1) annotation (Placement(
        transformation(extent={{40,-70},{60,-50}}, rotation=0)));

public
  Modelica.Blocks.Interfaces.RealOutput Qdot_conOut "Value of Real output"
    annotation (Placement(transformation(extent={{120,0},{140,20}})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_conIn
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{116,-36},
            {104,-24}})));
  Modelica.Blocks.Interfaces.RealInput T_conIn
    "Connector of Real input signal to be converted" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={130,-30})));
  Modelica.Blocks.Interfaces.RealInput T_evaIn
    "Connector of Real input signal to be converted" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,-30})));
  Modelica.Blocks.Interfaces.RealOutput Qdot_evaOut "Value of Real output"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-130,10})));
  Modelica.Blocks.Interfaces.RealInput T_conOut
    "Connector of Real input signal to be converted" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={130,50})));
  Modelica.Blocks.Interfaces.RealInput T_evaOut
    "Connector of Real input signal to be converted" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,50})));
  Modelica.Blocks.Interfaces.RealInput mFlow_eva
    "Connector of Real input signal to be converted" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,30})));
  Modelica.Blocks.Interfaces.RealInput mFlow_con
    "Connector of Real input signal to be converted" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={130,-10})));
public
  Modelica.Blocks.Sources.RealExpression maxTempCon(y=T_conMax) annotation (
      Placement(transformation(extent={{14,52},{34,72}}, rotation=0)));
public
  Modelica.Blocks.Math.Product productPelCoP2 annotation (Placement(
        transformation(extent={{80,30},{100,50}}, rotation=0)));
  Modelica.Blocks.Continuous.LimPID PIDmaxHeatFlowCon(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1,
    yMax=1,
    yMin=0,
    y_start=1) annotation (Placement(transformation(extent={{46,52},{66,72}})));
equation
  // correction of temperatures used in the table/polynomial
  if capCalcType==1 then
    mFlow_conNom= mFlow_conNominal;
    mFlow_evaNom= mFlow_evaNominal;
  else
    mFlow_conNom=dataTable.mFlow_conNom;
    mFlow_evaNom=dataTable.mFlow_evaNom;
  end if;

  if CorrFlowCo then
    T_conOutCorr=1/2*(mFlow_con/mFlow_conNom*(T_conOut-T_conIn)+T_conIn+T_conOut);
  else
    T_conOutCorr=T_conOut;
  end if;

  if CorrFlowEv then
    T_evaInCorr=1/2*(mFlow_eva/mFlow_evaNom*(T_evaIn-T_evaOut)+(T_evaIn+T_evaOut));
  else
    T_evaInCorr=T_evaIn;
  end if;

  // determination of speed N
if HPctrlType then
    N=N_nom;
else
  if N_in > N_max then
      N=N_max;
  else
    if N_in < N_min then
      N=N_min;
    else
      N=N_in;
    end if;
  end if;
end if;
  // determination of basic heat pump characteristics Qdot_conChar and P_eleChar and CoP_char
  if capCalcType==1 then //polynom
    Char=data_poly(N,T_conOutCorr, T_evaInCorr,mFlow_con,mFlow_eva);
  else //table
    Char={P_eleTableInternal,Qdot_conTableInternal};
  end if;

  if onOff_in then
    Qdot_conChar=Char[2];
    P_eleChar=Char[1];
    CoP_char=Qdot_conChar/P_eleChar;
  else
    Qdot_conChar=0;
    P_eleChar=0;
    CoP_char=0;
  end if;

  // determination of CoP-corrections
  if capCalcType==1 then
    factorCoP_icing=Corr_icing( T_evaInCorr-273.15);
  else
    factorCoP_icing=1;
  end if;

  CoP_corr=CoP_char*factorCoP_icing;//*f_cop_spread;

    P_ele=P_eleChar*factorScale;
  Qdot_con=firstOrder_outInternal;
  if onOff_in then
    if Qdot_con-P_ele*eta_ele>0 then
      Qdot_eva=Qdot_con-P_ele*eta_ele;
    else
      Qdot_eva=0;
    end if;
    CoP=Qdot_con/add.y;
  else
    Qdot_eva=0;
    CoP=0;
  end if;
  //internal connections for conditional models

  connect(productPelCoP1.y, firstOrder_inInternal);
  if PT1_cycle then
    connect(firstOrder_inInternal,firstOrder.u);
    connect(firstOrder.y,firstOrder_outInternal);
  else
     connect(firstOrder_inInternal,firstOrder_outInternal);
  end if;

   if capCalcType==1 then //polynom
    connect(Qdot_conTableInternal, dummyZero.y);
    connect(P_eleTableInternal, dummyZero.y);
   else
     connect(Qdot_conTableInternal,Qdot_ConTable.y);
    connect(P_eleTableInternal, P_eleTable.y);
   end if;

  connect(realPel.y, productPelCoP1.u1) annotation (Line(
      points={{-71,-30},{6,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realCoP.y, CoP_out) annotation (Line(
      points={{-11,-56},{-10,-56},{-10,-90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realT_evaIn.y, t_Ev_in.u) annotation (Line(
      points={{-73,36},{-69.2,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realT_conOut.y, t_Co_out.u) annotation (Line(
      points={{-73,16},{-69.2,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realCoP_corr.y, productPelCoP1.u2) annotation (Line(
      points={{-11,-40},{-2,-40},{-2,-42},{6,-42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(t_Ev_in.y,Qdot_ConTable. u2) annotation (Line(
      points={{-55.4,36},{-50,36},{-50,24},{-42,24}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(t_Ev_in.y, P_eleTable.u2) annotation (Line(
      points={{-55.4,36},{-50,36},{-50,-6},{-42,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(t_Co_out.y,Qdot_ConTable. u1) annotation (Line(
      points={{-55.4,16},{-48,16},{-48,36},{-42,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(t_Co_out.y, P_eleTable.u1) annotation (Line(
      points={{-55.4,16},{-48,16},{-48,6},{-42,6}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(greaterZero.y, realP_eleAdd.u) annotation (Line(
      points={{-79.6,-50},{-78,-50},{-78,-48},{-76,-48},{-76,-50},{-72.8,-50}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(realPel.y, greaterZero.u) annotation (Line(
      points={{-71,-30},{-66,-30},{-66,-40},{-92,-40},{-92,-50},{-88.8,-50}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(realP_eleAdd.y, add.u2) annotation (Line(
      points={{-63.6,-50},{-57,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realPel.y, add.u1) annotation (Line(
      points={{-71,-30},{-66,-30},{-66,-40},{-62,-40},{-62,-44},{-57,-44}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(t_conIn.u,T_conIn)  annotation (Line(
      points={{117.2,-30},{130,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realQdot_eva.y,Qdot_evaOut)  annotation (Line(
      points={{-121,-10},{-130,-10},{-130,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, P_eleOut) annotation (Line(
      points={{-45.5,-47},{-40,-47},{-40,-66},{-50,-66},{-50,-90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(productPelCoP2.y, Qdot_conOut) annotation (Line(
      points={{101,40},{112,40},{112,10},{130,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realQdot_con.y, productPelCoP2.u2) annotation (Line(
      points={{61,34},{78,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PIDmaxHeatFlowCon.u_s, maxTempCon.y) annotation (Line(
      points={{44,62},{35,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PIDmaxHeatFlowCon.u_m, T_conOut) annotation (Line(
      points={{56,50},{4,50},{4,80},{114,80},{114,50},{130,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PIDmaxHeatFlowCon.y, productPelCoP2.u1) annotation (Line(
      points={{67,62},{70,62},{70,46},{78,46}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,-100},
            {150,100}})),           Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-150,-100},{150,100}}), graphics={
        Rectangle(
          extent={{-130,90},{130,-90}},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Text(
          extent={{-80,2},{80,-40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="%name
"),     Ellipse(extent={{-80,80},{80,-80}}, lineColor={0,0,0})}),
             Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Heat pump refrigerant circuit black box model, no controllers included. It is used within the HeatPump model and delivers the basic functionality of the heat pump. The HeatPump model only adds the external heat exchangers and according connectors. </p>
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
</ul>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Works as on/off-controlled heat pump or heat pump with capacity control. The type of capacity and electrical power calculation can be chosen: </p>
<ol>
<li>Polynom 
<br/>a) depending on evaporator input temperature, condenser output temperature and variable speed (via conditional speed connector) for capacity controlled heat pumps 
<br/>b) depending on evaporator input temperature, condenser output temperature and nominal speed for on/off-controlled heat pump </li>
<li>Table data according for on/off-controlled heat pump, depending on evaporator input temperature, condenser output temperature </li>
</ol>
<p>The heat pump speed is helt between the boundaries N_min and N_max even if the input speed is higher or lower. But no further controlling is implemented! The control logic is conciously not integrated into this model! </p>
<p>The calculation of the capacity and electric power does not represent any dynamic behavior of the refrigerant cycle as it occurs in real heat pumps. Therefore two possibilities exist, to add dynamic behavior: </p>
<ol>
<li>The condenser and evaporator can be parametized with a certain external fluid volume to represent their thermal inertia in the tab Evaporator/Condenser</li>
<li>A first order element can be added to the calculation in the tab Advanced if the check box PT1_cycle is enabled (see: <i>Correction models)</i> </li>
</ol>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Sources:</p>
<ul>
<li>Pahud, D. and Lachal, B.: <i>Mesure des performances thermiques d?une pompe &agrave; chaleur coupl&eacute;e sur des sondes g&eacute;othermiques &agrave; Lugano (TI)</i>. Office f&eacute;d&eacute;ral de l&apos;energie, Bern, Switzerland. 2004. </li>
<li>Wetter, M. and Afjei, T.: <i>TRNSYS TYPE 401 - Kompressionsw&auml;rmepumpe inklusiv Frost- und Taktverluste</i>. Zentralschweizerisches Technikum Luzern - Ingenieruschule HTL, Switzerland. 1996. </li>
</ul>
</html>",
      revisions="<html>
<ul>
<li><i>March 27, 2013</i> by Kristian Huchtemann:<br/>Added maximum condenser temperature implementation.</li>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
<li><i>April 23, 2013&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul>
</html>"));
end CycleHP;
