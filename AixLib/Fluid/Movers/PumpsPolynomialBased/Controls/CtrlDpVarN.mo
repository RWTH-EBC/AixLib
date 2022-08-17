within AixLib.Fluid.Movers.PumpsPolynomialBased.Controls;
model CtrlDpVarN "'dp variable' for PumpSpeedControlled"
  extends BaseClasses.PumpController;

  parameter Modelica.Units.NonSI.AngularVelocity_rpm Nstart=pumpParam.nMin + (
      pumpParam.nMax - pumpParam.nMin)*0.8 "pump speed at start of simulation";
  parameter Real Qnom(
    quantity="VolumeFlowRate",
    unit="m3/h",
    displayUnit="m3/h") = 0.5*max(pumpParam.maxMinSpeedCurves[:,1])  "Nominal volume flow rate in m³/h";
  parameter Modelica.Units.SI.Height Hnom=
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cHQN,
      Qnom,
      Nstart) "Nominal pump head in m (water)";
  parameter Modelica.Units.SI.Height H0=0.5*Hnom "pump head when Q == 0 m3/h";

  parameter Real k(unit="1") = 10 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 5
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time Td(min=0) = 0.001
    "Time constant of Derivative block";

  Modelica.Blocks.Continuous.LimPID PID(
    k=k,
    Ti=Ti,
    Td=Td,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=Nstart,
    yMax=pumpParam.nMax,
    yMin=pumpParam.nMin,
    controllerType=controllerTypePID)
    annotation (Placement(transformation(extent={{-6,-24},{14,-4}})));
  Modelica.Blocks.Sources.RealExpression headControl(y=(Hnom - H0)/Qnom*Q.y +
        H0)    "The given pump head according to controll strategy"
    annotation (Placement(transformation(extent={{-80,-24},{-44,-4}})));
protected
  Modelica.Blocks.Routing.RealPassThrough powerPassThrough annotation (
      Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=0,
        origin={-81,-53})));
  Modelica.Blocks.Routing.RealPassThrough efficiencyPassThrough annotation (
      Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=0,
        origin={-81,-71})));
  Modelica.Blocks.Routing.RealPassThrough Q
    "Dummy for volume flow rate signal." annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=270,
        origin={-53,-31})));
public
  parameter Modelica.Blocks.Types.SimpleController controllerTypePID=.Modelica.Blocks.Types.SimpleController.PID
    "Type of controller";
  Modelica.StateGraph.InitialStep Standby(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-56,48},{-36,68}})));
  Modelica.StateGraph.StepWithSignal ActiveState(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{0,48},{20,68}})));
  Modelica.StateGraph.TransitionWithSignal pumpOn(enableTimer=false, waitTime=1)
    "fires when on"
    annotation (Placement(transformation(extent={{-30,48},{-10,68}})));
  Modelica.StateGraph.TransitionWithSignal noDemand(waitTime=60, enableTimer=
        false)
    annotation (Placement(transformation(extent={{24,48},{44,68}})));
  Modelica.Blocks.Logical.Switch pumpSpeedSwitch "If false: rpm_Input = 0"
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Blocks.Sources.Constant zeroSpeed(k=0)
    annotation (Placement(transformation(extent={{38,-44},{50,-32}})));
  Modelica.Blocks.Logical.Not notOn annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={34,32})));
  Modelica.Blocks.Routing.RealPassThrough nActPassThrough
    "pass through of pump speed signal"
    annotation (Placement(transformation(extent={{-74,-42},{-88,-28}})));
  Modelica.Blocks.Routing.BooleanPassThrough onOffPassThrough1
    annotation (Placement(transformation(extent={{-88,-96},{-74,-82}})));
