within AixLib.Airflow.WindowVentilation.BaseClasses.Types;
type WindowOpeningTypes = enumeration(
    SideHungInward "Side-hung opening, inward (casement)",
    SideHungOutward "Side-hung opening, outward (casement)",
    TopHungOutward "Top-hung opening, outward (awning)",
    BottomHungInward "Bottom-hung opening, inward (hopper, tilt)",
    PivotVertical "Pivot vertical opening (centre hinge vertical)",
    PivotHorizontal "Pivot horizontal opening (centre hinge horizontal)",
    SlidingVertical "Sliding opening vertical (single-hung or double-hung)",
    SlidingHorizontal "Sliding opening horizontal (slider)")
    "Enumeration to define window opening types" annotation (Documentation(info=
       "<html>
<p>This enum defines window sash opening types.</p>
</html>"));
