within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model Iteration_ExhaustTemp

  Real T_RL=60;

  Real Delta_T=20;

  Real T_ag2;

  Real DT_W; // logarithmisch gemittelte Temperatur

  constant Real cp_W=4.18;
  constant Real T_F=1686.4;
  constant Real a=0.0031264; // Gradient zur Berechnung kA


  Modelica.Blocks.Interfaces.RealOutput T_AG
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput PLR
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  DT_W=(Delta_T*PLR)/log(((Delta_T*PLR)+T_RL)/T_RL);

algorithm
  T_ag2:=120;

    while abs(T_AG-T_ag2)>=0.01 loop
     T_AG:=DT_W + (T_F - DT_W)*exp(-(a*(T_F - T_ag2)/PLR));
  T_ag2:=T_ag2 - 0.001;
    end while;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100));
end Iteration_ExhaustTemp;
