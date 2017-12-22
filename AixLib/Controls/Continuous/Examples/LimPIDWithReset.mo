within AixLib.Controls.Continuous.Examples;

model LimPIDWithReset

  "Example that demonstrates the controller output reset"

  extends Modelica.Icons.Example;



  Plant plaWitRes "Plant connected to controller with reset" annotation (

      Placement(transformation(extent={{20,40},{40,60}})));

  Controller conWitRes(reset=AixLib.Types.Reset.Parameter)

    "Controller with reset" annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

  Plant plaNoRes "Plant connected to controller without reset" annotation (

      Placement(transformation(extent={{20,-20},{40,0}})));

  Controller conNoRes(reset=AixLib.Types.Reset.Disabled)

    "Controller without reset" annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));

  Modelica.Blocks.Sources.Pulse TSet(

    amplitude=20,

    width=50,

    offset=293.15,

    y(unit="K"),

    period=180)    "Temperature set point"

    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));



protected

  model Plant

    "Plant model"

    extends Modelica.Blocks.Icons.Block;



    Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W")

      "Heat flow rate added to system"

      annotation (Placement(

          transformation(extent={{-120,-10},{-100,10}})));

    Modelica.Blocks.Interfaces.RealOutput T(unit="K")

      "Controlled temperature"

      annotation (Placement(

          transformation(extent={{100,-10},{120,10}})));



    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(

      C=10,

      T(fixed=true,

        start=293.15)) "Heat capacitor"

      annotation (Placement(transformation(extent={{-38,0},{-18,20}})));

    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap1(

      C=10,

      T(fixed=true,

          start=293.15)) "Heat capacitor"

      annotation (Placement(transformation(extent={{20,0},{40,20}})));



    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temSen

      "Temperature sensor"

      annotation (Placement(transformation(extent={{50,-10},{70,10}})));

    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea

      "Prescribed heat flow rate"

      annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));

    Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G=5)

      "Thermal conductor"

      annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TBou(T=293.15)

      "Boundary condition"

      annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));

    Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon1(G=1)

      "Thermal conductor"

      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));



  equation

    connect(Q_flow, preHea.Q_flow)

      annotation (Line(points={{-110,0},{-78,0}},         color={0,0,127}));

    connect(T, temSen.T)

      annotation (Line(points={{110,0},{70,0}},        color={0,0,127}));

    connect(TBou.port, theCon.port_a)

      annotation (Line(points={{-60,-40},{-60,-40},{-50,-40}}, color={191,0,0}));

    connect(cap.port, theCon1.port_a)

      annotation (Line(points={{-28,0},{-28,0},{-10,0}},

                                               color={191,0,0}));

    connect(theCon1.port_b, cap1.port)

      annotation (Line(points={{10,0},{30,0}}, color={191,0,0}));

    connect(cap1.port, temSen.port)

      annotation (Line(points={{30,0},{30,0},{50,0}}, color={191,0,0}));

    connect(theCon.port_b, cap.port)

      annotation (Line(points={{-30,-40},{-30,-40},{-20,-40},{-20,0},{-28,0}},

                                                          color={191,0,0}));

    connect(preHea.port, cap.port)

      annotation (Line(points={{-58,0},{-28,0}}, color={191,0,0}));

    annotation (Documentation(info="<html>
<p>
  Plant model for <a href=\"modelica://AixLib.Controls.Continuous.Examples.LimPIDWithReset\">AixLib.Controls.Continuous.Examples.LimPIDWithReset</a>. consisting of a simple heat transfer model.
</p>
<h4>
  Implementation
</h4>
<p>
  To compare the effect of the controller output reset, the plant and control models have been implemented in separate blocks so they can be instantiated twice in the system model with the appropriate control settings.
</p></html>",revisions="<html>
<ul>
  <li>October 3, 2016, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul></html>",revisions="<html>
<p>
  Controller model for <a href=\"modelica://AixLib.Controls.Continuous.Examples.LimPIDWithReset\">AixLib.Controls.Continuous.Examples.LimPIDWithReset</a>.
</p>
<p>
  The controller is reset whenever the input signal becomes bigger than <i>30</i>°C.
</p>
<h4>
  Implementation
</h4>
<p>
  To compare the effect of the controller output reset, the plant and control models have been implemented in separate blocks so they can be instantiated twice in the system model with the appropriate control settings.
</p>
<ul>
  <li>October 10, 2016, by Michael Wetter:<br/>
    Added full path in the type declaration.<br/>
    This is for <a href=\"https://github.com/iea-annex60/modelica-annex60/issues/540\">issue 540</a>.
  </li>
  <li>October 3, 2016, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>
<p>
  Example that demonstrates the effect of the integrator reset. The top model has the reset of the controller output enabled. By plotting the controller error, one sees that the integrator reset improves the closed loop performance slightly. Note, however, that both controllers have an integrator anti-windup and hence the integrator reset has limited benefits.
</p>
<ul>
  <li>September 29, 2016, by Michael Wetter:<br/>
    First implementation.
  </li>
</ul>

</html>"));

end LimPIDWithReset;

