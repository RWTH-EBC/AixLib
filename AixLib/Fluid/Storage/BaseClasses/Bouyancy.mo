within AixLib.Fluid.Storage.BaseClasses;
model Bouyancy
  parameter Modelica.Units.SI.Area A=1;
  parameter Modelica.Units.SI.RelativePressureCoefficient beta=350e-6;
  parameter Modelica.Units.SI.Length dx=0.2;
  parameter Real kappa = 0.4;
  Modelica.Units.SI.TemperatureDifference dT;
  Modelica.Units.SI.ThermalConductivity lambda_eff;
  parameter Modelica.Units.SI.Acceleration g=Modelica.Constants.g_n;
  Modelica.Units.SI.SpecificHeatCapacity cp=4180;
  Modelica.Units.SI.ThermalConductivity lambda=0.598;
  Modelica.Units.SI.Density rho=1000;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(transformation(extent = {{-16, 86}, {4, 106}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(transformation(extent = {{-16, -104}, {4, -84}})));
equation
  dT = port_a.T - port_b.T;
  if dT > 0 then
    lambda_eff = lambda;
  else
    lambda_eff = lambda + 2 / 3 * rho * cp * kappa * dx ^ 2 * sqrt(abs(-g * beta * dT / dx));
  end if;
  port_a.Q_flow = lambda_eff * A / dx * dT;
  port_a.Q_flow + port_b.Q_flow = 0;
  annotation (Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Bouyancy model for the heat transfer between the layers in a buffer
  storage.
</p>
<p>
  13.12.2013, by <i>Sebastian Stinner</i>: implemented
</p>
</html>"));
end Bouyancy;
