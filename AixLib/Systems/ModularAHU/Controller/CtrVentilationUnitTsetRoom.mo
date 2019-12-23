within AixLib.Systems.ModularAHU.Controller;
model CtrVentilationUnitTsetRoom
  "Controller for ventilation unit that controlls the room temperature"
  CtrVentilationUnitBasic ctrVentilationUnitBasic(final useExternalTset=true)
    annotation (Dialog(enable = true), Placement(transformation(extent={{40,-10},{60,10}})));
  BaseClasses.GenericAHUBus genericAHUBus1
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    yMax=yMax,
    yMin=yMin) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      parameter Modelica.SIunits.Temperature TRoomSet=289.15
    "Flow temperature set point of room"
    annotation (Dialog(enable=useExternalTset == false));
  parameter Real k=0.2 "Gain of controller";
  parameter Modelica.SIunits.Time Ti=300 "Time constant of Integrator block";
  parameter Real yMax=298.15 "Upper limit of output";
  parameter Real yMin=289.15 "Lower limit of output";
  Modelica.Blocks.Sources.Constant constTflowSet(final k=TRoomSet)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput T_act
    "Connector of measurement input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-120,-20},{-80,20}})));
equation
  connect(ctrVentilationUnitBasic.genericAHUBus, genericAHUBus1) annotation (
      Line(
      points={{60,0.1},{81,0.1},{81,0},{102,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID.y, ctrVentilationUnitBasic.Tset)
    annotation (Line(points={{1,0},{38,0}}, color={0,0,127}));
  connect(constTflowSet.y, PID.u_s)
    annotation (Line(points={{-39,0},{-22,0}}, color={0,0,127}));
  connect(PID.u_m, T_act) annotation (Line(points={{-10,-12},{-10,-38},{-92,-38},
          {-92,0},{-120,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CtrVentilationUnitTsetRoom;
