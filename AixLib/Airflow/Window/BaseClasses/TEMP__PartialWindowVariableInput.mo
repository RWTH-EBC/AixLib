within AixLib.Airflow.Window.BaseClasses;
partial model TEMP__PartialWindowVariableInput
  "Window opening width or angle as variable input"
  extends PartialWindow;

  parameter Boolean useOpeningWidth=true
  "true = Use window opening width as input;
  false = Use window opening angle as input"
  annotation (Dialog(group="Parameters"),choices(checkBox=true));

  Modelica.Blocks.Interfaces.RealInput opnWidth if useOpeningWidth
    "Window opening width" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-60,120})));
  Modelica.Blocks.Interfaces.RealInput opnAngle if not useOpeningWidth
    "Window opening angle" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-20,120})));
end TEMP__PartialWindowVariableInput;
