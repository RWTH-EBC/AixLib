within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialEmpiricalFlow
  "Partial model for empirical expressions of ventilation flow rate"
  parameter Boolean useOpnAreaInput = false
    "If activate the input port for the opening area";
  parameter Boolean useSpecOpnAreaTyp = false
    "If use a specific opening area type for the RealInput";
  parameter AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes
    opnAreaTyp = AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric
    "Window opening area types for calculation";
  parameter Modelica.Units.SI.Length winClrW(min=0)
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrH(min=0)
    "Height of the window clear opening";
  /*Convertible input port of opening area*/
  Modelica.Blocks.Interfaces.RealInput A(unit="m2", min=0)
    if useOpnAreaInput and not useSpecOpnAreaTyp
    "Window opening area, non-specific"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput A_geo(unit="m2", min=0)
    if useOpnAreaInput and useSpecOpnAreaTyp and
      opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Geometric
    "Window geometric opening area"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput A_proj(unit="m2", min=0)
    if useOpnAreaInput and useSpecOpnAreaTyp and
      opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Projective
    "Window projective opening area"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput A_eq(unit="m2", min=0)
    if useOpnAreaInput and useSpecOpnAreaTyp and
      opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Equivalent
    "Window equivalent opening area"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealInput A_eff(unit="m2", min=0)
    if useOpnAreaInput and useSpecOpnAreaTyp and
      opnAreaTyp == AixLib.Airflow.WindowVentilation.BaseClasses.Types.OpeningAreaTypes.Effective
    "Window effective opening area"
    annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput V_flow(unit="m3/s", min=0)
    "Ventilation flow rate"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialEmpiricalFlow;
