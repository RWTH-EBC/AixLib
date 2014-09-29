within AixLib.HVAC;
package Interfaces "Special interfaces for hyraulic applications"
  extends Modelica.Icons.InterfacesPackage;

  connector Port_a
    Modelica.SIunits.Pressure p "Pressure at the port";
    flow Modelica.SIunits.MassFlowRate m_flow "Mass flowing into the port";
    stream Modelica.SIunits.SpecificEnthalpy h_outflow
      "Specific enthalpy close to the connection point if m_flow < 0";
    annotation (defaultComponentName="port_a",
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Ellipse(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,0},
            fillColor={85,85,255},
            fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
              textString="%name")}),
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={85,85,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>", info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Interface for quasi one-dimensional fluid flow in a hydraulic component. Only for fluid with constant properties.</p>
<p>Pressure, mass flow and enthalpy flow are transported in this interface.</p>
</html>"));
  end Port_a;

  connector Port_b
    Modelica.SIunits.Pressure p "Pressure at the port";
    flow Modelica.SIunits.MassFlowRate m_flow "Mass flowing into the port";
    stream Modelica.SIunits.SpecificEnthalpy h_outflow
      "Specific enthalpy close to the connection point if m_flow < 0";
    annotation (defaultComponentName="port_b",
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Ellipse(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,0},
            fillColor={85,85,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-30,30},{30,-30}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(extent={{-150,110},{150,50}}, textString="%name")}),
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={85,85,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>", info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Interface for quasi one-dimensional fluid flow in a hydraulic component. Only for fluid with constant properties.</p>
<p>Pressure, mass flow and enthalpy flow are transported in this interface.</p>
</html>"));
  end Port_b;

  partial model TwoPort
    "Component with two hydraulic ports and mass flow rate from a to b"
    Modelica.SIunits.PressureDifference dp
      "Pressure drop between the two ports (= port_a.p - port_b.p)";
    Modelica.SIunits.MassFlowRate m_flow "Mass flowing from port a to port b";
    outer BaseParameters baseParameters "System properties";

  protected
    parameter Modelica.SIunits.DynamicViscosity mu=baseParameters.mu_Water
      "Dynamic viscosity";
    parameter Modelica.SIunits.Density rho=baseParameters.rho_Water
      "Density of the fluid";
    parameter Modelica.SIunits.SpecificHeatCapacity cp=baseParameters.cp_Water
      "Specific heat capacity";
  public
    Port_a  port_a    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Port_b  port_b    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  equation
    dp = port_a.p - port_b.p;
    0 = port_a.m_flow + port_b.m_flow;
    m_flow = port_a.m_flow;
    annotation (Icon(graphics), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}),
                                        graphics),
      Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>",
  info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
