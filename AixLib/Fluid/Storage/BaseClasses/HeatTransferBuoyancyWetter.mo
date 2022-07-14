within AixLib.Fluid.Storage.BaseClasses;
model HeatTransferBuoyancyWetter "Heat transfer with buoyancy as in Buildings library"
  extends AixLib.Fluid.Storage.BaseClasses.PartialHeatTransferLayers;

  parameter Modelica.Units.SI.Time tau(min=0) = 100 "Time constant for mixing";
  Modelica.Units.SI.HeatFlowRate[n - 1] qFlow
    "Heat flow rate from segment i+1 to i";

protected
  parameter Modelica.Units.SI.Density rho0=1000
    "Density, used to compute fluid mass";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp0=4180
    "Specific heat capacity";
  Modelica.Units.SI.TemperatureDifference dT[n - 1]
    "Temperature difference between adjoining volumes";
   parameter Real k(unit="W/K2") = data.hTank*Modelica.Constants.pi/4*data.dTank^2*rho0*cp0/tau/n
    "Proportionality constant, since we use dT instead of dH";
equation

  for i in 1:n-1 loop
    dT[i] = therm[i].T-therm[i+1].T;
    qFlow[i] = k*noEvent(smooth(1, if dT[i]>0 then dT[i]^2 else 0));
  end for;

  therm[1].Q_flow = qFlow[1];
  for i in 2:n-1 loop
       therm[i].Q_flow = qFlow[i]-qFlow[i-1];
  end for;
  therm[n].Q_flow = -qFlow[n-1];

  annotation (Diagram(graphics), Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for heat transfer between buffer storage layers.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Models buoyancy according to
  Buildings.Fluid.Storage.BaseClasses.Buoyancy model of Buildings
  library, cf. https://simulationresearch.lbl.gov/modelica. No
  conduction is implemented apart from when buoyancy occurs.
</p>
</html>",
   revisions="<html><ul>
  <li>
    <i>October 12, 2016&#160;</i> by Marcus Fuchs:<br/>
    Add comments and fix documentation
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Sebastian Stinner:<br/>
    Added to AixLib
  </li>
  <li>
    <i>December 10, 2013</i> by Kristian Huchtemann:<br/>
    Added Documentation.
  </li>
  <li>
    <i>October 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end HeatTransferBuoyancyWetter;
