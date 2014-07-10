within AixLib.HVAC;
package Ductwork "Contains Ducts and other parts concerning ductwork"
  extends Modelica.Icons.Package;

  model Duct "Duct with pressure loss and storage of mass and energy"
  extends Interfaces.TwoPortMoistAir;
    outer BaseParameters baseParameters "System properties";
  public
    parameter Modelica.SIunits.Length D=0.05 "Diameter";
  parameter Modelica.SIunits.Length l=1 "Length";
  parameter Modelica.SIunits.Length e=2.5e-5 "Roughness";

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatport annotation (
        Placement(transformation(extent={{-12,32},{8,52}}),  iconTransformation(
            extent={{-10,27},{10,47}})));
    Volume.VolumeMoistAir volumeMoistAir(V=D*D/4*Modelica.Constants.pi*l,
      X(start=0.005),
      X_Steam(start=0.005))
      annotation (Placement(transformation(extent={{18,-31},{80,31}})));
    BaseClasses.DuctPressureLoss ductPressureLoss(
      D=D, l=l, e=e,
      X(start=0.005),
      X_Steam(start=0.005))
      annotation (Placement(transformation(extent={{-70,-28},{-8,28}})));
  equation
    connect(volumeMoistAir.portMoistAir_b, portMoistAir_b) annotation (Line(
        points={{80,0},{100,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volumeMoistAir.heatPort, heatport) annotation (Line(
        points={{49,31},{44,31},{44,34},{-2,34},{-2,42}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(ductPressureLoss.portMoistAir_b, volumeMoistAir.portMoistAir_a)
      annotation (Line(
        points={{-8,-3.55271e-015},{-2,-3.55271e-015},{-2,0},{18,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ductPressureLoss.portMoistAir_a, portMoistAir_a) annotation (Line(
        points={{-70,-3.55271e-015},{-86,-3.55271e-015},{-86,0},{-100,0}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},
              {100,40}}),  graphics={             Rectangle(
            extent={{-100,33},{100,-35}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-100,29},{100,-31}},
            lineColor={0,0,0},
            fillColor={170,255,255},
            fillPattern=FillPattern.HorizontalCylinder)}),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple Duct Model with pressure loss and storage of mass and energy</p>
<p>It consists of one pressure loss model and one Volume model.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Ductwork.Examples.DuctNetwork\">AixLib.HVAC.Ductwork.Examples.DuctNetwork</a> </p>
</html>",   revisions="<html>
<p>30.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,
              40}}),
              graphics));
  end Duct;

  model PressureLoss "simple pressure loss model based on zeta value"
  extends BaseClasses.SimplePressureLoss;
    outer BaseParameters baseParameters "System properties";
    parameter Real zeta = 1.0
      "Pressure loss factor for flow of port_a -> port_b";

  equation
    zeta_var = zeta;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(graphics={
                                            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={170,255,255},
            fillPattern=FillPattern.HorizontalCylinder),
                        Text(
            extent={{88,44},{-88,-40}},
            lineColor={0,0,255},
            fillColor={255,255,0},
            fillPattern=FillPattern.Solid,
            textString="Zeta =%zeta
d=%D")}),      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple pressure loss model based on a constant zeta value.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Ductwork.Examples.DuctPressureLoss\">AixLib.HVAC.Ductwork.Examples.DuctPressureLoss</a> </p>
</html>",   revisions="<html>
<p>30.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,
              40}}),
              graphics));
  end PressureLoss;

  model VolumeFlowController

  extends BaseClasses.SimplePressureLoss;
    outer BaseParameters baseParameters annotation (Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics), Icon(graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  fillColor={170,255,255},
                  fillPattern=FillPattern.HorizontalCylinder)}));

    Modelica.Blocks.Sources.RealExpression Volumeflow(y=Volflow)
      annotation (Placement(transformation(extent={{-88,-38},{-56,-6}})));
    Modelica.Blocks.Interfaces.RealInput VolumeFlowSet
      annotation (Placement(transformation(extent={{-126,4},{-90,38}})));

  Real angle "current angle of Flap";

    Modelica.Blocks.Continuous.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=0,
      yMin=-90,
      k=100,
      Ti=20,
      Td=1)  annotation (Placement(transformation(extent={{-22,2},{16,40}})));
  equation
    angle = -PID.y;
    zeta_var = 0.25*exp(0.1*angle);
    connect(VolumeFlowSet, PID.u_s) annotation (Line(
        points={{-108,21},{-25.8,21}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(PID.u_m, Volumeflow.y) annotation (Line(
        points={{-3,-1.8},{-3,-22},{-54.4,-22}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -50},{100,50}}),   graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-50},{100,50}}), graphics={
          Rectangle(
            extent={{-100,50},{100,-50}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-4,4},{4,-4}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillPattern=FillPattern.Solid),
          Line(
            points={{26,40},{-28,-40},{-28,-40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None),
          Line(
            points={{-68,0},{-30,0}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.None,
            arrow={Arrow.None,Arrow.Filled})}),    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Volume Flow Controler which is based on a PI controller</p>
<p>The Controller Influences the zeta-value of the component.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Ductwork.Examples.VolumeFlowController\">AixLib.HVAC.Ductwork.Examples.VolumeFlowController</a> </p>
</html>",   revisions="<html>
<p>30.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,
              40}}),
              graphics));
  end VolumeFlowController;

  package BaseClasses "BaseClasses for Ducts and other Ductwork"
    extends Modelica.Icons.BasesPackage;
    model DuctPressureLoss "Pressure Loss of a Duct"
    extends Interfaces.TwoPortMoistAirTransportFluidprops;

    import Modelica.Math;

    parameter Modelica.SIunits.Length D=0.05 "Diameter";
    parameter Modelica.SIunits.Length l=1 "Length";
    parameter Modelica.SIunits.Length e=2.5e-5 "Roughness";

    Modelica.SIunits.VolumeFlowRate Volflow "Volume Flow";

    Real lambda;
    Modelica.SIunits.ReynoldsNumber Re "Reynolds number";

    equation
    portMoistAir_a.m_flow = BaseClasses.m_flow_of_dp(dp,rho_MoistAir,dynamicViscosity,l,D,e/D)/(1+X_Steam);

    Re = 4*rho_MoistAir*Volflow / dynamicViscosity / D / Modelica.Constants.pi;

    Volflow = portMoistAir_a.m_flow*(1+X_Steam) / rho_MoistAir;

    lambda = if Volflow > 0 then 1/8 * dp*D^5*Modelica.Constants.pi^2/l /rho_MoistAir / Volflow^2 else 0;
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
                 Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Pressure loss model for duct.</p>
