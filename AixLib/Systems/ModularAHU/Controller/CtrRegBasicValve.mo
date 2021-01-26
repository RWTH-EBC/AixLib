within AixLib.Systems.ModularAHU.Controller;
block CtrRegBasicValve "Controller for heating and cooling registers"
  //Boolean choice;

  parameter Boolean useExternalVset = false "If True, set temperature can be given externally";
  parameter Boolean useExternalVMea = false "If True, measured temperature can be given externally";
  parameter Modelica.SIunits.Temperature VflowSet = 293.15 "Flow temperature set point of consumer" annotation (Dialog(enable=
          useExternalVset == false));
  parameter Real k(min=0, unit="1") = 1500 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=60
    "Time constant of Integrator block";
  parameter Modelica.SIunits.Time Td(min=0)= 4 "Time constant of Derivative block";
  parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the Pump";
  parameter Modelica.Blocks.Types.InitPID initType=.Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Dialog(group="PID"));
  parameter Boolean reverseAction = false
    "Set to true for throttling the water flow rate through a cooling coil controller";
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(group="PID"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation(Dialog(group="PID"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(group="PID"));
  Modelica.Blocks.Interfaces.RealInput valveSet if
                                               useExternalVset
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Sources.Constant constRpmPump(final k=rpm_pump) annotation (Placement(transformation(extent={{-14,-18},
            {6,2}})));

  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{24,20},{44,40}})));
  BaseClasses.RegisterBus registerBus annotation (Placement(transformation(
          extent={{74,-26},{128,26}}), iconTransformation(extent={{88,-14},{116,
            14}})));
equation

  if useExternalVMea==false then
  end if;
  connect(booleanConstant.y, registerBus.hydraulicBus.pumpBus.onSet)
    annotation (Line(points={{45,30},{101.135,30},{101.135,0.13}}, color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(constRpmPump.y, registerBus.hydraulicBus.pumpBus.rpmSet) annotation (
      Line(points={{7,-8},{68,-8},{68,0.13},{101.135,0.13}},color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(registerBus.hydraulicBus.valveSet, valveSet) annotation (Line(
      points={{101.135,0.13},{-20,0.13},{-20,0},{-120,0}},
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
          points={{20,100},{100,0},{20,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(revisions="<html>
<ul>
<li>August 1, 2019, by Alexander K&uuml;mpel:<br/>Improvement.</li>
<li>October 18, 2018, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>Simple controller for heating and cooling registers. The controlled variable is the air outflow temperature T_air_out. The pump (if existing in hydraulic circuit) operates at constant frequency and is always on.</p>
</html>"));
end CtrRegBasicValve;
