within AixLib.Fluid.Solar.Thermal.BaseClasses;
model SolarThermalEfficiency
  "Calculates the efficiency of a solar thermal collector"
  parameter AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition
    Collector=AixLib.DataBase.SolarThermal.SimpleAbsorber()
    "Properties of Solar Thermal Collector" annotation (choicesAllMatching=true);
  Modelica.Blocks.Interfaces.RealInput T_air(
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") "Air temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-50,106})));
  Modelica.Blocks.Interfaces.RealInput G(quantity="Irradiance", unit="W/m2")
    "Global solar irradiation in W/m2" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={10,106})));
  Modelica.Blocks.Interfaces.RealInput T_col(
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") "Collector temperature" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-106})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow(quantity="HeatFlux", unit="W/m2")
    "Useful heat flow from solar collector in W/m2"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
protected
  Modelica.Units.SI.Efficiency eta(max=Collector.eta_zero)
    "Efficiency of solar thermal collector";
  Modelica.Units.SI.TemperatureDifference dT
    "Temperature difference between collector and air in K";
equation
  dT = T_col - T_air;
  eta = max(0,
          min(Collector.eta_zero,
              Collector.eta_zero - Collector.c1*dT/max(G,
                Modelica.Constants.eps) -
              Collector.c2*dT*dT/max(G, Modelica.Constants.eps)));
  Q_flow = G*eta;
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for the efficiency of a solar thermal collector. Inputs are
  outdoor air temperature, fluid temperature and solar irradiation.
  Based on these values and the collector properties from database,
  this model calculates the heat flow to the fluid circuit. We assume
  that the fluid temperature is equal to the collector temperature.
</p>
<ul>
  <li>
    <i>Febraury 7, 2018</i> by Peter Matthes:<br/>
    Adds quatity information to RealInputs and RealOutputs.
  </li>
  <li>
    <i>February 1, 2018&#160;</i> by Philipp Mehrfeld:<br/>
    eta must be between 0 and eta_zero optical efficiency
  </li>
  <li>
    <i>October 25, 2017</i> by Philipp Mehrfeld:<br/>
    Limit eta to 0 and eta_zero.<br/>
    Add correct units.<br/>
    Avoid dividing by G=0.
  </li>
  <li>
    <i>December 15, 2016&#160;</i> by Moritz Lauster:<br/>
    moved
  </li>
  <li>
    <i>November 11, 2013&#160;</i> by Marcus Fuchs:<br/>
    implemented
  </li>
</ul>
</html>"));
end SolarThermalEfficiency;
