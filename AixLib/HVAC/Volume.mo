within AixLib.HVAC;
package Volume
  "Contains volume models for modelling components which use a fluid volume"
  extends Modelica.Icons.Package;
  model Volume "Model of a fluid volume with heat port"

    parameter Modelica.SIunits.Volume V = 0.01 "Volume in m3";
    Modelica.SIunits.Temperature T "Temperature inside the CV in K";
    outer BaseParameters baseParameters "System properties";

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  protected
    parameter Modelica.SIunits.DynamicViscosity mu=baseParameters.mu_Water
      "Dynamic viscosity";
    parameter Modelica.SIunits.Density rho=baseParameters.rho_Water
      "Density of the fluid";
    parameter Modelica.SIunits.SpecificHeatCapacity cp=baseParameters.cp_Water
      "Specific heat capacity";
    parameter Modelica.SIunits.Temperature T0=baseParameters.T0
      "Initial temperature in K";
    parameter Modelica.SIunits.Temperature T_ref = baseParameters.T_ref
      "Reference temperature in K";
    parameter Modelica.SIunits.Mass m = V*rho
      "Mass of the fluid inside the volume in kg";
    Modelica.SIunits.Energy U(start = m * cp * (T0-T_ref))
      "Internal energy in J";
    Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
    Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";

  public
    Interfaces.Port_a port_a
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Interfaces.Port_b port_b
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  equation
    port_a.p = port_b.p; //no pressure difference between the two ports

    port_a.h_outflow = cp*(T-T_ref);
    port_b.h_outflow = cp*(T-T_ref);
    H_flow_a = port_a.m_flow*actualStream(port_a.h_outflow);
    H_flow_b = port_b.m_flow*actualStream(port_b.h_outflow);

    U = m * cp * (T-T_ref);
    der(U) = heatPort.Q_flow + H_flow_a + H_flow_b; // Dynamic energy balance
    heatPort.T = T;
    0 = port_a.m_flow + port_b.m_flow;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Sphere,
            fillColor={85,170,255})}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This model represents a simple fluid volume with two fluid ports and one heat port. It has no pressure difference between the two fluid ports. </p>
