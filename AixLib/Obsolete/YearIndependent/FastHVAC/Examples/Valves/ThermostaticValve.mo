within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Valves;
model ThermostaticValve
  extends Modelica.Icons.Example;
   Modelica.Blocks.Sources.Constant T_setRoom(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-88,-14},{-70,4}})));
  Components.Valves.ThermostaticValve thermostaticValve(
    riseTime=5,
    k=1,
    dotm_nominal=0.2,
    filteredOpening=false)
                      annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=0,
        origin={-44,0})));
  Modelica.Blocks.Interfaces.RealOutput dotm_pump
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));
  Modelica.Blocks.Interfaces.RealOutput setTemperature
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{74,-32},{94,-12}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature varTemp
    annotation (Placement(transformation(extent={{-32,32},{-52,52}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=36000,
    offset=273.15 + 15,
    height=5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-4,24})));
  Modelica.Blocks.Interfaces.RealOutput T_actually
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{70,38},{90,58}})));
equation

  connect(T_setRoom.y, thermostaticValve.T_set) annotation (Line(
      points={{-69.1,-5},{-59.55,-5},{-59.55,-4.8},{-58.4,-4.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(thermostaticValve.dotm_set, dotm_pump) annotation (Line(
      points={{-29.6,0},{84,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_setRoom.y, setTemperature) annotation (Line(
      points={{-69.1,-5},{-69.1,-22},{84,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(varTemp.port, thermostaticValve.T_room) annotation (Line(
      points={{-52,42},{-58.4,42},{-58.4,4.8}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(ramp.y, varTemp.T) annotation (Line(
      points={{-15,24},{-30,24},{-30,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ramp.y, T_actually) annotation (Line(
      points={{-15,24},{-20,24},{-20,48},{80,48}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=172800,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end ThermostaticValve;
