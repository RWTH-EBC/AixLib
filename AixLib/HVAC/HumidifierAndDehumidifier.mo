within AixLib.HVAC;
package HumidifierAndDehumidifier "Models for Humidifier and Dehumidifier"
      extends Modelica.Icons.Package;

  model SteamHumidifier "Steam humidifier, with consideration of saturation"
    extends Interfaces.TwoPortMoistAirFluidprops;
    outer BaseParameters baseParameters "System properties";

    Modelica.SIunits.Pressure p_Saturation_portb
      "Saturation Pressure of Steam portb";
     Real X_Saturation_portb(min=0)
      "saturation mass fractions of water to dry air m_w/m_a at portb";
     Real  Massflow_steamOut(start = 0) "steam flow which remains unused";
     Real Massflow_steamUseful "used steam flow";
     Real Dummy_portb_Xout "Xout if all the mass flow is used)";

    Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
    Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";

    Modelica.Blocks.Interfaces.RealInput Massflow_steamIn
                                                        annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-40,100}), iconTransformation(
          extent={{-14,-14},{14,14}},
          rotation=270,
          origin={-40,94})));
    Modelica.Blocks.Interfaces.RealInput Temperature_steamIn
                                                           annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={34,100}), iconTransformation(
          extent={{-14,-14},{14,14}},
          rotation=270,
          origin={40,94})));

  equation
     assert(portMoistAir_b.X_outflow < X_Saturation_portb, "
Oversaturation X_outflow at port_b = "   + String(portMoistAir_b.X_outflow) + " while X_saturation at port_b =" + String(X_Saturation_portb)+ ".", level=AssertionLevel.warning);
       assert(inStream(portMoistAir_a.X_outflow) < X_Saturation, "
Oversaturation X_outflow at port_a = "   + String(inStream(portMoistAir_a.X_outflow)) + " while X_saturation at port_a =" + String(X_Saturation)+ ".", level=AssertionLevel.warning);

    // No pressure loss
    dp = 0;

    // Mass balance air
    0 = portMoistAir_a.m_flow + portMoistAir_b.m_flow;

    // Mass balance water
    portMoistAir_b.X_outflow = inStream(portMoistAir_a.X_outflow) + Massflow_steamUseful / portMoistAir_a.m_flow;
    portMoistAir_a.X_outflow = inStream(portMoistAir_b.X_outflow) + Massflow_steamUseful / portMoistAir_b.m_flow;

    //Energy balance
    portMoistAir_b.h_outflow = inStream(portMoistAir_a.h_outflow) + Massflow_steamUseful * ((r_Steam + cp_Steam*(Temperature_steamIn - T_ref)))/portMoistAir_a.m_flow;
    portMoistAir_a.h_outflow = inStream(portMoistAir_b.h_outflow) + Massflow_steamUseful * ((r_Steam + cp_Steam*(Temperature_steamIn - T_ref)))/portMoistAir_b.m_flow;

    //Calculate help variables
    H_flow_a = portMoistAir_a.m_flow*actualStream(portMoistAir_a.h_outflow);
    H_flow_b = portMoistAir_b.m_flow*actualStream(portMoistAir_b.h_outflow);

    //Saturation pressure and humidity
    p_Saturation_portb = HVAC.Volume.BaseClasses.SaturationPressureSteam(T);                      // because almost isothermal
    X_Saturation_portb = M_Steam/M_Air*p_Saturation/(portMoistAir_b.p - p_Saturation_portb);
    Dummy_portb_Xout = inStream(portMoistAir_a.X_outflow) + Massflow_steamIn / portMoistAir_a.m_flow;

    if Dummy_portb_Xout > X_Saturation_portb then
      Massflow_steamUseful = portMoistAir_a.m_flow*(X_Saturation_portb - inStream(portMoistAir_a.X_outflow));
    else
      Massflow_steamUseful = Massflow_steamIn;
    end if;

    Massflow_steamOut = Massflow_steamIn - Massflow_steamUseful;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-80,80},{80,-80}},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Line(
            points={{-32,54},{-64,-48}},
            color={0,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None),
          Line(
            points={{-12,54},{-44,-48}},
            color={0,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None),
          Line(
            points={{12,54},{-20,-48}},
            color={0,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None),
          Line(
            points={{36,52},{4,-50}},
            color={0,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None),
          Line(
            points={{62,52},{30,-50}},
            color={0,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None),
          Line(
            points={{-50,56},{-20,-44}},
            color={0,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None),
          Line(
            points={{-18,56},{12,-44}},
            color={0,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None),
          Line(
            points={{16,56},{46,-44}},
            color={0,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None)}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a steam humidifier.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Model functions in both directions as a humidifier.</p>
<p>Model inputs: Massflow and temperature for steam.</p>
<p>Assumptions: all the possible steam is absorbed. Saturation is considered.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.HumidifierAndDehumidifier.SteamHumidifier\">AixLib.HVAC.HumidifierAndDehumidifier.SteamHumidifier</a></p>
</html>",
        revisions="<html>
<p>21.01.2014, by <i>Ana Constantin</i>: implemented</p>
</html>"));
  end SteamHumidifier;

  model CoolerDehumidifier "Dehumidifier through cooling"
      extends Interfaces.TwoPortMoistAirFluidprops;
    outer BaseParameters baseParameters "System properties";

     Modelica.SIunits.Pressure p_Saturation_CoolSurface
      "Saturation Pressure of Steam at Sensor";
     Real X_Saturation_CoolSurface(min=0)
      "saturation mass fractions of water to dry air m_w/m_a in Sensor";
     Real  Massflow_waterOut "dehumidified water flow";

    Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
    Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";

    Modelica.Blocks.Interfaces.RealInput BypassFactor      annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={46,100}), iconTransformation(
          extent={{-14,-14},{14,14}},
          rotation=270,
          origin={-60,94})));
    Modelica.Blocks.Interfaces.RealInput CoolSurfaceTemperature
                                                           annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-66,100}),iconTransformation(
          extent={{-14,-14},{14,14}},
          rotation=270,
          origin={52,94})));

  equation
    // No pressure loss
    dp = 0;

    // Calculate saturation mass fraction at cooling temperature
    p_Saturation_CoolSurface =
      HVAC.Volume.BaseClasses.SaturationPressureSteam(
      CoolSurfaceTemperature);
    X_Saturation_CoolSurface = M_Steam/M_Air*p_Saturation_CoolSurface/(portMoistAir_a.p - p_Saturation_CoolSurface);

    // Mass balance air
    0 = portMoistAir_a.m_flow + portMoistAir_b.m_flow;

    // Mass balance water
    portMoistAir_b.X_outflow = inStream(portMoistAir_a.X_outflow)*BypassFactor + X_Saturation_CoolSurface*(1-BypassFactor);
    portMoistAir_a.X_outflow = inStream(portMoistAir_b.X_outflow)*BypassFactor + X_Saturation_CoolSurface*(1-BypassFactor);

    Massflow_waterOut = (actualStream(portMoistAir_a.X_outflow)-actualStream(portMoistAir_b.X_outflow))/abs(portMoistAir_a.m_flow);

    //Energy balance
    portMoistAir_b.h_outflow  = inStream(portMoistAir_a.h_outflow)*BypassFactor + (1-BypassFactor)*(cp_Air*(CoolSurfaceTemperature-T_ref) + X_Saturation_CoolSurface*(cp_Steam*(CoolSurfaceTemperature-T_ref)+r_Steam));
    portMoistAir_a.h_outflow  = inStream(portMoistAir_b.h_outflow)*BypassFactor + (1-BypassFactor)*(cp_Air*(CoolSurfaceTemperature-T_ref) + X_Saturation_CoolSurface*(cp_Steam*(CoolSurfaceTemperature-T_ref)+r_Steam));

      //Calculate help variables
    H_flow_b = portMoistAir_b.m_flow *actualStream(portMoistAir_b.h_outflow);
    H_flow_a = portMoistAir_a.m_flow*actualStream(portMoistAir_a.h_outflow);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}),       graphics={
          Rectangle(
            extent={{-80,80},{80,-80}},
            fillColor={85,170,255},
            fillPattern=FillPattern.HorizontalCylinder,
            pattern=LinePattern.None,
            lineColor={0,0,0}),
          Line(
            points={{-50,-56},{-50,-34}},
            color={0,0,0},
            pattern=LinePattern.Dash,
            smooth=Smooth.None),
          Line(
            points={{-20,-56},{-20,-34}},
            color={0,0,0},
            pattern=LinePattern.Dash,
            smooth=Smooth.None),
          Line(
            points={{12,-56},{12,-34}},
            color={0,0,0},
            pattern=LinePattern.Dash,
            smooth=Smooth.None),
          Line(
            points={{46,-56},{46,-34}},
            color={0,0,0},
            pattern=LinePattern.Dash,
            smooth=Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a cooling dehumidfier.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Model inputs: temperature of cooling temperature and bypass factor.</p>
<p>Model functions in both directions as a dehumidifier.</p>
<p>Assumption: Model does not check to see if the water fraction dropped under 0.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.HumidifierAndDehumidifier.Examples.CoolerDehumidifier\">AixLib.HVAC.HumidifierAndDehumidifier.Examples.CoolerDehumidifier</a></p>
</html>",
        revisions="<html>
<p>21.01.2014, by <i>Ana Constantin</i>: implemented</p>
</html>"));
  end CoolerDehumidifier;

  package Examples
     extends Modelica.Icons.ExamplesPackage;

    model SteamHumidifier
      import Anlagensimulation_WS1314 = AixLib.HVAC;
      extends Modelica.Icons.Example;

      Anlagensimulation_WS1314.HumidifierAndDehumidifier.SteamHumidifier
        steamHumidifier
        annotation (Placement(transformation(extent={{-30,-2},{-6,20}})));
      Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX
                                                            source(
        h=56e3,
        m=2.78e-4,
        X=0.013)
        annotation (Placement(transformation(extent={{-102,0},{-82,20}})));
      Anlagensimulation_WS1314.Sources.BoundaryMoistAir_phX sink(
        X=0.04,
        h=1e5,
        p=100000)
        annotation (Placement(transformation(extent={{102,0},{80,22}})));
     inner Anlagensimulation_WS1314.BaseParameters
                               baseParameters(T0=303.15)
       annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Modelica.Blocks.Sources.Constant massFlow_steamIn(k=2.78e-6)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Modelica.Blocks.Sources.Constant temperature_steamIn(k=273.15 + 100)
        annotation (Placement(transformation(extent={{40,40},{20,60}})));
      Anlagensimulation_WS1314.Ductwork.Duct duct(l=10)
        annotation (Placement(transformation(extent={{30,4},{52,18}})));
    equation
      connect(massFlow_steamIn.y, steamHumidifier.Massflow_steamIn) annotation (
         Line(
          points={{-39,50},{-22.8,50},{-22.8,19.34}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(temperature_steamIn.y, steamHumidifier.Temperature_steamIn)
        annotation (Line(
          points={{19,50},{-13.2,50},{-13.2,19.34}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(duct.portMoistAir_b, sink.portMoistAir_a)  annotation (Line(
          points={{52,11},{80,11}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(source.portMoistAir_a, steamHumidifier.portMoistAir_a)
        annotation (Line(
          points={{-82,10},{-58,10},{-58,9},{-30,9}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(steamHumidifier.portMoistAir_b, duct.portMoistAir_a)  annotation (
         Line(
          points={{-6,9},{14,9},{14,11},{30,11}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
        experiment(
          StopTime=1000,
          Interval=1,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Example shows how the steam humidifier works.</p>
<p>In this particular set-up not all of the steam is absorbed because it would lead to over saturation.</p>
</html>", revisions="<html>
<p>21.01.2014, by <i>Ana Constantin</i>: implemented</p>
</html>"));
    end SteamHumidifier;

    model CoolerDehumidifier
      import Anlagensimulation_WS1314 = AixLib.HVAC;
      extends Modelica.Icons.Example;

      Anlagensimulation_WS1314.HumidifierAndDehumidifier.CoolerDehumidifier coolingDehumidifier
        annotation (Placement(transformation(extent={{-30,-2},{-6,20}})));
      Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX
                                                            source(
        h=56e3,
        m=2.78e-4,
        X=0.02)
        annotation (Placement(transformation(extent={{-102,0},{-82,20}})));
      Anlagensimulation_WS1314.Sources.BoundaryMoistAir_phX sink(
        X=0.01,
        h=1e4,
        p=100000)
        annotation (Placement(transformation(extent={{102,0},{80,22}})));
     inner Anlagensimulation_WS1314.BaseParameters
                               baseParameters(T0=303.15)
       annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Modelica.Blocks.Sources.Constant bypassFactor(k=0.01)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Modelica.Blocks.Sources.Constant temperature_coolingSurface(k=273.15 + 15)
        annotation (Placement(transformation(extent={{40,40},{20,60}})));
      Anlagensimulation_WS1314.Ductwork.Duct duct(l=10)
        annotation (Placement(transformation(extent={{30,4},{52,18}})));
    equation
      connect(duct.portMoistAir_b, sink.portMoistAir_a)  annotation (Line(
          points={{52,11},{80,11}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(source.portMoistAir_a, coolingDehumidifier.portMoistAir_a)
        annotation (Line(
          points={{-82,10},{-58,10},{-58,9},{-30,9}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(coolingDehumidifier.portMoistAir_b, duct.portMoistAir_a)
                                                                    annotation (
         Line(
          points={{-6,9},{14,9},{14,11},{30,11}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(coolingDehumidifier.CoolSurfaceTemperature,
        temperature_coolingSurface.y) annotation (Line(
          points={{-11.76,19.34},{-11.76,50},{19,50}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(bypassFactor.y, coolingDehumidifier.BypassFactor) annotation (
          Line(
          points={{-39,50},{-25.2,50},{-25.2,19.34}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
        experiment(
          StopTime=1000,
          Interval=1,
          __Dymola_Algorithm="Lsodar"),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Example shows how the cooling dehumidifier works.</p>
</html>", revisions="<html>
<p>21.01.2014, by <i>Ana Constantin</i>: implemented</p>
</html>"));
    end CoolerDehumidifier;
  end Examples;

end HumidifierAndDehumidifier;
