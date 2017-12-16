within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Balances;
model WallConservation
  "Model to check the blanace equations of a wall cell"

  // Definition of inputs describing energy balances of each regime
  //
  input Modelica.SIunits.InternalEnergy USC
    "Energy of the working fluid of the supercooled regime"
    annotation(Dialog(tab="General",group="Energy balances"));
  input Modelica.SIunits.InternalEnergy UTP
    "Energy of the working fluid of the two-phase regime"
    annotation(Dialog(tab="General",group="Energy balances"));
  input Modelica.SIunits.InternalEnergy USH
    "Energy of the working fluid of the superheated regime"
    annotation(Dialog(tab="General",group="Energy balances"));
  input Real dUSCdt(unit="J/s")
    "Derivative of the working fluid's energy of the supercooled regime wrt. time"
    annotation(Dialog(tab="General",group="Energy balances"));
  input Real dUTPdt(unit="J/s")
    "Derivative of the working fluid's energy of the two-phase regime wrt. time"
    annotation(Dialog(tab="General",group="Energy balances"));
  input Real dUSHdt(unit="J/s")
    "Derivative of the working fluid's energy of the superheated regime wrt. time"
    annotation(Dialog(tab="General",group="Energy balances"));

  // Definition of variables describing energy balances
  //
  Modelica.SIunits.InternalEnergy UHX
    "Energy of the working fluid of all three flow regimes";
  Modelica.SIunits.InternalEnergy UHXInt
    "Energy of the working fluid of all three flow regimes";
  Modelica.SIunits.InternalEnergy USCInt
    "Energy of the working fluid of the supercooled regime calc. by integration";
  Modelica.SIunits.InternalEnergy UTPInt
    "Energy of the working fluid of the two-phase regime calc. by integration";
  Modelica.SIunits.InternalEnergy USHInt
    "Energy of the working fluid of the superheated regime calc. by integration";

  // Definition of variables describing deviations
  //
  Modelica.SIunits.InternalEnergy dUSC
    "Dofference of energy of the working fluid of the supercooled regime";
  Modelica.SIunits.InternalEnergy dUTP
    "Dofference of energy of the working fluid of the two-phase regime";
  Modelica.SIunits.InternalEnergy dUSH
    "Dofference of energy of the working fluid of the superheated regime";


initial equation
  USCInt = USC
    "Mass of the working fluid of the two-phase regime calc. by integration";
  UTPInt = UTP
    "Mass of the working fluid of the two-phase regime calc. by integration";
  USHInt = USH
    "Mass of the working fluid of the superheated regime calc. by integration";


equation
  // Calculate overall energy of the working fluid
  //
  UHX = USC + UTP + USH
    "Energy of the working fluid of all three flow regimes";
  UHXInt = USCInt + UTPInt + USHInt
    "Energy of the working fluid of all three flow regimes";

  // Calculate mass and energy of the working fluid by integration
  //
  der(USCInt) = dUSCdt
    "Mass of the working fluid of the two-phase regime calc. by integration";
  der(UTPInt) = dUTPdt
    "Mass of the working fluid of the two-phase regime calc. by integration";
  der(USHInt) = dUSHdt
    "Mass of the working fluid of the superheated regime calc. by integration";

  // Calculate differences
  //
  dUSC = USC - USCInt
    "Dofference of energy of the working fluid of the supercooled regime";
  dUTP = UTP - UTPInt
    "Dofference of energy of the working fluid of the two-phase regime";
  dUSH = USH - USHInt
    "Dofference of energy of the working fluid of the superheated regime";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          lineColor={135,135,135},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          extent={{-100,-100},{100,100}},
          radius=25),
        Text(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          textString="d(U)/dt = ...",
          textStyle={TextStyle.Bold})}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WallConservation;
