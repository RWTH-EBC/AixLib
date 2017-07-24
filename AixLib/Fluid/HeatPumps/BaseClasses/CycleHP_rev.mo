within AixLib.Fluid.HeatPumps.BaseClasses;
model CycleHP_rev "cycle for reversible heat pump"
  import SI = Modelica.SIunits;
  parameter AixLib.Controls.Types.OperationMode_HP operationMode = AixLib.Controls.Types.OperationMode_HP.heatPump "Operation mode of the machine" annotation(Dialog(group = "Control Mode"));
  parameter AixLib.Controls.Types.ControlMode_HP controlMode = AixLib.Controls.Types.ControlMode_HP.onOff "Control mode of the machine" annotation(Dialog(group = "Control Mode"));

  // heat pump data
  parameter
    AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition_new
    HeatPumpData=AixLib.DataBase.HeatPump.Galetti_HeatPump_MFE005MH()
    "HeatPump data, make sure you have the correct tables (on/off) or polynoms (speed control)"
    annotation (choicesAllMatching=true, Dialog(group="Control Mode", enable=(operationMode == "heat pump" or operationMode == "reversible")));
  // chiller data
  parameter
    AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition_new
    ChillerData = AixLib.DataBase.HeatPump.Galetti_Chiller_MFE005M()
    "Chiller data, make sure you have the correct tables (on/off) or polynoms (speed control)"
    annotation (choicesAllMatching=true, Dialog(group="Control Mode", enable=(operationMode == "chiller" or operationMode == "reversible")));

    replaceable function Corr_icing =
      AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.noModel
                                                                 constrainedby
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.DefrostCorrection.baseFct
    "Frost/Defrost model (only air-to-water heat pumps)" annotation (
      choicesAllMatching=true, Dialog(
      enable=(controlMode == "speed control"),
      group="Defrosting/Icing correction",
      tab="Advanced"));

  parameter Boolean PT1_cycle=false "First Order model for capacity" annotation(Dialog(group = "Start/stop behavior",tab="Advanced"));
  parameter SI.Time T_hp_cycle=1 "Time constant for first order model" annotation(Dialog(group = "Start/stop behavior",tab="Advanced", enable=PT1_cycle));
  /*parameter Boolean Pel_trapezoid=false "rising and falling of elctric power" annotation(Dialog(group = "Start/stop behavior",tab="Advanced"), choices(checkBox=true));
  parameter SI.Time rising=0 "start-up of electric power"   annotation(Dialog(group = "Start/stop behavior",tab="Advanced", enable=Pel_trapezoid));
  parameter SI.Time falling=0 "shut-off of electric power"   annotation(Dialog(group = "Start/stop behavior",tab="Advanced", enable=Pel_trapezoid));*/
  parameter Real eta_el=1
    "assumption of P_tech/P_el (for calculation of Evaporator load)"                         annotation(Dialog(group="Assumptions",tab="Advanced"));
  parameter Real factor_scale=1
    "scaling factor (Attention: not physically correct)"
     annotation(Dialog(group="Assumptions",tab="Advanced"));
  parameter SI.Power Pel_add=0
    "additional electric power when heat pump is on (not influenced through scaling factor)"
     annotation(Dialog(group="Assumptions",tab="Advanced"));

  parameter Boolean CorrFlowUse = false
    "Correction of mass flow different from nominal flow in use part"
    annotation(Dialog(group="Mass flow correction",tab="Advanced"));

  parameter SI.MassFlowRate mFlowUseNom=0.5
    "Nominal mass flow rate use medium"
  annotation(Dialog(group="Mass flow correction",tab="Advanced", enable=(CorrFlowUse and (controlMode == "speed control"))));

 // parameter SI.TemperatureDifference deltaT_Co_nominal=5 "Nominal temperature spread in condenser"
 // annotation(Dialog(group="Mass flow correction",tab="Advanced", enable=(CorrFlowUse and (controlMode == "speed control"))));

  parameter Boolean CorrFlowSource=false
    "Correction of mass flow different from nominal flow in source part"
    annotation(Dialog(group="Mass flow correction",tab="Advanced"));

  parameter SI.MassFlowRate mFlowSourceNom=0.5
    "Nominal mass flow rate source medium"
  annotation(Dialog(group="Mass flow correction",tab="Advanced",enable=(CorrFlowSource and (controlMode == "speed control"))));

  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "smoothness of table interpolation" annotation(Dialog(group = "Assumptions",tab="Advanced", enable=not
                                                                                          ((controlMode == "speed control"))));

