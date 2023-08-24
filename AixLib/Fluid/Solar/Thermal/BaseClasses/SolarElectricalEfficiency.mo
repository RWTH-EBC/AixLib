within AixLib.Fluid.Solar.Thermal.BaseClasses;
model SolarElectricalEfficiency
  "simplified calculation for the electrical efficiency of a photovoltaic thermal collector"
  parameter AixLib.DataBase.PhotovoltaicThermal.PhotovoltaicThermalBaseDataDefinitionElectrical
    Collector=AixLib.DataBase.PhotovoltaicThermal.ElectricalGlazedPVTWithLowEmissionCoating()
    "Electrical properties of Photovoltaic thermal Collector" annotation (choicesAllMatching=true);
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
  Modelica.Blocks.Interfaces.RealOutput P_el(quantity="ElectricPower", unit="W/m2")
    "Useful electric power output from solar collector in W/m2"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
protected
  Modelica.Units.SI.Efficiency eta(max=Collector.eta_zero)
    "Efficiency of electricity generation of pvt collector";
  Modelica.Units.SI.TemperatureDifference dT
    "Temperature difference between collector and air in K";
equation
  dT = T_col - T_air;
  eta = max(0,
          min(Collector.eta_zero,
              Collector.eta_zero + Collector.m*dT/max(G,
                Modelica.Constants.eps)));
  P_el = G*eta;
  annotation (Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>Simplified Model for the electrical efficiency of a photovoltaic thermal collector. Inputs are outdoor air temperature, fluid temperature and solar irradiation. Based on these values and the collector properties from database, this model calculates the electrical power output of the collector. We assume that the fluid temperature is equal to the collector temperature. </p>
</html>"));
end SolarElectricalEfficiency;
