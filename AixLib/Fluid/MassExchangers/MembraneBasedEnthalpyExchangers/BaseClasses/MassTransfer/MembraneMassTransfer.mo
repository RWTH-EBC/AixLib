within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.BaseClasses.MassTransfer;
model MembraneMassTransfer "model for mass transfer through membrane"

  // General Parameter
  parameter Integer n = 2
    "Segmentation of membrane";
  parameter Real nParallel
    "number of parallel air ducts";

  // Parameter
  parameter Modelica.SIunits.Length lengthMem
    "length of membrane in flow direction";
  parameter Modelica.SIunits.Length widthMem
    "width of membrane";
  parameter Modelica.SIunits.Length thicknessMem
    "thickness of membrane";
  parameter Modelica.SIunits.Density rhoMem
    "density of membrane";
  parameter Modelica.SIunits.Area areaMem=
    lengthMem*widthMem*nParallel
    "surface area of membrane"
    annotation (Dialog(enable=false));

  // Initialization
  parameter Modelica.SIunits.PartialPressure p_start
    "start value for mean partial pressure at membrane's surfaces";
  parameter Modelica.SIunits.PartialPressure dp_start
    "start value for partial pressure difference between membrane's surfaces";

  // Inputs
  input Real perMem(unit="mol/(m.s.Pa)") "membrane's permeability in Barrer";

//   // partial pressures
//   Modelica.SIunits.PartialPressure[n] p_b(each start=p_start+0.5*dp_start);
//   Modelica.SIunits.PartialPressure[n] p_a(each start=p_start-0.5*dp_start);
//
//   Modelica.SIunits.MolarMass[n] M_a "molar mass of moist air at side a";
//   Modelica.SIunits.MolarMass[n] M_b "molar mass of moist air at side b";

  // Ports
  Utilities.MassTransfer.MassPort[n] massPorts_a
    "mass port to component boundary" annotation (Placement(transformation(
          extent={{-14,56},{14,84}}), iconTransformation(extent={{-16,54},{16,86}})));
  Utilities.MassTransfer.MassPort[n] massPorts_b
    "mass port to component boundary" annotation (Placement(transformation(
          extent={{-14,-84},{14,-56}}), iconTransformation(extent={{-16,-88},{16,
            -54}})));

protected
  constant Real cCon = 3.33*10^(-16)
    "conversion factor for permeability to calculate SI-units from Barrer";
  // 1 Barrer = 3.33*10^(-16) (mol*m)/(m²*s*Pa)
  // calculated from: Stern, S.A.: The "Barrer" Permeability Unit.
  //                  J. of Polym. Sci. Vol. 6. 1968
   constant Modelica.SIunits.MolarMass M_steam = 0.01802;
//   constant Modelica.SIunits.MolarMass M_air = 0.028949;
  // source: Detlev Möller: Luft: Chemie, Physik, Biologie, Reinhaltung, Recht.
  //         Walter de Gruyter, 2003, ISBN 3-11-016431-0, S. 173

equation
  for i in 1:n loop
    0 = massPorts_a[i].m_flow + massPorts_b[i].m_flow;
    massPorts_a[i].m_flow = (perMem * cCon * M_steam) *
      (massPorts_a[i].p - massPorts_b[i].p) / thicknessMem * areaMem/n;

//     p_a[i] = massPorts_a[i].p * massPorts_a[i].X * (M_a[i]/M_steam);
//     p_b[i] = massPorts_b[i].p * massPorts_b[i].X * (M_b[i]/M_steam);

//     M_a[i] = 1/(massPorts_a[i].X / M_steam + (1 - massPorts_a[i].X) / M_air);
//     M_b[i] = 1/(massPorts_b[i].X / M_steam + (1 - massPorts_b[i].X) / M_air);
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model calculates the locally distributed mass transfer through a thin membrane. The model is based on the Solution-Diffusion model. It uses the permeability to describe the process of sorption, diffusion and desorption of the water vapour. For detailed information see [1].</p>
<h4>References</h4>
<p>[1]: Koester, S.; Roghmans, F.; Wessling, M.: <i>Water vapor permeance: The interplay of feed and permeate activity</i> ; Journal of Membrane Science; Vol. 485 (2015) pp. 69-78</p>
</html>", revisions="<html>
<ul>
<li>November 20, 2018, by Martin Kremer:<br/>Changing mass transfer calculation: Now using permeability and thickness of membrane instead of permeance.</li>
<li>August 21, 2018, by Martin Kremer:<br/>First implementation.</li>
</ul>
</html>"));
end MembraneMassTransfer;
