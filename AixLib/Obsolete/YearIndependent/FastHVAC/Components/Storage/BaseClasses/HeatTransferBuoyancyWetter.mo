within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses;
model HeatTransferBuoyancyWetter

  extends PartialHeatTransferLayers;
  parameter Modelica.Units.SI.Time tau(min=0) = 100 "Time constant for mixing";
  Modelica.Units.SI.HeatFlowRate[n - 1] Q_flow
    "Heat flow rate from segment i+1 to i";
  //parameter Medium.ThermodynamicState sta0 = Medium.setState_pTX(T=Medium.T_default,
  //       p=Medium.p_default, X=Medium.X_default[1:Medium.nXi]);
/*  BaseLib.BaseClasses.HeatTransfer.HeatCond[n-1] heatCond( each lambda=0.64,
    each A=Modelica.Constants.pi/4*data.d_Tank^2,
    each d=data.h_Tank/n) annotation 0;*/
protected
  parameter Modelica.Units.SI.Density rho0=1000
    "Density, used to compute fluid mass";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp0=4180
    "Specific heat capacity";
  Modelica.Units.SI.TemperatureDifference dT[n - 1]
    "Temperature difference between adjoining volumes";
   parameter Real k(unit="W/K") = data.hTank*Modelica.Constants.pi/4*data.dTank^2*rho0*cp0/tau/n
    "Proportionality constant, since we use dT instead of dH";
equation

  for i in 1:n-1 loop
    dT[i] = therm[i].T-therm[i+1].T;
    Q_flow[i] = k*noEvent(smooth(1, if dT[i]>0 then dT[i]^2 else 0));
  end for;

  therm[1].Q_flow = Q_flow[1];
  for i in 2:n-1 loop
       therm[i].Q_flow = Q_flow[i]-Q_flow[i-1];
  end for;
  therm[n].Q_flow = -Q_flow[n-1];

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
    <i>December 20, 2016&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
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
