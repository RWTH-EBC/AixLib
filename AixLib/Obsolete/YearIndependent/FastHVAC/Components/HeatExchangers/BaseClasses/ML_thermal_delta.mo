within AixLib.Obsolete.YearIndependent.FastHVAC.Components.HeatExchangers.BaseClasses;
model ML_thermal_delta "Multi layers of heat exchanger"
  import calcT =
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp;

  /* *******************************************************************
     Parameters
     ******************************************************************* */

     parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Standard charastics for fluid (heat capacity, density, thermal conductivity)";

  parameter Modelica.Units.SI.Mass m_radiator=20;
  parameter calcT.Temp calc_dT
    "Select calculation method of excess temperature";
  parameter AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.RadiatorType
  Type
  "Type of radiator" annotation (choicesAllMatching=true, Dialog(tab="Geometry and Material", group="Geometry"));
  parameter Real n=1.3  annotation (Dialog(tab="Geometry and Material", group="Geometry"));
  parameter Modelica.Units.SI.Density densitySteel=densitySteel
    "Specific density of steel, in kg/m3"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
//   parameter Modelica.SIunits.Density densityWater=densityWater
//     "Specific density of Water, in kg/m3";

  parameter Modelica.Units.SI.SpecificHeatCapacity capacitySteel=capacitySteel
    "Specific heat capacity of steel, in J/kgK"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
