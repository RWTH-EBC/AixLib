within AixLib.Fluid.HeatExchangers.ActiveWalls;
package PanelHeatingNew
  model PanelHeating
    "A panel heating for e.g. floor heating with discretization"

    extends Modelica.Fluid.Interfaces.PartialTwoPort;

       parameter AixLib.DataBase.ActiveWalls.ActiveWallBaseDataDefinition floorHeatingType=
        DataBase.ActiveWalls.JocoKlimaBodenTOP2000_Parkett()
      annotation (Dialog(group="Type"), choicesAllMatching=true);

    parameter Boolean isFloor =  true "Floor or Ceiling heating"
      annotation(Dialog(compact = true, descriptionLabel = true), choices(
        choice = true "Floorheating",
        choice = false "Ceilingheating",
        radioButtons = true));

    parameter Integer dis(min=1) = 5 "Number of Discreatisation Layers";

    parameter Modelica.SIunits.Area A "Area of floor / heating panel part";

    parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
      "Initial temperature, in degrees Celsius";

    parameter Integer calcMethod=2 "Calculation method for convective heat transfer coefficient at surface" annotation (Dialog(group="Heat convection",
          descriptionLabel=true), choices(
        choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
        choice=2 "By Bernd Glueck",
        choice=3 "Custom hCon (constant)",
        radioButtons=true));

    parameter Modelica.SIunits.CoefficientOfHeatTransfer hCon_const=2.5 "Custom convective heat transfer coefficient"
      annotation (Dialog(group="Heat convection",
      descriptionLabel=true,
          enable=if calcMethod == 3 then true else false));

    final parameter Modelica.SIunits.Emissivity eps=floorHeatingType.eps
      "Emissivity";

    final parameter Real cTopRatio(min=0,max=1)= floorHeatingType.c_top_ratio;

    final parameter BaseClasses.HeatCapacityPerArea
      cFloorHeating=floorHeatingType.C_ActivatedElement;

    final parameter BaseClasses.HeatCapacityPerArea
      cTop=cFloorHeating * cTopRatio;

    final parameter BaseClasses.HeatCapacityPerArea
      cDown=cFloorHeating * (1-cTopRatio);

    final parameter Modelica.SIunits.Length tubeLength=A/floorHeatingType.Spacing;

    final parameter Modelica.SIunits.Volume VWater=
      Modelica.SIunits.Conversions.from_litre(floorHeatingType.VolumeWaterPerMeter*tubeLength)
        "Volume of Water";

    // ACCORDING TO GLUECK, Bauteilaktivierung 1999

    // According to equations 7.91 (for heat flow up) and 7.93 (for heat flow down) from page 41
    //   final parameter Modelica.SIunits.Temperature T_Floor_nom= if Floor then
    //     (floorHeatingType.q_dot_nom/8.92)^(1/1.1) + floorHeatingType.Temp_nom[3]
    //     else floorHeatingType.q_dot_nom/6.7 + floorHeatingType.Temp_nom[3];

    final parameter Modelica.SIunits.CoefficientOfHeatTransfer
      kTop_nominal=floorHeatingType.k_top;

    final parameter Modelica.SIunits.CoefficientOfHeatTransfer
      kDown_nominal = floorHeatingType.k_down;

    Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium
        = Medium)
      annotation (Placement(transformation(extent={{60,-36},{80,-16}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermDown annotation (
        Placement(transformation(extent={{-10,-72},{10,-52}}),
          iconTransformation(extent={{-2,-38},{18,-18}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp annotation (
        Placement(transformation(extent={{-10,48},{10,68}}), iconTransformation(
            extent={{4,30},{24,50}})));

    PanelHeatingSegment panelHeatingSegment(
      redeclare package Medium = Medium,
      A=A/dis,
      VWater=5,
      kTop=5,
      kDown=5,
      cTop=5,
      cDown=5) annotation (Placement(transformation(extent={{-8,0},{12,20}})));
  equation

    // HEAT CONNECTIONS
    for i in 1:dis loop
    end for;

    // FLOW CONNECTIONS

    //OUTER CONNECTIONS

    //INNER CONNECTIONS

    if dis > 1 then
      for i in 1:(dis-1) loop
      end for;
    end if;

    connect(port_a, TFlow.port_a) annotation (Line(
        points={{-100,0},{-88,0},{-88,-30},{-70,-30}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(TReturn.port_b, port_b) annotation (Line(
        points={{80,-26},{84,-26},{84,0},{100,0}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(TFlow.port_b, panelHeatingSegment.port_a) annotation (Line(points={
            {-50,-30},{-50,10},{-8,10}}, color={0,127,255}));
    connect(panelHeatingSegment.thermDown, ThermDown)
      annotation (Line(points={{0.8,0},{0,0},{0,-62}}, color={191,0,0}));
    connect(panelHeatingSegment.thermUp, thermUp)
      annotation (Line(points={{0,19.8},{0,58}}, color={191,0,0}));
    connect(panelHeatingSegment.port_b, TReturn.port_a)
      annotation (Line(points={{12,10},{60,10},{60,-26}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,
              -60},{100,60}}), graphics={Rectangle(extent={{20,40},{40,20}},
              lineColor={191,0,0}), Text(
            extent={{22,34},{38,26}},
            lineColor={0,0,0},
            textString="dP")}),  Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-25},{100,35}}),
                                      graphics={
          Rectangle(
            extent={{-100,14},{100,-26}},
            lineColor={200,200,200},
            fillColor={150,150,150},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,35},{100,14}},
            lineColor={200,200,200},
            fillColor={170,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-84,-2},{-76,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-68,-2},{-60,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-52,-2},{-44,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-36,-2},{-28,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-20,-2},{-12,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-4,-2},{4,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{12,-2},{20,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{28,-2},{36,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{44,-2},{52,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{60,-2},{68,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{76,-2},{84,-10}},
            lineColor={200,200,200},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,8},{-80,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None},
            thickness=1),
          Line(
            points={{-64,8},{-64,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{-48,8},{-48,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{-32,8},{-32,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{-16,8},{-16,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{0,8},{0,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{16,8},{16,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{32,8},{32,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{48,8},{48,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{64,8},{64,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{80,8},{80,0}},
            color={255,0,0},
            smooth=Smooth.None,
            arrow={Arrow.Filled,Arrow.None})}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for floor heating, with one pipe running through the whole floor.</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The assumption is made that there is one pipe that runs thorugh the whole floor. Which means that a discretisation of the floor heating is done, the discretisation elements will be connected in series: the flow temperature of one element is the return temperature of the element before.</p>
<p>The pressure drop is calculated at the end for the whole length of the pipe.</p>
<h4><span style=\"color:#008000\">Reference</span></h4>
<p>Source:</p>
<ul>
<li>Bernd Glueck, Bauteilaktivierung 1999, Page 41</li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test\">AixLib.Fluid.HeatExchangers.Examples.ActiveWalls.ActiveWalls_Test</a></p>
</html>", revisions="<html>
<ul>
<li><i>February 06, 2017&nbsp;</i> by Philipp Mehrfeld:<br/>
Use kTop and kDown instead of k_insulation. Naming according to AixLib standards.</li>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>
Uses components from MSL</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>"));
  end PanelHeating;

  model PanelHeatingToRoom
    replaceable package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater;
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp annotation (
        Placement(transformation(extent={{-82,30},{-62,50}}), iconTransformation(
            extent={{-82,30},{-62,50}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling
      annotation (Placement(transformation(extent={{-8,-24},{8,-6}})));
    PanelHeating panelHeating(redeclare package Medium = Medium, A=floor.wall_length
          *floor.wall_height)
      annotation (Placement(transformation(extent={{-142,26},{-122,32}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
    Sources.MassFlowSource_T boundary(nPorts=1, redeclare package Medium = Medium,
      m_flow=5)
      annotation (Placement(transformation(extent={{-176,18},{-156,38}})));
    Modelica.Fluid.Sources.FixedBoundary boundary1(nPorts=1, redeclare package
        Medium = Medium)
      annotation (Placement(transformation(extent={{68,20},{48,40}})));
    ThermalZones.HighOrder.Components.Walls.Wall floor(outside=false, WallType=
          DataBase.Walls.Dummys.FloorForFloorHeating2Layers()) annotation (
        Placement(transformation(
          extent={{-2,-12},{2,12}},
          rotation=90,
          origin={0,48})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown annotation (
        Placement(transformation(extent={{-82,8},{-62,28}}), iconTransformation(
            extent={{-82,30},{-62,50}})));
    ThermalZones.HighOrder.Components.Walls.Wall floor1(outside=false, WallType=
          DataBase.Walls.Dummys.CeilingForFloorHeating3Layers()) annotation (
        Placement(transformation(
          extent={{2,-12},{-2,12}},
          rotation=90,
          origin={0,-50})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor
      annotation (Placement(transformation(extent={{-26,30},{-10,48}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature
      annotation (Placement(transformation(extent={{78,-66},{68,-56}})));
    Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort
      annotation (Placement(transformation(extent={{26,-64},{40,-52}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{78,-54},{66,-42}})));
    Modelica.Blocks.Sources.Constant const1(k=273 + 20)
      annotation (Placement(transformation(extent={{102,-66},{92,-56}})));
    Modelica.Blocks.Sources.Constant const2(k=10)
      annotation (Placement(transformation(extent={{102,-52},{92,-42}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature1
      annotation (Placement(transformation(extent={{88,50},{78,60}})));
    Utilities.Interfaces.Adaptors.ConvRadToCombPort convRadToCombPort1
      annotation (Placement(transformation(extent={{36,52},{50,64}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
      prescribedHeatFlow1
      annotation (Placement(transformation(extent={{88,62},{76,74}})));
    Modelica.Blocks.Sources.Constant const3(k=273 + 20)
      annotation (Placement(transformation(extent={{112,50},{102,60}})));
    Modelica.Blocks.Sources.Constant const4(k=10)
      annotation (Placement(transformation(extent={{112,64},{102,74}})));
  equation

    connect(boundary.ports[1], panelHeating.port_a) annotation (Line(points={{-156,
            28},{-150,28},{-150,28.5},{-142,28.5}}, color={0,127,255}));
    connect(panelHeating.port_b, boundary1.ports[1]) annotation (Line(points={{-122,
            28.5},{-116,28.5},{-116,28},{48,28},{48,30}}, color={0,127,255}));
    connect(thermUp, panelHeating.thermUp) annotation (Line(points={{-72,40},{-72,
            38},{-130.6,38},{-130.6,32.5}}, color={191,0,0}));
    connect(thermUp, floor.port_outside) annotation (Line(points={{-72,40},{-50,40},
            {-50,38},{-2.22045e-16,38},{-2.22045e-16,45.9}}, color={191,0,0}));
    connect(panelHeating.ThermDown, thermDown) annotation (Line(points={{-131.2,25.7},
            {-131.2,18},{-72,18}}, color={191,0,0}));
    connect(thermCeiling, thermDown) annotation (Line(points={{0,-15},{0,0},{-72,0},
            {-72,18}}, color={191,0,0}));
    connect(floor1.port_outside, thermCeiling)
      annotation (Line(points={{0,-47.9},{0,-15}}, color={191,0,0}));
    connect(floor1.thermStarComb_inside, convRadToCombPort.portConvRadComb)
      annotation (Line(points={{0,-52},{2,-52},{2,-57.025},{26.14,-57.025}},
          color={191,0,0}));
    connect(convRadToCombPort.portConv, prescribedTemperature.port) annotation
      (Line(points={{40.07,-61.825},{46,-61.825},{46,-61},{68,-61}}, color={191,
            0,0}));
    connect(convRadToCombPort.portRad, prescribedHeatFlow.port) annotation (
        Line(points={{40.28,-53.65},{66,-53.65},{66,-48}}, color={95,95,95}));
    connect(prescribedHeatFlow.Q_flow, const2.y) annotation (Line(points={{78,
            -48},{91.5,-48},{91.5,-47}}, color={0,0,127}));
    connect(prescribedTemperature.T, const1.y) annotation (Line(points={{79,-61},
            {91.5,-61},{91.5,-61}}, color={0,0,127}));
    connect(convRadToCombPort1.portConv, prescribedTemperature1.port)
      annotation (Line(points={{50.07,54.175},{56,54.175},{56,55},{78,55}},
          color={191,0,0}));
    connect(convRadToCombPort1.portRad, prescribedHeatFlow1.port) annotation (
        Line(points={{50.28,62.35},{76,62.35},{76,68}}, color={95,95,95}));
    connect(prescribedHeatFlow1.Q_flow, const4.y) annotation (Line(points={{88,
            68},{101.5,68},{101.5,69}}, color={0,0,127}));
    connect(prescribedTemperature1.T, const3.y)
      annotation (Line(points={{89,55},{101.5,55}}, color={0,0,127}));
    connect(floor.thermStarComb_inside, convRadToCombPort1.portConvRadComb)
      annotation (Line(points={{0,50},{2,50},{2,58.975},{36.14,58.975}}, color=
            {191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(extent={{-72,76},{72,68}}, lineColor={28,108,200}),
          Text(
            extent={{-14,74},{14,66}},
            lineColor={28,108,200},
            textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),       Line(points={{0,-52},{0,-70}},   color={28,108,200}),
          Line(points={{0,-70},{4,-66}},   color={28,108,200}),
          Line(points={{-4,-66},{0,-70}},  color={28,108,200}),
          Rectangle(extent={{-42,-70},{56,-78}}, lineColor={28,108,200}),
          Text(
            extent={{-40,-72},{56,-76}},
            lineColor={28,108,200},
            textString="Wärmeabgabe an Raum unter der Fußbodenheizung"),
          Line(points={{0,68},{0,50}}, color={28,108,200}),
          Line(points={{0,50},{4,54}}, color={28,108,200}),
          Line(points={{-4,54},{0,50}}, color={28,108,200})}));
  end PanelHeatingToRoom;

  model PanelHeatingSegment
    "One segment of the discretized panel heating"

  extends Modelica.Fluid.Interfaces.PartialTwoPort;

  parameter Boolean isFloor = true;

  parameter Modelica.SIunits.Area A = panelHeating.A "Area of Floor part";

  parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity";

  parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
      "Initial temperature, in degrees Celsius";

  parameter Modelica.SIunits.Volume VWater "Volume of Water in m^3";

  parameter Modelica.SIunits.CoefficientOfHeatTransfer kTop;
  parameter Modelica.SIunits.CoefficientOfHeatTransfer kDown;

  parameter BaseClasses.HeatCapacityPerArea cTop;
  parameter BaseClasses.HeatCapacityPerArea cDown;

    parameter Integer calcMethod=2 "Calculation method for convective heat transfer coefficient at surface"
      annotation (Dialog(group="Heat convection",
          descriptionLabel=true), choices(
          choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
          choice=2 "By Bernd Glueck",
          choice=3 "Custom hCon (constant)",
          radioButtons=true));

    parameter Modelica.SIunits.CoefficientOfHeatTransfer hCon_const=2.5 "Constant heat transfer coefficient"
      annotation (Dialog(group="Heat convection",
      descriptionLabel=true,
          enable=if calcMethod == 3 then true else false));

    Modelica.Fluid.Vessels.ClosedVolume vol(
      redeclare package Medium = Medium,
      energyDynamics=system.energyDynamics,
      use_HeatTransfer=true,
      T_start=T0,
      redeclare model HeatTransfer =
          Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
      use_portsData=false,
      V=VWater,
      nPorts=2) annotation (Placement(transformation(extent={{-14,-26},{8,-4}})));

    Modelica.Fluid.Sensors.TemperatureTwoPort TFlow(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-70,-36},{-50,-16}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown
      annotation (Placement(transformation(extent={{-22,-110},{-2,-90}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermUp
      annotation (Placement(transformation(extent={{-30,88},{-10,108}})));
  equation

    connect(port_a, TFlow.port_a) annotation (Line(
        points={{-100,0},{-88,0},{-88,-26},{-70,-26}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(TFlow.port_b, vol.ports[1]) annotation (Line(
        points={{-50,-26},{-5.2,-26}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(vol.ports[2], TReturn.port_a) annotation (Line(
        points={{-0.8,-26},{50,-26}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(TReturn.port_b, port_b) annotation (Line(
        points={{70,-26},{84,-26},{84,0},{100,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(thermDown, thermDown) annotation (Line(
        points={{-12,-100},{-12,-100}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(vol.heatPort, thermUp) annotation (Line(points={{-14,-15},{-18,-15},{-18,
            98},{-20,98}}, color={191,0,0}));
    connect(vol.heatPort, thermDown) annotation (Line(points={{-14,-15},{-14,-100},
            {-12,-100}}, color={191,0,0}));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}})),  Icon(graphics={
          Rectangle(
            extent={{-100,20},{100,-22}},
            lineColor={0,0,0},
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-100,66},{100,40}},
          lineColor={166,166,166},
          pattern=LinePattern.None,
          fillColor={190,190,190},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,100},{-100,66}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,40},{-100,20}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,-22},{-100,-56}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-56},{100,-82}},
          lineColor={166,166,166},
          pattern=LinePattern.None,
          fillColor={190,190,190},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{100,-82},{-100,-102}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid),
          Line(
            points={{-22,26},{-22,82}},
            color={255,0,0},
            thickness=0.5,
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{-20,62},{62,40}},
            lineColor={255,0,0},
            textString="Q_flow"),
          Text(
            extent={{-20,-46},{62,-68}},
            lineColor={255,0,0},
            textString="Q_flow"),
          Line(
            points={{0,-28},{0,28}},
            color={255,0,0},
            thickness=0.5,
            arrow={Arrow.None,Arrow.Filled},
            origin={-22,-54},
            rotation=180)}),
      Documentation(revisions="<html>
<ul>
<li><i>February 06, 2017&nbsp;</i> by Philipp Mehrfeld:<br/>
Naming according to AixLib standards.</li>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>Added documentation.</li>
</ul>
</html>",
        info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for a panel heating element, consisting of a water volume, heat conduction upwards and downwards through the wall layers, convection and radiation exchange at the room facing side.</p>
</html>"));
  end PanelHeatingSegment;

  model HeatConductionSegment

  parameter Modelica.SIunits.ThermalConductance kA
      "Constant thermal conductance of material";
  parameter Modelica.SIunits.HeatCapacity mc_p
      "Heat capacity of element (= cp*m)";
  parameter Modelica.SIunits.Temperature T0 "Initial Temperature of element";

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
      annotation (Placement(transformation(extent={{-108,-8},{-74,26}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
      annotation (Placement(transformation(extent={{74,-8},{108,26}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=2*kA)
      annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor
      thermalConductor2(                                                        G=
         2*kA) annotation (Placement(transformation(extent={{28,-2},{48,18}})));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor
      heatCapacitor(                                                     T(start=
            T0), C=mc_p)
      annotation (Placement(transformation(extent={{-12,34},{8,54}})));
  equation
    connect(port_a, thermalConductor1.port_a) annotation (Line(
        points={{-91,9},{-46,9},{-46,10}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(thermalConductor1.port_b, heatCapacitor.port) annotation (Line(
        points={{-26,10},{-24,10},{-24,28},{-2,28},{-2,34}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(thermalConductor2.port_a, heatCapacitor.port) annotation (Line(
        points={{28,8},{20,8},{20,28},{-2,28},{-2,34}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(thermalConductor2.port_b, port_b) annotation (Line(
        points={{48,8},{86,8},{86,10},{88,10},{88,9},{91,9}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(graphics={
        Rectangle(
          extent={{-100,-45.5},{100,45.5}},
          lineColor={166,166,166},
          pattern=LinePattern.None,
          fillColor={190,190,190},
          fillPattern=FillPattern.Solid,
            origin={0.5,0},
            rotation=90),
        Rectangle(
          extent={{100,30},{-100,-30}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid,
            origin={-70,0},
            rotation=270),
        Rectangle(
          extent={{100,30},{-100,-30}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={156,156,156},
          fillPattern=FillPattern.Solid,
            origin={76,0},
            rotation=270),
          Line(
            points={{-72,-1},{72,-1}},
            color={255,0,0},
            thickness=0.5,
            arrow={Arrow.None,Arrow.Filled},
            origin={4,47},
            rotation=360),
          Line(
            points={{-72,-1},{72,-1}},
            color={255,0,0},
            thickness=0.5,
            arrow={Arrow.None,Arrow.Filled},
            origin={2,-33},
            rotation=180)}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model for heat conduction using elements from the MSL.</p>
</html>",
        revisions="<html>
<ul>
<li><i>February 06, 2017&nbsp;</i> by Philipp Mehrfeld:<br/>
Naming according to AixLib standards.</li>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>
Uses components from MSL</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>"));
  end HeatConductionSegment;

  model PanelHeatingSegmentTest
    replaceable package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater;

    PanelHeatingSegment panelHeatingSegment(
      redeclare package Medium = Medium,
      A=4,
      kTop=1,
      kDown=1,
      cTop=1,
      cDown=1,
      VWater=1)
      annotation (Placement(transformation(extent={{-50,-8},{-30,12}})));
    Modelica.Fluid.Sources.FixedBoundary boundary1(nPorts=1, redeclare package
        Medium = Medium)
      annotation (Placement(transformation(extent={{80,-12},{60,8}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
      annotation (Placement(transformation(extent={{-54,88},{-34,108}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1
      annotation (Placement(transformation(extent={{-48,-104},{-28,-84}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
    Sources.MassFlowSource_T boundary(nPorts=1, redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-98,-8},{-78,12}})));
  equation
    connect(panelHeatingSegment.port_b, boundary1.ports[1]) annotation (Line(
          points={{-30,2},{-12,2},{-12,0},{60,0},{60,-2}}, color={0,127,255}));
    connect(port_a, panelHeatingSegment.thermUp) annotation (Line(points={{-44,98},
            {-44,11.8},{-42,11.8}}, color={191,0,0}));
    connect(port_a1, panelHeatingSegment.thermDown) annotation (Line(points={{-38,
            -94},{-44,-94},{-44,-8},{-41.2,-8}}, color={191,0,0}));
    connect(boundary.ports[1], panelHeatingSegment.port_a)
      annotation (Line(points={{-78,2},{-50,2}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PanelHeatingSegmentTest;
end PanelHeatingNew;
