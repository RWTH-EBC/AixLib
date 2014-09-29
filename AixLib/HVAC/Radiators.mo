within AixLib.HVAC;
package Radiators "Contains a radiator model"
  extends Modelica.Icons.Package;

  model Radiator
    import AixLib;

    parameter AixLib.DataBase.Radiators.RadiatiorBaseDataDefinition
      RadiatorType=AixLib.DataBase.Radiators.ThermX2_ProfilV_979W()
      annotation (choicesAllMatching=true);

   Sensors.TemperatureSensor T_flow
      annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
    Sensors.TemperatureSensor T_return
      annotation (Placement(transformation(extent={{54,-10},{74,10}})));
    Volume.Volume volume(V=RadiatorType.VolumeWater*0.001)
      annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
    Interfaces.RadPort radPort
      annotation (Placement(transformation(extent={{30,68},{50,88}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convPort
      annotation (Placement(transformation(extent={{-52,66},{-32,86}})));
   // Variablen
   Modelica.SIunits.Power Power "current power of radiator";
   Modelica.SIunits.TemperatureDifference OverTemperature
      "current over temperature";

  protected
   parameter Modelica.SIunits.TemperatureDifference OverTemperature_Norm = (RadiatorType.T_flow_nom - RadiatorType.T_return_nom) /  Modelica.Math.log((RadiatorType.T_flow_nom - RadiatorType.T_room_nom)/(RadiatorType.T_return_nom - RadiatorType.T_room_nom))
      "over temperature according to norm";

  public
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-34,2},{-14,22}})));
    Interfaces.Port_a port_a
      annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
    Interfaces.Port_b port_b
      annotation (Placement(transformation(extent={{82,-10},{102,10}})));
  equation

    // Calculate the current over temperature

      //This equation works well for educational purposes. The oevrtemperature calculation only works by correct initailization of the system tzemperatures.

  //     if (T_flow.signal - convPort.T) > 1e-5 or (T_return.signal - convPort.T) > 1e-5 then
  //       OverTemperature = (T_flow.signal - T_return.signal)
  //       /  Modelica.Math.log((T_flow.signal - convPort.T)/(T_return.signal - convPort.T));
  //     else // for nummerical reasons
  //        OverTemperature = (T_flow.signal + T_return.signal)*0.5 - convPort.T;
  //     end if;

    // This equation works better for stable equations, because the overtemperature can actually be directly calculated
    OverTemperature = max(volume.heatPort.T -  convPort.T,0.0); //the average radiator temperature is assumed to be the temperature of the volume, this avoids any division by zero and improves stability

    //Calculate the current power
    Power = RadiatorType.NominalPower * (OverTemperature/OverTemperature_Norm)^RadiatorType.Exponent;

    // Distribute the power to the convective and radiative ports

    //Extract the power from the water volume
    prescribedHeatFlow.Q_flow = - Power;

    //Set the convective power
    convPort.Q_flow = - Power * (1 - RadiatorType.RadPercent);

    //Set the radiative power
    radPort.Q_flow = - Power * RadiatorType.RadPercent;

    connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(
        points={{-14,12},{2,12},{2,10}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(port_a, T_flow.port_a) annotation (Line(
        points={{-92,0},{-78,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(T_flow.port_b, volume.port_a) annotation (Line(
        points={{-58,0},{-8,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volume.port_b, T_return.port_a) annotation (Line(
        points={{12,0},{54,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(T_return.port_b, port_b) annotation (Line(
        points={{74,0},{92,0}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Text(
            extent={{-80,-10},{-54,-18}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="T_flow"), Text(
            extent={{54,-10},{76,-18}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="T_return"),
          Rectangle(
            extent={{-40,54},{40,26}},
            lineColor={255,0,0},
            lineThickness=1),
          Text(
            extent={{-34,52},{36,28}},
            lineColor={255,0,0},
            lineThickness=1,
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="Heat transfer equations"),
          Line(
            points={{0,16},{0,24},{-2,22},{0,24},{2,22}},
            color={255,0,0},
            thickness=1,
            smooth=Smooth.None),
          Line(
            points={{28,58},{34,68},{30,66},{34,68},{34,64}},
            color={255,0,0},
            thickness=1,
            smooth=Smooth.None),
          Line(
            points={{-32,60},{-38,68},{-38,64},{-38,68},{-34,66}},
            color={255,0,0},
            thickness=1,
            smooth=Smooth.None)}), Icon(graphics={
          Rectangle(
            extent={{-68,56},{-60,-74}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-48,56},{-40,-74}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-28,56},{-20,-74}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-8,56},{0,-74}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{12,56},{20,-74}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{32,56},{40,-74}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{52,56},{60,-74}},
            lineColor={95,95,95},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-74,-60},{62,-70}},
            lineColor={95,95,95},
            fillColor={230,230,230},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-72,50},{64,40}},
            lineColor={95,95,95},
            fillColor={230,230,230},
            fillPattern=FillPattern.Solid)}),
      Documentation(revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple model for a radiator with one water volume. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The power is calculated according to the flow and return temperatures, the power and temperatures in the design case and the radiator exponent.</p>
<p>The power is split between convective and radiative heat transfer. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Radiators.Examples.PumpRadiatorValve\">AixLib.HVAC.Radiators.Examples.PumpRadiatorValve</a></p>
<p><a href=\"AixLib.HVAC.Radiators.Examples.PumpRadiatorThermostaticValve\">AixLib.HVAC.Radiators.Examples.PumpRadiatorThermostaticValve</a></p>
</html>"));
  end Radiator;

  package Examples
    extends Modelica.Icons.ExamplesPackage;
    model PumpRadiatorValve
      import AixLib;
      extends Modelica.Icons.Example;
      Pumps.Pump pump(
        MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1(),
        V_flow_max=2,
        ControlStrategy=2,
        V_flow(fixed=false),
        Head_max=2)
        annotation (Placement(transformation(extent={{-54,10},{-34,30}})));
      Pipes.StaticPipe
                 pipe(l=10, D=0.01)
        annotation (Placement(transformation(extent={{4,10},{24,30}})));
      Pipes.StaticPipe
                 pipe1(l=10, D=0.01)
        annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
      Modelica.Blocks.Sources.BooleanConstant
                                           NightSignal(k=false)
        annotation (Placement(transformation(extent={{-76,50},{-56,70}})));
      inner BaseParameters     baseParameters
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Sources.Boundary_p PointFixedPressure(use_p_in=false)
        annotation (Placement(transformation(extent={{-98,10},{-78,30}})));
      Valves.SimpleValve simpleValve(Kvs=0.4)
        annotation (Placement(transformation(extent={{30,10},{50,30}})));
      Radiator radiator(RadiatorType=
            AixLib.DataBase.Radiators.ThermX2_ProfilV_979W())
        annotation (Placement(transformation(extent={{112,10},{134,30}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature AirTemp
        annotation (Placement(transformation(extent={{100,58},{112,70}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RadTemp
        annotation (Placement(transformation(extent={{148,58},{136,70}})));
      Modelica.Blocks.Sources.Constant Source_Temp(k=273.15 + 20)
        annotation (Placement(transformation(extent={{60,80},{80,100}})));
      Modelica.Blocks.Sources.Sine Source_opening(
        freqHz=1/86400,
        offset=0.5,
        startTime=-21600,
        amplitude=0.49)
        annotation (Placement(transformation(extent={{10,60},{30,80}})));
      HeatGeneration.Boiler boiler
        annotation (Placement(transformation(extent={{-26,10},{-6,30}})));
      Modelica.Blocks.Sources.Constant Source_TempSet_Boiler(k=273.15 + 75)
        annotation (Placement(transformation(extent={{0,60},{-20,80}})));
    equation
      connect(pipe1.port_b,pump. port_a) annotation (Line(
          points={{-30,-20},{-60,-20},{-60,20},{-54,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(NightSignal.y,pump. IsNight) annotation (Line(
          points={{-55,60},{-44,60},{-44,30.2}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(PointFixedPressure.port_a,pump. port_a) annotation (Line(
          points={{-78,20},{-54,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe.port_b, simpleValve.port_a) annotation (Line(
          points={{24,20},{30,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(simpleValve.port_b, radiator.port_a) annotation (Line(
          points={{50,20},{112.88,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(radiator.port_b, pipe1.port_a) annotation (Line(
          points={{133.12,20},{160,20},{160,-20},{-10,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(AirTemp.port, radiator.convPort) annotation (Line(
          points={{112,64},{118.38,64},{118.38,27.6}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(radiator.radPort, RadTemp.port) annotation (Line(
          points={{127.4,27.8},{127.4,64},{136,64}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(Source_Temp.y, AirTemp.T) annotation (Line(
          points={{81,90},{98.8,90},{98.8,64}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_Temp.y, RadTemp.T) annotation (Line(
          points={{81,90},{150,90},{150,64},{149.2,64}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_opening.y, simpleValve.opening) annotation (Line(
          points={{31,70},{40,70},{40,28}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pump.port_b, boiler.port_a) annotation (Line(
          points={{-34,20},{-26,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boiler.port_b, pipe.port_a) annotation (Line(
          points={{-6,20},{4,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Source_TempSet_Boiler.y, boiler.T_set) annotation (Line(
          points={{-21,70},{-34,70},{-34,26},{-26.8,26},{-26.8,27}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(extent={{-100,-100},{160,100}},
              preserveAspectRatio=false), graphics),
        Icon(coordinateSystem(extent={{-100,-100},{160,100}})),
        experiment(
          StopTime=86400,
          Interval=60,
          __Dymola_Algorithm="Rkfix2"),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Pump, boiler, valve and radiator in a closed loop.</p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The example ilustrates how the radiator power depends on the mass flow, i.e. the valve opening.</p>
<p>The valve doesn&apos;t fully close, because as the radiator it is connected to fixed temperatures the temperature difference between flow and return become infinite at zero mass flow in order to satisfy the power equation. </p>
<p>Make sure you initialise the temperatures correctly in order to have flow temperature &GT; return temperature &GT; room temperature in order for the equation for over temperature to be correctly calculated.</p>
</html>"));
    end PumpRadiatorValve;

    model PumpRadiatorThermostaticValve
      import AixLib;
      extends Modelica.Icons.Example;
      Pumps.Pump pump(
        MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1(),
        V_flow_max=2,
        ControlStrategy=2,
        V_flow(fixed=false))
        annotation (Placement(transformation(extent={{-54,10},{-34,30}})));
      Pipes.StaticPipe
                 pipe(l=10, D=0.01)
        annotation (Placement(transformation(extent={{4,10},{24,30}})));
      Pipes.StaticPipe
                 pipe1(l=10, D=0.01)
        annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
      Modelica.Blocks.Sources.BooleanConstant
                                           NightSignal(k=false)
        annotation (Placement(transformation(extent={{-76,50},{-56,70}})));
      inner BaseParameters     baseParameters
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Sources.Boundary_p PointFixedPressure(use_p_in=false)
        annotation (Placement(transformation(extent={{-98,10},{-78,30}})));
      Valves.ThermostaticValve simpleValve(
        Influence_PressureDrop=0.15,
        Kvs=0.4,
        Kv_setT=0.12,
        dp(start=20000),
        leakageOpening=0)
        annotation (Placement(transformation(extent={{32,10},{52,30}})));
      Radiator radiator(RadiatorType=
            AixLib.DataBase.Radiators.ThermX2_ProfilV_979W())
        annotation (Placement(transformation(extent={{112,10},{134,30}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature AirTemp
        annotation (Placement(transformation(extent={{100,58},{112,70}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RadTemp
        annotation (Placement(transformation(extent={{148,58},{136,70}})));
      Modelica.Blocks.Sources.Constant Source_Temp(k=273.15 + 20)
        annotation (Placement(transformation(extent={{56,80},{76,100}})));
      Modelica.Blocks.Sources.Sine Source_opening(
        freqHz=1/86400,
        amplitude=1,
        startTime=0,
        offset=273.15 + 18.5)
        annotation (Placement(transformation(extent={{10,60},{30,80}})));
      HeatGeneration.Boiler boiler
        annotation (Placement(transformation(extent={{-26,10},{-6,30}})));
      Modelica.Blocks.Sources.Constant Source_TempSet_Boiler(k=273.15 + 75)
        annotation (Placement(transformation(extent={{0,60},{-20,80}})));
    equation
      connect(pipe1.port_b,pump. port_a) annotation (Line(
          points={{-30,-20},{-60,-20},{-60,20},{-54,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(NightSignal.y,pump. IsNight) annotation (Line(
          points={{-55,60},{-44,60},{-44,30.2}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(PointFixedPressure.port_a,pump. port_a) annotation (Line(
          points={{-78,20},{-54,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe.port_b, simpleValve.port_a) annotation (Line(
          points={{24,20},{32,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(simpleValve.port_b, radiator.port_a) annotation (Line(
          points={{52,20},{112.88,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(radiator.port_b, pipe1.port_a) annotation (Line(
          points={{133.12,20},{160,20},{160,-20},{-10,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(AirTemp.port, radiator.convPort) annotation (Line(
          points={{112,64},{118.38,64},{118.38,27.6}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(radiator.radPort, RadTemp.port) annotation (Line(
          points={{127.4,27.8},{127.4,64},{136,64}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(Source_Temp.y, AirTemp.T) annotation (Line(
          points={{77,90},{98.8,90},{98.8,64}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_Temp.y, RadTemp.T) annotation (Line(
          points={{77,90},{150,90},{150,64},{149.2,64}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pump.port_b, boiler.port_a) annotation (Line(
          points={{-34,20},{-26,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boiler.port_b, pipe.port_a) annotation (Line(
          points={{-6,20},{4,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Source_TempSet_Boiler.y, boiler.T_set) annotation (Line(
          points={{-21,70},{-34,70},{-34,26},{-26.8,26},{-26.8,27}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_Temp.y, simpleValve.T_room) annotation (Line(
          points={{77,90},{80,90},{80,44},{35.6,44},{35.6,29.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_opening.y, simpleValve.T_setRoom) annotation (Line(
          points={{31,70},{47.6,70},{47.6,29.8}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(extent={{-100,-100},{160,100}},
              preserveAspectRatio=false), graphics),
        Icon(coordinateSystem(extent={{-100,-100},{160,100}})),
        experiment(
          StopTime=86400,
          Interval=60,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Pump, boiler, thernostatic valve and radiator in a closed loop.</p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The example ilustrates how the thermostatic valve reacts.</p>
<p>The valve doesn&apos;t fully close, because as the radiator it is connected to fixed temperatures the temperature difference between flow and return become infinite at zero mass flow in order to satisfy the power equation. </p>
<p>Make sure you initialise the temperatures correctly in order to have flow temperature &GT; return temperature &GT; room temperature in order for the equation for over temperature to be correctly calculated.</p>
</html>"));
    end PumpRadiatorThermostaticValve;
  end Examples;
end Radiators;
