within AixLib.Fluid.HeatGenerators;
model CHP
  extends AixLib.Fluid.HeatGenerators.BaseClasses.PartialHeatGenerator(
      pressureDrop(             a=1e10),                               vol(V=param.Vol[
          1]));

  parameter AixLib.DataBase.CHP.CHPBaseDataDefinition
                                    param= AixLib.DataBase.CHP.CHP_FMB_31_GSK()
    annotation (choicesAllMatching=true,Dialog(group="Unit properties"));

  parameter Real MinCapacity = 30 "Minimum allowable working capacity in %"
    annotation(Dialog(group="Unit properties"));
  parameter Boolean ElectricityDriven = false
    "If the CHP is controlled by electricity demand (external table required)"
    annotation(Dialog(group="Control system"),Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
  parameter Boolean TSet_in = true
    "Input temperature setpoint from outside (Otherwise max temp in database)"
    annotation(Dialog(group="Control system"),Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
  parameter Boolean CtrlStrategy = true
    "True for flow-, false for return- temperature control strategy"
    annotation(Dialog(group="Control system"));
  parameter Real MinDeltaT = 10
    "Minimum flow and return temperature difference"
    annotation(Dialog(group="Control system"));
  parameter Real TFlowRange = 2 "Range of allowable flow temperature"
    annotation(Dialog(group="Control system"));
  parameter Modelica.SIunits.Time DelayTime = 3600 "Shutdown/Startup delay"
    annotation(Dialog(group="Control system"));
  parameter Real Kc = 1 "Gain of the controller"
    annotation(Dialog(group="Control system"));
  parameter Modelica.SIunits.Time Tc=60 "Time Constant (T>0 required)"
    annotation(Dialog(group="Control system"));
  parameter Modelica.SIunits.Time DelayUnit = 60
    "Delay measurement of the controller output"
    annotation(Dialog(group="Control system"));

  BaseClasses.Controllers.delayedOnOffController delayedOnOffController(
    MaxTReturn=param.MaxTReturn,
    MinDeltaT=MinDeltaT,
    TFlowRange=TFlowRange,
    DelayTime=DelayTime,
    DelayUnit=DelayUnit,
    MinCapacity=MinCapacity)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  BaseClasses.Controllers.PIController thControl(
    Kc=Kc,
    Tc=Tc,
    MinCapacity=MinCapacity)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Math.Min min
    annotation (Placement(transformation(extent={{20,40},{30,60}},
                           rotation=0)));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(
    tableName="NoName",
    fileName="NoName",
    table=param.data_CHP)
    annotation (Placement(transformation(extent={{40,40},{60,60}}, rotation=0)));
  Modelica.Blocks.Continuous.LimPID elControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=100,
    yMin=0,
    y_start=0,
    k=Kc,
    Ti=Tc)     annotation (Placement(transformation(extent={{-10,60},{10,80}},
          rotation=0)));
  Modelica.Blocks.Sources.Constant constSetpoint(k=if CtrlStrategy then (param.MaxTFlow)
         else (param.MaxTReturn))
                                annotation (Placement(transformation(extent={{-86,
            74},{-74,86}}, rotation=0)));
  Modelica.Blocks.Sources.Constant const(k=MinCapacity + 10)
    annotation (Placement(transformation(extent={{-80,-6},{-68,6}},  rotation=
         0)));
  Modelica.Blocks.Logical.Switch ctrlSwitch
    "Changes the measured temperature source"
    annotation (Placement(transformation(
      origin={0,0},
      extent={{-10,10},{10,-10}},
      rotation=90)));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=CtrlStrategy)
    annotation (Placement(transformation(extent={{-26,-54},{-14,-42}},
                                                                     rotation=
         0)));
  Modelica.Blocks.Math.Gain gain(k=1000)
    annotation (Placement(transformation(extent={{60,-36},{48,-24}})));
  Modelica.Blocks.Sources.Constant ExothermicTemperature(k=1783.4)
    annotation (Placement(transformation(extent={{44,12},{60,28}})));
  Modelica.Blocks.Interfaces.RealInput TSet if          TSet_in
    "Temperature setpoint [�C]" annotation (Placement(transformation(extent={{-126,76},
            {-100,104}},         rotation=0), iconTransformation(extent={{-80,-70},
            {-60,-50}})));
  Modelica.Blocks.Interfaces.RealInput ElSet if           ElectricityDriven
    "Electrical power setpoint" annotation (Placement(transformation(extent={{-126,56},
            {-100,84}},     rotation=0), iconTransformation(extent={{-80,50},{-60,
            70}})));
  Modelica.Blocks.Interfaces.BooleanInput ON "False for shut down" annotation (
     Placement(transformation(extent={{-128,26},{-100,54}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-90})));


  Modelica.Blocks.Interfaces.RealOutput TSource "Combustion temperature"
    annotation (Placement(transformation(extent={{99.5,41.75},{118,60}}),
        iconTransformation(
        extent={{-9.75,-9.75},{9.75,9.75}},
        rotation=-90,
        origin={-29.75,-89.75})));
public
  Modelica.Blocks.Interfaces.RealOutput ElectricalPower annotation (Placement(
        transformation(
        origin={30,90},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,90})));
  Modelica.Blocks.Interfaces.RealOutput ThermalPower annotation (Placement(
        transformation(
        origin={46,90},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,90})));
  Modelica.Blocks.Interfaces.RealOutput FuelInput
    annotation (Placement(transformation(
      origin={61,90},
      extent={{-10,-11},{10,11}},
      rotation=90), iconTransformation(
        extent={{-10,-11},{10,11}},
        rotation=90,
        origin={20,90})));
  Modelica.Blocks.Interfaces.RealOutput FuelConsumption
    annotation (Placement(transformation(
      origin={76,90},
      extent={{-10,-10},{10,10}},
      rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,90})));