This component transports fluid between its two ports, without storing mass or energy.
Energy may be exchanged with the environment though, e.g., in the form of heat transfer.
<code>TwoPort</code> is intended as base class for devices like pipes, valves and simple fluid machines.
<p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
Three equations need to be added by an extending class using this component:
</p>
<ul>
<li>the momentum balance specifying the relationship between the pressure drop <code>dp</code> and the mass flow rate <code>m_flow</code></li>
<li><code>port_b.h_outflow</code> for flow in design direction</li>
<li><code>port_a.h_outflow</code> for flow in reverse direction</li>
</ul>
</html>"));
  end TwoPort;

  connector RadPort "Port for radiative heat transfer 1-dim"
    extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Line(
            points={{-100,100},{100,-100}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{-100,0},{100,0}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{-98,-96},{100,100}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{0,-100},{0,100}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5)}), Diagram(graphics={
          Text(
            extent={{-80,114},{82,72}},
            lineColor={0,0,0},
            lineThickness=1,
            textString="%name"),
          Line(
            points={{-60,58},{60,-60}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=1),
          Line(
            points={{-80,0},{80,0}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=1),
          Line(
            points={{-60,-60},{58,60}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=1),
          Line(
            points={{0,-80},{0,80}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=1)}),
      Documentation(revisions="<html>
<p>13.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>", info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Connector for radiative heat transfer.</p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>Same functionality as HeatPort.</p>
<p>Is used for components with radiative heat transfer (NOT air).</p>
</html>"));
  end RadPort;

  connector PortMoistAir_a
    Modelica.SIunits.Pressure p "Pressure at the port";
    flow Modelica.SIunits.MassFlowRate m_flow
      "Massflow of Dry Air flowing into the port";
    stream Modelica.SIunits.SpecificEnthalpy h_outflow
      "Specific enthalpy (in kJ / kg_dry-air) close to the connection point, when the mass flow flows OUT of the port";
    stream Real X_outflow(min=0)
      "mass fractions of water to dry air m_w/m_a close to the connection point, when the mass flow flows OUT of the port";
    annotation (defaultComponentName="portMoistAir_a",
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Ellipse(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,0},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
              textString="%name")}),
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid)}),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Port Model for Moist Air</p>
</html>",   revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end PortMoistAir_a;

  connector PortMoistAir_b
    Modelica.SIunits.Pressure p "Pressure at the port";
    flow Modelica.SIunits.MassFlowRate m_flow
      "Massflow of Dry Air flowing into the port";
    stream Modelica.SIunits.SpecificEnthalpy h_outflow
      "Specific enthalpy (in kJ / kg_dry-air) close to the connection point";
    stream Real X_outflow(min=0)
      "mass fractions of water to dry air m_w/m_a close to the connection point";
    annotation (defaultComponentName="portMoistAir_b",
                Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Ellipse(
            extent={{-40,40},{40,-40}},
            lineColor={0,0,0},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid), Text(extent={{-150,110},{150,50}},
              textString="%name"),
          Ellipse(
            extent={{-30,30},{30,-30}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,127,255},
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid), Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={0,127,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Port Model for Moist Air</p>
</html>",   revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end PortMoistAir_b;

  partial model TwoPortMoistAir "Component with two moist air ports"
    Modelica.SIunits.PressureDifference dp
      "Pressure drop between the two ports (= port_a.p - port_b.p)";

    PortMoistAir_a portMoistAir_a
                      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    PortMoistAir_b portMoistAir_b
                      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  equation
    dp = portMoistAir_a.p - portMoistAir_b.p;

    annotation (Icon(graphics), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}),
                                        graphics),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Two Port Model for Moist Air</p>