protected
  final parameter Real table_QflowUse_HP[:,:]=HeatPumpData.table_QflowUse;
  final parameter Real table_Pel_HP[:,:]= HeatPumpData.table_Pel;
  final parameter Real table_QflowUse_C[:,:]=ChillerData.table_QflowUse;
  final parameter Real table_Pel_C[:,:]= ChillerData.table_Pel;


 // parameter SI.TemperatureDifference deltaT_Ev_nominal=5 "Nominal temperature spread in evaporator"
 // annotation(Dialog(group="Mass flow correction",tab="Advanced", enable=(CorrFlowSource and (controlMode == "speed control"))));

  SI.ThermodynamicTemperature Tuse;
  SI.ThermodynamicTemperature Tuse_in;
  SI.ThermodynamicTemperature Tsource;
  SI.ThermodynamicTemperature Tsource_out;
  SI.Power Pel;
  SI.Power Pel_char;
  SI.HeatFlowRate QflowSource;
  SI.HeatFlowRate QflowUse;
  SI.HeatFlowRate QflowUse_char;
  SI.MassFlowRate mflowUse;
  SI.MassFlowRate mflowSource;
  Real CoP;
  Real CoP_corr;
  Real CoP_char;
  Real f_cop_icing;
  //Real f_cop_spread;
  Real Char[2];
  SI.ThermodynamicTemperature Tuse_corr;
  SI.ThermodynamicTemperature Tsource_corr;
  Real Nmax;
  Real Nmin;

protected
  SI.ThermodynamicTemperature TuseLimit "limit for Tuse, when Pel = PelMax";
  Modelica.Blocks.Interfaces.RealInput firstOrder_out_internal
    "Needed to connect to conditional model";
  Modelica.Blocks.Interfaces.RealOutput firstOrder_in_internal
    "Needed to connect to conditional model";
  Modelica.Blocks.Interfaces.RealInput delay_out_internal
    "Needed to connect to conditional model";
  Modelica.Blocks.Interfaces.RealOutput delay_in_internal
    "Needed to connect to conditional model";
  Modelica.Blocks.Interfaces.RealInput QflowUse_table_internal
    "Needed to connect to conditional model";
  Modelica.Blocks.Interfaces.RealInput Pel_table_internal
    "Needed to connect to conditional model";
  /*Modelica.Blocks.Interfaces.RealInput Pel_trapezoid_internal 
    "Needed to connect to conditional model";*/
  SI.MassFlowRate mflowUse_nom;
  SI.MassFlowRate mflowSource_nom;

  Modelica.Blocks.Interfaces.RealOutput output_Pel annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-90}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={140,-62})));
  Modelica.Blocks.Interfaces.BooleanInput isOn "if true, pump is on"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,90})));
  Modelica.Blocks.Interfaces.RealOutput output_CoP annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-90}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={140,-38})));
  Modelica.Blocks.Interfaces.RealInput N(unit="rpm")
    "rotational speed in [rpm]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,90})));


public
  Modelica.Blocks.Sources.RealExpression real_QflowUse(y=QflowUse) annotation (
      Placement(transformation(extent={{40,24},{60,44}}, rotation=0)));
public
  Modelica.Blocks.Sources.RealExpression real_QflowSource(y=QflowSource)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,6})));
public
  Modelica.Blocks.Sources.RealExpression real_Pel(y=Pel)
    annotation (Placement(transformation(extent={{-92,-40},{-72,-20}},
          rotation=0)));
public
  Modelica.Blocks.Sources.RealExpression real_CoP(y=CoP)
    annotation (Placement(transformation(extent={{-32,-66},{-12,-46}},
          rotation=0)));

  Modelica.Blocks.Tables.CombiTable2D Table_QflowUse_HP(
    tableName="NoName",
    fileName="NoName",
    smoothness=smoothness,
    table=table_QflowUse_HP) if
                            not ((controlMode == AixLib.Controls.Types.ControlMode_HP.onOff.speedControl))
    "look up table for Qflow use for heat pump mode" annotation (extent=[-60,40;
        -40,60], Placement(transformation(extent={{-58,48},{-38,68}})));

  Modelica.Blocks.Tables.CombiTable2D Table_Pel_HP(
    tableName="NoName",
    fileName="NoName",
    smoothness=smoothness,
    table=table_Pel_HP) if
                        not ((controlMode == AixLib.Controls.Types.ControlMode_HP.onOff.speedControl))
    "look up table for electrical power in heat pump mode" annotation (extent=[-60,
        -20; -40,0], Placement(transformation(extent={{-60,20},{-40,40}})));