<p>The model uses the same energy balance as the pipe model.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst</a></p>
</html>",   revisions="<html>
<p>02.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end Volume;

      model VolumeMoistAir "Model of a moist Air volume with heat port"

        extends Interfaces.TwoPortMoistAir;
        import Modelica.Constants.R;

        outer BaseParameters baseParameters "System properties";

        parameter Modelica.SIunits.Volume V=0.01 "Volume in m3";
        Modelica.SIunits.Temperature T(start=T0, nominal=T0)
      "Temperature inside the CV in K";

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));

        // PARAMETERS FOR LIQUID WATER:

  protected
        parameter Modelica.SIunits.Density rho_Water=baseParameters.rho_Water
      "Density of water";
        parameter Modelica.SIunits.SpecificHeatCapacity cp_Water=baseParameters.cp_Water
      "Specific heat capacity";

        // PARAMETERS FOR STEAM:

        parameter Modelica.SIunits.MolarMass M_Steam = baseParameters.M_Steam
      "Molar Mass of Steam";
        parameter Modelica.SIunits.SpecificHeatCapacity cp_Steam=baseParameters.cp_Steam
      "Specific heat capacity of Steam";
        parameter Modelica.SIunits.SpecificEnthalpy r_Steam=baseParameters.r_Steam
      "Specific enthalpy of vapoisation";

        // PARAMETERS FOR AIR:

        parameter Modelica.SIunits.MolarMass M_Air=baseParameters.M_Air
      "Molar Mass of Dry Air";
        parameter Modelica.SIunits.SpecificHeatCapacity cp_Air=baseParameters.cp_Air
      "Specific heat capacity of Dry Air";

        // REF AND INITIAL TEMPERATURE

  public
        parameter Modelica.SIunits.Temperature T0=baseParameters.T0
      "Initial temperature in K";
        parameter Modelica.SIunits.Temperature T_ref=baseParameters.T_ref
      "Reference temperature in K";

        Modelica.SIunits.Pressure p "Pressure in CV";
        Modelica.SIunits.Pressure p_Steam "Pressure of Steam in CV";
        Modelica.SIunits.Pressure p_Air "Pressure of Air in CV";
        Modelica.SIunits.Pressure p_Saturation
      "Saturation Pressure of Steam in Air in CV";
        Modelica.SIunits.Density rho_MoistAir "Density of Moist Air";
        Modelica.SIunits.Density rho_Air(start = 1) "Density of Dry Air";
        Modelica.SIunits.Density rho_Steam(start = 1) "Density of Steam";
        Modelica.SIunits.Energy U "Internal energy in J";
        Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
        Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";
        Modelica.SIunits.MassFlowRate mX_flow_a "Mass Flow of Water at Port a";
        Modelica.SIunits.MassFlowRate mX_flow_b "Mass Flow of Water at Port b";
        Modelica.SIunits.Mass mX "Mass of Water in CV";

        Real X(min=0)
      "mass fractions of water (liquid and steam) to dry air m_w/m_a in CV";
        Real X_Steam(min=0) "mass fractions of steam to dry air m_w/m_a in CV";
        Real X_Water(min=0)
      "mass fractions of liquid water to dry air m_w/m_a in CV";
        Real X_Saturation(min=0)
      "saturation mass fractions of water to dry air m_w/m_a in CV";

        parameter Boolean useTstart=true
      "true if volume temperature should be initialized";
      initial equation

      if useTstart then
        T = T0;
      end if;
      X = 0.005;

      equation
        assert(T >= 273.15 and T <= 373.15, "
Temperature T is not in the allowed range
273.15 K <= (T ="  + String(T) + " K) <= 373.15 K
required from used moist air medium model.",      level=AssertionLevel.warning);

        // Pressure

        portMoistAir_a.p = portMoistAir_b.p;

        p = portMoistAir_a.p;

        p = p_Steam + p_Air;

        p_Steam = R/M_Steam*rho_Steam*T;
        p_Air = R/M_Air*rho_Air*T;

        p_Saturation = BaseClasses.SaturationPressureSteam(T);

       // Storage of Air Mass

        der(rho_Air)*V = portMoistAir_a.m_flow + portMoistAir_b.m_flow;
        rho_MoistAir = rho_Air*(1 + X_Steam + X_Water);

        // X

        X_Steam = rho_Steam/rho_Air;

        X_Saturation = M_Steam/M_Air*p_Saturation/(p - p_Saturation);

        X_Steam = min(X_Saturation, X);

        X_Water = max(X - X_Saturation, 0);

        // WATER MASS BALANCE

        portMoistAir_a.X_outflow = X;
        portMoistAir_b.X_outflow = X;

        // ENTHALPY

        portMoistAir_a.h_outflow = cp_Air*(T - T_ref) + X_Steam*(r_Steam + cp_Steam*(T - T_ref)) + X_Water*cp_Water*(T - T_ref);
        portMoistAir_b.h_outflow = cp_Air*(T - T_ref) + X_Steam*(r_Steam + cp_Steam*(T - T_ref)) + X_Water*cp_Water*(T - T_ref);

        H_flow_a = portMoistAir_a.m_flow*actualStream(portMoistAir_a.h_outflow);
        H_flow_b = portMoistAir_b.m_flow*actualStream(portMoistAir_b.h_outflow);

        U = V*rho_Air*(cp_Air*(T - T_ref) + X_Steam*(r_Steam + cp_Steam*(T - T_ref)) + X_Water*cp_Water*(T - T_ref));

        der(U) = heatPort.Q_flow + H_flow_a + H_flow_b;   // Dynamic energy balance

        mX_flow_a = portMoistAir_a.m_flow*actualStream(portMoistAir_a.X_outflow)
      "water mass flow";
        mX_flow_b = portMoistAir_b.m_flow*actualStream(portMoistAir_b.X_outflow)
      "water mass flow";

        mX = V*rho_Air*X;

        der(mX) = mX_flow_a + mX_flow_b;

        heatPort.T = T;

        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}),        graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={170,255,255},
            fillPattern=FillPattern.Sphere,
            fillColor={170,255,255})}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Volume Model for Moist Air without any pressure difference. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Includes storage of mass and energy. c_p is constant for every substance. Volume is also Constant. </p>
<p>The Volume of liquid Water does not influence the pressure calculation, because it is assumed to be very small.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer\">AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer</a></p>
</html>",   revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
      end VolumeMoistAir;

