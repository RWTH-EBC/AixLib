within AixLib.HVAC;
package HydraulicSeparator
  "This package contains a model for HydraulicSeparator"
extends Modelica.Icons.Package;
  model HydraulicSeparator
    import Modelica.Blocks.Math;
    import AixLib;

      ///////////////////////////////////////////////////////////////////////////
      //Geometric parameters                                                   //
      ///////////////////////////////////////////////////////////////////////////
    parameter Modelica.SIunits.VolumeFlowRate pumpMaxVolumeFlow=0.003
      "Maximum VolumeFlowRate of either primary or secondary Pump";
    parameter Modelica.SIunits.Velocity vmaxExchange=0.2
      "Maximum velocity of the exchange-flow between top and bottom of the Hydraulic Separator";
    parameter Modelica.SIunits.Diameter DFlange "Diameter of the flanges";
    parameter Modelica.SIunits.Diameter D = sqrt(pumpMaxVolumeFlow*4/(Modelica.Constants.pi*vmaxExchange))
      "Diameter of the main-body";

      ///////////////////////////////////////////////////////////////////////////
      //Pipes including main body and flanges                                  //
      ///////////////////////////////////////////////////////////////////////////
    AixLib.HVAC.Pipes.StaticPipe staticPipe(D=DFlange, l=0.05)
      annotation (Placement(transformation(extent={{-32,-66},{-52,-46}})));
    AixLib.HVAC.Pipes.StaticPipe staticPipe2(D=DFlange, l=0.05)
      annotation (Placement(transformation(extent={{-54,42},{-34,62}})));
    AixLib.HVAC.Pipes.StaticPipe staticPipe4(D=D, l=1.5*D) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,26})));
    AixLib.HVAC.Pipes.StaticPipe staticPipe5(D=D, l=1.5*D) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-26})));

    AixLib.HVAC.Pipes.Pipe pipe(D=DFlange, l=0.05)
      annotation (Placement(transformation(extent={{48,-66},{28,-46}})));
    AixLib.HVAC.Pipes.Pipe pipe1(D=DFlange, l=0.05)
      annotation (Placement(transformation(extent={{28,62},{48,42}})));

      ///////////////////////////////////////////////////////////////////////////
      //Measurement of water exchanged between primary and secondary circuit   //
      ///////////////////////////////////////////////////////////////////////////
    AixLib.HVAC.Sensors.MassFlowSensor massFlowSensor annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));

    Modelica.Blocks.Interfaces.RealOutput waterExchange annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,90})));

      ///////////////////////////////////////////////////////////////////////////
      //Ports/ Flanges                                                         //
      ///////////////////////////////////////////////////////////////////////////
    AixLib.HVAC.Interfaces.Port_a port_a_primary
      "Hot port of the primary circuit"
      annotation (Placement(transformation(extent={{-82,42},{-62,62}}),
          iconTransformation(extent={{-82,42},{-62,62}})));
    AixLib.HVAC.Interfaces.Port_a port_a_secondary
      "Cold port of the secondary circuit"
      annotation (Placement(transformation(extent={{62,-66},{82,-46}}),
          iconTransformation(extent={{62,-66},{82,-46}})));
    AixLib.HVAC.Interfaces.Port_b port_b_primary
      "Cold port of the primary circuit"
      annotation (Placement(transformation(extent={{-82,-66},{-62,-46}}),
          iconTransformation(extent={{-82,-66},{-62,-46}})));
    AixLib.HVAC.Interfaces.Port_b port_b_secondary
      "Hot port of the secondary circuit"
      annotation (Placement(transformation(extent={{62,42},{82,62}}),
          iconTransformation(extent={{62,42},{82,62}})));

      ///////////////////////////////////////////////////////////////////////////
      //Thermal Conductor to simulate heat exchange between layers when there  //
      //is no exchange of mass between primary and secondary circuit           //
      ///////////////////////////////////////////////////////////////////////////
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=0.59*(D
          ^2/4*Modelica.Constants.pi)/(3*D))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={38,2})));

  equation
    connect(staticPipe4.port_a, massFlowSensor.port_b) annotation (Line(
        points={{-5.55112e-016,16},{0,16},{0,10},{5.55112e-016,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(massFlowSensor.port_a, staticPipe5.port_b) annotation (Line(
        points={{0,-10},{0,-16}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(massFlowSensor.signal, waterExchange) annotation (Line(
        points={{-10,0},{-16,0},{-16,84},{0,84},{0,90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(port_a_primary, port_a_primary) annotation (Line(
        points={{-72,52},{-72,52}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(thermalConductor.port_b, pipe1.heatport) annotation (Line(
        points={{38,12},{38,47}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(thermalConductor.port_a, pipe.heatport) annotation (Line(
        points={{38,-8},{38,-51}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(port_a_primary, staticPipe2.port_a) annotation (Line(
        points={{-72,52},{-54,52}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe1.port_b, port_b_secondary) annotation (Line(
        points={{48,52},{72,52}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(staticPipe.port_b, port_b_primary) annotation (Line(
        points={{-52,-56},{-72,-56}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe.port_a, port_a_secondary) annotation (Line(
        points={{48,-56},{72,-56}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(staticPipe4.port_b, pipe1.port_a) annotation (Line(
        points={{0,36},{0,52},{28,52}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(staticPipe5.port_a, pipe.port_b) annotation (Line(
        points={{0,-36},{0,-56},{28,-56}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(staticPipe2.port_b, pipe1.port_a) annotation (Line(
        points={{-34,52},{28,52}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(staticPipe.port_a, pipe.port_b) annotation (Line(
        points={{-32,-56},{28,-56}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-34,70},{34,-80}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,255}),
          Polygon(
            points={{-34,70},{-34,-40},{34,20},{34,70},{-34,70}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,60},{-34,40}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{60,60},{34,40}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{60,-40},{34,-60}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-60,-40},{-34,-60}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,60},{-34,60},{-34,70},{34,70},{34,60},{60,60},{60,40},{34,
                40},{34,-40},{60,-40},{60,-60},{34,-60},{34,-80},{-34,-80},{-34,-60},
                {-60,-60},{-60,-40},{-34,-40},{-34,40},{-60,40},{-60,60}},
            lineColor={0,0,0},
            smooth=Smooth.None)}),Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The component Hydraulic Separator is used to hydraulically decouple the heating circuit from the consumer circuit. It is basically a big cylinder with four flanges to mount the primary and secondary circuit. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>There is no pressure-drop inside the water volume because of the weight of the water.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>A Hydraulic Separator should have a diameter that allows a maximum velocity of 0.2 m/s (vmaxExchange)for the water exchanged between the top and bottom layer in order to prevent turbulences. The diameter of the main body is therefore calculated with the help of the maximum VolumeFlowRate in either primary or secondary circuit. This is done by the model itself. The height of the Hydraulic Separator is calculated according to VDMA 24770 also depending on the maximum VolumeFlowRate. The model therefore simulates a Hydraulic Separator which is suitable for the circuit used. The size of the flanges has to be set by the user. </p>
<p><br><b><font style=\"color: #008000; \">References</font></b></p>
<p><a href=\"http://www.google.de/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=0CCkQFjAB&url=http%3A</p>F</p>Fwww.vaillant.pl</p>Fstepone</p>Fdata</p>Fdownloads</p>Fb6</p>F34</p>F00</p>FSprzeglo_hydr_wg_VDMA.pdf&ei=R9lHVJraO4eNywO9yoBo&usg=AFQjCNFSBhKLlP0X4q2TfQZtRlXd_a4F6A&bvm=bv.77880786,d.bGQ\">VDMA Richtlinie 24770</a>%3
<p><a href=\"http://www.sinusverteiler.com/files/ausgleich_von_last_und_leistung_01.pdf\">Catalogue Sinusverteiler (Explanation of design and function)</a> </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.HydraulicSeparator.Examples.HydraulicSeparator\">ExampleHydraulicSeparator</a> </p>
</html>", revisions="<html>
<p>26.11.2014, by <i>Roozbeh Sangi</i>: implemented </p>
</html>"));
  end HydraulicSeparator;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model HydraulicSeparator
      import AixLib;
      extends Modelica.Icons.Example;
      inner AixLib.HVAC.BaseParameters baseParameters
        annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
      AixLib.HVAC.HydraulicSeparator.HydraulicSeparator hydraulicSeparator(DFlange=
            0.01)
        annotation (Placement(transformation(extent={{16,-8},{36,12}})));
      AixLib.HVAC.Pumps.Pump pump(
        V_flow(start=0.002),
        ControlStrategy=2,
        V_flow_max=12,
        Head_max=10)
        annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
      AixLib.HVAC.Sources.Boundary_p boundary_p(p=150000)
                                                annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-88,22})));
      AixLib.HVAC.Pipes.Pipe pipe(D=0.01, l=2)
        annotation (Placement(transformation(extent={{-30,-2},{-10,18}})));
      AixLib.HVAC.Pipes.Pipe pipe1(D=0.01, l=10)
        annotation (Placement(transformation(extent={{30,-46},{10,-66}})));
      AixLib.HVAC.Pipes.StaticPipe staticPipe(D=0.01, l=10)
        annotation (Placement(transformation(extent={{-50,-26},{-70,-6}})));
      AixLib.HVAC.Sensors.MassFlowSensor massFlowSensorPrim
        annotation (Placement(transformation(extent={{-54,-2},{-34,18}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
        Q_flow=1.6e3,
        T_ref=343.15,
        alpha=-0.5)
        annotation (Placement(transformation(extent={{-42,28},{-22,48}})));
      AixLib.HVAC.Pumps.Pump pump1(
        ControlStrategy=2,
        V_flow_max=12,
        Head_max=10)
        annotation (Placement(transformation(extent={{66,0},{86,20}})));
      AixLib.HVAC.Sensors.TemperatureSensor temperatureMixedTop
        annotation (Placement(transformation(extent={{38,0},{58,20}})));
      AixLib.HVAC.Pipes.StaticPipe staticPipe1(D=0.01, l=10)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={92,-26})));
      AixLib.HVAC.Valves.SimpleValve simpleValve
        annotation (Placement(transformation(extent={{70,-74},{50,-54}})));
      AixLib.HVAC.Sensors.MassFlowSensor massFlowSensor1Sec
        annotation (Placement(transformation(extent={{2,-66},{-18,-46}})));
      AixLib.HVAC.Sensors.TemperatureSensor temperatureBottom
        annotation (Placement(transformation(extent={{10,-46},{30,-26}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
          T=baseParameters.T_ambient)
        annotation (Placement(transformation(extent={{-32,-96},{-12,-76}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor
        thermalConductor(G=1.6e3/8)
        annotation (Placement(transformation(extent={{-4,-96},{16,-76}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation (
         Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-70,34})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression1
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={76,36})));
      Modelica.Blocks.Sources.Step step(
        startTime=12000,
        height=0.5,
        offset=0.2)
        annotation (Placement(transformation(extent={{48,-42},{68,-22}})));
      AixLib.HVAC.Sensors.TemperatureSensor temperatureMixedBottom
        annotation (Placement(transformation(extent={{-8,-26},{-28,-6}})));
      AixLib.HVAC.Sensors.TemperatureSensor temperatureTop
        annotation (Placement(transformation(extent={{14,-2},{-6,18}})));
    equation
      connect(boundary_p.port_a, pump.port_a) annotation (Line(
          points={{-88,12},{-88,8},{-80,8}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pump.port_b, massFlowSensorPrim.port_a) annotation (Line(
          points={{-60,8},{-54,8}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe.port_a, massFlowSensorPrim.port_b) annotation (Line(
          points={{-30,8},{-34,8}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(fixedHeatFlow.port, pipe.heatport) annotation (Line(
          points={{-22,38},{-20,38},{-20,13}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(hydraulicSeparator.port_b_secondary, temperatureMixedTop.port_a)
        annotation (Line(
          points={{33.2,7.2},{36,7.2},{36,10},{38,10}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureMixedTop.port_b, pump1.port_a) annotation (Line(
          points={{58,10},{66,10}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pump1.port_b, staticPipe1.port_a) annotation (Line(
          points={{86,10},{92,10},{92,-16}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(staticPipe1.port_b, simpleValve.port_a) annotation (Line(
          points={{92,-36},{92,-64},{70,-64}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(simpleValve.port_b, pipe1.port_a) annotation (Line(
          points={{50,-64},{40,-64},{40,-56},{30,-56}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe1.port_b, massFlowSensor1Sec.port_a) annotation (Line(
          points={{10,-56},{2,-56}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(massFlowSensor1Sec.port_b, temperatureBottom.port_a)
        annotation (Line(
          points={{-18,-56},{-28,-56},{-28,-36},{10,-36}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureBottom.port_b, hydraulicSeparator.port_a_secondary)
        annotation (Line(
          points={{30,-36},{42,-36},{42,-3.6},{33.2,-3.6}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(thermalConductor.port_a, fixedTemperature.port) annotation (
          Line(
          points={{-4,-86},{-12,-86}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(thermalConductor.port_b, pipe1.heatport) annotation (Line(
          points={{16,-86},{20,-86},{20,-61}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(pump1.IsNight, booleanExpression1.y) annotation (Line(
          points={{76,20.2},{76,25}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(pump.IsNight, booleanExpression.y) annotation (Line(
          points={{-70,18.2},{-70,23}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(step.y, simpleValve.opening) annotation (Line(
          points={{69,-32},{76,-32},{76,-56},{60,-56}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(staticPipe.port_a, temperatureMixedBottom.port_b) annotation (
          Line(
          points={{-50,-16},{-28,-16}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureMixedBottom.port_a, hydraulicSeparator.port_b_primary)
        annotation (Line(
          points={{-8,-16},{10,-16},{10,-3.6},{18.8,-3.6}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(staticPipe.port_b, pump.port_a) annotation (Line(
          points={{-70,-16},{-92,-16},{-92,8},{-80,8}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe.port_b, temperatureTop.port_b) annotation (Line(
          points={{-10,8},{-6,8}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureTop.port_a, hydraulicSeparator.port_a_primary)
        annotation (Line(
          points={{14,8},{16,8},{16,7.2},{18.8,7.2}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Documentation(info="<html>
<p>This model shows the usage of a Hydraulic Separator within a simple heating circuit. The primary circuit consists of a tank, a pump, a boiler (represented by a pipe with prescribed heat-flux), a pipe and some sensors. The secondary circuit consists of a pump, a static pipe, a valve and a radiator (represented by a pipe with heat-transfer to the outside). Between the two circuit lies the Hydraulic Separator. The example shows that the model of the Hydraulic Separator works in consistence with ones expactation. There is mixing of the fluids between bottom and top of the Hydraulic Separator depending on the mass flowrates in the circuits. If the mass-flows are the same and no mass is exchanged between top and bottom, there is still a small amount of heat transported via conduction. </p>
</html>",     revisions="<html>
<p>26.11.2014, by <i>Roozbeh Sangi</i>: implemented </p>
</html>"),    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),        graphics),
        experiment(StopTime=20000),
        __Dymola_experimentSetupOutput);
    end HydraulicSeparator;
    annotation (Documentation(info="<html>
<p>This package contains an example for Hydraulic Separator.</p>
</html>"));
  end Examples;
end HydraulicSeparator;
