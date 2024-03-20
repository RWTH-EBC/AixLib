within AixLib.Airflow.Window.BaseClasses.Types;
type WindowOpeningTypes = enumeration(
    Simple "Simple opening without sash",
    SideHungInward "Side-hung opening, inward (casement)",
    SideHungOutward "Side-hung opening, outward (casement)",
    TopHungOutward "Top-hung opening, outward (awning)",
    BottomHungInward "Bottom-hung opening, inward (hopper, tilt)",
    PivotVertical "Pivot vertical opening (centre hinge vertical)",
    PivotHorizontal "Pivot horizontal opening (centre hinge horizontal)",
    SlidingVertical "Sliding opening vertical (single-hung or double-hung)",
    SlidingHorizontal "Sliding opening horizontal (slider)",
    Fixed "Fixed glazed window without any sash")
    "Enumeration to define window opening types";
