within AixLib.Systems.ModularAHU.Controller;
block CtrBasic "controller for mixed cooling circuit "
  //Boolean choice;

  parameter Modelica.SIunits.Temperature TflowSet = 289.15 "Flow temperature set point of consumer";
  parameter Real k(min=0, unit="1") = 0.025 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=Modelica.Constants.small)=130
    "Time constant of Integrator block";
  parameter Modelica.SIunits.Time Td(min=0)= 4 "Time constant of Derivative block";
  parameter Modelica.SIunits.Temperature T_amb = 293.15 "ambient temperature";
  parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the Pump";
  parameter Modelica.Blocks.Types.InitPID initType=.Modelica.Blocks.Types.InitPID.DoNotUse_InitialIntegratorState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation(Dialog(group="PID"));
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation(Dialog(group="PID"));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation(Dialog(group="PID"));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(group="PID"));
  Controls.Continuous.LimPID        PID(
    yMax=1,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=k,
    Ti=Ti,
    Td=Td,
    initType=initType,
    xi_start=xi_start,
    xd_start=xd_start,
    y_start=y_start,
    reverseAction=reverseAction)
            annotation (Placement(transformation(extent={{-16,-60},{4,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(
                                                        y=rpm_pump)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Blocks.Interfaces.RealInput Tset "Input signal connector"
    annotation (Placement(transformation(extent={{-122,-40},{-82,0}})));
  BaseClasses.registerBus registerBus annotation (Placement(transformation(
          extent={{74,-26},{128,26}}), iconTransformation(extent={{68,-14},{96,
            14}})));
  parameter Boolean reverseAction=false
    "Set to true for throttling the water flow rate through a cooling coil controller";
equation
  connect(realExpression1.y, registerBus.hydraulicBus.pumpBus.rpm_Input)
    annotation (Line(points={{11,0},{52,0},{52,0.13},{101.135,0.13}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PID.y, registerBus.hydraulicBus.valSet) annotation (Line(points={{5,
          -50},{101.135,-50},{101.135,0.13}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PID.u_s, Tset) annotation (Line(points={{-18,-50},{-56,-50},{-56,-20},
          {-102,-20}}, color={0,0,127}));
  connect(PID.u_m, registerBus.Tair_out) annotation (Line(points={{-6,-62},{-6,
          -88},{101.135,-88},{101.135,0.13}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="HCMI"),
          Rectangle(
          extent={{-90,80},{70,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{10,80},{70,0},{30,-80}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-90,20},{56,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Admix")}),Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(revisions="<html>
<ul>
<li>October 25, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>Simple controller for admix circuit.</p>
</html>"));
end CtrBasic;
