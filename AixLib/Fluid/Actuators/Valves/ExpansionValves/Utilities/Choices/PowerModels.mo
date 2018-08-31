within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices;
type PowerModels = enumeration(
    ShanweiEtAl2005
    "ShanweiEtAl2005 - Function of area, pressures, subcooling and densities",
    ZhifangAndOu2008
    "ZhifangAndOu2008 - Function of geometry data and various media properties",
    Li2013
    "Li2013 - Function of opening degree and subcooling")
  "Enumeration to define power models for calculating flow coefficient"
  annotation (Evaluate=true);
