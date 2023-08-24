within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model Control

    parameter Modelica.Units.SI.Temperature T_cold_nom=273.15 + 35
                                                             "Return temperature"
   annotation (Dialog(group="Nominal condition"));

  AixLib.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PID,
    k=1,
    Ti=5,
    Td=1,
    yMin=0.01)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom1(y=T_cold_nom)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{-100,-12},{-58,12}})));
  AixLib.Controls.Continuous.LimPID conPID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1,
    Ti=5,
    Td=1,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{10,32},{30,52}})));
  Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(dTWaterNom1.y,conPID1. u_s) annotation (Line(points={{-55.9,0},{-46,0}},
                                          color={0,0,127}));
  connect(boilerControlBus.TSupplySet,conPID2. u_s) annotation (Line(
      points={{100,0},{-2,0},{-2,42},{8,42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TReturnMea,conPID1. u_m) annotation (Line(
      points={{100,0},{100,-34},{-34,-34},{-34,-12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.TSupplyMea,conPID2. u_m) annotation (Line(
      points={{100,0},{20,0},{20,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(conPID1.y, boilerControlBus.m_flowSet) annotation (Line(points={{-23,0},
          {100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID2.y, boilerControlBus.FirRatSet) annotation (Line(points={{31,42},
          {100,42},{100,0}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Control;
