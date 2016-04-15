within AixLib.Fluid.HeatExchangers.Radiators;
model Radiator_ML_EBC "radiator multilayer model"
  import Modelica.SIunits;
  import calcT =
    AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.Calc_Excess_Temp;
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  // parameter Real kv=.1;
 parameter Boolean selectable=false "Radiator record" annotation(Dialog(group="Radiator Data"));
 parameter AixLib.DataBase.Radiators.RadiatorMLBaseDataDefinition
                                                       radiatorType=
      AixLib.DataBase.Radiators.RadiatorMLBaseDataDefinition()
    "choose a radiator"
                    annotation(Dialog(group="Radiator Data", enable=selectable), choicesAllMatching=true);
  parameter BaseClasses.RadiatorTypes.RadiatorType Type=(if selectable then
      radiatorType.Type else BaseClasses.RadiatorTypes.PanelRadiator10)
    "Type of radiator" annotation (choicesAllMatching=true, Dialog(
      tab="Geometry and Material",
      group="Geometry",
      enable=not selectable));
  parameter Real NominalPower=(if selectable then radiatorType.NominalPower else 1000)
    "Nominal power of radiator per meter at nominal temperatures in W/m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter Real Exponent=(if selectable then radiatorType.Exponent else 1.29)
annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter Real VolumeWater(unit="l/m")=(if selectable then radiatorType.VolumeWater else 20)
    "Water volume inside radiator per m, in l/m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter Real MassSteel(unit="kg/m")=(if selectable then radiatorType.MassSteel else 30)
    "Material mass of radiator per m, in kg/m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter SIunits.Density DensitySteel=(if selectable then radiatorType.DensitySteel else 7900)
    "Specific density of steel, in kg/m3"
    annotation (Dialog(tab="Geometry and Material", group="Material", enable=not selectable));
  parameter SIunits.SpecificHeatCapacity CapacitySteel=(if selectable then radiatorType.CapacitySteel else 551)
    "Specific heat capacity of steel, in J/kgK"
    annotation (Dialog(tab="Geometry and Material", group="Material", enable=not selectable));
  parameter SIunits.ThermalConductivity LambdaSteel=(if selectable then radiatorType.LambdaSteel else 60)
    "Thermal conductivity of steel, in W/mK"
    annotation (Dialog(tab="Geometry and Material", group="Material", enable=not selectable));
    parameter SIunits.Length length=(if selectable then radiatorType.length else 1)
    "Length of radiator, in m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter SIunits.Length height=(if selectable then radiatorType.height else 0.6)
    "Height of raditor, in m"
    annotation (Dialog(tab="Geometry and Material", group="Geometry", enable=not selectable));
  parameter Modelica.SIunits.Area A=2*length*height
  annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.SIunits.Length d=0.025 "thickness of radiator wall"
  annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter Modelica.SIunits.Emissivity eps=0.95 "Emissivity"
  annotation (Dialog(tab="Geometry and Material", group="Material"));
  parameter SIunits.Temperature T0=Modelica.SIunits.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius"
    annotation (Dialog(group="Miscellaneous"));
  parameter SIunits.Temperature RT_nom[3]=(if selectable then Modelica.SIunits.Conversions.from_degC(radiatorType.RT_nom) else Modelica.SIunits.Conversions.from_degC({75,65,20}))
    "nominal temperatures (Tin, Tout, Tair) according to DIN-EN 442."
                                                            annotation (Dialog(group="Miscellaneous",enable=not selectable));
  parameter Real PD = (if selectable then radiatorType.PressureDrop else 548208)
    "Pressure drop coefficient, delta_p[Pa] = PD*m_flow[kg/s]^2"                                        annotation (Dialog(group="Miscellaneous", enable=not selectable));
  parameter Integer N=16 "number of discretisation layers";

  parameter BaseClasses.BaseClasses.Calc_Excess_Temp.Temp calc_dT=calcT.exp
    "select calculation method";
  SIunits.Power Power;
  SIunits.Temperature TV_1;
  SIunits.Temperature TR_N;
protected
  parameter Modelica.SIunits.Temperature T0_N[N]= {(T0-ki*0.2) for ki in 1:N};
  parameter SIunits.Volume Vol_Water=(length*VolumeWater/1000)/N;
  parameter SIunits.Volume Vol_Steel=(length*MassSteel) / DensitySteel /N
    annotation (Dialog(tab="Geometry and Material", group="Geometry"));

  parameter SIunits.Length d1=2*(Vol_Water/Modelica.Constants.pi/length)^0.5
    "inner diameter of single layer";
  parameter SIunits.Length d2=2*((Vol_Water+Vol_Steel)/Modelica.Constants.pi/length)^0.5
    "outer diameter of single layer";
  parameter Real dT_V_nom=RT_nom[1]-RT_nom[3];
  parameter Real dT_R_nom=RT_nom[2]-RT_nom[3];

