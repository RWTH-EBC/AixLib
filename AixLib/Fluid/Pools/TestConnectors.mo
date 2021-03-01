within AixLib.Fluid.Pools;
model TestConnectors


  Modelica.Blocks.Sources.Constant const(k=300)
    annotation (Placement(transformation(extent={{-86,70},{-66,90}})));
  Modelica.Blocks.Sources.Constant const1(k=303)
    annotation (Placement(transformation(extent={{-86,38},{-66,58}})));
  Modelica.Blocks.Sources.Constant const2(k=4884.6*1000)
    annotation (Placement(transformation(extent={{-84,-42},{-64,-22}})));
  Modelica.Blocks.Sources.Constant const3(k=9772*1000)
    annotation (Placement(transformation(extent={{-82,-76},{-62,-56}})));
  RechnenMitVektoren rechnenMitVektoren(num=2, nun=2)
    annotation (Placement(transformation(extent={{-10,4},{10,24}})));
equation

  connect(const.y, rechnenMitVektoren.T[1]) annotation (Line(points={{-65,80},{-65,
          50},{-9.8,50},{-9.8,17}}, color={0,0,127}));

  connect(const1.y, rechnenMitVektoren.T[2]) annotation (Line(points={{-65,48},{
          -38,48},{-38,19},{-9.8,19}}, color={0,0,127}));
  connect(const2.y, rechnenMitVektoren.Q_Lat[1]) annotation (Line(points={{-63,-32},
          {-38,-32},{-38,10.8},{-9.6,10.8}}, color={0,0,127}));
  connect(const3.y, rechnenMitVektoren.Q_Lat[2]) annotation (Line(points={{-61,-66},
          {-36,-66},{-36,12.8},{-9.6,12.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestConnectors;