public
  Modelica.Blocks.Sources.RealExpression real_T_source(y=Tsource_corr)
    annotation (Placement(transformation(extent={{-96,50},{-76,70}}, rotation=0)));
public
  Modelica.Blocks.Sources.RealExpression real_T_use(y=Tuse_corr)  annotation (
      Placement(transformation(extent={{-96,20},{-76,40}}, rotation=0)));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=T_hp_cycle) if PT1_cycle
    annotation (Placement(transformation(extent={{42,-6},{62,14}})));
public
  Modelica.Blocks.Math.Product product_Pel_CoP
    annotation (Placement(transformation(extent={{8,-46},{28,-26}},
          rotation=0)));
public
  Modelica.Blocks.Sources.RealExpression dummy_zero(y=0)            annotation (Placement(transformation(extent={{40,-86},
            {60,-66}},
          rotation=0)));
public
  Modelica.Blocks.Sources.RealExpression real_CoP_corr(y=CoP_corr)
    annotation (Placement(transformation(extent={{-32,-50},{-12,-30}},
          rotation=0)));

public
  Modelica.Blocks.Logical.TriggeredTrapezoid real_Pel_add(amplitude=Pel_add)
    annotation (Placement(transformation(extent={{-72,-54},{-64,-46}},
          rotation=0)));
public
  Modelica.Blocks.Logical.GreaterThreshold real_Pel_add1
    annotation (Placement(transformation(extent={{-88,-54},{-80,-46}},
          rotation=0)));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-56,-52},{-46,-42}})));

/*  Modelica.Blocks.Logical.TriggeredTrapezoid trapezoid(
    amplitude=1,
    rising=rising,
    falling=falling,
    offset=0) if Pel_trapezoid annotation (Placement(transformation(extent={{-40,60},{-20,80}})));*/
public
  Modelica.Blocks.Sources.RealExpression dummy_one(y=1)             annotation (Placement(transformation(extent={{40,-70},
            {60,-50}},
          rotation=0)));
  //Modelica.Blocks.Sources.BooleanExpression trapezoid_boolean(y=if
   //     Pel_trapezoid then OnOff_in else false)                     annotation (Placement(transformation(extent={{-122,
   //         -64},{-102,-44}},
   //       rotation=0)));
public
  Modelica.Blocks.Interfaces.RealOutput Q_flow_Co "heat flow in condesner"
    annotation (Placement(transformation(extent={{130,38},{150,58}}),
        iconTransformation(extent={{130,38},{150,58}})));
  Modelica.Blocks.Interfaces.RealInput T_Co_in(unit="K")
    "Entry temperature in condenser [K]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={146,-30}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-48})));
  Modelica.Blocks.Interfaces.RealInput T_Ev_in(unit="K")
    "Entry temperature in evaporator[K]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,74}), iconTransformation(extent={{-150,80},{-130,100}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_Ev "heat flow from evaporator"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-130,10}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={140,20})));
  Modelica.Blocks.Interfaces.RealInput T_Co_out(unit="K")
    "Exit temperature in condenser [K]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={148,-48}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-72})));
  Modelica.Blocks.Interfaces.RealInput T_Ev_out(unit="K")
    "Exit temperature from evaporator [K]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,52}), iconTransformation(extent={{-150,56},{-130,76}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_Ev(unit="kg/s")
    "mass flow in evaporator [kg/s]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-130,30}), iconTransformation(extent={{-150,30},{-130,50}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_Co(unit="kg/s")
    "mass flow in condenser [kg/s]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={146,-10}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-24})));
public
  Modelica.Blocks.Sources.RealExpression real_TuseLimit(y=TuseLimit)
    "limit for Tuse at maximum Pel" annotation (Placement(transformation(extent=
           {{14,52},{34,72}}, rotation=0)));
