within AixLib.FastHVAC.Components.HeatExchangers;
model RadiatorMultiLayer "Simple radiator multilayer model"
  import Modelica.SIunits;
  import calcT =
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp;

  parameter AixLib.FastHVAC.Media.BaseClasses.MediumSimple medium= AixLib.FastHVAC.Media.WaterSimple()
    "Standard charastics for water (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);

  /* *******************************************************************
  Radiator Multilayer Parameters
      ******************************************************************* */

  parameter Boolean selectable=false "Radiator record" annotation(Dialog(group="Radiator Data"));
  parameter AixLib.DataBase.Radiators.RadiatorBaseDataDefinition radiatorType
    "Choose a radiator" annotation (Dialog(group="Radiator Data", enable=
          selectable), choicesAllMatching=true);
  parameter
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.RadiatorType
    Type=(if selectable then
      radiatorType.Type else AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator10)
    "Type of radiator" annotation (choicesAllMatching=true, Dialog(
      tab="Geometry and Material",
      group="Geometry",
      enable=not selectable));
  parameter Real nominalPower=(if selectable then radiatorType.NominalPower else 1000)
    "Nominal power of radiator per meter at nominal temperatures in W/m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter Real exponent=(if selectable then radiatorType.Exponent else 1.29)
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
    parameter SIunits.Length length=(if selectable then radiatorType.length else 1)
    "Length of radiator, in m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter SIunits.Length height=(if selectable then radiatorType.height else 0.6)
    "Height of raditor, in m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter Modelica.SIunits.Area A=2*length*height
    annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.SIunits.Length d=0.025 "Thickness of radiator wall"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity"
    annotation (Dialog(tab="Geometry and Material", group="Material"));

  /* *********Water And Steel Parameters**********************************/
  parameter Real volumeWater( unit="l/m")=(if selectable then radiatorType.VolumeWater else 20)
    "Water volume inside radiator per m, in l/m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter Modelica.SIunits.LinearDensity massSteel=(if selectable then radiatorType.MassSteel else 30)
    "Material mass of radiator per m, in kg/m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter SIunits.Density densitySteel=(if selectable then radiatorType.DensitySteel else 7900)
    "Specific density of steel, in kg/m3"
    annotation (Dialog(tab="Geometry and Material", group="Material", enable=not selectable));

  parameter SIunits.SpecificHeatCapacity capacitySteel=(if selectable then radiatorType.CapacitySteel else 551)
    "Specific heat capacity of steel, in J/kgK"
    annotation (Dialog(tab="Geometry and Material", group="Material", enable=not selectable));

  parameter SIunits.ThermalConductivity lambdaSteel=(if selectable then radiatorType.LambdaSteel else 60)
    "Thermal conductivity of steel, in W/mK"
    annotation (Dialog(tab="Geometry and Material", group="Material", enable=not selectable));
  parameter SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius"
    annotation (Dialog(group="Miscellaneous"));
  parameter SIunits.Temperature RT_nom[3]=
    (if selectable then Modelica.SIunits.Conversions.from_degC(radiatorType.RT_nom)
    else Modelica.SIunits.Conversions.from_degC({75,65,20}))
    "Nominal temperatures (TIn, TOut, TAir) according to DIN-EN 442."
    annotation (Dialog(group="Miscellaneous",enable=not selectable));
  parameter Integer N=16 "Number of discretisation layers";
  parameter AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.Temp
    calc_dT=calcT.exp
    "Select calculation method";
  /* *********Select calculation method**********************************/
//
// protected
//    parameter SIunits.SpecificHeatCapacity capacityWater = medium.c
//     "Specific heat capacity of Water, in J/kgK";
//   parameter SIunits.Density densityWater=medium.rho
//     "Specific density of water, in kg/m3";

  SIunits.Temperature TV_1;
  SIunits.Temperature TR_N;