</html>",   revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end TwoPortMoistAir;

  partial model TwoPortMoistAirTransport
    "Base class for moist air transport models without influence on fluid"
    extends TwoPortMoistAir;

  equation
      // Mass Equation
    0 = portMoistAir_a.m_flow + portMoistAir_b.m_flow;

      // Enthalpy Equations
    inStream(portMoistAir_a.h_outflow) = portMoistAir_b.h_outflow;
    inStream(portMoistAir_b.h_outflow) = portMoistAir_a.h_outflow;

      // Water Equations
    inStream(portMoistAir_b.X_outflow) = portMoistAir_a.X_outflow;
    inStream(portMoistAir_a.X_outflow) = portMoistAir_b.X_outflow;

    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Two Port Model for Moist Air with transport equations, no influence of fluid</p>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),            graphics));
  end TwoPortMoistAirTransport;

  partial model TwoPortMoistAirFluidprops
    "Base class for Moist Air with all fluid properties at port a"
    extends Interfaces.TwoPortMoistAir;
    import Modelica.Constants.R;
    outer BaseParameters baseParameters "System properties";

  // PARAMETERS FOR WATER:

  protected
    parameter Modelica.SIunits.SpecificHeatCapacity cp_Water=baseParameters.cp_Water
      "Specific heat capacity of liquid water";

  // PARAMETERS FOR STEAM:

    parameter Modelica.SIunits.MolarMass M_Steam = baseParameters.M_Steam
      "Molar Mass of Steam";
    parameter Modelica.SIunits.SpecificHeatCapacity cp_Steam=baseParameters.cp_Steam
      "Specific heat capacity of Steam";
    parameter Modelica.SIunits.SpecificEnthalpy r_Steam=baseParameters.r_Steam
      "Specific enthalpy of vaporisation";

    // PARAMETERS FOR DRY AIR:

    parameter Modelica.SIunits.MolarMass M_Air=baseParameters.M_Air
      "Molar Mass of Dry Air";
    parameter Modelica.SIunits.SpecificHeatCapacity cp_Air=baseParameters.cp_Air
      "Specific heat capacity of Dry Air";

  public
    parameter Modelica.SIunits.Temperature T_ref=baseParameters.T_ref
      "Reference temperature in K";
    Modelica.SIunits.Temperature T "Temperature close to the sensor in K";
    Modelica.SIunits.Pressure p "Pressure at Sensor";
    Modelica.SIunits.Pressure p_Steam "Pressure of Steam at Sensor";
    Modelica.SIunits.Pressure p_Air "Pressure of Air at Sensor";
    Modelica.SIunits.Pressure p_Saturation
      "Saturation Pressure of Steam at Sensor";
    Modelica.SIunits.Density rho_MoistAir(start = 1) "Density of Moist Air";
    Modelica.SIunits.Density rho_Air(start = 1) "Density of Dry Air";
    Modelica.SIunits.Density rho_Steam(start = 1) "Density of Steam";

    Real X(min=0)
      "mass fractions of water (liquid and steam) to dry air m_w/m_a in Sensor";
    Real X_Steam(min=0) "mass fractions of steam to dry air m_w/m_a in Sensor";
    Real X_Water(min=0)
      "mass fractions of liquid water to dry air m_w/m_a in Sensor";
    Real X_Saturation(min=0)
      "saturation mass fractions of water to dry air m_w/m_a in Sensor";

    Modelica.SIunits.DynamicViscosity   dynamicViscosity
      "dynamic viscosity of moist air";

  equation
    // Pressure
    p = portMoistAir_a.p;

    p = p_Steam + p_Air;

    p_Steam = R/M_Steam*rho_Steam*T;
    p_Air = R/M_Air*rho_Air*T;

    p_Saturation = HVAC.Volume.BaseClasses.SaturationPressureSteam(T);

    rho_MoistAir = rho_Air*(1 + X_Steam + X_Water);

    // X

    X_Steam = rho_Steam/rho_Air;

    X_Saturation = M_Steam/M_Air*p_Saturation/(p - p_Saturation);

    X_Steam = min(X_Saturation, X);

    X_Water = max(X - X_Saturation, 0);

   // ENTHALPY

    actualStream(portMoistAir_a.h_outflow) = cp_Air*(T - T_ref) + X_Steam*(r_Steam + cp_Steam*(T -
      T_ref)) + X_Water*cp_Water*(T - T_ref);

    X = actualStream(portMoistAir_a.X_outflow);

    dynamicViscosity = HVAC.Volume.BaseClasses.DynamicViscosityMoistAir(T,
      X_Steam);

    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Two Port Model for Moist Air with fluid propoerties at port a</p>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),            graphics));
  end TwoPortMoistAirFluidprops;

  partial model TwoPortMoistAirTransportFluidprops
    "Base class for tranport of Moist Air with all fluid properties"
    extends Interfaces.TwoPortMoistAirTransport;
    import Modelica.Constants.R;
    outer BaseParameters baseParameters "System properties";

  // PARAMETERS FOR WATER:

  protected
    parameter Modelica.SIunits.SpecificHeatCapacity cp_Water=baseParameters.cp_Water
      "Specific heat capacity of liquid water";

  // PARAMETERS FOR STEAM:

    parameter Modelica.SIunits.MolarMass M_Steam = baseParameters.M_Steam
      "Molar Mass of Steam";
    parameter Modelica.SIunits.SpecificHeatCapacity cp_Steam=baseParameters.cp_Steam
      "Specific heat capacity of Steam";
    parameter Modelica.SIunits.SpecificEnthalpy r_Steam=baseParameters.r_Steam
      "Specific enthalpy of vaporisation";

    // PARAMETERS FOR DRY AIR:

    parameter Modelica.SIunits.MolarMass M_Air=baseParameters.M_Air
      "Molar Mass of Dry Air";
    parameter Modelica.SIunits.SpecificHeatCapacity cp_Air=baseParameters.cp_Air
      "Specific heat capacity of Dry Air";

  public
    parameter Modelica.SIunits.Temperature T_ref=baseParameters.T_ref
      "Reference temperature in K";
    Modelica.SIunits.Temperature T "Temperature close to the sensor in K";
    Modelica.SIunits.Pressure p "Pressure at Sensor";
    Modelica.SIunits.Pressure p_Steam "Pressure of Steam at Sensor";
    Modelica.SIunits.Pressure p_Air "Pressure of Air at Sensor";
    Modelica.SIunits.Pressure p_Saturation
      "Saturation Pressure of Steam at Sensor";
    Modelica.SIunits.Density rho_MoistAir "Density of Moist Air";
    Modelica.SIunits.Density rho_Air(start = 1) "Density of Dry Air";
    Modelica.SIunits.Density rho_Steam(start = 1) "Density of Steam";

    Real X(min=0)
      "mass fractions of water (liquid and steam) to dry air m_w/m_a in Sensor";
    Real X_Steam(min=0) "mass fractions of steam to dry air m_w/m_a in Sensor";
    Real X_Water(min=0)
      "mass fractions of liquid water to dry air m_w/m_a in Sensor";
    Real X_Saturation(min=0)
      "saturation mass fractions of water to dry air m_w/m_a in Sensor";

    Modelica.SIunits.DynamicViscosity   dynamicViscosity
      "dynamic viscosity of moist air";

  equation
    // Pressure
    p = portMoistAir_a.p;

    p = p_Steam + p_Air;

    p_Steam = R/M_Steam*rho_Steam*T;
    p_Air = R/M_Air*rho_Air*T;

    p_Saturation = HVAC.Volume.BaseClasses.SaturationPressureSteam(T);

    rho_MoistAir = rho_Air*(1 + X_Steam + X_Water);

    // X

    X_Steam = rho_Steam/rho_Air;

    X_Saturation = M_Steam/M_Air*p_Saturation/(p - p_Saturation);

    X_Steam = min(X_Saturation, X);

    X_Water = max(X - X_Saturation, 0);

   // ENTHALPY

    actualStream(portMoistAir_a.h_outflow) = cp_Air*(T - T_ref) + X_Steam*(r_Steam + cp_Steam*(T -
      T_ref)) + X_Water*cp_Water*(T - T_ref);

    X = actualStream(portMoistAir_a.X_outflow);

    dynamicViscosity = HVAC.Volume.BaseClasses.DynamicViscosityMoistAir(T,
      X_Steam);

    annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Two Port Model for Moist Air with transport equations and fluid properties at port a, no influence of fluid.</p>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
       Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),            graphics));
  end TwoPortMoistAirTransportFluidprops;

  partial model FourPortMoistAir "Component with four moist air ports"
    Modelica.SIunits.PressureDifference dp[2]
      "Pressure drop between the two ports (= port_a.p - port_b.p)";

    Interfaces.PortMoistAir_a port_1a
      annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
    Interfaces.PortMoistAir_b port_1b
      annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
    Interfaces.PortMoistAir_a port_2a annotation (Placement(transformation(extent=
             {{90,-70},{110,-50}}), iconTransformation(extent={{90,-70},{110,-50}})));
    Interfaces.PortMoistAir_b port_2b annotation (Placement(transformation(
            extent={{90,50},{110,70}}), iconTransformation(extent={{90,50},{110,70}})));

  equation
    dp[1] = port_1a.p - port_1b.p;
    dp[2] = port_2a.p - port_2b.p;

    annotation (Icon(graphics), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}),
                                        graphics),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Two Port Model for Moist Air</p>
</html>",   revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end FourPortMoistAir;

end Interfaces;
