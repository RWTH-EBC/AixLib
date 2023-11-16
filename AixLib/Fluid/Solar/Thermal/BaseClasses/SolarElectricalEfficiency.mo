within AixLib.Fluid.Solar.Thermal.BaseClasses;
model SolarElectricalEfficiency
  "simplified calculation for the electrical efficiency of a photovoltaic thermal collector"
  parameter AixLib.DataBase.PhotovoltaicThermal.PhotovoltaicThermalBaseDataDefinitionElectrical
    parCol=AixLib.DataBase.PhotovoltaicThermal.ElectricalGlazedPVTWithLowEmissionCoating()
    "Electrical properties of Photovoltaic thermal Collector" annotation (choicesAllMatching=true);
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
  Modelica.Blocks.Interfaces.RealOutput PEle(quantity="ElectricPower", unit="W/m2")
    "Useful electric power output from solar collector in W/m2"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
protected
  Modelica.Units.SI.Efficiency eta(max=parCol.eta_zero)
    "Efficiency of electricity generation of pvt collector";
  Modelica.Units.SI.TemperatureDifference dT
    "Temperature difference between collector and air in K";
equation
  dT = TCol - TAir;
  eta = max(0,
          min(parCol.eta_zero,
              parCol.eta_zero + parCol.m*dT/max(G,
                Modelica.Constants.eps)));
  PEle = G*eta;
  annotation (Documentation(info="<html>
<h4>Overview</h4>
<p>Simplified Model for the electrical efficiency of a photovoltaic thermal collector. Inputs are outdoor air temperature, fluid temperature and solar irradiation. Based on these values and the collector properties from database, this model calculates the electrical power output of the collector. We assume that the fluid temperature is equal to the collector temperature. </p>
</html>"));
end SolarElectricalEfficiency;