protected
   parameter Modelica.SIunits.Temperature T0_N[N]= {(T0-ki*0.2) for ki in 1:N};
  parameter SIunits.Volume vol_water=(length*volumeWater/1000)/N;
  parameter SIunits.Volume vol_steel=(length*massSteel) / densitySteel /N
    annotation (Dialog(tab="Geometry and Material", group="Geometry"));

    parameter SIunits.Length d1=2*(vol_water/Modelica.Constants.pi/length)^0.5
    "inner diameter of single layer";
  parameter SIunits.Length d2=2*((vol_water+vol_steel)/Modelica.Constants.pi/length)^0.5
    "outer diameter of single layer";

  parameter Modelica.SIunits.TemperatureDifference dT_V_nom=RT_nom[1]-RT_nom[3]
    "Temperature difference between the nominal temperatures Tin and Tair";
  parameter Modelica.SIunits.TemperatureDifference dT_R_nom=RT_nom[2]-RT_nom[3]
    "Temperature difference between the nominal temperatures Tout and Tair";

  /* *********Calculation of convective excess temperature, according to the chosen calculation method**********************************/
  parameter Real dT_nom=if calc_dT==calcT.ari then (dT_V_nom+dT_R_nom)/2 else
  if calc_dT==calcT.log then (dT_V_nom-dT_R_nom)/log(dT_V_nom/dT_R_nom) else
  ((exponent-1)*(dT_V_nom-dT_R_nom)/(dT_R_nom^(1-exponent)-dT_V_nom^(1-exponent)))^(1/exponent)
    "Convective excess temperature";

  /* *********Calculation of nominal radiation excess temperature**********************************/
  parameter SIunits.Temperature delta_nom=(dT_nom+RT_nom[3])*(dT_nom+RT_nom[3])*(dT_nom+RT_nom[3])*(dT_nom+RT_nom[3])-RT_nom[3]*RT_nom[3]*RT_nom[3]*RT_nom[3]
    "Nominal radiation excess temperature";
  parameter SIunits.Power dotQ_nomLayer= length * nominalPower/N
    "Nominal heat flow";
  /* *******************************************************************
      Components
     ******************************************************************* */

public
  BaseClasses.ML_thermal_delta                                   hexRadiator[
    N](
    medium=fill(medium, N),
    m_radiator=fill((length*massSteel)/N, N),
    Type=fill(Type, N),
    n=fill(exponent, N),
    densitySteel=fill(densitySteel, N),
    capacitySteel=fill(capacitySteel, N),
    length=fill(length, N),
    T0=T0_N,
    s_eff=fill(Type[1], N),
    dotQ_nomLayer=fill(dotQ_nomLayer, N),
    dT_nom=fill(dT_nom, N),
    delta_nom=fill(delta_nom, N),
    lambdaSteel=fill(lambdaSteel, N),
    eps=fill(eps, N),
    A=fill(A/N, N),
    d=fill(d, N),
    vol_water=fill(vol_water, N),
    calc_dT=fill(calc_dT, N))
    annotation (Placement(transformation(extent={{-28,-64},{30,12}})));
// densityWater=fill(densityWater, N),
//     capacityWater=fill(capacityWater, N),
  Sensors.TemperatureSensor flowTemperature
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Sensors.TemperatureSensor returnTemperature
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a
                           ConvectiveHeat
    annotation (Placement(transformation(extent={{-64,48},{-44,68}}),
        iconTransformation(extent={{-64,48},{-44,68}})));
  AixLib.Utilities.Interfaces.Star RadiativeHeat annotation (Placement(
        transformation(extent={{46,50},{66,70}}), iconTransformation(extent={{
            46,50},{66,70}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b1 "radiator_Out" annotation (
      Placement(transformation(extent={{70,-12},{90,8}}), iconTransformation(
          extent={{70,-12},{90,8}})));
  Interfaces.EnthalpyPort_a enthalpyPort_a1 "radiator_In" annotation (Placement(
        transformation(extent={{-90,-12},{-70,8}}), iconTransformation(extent={{
            -90,-12},{-70,8}})));
equation

  TV_1=hexRadiator[1].Tin;
  TR_N=hexRadiator[N].Tout;

  for i in 1:N loop
    connect(hexRadiator[i].Convective, ConvectiveHeat);
    connect(hexRadiator[i].Radiative, RadiativeHeat);
  end for;

  for j in 1:(N-1) loop
    connect(hexRadiator[j].enthalpyPort_b1, hexRadiator[j+1].enthalpyPort_a1);
  end for;
  connect(flowTemperature. enthalpyPort_b, hexRadiator[1].enthalpyPort_a1);
  connect(returnTemperature. enthalpyPort_a, hexRadiator[N].enthalpyPort_b1);

  connect(flowTemperature.enthalpyPort_a, enthalpyPort_a1) annotation (Line(
      points={{-78.8,-50.1},{-80,-50.1},{-80,-2}},
      color={176,0,0},
      smooth=Smooth.None));
  connect(returnTemperature.enthalpyPort_b, enthalpyPort_b1) annotation (Line(
      points={{79,-50.1},{79,-2},{80,-2}},
      color={176,0,0},
      smooth=Smooth.None));
    annotation (Line(
      points={{-55,-36.1},{-41.5,-36.1},{-41.5,-22.2},{-28,-22.2}},
      color={176,0,0},
      smooth=Smooth.None),
                Line(
      points={{30,-22.2},{44,-22.2},{44,-40.12},{57.44,-40.12}},
      color={176,0,0},
      smooth=Smooth.None),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{14,-60},{54,-75},{14,-90},{14,-60}},
          lineColor={176,0,0},
          smooth=Smooth.None,
          fillColor={176,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{14,-65},{44,-75},{14,-85},{14,-65}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{49,-75},{-66,-75}},
          color={176,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-139,-104},{161,-144}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-64,72},{-56,-58}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,72},{-36,-58}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-24,72},{-16,-58}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,72},{4,-58}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{16,72},{24,-58}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{36,72},{44,-58}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{56,72},{64,-58}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,-44},{66,-54}},
          lineColor={95,95,95},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,66},{68,56}},
          lineColor={95,95,95},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid)}),
              Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The Radiator model represents a heating device. This model also
  includes the conduction through the radiator wall.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The Radiator model represents a heating device. Heat energy taken
  from the hot water flow through the device is being emitted via
  convective and radiative energy transport connectors. The ratio of
  convective and radiative energy flows depends on the type of the
  heating device (see table).