package BaseClasses "Contains base classes for Volume"
  extends Modelica.Icons.BasesPackage;

function SaturationPressureSteam
import degc = Modelica.SIunits.Conversions.to_degC;
input Modelica.SIunits.Temperature T "Temperature of Steam";

output Modelica.SIunits.Pressure   p_Saturation "Saturation Pressure of Steam";

algorithm
  p_Saturation :=611.657*exp(17.2799 - 4102.99/(degc(T) + 237.431));
annotation (
Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Function to calculate Saturation pressure for water / steam according to actual temperature.</p>
<p>Equation according to Baehr &ndash; Thermodynamik 15. edition, ISBN: 3642241603:</p>
<pre>   p_saturation = 611.657*e^(17.2799 - 4102.99/(T + 237.431));</pre>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
end SaturationPressureSteam;

function DynamicViscosityAir
import degc = Modelica.SIunits.Conversions.to_degC;
input Modelica.SIunits.Temperature T "Temperature of Steam";

output Modelica.SIunits.DynamicViscosity   DynamicViscosity
        "Saturation Pressure of Steam";

algorithm
  DynamicViscosity :=  1.72436e-5 + 5.04587e-8*degc(T) - 3.923361e-11 * degc(T)^2 + 4.046118e-14 * degc(T)^3;
annotation (
Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Function to calculate Dynamic viscosity of dry Air.</p>
<p>Equation according to Bernd Gl&uuml;ck &ndash; Zustands- und Stoffwerte, ISBN: 3-345-00487-9:</p>
<pre>   DynamicViscosity = 1.72436e-5 + 5.04587e-8*T - 3.923361e-11 * T^2 + 4.046118e-14 * T^3;</pre>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
end DynamicViscosityAir;

function DynamicViscositySteam
import degc = Modelica.SIunits.Conversions.to_degC;
input Modelica.SIunits.Temperature T "Temperature of Steam";

output Modelica.SIunits.DynamicViscosity   DynamicViscosity
        "Saturation Pressure of Steam";

algorithm
  DynamicViscosity :=  9.1435e-6 + 2.81979e-8 * degc(T) + 4.486993e-11 * degc(T)^2 - 4.928814e-14 * degc(T)^3;
annotation (
Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Function to calculate Dynamic viscosity of Steam.</p>
<p>Equation according to Bernd Gl&uuml;ck &ndash; Zustands- und Stoffwerte, ISBN: 3-345-00487-9:</p>
<pre>   DynamicViscosity =  9.1435e-6 + 2.81979e-8 * T + 4.486993e-11 * T^2 - 4.928814e-14 * T^3;</pre>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
end DynamicViscositySteam;

function DynamicViscosityMoistAir

input Modelica.SIunits.Temperature T "Temperature of Steam";
input Real X_Steam "mass fractions of steam to dry air m_s/m_a";

output Modelica.SIunits.DynamicViscosity   DynamicViscosity
        "Saturation Pressure of Steam";

algorithm
  DynamicViscosity := X_Steam / (1 + X_Steam) * DynamicViscositySteam(T) + 1 / (1 + X_Steam) * DynamicViscosityAir(T);

annotation (
Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Function to calculate Dynamic viscosity of moist Air.</p>
<p>Equation according to Bernd Gl&uuml;ck &ndash; Zustands- und Stoffwerte, ISBN: 3-345-00487-9:</p>
<pre>  DynamicViscosityMoistAir =  X_Steam / (1 + X_Steam) * DynamicViscositySteam + 1 / (1 + X_Steam) * DynamicViscosityAir</pre>
</html>",
      revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
end DynamicViscosityMoistAir;
end BaseClasses;

   package Examples
    extends Modelica.Icons.ExamplesPackage;
     model MoistAirWithHeatTransfer
     extends Modelica.Icons.Example;

       Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(X=0.001, p=100000)
        annotation (Placement(transformation(extent={{-100,-97},{-70,-67}})));
       Sources.MassflowsourceMoistAir_mhX massflowsourceMoistAir_mhX_1(
        h=7e3,
        X=2e-3,
        m=0.1)
        annotation (Placement(transformation(extent={{-100,40},{-70,71}})));
       HVAC.Volume.VolumeMoistAir volumeMoistAir_1(V=1)
        annotation (Placement(transformation(extent={{44,36},{84,76}})));
      inner BaseParameters      baseParameters(T0=298.15)
        annotation (Placement(transformation(extent={{78,74},{98,94}})));
       HVAC.Volume.VolumeMoistAir volumeMoistAir_M(V=1) annotation (
          Placement(transformation(
            extent={{-20,20},{20,-20}},
            rotation=180,
            origin={66,-82})));
       HVAC.Volume.VolumeMoistAir volumeMoistAir_2(V=2)
        annotation (Placement(transformation(extent={{40,-20},{80,20}})));
      Sensors.RelativeHumiditySensor humiditySensor_1
        annotation (Placement(transformation(extent={{-56,46},{-36,66}})));
      Sensors.RelativeHumiditySensor humiditySensor_2
        annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
      Sensors.RelativeHumiditySensor humiditySensor_M
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={26,-82})));
       Sources.MassflowsourceMoistAir_mhX massflowsourceMoistAir_mhX_2(
        h=39e3,
        X=7.5e-3,
        m=0.2) annotation (Placement(transformation(extent={{-103,-15},{-73,
                16}})));
      Sensors.RelativeHumiditySensor humiditySensor_C
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-50,-82})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{-40,-52},{-20,-32}})));
       HVAC.Volume.VolumeMoistAir volumeMoistAir_M1(V=1) annotation (
          Placement(transformation(
            extent={{-20,20},{20,-20}},
            rotation=180,
            origin={-12,-82})));
      Modelica.Blocks.Sources.Ramp ramp(
        startTime=100,
        duration=100,
        height=-2000)
        annotation (Placement(transformation(extent={{-80,-52},{-60,-32}})));
     equation
      connect(massflowsourceMoistAir_mhX_1.portMoistAir_a, humiditySensor_1.portMoistAir_a)
        annotation (Line(
          points={{-70,55.5},{-63,55.5},{-63,56},{-56,56}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(humiditySensor_1.portMoistAir_b, volumeMoistAir_1.portMoistAir_a)
        annotation (Line(
          points={{-36,56},{44,56}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(humiditySensor_2.portMoistAir_b, volumeMoistAir_2.portMoistAir_a)
        annotation (Line(
          points={{-32,0},{40,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(humiditySensor_2.portMoistAir_a, massflowsourceMoistAir_mhX_2.portMoistAir_a)
        annotation (Line(
          points={{-52,0},{-66,0},{-66,0.5},{-73,0.5}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(humiditySensor_C.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a)
        annotation (Line(
          points={{-60,-82},{-70,-82}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volumeMoistAir_2.portMoistAir_b, volumeMoistAir_M.portMoistAir_a)
        annotation (Line(
          points={{80,0},{98,0},{98,-82},{86,-82}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volumeMoistAir_1.portMoistAir_b, volumeMoistAir_M.portMoistAir_a)
        annotation (Line(
          points={{84,56},{98,56},{98,-82},{86,-82}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(humiditySensor_M.portMoistAir_b, volumeMoistAir_M1.portMoistAir_a)
        annotation (Line(
          points={{16,-82},{8,-82}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volumeMoistAir_M1.portMoistAir_b, humiditySensor_C.portMoistAir_a)
        annotation (Line(
          points={{-32,-82},{-40,-82}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volumeMoistAir_M.portMoistAir_b, humiditySensor_M.portMoistAir_a)
        annotation (Line(
          points={{46,-82},{36,-82}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(prescribedHeatFlow.port, volumeMoistAir_M1.heatPort) annotation (
          Line(
          points={{-20,-42},{-12,-42},{-12,-62}},
          color={191,0,0},
          smooth=Smooth.None));

      connect(ramp.y, prescribedHeatFlow.Q_flow) annotation (Line(
          points={{-59,-42},{-40,-42}},
          color={0,0,127},
          smooth=Smooth.None));
       annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),  graphics),
        experiment(StopTime=1000, Interval=1),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Example to show mixing of fluid flows and heat transfer for moist air model</p>
</html>",  revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
     end MoistAirWithHeatTransfer;

   end Examples;

  annotation (Documentation(info="<html>
<p>This package is a first implementation and will probalby contain only one volume model - if anyone has a better idea where to put this volume model: feel free to move it around if you make sure other models will still work.</p>
</html>"));
end Volume;