<p>It covers laminar and turbulent regime.</p>
<p>The critical Reynolds Number is 2300.</p>
<p>See function for Equations.</p>
</html>",    revisions="<html>
<p>30.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,
                40}}),
                graphics),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Polygon(
              points={{20,-70},{60,-85},{20,-100},{20,-70}},
              lineColor={0,128,255},
              smooth=Smooth.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              visible=showDesignFlowDirection),
            Polygon(
              points={{20,-75},{50,-85},{20,-95},{20,-75}},
              lineColor={255,255,255},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              visible=allowFlowReversal),
            Line(
              points={{55,-85},{-60,-85}},
              color={0,128,255},
              smooth=Smooth.None,
              visible=showDesignFlowDirection),
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={240,240,240},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-76,72},{-76,-38},{76,-38}},
              color={0,0,0},
              smooth=Smooth.None,
              arrow={Arrow.Open,Arrow.Open}),
            Text(
              extent={{-98,88},{-62,78}},
              lineColor={0,0,0},
              textString="lambda"),
            Text(
              extent={{62,-44},{92,-58}},
              lineColor={0,0,0},
              textString="Re"),
            Line(
              points={{-68,62},{-66,46},{-58,12},{-48,-8}},
              color={0,0,0},
              smooth=Smooth.None,
              thickness=0.5),
            Line(
              points={{-44,26},{-26,4},{6,-14},{64,-28}},
              color={0,0,0},
              smooth=Smooth.None,
              thickness=0.5),
            Line(
              points={{-42,38},{-24,16},{8,-2},{66,-16}},
              color={0,0,0},
              smooth=Smooth.None,
              thickness=0.5),
            Line(
              points={{-42,52},{-24,30},{8,12},{66,2}},
              color={0,0,0},
              smooth=Smooth.None,
              thickness=0.5),
            Line(
              points={{-40,62},{-22,40},{10,22},{66,16}},
              color={0,0,0},
              smooth=Smooth.None,
              thickness=0.5)}));
    end DuctPressureLoss;

    partial model SimplePressureLoss
    extends Interfaces.TwoPortMoistAirTransportFluidprops;

      parameter Modelica.SIunits.Length D=0.3 "Diameter of component";

    Modelica.SIunits.VolumeFlowRate Volflow(min = 0) "Volume Flow";

    Real zeta_var;

    equation
    Volflow = portMoistAir_a.m_flow*(1+X_Steam) / rho_MoistAir;

    dp = 8* zeta_var * rho_MoistAir /D^4  / Modelica.Constants.pi^2 * abs(Volflow)*Volflow;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                 Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple partial pressure loss model based on zeta value, which in this case given as a variable.</p>
