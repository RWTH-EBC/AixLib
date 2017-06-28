within AixLib.Fluid.HeatExchangers.ActiveWalls;
model Panel_Dis1D
  "Activated wall element with discretization elements connected in parallel"

  extends Modelica.Fluid.Interfaces.PartialTwoPort;
  import Modelica.SIunits.Conversions.from_degC;

  parameter Boolean Floor =  false "Activated room element"
    annotation(Dialog(group="Type", compact = true, descriptionLabel = true), choices(choice=true "Floor", choice = false "Ceiling",
                                                                                                    radioButtons = true));
  parameter Integer OperatingMode = 2 "Operating mode for the panels" annotation(Dialog(group="Type", compact = true, descriptionLabel = true), choices(choice=1 "Heating", choice=2 "Cooling", choice = 3
        "Heating and Cooling",                                                                                                    radioButtons = true));

  parameter DataBase.ActiveWalls.ActiveWallBaseDataDefinition HeatingRecord=
      DataBase.ActiveWalls.JocoKlimaBodenTOP2000_Parkett() annotation (Dialog(
        group="Type", enable=if (OperatingMode == 1 or OperatingMode == 3)
           then true else false), choicesAllMatching=true);

  parameter DataBase.ActiveWalls.ActiveWallBaseDataDefinition
    CoolingRecord= DataBase.ActiveWalls.JocoKlimaBodenTOP2000_Parkett() annotation(Dialog(group="Type",enable = if (OperatingMode == 2 or OperatingMode ==3) then true else false), choicesAllMatching=true);

  parameter Integer Dis(min=1) = 5 "Number of discretisation" annotation(Dialog(group="Discretisation"));

  parameter Modelica.SIunits.Area A=10
    "Area of the whole activated elemnt, floor or ceiling"                                    annotation(Dialog(group="Discretisation"));

  parameter Modelica.SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius" annotation(Dialog(group="Discretisation"));

  parameter Modelica.SIunits.Length Tubelength=26.25
    "Tube length for one discretisation element" annotation(Dialog(group="Discretisation"));

  final parameter Modelica.SIunits.Emissivity eps=if (OperatingMode == 1 or OperatingMode ==3) then HeatingRecord.eps else CoolingRecord.eps
    "Emissivity";

  final parameter Modelica.SIunits.CoefficientOfHeatTransfer k_isolation= if (OperatingMode == 1 or OperatingMode ==3)  then HeatingRecord.k_isolation else CoolingRecord.k_isolation
    "k through layer";

  final parameter Real c_top_ratio(min=0,max=1)= if (OperatingMode == 1 or OperatingMode ==3) then HeatingRecord.c_top_ratio else CoolingRecord.c_top_ratio;

 final parameter BaseClasses.HeatCapacityPerArea
    C_ActivatedElement=if (OperatingMode == 1 or OperatingMode ==3) then HeatingRecord.C_ActivatedElement else CoolingRecord.C_ActivatedElement;

 final parameter BaseClasses.HeatCapacityPerArea
    C_top=if (OperatingMode == 1 or OperatingMode ==3) then HeatingRecord.c_top_ratio else CoolingRecord.c_top_ratio;

  final parameter BaseClasses.HeatCapacityPerArea
    C_down=C_ActivatedElement* (1-c_top_ratio);

  final parameter Modelica.SIunits.Volume Watervolume=if (OperatingMode == 1 or OperatingMode ==3) then  Modelica.SIunits.Conversions.from_litre(HeatingRecord.VolumeWaterPerMeter*Tubelength)  else  Modelica.SIunits.Conversions.from_litre(CoolingRecord.VolumeWaterPerMeter*Tubelength)
    "Volume of Water in m^3";

  // ACCORDING TO GLUECK, Bauteilaktivierung 1999

  // According to equations 7.91 (for heat flow up) and 7.93 (for heat flow down) from page 41
  final parameter Modelica.SIunits.Temperature[2] T_Floor_nom=
  if Floor then
    if OperatingMode == 1 then
      {(HeatingRecord.q_dot_nom/8.92)^(1/1.1) + from_degC(HeatingRecord.Temp_nom[3]), 0}
    else if OperatingMode == 2 then
      {0, -CoolingRecord.q_dot_nom/6.7 + from_degC(CoolingRecord.Temp_nom[3])}
    else
      {(HeatingRecord.q_dot_nom/8.92)^(1/1.1) +from_degC(HeatingRecord.Temp_nom[3]), -CoolingRecord.q_dot_nom/6.7 + from_degC(CoolingRecord.Temp_nom[3])}
    else
      if OperatingMode == 1 then
      {0, HeatingRecord.q_dot_nom/6.7 + from_degC(HeatingRecord.Temp_nom[3])}
    else if OperatingMode == 2 then
      {-(CoolingRecord.q_dot_nom/8.92)^(1/1.1) + from_degC(CoolingRecord.Temp_nom[3]), 0}
    else
      {-(CoolingRecord.q_dot_nom/8.92)^(1/1.1) + from_degC(CoolingRecord.Temp_nom[3]), HeatingRecord.q_dot_nom/6.7 + from_degC(HeatingRecord.Temp_nom[3])}
    "Surface temperature [T_heat_flow_up T_heat_flow_down]";

  final parameter Modelica.SIunits.TemperatureDifference[2] nomDT=
   if Floor then
    if OperatingMode == 1 then
      {BaseClasses.logDT({from_degC(HeatingRecord.Temp_nom[1]),from_degC(HeatingRecord.Temp_nom[2]),T_Floor_nom[1]}), 0}
    else if OperatingMode == 2 then
      {0, BaseClasses.logUnderDT({from_degC(CoolingRecord.Temp_nom[1]),from_degC(CoolingRecord.Temp_nom[2]),T_Floor_nom[2]})}
    else
      {BaseClasses.logDT({from_degC(HeatingRecord.Temp_nom[1]),from_degC(HeatingRecord.Temp_nom[2]),T_Floor_nom[1]}), BaseClasses.logUnderDT({from_degC(CoolingRecord.Temp_nom[1]),from_degC(CoolingRecord.Temp_nom[2]),T_Floor_nom[2]})}
    else
      if OperatingMode == 1 then
      {0, BaseClasses.logDT({from_degC(HeatingRecord.Temp_nom[1]),from_degC(HeatingRecord.Temp_nom[2]),T_Floor_nom[2]})}
    else if OperatingMode == 2 then
      {BaseClasses.logUnderDT({from_degC(CoolingRecord.Temp_nom[1]),from_degC(CoolingRecord.Temp_nom[2]),T_Floor_nom[1]}), 0}
    else
      {BaseClasses.logUnderDT({from_degC(CoolingRecord.Temp_nom[1]),from_degC(CoolingRecord.Temp_nom[2]),T_Floor_nom[1]}),BaseClasses.logDT({from_degC(HeatingRecord.Temp_nom[1]),from_degC(HeatingRecord.Temp_nom[2]),T_Floor_nom[2]})}
    "Nominal over / under temperature";

  final parameter Modelica.SIunits.CoefficientOfHeatTransfer[2] k_nom_top=
   if Floor then
    if OperatingMode == 1 then
      {HeatingRecord.q_dot_nom/nomDT[1], 0}
    else if OperatingMode == 2 then
      {0, -CoolingRecord.q_dot_nom/nomDT[2]}
    else
      {HeatingRecord.q_dot_nom/nomDT[1], -CoolingRecord.q_dot_nom/nomDT[2]}
    else
      if OperatingMode == 1 then
      {0, HeatingRecord.q_dot_nom/nomDT[2]}
    else if OperatingMode == 2 then
      {CoolingRecord.q_dot_nom/nomDT[1], 0}
    else
      {CoolingRecord.q_dot_nom/nomDT[1], HeatingRecord.q_dot_nom/nomDT[2]}
    "coefficient of heat tranfer towards room air";

  final parameter Modelica.SIunits.CoefficientOfHeatTransfer[2]
    k_nom_down= if (OperatingMode == 1 or OperatingMode ==3) then {(HeatingRecord.k_isolation^(-1) -  k_nom_top[1]^(-1))^(-1), 0} else {0, (CoolingRecord.k_isolation^(-1) -  k_nom_top[2]^(-1))^(-1)}
    "coefficient of heat transfer towards wall";