</p>
<p>
  T_source output is relevant for exergy analysis. It describes
  the&#160;logarithmic&#160;mean&#160;temperature&#160;is&#160;calculated&#160;from&#160;the&#160;temperatures&#160;at&#160;in-&#160;and&#160;outlet&#160;of&#160;the&#160;radiator.
</p>
<table summary=\"equation for multilayer\" cellspacing=\"0\" cellpadding=
\"2\" border=\"1\">
  <tr>
    <td>
      <h4>
        Type
      </h4>
    </td>
    <td>
      <h4>
        Fraction of convective transport
      </h4>
    </td>
    <td>
      <h4>
        Fraction of radiative transport
      </h4>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>SectionalRadiator</i>
      </p>
      <p>
        Simple (vertical) sectional radiator
      </p>
    </td>
    <td>
      <p>
        0.70
      </p>
    </td>
    <td>
      <p>
        0.30
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>PanelRadiator10</i>
      </p>
      <p>
        10 -- Panel radiator (single panel) without convection device
      </p>
    </td>
    <td>
      <p>
        0.50
      </p>
    </td>
    <td>
      <p>
        0.50
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>PanelRadiator11</i>
      </p>
      <p>
        11 -- Panel radiator (single panel) with one convection device
      </p>
    </td>
    <td>
      <p>
        0.65
      </p>
    </td>
    <td>
      <p>
        0.35
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>PanelRadiator12</i>
      </p>
      <p>
        12 -- Panel radiator (single panel) with two convection devices
      </p>
    </td>
    <td>
      <p>
        0.75
      </p>
    </td>
    <td>
      <p>
        0.25
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>PanelRadiator20</i>
      </p>
      <p>
        20 -- Panel radiator (two panels) without convection device
      </p>
    </td>
    <td>
      <p>
        0.65
      </p>
    </td>
    <td>
      <p>
        0.35
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>PanelRadiator21</i>
      </p>
      <p>
        21 -- Panel radiator (two panels) with one convection device
      </p>
    </td>
    <td>
      <p>
        0.80
      </p>
    </td>
    <td>
      <p>
        0.20
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>PanelRadiator22</i>
      </p>
      <p>
        22 -- Panel radiator (two panels) with two convection devices
      </p>
    </td>
    <td>
      <p>
        0.85
      </p>
    </td>
    <td>
      <p>
        0.15
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>PanelRadiator30</i>
      </p>
      <p>
        30 -- Panel radiator (three panels) without convection device
      </p>
    </td>
    <td>
      <p>
        0.80
      </p>
    </td>
    <td>
      <p>
        0.20
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>PanelRadiator31</i>
      </p>
      <p>
        31 -- Panel radiator (three panels) with one convection device
      </p>
    </td>
    <td>
      <p>
        0.85
      </p>
    </td>
    <td>
      <p>
        0.15
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>PanelRadiator32</i>
      </p>
      <p>
        32 -- Panel radiator (three panels) with two or more convection
        devices
      </p>
    </td>
    <td>
      <p>
        0.90
      </p>
    </td>
    <td>
      <p>
        0.10
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>ConvectorHeaterUncovered</i>
      </p>
      <p>
        Convector heater without cover
      </p>
    </td>
    <td>
      <p>
        0.95
      </p>
    </td>
    <td>
      <p>
        0.05
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <i>ConvectorHeaterCovered</i>
      </p>
      <p>
        Convector heater with cover
      </p>
    </td>
    <td>
      <p>
        1.00
      </p>
    </td>
    <td>
      <p>
        - no radiative transport -
      </p>
    </td>
  </tr>
</table>
<p>
  <br/>
  The Height H of the radiator is discretized in N single Layers, as
  shown in Figure 1
</p>
<p>
  <br/>
  <img src=
  \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Schichtenmodell.png\"
  alt=\"Multilayer Model of radiator \" />
