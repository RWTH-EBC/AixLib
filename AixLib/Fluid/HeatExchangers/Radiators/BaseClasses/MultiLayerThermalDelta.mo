within AixLib.Fluid.HeatExchangers.Radiators.BaseClasses;
model MultiLayerThermalDelta "multi layers of heat exchanger"

  import calcT =
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp;
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter Modelica.SIunits.Mass M_Radiator
    "Mass of radiator";
  parameter calcT.Temp calc_dT
    "Select calculation method of excess temperature";
  parameter
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.RadiatorType
    Type
    "Type of radiator" annotation (choicesAllMatching=true, Dialog(tab=
          "Geometry and Material", group="Geometry"));
  parameter Real n
    "Radiator exponent"
    annotation (Dialog(tab="Geometry and Material", group="Geometry"));
  parameter Modelica.SIunits.Density DensitySteel=DensitySteel
    "Specific density of steel, in kg/m3"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.SIunits.SpecificHeatCapacity CapacitySteel=CapacitySteel
    "Specific heat capacity of steel, in J/kgK"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.SIunits.ThermalConductivity LambdaSteel=LambdaSteel
    "Thermal conductivity of steel, in W/mK"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.SIunits.Length length
    "Length of radiator, in m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry"));
  parameter Modelica.SIunits.Temperature T0
    "Initial temperature"
    annotation (Dialog(group="Miscellaneous"));
  parameter Modelica.SIunits.Volume Vol_Water
    "Water volume inside layer";
  parameter Real s_eff=Type[1]
    "Radiative coefficient";
  parameter Real Q_dot_nom_i
    "Nominal power of single layer";
  parameter Real dT_nom
    "Nominal access temperature";
  parameter Real delta_nom
    "Nominal Radiation temperature";
  parameter Modelica.SIunits.Emissivity eps
    "Emissivity";
  parameter Modelica.SIunits.Area A
    "Area of radiator layer";
  parameter Modelica.SIunits.Length d
    "Thickness of radiator wall";
  Real dT_V;
  Real dT_R;
  Modelica.SIunits.Temperature TIn;
  Modelica.SIunits.Temperature TOut;
  Modelica.SIunits.Temperature TRad;
  Modelica.SIunits.Temperature TAir;
  AixLib.Utilities.Interfaces.RadPort radiative annotation (Placement(transformation(extent={{22,73},{40,89}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a convective
    annotation (Placement(transformation(extent={{-48,74},{-32,88}},
          rotation=0)));
  Utilities.HeatTransfer.HeatToRad twoStar_RadEx(A=(s_eff*Q_dot_nom_i)/((delta_nom)*Modelica.Constants.sigma*eps), eps=1) annotation (Placement(transformation(
        origin={41,51},
        extent={{-11,-23},{11,23}},
        rotation=90)));
  AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.HeatConvRadiator
    heatConv_Radiator(
    n=n,
    NominalPower=Q_dot_nom_i,
    s_eff=s_eff,
    dT_nom=dT_nom) annotation (Placement(transformation(
        origin={-17,51},
        extent={{-11,-27},{11,27}},
        rotation=90)));
  AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorWall radiator_wall(
    lambda=LambdaSteel,
    c=CapacitySteel,
    d=d,
    T0=T0,
    A=A,
    C=M_Radiator*CapacitySteel) annotation (Placement(transformation(
        origin={-11,20},
        extent={{-8,-31},{8,31}},
        rotation=90)));
  AixLib.Fluid.MixingVolumes.MixingVolume Volume(
    redeclare package Medium = Medium,
    T_start=T0,
    V=Vol_Water,
    nPorts=2,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-16,-28},{6,-6}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort   temperatureIn(redeclare package Medium =
               Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-70,-38},{-50,-18}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort   temperatureOut(redeclare package Medium =
               Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{50,-38},{70,-18}})));
equation
 // Calculation of excess temperature
TIn=temperatureIn.T;
TOut=temperatureOut.T;
TAir=convective.T;
TRad=radiative.T;

// Calculation of excess temperature
dT_V=TIn - TAir;
dT_R=TOut - TAir;

  connect(port_a, temperatureIn.port_a) annotation (Line(
      points={{-100,0},{-80,0},{-80,-28},{-70,-28}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperatureIn.port_b, Volume.ports[1]) annotation (Line(
      points={{-50,-28},{-7.2,-28}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(Volume.ports[2], temperatureOut.port_a) annotation (Line(
      points={{-2.8,-28},{50,-28}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(temperatureOut.port_b, port_b) annotation (Line(
      points={{70,-28},{80,-28},{80,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatConv_Radiator.port_b, convective) annotation (Line(
      points={{-17,61.34},{-17,68},{-40,68},{-40,81}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radiator_wall.port_b, heatConv_Radiator.port_a) annotation (Line(
      points={{-11,27.52},{-11,32},{-17,32},{-17,41.1}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radiator_wall.port_b, twoStar_RadEx.conv) annotation (Line(
      points={{-11,27.52},{-11,32},{41,32},{41,40.88}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(twoStar_RadEx.rad, radiative) annotation (Line(
      points={{41,61.01},{41,68.505},{31,68.505},{31,81}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(Volume.heatPort, radiator_wall.port_a) annotation (Line(
      points={{-16,-17},{-22,-17},{-22,-16},{-28,-16},{-28,0},{-11.62,0},{
          -11.62,12.48}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics={Text(
          extent={{10,102},{54,88}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "radiative"), Text(
          extent={{-64,106},{-16,84}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "Convective")}),
                       Icon(graphics={
        Rectangle(
          extent={{-54,58},{72,38}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-54,38},{72,18}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-54,18},{72,-2}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-54,-44},{72,-64}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{6,52},{14,46}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "1"),
        Text(
          extent={{6,30},{14,24}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "2"),
        Text(
          extent={{6,12},{14,6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "3"),
        Text(
          extent={{2,-6},{18,-18}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "."),
        Text(
          extent={{2,-16},{18,-28}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "."),
        Text(
          extent={{2,-24},{18,-36}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "."),
        Text(
          extent={{8,-52},{16,-58}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "n"),
        Line(
          points={{-76,50},{-58,50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-56,-56},{-70,-56}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Text(
          extent={{-70,74},{-56,64}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "TIn"),
        Text(
          extent={{-52,-86},{-68,-74}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "TOut"),
        Line(
          points={{-70,-56},{-62,-48}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-62,-64},{-70,-56}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-66,58},{-58,50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-66,42},{-58,50}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None)}),
    Documentation(revisions="<html><ul>
  <li>
    <i>October, 2016&#160;</i> by Peter Remmen:<br/>
    Transfer to AixLib.
  </li>
  <li>
    <i>October 7, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>
", info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model of the multi layers of heat exchanger. From the water flow is
  the convective and radiative heat output calculated.
</p>
</html>"));
end MultiLayerThermalDelta;
