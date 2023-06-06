within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses;
model HeatingCoil

 parameter Integer dis_HC(min=1);

  parameter Media.BaseClasses.MediumSimple medium_HC=Media.WaterSimple()
    "Mediums charastics  (heat capacity, density, thermal conductivity)";

  parameter Modelica.Units.SI.Length lengthHC=3 "Length of Pipe for HC";

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConHC=20
    "Model assumptions heat transfer coefficient HC <-> Heating Water";

  parameter Modelica.Units.SI.Temperature T_start "Start Temperature of fluid";

 parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition pipeRecordHC=
      AixLib.DataBase.Pipes.Copper.Copper_28x1() "Type of Pipe for HR1";

  FastHVAC.Components.Pipes.BaseClasses.PipeBase pipeHC(
    medium=medium_HC,
    parameterPipe=pipeRecordHC,
    T_0=T_start,
    length=lengthHC,
    nNodes=dis_HC,
    hConIn_const=hConIn_const,
    calcHCon=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-2,0})));
  AixLib.Utilities.HeatTransfer.CylindricHeatTransfer PipeWall_HC1[dis_HC](
    each T0=T_start,
    rho=fill(pipeRecordHC.d, dis_HC),
    c=fill(pipeRecordHC.c, dis_HC),
    d_out=fill(pipeRecordHC.d_o, dis_HC),
    d_in=fill(pipeRecordHC.d_i, dis_HC),
    length=fill(lengthHC/dis_HC, dis_HC),
    lambda=fill(pipeRecordHC.lambda, dis_HC)) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-2,50})));

  AixLib.Utilities.HeatTransfer.HeatConv conv_HC1_Outside[dis_HC](each hCon=hConHC, A=fill(pipeRecordHC.d_o*Modelica.Constants.pi*lengthHC/
        dis_HC, dis_HC)) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-2,76})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm1[dis_HC]
    annotation (Placement(transformation(extent={{-12,94},{8,114}})));
  AixLib.Obsolete.YearIndependent.FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b1
    annotation (Placement(transformation(extent={{82,-10},{102,10}})));
  AixLib.Obsolete.YearIndependent.FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a1
    annotation (Placement(transformation(extent={{-106,-10},{-86,10}})));
  parameter Boolean calcHCon=true "Use calculated value for inside heat transfer coefficient";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hConIn_const=30
    "Fix value for heat transfer coefficient inside pipe"
    annotation (Dialog(enable=not calcHCon));
equation
  connect(conv_HC1_Outside.port_a, Therm1) annotation (Line(
      points={{-2,82},{-2,104}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(PipeWall_HC1.port_b,conv_HC1_Outside.port_b)  annotation (Line(
      points={{-2,55.28},{-2,70}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipeHC.enthalpyPort_a1, enthalpyPort_a1) annotation (Line(
      points={{-11.8,0},{-96,0}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(pipeHC.enthalpyPort_b1, enthalpyPort_b1)
    annotation (Line(points={{7.8,0},{92,0}}, color={176,0,0}));
  connect(pipeHC.heatPorts, PipeWall_HC1.port_a) annotation (Line(points={{-2.1,
          4.9},{-2.1,27.45},{-2,27.45},{-2,50}}, color={127,0,0}));
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
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model of a heating coil to heat a fluid (e.g. water) by a given input
  on the heat port.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The heating coil is implemented as a pipe which is going through the
  storage tank. The heat transfer to the storage tank is modelled with
  a heat transfer coefficient.
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>December 20, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 10, 2015&#160;</i> by Konstantin Finkbeiner:<br/>
    Addapted to FastHVAC.
  </li>
  <li>
    <i>October 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>
"));
end HeatingCoil;
