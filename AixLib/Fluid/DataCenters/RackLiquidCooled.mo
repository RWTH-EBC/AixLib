within AixLib.Fluid.DataCenters;
model RackLiquidCooled
   extends AixLib.Fluid.DataCenters.BaseClasses.PartialRack(rackVolume(V=
          nServers*nRacks*(1e-4)));

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

  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = Medium,
    length=0.5*4,
    diameter=0.019)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Thermal.HeatTransfer.Components.Convection coolingConvection
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={50,-30})));
  Modelica.Blocks.Sources.Constant convectiveCoefficientAir(k=3)
    annotation (Placement(transformation(extent={{6,-40},{26,-20}})));
  Building.Components.DryAir.VarAirExchange        varAirExchange(V=VfreeSpace*
        nRacks)
    annotation (Placement(transformation(extent={{6,-70},{26,-50}})));
  Building.Components.DryAir.Airload        airload(
    V=VfreeSpace*nRacks,
    rho=1.25,
    c=1000,
    T(start=T_startAir))
    annotation (Placement(transformation(extent={{52,-68},{72,-48}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=298.15)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
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
  connect(port_a, pipe.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(pipe.port_b, flowTemperature.port_a)
    annotation (Line(points={{-70,0},{-70,0},{-62,0}}, color={0,127,255}));
  connect(coolingConvection.Gc,convectiveCoefficientAir. y)
    annotation (Line(points={{40,-30},{34,-30},{27,-30}}, color={0,0,127}));
  connect(airload.port,coolingConvection. fluid)
    annotation (Line(points={{53,-60},{50,-60},{50,-40}}, color={191,0,0}));
  connect(varAirExchange.port_b,airload. port)
    annotation (Line(points={{26,-60},{53,-60}}, color={191,0,0}));
  connect(varAirExchange.port_a,fixedTemperature. port)
    annotation (Line(points={{6,-60},{-8,-60},{-20,-60}}, color={191,0,0}));
  connect(const.y,varAirExchange. InPort1) annotation (Line(points={{-19,-90},{
          -10,-90},{0,-90},{0,-66.4},{7,-66.4}},
                                             color={0,0,127}));
  connect(coolingConvection.solid, rackVolume.heatPort)
    annotation (Line(points={{50,-20},{50,16},{68,16}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
This is a simple liquid cooled rack model considering the whole rack or a row of racks as a single lumped volume and air node inside. 
It calculates the heat dissipation of the IT components in the servers located in the racks based on the CPU utilization.
The values are chosen based on measurement data of a test bed at TU Berlin.
</p>
<p>
Changing the idle power of a single server and number f racks and servers, this model can simulate various data center rack setups.
</p>
</html>", revisions="<html>
<ul>
<li>
<i>June 07, 2017&nbsp;</i>  by Pooyan Jahangiri:<br/>
First implementation.
</li>
</ul>
</html>"));
end RackLiquidCooled;
