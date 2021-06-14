within AixLib.Systems.HydraulicModules.Controller;
block CtrMixVflowConstValve
  "Controller for mixed and injection circuits"
  //Boolean choice;



  parameter Real constValveSet(min=0,max=1, unit="1") = 1 "Set Point Valve";

    parameter Real k_pump(min=0, unit="1") = 1000 "Gain of controller";
  parameter Modelica.SIunits.Time Ti_pump(min=Modelica.Constants.small)=60
    "Time constant of Integrator block";
  parameter Modelica.SIunits.Time Td_pump(min=0)= 4 "Time constant of Derivative block";
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm rpm_pump(min=0) = 2000 "Rpm of the Pump";
  parameter Modelica.Blocks.Types.InitPID initType=.Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Dialog(group="PID"));
      parameter Boolean reverseActionPump = false
    "Set to true for throttling the water flow rate through a cooling coil controller";
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(group="PID"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation(Dialog(group="PID"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(group="PID"));


  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{40,64},{60,84}})));
  Controls.Continuous.LimPID PID1(
    final yMax=rpm_pump,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PID,
    final k=k_pump,
    final Ti=Ti_pump,
    final Td=Td_pump,
    final initType=initType,
    final xi_start=xi_start,
    final xd_start=xd_start,
    final y_start=y_start,
    reverseActing=not (reverseActionPump))
    annotation (Placement(transformation(extent={{-44,38},{-24,58}})));
  Modelica.Blocks.Math.Gain cubicmeters2kgpersec(k=1000)
    annotation (Placement(transformation(extent={{14,-6},{2,6}})));
  Modelica.Blocks.Interfaces.RealInput Mflowset
    "Connector of setpoint input signal" annotation (Placement(transformation(
          extent={{-140,38},{-100,78}}), iconTransformation(extent={{-140,38},{-100,
            78}})));
  Modelica.Blocks.Sources.Constant const(k=constValveSet)
    annotation (Placement(transformation(extent={{-44,-60},{-24,-40}})));
equation

public
  BaseClasses.HydraulicBus  hydraulicBus
    annotation (Placement(transformation(extent={{76,-24},{124,24}}),
        iconTransformation(extent={{90,-22},{138,26}})));
equation

  connect(booleanConstant.y, hydraulicBus.pumpBus.onSet) annotation (Line(
        points={{61,74},{100.12,74},{100.12,0.12}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID1.y, hydraulicBus.pumpBus.rpmSet) annotation (Line(points={{-23,48},
          {48,48},{48,0.12},{100.12,0.12}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(cubicmeters2kgpersec.y, PID1.u_m) annotation (Line(points={{1.4,0},{-34,
          0},{-34,36}},          color={0,0,127}));
  connect(cubicmeters2kgpersec.u, hydraulicBus.VFlowInMea) annotation (Line(
        points={{15.2,0},{58,0},{58,0.12},{100.12,0.12}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID1.u_s, Mflowset) annotation (Line(points={{-46,48},{-82,48},{-82,58},
          {-120,58}}, color={0,0,127}));
  connect(hydraulicBus.valveSet, const.y) annotation (Line(
      points={{100.12,0.12},{100.12,-50},{-23,-50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{-100,100},{-36,-2},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,20},{98,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(revisions="<html>
<ul>
<li>January 22, 2019, by Alexander K&uuml;mpel:<br/>External T_set added.</li>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>Simple controller for admix and injection circuit. The controlled variable is the outflow temperature T_fwrd_out and controlled by a PID controller. The pump is always on and has a constant frequency.</p>
</html>"));
end CtrMixVflowConstValve;