Modelica.Fluid.Sensors.TemperatureTwoPort t_flow(redeclare package Medium =
      Medium)
  annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermDown annotation (
        Placement(transformation(extent={{-10,-72},{10,-52}}),
          iconTransformation(extent={{-2,-38},{18,-18}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ThermTop annotation (
        Placement(transformation(extent={{4,48},{24,68}}), iconTransformation(
            extent={{4,30},{24,50}})));
  AixLib.Utilities.Interfaces.Star StarTop annotation (Placement(transformation(
          extent={{-26,50},{-6,70}}), iconTransformation(extent={{-22,28},{-2,
            48}})));
BaseClasses.Segment_dynamic fH_Segment(
      redeclare package Medium = Medium,
      each A=A/Dis,
      each eps=eps,
      each T0=T0,
      each k_top=k_nom_top,
      each k_down=k_nom_down,
      each C_top=C_top,
      each C_down=C_down,
      each Floor=Floor,
      each Watervolume=Watervolume)
      annotation (Placement(transformation(extent={{-58,1},{-8,51}})));
public
  BaseClasses.PressureDropPH pressureDrop(
      redeclare package Medium = Medium,
      Tubelength=Tubelength,
      m=if (OperatingMode == 1 or OperatingMode == 3) then HeatingRecord.PressureDropCoefficient
           else CoolingRecord.PressureDropCoefficient,
      n=if (OperatingMode == 1 or OperatingMode == 3) then HeatingRecord.PressureDropExponent
           else CoolingRecord.PressureDropExponent)
      annotation (Placement(transformation(extent={{8,0},{54,52}})));
  Utilities.Multiplier.M_flowMultiplier
                                      m_dotMultiplier(
                                                     redeclare package Medium =
        Medium, f=Dis) annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=180,
        origin={-72,-11})));
  Utilities.Multiplier.Q_flowMultiplier
                                      q_dotMultiplier(
                                                     f=Dis) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-46,50})));
  Utilities.Multiplier.Q_flowMultiplier
                                      q_dotMultiplier1(
                                                      f=Dis) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,50})));
  Utilities.Multiplier.M_flowMultiplier
                                      m_dotMultiplier1(
                                                      redeclare package
      Medium =
        Medium, f=Dis) annotation (Placement(transformation(
        extent={{-6,-8},{6,8}},
        rotation=90,
        origin={62,4})));
