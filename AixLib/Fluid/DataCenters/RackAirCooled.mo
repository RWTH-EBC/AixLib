within AixLib.Fluid.DataCenters;
model RackAirCooled
   extends AixLib.Fluid.DataCenters.BaseClasses.PartialRack(rackVolume(V=
           V_freeSpace*n_racks), coolingChannel(
       length=0.5,
       diameter=0.5,
       isCircular=false));

  parameter Integer n_servers = 16 "Number of servers in rack";
  parameter Integer n_racks = 1
    "Number of racks (only for experimental purposes, since this is a model of a single rack)";
  parameter Modelica.SIunits.Mass m_server = 24.4
    "Average mass of a single server (1 to 4 HU)";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_IT = 600
    "Average heat capacity of all the IT equipments";
  parameter Modelica.SIunits.Power IdleServerPower = 126.65
    "Idle power comsumption of a single Server in Watt at 294.05K inflow temperatur";
  parameter Modelica.SIunits.Mass m_RackHousing = 50
    "Mass of rack housing (usually about 50kg per rack)";
  parameter Modelica.SIunits.Volume V_freeSpace = 0.25
    "Volume free space in rack. Depends on number of racks technically";
  parameter Real ConvectiveCoefficient = 12000
    "Real parameter representing the convective thermal conductance in [W/K] of the rack";
    parameter Modelica.SIunits.Temperature T_startIT = 307.15
    "Initial temperature of the IT surface";
  Modelica.Blocks.Interfaces.RealInput CPU_utilization
    "Average Utilization of CPUs build in rack in %"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}}),
        iconTransformation(extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Math.Gain IdlePower(k=IdleServerPower*n_servers*n_racks)
    annotation (Placement(transformation(extent={{-10,56},{10,76}})));
  Modelica.Blocks.Tables.CombiTable2D rackPowerCorrectionTable(
    tableOnFile=true,
    tableName="RackPowerData",
    fileName="RackPowerTable.mat")
    "This table corrects the power consumption of the whole rack based on the CPU-Utilization using data from measurement."
    annotation (Placement(transformation(extent={{-44,56},{-24,76}})));
  Modelica.Blocks.Interfaces.RealOutput ITConsumption
    annotation (Placement(transformation(extent={{100,80},{120,100}})));

  parameter Modelica.Media.Interfaces.Types.Temperature T_startAir=301.15
    "Start value of the air temperature inside the rack";
equation
  connect(rackPowerCorrectionTable.y, IdlePower.u) annotation (Line(
      points={{-23,66},{-12,66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(CPU_utilization,rackPowerCorrectionTable. u2) annotation (Line(
      points={{-120,70},{-84,70},{-84,60},{-46,60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(IdlePower.y, ITConsumption) annotation (Line(points={{11,66},{16,66},
          {16,90},{110,90}}, color={0,0,127}));
  connect(IdlePower.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{11,66},{16.5,66},{22,66}}, color={0,0,127}));
  connect(flowTemperature.T,rackPowerCorrectionTable. u1)
    annotation (Line(points={{-52,11},{-52,72},{-46,72}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end RackAirCooled;