//    parameter Modelica.SIunits.SpecificHeatCapacity capacityWater=capacityWater
//     "Specific heat capacity of Water, in J/kgK";

  parameter Modelica.Units.SI.ThermalConductivity lambdaSteel=lambdaSteel
    "Thermal conductivity of steel, in W/mK"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.Units.SI.Length length=1.05 "Length of radiator, in m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry"));
  parameter Modelica.Units.SI.Temperature T0=
      Modelica.Units.Conversions.from_degC(55) "Initial temperature, in Kelvin"
    annotation (Dialog(group="Miscellaneous"));

  parameter Modelica.Units.SI.Volume vol_water=0.0001;
  parameter Real s_eff=Type[1];
  parameter Real dotQ_nomLayer=100 "Nominal power of single layer";
  parameter Modelica.Units.SI.Temperature dT_nom=50
    "Nominal access temperature";
  parameter Modelica.Units.SI.Temperature delta_nom=50
    "Nominal Radiation temperature";
  parameter Modelica.Units.SI.Emissivity eps=0.95 "Emissivity";
  parameter Modelica.Units.SI.Area A=1 "Area of radiator layer";
  parameter Modelica.Units.SI.Length d=0.025 "Thickness of radiator wall";

  Modelica.Units.SI.Temperature Tin;
  Modelica.Units.SI.Temperature Tout;
  Modelica.Units.SI.Temperature Trad;
  Modelica.Units.SI.Temperature Tair;
  Real dT_V;
  Real dT_R;

  /* *******************************************************************
      Components
     ******************************************************************* */

  Fluid.HeatExchangers.Radiators.BaseClasses.HeatConvRadiator     heatConv_Radiator(
    n=n,
    NominalPower=dotQ_nomLayer,
    s_eff=s_eff,
    dT_nom=dT_nom) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-52,48})));
  AixLib.Utilities.HeatTransfer.HeatToRad twoStar_RadEx(eps=1, A=(s_eff*dotQ_nomLayer)/((delta_nom)*Modelica.Constants.sigma*eps)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={32,46})));
  Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorWall     radiatorWall(
    lambda=lambdaSteel,
    c=capacitySteel,
    d=d,
    T0=T0,
    A=A,
    C=m_radiator*capacitySteel) annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-13,9})));
  Sensors.TemperatureSensor                     temperatureIn
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Sensors.TemperatureSensor                     temperatureOut
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  AixLib.Utilities.Interfaces.RadPort Radiative annotation (Placement(transformation(extent={{36,70},{56,90}}), iconTransformation(extent={{36,70},{56,90}})));
  FastHVAC.BaseClasses.WorkingFluid radiatorFluid(
    T0=T0,
    medium=medium,
    m_fluid=medium.rho*vol_water)
    annotation (Placement(transformation(extent={{-20,-62},{4,-38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Convective "Therm1"
    annotation (Placement(transformation(extent={{-64,72},{-40,96}})));
  Interfaces.EnthalpyPort_b          enthalpyPort_b1 annotation (Placement(
        transformation(extent={{90,0},{110,20}}), iconTransformation(extent=
           {{90,0},{110,20}})));
  Interfaces.EnthalpyPort_a          enthalpyPort_a1 annotation (Placement(
        transformation(extent={{-110,0},{-90,20}}), iconTransformation(
          extent={{-110,0},{-90,20}})));
equation

  /* **********calculation of excess temperature***************************/
Tin=temperatureIn.T;
Tout=temperatureOut.T;
Tair=Convective.T;
Trad=Radiative.T;

  /* **********calculation of excess temperature***************************/
dT_V=Tin - Tair;
dT_R=Tout - Tair;

  connect(twoStar_RadEx.rad, Radiative) annotation (Line(
      points={{32,55.1},{36,55.1},{36,80},{46,80}},
      color={95,95,95},
      pattern=LinePattern.None,
      smooth=Smooth.None));
  connect(temperatureOut.enthalpyPort_b, enthalpyPort_b1) annotation (Line(
      points={{59,-50.1},{59,-16.05},{100,-16.05},{100,10}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(temperatureIn.enthalpyPort_a, enthalpyPort_a1) annotation (Line(
      points={{-78.8,-50.1},{-78.8,-17.05},{-100,-17.05},{-100,10}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(temperatureIn.enthalpyPort_b, radiatorFluid.enthalpyPort_a)
    annotation (Line(
      points={{-61,-50.1},{-40.5,-50.1},{-40.5,-50},{-18.8,-50}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(radiatorFluid.enthalpyPort_b, temperatureOut.enthalpyPort_a)
    annotation (Line(
      points={{2.8,-50},{22,-50},{22,-50.1},{41.2,-50.1}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(radiatorFluid.heatPort, radiatorWall.port_a) annotation (Line(
      points={{-8,-38.72},{-10,-38.72},{-10,-1.34},{-13.22,-1.34}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radiatorWall.port_b, heatConv_Radiator.port_a) annotation (Line(
      points={{-13,19.34},{-52,19.34},{-52,39}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(radiatorWall.port_b, twoStar_RadEx.conv) annotation (Line(
      points={{-13,19.34},{32,19.34},{32,36.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatConv_Radiator.port_b, Convective) annotation (Line(
      points={{-52,57.4},{-52,84}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}),
                                      graphics={
        Polygon(
          points={{20,-60},{60,-75},{20,-90},{20,-60}},
          lineColor={176,0,0},
          smooth=Smooth.None,
          fillColor={176,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,-65},{50,-75},{20,-85},{20,-65}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{55,-75},{-60,-75}},
          color={176,0,0},
          smooth=Smooth.None),
        Ellipse(
          extent={{-110,36},{-90,-14}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          visible=port_a_exposesState),
        Ellipse(
          extent={{90,35},{110,-15}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          visible=port_b_exposesState),
        Rectangle(
          extent={{-54,68},{72,48}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-54,48},{72,28}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-54,28},{72,8}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-54,-34},{72,-54}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{6,62},{14,56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "1"),
        Text(
          extent={{6,40},{14,34}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "2"),
        Text(
          extent={{6,22},{14,16}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "3"),
        Text(
          extent={{2,4},{18,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "."),
        Text(
          extent={{2,-6},{18,-18}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "."),
        Text(
          extent={{2,-14},{18,-26}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "."),
        Text(
          extent={{8,-42},{16,-48}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "n"),
        Line(
          points={{-76,60},{-58,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-56,-46},{-70,-46}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Text(
          extent={{-70,84},{-56,74}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "Tin"),
        Text(
          extent={{-52,-76},{-68,-64}},
          lineColor={0,0,0},
          lineThickness=0.5,
          textString=
               "Tout"),
        Line(
          points={{-70,-46},{-62,-38}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-62,-54},{-70,-46}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-66,68},{-58,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Line(
          points={{-66,52},{-58,60}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None)}),
    Documentation(revisions="<html><ul>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>December 16, 2014&#160;</i> by Konstantin Finkbeiner:<br/>
    Derived from HVAC.
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
end ML_thermal_delta;
