within AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses;
model CoaxialPipeElement
  "Heat capacity distributed. Small inner part inside of pipes, rest outward up until boreholeDiameter"
  import SI = Modelica.SIunits;

  /// Model parameters ///
    // General
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Used medium"                                                                      annotation (Dialog(group="General"), choicesAllMatching=true);
    parameter SI.Temperature T_start "Initial Temperature of system" annotation (Dialog(group="General"));

    // Borehole
parameter SI.Diameter boreholeDiameter = 0.135 "Diameter of borehole" annotation(Dialog(group="Borehole"));
  // outer pipe
  parameter SI.Diameter d_i_outerPipe=0.2 "inner diameter of outer pipe" annotation (Dialog(group="Outer pipe"));
  parameter SI.Diameter d_o_outerPipe=0.21 "outer diameter of outer pipe" annotation (Dialog(group="Outer pipe"));

    parameter SI.Density fillingDensity = fillingDensity
    "Density of borehole filling"                                                      annotation(Dialog(group="Borehole"));
    parameter SI.SpecificHeatCapacity fillingHeatCapacity = fillingHeatCapacity
    "Specific heatcapacity of borehole filling"                                                              annotation(Dialog(group="Borehole"));
    parameter SI.ThermalConductivity fillingThermalConductivity = fillingThermalConductivity
    "Thermal conductivity of borehole filling"                                                                   annotation(Dialog(group="Borehole"));

    // Pipes
    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition innerPipeType = AixLib.DataBase.Pipes.DIN_EN_10255.DIN_EN_10255_DN10()
    "Type of inner pipe" annotation (Dialog(group="Inner pipe"), choicesAllMatching=true);
    //parameter Integer nParallel = 2 "1: U-Pipe, 2: Double-U-Pipe" annotation (Dialog(group="Pipes"));
    parameter SI.Length length = 1 "Length of the pipe element";

    // Implicit values

    Real pi = Modelica.Constants.pi;

  /// Object Generation ///
  FixedResistances.Pipe                 innerPipeDown(
    redeclare package Medium = Medium,
    length=length,
    diameter=innerPipeType.d_i,
    use_HeatTransferConvective=true,
    parameterIso=AixLib.DataBase.Pipes.Insulation.Iso0pc(),
    T_start=T_start,
    nNodes=2,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    parameterPipe=innerPipeType,
    nParallel=1,
    height_ab=length) annotation (Placement(transformation(
        extent={{24,24},{-24,-24}},
        rotation=-90,
        origin={40,46})));

  Modelica.Fluid.Pipes.DynamicPipe
                        outerPipeUp(
    redeclare package Medium = Medium,
    each length=length,
    T_start=T_start,
    nNodes=2,
    modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    isCircular=false,
    each height_ab=0,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=0, m_flow_nominal=1),
    crossArea=Modelica.Constants.pi/4*(d_i_outerPipe*d_i_outerPipe -
        innerPipeType.d_o*innerPipeType.d_o),
    perimeter=Modelica.Constants.pi*(innerPipeType.d_o + d_i_outerPipe),
    nParallel=1,
    diameter=1)                            annotation (Placement(transformation(
        extent={{24,-24},{-24,24}},
        rotation=90,
        origin={-60,46})));

  Modelica.Fluid.Interfaces.FluidPort_a portDownIn(redeclare package Medium =
        Medium) "Inlet FluidPort of the downgoing pipe of the U-Pipe-Element"                                        annotation (Placement(transformation(extent={{-70,90},
            {-50,110}}),
                       iconTransformation(extent={{-40,80},{-20,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b portUpOut(redeclare package Medium =
        Medium) "Outlet FluidPort of the upgoing pipe of the U-Pipe-Element"                                          annotation (Placement(transformation(extent={{0,80},{
            20,100}}),
        iconTransformation(extent={{0,80},{20,100}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a externalHeatPort
    annotation (Placement(transformation(extent={{-124,70},{-104,90}}),
        iconTransformation(extent={{-80,40},{-60,60}})));

  Modelica.Fluid.Interfaces.FluidPort_a portUpIn(redeclare package Medium =
        Medium) "Inlet FluidPort of the upgoing pipe of the U-Pipe-Element"
    annotation (Placement(transformation(extent={{30,-30},{50,-10}}),
        iconTransformation(extent={{0,-20},{20,0}})));
  Modelica.Fluid.Interfaces.FluidPort_b portDownOut(redeclare package Medium =
        Medium) "Outlet FluidPort of the downgoing pipe of the U-Pipe-Element"
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}}),
        iconTransformation(extent={{-40,-20},{-20,0}})));
  AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss.WallFrictionAndGravity_AnnularGap
    pipe(
    redeclare package Medium = Medium,
    redeclare function delta_p = delta_p_AnnularGap,
    length=length,
    d_in=innerPipeType.d_o,
    d_ou=d_i_outerPipe,
    height_ab=-length) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-50,2})));
  AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.HeatConv_AnnularGap heatConv_AnnularGapInside(
    redeclare function alpha = alpha_AnnularGapInside,
    d_i=innerPipeType.d_o,
    d_o=d_i_outerPipe,
    L=length,
    eta=eta,
    d=d,
    lambda=lambda,
    cp=cp) annotation (Placement(transformation(extent={{-6,38},{14,58}})));
  AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.HeatConv_AnnularGap heatConv_AnnularGapOutside(
    redeclare function alpha = alpha_AnnularGapOutside,
    d_i=innerPipeType.d_o,
    d_o=d_i_outerPipe,
    L=length,
    eta=eta,
    d=d,
    lambda=lambda,
    cp=cp) annotation (Placement(transformation(extent={{-82,36},{-102,56}})));

  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer HeatTransferOuterPipe(
    T0=T_start,
    length=length,
    rho=rho_OuterPipe,
    c=c_OuterPipe,
    d_out=d_o_outerPipe,
    d_in=d_i_outerPipe,
    lambda=lambda_outerPipe)
    "Heat transfer from the pipes towards the borehole outside"
    annotation (Placement(transformation(extent={{-118,46},{-98,66}})));
  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer HeatTransferBackfill(
    rho=fillingDensity,
    c=fillingHeatCapacity,
    d_out=boreholeDiameter,
    lambda=fillingThermalConductivity,
    T0=T_start,
    length=length,
    d_in=d_o_outerPipe)
    "Heat transfer from the pipes towards the borehole outside"
    annotation (Placement(transformation(extent={{-104,66},{-84,86}})));
  parameter SI.ThermalConductivity lambda_outerPipe=373
    "Heat conductivity of pipe" annotation (Dialog(group="Outer pipe"));
  parameter SI.SpecificHeatCapacity c_OuterPipe=1000
    annotation (Dialog(group="Outer pipe"));
  parameter SI.Density rho_OuterPipe=1600
    annotation (Dialog(group="Outer pipe"));
  replaceable function alpha_AnnularGapInside =
      AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alphaAnnular1
    constrainedby
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alpha_partial
      annotation (__Dymola_choicesAllMatching=true);
  replaceable function alpha_AnnularGapOutside =
      AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alphaAnnular1
    constrainedby
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.HeatTransfer.AnnularGap.alpha_partial
      annotation (__Dymola_choicesAllMatching=true);
  replaceable function delta_p_AnnularGap =
      AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss.delta_pAnnularGap
    constrainedby
    AixLib.Fluid.HeatExchangers.Geothermal.BaseClasses.PressureLoss.delta_p_partial
      annotation (__Dymola_choicesAllMatching=true);
  Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-50,86})));
  parameter SI.DynamicViscosity eta=1139.0*10e-6 "Dynamic Viscosity"
    annotation (Dialog(group="Medium"));
  parameter SI.Density d=999.2 "Density" annotation (Dialog(group="Medium"));
  parameter SI.ThermalConductivity lambda=0.5911 "thermal Conductivity"
    annotation (Dialog(group="Medium"));
  parameter SI.HeatCapacity cp=4186 "heat Capacity at constant pressure J/kgK"
    annotation (Dialog(group="Medium"));