public
  Modelica.Blocks.Math.Product product_QflowUse_max annotation (Placement(
        transformation(extent={{104,30},{124,50}},rotation=0)));
  Modelica.Blocks.Continuous.LimPID PID_max_QflowUse_HP(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1,
    yMax=1,
    yMin=0,
    y_start=1) annotation (Placement(transformation(extent={{46,56},{66,76}})));

  Modelica.Blocks.Tables.CombiTable2D Table_QflowUse_C(
    tableName="NoName",
    fileName="NoName",
    smoothness=smoothness,
    table=table_QflowUse_C) if
                            not ((controlMode == AixLib.Controls.Types.ControlMode_HP.onOff.speedControl))
    "look up table for Qflow use for chiller mode" annotation (extent=[-60,40; -40,
        60], Placement(transformation(extent={{-26,48},{-6,68}})));
  Modelica.Blocks.Tables.CombiTable2D Table_Pel_C(
    tableName="NoName",
    fileName="NoName",
    smoothness=smoothness,
    table=table_Pel_C) if
                        not ((controlMode == AixLib.Controls.Types.ControlMode_HP.onOff.speedControl))
    "look up table for electrical power in chiller mode" annotation (extent=[-60,
        -20; -40,0], Placement(transformation(extent={{-26,20},{-6,40}})));
  Modelica.Blocks.Interfaces.BooleanInput isHP
    "if true then heat pump, else chiller" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={22,90})));
public
  Modelica.Blocks.Sources.RealExpression real_TuseIs(y=Tuse) "current Tuse"
    annotation (Placement(transformation(extent={{14,36},{34,56}}, rotation=0)));
  Modelica.Blocks.Continuous.LimPID PID_max_QflowUse_C(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1,
    yMax=1,
    yMin=0,
    y_start=1) annotation (Placement(transformation(extent={{78,52},{98,72}})));
equation

  // Decide on Source and Use inputs and outputs
  if isHP then         // heat pump mode
    Tuse =T_Co_out;
    Tuse_in =T_Co_in;
    Tsource =T_Ev_in;
    Tsource_out =T_Ev_out;
    Q_flow_Co = QflowUse;
    Q_flow_Ev = (-1)*QflowSource;
    mflowUse =m_flow_Co;
    mflowSource=m_flow_Ev;
    TuseLimit = HeatPumpData.TuseMax;
    Table_QflowUse_HP.u1 =real_T_use.y;
    Table_QflowUse_HP.u2 =real_T_source.y;
    Table_Pel_HP.u1 =real_T_use.y;
    Table_Pel_HP.u2 =real_T_source.y;
    Table_QflowUse_C.u1 = 0;
    Table_QflowUse_C.u2 = 0;
    Table_Pel_C.u1 = 0;
    Table_Pel_C.u2 = 0;
    product_QflowUse_max.u1 = PID_max_QflowUse_HP.y;
  else // chiller mode
    Tuse =T_Ev_out;
    Tuse_in =T_Ev_in;
    Tsource =T_Co_in;
    Tsource_out =T_Co_out;
    Q_flow_Co = QflowSource;
    Q_flow_Ev = (-1)*QflowUse;
    mflowUse =m_flow_Ev;
    mflowSource=m_flow_Co;
    TuseLimit = HeatPumpData.TuseMin;
    Table_QflowUse_C.u1 =real_T_use.y;
    Table_QflowUse_C.u2 =real_T_source.y;
    Table_Pel_C.u1 =real_T_use.y;
    Table_Pel_C.u2 =real_T_source.y;
    Table_QflowUse_HP.u1 = 0;
    Table_QflowUse_HP.u2 = 0;
    Table_Pel_HP.u1 = 0;
    Table_Pel_HP.u2 = 0;
    product_QflowUse_max.u1 = PID_max_QflowUse_C.y;
  end if;

    Nmax=HeatPumpData.Nmax;
    Nmin=HeatPumpData.Nmin;

  // correction of temperatures used in the table/polynomial
    mflowUse_nom= HeatPumpData.mFlowUseNom;
    mflowSource_nom= HeatPumpData.mFlowSourceNom;


  if CorrFlowUse then
    Tuse_corr=1/2*(mflowUse/mflowUse_nom*(Tuse - Tuse_in) +
     Tuse_in + Tuse);
  else
    Tuse_corr=Tuse;
  end if;

//  output_Tuse_mean =Tuse_corr;

  if CorrFlowSource then
    Tsource_corr=1/2*(mflowSource/mflowSource_nom*(Tsource - Tsource_out) +
      (Tsource + Tsource_out));
  else
    Tsource_corr=Tsource;
  end if;