equation
  connect(pumpBus.PelMea, powerPassThrough.u) annotation (Line(
      points={{0.1,-99.9},{-62,-99.9},{-62,-53},{-72.6,-53}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-5,3},{-5,3}}));
  connect(powerPassThrough.y, pumpControllerBus.PelMea) annotation (Line(points=
         {{-88.7,-53},{-98,-53},{-98,100.1},{0.1,100.1}}, color={0,0,127}));
  connect(pumpBus.efficiencyMea, efficiencyPassThrough.u) annotation (Line(
      points={{0.1,-99.9},{-62,-99.9},{-62,-71},{-72.6,-71}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,3},{-3,3}}));
  connect(efficiencyPassThrough.y, pumpControllerBus.efficiencyMea) annotation (
     Line(points={{-88.7,-71},{-98,-71},{-98,100.1},{0.1,100.1}}, color={0,0,
          127}));
  connect(PID.y, pumpSpeedSwitch.u1) annotation (Line(points={{15,-14},{38,-14},
          {38,-22},{58,-22}}, color={0,0,127}));
  connect(pumpBus.vFRcur_m3h, Q.u) annotation (Line(
      points={{0,-100},{-2,-100},{-2,-76},{-53,-76},{-53,-39.4}},
      color={255,204,51},
      thickness=0.5));
  connect(pumpBus.dpMea, PID.u_m) annotation (Line(
      points={{0.1,-99.9},{4,-99.9},{4,-26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(headControl.y, PID.u_s)
    annotation (Line(points={{-42.2,-14},{-8,-14}}, color={0,0,127}));
  connect(Standby.outPort[1],pumpOn. inPort)
    annotation (Line(points={{-35.5,58},{-24,58}}, color={0,0,0}));
  connect(ActiveState.outPort[1],noDemand. inPort)
    annotation (Line(points={{20.5,58},{25.25,58},{30,58}}, color={0,0,0}));
  connect(ActiveState.active,pumpSpeedSwitch. u2) annotation (Line(points={{10,47},
          {10,8},{52,8},{52,-30},{58,-30}}, color={255,0,255}));
  connect(notOn.y,noDemand. condition)
    annotation (Line(points={{34,36.4},{34,36.4},{34,46}}, color={255,0,255}));
  connect(pumpOn.condition, pumpControllerBus.onSet) annotation (Line(points={{
          -20,46},{-98,46},{-98,100.1},{0.1,100.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpSpeedSwitch.y, pumpBus.rpmSet) annotation (Line(points={{81,-30},
          {86,-30},{86,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(zeroSpeed.y,pumpSpeedSwitch. u3)
    annotation (Line(points={{50.6,-38},{58,-38}}, color={0,0,127}));
  connect(pumpOn.condition,notOn. u) annotation (Line(points={{-20,46},{-20,22},
          {34,22},{34,27.2}}, color={255,0,255}));
  connect(pumpOn.outPort,ActiveState. inPort[1])
    annotation (Line(points={{-18.5,58},{-1,58}}, color={0,0,0}));
  connect(noDemand.outPort,Standby. inPort[1]) annotation (Line(points={{35.5,58},
          {50,58},{50,80},{-66,80},{-66,58},{-57,58}}, color={0,0,0}));
  connect(pumpBus.rpmMea, nActPassThrough.u) annotation (Line(
      points={{0.1,-99.9},{-62,-99.9},{-62,-35},{-72.6,-35}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,3},{-3,3}}));
  connect(nActPassThrough.y, pumpControllerBus.rpmMea) annotation (Line(points=
          {{-88.7,-35},{-98,-35},{-98,100.1},{0.1,100.1}}, color={0,0,127}));
  connect(pumpControllerBus.onSet, onOffPassThrough1.u) annotation (Line(
      points={{0.1,100.1},{-98,100.1},{-98,-89},{-89.4,-89}},
      color={255,204,51},
      thickness=0.5));
  connect(onOffPassThrough1.y, pumpBus.onSet) annotation (Line(points={{-73.3,-89},
          {-62,-89},{-62,-100},{0.1,-99.9}}, color={255,0,255}));
  annotation (
    Dialog(group="Heating curves"),
    choicesAllMatching=true,
    Documentation(info="<html><p>
  This controller implements the conventional variable dp control
  strategy. The pump's operating points fall on an ascending line with
  the point p0(Q0, H0) and p1(Qnom, Hnom) where Q0 and H0 are volume
  flow rate and pump head at zero mass flow. Hence p0 = (0, H0). p1 is
  the pump's design point. Normally, H0 = 0.5 * Hnom.
</p>
<ul>
  <li>2019-09-18 by Alexander Kümpel:<br/>
    Renaming and bug fixes.
  </li>
  <li>2018-03-01 by Peter Matthes:<br/>
    Simplified doc string to \"'dp variable' for PumpN\".
  </li>
  <li>2018-02-05 by Peter Matthes:<br/>
    Adds pass through for rpm_Act signal. Some controllers need the
    current speed signal for anti-windup.
  </li>
  <li>2018-01-26 by Peter Matthes:<br/>
    * Changes parameter name n_start into Nstart to be
    compatible/exchangeable with the speed controlled (red pump) and
    the head controlled pump (blue pump).<br/>
    * Changes icon to reflect relationship with red pump (speed
    control).
  </li>
  <li>2018-01-10 by Peter Matthes:<br/>
    Adds state graph controller parts as taken from the BaseClass. Not
    all controllers need the state graph why we decided to remove it
    from the BaseClass.
  </li>
  <li>2017-12-05 by Peter Matthes:<br/>
    Initial implementation.
  </li>
</ul>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-80,50},{76,-8}},
          lineColor={0,0,0},
          fillColor={254,178,76},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{-70,38},{64,8}},
          lineColor={240,59,32},
          fillColor={0,216,108},
          fillPattern=FillPattern.Solid,
          textString="dp_var")}));
end CtrlDpVarN;
