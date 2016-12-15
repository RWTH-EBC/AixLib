within AixLib.Fluid.Storage.BaseClasses;
model HeatingCoil
  //import DataBase;
  //import HVAC;

 parameter Integer dis_HC = 2;

 parameter Modelica.SIunits.Length Length_HC = 3 "Length of Pipe for HC";

 parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_HC=20
    "Model assumptions Coefficient of Heat Transfer HC <-> Heating Water";

 outer parameter Modelica.SIunits.Temperature T_start=298.15
    "Start Temperature of fluid";

 parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition Pipe_HC=
      AixLib.DataBase.Pipes.Copper.Copper_28x1() "Type of Pipe for HR1";

  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

    Utilities.HeatTransfer.CylindricHeatTransfer                       PipeWall_HC1[dis_HC](
    each T0=T_start,
    rho=fill(Pipe_HC.d, dis_HC),
    c=fill(Pipe_HC.c, dis_HC),
    d_out=fill(Pipe_HC.d_o, dis_HC),
    d_in=fill(Pipe_HC.d_i, dis_HC),
    length=fill(Length_HC/dis_HC, dis_HC),
    lambda=fill(Pipe_HC.lambda, dis_HC)) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-4,26})));
  AixLib.Utilities.HeatTransfer.HeatConv conv_HC1_Outside[dis_HC](each alpha=
        alpha_HC, A=fill(Pipe_HC.d_o*Modelica.Constants.pi*Length_HC/dis_HC,
        dis_HC)) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-4,52})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm1[dis_HC]
    annotation (Placement(transformation(extent={{-14,94},{6,114}})));
  FixedResistances.Pipe pipe[dis_HC](D=Pipe_HC.d_i,
    m_flow_small=1e-5,
    l=Length_HC/dis_HC)
    annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
equation
  for k in 1:dis_HC-1 loop
    connect(pipe[k].port_b,pipe[k+1].port_a);
  end for;

  connect(conv_HC1_Outside.port_a, Therm1) annotation (Line(
      points={{-4,58},{-4,70.7},{-4,70.7},{-4,104}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(PipeWall_HC1.port_b,conv_HC1_Outside.port_b)  annotation (Line(
      points={{-4,31.28},{-4,46}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipe.heatport, PipeWall_HC1.port_a)
    annotation (Line(points={{-4,5},{-4,26}},         color={191,0,0}));
  connect(pipe[1].port_a, port_a)
    annotation (Line(points={{-14,0},{-100,0}},          color={0,127,255}));
  connect(pipe[dis_HC].port_b, port_b)
    annotation (Line(points={{6,0},{100,0}},         color={0,127,255}));
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
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Model of a heating coil to heat a fluid (e.g. water) by a given input on the heat port.</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/> </p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The heating coil is implemented as a pipe which is going through the storage tank. The heat transfer to the storage tank is modelled with a heat transfer coefficient.</p>
</html>",
      revisions="<html>
<p><ul>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>October 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>
"));
end HeatingCoil;
