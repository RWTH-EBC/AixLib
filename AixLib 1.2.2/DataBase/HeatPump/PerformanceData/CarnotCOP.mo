within AixLib.DataBase.HeatPump.PerformanceData;
model CarnotCOP
  Modelica.Blocks.Interfaces.RealInput tHot annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,40})));
  Modelica.Blocks.Interfaces.RealInput tCold annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-40})));
  Modelica.Blocks.Interfaces.RealOutput COP
    "Carnot COP" annotation (Placement(
        transformation(
        extent={{-11.5,-12},{11.5,12}},
        rotation=0,
        origin={111.5,-2}), iconTransformation(extent={{-11.5,-10.5},{11.5,10.5}},
          origin={111.5,-0.5})));


equation

  COP=1/(1-(tCold/tHot));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CarnotCOP;
