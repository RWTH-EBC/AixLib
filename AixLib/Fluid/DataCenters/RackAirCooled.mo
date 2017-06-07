within AixLib.Fluid.DataCenters;
model RackAirCooled
   extends AixLib.Fluid.DataCenters.BaseClasses.PartialRack(rackVolume(V=
          VfreeSpace*nRacks));

  parameter AixLib.DataBase.Servers.TempretaurePowerRatioBaseDataDefinition powerRatio=AixLib.DataBase.Servers.genericCPUTempPowerRatio()
    "Record contaning the temperature CPU-utilization and power consumption ratio"
    annotation (choicesAllMatching=true,Dialog(group="Servers"));

  parameter Modelica.SIunits.Power IdleServerPower = 126.65
    "Idle power comsumption of a single Server in Watt at 294.05K inflow temperatur" annotation (Dialog(group="Servers"));
  parameter Modelica.SIunits.Volume VfreeSpace = 0.25
    "Volume free space in rack. Depends on number of racks technically" annotation (Dialog(group="Racks"));

  parameter Real ConvectiveCoefficient = 12000
    "Real parameter representing the convective thermal conductance in [W/K] of the rack";

  Modelica.Blocks.Interfaces.RealInput CPUutilization
    "Average Utilization of CPUs build in rack in %" annotation (Placement(
        transformation(extent={{-140,60},{-100,100}}), iconTransformation(
          extent={{-120,80},{-100,100}})));
  Modelica.Blocks.Math.Gain IdlePower(k=IdleServerPower*nServers*nRacks)
    annotation (Placement(transformation(extent={{-10,56},{10,76}})));
  Modelica.Blocks.Tables.CombiTable2D rackPowerCorrectionTable(tableOnFile=
        false, table=powerRatio.powerRatio)
    "This table corrects the power consumption of the whole rack based on the CPU-Utilization using data from measurement."
    annotation (Placement(transformation(extent={{-44,56},{-24,76}})));
  Modelica.Blocks.Interfaces.RealOutput ITConsumption
    annotation (Placement(transformation(extent={{100,80},{120,100}})));


  FixedResistances.PressureDrop pressureDrop(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
equation
  connect(rackPowerCorrectionTable.y, IdlePower.u) annotation (Line(
      points={{-23,66},{-12,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(CPUutilization, rackPowerCorrectionTable.u2) annotation (Line(
      points={{-120,80},{-84,80},{-84,60},{-46,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(IdlePower.y, ITConsumption) annotation (Line(points={{11,66},{16,66},
          {16,90},{110,90}}, color={0,0,127}));
  connect(IdlePower.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{11,66},{16.5,66},{22,66}}, color={0,0,127}));
  connect(flowTemperature.T,rackPowerCorrectionTable. u1)
    annotation (Line(points={{-52,11},{-52,72},{-46,72}}, color={0,0,127}));
  connect(flowTemperature.port_a, pressureDrop.port_b)
    annotation (Line(points={{-62,0},{-70,0}}, color={0,127,255}));
  connect(port_a, pressureDrop.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end RackAirCooled;
