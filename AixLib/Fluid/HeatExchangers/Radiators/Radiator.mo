within AixLib.Fluid.HeatExchangers.Radiators;
model Radiator "Radiator multilayer model"
  import Modelica.SIunits;
  import calcT =
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp;
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  // parameter Real kv=.1;
  parameter Boolean selectable=false
    "Radiator record" annotation(Dialog(group="Radiator Data"));
  parameter AixLib.DataBase.Radiators.RadiatorBaseDataDefinition radiatorType
    "Choose a radiator" annotation (Dialog(group="Radiator Data", enable=
          selectable), choicesAllMatching=true);
  parameter
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.RadiatorType
    Type=(if selectable then
      radiatorType.Type else BaseClasses.RadiatorTypes.PanelRadiator10)
    "Type of radiator" annotation (choicesAllMatching=true, Dialog(
      tab="Geometry and Material",
      group="Geometry",
      enable=not selectable));
  parameter Real NominalPower=
    (if selectable then radiatorType.NominalPower else 1000)
    "Nominal power of radiator per meter at nominal temperatures in W/m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry",
    enable=not selectable));
  parameter Real Exponent=(if selectable then radiatorType.Exponent else 1.29)
    "Radiator exponent"
    annotation (Dialog(tab="Geometry and Material", group="Geometry",
    enable=not selectable));
  parameter Real VolumeWater(unit="l/m")=
    (if selectable then radiatorType.VolumeWater else 20)
    "Water volume inside radiator per m, in l/m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry",
    enable=not selectable));
  parameter Real MassSteel(unit="kg/m")=
    (if selectable then radiatorType.MassSteel else 30)
    "Material mass of radiator per m, in kg/m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry",
    enable=not selectable));
  parameter SIunits.Density DensitySteel=
    (if selectable then radiatorType.DensitySteel else 7900)
    "Specific density of steel, in kg/m3"
    annotation (Dialog(tab="Geometry and Material", group="Material",
    enable=not selectable));
  parameter SIunits.SpecificHeatCapacity CapacitySteel=
    (if selectable then radiatorType.CapacitySteel else 551)
    "Specific heat capacity of steel, in J/kgK"
    annotation (Dialog(tab="Geometry and Material", group="Material",
    enable=not selectable));
  parameter SIunits.ThermalConductivity LambdaSteel=
    (if selectable then radiatorType.LambdaSteel else 60)
    "Thermal conductivity of steel, in W/mK"
    annotation (Dialog(tab="Geometry and Material", group="Material",
    enable=not selectable));
  parameter SIunits.Length length=
    (if selectable then radiatorType.length else 1)
    "Length of radiator, in m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry",
    enable=not selectable));
  parameter SIunits.Length height=
    (if selectable then radiatorType.height else 0.6)
    "Height of raditor, in m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry",
    enable=not selectable));
  parameter Modelica.SIunits.Area A=2*length*height
    "Radiator surface area"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.SIunits.Length d=0.025 "Thickness of radiator wall"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity"
    annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius"
    annotation (Dialog(group="Miscellaneous"));
  parameter SIunits.Temperature RT_nom[3]=
    (if selectable then radiatorType.RT_nom
    else Modelica.SIunits.Conversions.from_degC({75,65,20}))
    "Nominal temperatures (TIn, TOut, TAir) according to DIN-EN 442."
    annotation (Dialog(group="Miscellaneous",enable=not selectable));
  parameter Real PD = (if selectable then radiatorType.PressureDrop else 548208)
    "Pressure drop coefficient, delta_p[Pa] = PD*m_flow[kg/s]^2"
    annotation (Dialog(group="Miscellaneous", enable=not selectable));
  parameter Integer N=16
    "Number of discretisation layers";
  parameter AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.Temp
    calc_dT=calcT.exp
    "Select calculation method";
  SIunits.Temperature TV_1;
  SIunits.Temperature TR_N;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvectiveHeat
    "Convective heat port to room"
    annotation (Placement(transformation(extent={{-60,20},{-44,36}}, rotation=
           0), iconTransformation(extent={{-30,10},{-10,30}})));
  AixLib.Utilities.Interfaces.RadPort RadiativeHeat "Radiative heat port to room" annotation (Placement(transformation(extent={{30,12},{50,30}}, rotation=0), iconTransformation(extent={{30,10},{50,30}})));
  Sensors.TemperatureTwoPort FlowTemperature(redeclare package Medium =
             Medium,
    m_flow_nominal=m_flow_nominal)
    "Flow temperature"
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  Sensors.TemperatureTwoPort ReturnTemperature(redeclare package Medium =
             Medium,
    m_flow_nominal=m_flow_nominal)
    "Return temperature"
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));
  BaseClasses.PressureDropRadiator pressureDropRadiator(redeclare package Medium =
             Medium, PD=PD,
    m_flow_small=0.01)
    "Base class of radiator"
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));

