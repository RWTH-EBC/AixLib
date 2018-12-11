within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types;
type MetaPolynomialModel = enumeration(
    Liang2009       "Liang2009- Function of area, pressures and subcooling temperature",
    Liu2007       "Liu2007- Function of Frozen Flow and equilibrium Flow Model")
  "Enumeration to define polynomial models for calculating metastability coefficient"
          annotation (Evaluate=true);
