within AixLib.FastHVAC.Components.HeatExchangers.Geothermal.BoreHoleHeatExchanger;
model CoaxialPipe "Discretized UPipe consisting of n UPipeElements"
  import SI = Modelica.SIunits;

  /// Model parameters ///
    // General
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Used medium"                                                                      annotation (Dialog(group="General"), choicesAllMatching=true);
    parameter SI.Temperature T_start "Initial Temperature of UPipe-System"          annotation(Dialog(group="General"));
    parameter Integer n = 5 "Number of discretizations in axial direction" annotation(Dialog(group="General"));

    // Borehole
    parameter SI.Length boreholeDepth "Total depth of the borehole" annotation(Dialog(group="Borehole"));
    parameter SI.Diameter boreholeDiameter "Total diameter of the borehole" annotation(Dialog(group="Borehole"));
    parameter AixLib.DataBase.Materials.FillingMaterials.FillingMaterialBaseRecord
    boreholeFilling "Filling of the borehole" annotation(Dialog(group="Borehole"), choicesAllMatching=true);

    // Pipes
    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeType "Type of pipe" annotation (Dialog(group="Pipes"), choicesAllMatching=true);
    parameter Integer nParallel = 2 "1: U-Pipe, 2: Double-U-Pipe" annotation (Dialog(group="Pipes"));

    // Deflection
    parameter Real zeta = 0.237
    "Pressure loss coefficient for pipe deflection at bottom of borehole"                                     annotation(Dialog(group="Deflection"));
    parameter SI.MassFlowRate m
    "Nominal massflow rate for pipe deflection at bottom of borehole"                                     annotation(Dialog(group="Deflection"));
public
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.CoaxialPipeElement uPipeElement[n](
    redeclare package Medium = Medium,
    each T_start=T_start,
    each fillingDensity=boreholeFilling.density,
    each fillingHeatCapacity=boreholeFilling.heatCapacity,
    each fillingThermalConductivity=boreholeFilling.thermalConductivity,
    each boreholeDiameter=boreholeDiameter,
    each length=boreholeDepth/n,
    each d_i_outerPipe=d_i_outerPipe,
    each d_o_outerPipe=d_o_outerPipe,
    each innerPipeType=innerPipeType,
    each lambda_outerPipe=lambda_outerPipe,
    each c_OuterPipe=c_OuterPipe,
    each rho_OuterPipe=rho_OuterPipe,
    redeclare each function alpha_AnnularGapInside = alpha_AnnularGapInside,
    redeclare each function alpha_AnnularGapOutside = alpha_AnnularGapOutside,
    redeclare function delta_p_AnnularGap = delta_p_AnnularGap,
    each eta=eta,
    each d=d,
    each lambda=lambda,
    each cp=cp)
    annotation (Placement(transformation(extent={{-31,-8},{43,36}})));