protected
  parameter Modelica.SIunits.Temperature T0_N[N]= {(T0-ki*0.2) for ki in 1:N};
  parameter SIunits.Volume Vol_Water=(length*VolumeWater/1000)/N
    "Volume of water";
  parameter SIunits.Volume Vol_Steel=(length*MassSteel) / DensitySteel /N
    "Volume of steel"
    annotation (Dialog(tab="Geometry and Material", group="Geometry"));
  parameter SIunits.Length d1=2*(Vol_Water/Modelica.Constants.pi/length)^0.5
    "Inner diameter of single layer";
  parameter SIunits.Length d2=
    2*((Vol_Water+Vol_Steel)/Modelica.Constants.pi/length)^0.5
    "Outer diameter of single layer";
  parameter Real dT_V_nom=RT_nom[1]-RT_nom[3];
  parameter Real dT_R_nom=RT_nom[2]-RT_nom[3];

// Calculation of convective excess temperature, according to the chosen calculation method

  parameter Real dT_nom=if calc_dT==calcT.ari then (dT_V_nom+dT_R_nom)/2 else
    if calc_dT==calcT.log then (dT_V_nom-dT_R_nom)/log(dT_V_nom/dT_R_nom) else
    ((Exponent-1)*(dT_V_nom-dT_R_nom)/(dT_R_nom^(1-Exponent)-dT_V_nom^
    (1-Exponent)))^(1/Exponent)
    "Nominal temperature difference";

// Calculation of nominal radiation excess temperature

  parameter Real delta_nom=(dT_nom+RT_nom[3])*(dT_nom+RT_nom[3])*
    (dT_nom+RT_nom[3])*(dT_nom+RT_nom[3])-RT_nom[3]*RT_nom[3]*RT_nom[3]*RT_nom[3];
  parameter SIunits.Power Q_dot_nom_i= length * NominalPower/N
    "Nominal heating power per layer";

  BaseClasses.MultiLayerThermalDelta multiLayer_HE[N](
    redeclare each package Medium = Medium,
    each M_Radiator=(length*MassSteel)/N,
    each calc_dT=calc_dT,
    each Type=Type,
    each n=Exponent,
    each DensitySteel=DensitySteel,
    each CapacitySteel=CapacitySteel,
    each length=length,
    T0=T0_N,
    each Vol_Water=Vol_Water,
    each s_eff=Type[1],
    each Q_dot_nom_i=Q_dot_nom_i,
    each dT_nom=dT_nom,
    each delta_nom=delta_nom,
    each LambdaSteel=LambdaSteel,
    each eps=eps,
    each A=A/N,
    each d=d,
    each m_flow_nominal=m_flow_nominal)
    "Multilayer base class"
    annotation (Placement(transformation(extent={{-28,-18},{8,18}})));

