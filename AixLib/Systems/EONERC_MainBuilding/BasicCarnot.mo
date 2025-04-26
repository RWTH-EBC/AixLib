within AixLib.Systems.EONERC_MainBuilding;
model BasicCarnot

  parameter Real etaCarnot_nominal = 0.35;
  parameter Real etaPL = 1;

  Real COPCar;
  Real COP;
  Real QEva_flow_internal;

  Modelica.Blocks.Interfaces.RealInput TConAct
    annotation (Placement(transformation(extent={{-140,32},{-100,72}})));
  Modelica.Blocks.Interfaces.RealInput TEvaAct
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput QCon_flow_internal annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={2,120})));
  Modelica.Blocks.Interfaces.RealOutput P annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
    COPCar = TConAct/AixLib.Utilities.Math.Functions.smoothMax(
    x1=1,
    x2=TConAct - TEvaAct,
    deltaX=0.25) "Carnot efficiency";

    COP = etaCarnot_nominal * COPCar * etaPL;

    QCon_flow_internal = P - QEva_flow_internal;

    QEva_flow_internal = (1 - COP)*P;

end BasicCarnot;
