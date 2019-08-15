within AixLib.Utilities.HeatTransfer;
model Cell3D "3 Dimensional Heat Tranfer"

  parameter Modelica.SIunits.Height y=1;
  parameter Modelica.SIunits.Thickness x=1;
  parameter Modelica.SIunits.Length z=1;
  parameter Modelica.SIunits.ThermalConductivity lambda=2.4;
  parameter Modelica.SIunits.Density rho=1600;
  parameter Modelica.SIunits.SpecificHeatCapacity c=1000;
  parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(16)
    "initial temperature";
  Real qFront;
  Real qLeft;
  Real qBack;
  Real qRight;
  Real qBottom;
  Real qTop;
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCond1(G=(x*y)
        *(lambda)/(z/2)) annotation (Placement(transformation(
        origin={0,50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCond2(G=(y*z)
        *(lambda)/(x/2)) annotation (Placement(transformation(extent={{48,-8},
            {68,12}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCond3(G=(x*y)
        *(lambda)/(z/2)) annotation (Placement(transformation(
        origin={2,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCond4(G=(y*z)
        *(lambda)/(x/2)) annotation (Placement(transformation(
        origin={-48,-2},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ThermTop
                                              annotation (Placement(
        transformation(extent={{-12,82},{10,102}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermLeft
                                              annotation (Placement(
        transformation(extent={{-102,-10},{-82,10}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ThermRight
                                              annotation (Placement(
        transformation(extent={{82,-10},{102,10}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermBottom
                                              annotation (Placement(
        transformation(extent={{-10,-102},{10,-82}}, rotation=0)));
 // String connection;
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Load1(C=(c)*(rho)*(x
        *y)*(z), T(start=T0))
                 annotation (Placement(transformation(extent={{-4,-8},{16,12}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b ThermBack
                                              annotation (Placement(
        transformation(extent={{80,82},{102,102}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermFront
                                              annotation (Placement(
        transformation(extent={{-102,-102},{-80,-82}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCond5(G=(x*z)
        *(lambda)/(y/2)) annotation (Placement(transformation(extent={{48,46},
            {68,66}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor HeatCond6(G=(x*z)
        *(lambda)/(y/2)) annotation (Placement(transformation(extent={{-48,-70},
            {-68,-50}}, rotation=0)));
equation
qFront=ThermFront.Q_flow/(x*z);
qLeft=ThermLeft.Q_flow/(y*z);
qBack=ThermBack.Q_flow/(x*z);
qRight=ThermRight.Q_flow/(y*z);
qBottom=ThermBottom.Q_flow/(y*x);
qTop=ThermTop.Q_flow/(y*x);
  connect(HeatCond4.port_b, ThermLeft)
                                    annotation (Line(points={{-58,-2},{-60,0},
          {-92,0}},                       color={0,0,0}));
  connect(HeatCond4.port_a, Load1.port)
    annotation (Line(points={{-38,-2},{-28,-8},{6,-8}},color={0,0,0}));
  connect(HeatCond1.port_b, ThermTop)
                                    annotation (Line(points={{6.66134e-016,60},
          {6.66134e-016,70},{6.66134e-016,92},{-1,92}},
                           color={0,0,0}));
  connect(HeatCond1.port_a, Load1.port)
    annotation (Line(points={{-6.66134e-016,40},{-6.66134e-016,30},{6,30},{6,
          -8}},                                             color={0,0,0}));
  connect(HeatCond5.port_b, ThermBack)
                                    annotation (Line(points={{68,56},{76,56},
          {76,92},{91,92}}, color={0,0,0}));
  connect(Load1.port, HeatCond5.port_a) annotation (Line(points={{6,-8},{6,-8},
          {6,20},{38,20},{38,56},{48,56}},  color={0,0,0}));
  connect(HeatCond2.port_b, ThermRight)
    annotation (Line(points={{68,2},{75,2},{75,0},{92,0}}, color={0,0,0}));
  connect(HeatCond2.port_a, Load1.port) annotation (Line(points={{48,2},{28,2},
          {28,-14},{6,-14},{6,-8}},  color={0,0,0}));
  connect(HeatCond3.port_b, ThermBottom)
                                    annotation (Line(points={{2,-60},{0,-70},
          {0,-92}},              color={0,0,0}));
  connect(HeatCond3.port_a, Load1.port) annotation (Line(points={{2,-40},{2,
          -26},{-12,-26},{-12,-8},{6,-8}},
                                     color={0,0,0}));
  connect(HeatCond6.port_b, ThermFront)
                                    annotation (Line(points={{-68,-60},{-84,
          -60},{-84,-92},{-91,-92}}, color={0,0,0}));
  connect(HeatCond6.port_a, Load1.port) annotation (Line(points={{-48,-60},{
          -24,-60},{-24,-8},{6,-8}},
                                color={0,0,0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}),
            graphics),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-74,26},{26,-74}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-74,26},{-24,74},{74,74},{74,-24},{26,-74},{26,26},{-74,
              26}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(points={{26,26},{74,74}}, color={0,0,0}),
        Rectangle(
          extent={{-54,8},{8,-54}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Polygon(
          points={{-42,38},{16,38},{42,64},{-16,64},{-42,38}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Polygon(
          points={{38,20},{38,-44},{64,-18},{64,46},{38,20}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Text(
          extent={{-100,80},{100,40}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={193,236,255},
          textString="%name")}),
    DymolaStoredErrors,
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The <b>Cell3D</b> model represents a wall element consisting of one layer. There are 6 <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort\">HeatPort</a></b> Connector to connect several Cells for simulation of 3-dimensional heat transfer through a wall and heat storage within a wall.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"BaseLib.Examples.HeatTransfer3D_test\">BaseLib.Examples.HeatTransfer3D_test </a></p>
</html>",
      revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 01, 2014 </i> by Moritz Lauster:<br>Moved and Renamed</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted appropriately</li>
<li><i>In September 2009&nbsp;</i> by Kristian Huchtemann:<br>Changed notation of components and connectors to allow an easier assignment and connection. </li>
<li>by Alexander Hoh:<br>Implemented. </li>
</ul>
</html>"));
end Cell3D;
