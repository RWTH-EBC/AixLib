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
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermConv annotation (
        Placement(transformation(extent={{4,48},{24,68}}), iconTransformation(
            extent={{4,30},{24,50}})));
    AixLib.Utilities.Interfaces.RadPort starRad annotation (Placement(transformation(extent={{-26,50},{-6,70}}), iconTransformation(extent={{-22,28},{-2,48}})));
    BaseClasses.PanelHeatingSegment panelHeatingSegment[dis](
      redeclare package Medium = Medium,
      each final A=A/dis,
      each final eps=eps,
      each final T0=T0,
      each final VWater=VWater/dis,
      each final kTop=kTop_nominal,
      each final kDown=kDown_nominal,
      each final cTop=cTop,
      each final cDown=cDown,
      each final isFloor=isFloor,
      each final calcMethod=calcMethod,
      each final hCon_const=hCon_const) annotation (Placement(transformation(extent={{-58,1},{-8,51}})));

    BaseClasses.PressureDropPH pressureDrop(
      redeclare package Medium = Medium,
      final tubeLength=tubeLength,
      final n=floorHeatingType.PressureDropExponent,
      final m=floorHeatingType.PressureDropCoefficient)
    annotation (Placement(transformation(extent={{8,0},{54,52}})));
  equation

    // HEAT CONNECTIONS
    for i in 1:dis loop
      connect(panelHeatingSegment[i].thermConvWall, ThermDown);
      connect(panelHeatingSegment[i].thermConvRoom, thermConv);
      connect(panelHeatingSegment[i].starRad, starRad);
    end for;

    // FLOW CONNECTIONS

    //OUTER CONNECTIONS

    connect(TFlow.port_b, panelHeatingSegment[1].port_a);
    connect(pressureDrop.port_a, panelHeatingSegment[dis].port_b);

    //INNER CONNECTIONS

    if dis > 1 then
      for i in 1:(dis-1) loop
        connect(panelHeatingSegment[i].port_b, panelHeatingSegment[i + 1].port_a);
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
    connect(pressureDrop.port_b, TReturn.port_a) annotation (Line(
        points={{54,26},{60,26},{60,-26}},
        color={0,127,255},
        smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,
              -60},{100,60}})),  Icon(coordinateSystem(preserveAspectRatio=false,
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
    ThermalZones.HighOrder.Components.Walls.Wall floor(outside=false, WallType=
          DataBase.Walls.Dummys.FloorForFloorHeating2Layers()) annotation (
        Placement(transformation(
          extent={{2,-12},{-2,12}},
          rotation=-90,
          origin={0,46})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloor annotation (
        Placement(transformation(extent={{4,-20},{24,0}}),     iconTransformation(
            extent={{4,-20},{24,0}})));
    ThermalZones.HighOrder.Components.Walls.BaseClasses.SimpleNLayer
      lowerhalf_floor
      "represents the part of the floor that lies underneath the floor heating"
      annotation (Placement(transformation(
          extent={{-3,-15},{3,15}},
          rotation=-90,
          origin={-31,5})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
      thermFloorHeatingDownHeatFlow if                                 withFloorHeating
      "Thermal connector for heat flow of floor heating going downwards through the floor"
      annotation (Placement(transformation(extent={{-96,10},{-82,24}}),
          iconTransformation(extent={{-56,-92},{-36,-72}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermFloorHeatingUpHeatFlow if
                                                                       withFloorHeating
      "Thermal connector for heat flow of floor heating going upwards through the floor"
      annotation (Placement(transformation(extent={{-96,28},{-82,42}}),
          iconTransformation(extent={{-56,-92},{-36,-72}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermCeiling_Livingroom
      annotation (Placement(transformation(extent={{6,-44},{22,-26}})));
    ThermalZones.HighOrder.Components.Walls.Wall floor1(outside=false, WallType
        =DataBase.Walls.Dummys.CeilingForFloorHeating3Layers()) annotation (
        Placement(transformation(
          extent={{-2,12},{1.99995,-12}},
          rotation=-90,
          origin={14,-66})));
  equation
    connect(thermFloor, lowerhalf_floor.port_b) annotation (Line(points={{14,
            -10},{-30,-10},{-30,2},{-31,2}}, color={191,0,0}));
    connect(thermFloorHeatingDownHeatFlow, lowerhalf_floor.port_a) annotation (
        Line(points={{-89,17},{-30.5,17},{-30.5,8},{-31,8}}, color={191,0,0}));
    connect(thermFloorHeatingUpHeatFlow, thermFloorHeatingDownHeatFlow)
      annotation (Line(points={{-89,35},{-132,35},{-132,17},{-89,17}}, color={
            191,0,0}));
    connect(floor.port_outside, thermFloor) annotation (Line(
        points={{-4.44089e-16,43.9},{0,43.9},{0,36},{14,36},{14,-10}},
        color={191,0,0},
        pattern=LinePattern.Dash));
    connect(thermFloorHeatingUpHeatFlow, floor.port_outside) annotation (Line(
          points={{-89,35},{-0.5,35},{-0.5,43.9},{0,43.9}}, color={191,0,0}));
    connect(thermFloor, thermCeiling_Livingroom) annotation (Line(
        points={{14,-10},{14,-35},{14,-35}},
        color={191,0,0},
        smooth=Smooth.Bezier));
    connect(thermCeiling_Livingroom, floor1.port_outside) annotation (Line(
        points={{14,-35},{14,-63.9},{14,-63.9}},
        color={191,0,0},
        smooth=Smooth.Bezier));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(extent={{-72,76},{72,68}}, lineColor={28,108,200}),
          Text(
            extent={{-14,74},{14,66}},
            lineColor={28,108,200},
            textString="Information aus Raum: Heizlast = benötigte Wärmemenge aus Fußbodenheizung
"),
          Line(points={{14,-68},{14,-86}}, color={28,108,200}),
          Line(points={{14,-86},{18,-82}}, color={28,108,200}),
          Line(points={{10,-82},{14,-86}}, color={28,108,200}),
          Rectangle(extent={{-146,32},{-116,20}}, lineColor={28,108,200}),
          Text(
            extent={{-142,36},{-120,16}},
            lineColor={238,46,47},
            textString="FBH"),
          Rectangle(extent={{-28,-86},{70,-94}}, lineColor={28,108,200}),
          Text(
            extent={{-26,-88},{70,-92}},
            lineColor={28,108,200},
            textString="Wärmeabgabe an Raum unter der Fußbodenheizung"),
          Line(points={{0,68},{0,50}}, color={28,108,200}),
          Line(points={{0,50},{4,54}}, color={28,108,200}),
          Line(points={{-4,54},{0,50}}, color={28,108,200})}));
  end PanelHeatingToRoom;

  model PanelHeatingSegment "One segment of the discretized panel heating"

  extends Modelica.Fluid.Interfaces.PartialTwoPort;

  parameter Boolean isFloor = true;

  parameter Modelica.SIunits.Area A "Area of Floor part";

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
    Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package Medium
        = Medium)
      annotation (Placement(transformation(extent={{50,-36},{70,-16}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermDown
      annotation (Placement(transformation(extent={{-22,-110},{-2,-90}})));
    BaseClasses.HeatConductionSegment panel_Segment1(
      kA=kTop*A,
      mc_p=cTop*A,
      T0=T0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,30})));
    BaseClasses.HeatConductionSegment panel_Segment2(
      T0=T0,
      kA=kDown*A,
      mc_p=cDown*A) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-12,-56})));
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
    connect(panel_Segment1.port_a, vol.heatPort) annotation (Line(
        points={{-16.9,20.9},{-16.9,2},{-14,2},{-14,-15}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(panel_Segment2.port_b, thermDown) annotation (Line(
        points={{-11.1,-65.1},{-11.1,-81.55},{-12,-81.55},{-12,-100}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(panel_Segment2.port_a, vol.heatPort) annotation (Line(
        points={{-11.1,-46.9},{-11.1,-31.45},{-14,-31.45},{-14,-15}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(panel_Segment1.port_b, thermUp) annotation (Line(points={{-16.9,
            39.1},{-16.9,54},{-20,54},{-20,98}}, color={191,0,0}));
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