Modelica.Fluid.Sensors.TemperatureTwoPort t_return(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{62,-38},{82,-18}})));
equation

connect(port_a, t_flow.port_a) annotation (Line(
    points={{-100,0},{-88,0},{-88,-30},{-70,-30}},
    color={0,127,255},
    smooth=Smooth.None));

  connect(m_dotMultiplier.port_a, t_flow.port_b) annotation (Line(
      points={{-65,-11},{-50,-11},{-50,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(m_dotMultiplier.port_b, fH_Segment.port_a) annotation (Line(
      points={{-79,-11},{-79,26},{-58,26}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(fH_Segment.StarTop,q_dotMultiplier. Therm1) annotation (Line(
      points={{-40,51.5},{-40,37.205},{-46,37.205},{-46,41}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(fH_Segment.ThermTop,q_dotMultiplier1. Therm1) annotation (Line(
      points={{-32.75,49.75},{-32.75,36.4875},{-32,36.4875},{-32,41}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(q_dotMultiplier.Therm2, StarTop) annotation (Line(
      points={{-46,59},{-32,59},{-32,60},{-16,60}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(q_dotMultiplier1.Therm2, ThermTop) annotation (Line(
      points={{-32,59},{-12,59},{-12,58},{14,58}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pressureDrop.port_b,m_dotMultiplier1. port_b) annotation (Line(
      points={{54,26},{62,26},{62,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(m_dotMultiplier1.port_a, t_return.port_a) annotation (Line(
      points={{62,-2},{62,-28}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(t_return.port_b, port_b) annotation (Line(
      points={{82,-28},{84,-28},{84,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
    connect(fH_Segment.port_b, pressureDrop.port_a) annotation (Line(
        points={{-8,26},{8,26}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(fH_Segment.ThermDown, ThermDown) annotation (Line(
        points={{-36.5,2.5},{-36.5,-27.75},{0,-27.75},{0,-62}},
        color={191,0,0},
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
<p>Modification of Panelheating_1D_Dis.</p>
<p>Panels are connected in parallel in sets of x.</p>
<p>The discretisation is the number of parallel connections.</p>
<p>The set of x gives the tube length and the volume of water for every discretisation.</p>
<p>The model can work for only heating, only cooling, or heating and cooling, both as floor or ceiling. The combination of floor and cooling wouldn&apos;t make too much sense.</p>
<p>The temperature of the surface is calculated according to Bernd&nbsp;Glueck,&nbsp;Bauteilaktivierung&nbsp;1999 (equations&nbsp;7.91&nbsp;(forr&nbsp;heat&nbsp;flow&nbsp;up)&nbsp;and&nbsp;7.93&nbsp;(for&nbsp;heat&nbsp;flow&nbsp;down)&nbsp;from&nbsp;page&nbsp;41).</p>
<p>Using the surface temperature and a logarithmic calculation of the heating fluid overtemperature a heat transfer coefficient for the heat flow through the layers to the room side is calculated. This algorithm is still under review.</p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>The model is a greybox model: half physical model, half empirical formula. </p>
<p><b><font style=\"color: #ff0000; \">Attention:</font></b> When switching from cooling to heating mode the values for heat transfer coefficients don&apos;t change smoothly. So if the switch is not some type of step change for the flow temperature (see example) the model can become stuck constantly switching between hetaing and cooling mode. Realistically a change should be sudden, because there is supposed to be a certain temperature difference between room temperature and mean temperature of heating system. However a chnage can be gradual, when feeding the model with measurement data. As a solution please think about making the chnage more step like, or of introducing a a tolerance interval around the switching point, where the model is only cooling, or heating, or not doing anything. </p>
<h4><span style=\"color:#008000\">Example</span></h4>
<a href=\"HVAC.Examples.ActiveWalls.Panel_CoolingAndHeating\">HVAC.Examples.ActiveWalls.Panel_CoolingAndHeating</a>
</html>", revisions="<html>
<ul>
<li><i>June 15, 2017&nbsp;</i> by Tobias Blacha:<br/>
Moved into AixLib</li>
<li><i>August 03, 2014&nbsp;</i> by Ana Constantin:<br/>
Implemented.</li>
</ul>
</html>"));
end Panel_Dis1D;
