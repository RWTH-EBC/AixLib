within AixLib.Airflow.AirHandlingUnit.BaseClasses;
model boundaryConditions
  "describes the boundary conditions for the sources"

  parameter Real T = 293.15 "Inlet Temperature";
  parameter Real phi(  min= 0, max = 1) = 0.5 "Inlet relative humidity";
  parameter Real p = 101325 "Inlet pressure";

  Modelica.Blocks.Sources.RealExpression rh_exhaust(y=phi)   annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-34,0})));
  relToAbsHum             relToAbsHum1 annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={14,0})));
  Modelica.Blocks.Sources.RealExpression T_In1(y=T)             annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-34,20})));
  Modelica.Blocks.Sources.RealExpression p_exhaust(y=p)       annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-78,60})));
  Modelica.Blocks.Interfaces.RealOutput T_In
    annotation (Placement(transformation(extent={{96,10},{116,30}})));
  Modelica.Blocks.Interfaces.RealOutput p_In
    annotation (Placement(transformation(extent={{96,50},{116,70}})));
  Modelica.Blocks.Interfaces.RealOutput Xw_In
    annotation (Placement(transformation(extent={{96,-30},{116,-10}})));
  Modelica.Blocks.Interfaces.RealOutput Xair_In
    annotation (Placement(transformation(extent={{96,-70},{116,-50}})));
equation
  connect(rh_exhaust.y,relToAbsHum1. relHum) annotation (Line(points={{-23,0},{3.4,
          0}},                    color={0,0,127}));
  connect(T_In1.y,relToAbsHum1. Tem) annotation (Line(points={{-23,20},{-10,20},
          {-10,6},{3.4,6}},     color={0,0,127}));
  connect(T_In1.y, T_In)
    annotation (Line(points={{-23,20},{106,20}}, color={0,0,127}));
  connect(p_exhaust.y, p_In)
    annotation (Line(points={{-67,60},{106,60}}, color={0,0,127}));
  connect(p_exhaust.y, relToAbsHum1.p_In) annotation (Line(points={{-67,60},{-54,
          60},{-54,-6},{3.4,-6}}, color={0,0,127}));
  connect(relToAbsHum1.X_w[2], Xair_In) annotation (Line(points={{24.6,0.5},{62,
          0.5},{62,-60},{106,-60}}, color={0,0,127}));
  connect(relToAbsHum1.X_w[1], Xw_In) annotation (Line(points={{24.6,-0.5},{62,
          -0.5},{62,-20},{106,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end boundaryConditions;
