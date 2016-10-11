within AixLib.Fluid.HeatGenerators;
model CHP
  extends AixLib.Fluid.HeatGenerators.BaseClasses.PartialHeatGenerator(vol(V=
          param.vol[1]), preDro(a=1e10));

  parameter AixLib.DataBase.CHP.CHPBaseDataDefinition
                                    param= AixLib.DataBase.CHP.CHP_FMB_31_GSK()
    annotation (choicesAllMatching=true,Dialog(group="Unit properties"));

  parameter Real capacity_min = 30 "Minimum allowable working capacity in %"
    annotation(Dialog(group="Unit properties"));
  parameter Boolean electricityDriven = false
    "If the CHP is controlled by electricity demand (external table required)"
    annotation(Dialog(group="Control system"),Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
  parameter Boolean Tset_in = true
    "Input temperature setpoint from outside (Otherwise max temp in database)"
    annotation(Dialog(group="Control system"),Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
  parameter Boolean ctrlStrategy = true
    "True for flow-, false for return- temperature control strategy"
    annotation(Dialog(group="Control system"));
  parameter Real deltaT_min = 10
    "Minimum flow and return temperature difference"
    annotation(Dialog(group="Control system"));
  parameter Real Tflow_range = 2 "Range of allowable flow temperature"
    annotation(Dialog(group="Control system"));
  parameter Modelica.SIunits.Time delayTime = 3600 "Shutdown/Startup delay"
    annotation(Dialog(group="Control system"));
  parameter Real K_c = 1 "Gain of the controller"
    annotation(Dialog(group="Control system"));
  parameter Modelica.SIunits.Time T_c=60 "Time Constant (T>0 required)"
    annotation(Dialog(group="Control system"));
  parameter Modelica.SIunits.Time delayUnit = 60
    "Delay measurement of the controller output"
    annotation(Dialog(group="Control system"));

  BaseClasses.Controllers.delayedOnOffController delayedOnOffController(
    Treturn_max=param.maxRTemp,
    deltaT_min=deltaT_min,
    Tflow_range=Tflow_range,
    delayTime=delayTime,
    delayUnit=delayUnit,
    capacity_min=capacity_min)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  BaseClasses.Controllers.PIcontroller th_control(
    K_c=K_c,
    T_c=T_c,
    capacity_min=capacity_min)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Math.Min min
    annotation (Placement(transformation(extent={{20,40},{30,60}},
                           rotation=0)));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
    tableName="NoName",
    fileName="NoName",
    table=param.data_CHP)
    annotation (Placement(transformation(extent={{40,40},{60,60}}, rotation=0)));
  Modelica.Blocks.Continuous.LimPID el_control(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=100,
    yMin=0,
    Ti=T_c,
    k=K_c,
    y_start=0)
    annotation (Placement(transformation(extent={{-10,60},{10,80}},
        rotation=0)));
  Modelica.Blocks.Sources.Constant setpoint_const(k=if ctrlStrategy then (
        param.maxVTemp) else (param.maxRTemp))
    annotation (Placement(transformation(extent={{-86,74},{-74,86}},  rotation=
          0)));
  Modelica.Blocks.Sources.Constant const(k=capacity_min + 10)
    annotation (Placement(transformation(extent={{-80,-6},{-68,6}},  rotation=
         0)));
  Modelica.Blocks.Logical.Switch ctrlSwitch
    "Changes the measured temperature source"
    annotation (Placement(transformation(
      origin={0,0},
      extent={{-10,10},{10,-10}},
      rotation=90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=ctrlStrategy)
    annotation (Placement(transformation(extent={{-26,-54},{-14,-42}},
                                                                     rotation=
         0)));
  Modelica.Blocks.Interfaces.RealInput Tset if          Tset_in
    "Temperature setpoint [°C]" annotation (Placement(transformation(extent={{-126,76},
            {-100,104}},         rotation=0), iconTransformation(extent={{-80,-70},
            {-60,-50}})));
  Modelica.Blocks.Interfaces.RealInput elset if           electricityDriven
    "Electrical power setpoint" annotation (Placement(transformation(extent={{-126,56},
            {-100,84}},     rotation=0), iconTransformation(extent={{-80,50},{-60,
            70}})));
public
  Modelica.Blocks.Interfaces.RealOutput elPower annotation (Placement(
        transformation(
        origin={30,90},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,90})));
  Modelica.Blocks.Interfaces.BooleanInput ON "False for shut down" annotation (
     Placement(transformation(extent={{-128,26},{-100,54}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-90})));
  Modelica.Blocks.Math.Gain gain(k=1000)
    annotation (Placement(transformation(extent={{60,-36},{48,-24}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-50,68},{50,28}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString="CHP",
          textStyle={TextStyle.Bold})}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false)));

