within AixLib.FastHVAC.Components.Storage.BaseClasses;
model HeatingCoilFouling

 parameter Integer dis_HC = 2;

 parameter Media.BaseClasses.MediumSimple medium_HC=Media.WaterSimple()
    "Mediums charastics  (heat capacity, density, thermal conductivity)";

 parameter Modelica.SIunits.Length length_HC = 3 "Length of Pipe for HC";

 parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_HC=20
    "Model assumptions Coefficient of Heat Transfer HC <-> Heating Water";

 parameter Modelica.SIunits.Temperature T_start_HC "Start Temperature of fluid";

 parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipe_HC=
      AixLib.DataBase.Pipes.Copper.Copper_28x1() "Type of Pipe for HR1";

  parameter Modelica.SIunits.ThermalConductivity lambda_film=1.06
    "Heat conductivity of the biofilm";
  parameter Modelica.SIunits.Velocity v_bio_grow = 3.617E-09
    "Growing velocity of biofilm in m/s";
  parameter Modelica.SIunits.Velocity v_bio_clean = 8.3E-06
    "Cleaning velocity of biofilm in m/s";
  parameter Modelica.SIunits.Length s_biofilm_max = 0.005
    "Thikness of biofilm, when cleaning will be started";
  parameter Modelica.SIunits.Length s_biofilm_min = 0.0005
    "Thikness of biofilm, when cleaning will be started";
  parameter Modelica.SIunits.Length s_biofilm_0 = 0.0001
    "Thikness of biofilm at simulation start";

  FastHVAC.Components.Pipes.BaseClasses.PipeBase pipeHC(
    medium=medium_HC,
    parameterPipe=pipe_HC,
    length=length_HC,
    nNodes=dis_HC,
    T_0=T_start_HC)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-4,0})));

  AixLib.Utilities.HeatTransfer.HeatConv conv_HC1_Outside[dis_HC](each alpha=
        alpha_HC, A=fill(pipe_HC.d_o*Modelica.Constants.pi*length_HC/dis_HC,
        dis_HC)) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-4,86})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm1[dis_HC]
    annotation (Placement(transformation(extent={{-14,94},{6,114}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1
    annotation (Placement(transformation(extent={{82,-10},{102,10}})));
  AixLib.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1
    annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
  Utilities.HeatTransfer.HeatConvPipe_inside conv_HC1_Inside[dis_HC](
    d_i=fill(pipe_HC.d_i, dis_HC),
    d_a=fill(pipe_HC.d_o, dis_HC),
    A_sur=fill(pipe_HC.d_o*Modelica.Constants.pi*length_HC/dis_HC, dis_HC),
    length=fill(length_HC, dis_HC))    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-4,20})));
  Sensors.MassFlowSensor m_flow
    annotation (Placement(transformation(extent={{38,-10},{58,10}})));
  Utilities.HeatTransfer.CylindricHeatConduction_fouling
    cylindricHeatConduction_fouling[dis_HC](
    v_bio_grow=fill(v_bio_grow, dis_HC),
    lambda_film=fill(lambda_film, dis_HC),
    d_out=fill(pipe_HC.d_o, dis_HC),
    length=fill(length_HC/dis_HC, dis_HC),
    v_bio_clean=fill(v_bio_clean, dis_HC),
    s_biofilm_max=fill(s_biofilm_max, dis_HC),
    s_biofilm_min=fill(s_biofilm_min, dis_HC),
    s_biofilm_0=fill(s_biofilm_0, dis_HC))
    annotation (Placement(transformation(extent={{-14,58},{6,78}})));
  Utilities.HeatTransfer.CylindricHeatTransfer cylindricHeatTransfer[dis_HC](
    rho=fill(pipe_HC.d, dis_HC),
    c=fill(pipe_HC.c, dis_HC),
    d_out=fill(pipe_HC.d_o, dis_HC),
    d_in=fill(pipe_HC.d_i, dis_HC),
    length=fill(length_HC/dis_HC, dis_HC),
    lambda=fill(pipe_HC.lambda, dis_HC),
    T0=fill(T_start_HC, dis_HC))
    annotation (Placement(transformation(extent={{-14,34},{6,54}})));
  Modelica.Blocks.Interfaces.RealOutput s_biofilm
    annotation (Placement(transformation(extent={{98,56},{118,76}})));
  Modelica.Blocks.Interfaces.BooleanInput biofilm_removing
    annotation (Placement(transformation(extent={{-124,46},{-84,86}})));
equation

    for i in 1:dis_HC loop
      connect(m_flow.dotm, conv_HC1_Inside[i].m_flow);
      connect(biofilm_removing,cylindricHeatConduction_fouling[i].biofilm_removing);
    end for;
  connect(conv_HC1_Outside.port_a, Therm1) annotation (Line(
      points={{-4,92},{-4,104}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeHC.enthalpyPort_a1, enthalpyPort_a1) annotation (Line(
      points={{-13.8,0},{-96,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeHC.heatPorts, conv_HC1_Inside.port_b)
    annotation (Line(points={{-4.1,4.9},{-4.1,10},{-4,10}}, color={127,0,0}));
  connect(pipeHC.enthalpyPort_b1, m_flow.enthalpyPort_a)
    annotation (Line(points={{5.8,0},{39.2,0},{39.2,-0.1}}, color={176,0,0}));
  connect(m_flow.enthalpyPort_b, enthalpyPort_b1) annotation (Line(points={{57,
          -0.1},{74.5,-0.1},{74.5,0},{92,0}}, color={176,0,0}));
  connect(conv_HC1_Inside.port_a, cylindricHeatTransfer.port_a) annotation (
      Line(points={{-4,30},{-4,30},{-4,44}},         color={191,0,0}));
  connect(conv_HC1_Outside.port_b, cylindricHeatConduction_fouling.port_b)
    annotation (Line(points={{-4,80},{-4,76.8}}, color={191,0,0}));
  connect(cylindricHeatTransfer.port_b, cylindricHeatConduction_fouling.port_a)
    annotation (Line(points={{-4,52.8},{-4,52.8},{-4,68.4}}, color={191,0,0}));
  connect(cylindricHeatConduction_fouling[1].s_biofilm, s_biofilm) annotation (
      Line(points={{5.2,68.2},{53.6,68.2},{53.6,66},{108,66}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={
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
end HeatingCoilFouling;
