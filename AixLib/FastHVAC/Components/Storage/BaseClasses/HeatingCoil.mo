within AixLib.FastHVAC.Components.Storage.BaseClasses;
model HeatingCoil


 parameter Integer dis_HC = 2;

  parameter Media.BaseClasses.MediumSimple medium_HC=Media.WaterSimple()
    "Mediums charastics  (heat capacity, density, thermal conductivity)";

 parameter Modelica.SIunits.Length length_HC = 3 "Length of Pipe for HC";

 parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_HC=20
    "Model assumptions Coefficient of Heat Transfer HC <-> Heating Water";

  parameter Modelica.SIunits.Temperature T_start "Start Temperature of fluid";

 parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipe_HC=
      AixLib.DataBase.Pipes.Copper.Copper_28x1() "Type of Pipe for HR1";

  FastHVAC.Components.Pipes.BaseClasses.PipeBase pipeHC(
    medium=medium_HC,
    parameterPipe=pipe_HC,
    T_0=T_start,
    length=length_HC,
    nNodes=dis_HC) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-4,0})));

    Utilities.HeatTransfer.CylindricHeatTransfer                       PipeWall_HC1[dis_HC](
    each T0=T_start,
    rho=fill(pipe_HC.d, dis_HC),
    c=fill(pipe_HC.c, dis_HC),
    d_out=fill(pipe_HC.d_o, dis_HC),
    d_in=fill(pipe_HC.d_i, dis_HC),
    length=fill(length_HC/dis_HC, dis_HC),
    lambda=fill(pipe_HC.lambda, dis_HC)) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-4,26})));
  AixLib.Utilities.HeatTransfer.HeatConv conv_HC1_Outside[dis_HC](each alpha=
        alpha_HC, A=fill(pipe_HC.d_o*Modelica.Constants.pi*length_HC/dis_HC,
        dis_HC)) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-4,52})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm1[dis_HC]
    annotation (Placement(transformation(extent={{-14,94},{6,114}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1
    annotation (Placement(transformation(extent={{82,-10},{102,10}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1
    annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
equation
  connect(conv_HC1_Outside.port_a, Therm1) annotation (Line(
      points={{-4,58},{-4,104}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(PipeWall_HC1.port_b,conv_HC1_Outside.port_b)  annotation (Line(
      points={{-4,31.28},{-4,46}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(PipeWall_HC1.port_a, pipeHC.heatPorts) annotation (Line(
      points={{-4,26},{-4,4.9},{-4.1,4.9}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeHC.enthalpyPort_b1, enthalpyPort_b1) annotation (Line(
      points={{5.8,0},{92,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeHC.enthalpyPort_a1, enthalpyPort_a1) annotation (Line(
      points={{-13.8,0},{-96,0}},
      color={176,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(graphics={
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
<li><i>December 20, 2016&nbsp; </i> Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>February 10, 2015&nbsp;</i> by Konstantin Finkbeiner:<br>Addapted to FastHVAC.</li>
<li><i>October 2, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>

</ul></p>
</html>
"));
end HeatingCoil;
