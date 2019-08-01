within AixLib.Systems.Benchmark.Model;
model testmodel
  Modelica.Blocks.Math.Sum K_Investition
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Blocks.Math.Sum K_Betrieb
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=2)
    annotation (Placement(transformation(extent={{74,-6},{86,6}})));
    constant real q;
    constant real i; //Zinssatz

  Modelica.Blocks.Math.Sum K_Energiebezug
    annotation (Placement(transformation(extent={{-2,-94},{18,-74}})));
equation
  connect(K_Betrieb.y, multiSum.u[1]) annotation (Line(points={{61,-20},{68,-20},
          {68,2.1},{74,2.1}}, color={0,0,127}));
  connect(K_Investition.y, multiSum.u[2]) annotation (Line(points={{61,20},{66,20},
          {66,-2.1},{74,-2.1}}, color={0,0,127}));
          i=0.05;
          q=1+i;

  connect(K_Energiebezug.y, K_Betrieb.u[1]) annotation (Line(points={{19,-84},{
          28,-84},{28,-20},{38,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end testmodel;
