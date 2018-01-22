within AixLib.Building.Components.DryAir.BaseClasses;
model BasisAirloadconstTemp "constant temperature"
  extends AixLib.Building.Components.DryAir.BaseClasses.PartialBasisAirload;
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_a ports(redeclare package
                                                                                Medium = AirMedium)
                                                                                                    annotation (Placement(transformation(extent={{-40,-110},{40,-90}})));

  Modelica.SIunits.Pressure pvar(start = p, fixed = true) "Current pressure of the room";
  Modelica.SIunits.Mass m "Mass of air";
protected
  Modelica.SIunits.SpecificHeatCapacity cp_const;
  Modelica.SIunits.SpecificHeatCapacity cv_const;
  AirMedium.ThermodynamicState state = AirMedium.setState_pTX(pvar, T);
initial equation
  cp_const = AirMedium.specificHeatCapacityCp(state);
  cv_const = AirMedium.specificHeatCapacityCv(state);
equation
  ports.p = pvar;
  der(cp_const)=0;
  der(cv_const)=0;
  pvar = m * (cp_const-cv_const) * T / V;
  der(m) = ports.m_flow;
  ports.h_outflow = cp_const * T;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>BasisAirloadconstTemp</b> model represents a room airload with a constant temperature, that has variable pressure and density conditions.</p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>This model is used as a simplyfied model for the room airload.</p>
 <p>Pressure and mass flow rate are linked to the <code>FluidPorts_a</code>. </p>
 </html>", revisions="<html>
 <ul>
 <li><i>Jan 22, 2008&nbsp;</i>
by Tim R&ouml;der:<br/>
          Implemented.</li>
 </ul>
 </html>"));
end BasisAirloadconstTemp;
