within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationHeating
  "Substation model for bidirectional low-temperature networks for buildings with only heating demand equipped with a heat pump"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.Units.SI.SpecificHeatCapacity cp_default = 4180 "Specific heat capacity of Water (cp-value)";

    parameter Modelica.Units.SI.HeatFlowRate heatDemand_max "Maximum heat demand for scaling of heatpump in Watt";

    parameter Modelica.Units.SI.Temperature deltaT_heatingSet "Set temperature difference for heating on the site of building";

    parameter Modelica.Units.SI.Temperature deltaT_heatingGridSet "Set temperature difference for heating on the site of thermal network";

    parameter Modelica.Units.SI.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal = heatDemand_max / (cp_default * deltaT_heatingGridSet)
    "Nominal mass flow rate based on max. heating demand and set temperature difference";

  AixLib.Fluid.Delays.DelayFirstOrder vol(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{-90,6},{-70,26}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60)  annotation (Placement(transformation(extent={{132,6},{152,26}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpHeating(redeclare package
      Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
  AixLib.Fluid.Sources.MassFlowSource_T heatingReturnBuilding(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1) "Represents return line of buildings heating system"
    annotation (Placement(transformation(extent={{88,-48},{68,-28}})));
  Modelica.Blocks.Sources.Constant deltaT_heatingBuildingSite(k=
        deltaT_heatingSet)
    annotation (Placement(transformation(extent={{136,-74},{124,-62}})));
  Sources.Boundary_pT heatingSupplyBuilding(redeclare package Medium = Medium,
      nPorts=1) "Represents supply flow of buildings heating system"
    annotation (Placement(transformation(extent={{-44,-48},{-24,-28}})));
  Modelica.Blocks.Sources.Constant const(k=(cp_default*deltaT_heatingSet))
    annotation (Placement(transformation(extent={{142,-44},{130,-32}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{114,-38},{98,-22}})));
public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        AixLib.Media.Water)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        AixLib.Media.Water)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{150,-10},{170,10}}),
        iconTransformation(extent={{150,-10},{170,10}})));
  AixLib.Fluid.HeatPumps.Carnot_TCon heaPum(redeclare package Medium1 = Medium,
      redeclare package Medium2 = Medium,
    dp1_nominal=dp_nominal,
    dp2_nominal=dp_nominal,
    use_eta_Carnot_nominal=true,
    show_T=true,
    etaCarnot_nominal=0.4,
    QCon_flow_nominal=heatDemand_max)
    annotation (Placement(transformation(extent={{48,4},{28,-16}})));
  Modelica.Blocks.Math.Division division1
    "Calculation of mass flow rate needed from dhc grid for heating"
    annotation (Placement(transformation(extent={{-36,58},{-50,72}})));
  Modelica.Blocks.Sources.Constant const3(k=(cp_default*deltaT_heatingGridSet))
    annotation (Placement(transformation(extent={{-14,52},{-26,64}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemHeatingSup(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    "Supply temperatur of buildings heating system"
    annotation (Placement(transformation(extent={{6,-48},{-14,-28}})));
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit = "W")
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-128,74},{-88,114}}),
        iconTransformation(extent={{-116,74},{-76,114}})));
  Modelica.Blocks.Interfaces.RealInput T_supplyHeatingSet(unit = "K")
  "Supply temperature of the heating circuit in the building"
   annotation (Placement(
        transformation(extent={{-128,26},{-88,66}}),   iconTransformation(
          extent={{-116,30},{-76,70}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{114,-66},{98,-50}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=90,
        origin={2,80})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandHP(unit = "W")
  "Power demand of heat pump"
    annotation (Placement(transformation(extent={{158,96},{178,116}}),
        iconTransformation(extent={{158,96},{178,116}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandPump(unit = "W")
  "Power demand of distribution pump"
    annotation (Placement(transformation(extent={{158,72},{178,92}}),
        iconTransformation(extent={{158,72},{178,92}})));
  Modelica.Blocks.Math.Sum sumPower(nin=1)
    "Adds power demand for heat pump and distribution pump"
    annotation (Placement(transformation(extent={{104,58},{124,78}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandSubstation(unit = "W")
  "Power demand of substation (sum of heat pump and distribution pump)"
    annotation (Placement(transformation(extent={{158,48},{178,68}}),
        iconTransformation(extent={{158,48},{178,68}})));
equation
  connect(port_a,vol. ports[1])
    annotation (Line(points={{-100,0},{-81,0},{-81,6}}, color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{160,0},{141,0},{141,6}},
                                                     color={0,127,255}));
  connect(vol.ports[2],pumpHeating. port_a) annotation (Line(points={{-79,6},{-79,
          0},{-64,0}},         color={0,127,255}));
  connect(pumpHeating.port_b, heaPum.port_a2) annotation (Line(points={{-44,0},{
          28,0}},                      color={0,127,255}));
  connect(heaPum.port_b2, vol1.ports[2]) annotation (Line(points={{48,0},{143,0},
          {143,6}},              color={0,127,255}));
  connect(heatingReturnBuilding.ports[1], heaPum.port_a1) annotation (Line(
        points={{68,-38},{60,-38},{60,-12},{48,-12}}, color={0,127,255}));
  connect(heatingReturnBuilding.m_flow_in, division.y)
    annotation (Line(points={{90,-30},{97.2,-30}}, color={0,0,127}));
  connect(division.u2, const.y) annotation (Line(points={{115.6,-34.8},{120,-34.8},
          {120,-38},{129.4,-38}}, color={0,0,127}));
  connect(const3.y, division1.u2) annotation (Line(points={{-26.6,58},{-30,58},{
          -30,60.8},{-34.6,60.8}},
                              color={0,0,127}));
  connect(division1.y,pumpHeating. m_flow_in)
    annotation (Line(points={{-50.7,65},{-54,65},{-54,12}},color={0,0,127}));
  connect(senTemHeatingSup.port_a, heaPum.port_b1) annotation (Line(points={{6,-38},
          {20,-38},{20,-12},{28,-12}}, color={0,127,255}));
  connect(senTemHeatingSup.port_b, heatingSupplyBuilding.ports[1])
    annotation (Line(points={{-14,-38},{-24,-38}}, color={0,127,255}));
  connect(division.u1,heatDemand)  annotation (Line(points={{115.6,-25.2},{127.7,
          -25.2},{127.7,94},{-108,94}},  color={0,0,127}));
  connect(T_supplyHeatingSet, heaPum.TSet) annotation (Line(points={{-108,46},{54,
          46},{54,-14},{50,-14},{50,-15}},
                                  color={0,0,127}));
  connect(deltaT_heatingBuildingSite.y, add.u2) annotation (Line(points={{123.4,
          -68},{119.65,-68},{119.65,-62.8},{115.6,-62.8}},
                                                       color={0,0,127}));
  connect(T_supplyHeatingSet, add.u1) annotation (Line(points={{-108,46},{122,46},
          {122,-53.2},{115.6,-53.2}},
                               color={0,0,127}));
  connect(add.y, heatingReturnBuilding.T_in)
    annotation (Line(points={{97.2,-58},{90,-58},{90,-34}}, color={0,0,127}));
  connect(heaPum.P, add1.u2) annotation (Line(points={{27,-6},{18,-6},{18,92},{8,
          92},{8,89.6},{6.8,89.6}}, color={0,0,127}));
  connect(division1.u1, add1.y) annotation (Line(points={{-34.6,69.2},{2,69.2},{
          2,71.2}},          color={0,0,127}));
  connect(heaPum.P, powerDemandHP) annotation (Line(points={{27,-6},{18,-6},{18,
          40},{90,40},{90,106},{168,106}},                 color={0,0,127}));
  connect(pumpHeating.P, powerDemandPump) annotation (Line(points={{-43,9},{66,
          9},{66,82},{168,82}},        color={0,0,127}));
  connect(heaPum.P, sumPower.u[1]) annotation (Line(points={{27,-6},{18,-6},{18,
          40},{90,40},{90,68},{102,68}},           color={0,0,127}));
  connect(sumPower.y, powerDemandSubstation)
    annotation (Line(points={{125,68},{146,68},{146,58},{168,58}},
                                                 color={0,0,127}));
  connect(heatDemand, add1.u1) annotation (Line(points={{-108,94},{-2.8,94},{-2.8,
          89.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{160,120}}), graphics={
        Rectangle(
          extent={{-100,120},{160,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-38,34},{110,-80}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Line(points={{-48,34},{100,34}},color={28,108,200}),
        Polygon(
          points={{-52,34},{34,112},{122,34},{-52,34}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-6,18},{22,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{52,18},{80,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,-28},{46,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
            120}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>April 15, 2020</i> ,by Tobias Blacha:<br/>
    Add documentaion
  </li>
  <li>
    <i>August 09, 2018</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Substation model for bidirectional low-temperature networks with heat
  pump and fixed temperature difference (parameter) on network side.
  This model uses the heat pump <a href=
  \"modelica://AixLib.Fluid.HeatPumps.Carnot_TCon\">AixLib.Fluid.HeatPumps.Carnot_TCon</a>.
  The supply temperature of buildings heating system must be set be
  using the input T_supplyHeatingSet.
</p>
</html>"));
end SubstationHeating;