equation

  connect(heatConv_AnnularGapInside.port_b, innerPipeDown.heatPort_outside)
                                                                   annotation (
      Line(
      points={{13.2,48},{18,48},{18,49.84},{26.56,49.84}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(outerPipeUp.heatPorts[1], heatConv_AnnularGapInside.port_a)
                                                             annotation (Line(
      points={{-70.56,49.48},{-52,49.48},{-52,48},{-5.2,48}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(outerPipeUp.heatPorts[2], heatConv_AnnularGapInside.port_a)
                                                             annotation (Line(
      points={{-70.56,42.04},{-52,42.04},{-52,48},{-5.2,48}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(heatConv_AnnularGapOutside.port_a, outerPipeUp.heatPorts[1])
                                                                 annotation (
      Line(
      points={{-82.8,46},{-76,46},{-76,49.48},{-70.56,49.48}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatConv_AnnularGapOutside.port_a, outerPipeUp.heatPorts[2])
                                                                 annotation (
      Line(
      points={{-82.8,46},{-78.5,46},{-78.5,42.04},{-70.56,42.04}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatConv_AnnularGapOutside.port_b,HeatTransferOuterPipe.port_a)
    annotation (Line(
      points={{-101.2,46},{-108,46},{-108,56}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(HeatTransferOuterPipe.port_b,HeatTransferBackfill.port_a)
    annotation (Line(
      points={{-108,64.8},{-102,64.8},{-102,66},{-96,66},{-96,76},{-94,76}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(HeatTransferBackfill.port_b, externalHeatPort) annotation (Line(
      points={{-94,84.8},{-100,84.8},{-100,80},{-114,80}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(massFlowRate.port_b, outerPipeUp.port_a) annotation (Line(
      points={{-50,76},{-52,76},{-52,70},{-60,70}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(massFlowRate.m_flow, heatConv_AnnularGapOutside.m_flow)
    annotation (Line(
      points={{-61,86},{-78,86},{-78,64},{-92,64},{-92,54}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(massFlowRate.m_flow, heatConv_AnnularGapInside.m_flow)
    annotation (Line(
      points={{-61,86},{0,86},{0,56},{4,56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(innerPipeDown.port_a, portUpIn) annotation (Line(
      points={{40,21.04},{40,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(innerPipeDown.port_b, portUpOut) annotation (Line(
      points={{40,70.96},{40,90},{10,90}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(outerPipeUp.port_b, pipe.port_a) annotation (Line(
      points={{-60,22},{-54,22},{-54,12},{-50,12}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.port_b, portDownOut) annotation (Line(
      points={{-50,-8},{-50,-20},{-60,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(massFlowRate.port_a, portDownIn) annotation (Line(
      points={{-50,96},{-52,96},{-52,100},{-60,100}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-120,
            -20},{80,100}},
        initialScale=0.2), graphics),
                                   Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-120,-20},{80,100}},
        initialScale=0.2), graphics={
        Rectangle(
          extent={{0,80},{20,0}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={47,51,253}),
        Rectangle(
          extent={{-40,80},{-20,0}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={47,51,253}),
        Rectangle(
          extent={{40,80},{60,0}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={47,51,253}),
        Ellipse(extent={{-60,100},{80,60}}, lineColor={0,0,0}),
        Ellipse(extent={{-60,20},{80,-18}}, lineColor={0,0,0}),
        Line(
          points={{-60,80},{-60,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{80,80},{80,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Ellipse(extent={{-20,86},{40,74}}, lineColor={0,0,0}),
        Ellipse(extent={{-20,6},{40,-6}}, lineColor={0,0,0}),
        Ellipse(extent={{-40,90},{60,70}}, lineColor={0,0,0}),
        Ellipse(extent={{-40,10},{60,-10}}, lineColor={0,0,0}),
        Ellipse(extent={{0,82},{20,78}},   lineColor={0,0,0})}),
    Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This submodel is used to create an axially discretized model of a coaxial pipe borehole heat exchanger </p>
<p>Please see <a href=\"AixLib.Fluid.HeatExchangers.Geothermal.BoreHoleHeatExchanger.CoaxialPipe\">CoaxialPipe</a> model for further explanation</p>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>January 10, 2014&nbsp;</i> by Kristian Huchtemann:<br/>Implemented.</li>
</ul></p>
</html>"));
end CoaxialPipeElement;