equation
  if ElectricityDriven then
    connect(ElSet, elControl.u_s);
  else
    elControl.u_s = 1e9;
  end if;
  if TSet_in then
    connect(TSet, delayedOnOffController.FlowTemp_setpoint);
    connect(TSet,thControl.Setpoint);
  else
    connect(constSetpoint.y, delayedOnOffController.FlowTemp_setpoint);
    connect(constSetpoint.y,thControl.Setpoint);
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
  connect(const.y,delayedOnOffController.MinCapacity_in)
    annotation (Line(points={{-67.4,0},{-67.4,0},{-46,0}}, color={0,0,127}));
  connect(ctrlSwitch.y, thControl.measurement)
    annotation (Line(points={{0,11},{0,11},{0,18}}, color={0,0,127}));
  connect(delayedOnOffController.y, thControl.ON) annotation (Line(points={{-23,
          0},{-20,0},{-20,24},{-12,24}}, color={255,0,255}));
  connect(elControl.y, min.u1) annotation (Line(points={{11,70},{14,70},{14,56},
          {19,56}}, color={0,0,127}));
  connect(thControl.y, min.u2) annotation (Line(points={{11,30},{14,30},{14,44},
          {19,44}}, color={0,0,127}));
  connect(min.y, combiTable1Ds.u)
    annotation (Line(points={{30.5,50},{34,50},{38,50}}, color={0,0,127}));
  connect(min.y, delayedOnOffController.ControllerOutput) annotation (Line(
        points={{30.5,50},{34,50},{34,-32},{-50,-32},{-50,-6},{-46,-6}}, color=
         {0,0,127}));
  connect(combiTable1Ds.y[1], ElectricalPower) annotation (Line(points={{61,50},
          {70,50},{70,68},{30,68},{30,90}}, color={0,0,127}));
  connect(elControl.u_m, ElectricalPower) annotation (Line(points={{0,58},{0,50},
          {12,50},{12,68},{30,68},{30,90}}, color={0,0,127}));
  connect(delayedOnOffController.ExternalON, ON) annotation (Line(points={{-28,
          12},{-28,40},{-114,40}}, color={255,0,255}));
  connect(combiTable1Ds.y[2], gain.u) annotation (Line(points={{61,50},{70,50},
          {70,-30},{61.2,-30}}, color={0,0,127}));
  connect(gain.y, heater.Q_flow) annotation (Line(points={{47.4,-30},{48,-30},{
          46,-30},{-60,-30},{-60,-40}}, color={0,0,127}));

  connect(ExothermicTemperature.y,TSource)  annotation (Line(
      points={{60.8,20},{80,20},{80,50.875},{108.75,50.875}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(combiTable1Ds.y[2], ThermalPower) annotation (Line(points={{61,50},{70,
          50},{70,68},{46,68},{46,90}}, color={0,0,127}));
  connect(combiTable1Ds.y[3],FuelInput)  annotation (Line(points={{61,50},{70,50},
          {70,68},{61,68},{61,90}}, color={0,0,127}));
  connect(combiTable1Ds.y[4],FuelConsumption)  annotation (Line(points={{61,50},{70,50},{70,68},{76,68},{76,90}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-50,58},{50,18}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString="CHP",
          textStyle={TextStyle.Bold}),
        Rectangle(
          extent={{-12,6},{12,-36}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-16},{-10,-36},{-8,-30},{8,-30},{10,-36},{10,-16},{-10,-16}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,-26},{4,-32}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,-54},{-8,-64}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,-30},{-14,-54},{-10,-56},{0,-32},{-2,-30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4.5,-15.5},{-8,-10},{0,4},{6,-4},{10,-4},{8,-8},{8,-12},{5.5,
              -15.5},{-4.5,-15.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-4.5,-13.5},{0,-4},{6,-10},{2,-14},{-4.5,-13.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A table based combined heat and power (CHP) model. Depending on the user choice, this model can be both heat and electricity driven. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>When controlled by heat demand, the CHP is controlled either by flow temperature or by return temperature. When electricity control is activated, an electricity profile needs to be connected to the model. During electricity controlled operation, heat controllers act as emergency systems.</p>
<p>A complete On/Off controller is implemented which takes charge of the timing of each turning on and off command. For example it can be set that between each on and off command, the CHP needs 300 seconds (set in parameter SD_delay) to be able to execute the other command. During this time a PI controller controls the temperature continuously.</p>
<p>Minimum possible capacity can be set to prevent the CHP working in lower capacities. If the timing does not allow a shut down at times lower capacities are required, the CHP works on minimum capacity until the shut down is permitted. This can result in the rise of water temperature higher than setpoint and may in some cases result in temperatures higher than boiling point of water.</p>
<p>The dimension of thermal and electrical power outputs and fuel input as well as the electricity profile should be in kW. The dimmension of fuel consumption depends on the user&apos;s data. </p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>The combustion temperature T_sorce is at the moment set to a ciosntant value of 1748 K. The value is relevant for exergy analysis.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"HVAC.Examples.CHP.CHP_control\">HVAC.Examples.CHP.CHP_control</a></p>
</html>",
revisions="<html>
<ul>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with AixLib</li>
<li><i>January 09, 2006&nbsp;</i> by Peter Matthes:<br/>V0.1: Initial configuration.</li>
<li><i>November 28, 2014&nbsp;</i> by Roozbeh Sangi:<br>Output for source Temperature added.</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately</li>
<li>by Pooyan Jahangiri:<br>First implementation.</li>
</ul>
</html>"));
end CHP;
