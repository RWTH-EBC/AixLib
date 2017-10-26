within AixLib.Fluid.FixedResistances;
model Pipe "Discretized DynamicPipe with heat loss to ambient"

  import Modelica.Fluid.Types.ModelStructure;

  outer Modelica.Fluid.System system "System wide properties";

   // Parameters Tab "General"
    replaceable package Medium =
      Modelica.Media.Water.ConstantPropertyLiquidWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);

   parameter Real nParallel = 1 "Number of identical parallel pipes" annotation(Dialog(group = "Geometry"));
   parameter Modelica.SIunits.Length length=1 "Length"
                                           annotation(Dialog(group = "Geometry"));
   parameter Boolean isCircular = true
    "=true if cross sectional area is circular"                                    annotation(Dialog(group = "Geometry"));
   parameter Modelica.SIunits.Diameter diameter=parameterPipe.d_i
   "Diameter of circular pipe"                                annotation(Dialog,   enable = isCircular);
   parameter Modelica.SIunits.Area crossArea=Modelica.Constants.pi*
      diameter*diameter/4 "Inner cross section area"                                                  annotation(Dialog(group = "Geometry"));
   parameter Modelica.SIunits.Length perimeter=Modelica.Constants.pi*
      diameter "Inner perimeter"                                                      annotation(Dialog(group = "Geometry"));
   parameter Modelica.SIunits.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"                                 annotation(Dialog(group = "Geometry"));

   parameter Modelica.SIunits.Length height_ab=0
    "Height(port_b)-Height(port_a)"                                  annotation(Dialog(group = "Static head"));

   replaceable model FlowModel =
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
    constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Wall friction, gravity, momentum flow"
      annotation(Dialog(group="Pressure loss"), choicesAllMatching=true);

    // Parameter Tab "Assumptions"
    parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

    parameter Modelica.Fluid.Types.Dynamics energyDynamics = system.energyDynamics
    "Formulation of energy balances"                                                                 annotation(Dialog(tab="Assumptions", group = "Dynamics"));
    parameter Modelica.Fluid.Types.Dynamics massDynamics = system.massDynamics
    "Formulation of mass balances"                                                             annotation(Dialog(tab="Assumptions", group = "Dynamics"));
    parameter Modelica.Fluid.Types.Dynamics momentumDynamics = system.momentumDynamics
    "Formulation of momentum balances"                                                                     annotation(Dialog(tab="Assumptions", group = "Dynamics"));

    //Parameter Tab "HeatTransfer"
    parameter Boolean Heat_Loss_To_Ambient = false
    "= true to internally simulate heat loss to ambient by convection and radiation"                    annotation(Dialog(tab="Heat transfer"));
    parameter Boolean isEmbedded = false
    "= true if pipe is embedded in a solid material, for example walls "
    annotation(Dialog(tab="Heat transfer"));
    parameter Boolean withInsulation = false
    "= true to use a pipe with insulation"                                            annotation(Dialog(tab="Heat transfer"));

    parameter Boolean use_HeatTransferConvective = true
    "= true to use the convective HeatTransfer model"                                                      annotation(Dialog(tab="Heat transfer"));
    replaceable model HeatTransferConvective =
      Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer (alpha0 = alpha_i)
    constrainedby
    Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    "Wall heat transfer"
      annotation (Dialog(tab="Heat transfer",enable=use_HeatTransfer),choicesAllMatching=true);
    parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_i=1000
    "Heat tranfer coefficient from fluid to pipe wall";
    parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition parameterPipe=
      AixLib.DataBase.Pipes.Copper.Copper_6x1() "Pipe type"
    annotation (choicesAllMatching=true, Dialog(tab="Heat transfer"));
  parameter AixLib.DataBase.Pipes.InsulationBaseDataDefinition parameterIso=
      AixLib.DataBase.Pipes.Insulation.Iso0pc() "Insulation Type"
    annotation (choicesAllMatching=true, Dialog(tab="Heat transfer"));

    parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha=8
    "Heat transfer coefficient to ambient"                      annotation (Dialog(tab="Heat transfer", enable = Heat_Loss_To_Ambient));
    Utilities.HeatTransfer.CylindricHeatTransfer                       PipeWall[nNodes](
    rho=fill(parameterPipe.d, nNodes),
    c=fill(parameterPipe.c, nNodes),
    d_out=fill(parameterPipe.d_o, nNodes),
    d_in=fill(parameterPipe.d_i, nNodes),
    length=fill(length/nNodes, nNodes),
    lambda=fill(parameterPipe.lambda, nNodes),
    T0=fill(T_start, nNodes))
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));

    Utilities.HeatTransfer.CylindricHeatTransfer                       Insulation[nNodes](
    c=fill(parameterIso.c, nNodes),
    d_out=fill(parameterPipe.d_o*parameterIso.factor*2 + parameterPipe.d_o,
        nNodes),
    d_in=fill(parameterPipe.d_o, nNodes),
    length=fill(length/nNodes, nNodes),
    lambda=fill(parameterIso.lambda, nNodes),
    T0=fill(T_start, nNodes),
    rho=fill(parameterIso.d, nNodes)) if withInsulation
    annotation (Placement(transformation(extent={{-20,-8},{0,12}})));

  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = Medium,
    nParallel=nParallel,
    length=length,
    isCircular=isCircular,
    diameter=diameter,
    crossArea=crossArea,
    perimeter=perimeter,
    roughness=roughness,
    height_ab=height_ab,
    redeclare model FlowModel = FlowModel,
    use_HeatTransfer=Heat_Loss_To_Ambient,
    allowFlowReversal=allowFlowReversal,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    use_T_start=use_T_start,
    T_start=T_start,
    h_start=h_start,
    X_start=X_start,
    C_start=C_start,
    momentumDynamics=momentumDynamics,
    m_flow_start=m_flow_start,
    nNodes=nNodes,
    modelStructure=modelStructure,
    useLumpedPressure=useLumpedPressure,
    useInnerPortProperties=useInnerPortProperties,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
        (alpha0=alpha_i))
    annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{94,-46},{114,-26}}),
        iconTransformation(extent={{94,-10},{114,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-114,-46},{-94,-26}}),
        iconTransformation(extent={{-114,-10},{-94,10}})));

    // Parameter Tab "Initialisation"
   parameter Medium.AbsolutePressure p_a_start=system.p_start
    "Start value of pressure at port a"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium.AbsolutePressure p_b_start=p_a_start
    "Start value of pressure at port b"
    annotation(Dialog(tab = "Initialization"));
  parameter Boolean use_T_start=true "Use T_start if true, otherwise h_start"
     annotation(Evaluate=true, Dialog(tab = "Initialization"));

  parameter Medium.Temperature T_start=if use_T_start then system.T_start else
              Medium.temperature_phX(
        (p_a_start + p_b_start)/2,
        h_start,
        X_start) "Start value of temperature"
    annotation(Evaluate=true, Dialog(tab = "Initialization", enable = use_T_start));
  parameter Medium.SpecificEnthalpy h_start=if use_T_start then
        Medium.specificEnthalpy_pTX(
        (p_a_start + p_b_start)/2,
        T_start,
        X_start) else Medium.h_default "Start value of specific enthalpy"
    annotation(Evaluate=true, Dialog(tab = "Initialization", enable = not use_T_start));
  parameter Medium.MassFraction X_start[Medium.nX]=Medium.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium.nXi > 0));
  parameter Medium.ExtraProperty C_start[Medium.nC](
       quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
    "Start value of trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium.nC > 0));
  parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
    "Start value for mass flow rate"
       annotation(Evaluate=true, Dialog(tab = "Initialization"));

    // Parameter Tab "Advanced"
    parameter Integer nNodes(min=2)=2 "Number of discrete flow volumes"
    annotation(Dialog(tab="Advanced"),Evaluate=true);

   parameter Modelica.Fluid.Types.ModelStructure modelStructure=Modelica.Fluid.Types.ModelStructure.av_vb
    "Determines whether flow or volume models are present at the ports"
    annotation(Dialog(tab="Advanced"), Evaluate=true);

  parameter Boolean useLumpedPressure=false
    "=true to lump pressure states together"
    annotation(Dialog(tab="Advanced"),Evaluate=true);
  parameter Boolean useInnerPortProperties=false
    "=true to take port properties for flow models from internal control volumes"
    annotation(Dialog(tab="Advanced"),Evaluate=true);

protected
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts[nNodes]
    annotation (Placement(transformation(extent={{18,38},{58,46}}),
        iconTransformation(extent={{-46,20},{40,38}})));
public
  AixLib.Utilities.HeatTransfer.HeatConv heatConv[nNodes](alpha=fill(alpha,
        nNodes), A=Modelica.Constants.pi*PipeWall.d_out*length/nNodes) if
                                     Heat_Loss_To_Ambient and not withInsulation and not isEmbedded
    "Convection from pipe wall" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={24,26})));
  AixLib.Utilities.HeatTransfer.HeatConv heatConv_withInsulation[nNodes](alpha=
        fill(alpha, nNodes), A=Modelica.Constants.pi*Insulation.d_out*length/
        nNodes) if                   (Heat_Loss_To_Ambient and withInsulation and not isEmbedded)
    "Convection from insulation" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,26})));
  AixLib.Utilities.HeatTransfer.HeatToStar twoStar_RadEx[nNodes](eps=fill(eps,
        nNodes), A=Modelica.Constants.pi*PipeWall.d_out*length/nNodes) if
                                     Heat_Loss_To_Ambient and not isEmbedded
    "Radiation" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-58,28})));
