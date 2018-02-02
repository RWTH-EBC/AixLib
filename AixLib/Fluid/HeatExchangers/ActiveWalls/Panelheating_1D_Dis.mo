within AixLib.Fluid.HeatExchangers.ActiveWalls;
model Panelheating_1D_Dis

  extends Modelica.Fluid.Interfaces.PartialTwoPort;

     parameter AixLib.DataBase.ActiveWalls.ActiveWallBaseDataDefinition Floorheatingtype=
      DataBase.ActiveWalls.JocoKlimaBodenTOP2000_Parkett()
    annotation (Dialog(group="Type"), choicesAllMatching=true);

  parameter Boolean Floor =  true "Floor or Ceiling heating"
    annotation(Dialog(compact = true, descriptionLabel = true), choices(choice=true
        "Floorheating",                                                                             choice = false
        "Ceilingheating",                                                                                                  radioButtons = true));

  parameter Integer Dis(min=1) = 5 "Number of Discreatisation Layers";

  parameter Integer calcMethodConvection = 1
    "Calculation Method for convection at surface"
    annotation (Dialog(group = "Heat convection",
        descriptionLabel=true), choices(
        choice=1 "EN ISO 6946 Appendix A >>Flat Surfaces<<",
        choice=2 "By Bernd Glueck",
        choice=3 "Constant alpha",
        radioButtons=true));


  parameter Modelica.SIunits.CoefficientOfHeatTransfer convCoeffCustom = 2.5
    "Constant heat transfer coefficient"
    annotation (Dialog(group = "Heat convection",
    descriptionLabel=true,
        enable=if calcMethodConvection == 3 then true else false));


  final parameter Modelica.SIunits.Emissivity eps=Floorheatingtype.eps
    "Emissivity";

  final parameter Real c_top_ratio(min=0,max=1)= Floorheatingtype.c_top_ratio;

 final parameter BaseClasses.HeatCapacityPerArea
    C_Floorheating=Floorheatingtype.C_ActivatedElement;

 final parameter BaseClasses.HeatCapacityPerArea
    C_top=C_Floorheating * c_top_ratio;

  final parameter BaseClasses.HeatCapacityPerArea
    C_down=C_Floorheating * (1-c_top_ratio);

  parameter Modelica.SIunits.Area A "Area of floor / heating panel part";

  parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius";

  final parameter Modelica.SIunits.Length Tubelength=A/Floorheatingtype.Spacing;

  final parameter Modelica.SIunits.Volume Watervolume=Modelica.SIunits.Conversions.from_litre(Floorheatingtype.VolumeWaterPerMeter*Tubelength)
    "Volume of Water in m^3";

  // ACCORDING TO GLUECK, Bauteilaktivierung 1999

  // According to equations 7.91 (for heat flow up) and 7.93 (for heat flow down) from page 41
//   final parameter Modelica.SIunits.Temperature T_Floor_nom= if Floor then
//     (Floorheatingtype.q_dot_nom/8.92)^(1/1.1) + Floorheatingtype.Temp_nom[3]
//     else Floorheatingtype.q_dot_nom/6.7 + Floorheatingtype.Temp_nom[3];

  final parameter Modelica.SIunits.CoefficientOfHeatTransfer
    k_nom_top=Floorheatingtype.k_top;

  final parameter Modelica.SIunits.CoefficientOfHeatTransfer
    k_nom_down = Floorheatingtype.k_down;

Modelica.Fluid.Sensors.TemperatureTwoPort t_flow(redeclare package Medium =
      Medium)
  annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
Modelica.Fluid.Sensors.TemperatureTwoPort t_return(redeclare package Medium =
      Medium)
  annotation (Placement(transformation(extent={{60,-36},{80,-16}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermDown annotation (
      Placement(transformation(extent={{-10,-72},{10,-52}}),
        iconTransformation(extent={{-2,-38},{18,-18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermTop annotation (
      Placement(transformation(extent={{4,48},{24,68}}), iconTransformation(
          extent={{4,30},{24,50}})));
  AixLib.Utilities.Interfaces.Star StarTop annotation (Placement(transformation(
          extent={{-26,50},{-6,70}}), iconTransformation(extent={{-22,28},{-2,
            48}})));
BaseClasses.PH_Segment
    fH_Segment[Dis](
    redeclare package Medium = Medium,
    each A=A/Dis,
    each eps=eps,
    each T0=T0,
    each Watervolume=Watervolume/Dis,
    each k_top=k_nom_top,
    each k_down=k_nom_down,
    each C_top=C_top,
    each C_down=C_down,
    each Floor=Floor,
    each final calcMethodConvection = calcMethodConvection,
    each final convCoeffCustom = convCoeffCustom)
  annotation (Placement(transformation(extent={{-58,1},{-8,51}})));
public
  BaseClasses.PressureDropPH
    pressureDrop(
    redeclare package Medium = Medium,
    Tubelength=Tubelength,
    n=Floorheatingtype.PressureDropExponent,
    m=Floorheatingtype.PressureDropCoefficient)
  annotation (Placement(transformation(extent={{8,0},{54,52}})));
equation

  // HEAT CONNECTIONS
  for
  i in 1:Dis loop
  connect(fH_Segment[i].ThermDown, ThermDown);
  connect(fH_Segment[i].ThermTop, ThermTop);
  connect(fH_Segment[i].StarTop, StarTop);
  end for;

  // FLOW CONNECTIONS

  //OUTER CONNECTIONS

  connect(t_flow.port_b, fH_Segment[1].port_a);
  connect(pressureDrop.port_a, fH_Segment[Dis].port_b);

  //INNER CONNECTIONS

  if Dis > 1 then

 for i in 1:(Dis-1) loop
  connect(fH_Segment[i].port_b, fH_Segment[i+1].port_a);
 end for;

  end if;

connect(port_a, t_flow.port_a) annotation (Line(
    points={{-100,0},{-88,0},{-88,-30},{-70,-30}},
    color={0,127,255},
    smooth=Smooth.None));

connect(t_return.port_b, port_b) annotation (Line(
    points={{80,-26},{84,-26},{84,0},{100,0}},
    color={0,127,255},
    smooth=Smooth.None));
  connect(pressureDrop.port_b, t_return.port_a)           annotation (Line(
    points={{54,26},{60,26},{60,-26}},
    color={0,127,255},
    smooth=Smooth.None));

annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,
            -60},{100,60}}),
                    graphics), Icon(coordinateSystem(preserveAspectRatio=false,
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
</html>",
        revisions="<html>
<ul>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>March 25, 2015&nbsp;</i> by Ana Constantin:<br/>
Uses components from MSL</li>
<li><i>November 06, 2014&nbsp;</i> by Ana Constantin:<br/>
Added documentation.</li>
</ul>
</html>"));
end Panelheating_1D_Dis;
