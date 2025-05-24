within AixLib.DataBase.HeatPump.PerformanceData.BaseClasses;
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

  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{-20,16},{0,36}})));
equation

if greater.y then
  COP =  1 / (1 - (tCold / tHot));
else
  COP =  1;
end if;

  connect(tHot, greater.u1) annotation (Line(points={{-120,40},{-74,40},{-74,26},
          {-22,26}}, color={0,0,127}));
  connect(tCold, greater.u2) annotation (Line(points={{-120,-40},{-66,-40},{-66,
          18},{-22,18}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CarnotCOP;