// calculation of convective excess temperature, according to the chosen calculation method

  parameter Real dT_nom=if calc_dT==calcT.ari then (dT_V_nom+dT_R_nom)/2 else
  if calc_dT==calcT.log then (dT_V_nom-dT_R_nom)/log(dT_V_nom/dT_R_nom) else
  ((Exponent-1)*(dT_V_nom-dT_R_nom)/(dT_R_nom^(1-Exponent)-dT_V_nom^(1-Exponent)))^(1/Exponent);

// Calculation of nominal radiation excess temperature

  parameter Real delta_nom=(dT_nom+RT_nom[3])*(dT_nom+RT_nom[3])*(dT_nom+RT_nom[3])*(dT_nom+RT_nom[3])-RT_nom[3]*RT_nom[3]*RT_nom[3]*RT_nom[3];
  parameter SIunits.Power Q_dot_nom_i= length * NominalPower/N;

protected
  BaseClasses.ML_thermal_delta multiLayer_HE[N](
    M_Radiator=fill((length*MassSteel)/N, N),
    calc_dT=fill(calc_dT, N),
    Type=fill(Type, N),
    n=fill(Exponent, N),
    DensitySteel=fill(DensitySteel, N),
    CapacitySteel=fill(CapacitySteel, N),
    length=fill(length, N),
    T0=T0_N,
    Vol_Water=fill(Vol_Water, N),
    s_eff=fill(Type[1], N),
    Q_dot_nom_i=fill(Q_dot_nom_i, N),
    dT_nom=fill(dT_nom, N),
    delta_nom=fill(delta_nom, N),
    LambdaSteel=fill(LambdaSteel, N),
    eps=fill(eps, N),
    A=fill(A/N, N),
    d=fill(d, N),
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-28,-18},{8,18}})));

