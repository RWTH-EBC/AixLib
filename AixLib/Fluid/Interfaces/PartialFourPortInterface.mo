within AixLib.Fluid.Interfaces;
     "Small mass flow rate for regularization of zero flow"
partial model PartialFourPortInterface
  "Partial model transporting fluid between two ports without storing mass or energy"
  extends AixLib.Fluid.Interfaces.PartialFourPort;
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal(min=0)
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal(min=0)
    "Nominal mass flow rate"
    annotation(Dialog(group = "Nominal condition"));
  parameter Medium1.MassFlowRate m1_flow_small(min=0) = 1E-4*abs(m1_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));
  parameter Medium2.MassFlowRate m2_flow_small(min=0) = 1E-4*abs(m2_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation(Dialog(tab = "Advanced"));
  // Diagnostics
  parameter Boolean show_T = false
    "= true, if actual temperature at port is computed"
    annotation (
      Dialog(tab="Advanced", group="Diagnostics"),
      HideResult=true);
