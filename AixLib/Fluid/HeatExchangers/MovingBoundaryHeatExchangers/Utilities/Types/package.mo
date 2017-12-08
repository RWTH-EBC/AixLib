within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities;
package Types "Types, constants to define menu choices"
  extends Modelica.Icons.TypesPackage;

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
