within PhysicalCompressors.ReciprocatingCompressor.Utilities;
record DataBaseDefinition
  "Base data definition for geometrical quantities of reciprocating compressor"

  constant String name
  "Short description of the record";
  constant Modelica.SIunits.Diameter D_pis
  "Diameter of piston";
  constant Modelica.SIunits.Length H "Hub";
  constant Modelica.SIunits.Area A_env "Area of piston to enviroment";
  constant Real alpha_env "Heat flow coefficient, pistion-->ambient [W/m2K]";
  constant Real pistonRod_ratio "Ratio of rod and crankshaft";
  constant Modelica.SIunits.Area Aeff_in "Effective area valve in";
  constant Modelica.SIunits.Area Aeff_out "Effective area valve out";
  constant Real c_dead "Relative dead Volume of the piston";
  constant Modelica.SIunits.Pressure p_rub "Rubbing pressure";
  constant Modelica.SIunits.ThermalConductance G_wall_env "Thermal conductance between wall and ambient";

   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DataBaseDefinition;
