within AixLib.Fluid.Pool.BaseClasses;
model AirFlowMoistureToROM

  replaceable package AirMedium = AixLib.Media.Air annotation (choicesAllMatching=true);
  parameter Integer nPools = 1;

    //Parameters to enable addition of evaporation mass flow to ROM
  parameter Modelica.Units.SI.MassFlowRate m_flow_air_nominal=1
    "air flow rate between swimming hall and air layer above swimming pool";
  parameter Modelica.Units.SI.Volume VAirLay = 7500
    "volume of air layer above pool for mass exchange due to evaporation";

  Modelica.Blocks.Interfaces.RealInput QEva[nPools](final quantity=
        "HeatFlowRate", final unit="W") "Heat due to evaporation" annotation (
      Placement(transformation(extent={{118,26},{88,56}}), iconTransformation(
          extent={{106,24},{82,48}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_eva[nPools]
    "Water mass flow due to evaporation" annotation (Placement(transformation(
          extent={{120,-44},{88,-12}}), iconTransformation(extent={{108,-50},{
            82,-24}})));
  MixingVolumes.MixingVolumeMoistAir AirLay(
    redeclare package Medium = AirMedium,
    T_start=303.15,
    V=VAirLay,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=m_flow_air_nominal,
    nPorts=2) "Air layer above swimming pool, relevant for evaporation"
    annotation (Placement(transformation(extent={{-4,42},{-24,62}})));
  Movers.FlowControlled_m_flow          sou(
    redeclare package Medium = AirMedium,
    m_flow_nominal=m_flow_air_nominal,
    addPowerToMedium=false)
                 annotation (Placement(transformation(extent={{-42,-40},{-64,-14}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        AirMedium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-118,8},{-90,34}}),
        iconTransformation(extent={{-110,14},{-90,34}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        AirMedium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-112,-42},{-84,-14}}),
        iconTransformation(extent={{-108,-34},{-88,-14}})));
  Modelica.Blocks.Math.MultiSum Sum_m_flow_eva(nu=nPools)
    annotation (Placement(transformation(extent={{76,-34},{64,-22}})));
  Modelica.Blocks.Math.MultiSum SumQEva(nu=nPools)
    annotation (Placement(transformation(extent={{76,34},{60,50}})));
  Modelica.Blocks.Sources.RealExpression mAirExc(y=m_flow_air_nominal)
    "Set point for water mass fraction"
    annotation (Placement(transformation(extent={{-84,0},{-66,18}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{48,32},{28,52}})));
equation
  connect(m_flow_eva, Sum_m_flow_eva.u)
    annotation (Line(points={{104,-28},{76,-28}}, color={0,0,127}));
  connect(Sum_m_flow_eva.y, AirLay.mWat_flow) annotation (Line(points={{62.98,
          -28},{6,-28},{6,60},{-2,60}},
                                     color={0,0,127}));
  connect(sou.port_a, AirLay.ports[1])
    annotation (Line(points={{-42,-27},{-13,-27},{-13,42}},
                                                          color={0,127,255}));
  connect(sou.port_b, port_b) annotation (Line(points={{-64,-27},{-80,-27},{-80,
          -28},{-98,-28}}, color={0,127,255}));
  connect(port_a, AirLay.ports[2]) annotation (Line(points={{-104,21},{-104,26},
          {-15,26},{-15,42}}, color={0,127,255}));
  connect(mAirExc.y, sou.m_flow_in)
    annotation (Line(points={{-65.1,9},{-53,9},{-53,-11.4}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, AirLay.heatPort) annotation (Line(points={{
          28,42},{14,42},{14,52},{-4,52}}, color={191,0,0}));
  connect(SumQEva.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{58.64,42},{48,42}}, color={0,0,127}));
  connect(QEva, SumQEva.u) annotation (Line(points={{103,41},{89.5,41},{89.5,42},
          {76,42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end AirFlowMoistureToROM;
