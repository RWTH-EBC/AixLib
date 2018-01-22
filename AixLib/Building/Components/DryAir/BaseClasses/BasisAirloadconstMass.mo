within AixLib.Building.Components.DryAir.BaseClasses;
model BasisAirloadconstMass "constant mass"
  extends AixLib.Building.Components.DryAir.BaseClasses.PartialBasisAirload;
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

  Modelica.SIunits.Temperature Tvar(start=T, fixed=true, displayUnit="degC") "Current temperature of the room";
  Modelica.SIunits.Density d "Density of air";
protected
  Modelica.SIunits.SpecificHeatCapacity cp_const;
  AirMedium.ThermodynamicState state = AirMedium.setState_pTX(p, Tvar);
initial equation
   d = AirMedium.density(state);
   cp_const = AirMedium.specificHeatCapacityCp(state);
equation
  port.T = Tvar;
  der(d)=0;
  der(cp_const)=0;
  d * V * cp_const * der(Tvar) = port.Q_flow;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
              Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>BasisAirloadconstMass</b> model represents a room airload with a constant mass, that has a specific heat capacity.</p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>This model is used as a simplyfied model for the room airload.</p>
 <p>Temperature and heat flow rate are linked to the <code>HeatPort_a</code>. </p>
 </html>", revisions="<html>
 <ul>
 <li><i>Jan 22, 2008&nbsp;</i>
by Tim R&ouml;der:<br/>
          Implemented.</li>
 </ul>
 </html>"));
end BasisAirloadconstMass;
