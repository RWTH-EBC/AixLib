within AixLib.Fluid.Solar.Thermal.BaseClasses;
model ThermalEfficiency
  "Calculates the efficiency of a solar thermal collector"
  parameter Modelica.Units.SI.Efficiency eta_zero(max=1)
    "Conversion factor/Efficiency at Q = 0";
  parameter Real c1(unit = "W/(m.m.K)") "Loss coefficient c1";
  parameter Real c2(unit = "W/(m.m.K.K)") "Loss coefficient c2";
  Modelica.Units.SI.Efficiency eta(max=eta_zero)
    "Efficiency of solar thermal collector";
  Modelica.Blocks.Interfaces.RealInput TAir(
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") "Air temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-50,120})));
  Modelica.Blocks.Interfaces.RealInput G(quantity="Irradiance", unit="W/m2")
    "Global solar irradiation in W/m2" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={10,120})));
  Modelica.Blocks.Interfaces.RealInput TCol(
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") "Collector temperature" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-120})));
  Modelica.Blocks.Interfaces.RealOutput q_flow(quantity="HeatFlux", unit="W/m2")
    "Useful heat flow from solar collector in W/m2"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Modelica.Units.SI.TemperatureDifference dT
    "Temperature difference between collector and air in K";
equation
  dT =TCol - TAir;
  eta = max(0,
          min(eta_zero,
              eta_zero - c1*dT/max(G,
                Modelica.Constants.eps) -
              c2*dT*dT/max(G, Modelica.Constants.eps)));
  q_flow = G*eta;
annotation (Documentation(info="<html>
<p>
  Model for the efficiency of a solar thermal collector. 
  Inputs are outdoor air temperature, fluid temperature and solar irradiation. 
  Based on these values and the collector properties from database, this model 
  calculates the heat flow to the fluid circuit. 
  We assume that the fluid temperature is equal to the collector temperature. 
</p>
</html>", revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Fabian Wuellhorst:<br/>
    Add record parameter directly to use this model for
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
    issue 1451</a>
  </li>
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
</ul></html>"));
end ThermalEfficiency;
