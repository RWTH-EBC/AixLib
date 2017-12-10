within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities;
package Types "Types, constants to define menu choices"
  extends Modelica.Icons.TypesPackage;

  type ApplicationHX = enumeration(
    Evaporator
      "Evaporator",
    Condenser
      "Condenser")
    "Enumeration to define the application of the heat exchanger"
    annotation (Evaluate=true);

  type TypeHX = enumeration(
    DirectCurrent
      "Direct-current heat exchanger",
    CounterCurrent
      "Counter-current heat exchanger")
    "Enumeration to define types of heat exchangers"
    annotation (Evaluate=true);

  type GeometryCV = enumeration(
    Circular
      "Cross-sectional geometry - Circular heat exchanger",
    Plate
      "Cross-sectional geometry - Plate heat exchanger")
    "Enumeration to define the heat exchanger's cross-sectional geometry"
    annotation (Evaluate=true);

  type ModeCV = enumeration(
    SC
      "Supercooled",
    TP
      "Two-phase",
    SH
      "Superheated",
    SCTP
      "Supercooled - Two-phase",
    TPSH
      "Two-phase - Superheated",
    SCTPSH
      "Supercooled - Two-phase - Superheated")
    "Enumeration to define different kinds of control volumes"
    annotation (Evaluate=true);

  type CalculationHeatFlow = enumeration(
    Simplified
      "Simplified - Mean temperature differece",
    LMTD
      "LMTD - Logarithmic mean temperature difference",
    E_NTU
      "Epsilon-NTU - Method of number of transfer units")
    "Enumeration to define methods of calculating heat flows"
    annotation (Evaluate=true);

  type CalculationCoefficientOfHeatTransfer = enumeration(
    Constant
      "Constant - Simple model of a constant heat transfer coefficient")
    "Enumeration to define methods of calculating coefficient of heat transfer"
    annotation (Evaluate=true);

    annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 07, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This package contains types and constants to define menue choices.
</p>
</html>"));
end Types;
