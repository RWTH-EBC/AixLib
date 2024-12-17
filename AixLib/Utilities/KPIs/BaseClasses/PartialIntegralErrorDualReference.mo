within AixLib.Utilities.KPIs.BaseClasses;
partial model PartialIntegralErrorDualReference
  "Partial model for integral error with dual reference values"
  extends AixLib.Utilities.KPIs.BaseClasses.PartialIntegratorBase;
  Modelica.Blocks.Interfaces.RealInput u "Value input"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput refUpp "Upper reference value input"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput refLow "Lower reference value input"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput yPos
    "Positive integral error greater than upper reference"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput yNeg
    "Negative integral error less than lower reference"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
equation
  assert(refUpp > refLow, "Dual references wrong (refUpp<=refLow)");
end PartialIntegralErrorDualReference;