</p>
<p>
  Figure 1: Multilayer Model of radiator
</p>
<p>
  For every layer the equation (1) is solved.
</p>
<table summary=\"\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\">
  <tr>
    <td>
      <p>
        <br/>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/DGL_HK.png\"
        alt=\"Equation for every layer\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (1)
      </p>
    </td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>
<p>
  The total heat emission consists of a convective and a radiative
  part.
</p>
<table summary=\"\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\">
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Q_ab.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (2)
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Q_K1.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (3)
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Q_R1.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (4)
      </p>
    </td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>
<p>
  The convective heat emission is proportional to <img src=
  \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/deltaT.png\"
  alt=\"\" /> &#160;.
</p>
<p>
  The radiative heat emission is proportional to <img src=
  \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/delta.png\"
  alt=\"\" /> &#160;=(T_L + DeltaT)^4-TR^4 (T_L: Room Temperature, DeltaT:
  heater excess temperature, T_R: radiative temperature).
</p>
<table summary=\"\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\">
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Q_K.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (5)
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Q_R.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (6)
      </p>
    </td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>
<p>
  The heat emission of the radiator depends on the heater excess
  temperature. In the model it is possible to choose between:
</p>
<table summary=\"\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\">
  <tr>
    <td>
      <h4>
        Method
      </h4>
    </td>
    <td>
      <h4>
        Formula
      </h4>
    </td>
    <td></td>
  </tr>
  <tr>
    <td>
      <p>
        arithmetic heater excess temperature
      </p>
    </td>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Delta_T_ari.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (7)
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        logarithmic heater excess temperature
      </p>
    </td>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Delta_T_log.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (8)
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        exponential heater excess temperature according to [2]
      </p>
    </td>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Delta_T_exp.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (9)
      </p>
    </td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</table>
<p>
  Due to stability reasons and accuracy at small heating medium flow,
  an exponential calculation of the heater excess temperture is
  recommended. The function \"calcHeaterExcessTemp \" regularize the
  discontinuities in equation (9).
</p>
<p>
  The radiator exponent according to DIN 442 is valid for the total
  heat emission. the radiative heat emission part grows larger. This is
  considered by the following formulas:
</p>
<table summary=\"\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\">
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/n_K1.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (10)
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/n_K2.png\"
        alt=\"\" />
      </p>
    </td>
    <td>
      <p>
        <br/>
        (11)
      </p>
    </td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
</table>
<p>
  The modified convective exponent is calculated by (11). The region of
  discontinuity in eq. (11) has not yet been regulized, so a constant
  radiator exponent is used for now.
</p>
<p>
  In the model the heat emission is calculated according to eq. (5),
  (6) for every layer and the respective power is connected to the romm
  via the thermal ports. A varHeatSource (inPort=total heat emission)
  is connected via a thermal port to the enthalpie flow of the heating
  medium and the stored heat in the radiator mass.
</p>
<table summary=\"\" cellspacing=\"0\" cellpadding=\"2\" border=\"1\">
  <tr>
    <td></td>
  </tr>
</table>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Knowing the heat load of the room, an appropriate radiator can be
  choosen out of a Radiator DataBase via a record. But it is also
  possible to simulate with arbitrary parameters.
</p>
<p>
  The thermal part of the model is adapted from [3] and [1].
</p>
<ul>
  <li>[1] Glück, Bernd: Wärmeübertragung - Wärmeabgabe von
  Raumheizflächen und Rohren, 1990
  </li>
  <li>[2] Nadler,Norbert: Die Wärmeleistung von Raumheizkörpern in
  expliziter Darstellung, In: HLH Lüftung/Klima - Heizung/Sanitär -
  Gebäudetechnik 11, S.621 - 624, 1991
  </li>
  <li>[3] Tritschler, Markus: Bewertung der Genauigkeit von
  Heizkostenverteilern, Dissertation, Uni Stuttart, 1999
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.FastHVAC.Examples.HeatExchangers.RadiatorMultiLayer.ValidationRadiator\">
  ValidationRadiator</a>
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>February, 2 2018&#160;</i> David Jansen:<br/>
    Formatted documentation
  </li>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>January 12, 2015&#160;</i> by Konstantin Finkbeiner:<br/>
    Addapted to FastHVAC.
  </li>
  <li>
    <i>November 28, 2014&#160;</i> by Roozbeh Sangi:<br/>
    Output for logarithmic mean temperature added
  </li>
  <li>
    <i>October 7, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>Mai 1, 2011&#160;</i> by Ana Constantin:<br/>
    Addapted with a few changes from older model.
  </li>
</ul>
</html>"),
    experiment(
      StopTime=864000,
      Interval=30,
      Algorithm="Lsodar"),
    experimentSetupOutput);
end RadiatorMultiLayer;
