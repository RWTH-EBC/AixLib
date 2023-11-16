within AixLib.Fluid.Solar.Thermal.BaseClasses;
model PVT_SolarThermalEfficiency
  "Calculates the efficiency of a thermal component of pvt"
  parameter AixLib.DataBase.PhotovoltaicThermal.SolarThermalBaseDataDefinition
    parCol=AixLib.DataBase.PhotovoltaicThermal.PVT_thermal()
    "Thermal properties of Photovoltaic thermal Collector" annotation (choicesAllMatching=true);
  Modelica.Blocks.Interfaces.RealInput TAir(
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
  Modelica.Blocks.Interfaces.RealInput TCol(
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") "Collector temperature" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-106})));
  Modelica.Blocks.Interfaces.RealOutput QFlow(quantity="HeatFlux", unit="W/m2")
    "Useful heat flow from solar collector in W/m2"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
protected
  Modelica.Units.SI.Efficiency eta(max= parCol.eta_zero)
    "Efficiency of solar thermal collector";
  Modelica.Units.SI.TemperatureDifference dT
    "Temperature difference between collector and air in K";
equation
  dT = TCol - TAir;
  eta = max(0,
          min(parCol.eta_zero,
              parCol.eta_zero - parCol.c1*dT/max(G,
                Modelica.Constants.eps) -
              parCol.c2*dT*dT/max(G, Modelica.Constants.eps)));
  QFlow = G*eta;
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
end PVT_SolarThermalEfficiency;