public
  Modelica.Fluid.Interfaces.FluidPort_a fluidPortIn(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-38,70},{-18,90}}),
        iconTransformation(extent={{-38,70},{-18,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b fluidPortOut(redeclare package Medium
      = Medium) annotation (Placement(transformation(extent={{6,70},{26,90}}),
        iconTransformation(extent={{6,70},{26,90}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance deflection(
    redeclare package Medium = Medium,
    diameter=innerPipeType.d_i,
    zeta=zeta,
    m_flow_nominal=m)
    annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
    thermalConnectors2Ground[n] annotation (Placement(transformation(extent=
           {{-50,10},{-30,30}}), iconTransformation(extent={{-50,10},{-30,
            30}})));

  parameter SI.Diameter d_i_outerPipe=0.2 "inner diameter of outer pipe"
    annotation (Dialog(group="Outer pipe"));
  parameter SI.Diameter d_o_outerPipe=0.21 "outer diameter of outer pipe"
    annotation (Dialog(group="Outer pipe"));
  parameter SI.ThermalConductivity lambda_outerPipe=373
    "Heat conductivity of pipe" annotation (Dialog(group="Outer pipe"));
  parameter SI.SpecificHeatCapacity c_OuterPipe=1000
    annotation (Dialog(group="Outer pipe"));
  parameter SI.Density rho_OuterPipe=1600
    annotation (Dialog(group="Outer pipe"));
  parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition innerPipeType=
      DataBase.Pipes.DIN_EN_10255.DIN_EN_10255_DN10() "Type of inner pipe"
    annotation (Dialog(group="Inner pipe"),choicesAllMatching=true);

  replaceable function alpha_AnnularGapInside =
      AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alphaAnnular1
    constrainedby
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alpha_partial
                                                                                         annotation (
      __Dymola_choicesAllMatching=true);
  replaceable function alpha_AnnularGapOutside =
      AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alphaAnnular1
    constrainedby
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alpha_partial
                                                                                         annotation (
      __Dymola_choicesAllMatching=true);
  replaceable function delta_p_AnnularGap =
      AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss.delta_pAnnularGap
    constrainedby
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss.delta_p_partial
                                                                                                     annotation (
      __Dymola_choicesAllMatching=true);
  parameter SI.DynamicViscosity eta=1139.0*10e-6 "Dynamic Viscosity"
    annotation (Dialog(group="Medium"));
  parameter SI.Density d=999.2 "Density" annotation (Dialog(group="Medium"));
  parameter SI.ThermalConductivity lambda=0.5911 "thermal Conductivity"
    annotation (Dialog(group="Medium"));
  parameter SI.HeatCapacity cp=4186 "heat Capacity at constant pressure J/kgK"
    annotation (Dialog(group="Medium"));
equation
  for i in 1:n-1 loop
    // periodical connection of the discretized elements
    connect(uPipeElement[i].portDownOut, uPipeElement[i+1].portDownIn);
    connect(uPipeElement[i].portUpIn, uPipeElement[i+1].portUpOut);
  end for;

  for i in 1:n loop
    // periodical connection of the heat port of each pipeElement
    connect(uPipeElement[i].externalHeatPort, thermalConnectors2Ground[i]);
  end for;

    // connecting the first element to the models in/out-port
    connect(fluidPortIn, uPipeElement[1].portDownIn);
    connect(uPipeElement[1].portUpOut, fluidPortOut);

    // connecting the last element to the deflection
    connect(uPipeElement[n].portDownOut, deflection.port_a);
    connect(deflection.port_b, uPipeElement[n].portUpIn);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-80,-80},
            {80,80}})),           Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-80,-80},{80,80}}), graphics={
        Rectangle(
          extent={{-42,76},{74,-40}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,98},{74,56}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,-30},{10,-50}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-64},{8,-84}},
          pattern=LinePattern.None,
          fillColor={255,255,0},
          fillPattern=FillPattern.Sphere,
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-18,-82},{-18,-66},{6,-82},{6,-66}},
          smooth=Smooth.None,
          color={0,0,0},
          thickness=1),
        Ellipse(
          extent={{-38,96},{70,60}},
          lineColor={0,0,0},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,90},{50,70}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-14,88},{46,72}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-18},{74,-60}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,-16},{74,-38}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-42,-16},{-42,-40}},
          pattern=LinePattern.None,
          smooth=Smooth.None),
        Line(
          points={{74,-16},{74,-40}},
          pattern=LinePattern.None,
          smooth=Smooth.None),
        Line(
          points={{-28,68},{-28,20}},
          color={0,0,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{16,-4},{16,46}},
          color={0,0,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{16,-60},{16,-74}},
          color={0,128,255},
          smooth=Smooth.None,
          thickness=1),
        Line(
          points={{-32,-74},{-20,-74}},
          color={0,128,255},
          smooth=Smooth.None,
          thickness=1),
        Line(
          points={{8,-74},{16,-74}},
          color={0,128,255},
          smooth=Smooth.None,
          thickness=1),
        Line(
          points={{-32,-50},{-32,-74}},
          color={0,128,255},
          smooth=Smooth.None,
          thickness=1),
        Line(
          points={{-28,2},{-28,-46}},
          color={0,0,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{60,68},{60,20}},
          color={0,0,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{60,0},{60,-48}},
          color={0,0,0},
          smooth=Smooth.None,
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-80,-80},{80,-120}},
          lineColor={0,0,0},
          textString="%name")}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview </span></h4>
<p>The model enables the creation of a coaxial pipe borehole heat exchanger that is axially discretized. </p>
<h4><span style=\"color:#008000\">Assumptions </span></h4>
<p>The deflection at the bottom of the heat exchanger is assumed by a hydraulic resistance with the pressure loss coefficient of a 180&deg; pipe bend. </p>
<p>The heat transfer coefficient in the annular gap can be modeled according to different assumptions (see model BaseClasses.HeatTransfer.HeatConv_AnnularGap, VDI-Waermeatlas&nbsp;3.0,&nbsp;2006).</p>
<p>The pressure drop in the annular gap is modeled according to Gnielinski2007. Chose between whole regime (laminar/turbulent) or turbulent regime.</p>
<h4><span style=\"color:#008000\">Known Limitations </span></h4>
<p>A thermal vertical connection between the borehole fillings of the different axial discretization layers is not provided. </p>
<p>The pressure loss coefficient in the deflection has to be given explicitly, it is not calculated from the given geometry. </p>
<h4><span style=\"color:#008000\">References</span></h4>
<p>Source:</p>
<ul>
<li>VDI-Waermeatlas&nbsp;3.0,&nbsp;2006</li>
<li>Bibtex: Gnielinski2007 </li>
</ul>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:<br/>Implemented.</li>
</ul></p>
</html>"));
end CoaxialPipe;