equation
  if electricityDriven then
    connect(elset, el_control.u_s);
  else
    el_control.u_s = 1e9;
  end if;
  if Tset_in then
    connect(Tset, delayedOnOffController.FlowTemp_setpoint);
    connect(Tset, th_control.setpoint);
  else
    connect(setpoint_const.y, delayedOnOffController.FlowTemp_setpoint);
    connect(setpoint_const.y, th_control.setpoint);
  end if;


  connect(senTCold.T, ctrlSwitch.u3) annotation (Line(points={{-70,-69},{-70,-36},
          {-8,-36},{-8,-12}}, color={0,0,127}));
  connect(senTHot.T, ctrlSwitch.u1) annotation (Line(points={{40,-69},{40,-69},
          {40,-36},{40,-34},{8,-34},{8,-12}}, color={0,0,127}));
  connect(booleanConstant.y, ctrlSwitch.u2) annotation (Line(points={{-13.4,-48},
          {0,-48},{0,-12}}, color={255,0,255}));
  connect(delayedOnOffController.ReturnTemp, ctrlSwitch.u3) annotation (Line(
        points={{-34,-12},{-34,-36},{-8,-36},{-8,-12}}, color={0,0,127}));
  connect(delayedOnOffController.FlowTemp, ctrlSwitch.u1) annotation (Line(
        points={{-46,6},{-52,6},{-52,-34},{8,-34},{8,-12}}, color={0,0,127}));
  connect(const.y, delayedOnOffController.minCapacity_in)
    annotation (Line(points={{-67.4,0},{-67.4,0},{-46,0}}, color={0,0,127}));
  connect(ctrlSwitch.y, th_control.measurement)
    annotation (Line(points={{0,11},{0,11},{0,18}}, color={0,0,127}));
  connect(delayedOnOffController.y, th_control.ON) annotation (Line(points={{-23,
          0},{-20,0},{-20,24},{-12,24}}, color={255,0,255}));
  connect(el_control.y, min.u1) annotation (Line(points={{11,70},{14,70},{14,56},
          {19,56}}, color={0,0,127}));
  connect(th_control.y, min.u2) annotation (Line(points={{11,30},{14,30},{14,44},
          {19,44}}, color={0,0,127}));
  connect(min.y, combiTable1Ds.u)
    annotation (Line(points={{30.5,50},{34,50},{38,50}}, color={0,0,127}));
  connect(min.y, delayedOnOffController.ControllerOutput) annotation (Line(
        points={{30.5,50},{34,50},{34,-32},{-50,-32},{-50,-6},{-46,-6}}, color=
         {0,0,127}));
  connect(combiTable1Ds.y[1], elPower) annotation (Line(points={{61,50},{70,50},
          {70,68},{30,68},{30,90}}, color={0,0,127}));
  connect(el_control.u_m, elPower) annotation (Line(points={{0,58},{0,50},{12,50},
          {12,68},{30,68},{30,90}}, color={0,0,127}));
  connect(delayedOnOffController.externalOnOff, ON) annotation (Line(points={{-28,
          12},{-28,40},{-114,40}}, color={255,0,255}));
  connect(combiTable1Ds.y[2], gain.u) annotation (Line(points={{61,50},{70,50},
          {70,-30},{61.2,-30}}, color={0,0,127}));
  connect(gain.y, heater.Q_flow) annotation (Line(points={{47.4,-30},{48,-30},{
          46,-30},{-60,-30},{-60,-40}}, color={0,0,127}));
end CHP;