public
  BaseClasses.PressureDropRadiator pressureDropRadiator(redeclare package
      Medium = Medium, PD=PD)
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvectiveHeat
    annotation (Placement(transformation(extent={{-60,20},{-44,36}}, rotation=
           0), iconTransformation(extent={{-30,10},{-10,30}})));
  AixLib.Utilities.Interfaces.Star RadiativeHeat annotation (Placement(
        transformation(extent={{30,12},{50,30}}, rotation=0),
        iconTransformation(extent={{30,10},{50,30}})));

  AixLib.Utilities.Sensors.EEnergyMeter eEnergyMeter
    annotation (Placement(transformation(extent={{74,-62},{94,-42}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort FlowTemperature(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort ReturnTemperature(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));
  Modelica.Blocks.Interfaces.RealOutput T_source
    "The logarithmic mean temperature is calculated from the temperatures at in- and outlet of the radiator"
    annotation (Placement(transformation(extent={{-80,-60},{-100,-40}})));

equation
  TV_1=multiLayer_HE[1].Tin;
  TR_N=multiLayer_HE[N].Tout;
  Power=abs(ConvectiveHeat.Q_flow + RadiativeHeat.Q_flow);
  eEnergyMeter.p = Power;
  for i in 1:N loop
    connect(multiLayer_HE[i].Convective, ConvectiveHeat);
    connect(multiLayer_HE[i].Radiative, RadiativeHeat);
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

   T_source = (ReturnTemperature.T - FlowTemperature.T)/(log(ReturnTemperature.T
    /FlowTemperature.T));
  //The logarithmic mean temperature is calculated from the temperatures at in- and outlet of the radiator.

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
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The Radiator model represents a heating device. This model also includes the conduction through the radiator wall. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The Radiator model represents a heating device. Heat energy taken from the hot water flow through the device is being emitted via convective and radiative energy transport connectors. The ratio of convective and radiative energy flows depends on the type of the heating device (see table). </p>
<p>T_source output is relevant for exergy analysis. It describes the&nbsp;logarithmic&nbsp;mean&nbsp;temperature&nbsp;is&nbsp;calculated&nbsp;from&nbsp;the&nbsp;temperatures&nbsp;at&nbsp;in-&nbsp;and&nbsp;outlet&nbsp;of&nbsp;the&nbsp;radiator.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>Type</h4></td>
<td><h4>Fraction of convective transport</h4></td>
<td><h4>Fraction of radiative transport</h4></td>
</tr>
<tr>
<td><p><i>SectionalRadiator</i></p><p>Simple (vertical) sectional radiator</p></td>
<td><p>0.70</p></td>
<td><p>0.30</p></td>
</tr>
<tr>
<td><p><i>PanelRadiator10</i></p><p>10 -- Panel radiator (single panel) without convection device</p></td>
<td><p>0.50</p></td>
<td><p>0.50</p></td>
</tr>
<tr>
<td><p><i>PanelRadiator11</i></p><p>11 -- Panel radiator (single panel) with one convection device</p></td>
<td><p>0.65</p></td>
<td><p>0.35</p></td>
</tr>
<tr>
<td><p><i>PanelRadiator12</i></p><p>12 -- Panel radiator (single panel) with two convection devices</p></td>
<td><p>0.75</p></td>
<td><p>0.25</p></td>
</tr>
<tr>
<td><p><i>PanelRadiator20</i></p><p>20 -- Panel radiator (two panels) without convection device</p></td>
<td><p>0.65</p></td>
<td><p>0.35</p></td>
</tr>
<tr>
<td><p><i>PanelRadiator21</i></p><p>21 -- Panel radiator (two panels) with one convection device</p></td>
<td><p>0.80</p></td>
<td><p>0.20</p></td>
</tr>
<tr>
<td><p><i>PanelRadiator22</i></p><p>22 -- Panel radiator (two panels) with two convection devices</p></td>
<td><p>0.85</p></td>
<td><p>0.15</p></td>
</tr>
<tr>
<td><p><i>PanelRadiator30</i></p><p>30 -- Panel radiator (three panels) without convection device</p></td>
<td><p>0.80</p></td>
<td><p>0.20</p></td>
</tr>
<tr>
<td><p><i>PanelRadiator31</i></p><p>31 -- Panel radiator (three panels) with one convection device</p></td>
<td><p>0.85</p></td>
<td><p>0.15</p></td>
</tr>
<tr>
<td><p><i>PanelRadiator32</i></p><p>32 -- Panel radiator (three panels) with two or more convection devices</p></td>
<td><p>0.90</p></td>
<td><p>0.10</p></td>
</tr>
<tr>
<td><p><i>ConvectorHeaterUncovered</i></p><p>Convector heater without cover</p></td>
<td><p>0.95</p></td>
<td><p>0.05</p></td>
</tr>
<tr>
<td><p><i>ConvectorHeaterCovered</i></p><p>Convector heater with cover</p></td>
<td><p>1.00</p></td>
<td><p>- no radiative transport -</p></td>
</tr>
</table>
<p><br><br><br><br><br><br><br><br><br><br><br>The Height H of the radiator is discretized in N single Layers, as shown in figure 1 </p>
<p><br><img src=\"../Images/Schichtenmodell.png\"/></p>
<p>Figure 1: Multilayer Model of radiator </p>
<p>For every layer the equation (1) is solved. </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p><br><br><br><br><br><br><img src=\"../Images/DGL_HK.png\"/> </p></td>
<td><p><br>(1) </p></td>
</tr>
<tr>
<td></td>
<td></td>
</tr>
</table>
<p><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>The total heat emission consists of a convective and a radiative part. </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p><img src=\"../Images/Q_ab.png\"/> </p></td>
<td><p><br>(2) </p></td>
</tr>
<tr>
<td><p><img src=\"../Images/Q_K1.png\"/> </p></td>
<td><p><br>(3) </p></td>
</tr>
<tr>
<td><p><img src=\"../Images/Q_R1.png\"/> </p></td>
<td><p><br>(4) </p></td>
</tr>
<tr>
<td></td>
<td></td>
</tr>
</table>
<p><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>The convective heat emission is proportional to <img src=\"../Images/deltaT.png\"/>&nbsp;. The radiative heat emission is proportional to <img src=\"../Images/delta.png\"/>&nbsp;=(T_L + DeltaT)^4-TR^4 (T_L: Room Temperature, DeltaT: heater excess temperature, T_R: radiative temperature). </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p><img src=\"../Images/Q_K.png\"/> </p></td>
<td><p><br>(5) </p></td>
</tr>
<tr>
<td><p><img src=\"../Images/Q_R.png\"/> </p></td>
<td><p><br>(6) </p></td>
</tr>
<tr>
<td></td>
<td></td>
</tr>
</table>
<p><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>The heat emission of the radiator depends on the heater excess temperature. In the model it is possible to choose between: </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><h4>Method </h4></td>
<td><h4>Formula </h4></td>
<td></td>
</tr>
<tr>
<td><p><br><br><br><br><br><br><br><br><br><br><br>arithmetic heater excess temperature </p></td>
<td><p><img src=\"../Images/Delta_T_ari.png\"/> </p></td>
<td><p><br>(7) </p></td>
</tr>
<tr>
<td><p>logarithmic heater excess temperature </p></td>
<td><p><img src=\"../Images/Delta_T_log.png\"/> </p></td>
<td><p><br>(8) </p></td>
</tr>
<tr>
<td><p>exponential heater excess temperature according to [2] </p></td>
<td><p><img src=\"../Images/Delta_T_exp.png\"/> </p></td>
<td><p><br>(9) </p></td>
</tr>
<tr>
<td></td>
<td></td>
<td></td>
</tr>
</table>
<p><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>Due to stability reasons and accuracy at small heating medium flow, an exponential calculation of the heater excess temperture is recommended. The function &QUOT;calcHeaterExcessTemp &QUOT; regularize the discontinuities in equation (9). </p>
<p>The radiator exponent according to DIN 442 is valid for the total heat emission. the radiative heat emission part grows larger. This is considered by the following formulas: </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p><img src=\"../Images/n_K1.png\"/> </p></td>
<td><p><br>(10) </p></td>
</tr>
<tr>
<td><p><img src=\"../Images/n_K2.png\"/> </p></td>
<td><p><br>(11) </p></td>
</tr>
<tr>
<td></td>
<td></td>
</tr>
</table>
<p><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>The modified convective exponent is calculated by (11). The region of discontinuity in eq. (11) has not yet been regulized, so a constant radiator exponent is used for now. </p>
<p>In the model the heat emission is calculated according to eq. (5), (6) for every layer and the respective power is connected to the romm via the thermal ports. A varHeatSource (inPort=total heat emission) is connected via a thermal port to the enthalpie flow of the heating medium and the stored heat in the radiator mass. </p>
<p>The pressure loss is calculated with equation (12).</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td><p><img src=\"../Images/delta_P.png\"/> </p></td>
<td><p><br>(12) </p></td>
</tr>
</table>
<h4><span style=\"color:#008000\">References</span></h4>
<p>The coefficient k in eq. (12) is calculated from manufacturer data and is a part of the record for radiator_type. </p>
<p>Knowing the heat load of the room, an appropriate radiator can be choosen out of a Radiator DataBase via a record. But it is also possible to simulate with arbitrary parameters. </p>
<p>The thermal part of the model is adapted from [3] and [1]. </p>
<ul>
<li>[1] Gl&uuml;ck, Bernd: W&auml;rme&uuml;bertragung - W&auml;rmeabgabe von Raumheizfl&auml;chen und Rohren, 1990 </li>
<li>[2] Nadler,Norbert: Die W&auml;rmeleistung von Raumheizk&ouml;rpern in expliziter Darstellung, In: HLH L&uuml;ftung/Klima - Heizung/Sanit&auml;r - Geb&auml;udetechnik 11, S.621 - 624, 1991 </li>
<li>[3] Tritschler, Markus: Bewertung der Genauigkeit von Heizkostenverteilern, Dissertation, Uni Stuttart, 1999 </li>
</ul>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"HVAC.Examples.HeatExchanger.Verification.Simple_HeatExchanger\">HVAC.Examples.HeatExchanger.Verification.Simple_HeatExchanger</a></p>
<p><a href=\"HVAC.Examples.HeatExchanger.Validation.PanelRadiator\">HVAC.Examples.HeatExchanger.Validation.PanelRadiator</a></p>
<p><a href=\"HVAC.Examples.HeatExchanger.Validation.DINSteelRadiator\">HVAC.Examples.HeatExchanger.Validation.DINSteelRadiator</a></p>
<p><a href=\"HVAC.Examples.HeatExchanger.Validation.PressureDrop\">HVAC.Examples.HeatExchanger.Validation.PressureDrop</a></p>
</html>",
revisions="<html>
<ul>
<li><i>January 09, 2006&nbsp;</i> by Peter Matthes:<br/>V0.1: Initial configuration.</li>
<li><i>January 09, 2006&nbsp;</i> by Peter Matthes:<br/>V0.1: Initial configuration.</li>
<li><i>November 28, 2014&nbsp;</i> by Roozbeh Sangi:<br>Output for logarithmic mean temperature added</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately</li>
<li><i>Mai 1, 2011&nbsp;</i> by Ana Constantin:<br>Addapted with a few changes from older model.</li>
</ul>
</html>"),
    experiment(
      StopTime=864000,
      Interval=30,
      Algorithm="Lsodar"),
    experimentSetupOutput);
end Radiator_ML_EBC;