parameter Modelica.SIunits.Emissivity eps = 0.8 "Emissivity"
                                      annotation (Dialog(tab="Heat transfer", enable = Heat_Loss_To_Ambient));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_outside annotation (Placement(transformation(extent={{26,72},
            {46,92}}),
        iconTransformation(extent={{6,46},{26,66}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=nNodes)
                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={36,58})));

  AixLib.Utilities.Interfaces.Star Star if    Heat_Loss_To_Ambient and not isEmbedded
    annotation (Placement(transformation(extent={{-70,74},{-50,94}}),
        iconTransformation(extent={{-24,46},{-4,66}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector_Star(m=nNodes) if
                                     Heat_Loss_To_Ambient and not isEmbedded annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-60,58})));
protected
  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts_Star[nNodes] if Heat_Loss_To_Ambient and not isEmbedded
    annotation (Placement(transformation(extent={{-78,38},{-38,46}}),
        iconTransformation(extent={{-46,20},{40,38}})));
  /*Modelica.Blocks.Math.Sum sum1(nin=n)
    annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
 Modelica.Blocks.Interfaces.RealOutput StoredEnergy
  annotation (Placement(
        transformation(extent={{6,-100},{26,-80}}),     iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,-24})));
 Modelica.Blocks.Interfaces.RealOutput Temperature
  annotation (Placement(
        transformation(extent={{10,-74},{30,-54}}),     iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={90,24})));
        */
