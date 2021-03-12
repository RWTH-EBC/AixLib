within AixLib.ThermalZones.ReducedOrder.Multizone;
model MultizoneEquippedTest
  "Multizone model with ideal heater and cooler and AHU"
  extends
    AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizoneSwimmingPool;

  parameter Boolean heatAHU
    "Status of heating of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean coolAHU
    "Status of cooling of AHU"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean dehuAHU=if heatAHU and coolAHU then true
       else false
    "Status of dehumidification of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Boolean huAHU=if heatAHU and coolAHU then true
       else false
    "Status of humidification of AHU (Cooling and Heating must be enabled)"
    annotation (Dialog(tab="AirHandlingUnit", group="AHU Modes"));
  parameter Real BPFDehuAHU(
    min=0,
    max=1)
    "By-pass factor of cooling coil during dehumidification"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings AHU Value"));
  parameter Boolean HRS=true
    "Status of Heat Recovery System of AHU"
    annotation (
    Dialog(tab="AirHandlingUnit", group="AHU Modes"), choices(checkBox=true));
  parameter Real effHRSAHU_enabled(
    min=0,
    max=1)
    "Efficiency of HRS when enabled"
    annotation (Dialog(
    tab="AirHandlingUnit",
    group="Settings AHU Value",
    enable=HRS));
  parameter Real effHRSAHU_disabled(
    min=0,
    max=1)
    "Efficiency of HRS when disabled"
    annotation (Dialog(
    tab="AirHandlingUnit",
    group="Settings AHU Value",
    enable=HRS));
  parameter Modelica.SIunits.Time sampleRateAHU(min=0) = 1800
    "Time period for sampling"
    annotation (Dialog(tab="AirHandlingUnit", group="Settings for State Machines"));
  parameter Modelica.SIunits.Pressure dpAHU_sup
    "Pressure difference over supply fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.SIunits.Pressure dpAHU_eta
    "Pressure difference over extract fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.SIunits.Efficiency effFanAHU_sup
    "Efficiency of supply fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  parameter Modelica.SIunits.Efficiency effFanAHU_eta
    "Efficiency of extract fan"
    annotation (Dialog(tab="AirHandlingUnit", group="Fans"));
  replaceable model AHUMod =
    AixLib.Airflow.AirHandlingUnit.AHU
    constrainedby AixLib.Airflow.AirHandlingUnit.BaseClasses.PartialAHU
    "Air handling unit model"
    annotation(Dialog(tab="AirHandlingUnit"),choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealOutput CO2Con[size(zone, 1)] if use_C_flow
    "CO2 concentration in the thermal zone in ppm"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealInput ventRate[numZones](final quantity=
        "VolumeFlowRate", final unit="1/h")
    "Ventilation and infiltration rate"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}}),
        iconTransformation(extent={{-100,-36},{-80,-16}})));
  Modelica.Blocks.Interfaces.RealInput ventTemp[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0)
    "Ventilation and infiltration temperature"
    annotation (Placement(transformation(extent={{-120,-12},{-80,28}}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
  Modelica.Blocks.Interfaces.RealInput ventHum[numZones] if (ASurTot > 0 or
    VAir > 0) and use_moisture_balance
             "Ventilation and infiltration humidity"
     annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=180,
        origin={-100,42}),  iconTransformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-90,24})));
protected
  parameter Real zoneFactor[numZones,1](fixed=false)
    "Calculated zone factors";
  parameter Real VAirRes(fixed=false)
    "Resulting air volume in zones supplied by the AHU";

  Modelica.Blocks.Interfaces.RealOutput X_w[numZones] if (ASurTot > 0 or VAir > 0) and use_moisture_balance
    "Absolute humidity in thermal zone"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{80,40},{100,60}})));

initial algorithm
  for i in 1:numZones loop
    if zoneParam[i].withAHU then
      VAirRes :=VAirRes + zoneParam[i].VAir;
    end if;
  end for;
  for i in 1:numZones loop
    if zoneParam[i].withAHU then
      if VAirRes > 0 then
        zoneFactor[i,1] :=zoneParam[i].VAir/VAirRes;
      else
        zoneFactor[i,1] :=0;
      end if;
    else
      zoneFactor[i,1] :=0;
    end if;
  end for;

