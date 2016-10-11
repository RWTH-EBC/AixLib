within AixLib.Fluid.HeatPumps.BaseClasses;
model HeatExchangerHP
  import SI = Modelica.SIunits;
 outer Modelica.Fluid.System system;

    parameter Boolean use_p_start=true "select p_start or d_start"
    annotation (Evaluate=true, Dialog(tab="Initialization"));

  parameter Medium.AbsolutePressure p_start = system.p_start
    "Start value of pressure"
    annotation(Dialog(tab = "Initialization"));
  parameter Boolean use_T_start = true "= true, use T_start, otherwise h_start"
    annotation(Dialog(tab = "Initialization"), Evaluate=true);
  parameter Medium.Temperature T_start=
    if use_T_start then system.T_start else Medium.temperature_phX(p_start,h_start,X_start)
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization", enable = use_T_start));
  parameter Medium.SpecificEnthalpy h_start=
    if use_T_start then Medium.specificEnthalpy_pTX(p_start, T_start, X_start) else Medium.h_default
    "Start value of specific enthalpy"
    annotation(Dialog(tab = "Initialization", enable = not use_T_start));
  parameter Medium.MassFraction X_start[Medium.nX] = Medium.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](
       quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
    "Start value of trace substances"
   annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
  parameter SI.MassFlowRate m_flow_start=0.5 annotation (Dialog(tab="Initialization"));

 replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium model"
     annotation (choicesAllMatching=true);
       parameter Real a=0 "Pressure loss: Coefficient for quadratic term";
  parameter Real b=0 "Pressure loss: Coefficient for linear term";
  parameter SI.Volume volume=0.004 "External medium volume in heat exchanger";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermalPort
    "Thermal port" annotation (extent=[-10,50; 10,70]);

  Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate
                                               simpleGenericOrifice(
     redeclare package Medium = Medium,
    m_flow(start=m_flow_start),
    a=a,
    b=b)                 annotation (extent=[20,-10; 40,10], Placement(
        transformation(extent={{26,-10},{46,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1( redeclare package Medium = Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (extent=[90,-10; 110,10]);
  Modelica.Fluid.Interfaces.FluidPort_a port_a1( redeclare package Medium = Medium)
    "Fluid inlet port" annotation (extent=[-110,-10; -90,10]);

  Modelica.Fluid.Vessels.ClosedVolume fluidVolume(
    redeclare package Medium = Medium,
    T_start(displayUnit="K") = T_start,
    nPorts=2,
    use_HeatTransfer=true,
    use_portsData=false,
    V=volume)
    annotation (Placement(transformation(extent={{-25.5,-1},{-4.5,20}})));
equation
  connect(simpleGenericOrifice.port_b, port_b1) annotation (Line(
      points={{46,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fluidVolume.ports[1], simpleGenericOrifice.port_a) annotation (
      Line(
      points={{-17.1,-1},{-17.1,-2},{4,-2},{4,0},{26,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_a1, fluidVolume.ports[2]) annotation (Line(
      points={{-100,0},{-48,0},{-48,-1},{-12.9,-1}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fluidVolume.heatPort, thermalPort) annotation (Line(
      points={{-25.5,9.5},{-36,9.5},{-36,34},{0,34},{0,60}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
                       Icon(Rectangle(extent=[-100,60; 100,-60], style(
          color=0,
          rgbcolor={0,0,0},
          gradient=2,
          fillColor=30,
          rgbfillColor={215,215,215})), Text(
        extent=[-100,-60; 100,-100],
        style(color=3, rgbcolor={0,0,255}),
        string="%name")),
    Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Models external fluid volumes and pressure drop in a heat pump. Used as condenser and evaporator in model HeatPump. It uses the Modelica.Fluid.Vessels.ClosedVolume and Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate model.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
</html>",
    revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li>
         by Kristian Huchtemann:<br>
         Implemented.</li>
</ul>
</html>"),   Documentation(info="<html>
 
<dl>
<dt><b>Main Author: </b>
<dd>Kristian Huchtemann <br>
    E.ON Energy Research Center <br>
    Institute for Energy Efficient Buildings and Indoor Climate <br>
    J&auml;gerstra&szlig;e 17/19 <br> 
    D-52066 Aachen <br>
    <a href=\"mailto:khuchtemann@eonerc.rwth-aachen.de\">khuchtemann@eonerc.rwth-aachen.de</a><br>
    <a href=\"http://www.eonerc.rwth-aachen.de/ebc\">www.eonerc.rwth-aachen.de/ebc</a><br>
</dl>
 
</html>"));
end HeatExchangerHP;