</html>",     revisions="<html>
<p>30.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,
                40}}),
                graphics));
    end SimplePressureLoss;

    function m_flow_of_dp
      "Calculate mass flow rate as function of pressure drop due to friction"

      input Modelica.SIunits.Pressure dp
        "Pressure loss due to friction (dp = port_a.p - port_b.p)";
      input Modelica.SIunits.Density rho "Density at port_a";
      input Modelica.SIunits.DynamicViscosity mu "Dynamic viscosity at port_a";
      input Modelica.SIunits.Length length "Length of pipe";
      input Modelica.SIunits.Diameter diameter
        "Inner (hydraulic) diameter of pipe";
      input Real Delta "Relative roughness";
      output Modelica.SIunits.MassFlowRate m_flow
        "Mass flow rate from port_a to port_b";

    protected
      Real lambda2 "Modified friction coefficient (= lambda*Re^2)";
      Modelica.SIunits.ReynoldsNumber Re "Reynolds number";

    algorithm
      // Positive mass flow rate
      lambda2 := abs(dp)*2*diameter^3*rho/(length*mu*mu)
        "Known as lambda2=f(dp)";

      Re := lambda2/64 "Hagen-Poiseuille";

      // Modify Re, if turbulent flow
      if Re > 2300 then
        Re := -2*sqrt(lambda2)*Modelica.Math.log10(2.51/sqrt(lambda2) + 0.27*Delta)
          "Colebrook-White";
      end if;

      // Determine mass flow rate
      m_flow := (Modelica.Constants.pi*diameter/4)*mu*(if dp >= 0 then Re else -Re);
       annotation(smoothOrder=1,
       Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Calculation of pressureloss according to the following equation:</p>
<pre>dp = lambda * l / d * rho / 2 * u^2</pre>
<p><br>For laminar regime (if Re &le; 2300): </p>
<pre>
lambda = 64 / Re </pre>
<p><br>For turbulent regime (if Re &GT; 2300): </p>
<pre>
1/sqrt(lambda) = -2 log(2.51 / (Re *sqrt(lambda)) + epsilon / (3.71 * d)</pre>
<p> </p>
</html>",     revisions="<html>
<p>30.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end m_flow_of_dp;
  end BaseClasses;

  package Examples "Examples for Ducts and other Ductwork"
    extends Modelica.Icons.ExamplesPackage;
    model VolumeFlowController "Example for Volume Flow Controller"
      import Anlagensimulation_WS1314 = AixLib.HVAC;
    extends Modelica.Icons.Example;
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(use_p_in=false, p=
            100000) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={64,11})));
      inner Anlagensimulation_WS1314.BaseParameters
                                baseParameters
        annotation (Placement(transformation(extent={{60,66},{80,86}})));
     Modelica.Blocks.Sources.Ramp ramp(
       duration=100,
        startTime=50,
        offset=1.005e5,
        height=40000)
       annotation (Placement(transformation(extent={{-52,-58},{-32,-38}})));
     Modelica.Blocks.Sources.Ramp ramp1(
        offset=0,
        startTime=150,
        height=-5000,
        duration=2)
       annotation (Placement(transformation(extent={{-52,-88},{-32,-68}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{-4,-72},{16,-52}})));
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2(use_p_in=true, p=99900)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-62,11})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1)
        annotation (Placement(transformation(extent={{-88,34},{-68,54}})));
      Anlagensimulation_WS1314.Ductwork.VolumeFlowController
        volumeFlowControler(D=0.3)
        annotation (Placement(transformation(extent={{-24,6},{-4,16}})));
    equation

      connect(ramp.y, add.u1) annotation (Line(
          points={{-31,-48},{-24,-48},{-24,-56},{-6,-56}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(ramp1.y, add.u2) annotation (Line(
          points={{-31,-78},{-23.5,-78},{-23.5,-68},{-6,-68}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX2.p_in, add.y) annotation (Line(
          points={{-74,19},{-92,19},{-92,-32},{60,-32},{60,-62},{17,-62}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX2.portMoistAir_a, volumeFlowControler.portMoistAir_a)
        annotation (Line(
          points={{-52,11},{-24,11}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volumeFlowControler.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a)
        annotation (Line(
          points={{-4,11},{54,11}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volumeFlowControler.VolumeFlowSet, realExpression.y) annotation (
          Line(
          points={{-24.8,13.1},{-24.8,43.2},{-67,43.2},{-67,44}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
       Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A small example which shows how the volume flow controller works</p>
</html>", revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end VolumeFlowController;

    model DuctPressureLoss "Example for Duct"
      import Anlagensimulation_WS1314 = AixLib.HVAC;
    extends Modelica.Icons.Example;
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(use_p_in=false, p=
            100000) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={46,20})));
      inner Anlagensimulation_WS1314.BaseParameters
                                baseParameters
        annotation (Placement(transformation(extent={{60,66},{80,86}})));
     Modelica.Blocks.Sources.Ramp ramp(
       duration=100,
        startTime=50,
        offset=1.005e5,
        height=40000)
       annotation (Placement(transformation(extent={{-52,-58},{-32,-38}})));
     Modelica.Blocks.Sources.Ramp ramp1(
        offset=0,
        startTime=150,
        height=-5000,
        duration=2)
       annotation (Placement(transformation(extent={{-52,-88},{-32,-68}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{-4,-72},{16,-52}})));
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2(use_p_in=true, p=99900)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-42,20})));
      Anlagensimulation_WS1314.Ductwork.Duct duct
        annotation (Placement(transformation(extent={{-12,16},{8,24}})));
    equation

      connect(ramp.y, add.u1) annotation (Line(
          points={{-31,-48},{-24,-48},{-24,-56},{-6,-56}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(ramp1.y, add.u2) annotation (Line(
          points={{-31,-78},{-23.5,-78},{-23.5,-68},{-6,-68}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX2.p_in, add.y) annotation (Line(
          points={{-54,28},{-92,28},{-92,-32},{60,-32},{60,-62},{17,-62}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX2.portMoistAir_a, duct.portMoistAir_a)
        annotation (Line(
          points={{-32,20},{-12,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(duct.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a)
        annotation (Line(
          points={{8,20},{36,20}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics),
       Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A small example which shows the use of the duct model</p>
</html>", revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end DuctPressureLoss;

    model DuctNetwork "Duct Network Example"
      import Anlagensimulation_WS1314 = AixLib.HVAC;
    extends Modelica.Icons.Example;
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX1(use_p_in=false, p=98000)
                    annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={88,0})));
      inner Anlagensimulation_WS1314.BaseParameters
                                baseParameters
        annotation (Placement(transformation(extent={{60,66},{80,86}})));
      Sources.BoundaryMoistAir_phX boundaryMoistAir_phX2(
        use_p_in=false,
        h=2e4,
        p=100000)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,0})));
      Anlagensimulation_WS1314.Ductwork.Duct duct(D=0.1, l=10)
        annotation (Placement(transformation(extent={{-60,-6},{-40,6}})));
      Anlagensimulation_WS1314.Ductwork.Duct duct1(D=0.1, l=50)
        annotation (Placement(transformation(extent={{-26,26},{8,40}})));
      Anlagensimulation_WS1314.Ductwork.Duct duct2(D=0.1, l=100)
        annotation (Placement(transformation(extent={{-2,-6},{62,8}})));
      Anlagensimulation_WS1314.Ductwork.PressureLoss pressureLoss(D=0.1)
        annotation (Placement(transformation(extent={{14,26},{34,40}})));
      Anlagensimulation_WS1314.Ductwork.Duct duct3(D=0.1, l=50)
        annotation (Placement(transformation(extent={{42,26},{76,40}})));
      Anlagensimulation_WS1314.Ductwork.PressureLoss pressureLoss1(D=0.1, zeta=5)
        annotation (Placement(transformation(extent={{-58,-42},{-38,-28}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=500)
        annotation (Placement(transformation(extent={{-62,54},{-42,74}})));
    equation

      connect(duct.portMoistAir_b, duct1.portMoistAir_a) annotation (Line(
          points={{-40,0},{-32,0},{-32,33},{-26,33}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(duct.portMoistAir_b, duct2.portMoistAir_a) annotation (Line(
          points={{-40,0},{-2,0},{-2,1}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(duct1.portMoistAir_b, pressureLoss.portMoistAir_a) annotation (Line(
          points={{8,33},{14,33}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pressureLoss.portMoistAir_b, duct3.portMoistAir_a) annotation (Line(
          points={{34,33},{42,33}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(duct3.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a)
        annotation (Line(
          points={{76,33},{78,33},{78,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(duct2.portMoistAir_b, boundaryMoistAir_phX1.portMoistAir_a)
        annotation (Line(
          points={{62,1},{62,0},{78,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundaryMoistAir_phX2.portMoistAir_a, pressureLoss1.portMoistAir_a)
        annotation (Line(
          points={{-80,0},{-78,0},{-78,-2},{-72,-2},{-72,-35},{-58,-35}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pressureLoss1.portMoistAir_b, duct2.portMoistAir_a) annotation (Line(
          points={{-38,-35},{-10,-35},{-10,0},{0,0},{0,2},{-2,2},{-2,1}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(duct.portMoistAir_a, boundaryMoistAir_phX2.portMoistAir_a)
        annotation (Line(
          points={{-60,0},{-80,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(fixedHeatFlow.port, duct1.heatport) annotation (Line(
          points={{-42,64},{-9,64},{-9,39.475}},
          color={191,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
       Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A small example which shows how to build a network of ducts</p>
</html>", revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end DuctNetwork;
  end Examples;
end Ductwork;