equation

  connect(pipe.port_b, port_b) annotation (Line(
      points={{0,-36},{104,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.port_a, port_a) annotation (Line(
      points={{-20,-36},{-104,-36}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe.heatPorts,PipeWall.port_a);
  connect(heatPorts, thermalCollector.port_a);
  connect(heatPort_outside, thermalCollector.port_b);

        //Connect pipe wall or insulation to the outside.

        //Pipe: embedded, with heat losses, without insulation
        if (isEmbedded and Heat_Loss_To_Ambient and not withInsulation) then
        connect(PipeWall.port_b,heatPorts);

        //Pipe: embedded, with heat losses, with insulation
        elseif (isEmbedded and Heat_Loss_To_Ambient and withInsulation) then
        connect(PipeWall.port_b,Insulation.port_a);
        connect(Insulation.port_b,  heatPorts);

        //Pipe: not embedded, with heat losses, with insulation
        elseif (withInsulation and Heat_Loss_To_Ambient and not isEmbedded) then
        connect(PipeWall.port_b,Insulation.port_a);
        connect(Insulation.port_b,  heatConv_withInsulation.port_b);
        connect(heatConv_withInsulation.port_a, heatPorts);
        connect(heatPorts,thermalCollector.port_a);
        connect(thermalCollector.port_b,heatPort_outside);
        connect(Insulation.port_b, twoStar_RadEx.Therm);
        connect(twoStar_RadEx.Star, heatPorts_Star);
        connect(heatPorts_Star, thermalCollector_Star.port_a);
        connect(thermalCollector_Star.port_b, Star);

        //Pipe: not embedded, with heat losses, without insulation
        elseif
              (Heat_Loss_To_Ambient and not withInsulation and not isEmbedded) then
        connect(PipeWall.port_b,heatConv.port_b);
        connect(heatConv.port_a, heatPorts);
        connect(heatPorts,thermalCollector.port_a);
        connect(thermalCollector.port_b,heatPort_outside);
        connect(PipeWall.port_b, twoStar_RadEx.Therm);
        connect(twoStar_RadEx.Star, heatPorts_Star);
        connect(heatPorts_Star, thermalCollector_Star.port_a);
        connect(thermalCollector_Star.port_b, Star);

        else
        connect(PipeWall.port_b,  heatPorts);
        end if;

  /*connect(sum1.y,StoredEnergy)  annotation (Line(
      points={{1,-90},{16,-90}},
      color={0,0,127},
      smooth=Smooth.None));
      */
  annotation (                   Icon(graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-76,14},{-56,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0}),
        Ellipse(
          extent={{56,14},{76,-10}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0}),
        Text(
          extent={{-40,14},{40,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0},
          textString="%nNodes")}),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Dynamic Pipe with pipe wall and insulation wall which allows discretisation of pipe wall and pipe insulation. This model considers heat loss through radiation and convection if pipe is not embedded in wall. In case that the pipe is embedded in the wall, heat transfer between the pipe wall / insulation and the surrounding material is based on heat conduction.</p>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p>Dynamic pipe model with heat losses for various applications. It is possible to choose whether the pipe is embedded in a wall or not. In addition, no insulation can be selected, if used for example for CCA ( concrete core activation).</p>
<p>The model already includes heat-transfer by convection and by radiation. Instead of modeling these phenomena outside the pipe, an ambient temperature can be prescribed at the heat-port and the star of the pipe, so the loss to ambient will be calculated within the pipe model.</p>
<p>For each discretisation of the pipe, there is a connector to the corresponding element of the discretized pipe wall. Each element of the discretised pipe wall is connected to a corresponding element of the discretized insulation wall. The heat-ports and stars of all nodes are then collected to form two single ports, which can be connected to an ambient temperature.</p>
<h4><span style=\"color: #008000\">Example Results</span></h4>
<p><a href=\"AixLib.Fluid.FixedResistances.Examples.DPEAgg_ambientLoss\">AixLib.Fluid.FixedResistances.Examples.DPEAgg_ambientLoss</a></p>
</html>",
        revisions="<html>
<ul>
<li><i>April 25, 2017 </i>by Tobias Blacha:<br/>
Parameter isEmbedded added and correction of connections for different applications</li>
<li><i>April 25, 2017 </i>by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>March 18, 2015 </i>by Roozbeh Sangi:<br/>
Outputs for stored energy and temperature added</li>
<li><i>November 26, 2014&nbsp;</i> by Roozbeh Sangi:<br/>
Updated connectors to EBC Library 2.2, Updated documentation, Added example</li>
<li><i>May 19, 2014&nbsp;</i> by Roozbeh Sangi:<br/>
Added to the HVAC library</li>
<li><i>November 13, 2013&nbsp;</i> by Ole Odendahl:<br/>
Formatted documentation appropriately</li>
<li><i>August 3, 2011</i> by Ana Constantin:<br/>
Implemented</li>
</ul>
</html>"));
end Pipe;
