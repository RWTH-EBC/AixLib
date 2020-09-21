within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.HeatTransfer;
model MembraneHeatTransfer
  "model for heat transfer through a membrane"

  // General Parameters
  parameter Integer n = 2
    "Segmentation of membrane";
  parameter Integer nParallel
    "number of parallel air ducts";

  // Parameters
  parameter Modelica.SIunits.Length lengthMem
    "length of membrane in flow direction";
  parameter Modelica.SIunits.Length widthMem
    "width of membrane";
  parameter Modelica.SIunits.Length thicknessMem
    "thickness of membrane";
  parameter Modelica.SIunits.ThermalConductivity lambdaMem
    "thermal conductivity of membrane";
  parameter Modelica.SIunits.Density rhoMem
    "density of membrane";
  parameter Modelica.SIunits.SpecificHeatCapacity cpMem
    "mass weighted heat capacity of membrane";

  parameter Modelica.SIunits.Mass mMem=
    rhoMem*(lengthMem*widthMem*thicknessMem)*nParallel
    "mass of membrane"
    annotation (Dialog(enable=false));
  parameter Modelica.SIunits.Area areaMem=
    lengthMem*widthMem*nParallel
    "surface area of membrane"
    annotation (Dialog(enable=false));

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true);

  // Initialization
  parameter Modelica.SIunits.Temperature T_start
    "membrane temperature start value";
  parameter Modelica.SIunits.TemperatureDifference dT_start
    "start value for temperature difference between heatPorts_a and heatPorst_b";

  // Mass
  Modelica.SIunits.Mass[n] m=fill(mMem/n, n)
    "Distribution of wall mass";

  // Temperatures
  Modelica.SIunits.Temperature[n] Tb(each start=T_start+0.5*dT_start)
    "Temperature at side b";
  Modelica.SIunits.Temperature[n] Ta(each start=T_start-0.5*dT_start)
    "Temperature at side a";
  Modelica.SIunits.Temperature[n] Ts
    "Membrane temperature";

  // Ports
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[n] heatPorts_a
    "Heat port to component boundary" annotation (Placement(transformation(
          extent={{-10,60},{10,80}}), iconTransformation(extent={{-10,60},{10,80}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a[n] heatPorts_b
    "Heat port to component boundary" annotation (Placement(transformation(
          extent={{-10,-82},{10,-62}}), iconTransformation(extent={{-10,-80},{10,
            -60}})));

initial equation
  if energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyStateInitial then
    der(Ts) = zeros(n);
  elseif energyDynamics == Modelica.Fluid.Types.Dynamics.FixedInitial then
    Ts = ones(n)*T_start;
  end if;

equation
  for i in 1:n loop
    assert(m[i] > 0, "Membrane has negative dimensions");
    if energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
      0 = heatPorts_a[i].Q_flow + heatPorts_b[i].Q_flow;
    else
      cpMem*m[i]*der(Ts[i]) =
        heatPorts_a[i].Q_flow + heatPorts_b[i].Q_flow;
    end if;
    heatPorts_a[i].Q_flow = lambdaMem / thicknessMem * (Ta[i]-Ts[i]) *
      areaMem/n;
    heatPorts_b[i].Q_flow = lambdaMem / thicknessMem * (Tb[i]-Ts[i]) *
      areaMem/n;
  end for;

  Ta = heatPorts_a.T;
  Tb = heatPorts_b.T;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This heat transfer model calculates the locally resolved heat flow through a thin membrane using the thermal conductivity <i>&lambda;<sub>Membrane</sub> </i>and the membrane thickness <i>&delta;<sub>Membrane</sub> </i>.</p>
<p align=\"center\"><i>heatPorts_a[i].Q̇ = (&lambda;<sub>Membrane</sub> &frasl; &delta;<sub>Membrane</sub> ) (A<sub>Membrane</sub> &frasl; n ) (heatPorts_a[i].T - T<sub>Membrane</sub>[i] ) </i></p>
<p>Analogue for the second surface of the membrane:</p>
<p align=\"center\"><i>heatPorts_b[i].Q̇ = (&lambda;<sub>Membrane</sub> &frasl; &delta;<sub>Membrane</sub> ) (A<sub>Membrane</sub> &frasl; n ) (heatPorts_b[i].T - T<sub>Membrane</sub>[i] ) </i></p>
<p>If the energy dynamics are set to &quot;Steady State&quot; the membrane will not stroe any heat:</p>
<p align=\"center\"><i>0 = heatPorts_b[i].Q̇ + heatPorts_a[i].Q̇ </i></p>
<p>Otherwise the mebrane temperature will change with time.</p>
<p align=\"center\"><i>m<sub>Membrane</sub>[i] c<sub>p,Membrane</sub> dT<sub>Membrane</sub>[i] = heatPorts_a[i].Q̇ + heatPorts_b[i].Q̇ </i></p>
</html>", revisions="<html>
<ul>
<li>August 21, 2018, by Martin Kremer:<br/>First implementation. </li>
</ul>
</html>"));
end MembraneHeatTransfer;
