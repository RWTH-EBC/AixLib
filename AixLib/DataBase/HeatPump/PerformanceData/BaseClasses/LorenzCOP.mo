within AixLib.DataBase.HeatPump.PerformanceData.BaseClasses;
model LorenzCOP
  Modelica.Blocks.Interfaces.RealInput tHot_in annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,40})));
  Modelica.Blocks.Interfaces.RealInput tCold_in annotation (Placement(
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
  Modelica.Blocks.Interfaces.RealInput tHot_out annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,90})));
  Modelica.Blocks.Interfaces.RealInput tCold_out annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-90})));
equation

if greater.y then
  COP =1/(1 - (((tCold_out+tCold_in)/2)/((tHot_out+tHot_in)/2)));
else
  COP =  1;
end if;

  connect(tHot_in, greater.u1) annotation (Line(points={{-120,40},{-74,40},{-74,
          26},{-22,26}}, color={0,0,127}));
  connect(tCold_in, greater.u2) annotation (Line(points={{-120,-40},{-66,-40},{-66,
          18},{-22,18}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LorenzCOP;