equation
  TV_1=multiLayer_HE[1].TIn;
  TR_N=multiLayer_HE[N].TOut;

  for i in 1:N loop
    connect(multiLayer_HE[i].convective, ConvectiveHeat);
    connect(multiLayer_HE[i].radiative, RadiativeHeat);
  end for;

  for j in 1:(N-1) loop
    connect(multiLayer_HE[j].port_b, multiLayer_HE[j+1].port_a);
  end for;

  connect( FlowTemperature.port_b, multiLayer_HE[1].port_a);
  connect( pressureDropRadiator.port_a, multiLayer_HE[N].port_b);

  connect(pressureDropRadiator.port_b, ReturnTemperature.port_a) annotation (
      Line(
      points={{46,0},{62,0}},
      color={0,127,255},
      smooth=Smooth.None));



  connect(ReturnTemperature.port_b, port_b) annotation (Line(
      points={{82,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(FlowTemperature.port_a, port_a) annotation (Line(
      points={{-78,0},{-100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={
        Rectangle(
          extent={{-58,62},{-50,-68}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-38,62},{-30,-68}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-18,62},{-10,-68}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,62},{10,-68}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{22,62},{30,-68}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{42,62},{50,-68}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{62,62},{70,-68}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,-54},{72,-64}},
          lineColor={95,95,95},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,56},{74,46}},
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
  the&#160;logarithmic&#160;mean&#160;temperature&#160;is&#160;calculated&#160;
  from&#160;the&#160;temperatures&#160;at&#160;in-&#160;and&#160;outlet&#160;
  of&#160;the&#160;radiator.
</p>
<table summary=\"heat emission\" cellspacing=\"0\" cellpadding=\"2\" border=
\"1\">
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
  alt=\"Multilayer Model of radiator \">
</p>
<p>
  Figure 1: Multilayer Model of radiator
</p>
<p>
  For every layer the equation (1) is solved.
</p>
<table summary=\"equation for multilayer\" cellspacing=\"0\" cellpadding=
\"2\" border=\"1\">
  <tr>
    <td>
      <p>
        <br/>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/DGL_HK.png\"
        alt=\"Equation for every layer\">
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
  <br/>
  The total heat emission consists of a convective and a radiative
  part.
</p>
<table summary=\"heat emission conv and rad\" cellspacing=\"0\"
cellpadding=\"2\" border=\"1\">
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Q_ab.png\"
        alt=\"Total heat emission\">
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
        alt=\"Convective heat emission\">
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
        alt=\"Radiative heat emission\">
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
  <br/>
  The convective heat emission is proportional to <img src=
  \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/deltaT.png\"
  alt=\"delta T\">&#160;. The radiative heat emission is proportional to
  <img src=
  \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/delta.png\"
  alt=\"delta\"> &#160;=(T_L + DeltaT)^4-TR^4 (T_L: Room Temperature,
  DeltaT: heater excess temperature, T_R: radiative temperature).
</p>
<table summary=\"heat emission conv\" cellspacing=\"0\" cellpadding=\"2\"
border=\"1\">
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/Q_K.png\"
        alt=\"Convective heat emission, delta T\">
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
        alt=\"Radiative heat emission, delta \">
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
  <br/>
  The heat emission of the radiator depends on the heater excess
  temperature. In the model it is possible to choose between:
</p>
<table summary=\"heat emission excess temperature\" cellspacing=\"0\"
cellpadding=\"2\" border=\"1\">
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
        alt=\"arithmetic heater excess temperature \">
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
        alt=\"logarithmic heater excess temperature \">
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
        alt=\"exponential heater excess temperature \">
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
<table summary=\"radiator exponent\" cellspacing=\"0\" cellpadding=\"2\"
border=\"1\">
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/n_K1.png\"
        alt=\"Radiator exponent \">
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
        alt=\"Radiator exponent 2\">
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
<p>
  The pressure loss is calculated with equation (12).
</p>
<table summary=\"pressure loss\" cellspacing=\"0\" cellpadding=\"2\" border=
\"1\">
  <tr>
    <td>
      <p>
        <img src=
        \"modelica://AixLib/Resources/Images//Fluid/HeatExchanger/Radiator/delta_P.png\"
        alt=\"delta P\">
      </p>
    </td>
    <td>
      <p>
        <br/>
        (12)
      </p>
    </td>
  </tr>
</table>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  The coefficient k in eq. (12) is calculated from manufacturer data
  and is a part of the record for radiator_type.
</p>
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
</html>",
revisions="<html><ul>
  <li>
    <i>January 09, 2006&#160;</i> by Peter Matthes:<br/>
    V0.1: Initial configuration.
  </li>
  <li>
    <i>January 09, 2006&#160;</i> by Peter Matthes:<br/>
    V0.1: Initial configuration.
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
  <li>
    <i>October, 2016&#160;</i> by Peter Remmen:<br/>
    Transfer to AixLib. Delete EnergyMeter and additional output
    T_source
  </li>
  <li>
    <i>July 10, 2019&#160;</i> by Katharina Brinkmann:<br/>
    Changed temperature unit according to #734
  </li>
</ul>
</html>"));
end Radiator;