equation
  for i in 1:numZones loop

  end for;

  connect(zone.X_w, X_w) annotation (Line(points={{82.52,51.87},{94,51.87},{94,
          40},{110,40}},
                     color={0,0,127}));
  connect(zone.CO2Con, CO2Con) annotation (Line(points={{82.52,48.59},{82.52,20},
          {110,20}},color={0,0,127}));
  if not use_moisture_balance then
  end if;

  connect(zone.ventTemp, ventTemp) annotation (Line(points={{38.84,66.22},{
          -25.58,66.22},{-25.58,8},{-100,8}}, color={0,0,127}));
  connect(zone.ventRate, ventRate) annotation (Line(points={{38.84,60.89},{
          -28.58,60.89},{-28.58,-20},{-100,-20}}, color={0,0,127}));
  connect(zone.ventHum, ventHum) annotation (Line(points={{39.05,54.945},{
          -22.475,54.945},{-22.475,42},{-100,42}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-62,-12},{-20,-26}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Air Conditioning"),
        Polygon(
          points={{56,-44},{-80,-44},{-80,66},{32,66},{32,42},{56,42},{56,-44}},
          lineColor={0,0,255},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-44,58},{-20,52}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="AHU")}), Documentation(revisions="<html><ul>
  <li>November 20, 2020, by Katharina Breuer:<br/>
    Combine thermal zone models
  </li>
  <li>August 27, 2020, by Katharina Breuer:<br/>
    Add co2 balance
  </li>
  <li>April, 2019, by Martin Kremer:<br/>
    Add moisture balance
  </li>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation based on Annex60 and AixLib models.
  </li>
  <li>February 26, 2016, by Moritz Lauster:<br/>
    Fixed bug in share of AHU volume flow.
  </li>
  <li>April 25, 2015, by Ole Odendahl:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  This is a ready-to-use multizone model with a variable number of
  thermal zones. It adds heater/cooler devices and an air handling unit
  to <a href=
  \"AixLib.ThermalZones.ReducedOrder.Multizone.Multizone\">AixLib.ThermalZones.ReducedOrder.Multizone.Multizone</a>.
  It defines connectors and a replaceable vector of <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  models. Most connectors are conditional to allow conditional
  modifications according to parameters or to pass-through conditional
  removements in <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  and subsequently in <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.
</p>
<p>
  Moisture and CO2 balances are conditional submodels which can be
  activated by setting use_moisture_balance or use_C_flow true.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  The model needs parameters describing general properties of the
  building (indoor air volume, net floor area, overall surface area)
  and a vector with length of number of zones containing <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  records to define zone properties and heater/cooler properties. An
  additional tab allows configuring the air handling unit. The air
  handling unit facilitates heating, cooling, humidification,
  dehumidification and heat recovery modes. The user can redeclare the
  thermal zone model choosing from <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>.
  Further parameters for medium, initialization and dynamics originate
  from <a href=
  \"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
  A typical use case is a simulation of a multizone building for
  district simulations. The multizone model calculates heat load and
  indoor air profiles.
</p>
<h4>
  References
</h4>
<p>
  For automatic generation of thermal zone and multizone models as well
  as for datasets, see <a href=
  \"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a>
</p>
<ul>
  <li>German Association of Engineers: Guideline VDI 6007-1, March
  2012: Calculation of transient thermal response of rooms and
  buildings - Modelling of rooms.
  </li>
  <li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D.
  (2014): Low order thermal network models for dynamic simulations of
  buildings on city district scale. In: Building and Environment 73, p.
  223–231. DOI: <a href=
  \"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>.
  </li>
</ul>
<h4>
  Examples
</h4>
<p>
  See <a href=
  \"AixLib.ThermalZones.ReducedOrder.Examples.Multizone\">AixLib.ThermalZones.ReducedOrder.Examples.Multizone</a>.
</p>
</html>"));
end MultizoneEquippedTest;
