within AixLib.Fluid.Movers.PumpsPolynomialBased.Controls;
model CtrlDpVarH "'dp variable' for PumpHeadControlled"
  extends BaseClasses.PumpController;

  parameter Modelica.Units.NonSI.AngularVelocity_rpm Nstart=pumpParam.nMin + (
      pumpParam.nMax - pumpParam.nMin)*0.8 "pump speed at start of simulation";
  parameter Real Qnom(
    quantity="VolumeFlowRate",
    unit="m3/h",
    displayUnit="m3/h") = 0.5*max(pumpParam.maxMinSpeedCurves[:,1]) "Nominal volume flow rate in m³/h";
  parameter Modelica.Units.SI.Height Hnom=
      AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.polynomial2D(
      pumpParam.cHQN,
      Qnom,
      Nstart) "Nominal pump head in m (water)";
  parameter Modelica.Units.SI.Height H0=0.5*Hnom "pump head when Q == 0 m3/h";

  parameter Real k(unit="1") = 50 "Gain of controller";
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small) = 0.01
    "Time constant of Integrator block";
  parameter Modelica.Units.SI.Time Td(min=0) = 0.001
    "Time constant of Derivative block";

  Modelica.Blocks.Sources.RealExpression headControl(y=(Hnom - H0)/Qnom*Q.y +
        H0)    "The given pump head according to controll strategy"
    annotation (Placement(transformation(extent={{-40,-22},{-4,-2}})));
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
        origin={-13,-29})));
public
  parameter Modelica.Blocks.Types.SimpleController controllerTypePID=.Modelica.Blocks.Types.SimpleController.PID
    "Type of controller";
  Modelica.Blocks.Routing.BooleanPassThrough onOffPassThrough1
    annotation (Placement(transformation(extent={{-88,-96},{-74,-82}})));
equation
  connect(pumpBus.PelMea, powerPassThrough.u) annotation (Line(
      points={{0.1,-99.9},{-62,-99.9},{-62,-53},{-72.6,-53}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(powerPassThrough.y, pumpControllerBus.PelMea) annotation (Line(points=
         {{-88.7,-53},{-98,-53},{-98,100.1},{0.1,100.1}}, color={0,0,127}));
  connect(pumpBus.efficiencyMea, efficiencyPassThrough.u) annotation (Line(
      points={{0.1,-99.9},{-62,-99.9},{-62,-71},{-72.6,-71}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(efficiencyPassThrough.y, pumpControllerBus.efficiencyMea) annotation (
     Line(points={{-88.7,-71},{-98,-71},{-98,100.1},{0.1,100.1}}, color={0,0,
          127}));
  connect(pumpBus.vFRcur_m3h, Q.u) annotation (Line(
      points={{0,-100},{-2,-100},{-2,-76},{-13,-76},{-13,-37.4}},
      color={255,204,51},
      thickness=0.5));
  connect(headControl.y, pumpBus.dpSet) annotation (Line(points={{-2.2,-12},{12,
          -12},{12,-76},{0.1,-76},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
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
    Simplified doc string to \"'dp variable' for PumpH\".
  </li>
  <li>2018-01-26 by Peter Matthes:<br/>
    * Changes parameter name n_start into Nstart to be
    compatible/exchangeable with the speed controlled (red pump) and
    the head controlled pump (blue pump).<br/>
    * Changes icon color to blue to reflect relationship with blue pump
    (pressure head control).<br/>
    * Removes PID-controller as this new model should set pump pressure
    directly. The dp_var algorithm will also allow dp_const when
    H0=Hnom.
  </li>
  <li>2018-01-10 by Peter Matthes:<br/>
    Adds state graph controller parts as taken from the BaseClass. Not
    all controllers need the state graph why we decided to remove it
    from the BaseClass.
  </li>
  <li>2017-12-05 by Peter Matthes:<br/>
    Changes calculation of Qnom (taken from pump dataset) and Hnom (now
    uses full cHQN matrix. cABCeq has been removed.) Removes pumpParam
    from the model as that is now defined in the base class
    PumpStateController.
  </li>
  <li>2017-11-22 by Peter Matthes:<br/>
    Initial implementation.
  </li>
</ul>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-80,50},{76,-8}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{-70,38},{64,8}},
          lineColor={28,108,200},
          fillColor={0,216,108},
          fillPattern=FillPattern.Solid,
          textString="dp_var")}));
end CtrlDpVarH;
