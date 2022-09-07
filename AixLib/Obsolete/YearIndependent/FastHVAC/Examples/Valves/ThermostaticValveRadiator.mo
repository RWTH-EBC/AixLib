within AixLib.Obsolete.YearIndependent.FastHVAC.Examples.Valves;
model ThermostaticValveRadiator
 extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant T_setRoom(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-96,-42},{-78,-24}})));
  Modelica.Blocks.Sources.Sine sine1(
    f=1/86400,
    offset=-2000,
    amplitude=1214) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,30})));
  Components.Valves.ThermostaticValve thermostaticValve(
    riseTime=5,
    filteredOpening=true,
    k=1,
  dotm_nominal=0.3)   annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=0,
        origin={-52,-28})));
  Components.Pumps.FluidSource fluidSource annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,-6})));
  Modelica.Blocks.Sources.Constant T_source(k=348.15) annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-49,11})));
  Components.Sinks.Vessel vessel annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={80,-8})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor room(C=99999999, T(
        start=293.15)) annotation (Placement(transformation(
        extent={{-21,-21},{21,21}},
        rotation=0,
        origin={25,51})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatLossesRoom
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={64,30})));
  Components.HeatExchangers.RadiatorMultiLayer radiatorMultiLayer(
  selectable=true,
  calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.log,
  radiatorType=
      DataBase.Radiators.Standard_MFD_WSchV1984_OneAppartment.Radiator_Livingroom(
      length=5)) annotation (Placement(transformation(
      extent={{-21,-20},{21,20}},
      rotation=0,
      origin={24,-7})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor roomTemperature
    annotation (Placement(transformation(extent={{54,56},{74,76}})));
  Modelica.Blocks.Interfaces.RealOutput dotm_pump
    annotation (Placement(transformation(extent={{66,-68},{86,-48}})));
  Modelica.Blocks.Interfaces.RealOutput setTemperature
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{66,-90},{86,-70}})));
equation

  connect(sine1.y, heatLossesRoom.Q_flow) annotation (Line(
      points={{79,30},{74,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(room.port, heatLossesRoom.port) annotation (Line(
      points={{25,30},{54,30}},
      color={191,0,0},
      smooth=Smooth.None));
connect(radiatorMultiLayer.enthalpyPort_b1, vessel.enthalpyPort_a)
  annotation (Line(
    points={{40.8,-7.4},{72.4,-7.4},{72.4,-8},{73,-8}},
    color={176,0,0},
    smooth=Smooth.None));
connect(fluidSource.enthalpyPort_b, radiatorMultiLayer.enthalpyPort_a1)
  annotation (Line(
    points={{-10,-5},{8,-5},{8,-7.4},{7.2,-7.4}},
    color={176,0,0},
    smooth=Smooth.None));
  connect(thermostaticValve.dotm_set, fluidSource.dotm) annotation (Line(
      points={{-37.6,-28},{-28,-28},{-28,-8.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_source.y, fluidSource.T_fluid) annotation (Line(
      points={{-41.3,11},{-28,11},{-28,-1.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_setRoom.y, thermostaticValve.T_set) annotation (Line(
      points={{-77.1,-33},{-67.55,-33},{-67.55,-32.8},{-66.4,-32.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(thermostaticValve.T_room, room.port) annotation (Line(
      points={{-66.4,-23.2},{-66.4,30},{25,30}},
      color={191,0,0},
      smooth=Smooth.None));
connect(room.port, radiatorMultiLayer.ConvectiveHeat) annotation (Line(
    points={{25,30},{24,30},{24,20},{12.66,20},{12.66,4.6}},
    color={191,0,0},
    smooth=Smooth.None));
connect(room.port, radiatorMultiLayer.RadiativeHeat) annotation (Line(
    points={{25,30},{24,30},{24,20},{35.76,20},{35.76,5}},
    color={191,0,0},
    smooth=Smooth.None));
  connect(roomTemperature.port, room.port) annotation (Line(
      points={{54,66},{44,66},{44,30},{25,30}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(thermostaticValve.dotm_set, dotm_pump) annotation (Line(
      points={{-37.6,-28},{-37.6,-58},{76,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(T_setRoom.y, setTemperature) annotation (Line(
      points={{-77.1,-33},{-77.1,-80},{76,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=172800,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end ThermostaticValveRadiator;
