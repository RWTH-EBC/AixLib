within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationDirectCooling
  "Substation model for bidirctional low-temperature networks for buildings with direct cooling only. "

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";

    parameter Modelica.SIunits.HeatFlowRate heatDemand_max "Maximum heat demand for scaling of heat pump";

    parameter Modelica.SIunits.Temperature deltaT_heatingSet "Set temperature difference for heating on the site of building";

    parameter Modelica.SIunits.Temperature deltaT_heatingGridSet "Set temperature difference for heating on the site of thermal network";
    parameter Modelica.SIunits.Temperature deltaT_coolingGridSet "Set temperature difference for cooling on the side of the thermal network";

    parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";

    parameter Modelica.SIunits.Temperature T_supplyHeatingSet "Set supply temperature fore space heating";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal = m_flow_nominal
    "Nominal mass flow rate";

  AixLib.Fluid.Delays.DelayFirstOrder vol(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{-242,4},{-222,24}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{188,8},{208,28}})));
public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-270,-10},{-250,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{210,-10},{230,10}}),
        iconTransformation(extent={{210,-10},{230,10}})));

  Delays.DelayFirstOrder            del( nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-112,0},{-92,20}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpCooling(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand(unit = "W")
    "Input for cooling demand profile of substation"
    annotation (Placement(
        transformation(extent={{248,42},{208,82}}), iconTransformation(extent={{-176,40},
            {-136,80}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{68,100},{54,114}})));
  Modelica.Blocks.Sources.RealExpression
                                   realExpression1(y=(cp_default*(273.15 + 22
         - senTem4.T)))
    annotation (Placement(transformation(extent={{104,84},{92,96}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_GridHeat(redeclare package Medium
      =        Medium)
    annotation (Placement(transformation(extent={{-206,-10},{-186,10}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_GridCool(redeclare package Medium
      =        Medium)
    annotation (Placement(transformation(extent={{152,-10},{172,10}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-108,88})));
  Sensors.TemperatureTwoPort senTem4(redeclare package Medium = Medium,
      m_flow_nominal=2)
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=7200)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-40,94})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating1
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{-14,84},{6,104}})));
  Modelica.Blocks.Sources.Constant const3(k=m_flow_nominal)
    annotation (Placement(transformation(extent={{-50,48},{-38,60}})));
equation

  connect(port_a,vol. ports[1])
    annotation (Line(points={{-260,0},{-234,0},{-234,4}},
                                                        color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{220,0},{196,0},{196,8}},
                                                     color={0,127,255}));
  connect(division2.u2, realExpression1.y) annotation (Line(points={{69.4,102.8},
          {81.7,102.8},{81.7,90},{91.4,90}}, color={0,0,127}));
  connect(vol.ports[2], senMasFlo_GridHeat.port_a) annotation (Line(points={{
          -230,4},{-230,0},{-206,0},{-206,0}}, color={0,127,255}));
  connect(senMasFlo_GridCool.port_b, vol1.ports[2])
    annotation (Line(points={{172,0},{200,0},{200,8}}, color={0,127,255}));
  connect(senMasFlo.port_b, pumpCooling.port_a)
    annotation (Line(points={{70,0},{50,0}},   color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-260,0},{-260,0}}, color={0,127,255}));
  connect(del.ports[1], pumpCooling.port_b)
    annotation (Line(points={{-104,0},{30,0}},  color={0,127,255}));
  connect(coolingDemand, division2.u1) annotation (Line(points={{228,62},{122,
          62},{122,111.2},{69.4,111.2}},
                                     color={0,0,127}));
  connect(prescribedHeatFlow.port, del.heatPort) annotation (Line(points={{-108,78},
          {-112,78},{-112,10}},            color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, coolingDemand) annotation (Line(points={{-108,98},
          {-108,138},{224,138},{224,62},{228,62}},    color={0,0,127}));
  connect(senMasFlo.port_a, senTem4.port_a)
    annotation (Line(points={{90,0},{100,0}}, color={0,127,255}));
  connect(booleanStep.y,mass_flow_heatExchangerHeating1. u2) annotation (Line(
        points={{-33.4,94},{-16,94}},                    color={255,0,255}));
  connect(const3.y,mass_flow_heatExchangerHeating1. u3) annotation (Line(points={{-37.4,
          54},{-24,54},{-24,86},{-16,86}},        color={0,0,127}));
  connect(division2.y, mass_flow_heatExchangerHeating1.u1) annotation (Line(
        points={{53.3,107},{-26,107},{-26,102},{-16,102}}, color={0,0,127}));
  connect(mass_flow_heatExchangerHeating1.y, pumpCooling.m_flow_in)
    annotation (Line(points={{7,94},{40,94},{40,12}}, color={0,0,127}));
  connect(senMasFlo_GridHeat.port_b, del.ports[2])
    annotation (Line(points={{-186,0},{-100,0}}, color={0,127,255}));
  connect(senTem4.port_b, senMasFlo_GridCool.port_a)
    annotation (Line(points={{120,0},{152,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-260,
            -160},{220,160}}),
                         graphics={
        Rectangle(
          extent={{-160,160},{140,-160}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,30},{94,-146}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-106,30},{-6,140},{112,30},{-106,30}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-48,6},{-12,-36}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,-72},{18,-146}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{18,6},{54,-36}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-160},{220,
            160}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>"));
end SubstationDirectCooling;