//  output_Tsource_mean = Tsource_corr;

  // determination of speed N
  if (controlMode == AixLib.Controls.Types.ControlMode_HP.onOff) then
    N=HeatPumpDataT.Nnom;
  else // capacity control mode
    if N > Nmax then
      N=Nmax;
    else
      if N < Nmin then
        N=Nmin;
      else
        N=N;
      end if;
    end if;
  end if;
  output_N =N;

  //determination of basic heat pump characteristics QflowUse_char and Pel_char and CoP_char
  if (controlMode == AixLib.Controls.Types.ControlMode_HP.onOff) then // cycle data as table
    Char = {Pel_table_internal,QflowUse_table_internal};
  else // cycle data as polynom
    Char=AutomationLibrary.DataBaseX.HeatPumps.baseFct_withAlgorithmSI(N,Tuse_corr, Tsource_corr,HeatPumpDataP.Pel_fTuseTsourceN,HeatPumpDataP.QflowUse_fTuseTsourceN);
  end if;

  if isOn then
    QflowUse_char=Char[2];
    Pel_char=Char[1];
    CoP_char=QflowUse_char/max(Pel_char, 1e-3);
  else
    QflowUse_char=0;
    Pel_char=0;
    CoP_char=0;
  end if;

  // determination of CoP-corrections
  if (controlMode == AixLib.Controls.Types.ControlMode_HP.onOff.speedControl) then
    f_cop_icing=Corr_icing(Tsource_corr-273.15);
  else
    f_cop_icing=1;
  end if;
  //f_cop_spread=Corr_spreadCo(t_Co_in.y,t_Co_out.y,Cap_calc_type==2);
  CoP_corr=CoP_char*f_cop_icing;//*f_cop_spread;

  //calculation of heat pump characteristics
    Pel=Pel_char*factor_scale;
    QflowUse=firstOrder_out_internal;
  if isOn then
    if QflowUse-Pel*eta_el>0 then
      QflowSource=(QflowUse-Pel*eta_el);
    else
      QflowSource=0;
    end if;
    CoP=QflowUse/max((Pel+real_Pel_add.y), 1e-3);
  else
    QflowSource=0;
    CoP=0;
  end if;

  //internal connections for conditional models
  connect(product_Pel_CoP.y,delay_in_internal);
  if (delay_QflowUse == false) then
    connect(delay_in_internal,delay_out_internal);
  end if;
  connect(delay_out_internal,firstOrder_in_internal);
  if PT1_cycle then
    connect(firstOrder_in_internal,firstOrder.u);
    connect(firstOrder.y,firstOrder_out_internal);
  else
     connect(firstOrder_in_internal,firstOrder_out_internal);

  end if;

   if (controlMode == AixLib.Controls.Types.ControlMode_HP.onOff.speedControl) then // cycle data as polynom
     connect(QflowUse_table_internal,dummy_zero.y);
     connect(Pel_table_internal,dummy_zero.y);
   else
    if isHP then
      QflowUse_table_internal = Table_QflowUse_HP.y;
      Pel_table_internal = Table_Pel_HP.y;
     else
      QflowUse_table_internal = Table_QflowUse_C.y;
      Pel_table_internal = Table_Pel_C.y;
     end if;
   end if;

  connect(real_Pel.y, product_Pel_CoP.u1) annotation (Line(
      points={{-71,-30},{6,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(real_CoP.y, output_CoP) annotation (Line(
      points={{-11,-56},{-10,-56},{-10,-90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(real_CoP_corr.y, product_Pel_CoP.u2) annotation (Line(
      points={{-11,-40},{-2,-40},{-2,-42},{6,-42}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(real_Pel_add1.y, real_Pel_add.u) annotation (Line(
      points={{-79.6,-50},{-78,-50},{-78,-48},{-76,-48},{-76,-50},{-72.8,-50}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(real_Pel.y, real_Pel_add1.u) annotation (Line(
      points={{-71,-30},{-66,-30},{-66,-40},{-92,-40},{-92,-50},{-88.8,-50}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(real_Pel_add.y, add.u2) annotation (Line(
      points={{-63.6,-50},{-57,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(real_Pel.y, add.u1) annotation (Line(
      points={{-71,-30},{-66,-30},{-66,-40},{-62,-40},{-62,-44},{-57,-44}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(add.y, output_Pel) annotation (Line(
      points={{-45.5,-47},{-40,-47},{-40,-66},{-50,-66},{-50,-90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(real_QflowUse.y, product_QflowUse_max.u2) annotation (Line(
      points={{61,34},{102,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PID_max_QflowUse_HP.u_s, real_TuseLimit.y) annotation (Line(
      points={{44,66},{40,66},{40,62},{35,62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(real_TuseIs.y, PID_max_QflowUse_HP.u_m) annotation (Line(points={{35,46},
          {35,46},{56,46},{56,54}}, color={0,0,127}));
  connect(real_TuseLimit.y, PID_max_QflowUse_C.u_s)
    annotation (Line(points={{35,62},{76,62}}, color={0,0,127}));
  connect(real_TuseIs.y, PID_max_QflowUse_C.u_m)
    annotation (Line(points={{35,46},{88,46},{88,50}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-150,
            -100},{150,100}})),     Icon(coordinateSystem(preserveAspectRatio=true,
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
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Heat pump refrigerant circuit black box model with two simple heat exchangers, no controllers included. It is used within the HeatPump model and delivers the basic functionality of the heat pump. The HeatPump model only adds the external heat exchangers and according connectors.</p>
<h4><span style=\"color: #008000\">Assumptions</span></h4>
<p>Correction models of the calculation can be activated that effect the efficiency or the start-up and shut-off behavior of the heat pump. </p>
<ol>
<li>Icing and Defrosting: Simple model that use the evaporator inlet temperature and calculates a factor for CoP correction (according to Wetter and Afjei, 1996). Not enabled for table data, as usually already included (data according EN255 and EN14511). </li>
<li>Mass flow in condenser/evaporator: Model according to Pahud and Lachal, 2004, that corrects the temperatures used within table and polynomial. </li>
<li>First order behavior of heat pump capacity: Start-up and shut-off of heat pump can be modeled with a first order behavior. </li>
<li>Electric efficiency: The electric efficiency of the electric drive is implemented to calculate the evaporator heat flow </li>
<li>Scaling factor: A scaling facor is implemented for scaling of the heat pump power and capacity without effecting the heat pump efficiency which is not physically correct but may be helpful for rough calculation. </li>
<li>Additional electric power: This is a constant value that is added to the power consumption. This may be helpful if e.g. an electric drive operates together with the compressor and shall be included in overall electric power and CoP calculation. </li>
<li>The smoothness of table interpolation can be chosen. </li>
<li>Allowed sink temperature: A maximum condenser outlet temperature limits the condenser heat flow through a PID controller. </li>
</ol>
<h4><span style=\"color: #008000\">Known Limitations</span></h4>
<ul>
<li>Allowed source temperature: No limits for source temperature is implemented. Though, usually this is not a problem if the heat pump is properly integrated into a system model. </li>
</ul>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p>Works as on/off-controlled heat pump or heat pump with capacity control. The type of capacity and electrical power calculation can be chosen: </p>
<ol>
<li>Polynom <br>a) depending on evaporator input temperature, condenser output temperature and variable speed (via conditional speed connector) for capacity controlled heat pumps <br>b) depending on evaporator input temperature, condenser output temperature and nominal speed for on/off-controlled heat pump </li>
<li>Table data according for on/off-controlled heat pump, depending on evaporator input temperature, condenser output temperature </li>
</ol>
<p>The heat pump speed is helt between the boundaries N_min and N_max even if the input speed is higher or lower. But no further controlling is implemented! The control logic is conciously not integrated into this model! </p>
<p>The calculation of the capacity and electric power does not represent any dynamic behavior of the refrigerant cycle as it occurs in real heat pumps. Therefore two possibilities exist, to add dynamic behavior: </p>
<ol>
<li>The condenser and evaporator can be parametized with a certain external fluid volume to represent their thermal inertia in the tab Evaporator/Condenser</li>
<li>A first order element can be added to the calculation in the tab Advanced if the check box PT1_cycle is enabled (see: <i>Correction models)</i> </li>
</ol>
<h4><span style=\"color: #008000\">References</span></h4>
<ul>
<li>Pahud, D. and Lachal, B.: <i>Mesure des performances thermiques d?une pompe &agrave; chaleur coupl&eacute;e sur des sondes g&eacute;othermiques &agrave; Lugano (TI)</i>. Office f&eacute;d&eacute;ral de l&apos;energie, Bern, Switzerland. 2004. </li>
<li>Wetter, M. and Afjei, T.: <i>TRNSYS TYPE 401 - Kompressionsw&auml;rmepumpe inklusiv Frost- und Taktverluste</i>. Zentralschweizerisches Technikum Luzern - Ingenieruschule HTL, Switzerland. 1996. </li>
</ul>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 27, 2013</i> by Kristian Huchtemann:<br/>Added maximum condenser temperature implementation.</li>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately </li>
<li><i>April 23, 2013&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul></p>
</html>"));
end CycleHP_rev;
