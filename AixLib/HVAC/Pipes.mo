within AixLib.HVAC;
package Pipes "Models of pipes"
  extends Modelica.Icons.Package;
  model StaticPipe
    extends Interfaces.TwoPort;

    import Modelica.Math;

    parameter Modelica.SIunits.Length D=0.05 "Diameter";
    parameter Modelica.SIunits.Length l=1 "Length";
    parameter Modelica.SIunits.Length e=2.5e-5 "Roughness";

    Modelica.SIunits.ReynoldsNumber Re(nominal=1e5) "Reynolds number";
    Real lambda2 "Modified friction factor";

  equation
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);

    lambda2 =  abs(p)*2*D^3*rho/(l*mu*mu);
    Re = -2*sqrt(lambda2)*Math.log10(2.51/sqrt(lambda2+1e-10) + 0.27*(e/D));
    m_flow =  sign(p)*Modelica.Constants.pi/4*D*mu*Re;

    annotation (Icon(graphics={                   Rectangle(
            extent={{-100,40},{100,-40}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,30},{100,-30}},
            lineColor={0,0,0},
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder)}),
  Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>",
  info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model of a straight pipe with constant cross section and with steady-state mass, momentum and energy balances, i.e., the model does not store mass or energy. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model uses a modified friction factor to estimate the Reynolds number. Using Hagen&ndash;Poiseuille equation, the pressure drop and mass flow rate are calculated using the Reynolds number. The model is only valid for turbulent flow. </p>
<h4><span style=\"color:#008000\">Numerical Issues</span></h4>
<p>With the stream connectors the thermodynamic states on the ports are generally defined by models with storage or by sources placed upstream and downstream of the static pipe. Other non storage components in the flow path may yield to state transformation. Note that this generally leads to nonlinear equation systems if multiple static pipes, or other flow models without storage, are directly connected. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Pipes.Examples.StaticPipe_Validation\">AixLib.HVAC.Pipes.Examples.StaticPipe_Validation</a></p>
</html>"));
  end StaticPipe;

  model Pipe
    extends Interfaces.TwoPort;

    import Modelica.Math;

    parameter Modelica.SIunits.Length D=0.05 "Diameter";
    parameter Modelica.SIunits.Length l=1 "Length";
    parameter Modelica.SIunits.Length e=2.5e-5 "Roughness";

    parameter Modelica.SIunits.Temperature T0=baseParameters.T0
      "Initial temperature" annotation(Dialog(tab="Initialization"));

    Modelica.SIunits.Temperature T "Temperature inside the CV";

  protected
    Modelica.SIunits.ReynoldsNumber Re(nominal=1e5) "Reynolds number";
    Real lambda2 "Modified fanning friction factor";

    parameter Modelica.SIunits.Temperature T_ref=baseParameters.T_ref;
    parameter Modelica.SIunits.Mass m=Modelica.Constants.pi*D^2/4*l*rho
      "Mass of the fluid in CV";
    Modelica.SIunits.Energy U(start=m*cp*(T0 - T_ref)) "Internal energy";
    Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a";
    Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b";

  public
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport annotation (
        Placement(transformation(extent={{-10,40},{10,60}}), iconTransformation(
            extent={{-10,40},{10,60}})));
  equation
    port_a.h_outflow = cp*(T-T_ref);
    port_b.h_outflow = cp*(T-T_ref);
    H_flow_a = port_a.m_flow*actualStream(port_a.h_outflow);
    H_flow_b = port_b.m_flow*actualStream(port_b.h_outflow);

    U = m * cp * (T-T_ref);
    der(U) = heatport.Q_flow + H_flow_a + H_flow_b;
    heatport.T = T;

    lambda2 =  abs(p)*2*D^3*rho/(l*mu*mu);
    Re = -2*sqrt(lambda2)*Math.log10(2.51/sqrt(lambda2+1e-10) + 0.27*(e/D));
    m_flow =  sign(p)*Modelica.Constants.pi/4*D*mu*Re;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}),
                     graphics={                   Rectangle(
            extent={{-100,40},{100,-40}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,30},{100,-30}},
            lineColor={0,0,0},
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder)}),
  Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>",
  info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model of a straight pipe with mass, energy and momentum balances. It provides the complete balance equations for one-dimensional fluid flow.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model uses a modified friction factor to estimate the Reynolds number. Using Hagen&ndash;Poiseuille equation, the pressure drop and mass flow rate are calculated using the Reynolds number. The model is only valid for turbulent flow.</p>
<p>For the energy balance, a differential equation is implemented for the whole pipe volume. Temperature of the volume is equal to the temperature at the heat port.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Pipes.Examples.Pipe_Validation\">AixLib.HVAC.Pipes.Examples.Pipe_Validation</a></p>
</html>"));
  end Pipe;

  package Examples
    extends Modelica.Icons.ExamplesPackage;
    model StaticPipe_Validation
      extends Modelica.Icons.Example;
      StaticPipe
           pipe(
        l=10,
        D=0.02412,
        e=0.03135)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      inner BaseParameters     baseParameters
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Sources.Boundary_ph boundary_ph(use_p_in=true)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Sources.Boundary_ph boundary_ph1(use_p_in=false)
        annotation (Placement(transformation(extent={{60,-10},{40,10}})));
      Modelica.Blocks.Sources.Ramp ramp(
        duration=1000,
        offset=1.2e5,
        height=6e6)
        annotation (Placement(transformation(extent={{-100,-4},{-80,16}})));
    equation
      connect(boundary_ph.port_a, pipe.port_a) annotation (Line(
          points={{-40,0},{-10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundary_ph1.port_a, pipe.port_b) annotation (Line(
          points={{40,0},{10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(ramp.y, boundary_ph.p_in) annotation (Line(
          points={{-79,6},{-62,6}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=1000, Interval=1),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>", info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simple example of the static pipe connected to two boundaries.</p>
<p><br/><b><font style=\"color: #008000; \">Concept</font></b></p>
<p>The first boundary has a changing pressure and the second boundary has a fixed pressure. This results in changing of the mass flow and pressure drop in the pipe which can be observed in the results.</p>
</html>"));
    end StaticPipe_Validation;

    model Pipe_Validation
      extends Modelica.Icons.Example;
      Pipe pipe(
        l=10,
        D=0.02412,
        e=0.03135)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      inner BaseParameters     baseParameters
        annotation (Placement(transformation(extent={{-10,50},{10,70}})));
      Sources.Boundary_ph boundary_ph(use_p_in=false, h=1e6)
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Sources.Boundary_ph boundary_ph1(use_p_in=false)
        annotation (Placement(transformation(extent={{60,-10},{40,10}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{-38,20},{-18,40}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=1000,
        duration=1000,
        startTime=200)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    equation
      connect(boundary_ph.port_a, pipe.port_a) annotation (Line(
          points={{-40,0},{-10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundary_ph1.port_a, pipe.port_b) annotation (Line(
          points={{40,0},{10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(prescribedHeatFlow.port, pipe.heatport) annotation (Line(
          points={{-18,30},{0,30},{0,5}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(ramp.y, prescribedHeatFlow.Q_flow) annotation (Line(
          points={{-59,30},{-38,30}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
        experiment(StopTime=1500, Interval=1),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>", info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Simple example of the pipe connected to two boundaries and a heat source.</p>
<p><br/><b><font style=\"color: #008000; \">Concept</font></b></p>
<p>The boundaries have different pressures resulting in a mass flow in the pipe. The pipe is connected to a heat source with variable heat flow. The change in internal energy and the temperature of the pipe can be observed.</p>
</html>"));
    end Pipe_Validation;
  end Examples;
end Pipes;
