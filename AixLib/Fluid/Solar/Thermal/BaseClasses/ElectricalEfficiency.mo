within AixLib.Fluid.Solar.Thermal.BaseClasses;
model ElectricalEfficiency
  "simplified calculation for the electrical efficiency of a photovoltaic thermal collector"
  parameter Modelica.Units.SI.Efficiency eta_zero(max=1)
    "Conversion factor/Efficiency at Q = 0";
  parameter Real m(unit = "W/(m.m.K)") "Gradient of linear approximation";
  Modelica.Units.SI.Efficiency eta(max=eta_zero)
    "Efficiency of electricity generation of pvt collector";
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
  Modelica.Blocks.Interfaces.RealOutput PEle(quantity="ElectricPower", unit="W/m2")
    "Useful electric power output from solar collector in W/m2"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Modelica.Units.SI.TemperatureDifference dT
    "Temperature difference between collector and air in K";
equation
  dT = TCol - TAir;
  eta = max(0,
          min(eta_zero,
              eta_zero - m*dT/max(G,
                Modelica.Constants.eps)));
  PEle = G*eta;
  annotation (Documentation(info="<html>
<p>
  Simplified Model for the electrical efficiency of a photovoltaic thermal collector. 
  Inputs are outdoor air temperature, fluid temperature and solar irradiation. 
  Based on these values and the collector properties from database, this model 
  calculates the electrical power output of the collector. We assume that the 
  fluid temperature is equal to the collector temperature. 
</p>
</html>", revisions="<html><ul>
  <li>
    <i>January 23, 2024</i> by Philipp Schmitz and Fabian Wuellhorst:<br/>
    First implementation. This is for
 <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1451\">
 issue 1451</a>.
  </li>
</ul>
</html>"));
end ElectricalEfficiency;
