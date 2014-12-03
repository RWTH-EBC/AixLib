within AixLib.Building.LowOrder.BaseClasses.ReducedOrderModel;
partial model partialReducedOrderModel

 parameter Boolean withInnerwalls=true "If inner walls are existent"   annotation(Dialog(tab="Inner walls"),choices(checkBox = true));
  parameter Modelica.SIunits.ThermalResistance R1i=0.0005955
    "Resistor 1 inner wall"
    annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.HeatCapacity C1i=14860000 "Capacity 1 inner wall"
    annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Area Ai=75.5 "Inner wall area"
    annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Temp_K T0all=295.15
    "Initial temperature for all components";
  parameter Boolean withWindows=true "If windows are existent"   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withOuterwalls then true else false),choices(checkBox = true));
  parameter Real splitfac=0.03 "Factor for conv. part of rad. through windows"
   annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.Area Aw=10.5 "Window area"
    annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.Emissivity epsw=0.95 "Emissivity of the windows"
    annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
  parameter Modelica.SIunits.TransmissionCoefficient g=0.7
    "Total energy transmittance"
    annotation(Dialog(tab="Outer walls",group = "Windows",enable = if withWindows and withOuterwalls then true else false));
  parameter Boolean withOuterwalls=true
    "If outer walls (including windows) are existent"  annotation(Dialog(tab="Outer walls"),choices(checkBox = true));
  parameter Modelica.SIunits.ThermalResistance RRest=0.0427487
    "Resistor Rest outer wall"
    annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.ThermalResistance R1o=0.004366
    "Resistor 1 outer wall"
    annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.HeatCapacity C1o=1557570 "Capacity 1 outer wall"
    annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Area Ao=10.5 "Outer wall area"
    annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Volume Vair=52.5 "Volume of the air in the zone"
    annotation(Dialog(tab="Room air"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaiwi=2.7
    "Coefficient of heat transfer for inner walls"
    annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaowi=2.7
    "Outer wall's coefficient of heat transfer (inner side)"
    annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));
  parameter Modelica.SIunits.Density rhoair=1.19 "Density of the air"
    annotation(Dialog(tab="Room air"));
  parameter Modelica.SIunits.SpecificHeatCapacity cair=1007
    "Heat capacity of the air"
    annotation(Dialog(tab="Room air"));
  parameter Modelica.SIunits.Emissivity epsi=0.95
    "Emissivity of the inner walls"
    annotation(Dialog(tab="Inner walls",enable = if withInnerwalls then true else false));
  parameter Modelica.SIunits.Emissivity epso=0.95
    "Emissivity of the outer walls"
    annotation(Dialog(tab="Outer walls",enable = if withOuterwalls then true else false));

  Building.Components.DryAir.Airload
                       airload(
    V=Vair,
    rho=rhoair,
    c=cair,
    T(nominal=293.15,
      min=278.15,
      max=323.15))
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={2,2})));
  Utilities.HeatTransfer.HeatConv
                             heatConvInnerwall(A=Ai, alpha=alphaiwi) if withInnerwalls
    annotation (Placement(transformation(extent={{28,-10},{48,10}})));

  SimpleOuterWall outerwall(
    RRest=RRest,
    R1=R1o,
    C1=C1o,
    T0=T0all,
    port_b(T(
        nominal=293.15,
        min=278.15,
        max=323.15))) if
                 withOuterwalls
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  SimpleInnerWall innerwall(
    R1=R1i,
    C1=C1i,
    T0=T0all,
    port_a(T(
        nominal=293.15,
        min=278.15,
        max=323.15))) if
                 withInnerwalls
          annotation (Placement(transformation(extent={{56,-10},{76,10}})));

  Utilities.HeatTransfer.HeatConv
                             heatConvOuterwall(A=Ao, alpha=alphaowi) if
                     withOuterwalls
    annotation (Placement(transformation(extent={{-22,-10},{-42,10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv(T(
      nominal=273.15 + 22,
      min=273.15 - 30,
      max=273.15 + 60)) annotation (Placement(transformation(extent={{10,-100},{
            30,-80}}), iconTransformation(extent={{0,-110},{40,-70}})));
  Building.Components.DryAir.VarAirExchange
                              airExchange(
    V=Vair,
    c=cair,
    rho=rhoair)
    annotation (Placement(transformation(extent={{-44,-40},{-24,-20}})));
  Modelica.Blocks.Interfaces.RealInput ventilationRate annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-40,-100}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-38,-90})));
