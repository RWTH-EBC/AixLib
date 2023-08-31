within AixLib.ThermalZones.HighOrder.SpawnOfEP;
model Multizone

  parameter Integer nZones= 1
                             "Number of zones";
  parameter Integer nPorts=0
    "Number of fluid ports (equals to 2 for one inlet and one outlet)"
    annotation (Evaluate=true,Dialog(connectorSizing=true,tab="General",group="Ports"));
  replaceable package Medium=Buildings.Media.Air
    "Medium model";
  parameter String zoneNames[nZones]
    "Name of the thermal zone as specified in the EnergyPlus input";
  parameter Boolean use_C_flow[nZones]=fill(false, nZones)
    "Set to true to enable input connector for trace substance that is connected to room air";

  Buildings.ThermalZones.EnergyPlus_9_6_0.ThermalZone zon[nZones](
    zoneName=zoneNames,
    redeclare package Medium = Medium,
    use_C_flow=use_C_flow,
    each nPorts=nPorts)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir[nZones]
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
  Modelica.Blocks.Interfaces.RealOutput TRooAir[nZones](each unit="K", each
      displayUnit="degC") "Room air temperatures" annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},
            {120,10}})));
  Modelica.Blocks.Interfaces.RealInput qGai_flow[nZones,3]
    "Radiant, convective sensible and latent heat input into room (positive if heat gain)"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b portsExt[nZones,nPorts](
     redeclare each package Medium = Medium) "Fluid inlets and outlets"
    annotation (Dialog(connectorSizing=true),Placement(transformation(
        extent={{40,-10},{-40,10}},
        rotation=180,
        origin={2,-94}), iconTransformation(
        extent={{40,-9},{-40,9}},
        rotation=180,
        origin={2,-99})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorExt[nZones]
    "Heat port to air volume"
    annotation (Placement(transformation(extent={{-68,-108},{-48,-88}})));

equation
  connect(temAir.T, TRooAir)
    annotation (Line(points={{85,0},{110,0}}, color={0,0,127}));
  connect(zon.heaPorAir, temAir.port) annotation (Line(points={{0,0},{-6,0},{-6,
          38},{62,38},{62,0},{64,0}}, color={191,0,0}));
  connect(qGai_flow, zon.qGai_flow) annotation (Line(points={{-100,0},{-60,0},{-60,
          10},{-22,10}}, color={0,0,127}));
  connect(heaPorExt, zon.heaPorAir) annotation (Line(points={{-58,-98},{-58,-26},
          {0,-26},{0,0}}, color={191,0,0}));
  for i in 1:nZones loop
      connect(zon[i].ports[:], portsExt[i,:])
                                             annotation (Line(points={{0,-19.1},{0,-94},{2,-94}},color={0,127,255}));
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Multizone;
