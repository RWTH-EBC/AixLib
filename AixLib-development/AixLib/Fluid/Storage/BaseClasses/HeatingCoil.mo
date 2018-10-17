within AixLib.Fluid.Storage.BaseClasses;
model HeatingCoil "Heating coil for heat storage model"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

 parameter Integer disHC = 2 "Number of elements for heating coil discretization";

 parameter Modelica.SIunits.Length lengthHC = 3 "Length of Pipe for HC";

 parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaHC=20
    "Model assumptions Coefficient of Heat Transfer HC <-> Heating Water";

 parameter Modelica.SIunits.Temperature TStart=298.15
    "Start Temperature of fluid" annotation(Dialog(group = "Initialization"));

 parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeHC=
      AixLib.DataBase.Pipes.Copper.Copper_28x1() "Type of Pipe for HC";

 AixLib.Utilities.HeatTransfer.CylindricHeatTransfer pipeWallHC1[disHC](
    each T0=TStart,
    rho=fill(pipeHC.d, disHC),
    c=fill(pipeHC.c, disHC),
    d_out=fill(pipeHC.d_o, disHC),
    d_in=fill(pipeHC.d_i, disHC),
    length=fill(lengthHC/disHC, disHC),
    lambda=fill(pipeHC.lambda, disHC))
    "Heat transfer of pipe wall" annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-4,26})));
  AixLib.Utilities.HeatTransfer.HeatConv convHC1Outside[disHC](each alpha=
    alphaHC, A=fill(pipeHC.d_o*Modelica.Constants.pi*lengthHC/disHC,
    disHC))
    "Outer heat convection" annotation (Placement(transformation(
    extent={{-6,-6},{6,6}},
    rotation=270,
    origin={-4,52})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm1[disHC]
    "Vectorized heat port"
    annotation (Placement(transformation(extent={{-14,94},{6,114}})));
Modelica.Fluid.Pipes.DynamicPipe pipe(
use_HeatTransfer=true,
    modelStructure=Modelica.Fluid.Types.ModelStructure.a_v_b,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer,
    length=lengthHC,
    diameter=pipeHC.d_i,
    nNodes=disHC,
    redeclare package Medium = Medium)                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-4,0})));

equation


  connect(convHC1Outside.port_a, Therm1) annotation (Line(
      points={{-4,58},{-4,70.7},{-4,70.7},{-4,104}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeWallHC1.port_b,convHC1Outside.port_b)  annotation (Line(
      points={{-4,31.28},{-4,46}},
      color={191,0,0},
      smooth=Smooth.None));


  connect(pipe.heatPorts, pipeWallHC1.port_a) annotation (Line(points={{-3.9,4.4},
          {-3.9,15.2},{-4,15.2},{-4,26}}, color={127,0,0}));
  connect(port_a, pipe.port_a)
    annotation (Line(points={{-100,0},{-57,0},{-14,0}}, color={0,127,255}));
  connect(pipe.port_b, port_b)
    annotation (Line(points={{6,0},{54,0},{100,0}}, color={0,127,255}));
  annotation (                   Icon(graphics={
        Line(
          points={{-94,0},{-80,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-60,-80},{-80,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-10,-80},{10,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1,
          origin={-50,0},
          rotation=180),
        Line(
          points={{-10,-80},{10,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1,
          origin={-10,0},
          rotation=180),
        Line(
          points={{-20,-80},{-40,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-10,-80},{10,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1,
          origin={30,0},
          rotation=180),
        Line(
          points={{20,-80},{0,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{-10,-80},{10,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1,
          origin={70,0},
          rotation=180),
        Line(
          points={{60,-80},{40,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1),
        Line(
          points={{94,0},{80,80}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier,
          visible = use_heatingCoil1)}),
    Documentation(info="<html>
<h4><font color=\"#008000\">Overview</font></h4>
<p>Model of a heating coil to heat a fluid (e.g. water) by a given input on the
heat port.</p>
<h4><font color=\"#008000\">Concept</font></h4>
<p>The heating coil is implemented as a pipe which is going through the storage
tank. The heat transfer to the storage tank is modelled with a heat transfer
coefficient.</p>
</html>",
      revisions="<html>
<ul>
<li><i>October 12, 2016&nbsp;</i> by Marcus Fuchs:<br/>Add comments and fix documentation</li>
<li><i>October 11, 2016&nbsp;</i> by Sebastian Stinner:<br/>Added to AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>October 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>
"));
end HeatingCoil;