public
  Modelica.Blocks.Interfaces.RealInput ventilationTemperature annotation (
      Placement(transformation(extent={{-120,-82},{-80,-42}}),
        iconTransformation(extent={{-100,-28},{-60,-68}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTemp if
    withOuterwalls annotation (Placement(transformation(extent={{-110,-20},{-70,
            20}}), iconTransformation(extent={{-100,-16},{-60,24}})));
  Utilities.Interfaces.Star
                          internalGainsRad annotation (Placement(transformation(
          extent={{70,-100},{90,-80}}), iconTransformation(extent={{52,-112},{
            98,-68}})));
  Utilities.HeatTransfer.SolarRadToHeat
                                      solarRadToHeatWindowRad(coeff=g, A=Aw) if
                                                                             withWindows and withOuterwalls
    annotation (Placement(transformation(extent={{-46,82},{-26,102}},rotation=0)));
  Utilities.Interfaces.SolarRad_in
                                 solarRad_in if   withWindows and withOuterwalls
    annotation (Placement(transformation(extent={{-102,68},{-82,88}}, rotation=0),
        iconTransformation(extent={{-21,-20},{21,20}},
        rotation=-90,
        origin={-40,95})));

  SolarRadMultiplier solarRadMultiplierWindowRad(x=1 - splitfac) if
    withWindows and withOuterwalls
    annotation (Placement(transformation(extent={{-72,80},{-52,100}})));
  SolarRadMultiplier solarRadMultiplierWindowConv(x=splitfac) if   withWindows
     and withOuterwalls
    annotation (Placement(transformation(extent={{-72,56},{-52,76}})));
  Utilities.HeatTransfer.SolarRadToHeat
                                      solarRadToHeatWindowConv(A=Aw, coeff=g) if
                                                                              withWindows and withOuterwalls
    annotation (Placement(transformation(extent={{-46,58},{-26,78}}, rotation=0)));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    ventilationTemperatureConverter annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=90,
        origin={-68,-42})));
initial equation
  assert(noEvent((abs(Aw) < 0.00001 and withWindows)==false),"In ReducedModel, withWindows is true (windows existent), but the area of the windows Aw is zero (or nearly zero). This might cause an error.", level=AssertionLevel.warning);
  assert(noEvent((abs(Ao) < 0.00001 and withOuterwalls)==false),"In ReducedModel, withOuterwalls is true (outer walls existent), but the area of the outer walls Ao is zero (or nearly zero). This might cause an error.", level=AssertionLevel.warning);
  assert(noEvent((abs(Ai) < 0.00001 and withInnerwalls)==false),"In ReducedModel, withInnerwalls is true (inner walls existent), but the area of the inner walls Ai is zero (or nearly zero). This might cause an error.", level=AssertionLevel.warning);

equation
if withWindows and withOuterwalls then
    connect(solarRad_in, solarRadMultiplierWindowRad.solarRad_in) annotation (Line(
        points={{-92,78},{-75,78},{-75,90},{-71,90}},
        color={255,128,0},
        smooth=Smooth.None));
    connect(solarRad_in, solarRadMultiplierWindowConv.solarRad_in) annotation (Line(
        points={{-92,78},{-75,78},{-75,66},{-71,66}},
        color={255,128,0},
        smooth=Smooth.None));
    connect(solarRadMultiplierWindowRad.solarRad_out, solarRadToHeatWindowRad.solarRad_in)
      annotation (Line(
        points={{-53,90},{-46.1,90}},
        color={255,128,0},
        smooth=Smooth.None));
    connect(solarRadMultiplierWindowConv.solarRad_out, solarRadToHeatWindowConv.solarRad_in)
      annotation (Line(
        points={{-53,66},{-46.1,66}},
        color={255,128,0},
        smooth=Smooth.None));
    if withOuterwalls then
    else
      assert(withOuterwalls,"There must be outer walls, windows have to be counted too!");
    end if;
    if withInnerwalls then
    end if;
  end if;

  if withOuterwalls then
    connect(equalAirTemp, outerwall.port_a) annotation (Line(
        points={{-90,0},{-80,0},{-80,-0.909091},{-70,-0.909091}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(outerwall.port_b, heatConvOuterwall.port_b) annotation (Line(
        points={{-50,-0.909091},{-46.5,-0.909091},{-46.5,0},{-42,0}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(heatConvOuterwall.port_a, airload.port) annotation (Line(
        points={{-22,0},{-7,0}},
        color={191,0,0},
        smooth=Smooth.None));
    if withInnerwalls then
    else
    end if;
  end if;

  if withInnerwalls then
    connect(innerwall.port_a, heatConvInnerwall.port_b) annotation (Line(
        points={{56,-0.909091},{51.5,-0.909091},{51.5,0},{48,0}},
        color={191,0,0},
        smooth=Smooth.None));
  end if;

  connect(airExchange.port_b, airload.port)                  annotation (
      Line(
      points={{-24,-30},{-16,-30},{-16,0},{-7,0}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(internalGainsConv, airload.port) annotation (Line(
      points={{20,-90},{20,-30},{-16,-30},{-16,0},{-7,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(airload.port, heatConvInnerwall.port_a) annotation (Line(
      points={{-7,0},{-16,0},{-16,-30},{20,-30},{20,0},{28,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(solarRadToHeatWindowConv.heatPort, airload.port) annotation (Line(
      points={{-27,66},{-16,66},{-16,0},{-7,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(ventilationTemperature, ventilationTemperatureConverter.T)
    annotation (Line(
      points={{-100,-62},{-68,-62},{-68,-51.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ventilationTemperatureConverter.port, airExchange.port_a) annotation (
     Line(
      points={{-68,-34},{-68,-30},{-44,-30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(ventilationRate, airExchange.InPort1) annotation (Line(
      points={{-40,-100},{-40,-50},{-50,-50},{-50,-36.4},{-43,-36.4}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics),
    experiment(StopTime=864000),
    experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
         graphics={
        Rectangle(
          extent={{-60,74},{100,-70}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-44,60},{84,-56}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-44,-56},{-12,-28},{-12,38},{-44,60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-12,38},{30,38},{58,38},{84,60}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{58,38},{58,-28},{84,-56}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-12,-28},{58,-28}},
          color={0,0,0},
          smooth=Smooth.None),
        Rectangle(
          extent={{22,16},{38,4}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{6,16},{22,4}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{22,4},{38,-8}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{6,4},{22,-8}},
          lineColor={0,0,0},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-24,110},{122,74}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={236,99,92},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Documentation(info="<html>
<p>ReducedOrderModel is a simple component to compute the air temperature, heating load, etc. for a thermal zone. The zone is simplified to one outer wall, one inner wall and one air node. It is build out of standard components and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleOuterWall\">SimpleOuterWall</a> and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleInnerWall\">SimpleInnerWall</a>. </p>
<p>The partial class contains following components: </p>
<ul>
<li>inner and outer walls</li>
<li>windows</li>
<li>convective heat transfer of the walls and windows</li>
<li>influence of air temperature caused by infiltration</li>
<li>connectors for internal gains (conv. and rad.) </li>
</ul>
<h4>Main equations</h4>
<p>The concept is described in VDI 6007. All equations can be found in VDI 6007. All outer walls and inner walls (including the windows) are merged together to one wall respectively. The inner walls are used as heat storages only, there is no heat transfer out of the zone (adiabate). This assumption is valid as long as the walls are in the zone or touch zones with a similar temperature. All walls, which touch other thermal zones are put together in the outer walls, which have an heat transfer with <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>.</p>
<h4>Assumption and limitations</h4>
<p>The simplifications are based on the VDI 6007, which describes the thermal behaviour of a thermal zone with the equations for an electric circuit, hence they are equal. The heat transfer is described with resistances and the heat storage with capacitances. </p>
<h4>Typical use and important parameters</h4>
<p>The resolution of the model is very rough (only one air node), so the model is primarly thought for computing the air temperature of the room and with that, the heating and cooling load. It is more a heat load generator than a full building model. It is thought mainly for city district simulations, in which a lot of buildings has to be taken into account and the specific cirumstances in one building can be neglected.</p>
<p>Inputs: The model needs the outdoor air temperature and the Infiltration/VentilationRate for the Ventilation, the equivalent outdoor temperature (see <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp.partialEqAirTemp\">EqAirTemp</a>) for the heat conductance through the outer walls and the solar radiation through the windows. There are two ports, one thermal, one star, for inner loads, heating etc. . </p>
<p>Parameters: Inner walls: R and C for the heat conductance and storage in the wall, A, alpha and epsilon for the heat transfer. Outer walls: Similar to inner walls, but with two R&apos;s, as there is also a conductance through the walls. Windows: g, A, epsilon and a splitfac. Please see VDI 6007 for computing the R&apos;s and C&apos;s</p>
<h4>Options</h4>
<ul>
<li>Only outer walls are considered</li>
<li>Outer and inner walls are considered </li>
<li>Outer and inner walls as well as windows are considered </li>
</ul>
<h4>Validation</h4>
<p>The model is verified with the VDI 6007, see <a href=\"AixLib.Building.LowOrder.Validation.VDI6007\">Validation.VDI6007</a>. A validation with the use of the standard ASHRAE 140 is in progress </p>
<h4>Implementation</h4>
<h4>References</h4>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: 10.1016/j.buildenv.2013.12.016.</li>
</ul>
</html>", revisions="<html>
<p><ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br/>Implemented.</li>
</ul></p>
</html>"));
end partialReducedOrderModel;
