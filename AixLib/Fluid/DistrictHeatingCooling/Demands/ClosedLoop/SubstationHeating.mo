within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationHeating "Substation heating model"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180 "Specific heat capacity of Water (cp-value)";

    parameter Modelica.SIunits.HeatFlowRate heatDemand_max "Maximum heat demand for scaling of heatpump in Watt";

    parameter Modelica.SIunits.Temperature deltaT_heatingSet "Set temperature difference for heating on the site of building";

    parameter Modelica.SIunits.Temperature deltaT_heatingGridSet "Set temperature difference for heating on the site of thermal network";

    parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal = m_flow_nominal
    "Nominal mass flow rate";

  AixLib.Fluid.Delays.DelayFirstOrder vol(
    nPorts=2,
    redeclare package Medium = Medium,
    tau=600,
    m_flow_nominal=m_flow_nominal)
             annotation (Placement(transformation(extent={{-90,6},{-70,26}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    tau=600,
    m_flow_nominal=m_flow_nominal)
             annotation (Placement(transformation(extent={{70,6},{90,26}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpHeating(redeclare package
      Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
  AixLib.Fluid.Sources.MassFlowSource_T sourceHeating(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(extent={{50,-46},{30,-26}})));
  Modelica.Blocks.Sources.Constant deltaT_heatingBuildingSite(k=
        deltaT_heatingSet)
    annotation (Placement(transformation(extent={{114,-74},{100,-60}})));
  Sources.Boundary_pT sinkHeating(redeclare package Medium = Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-86,-46},{-66,-26}})));
  Modelica.Blocks.Sources.Constant const(k=(cp_default*deltaT_heatingSet))
    annotation (Placement(transformation(extent={{112,-46},{100,-34}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{86,-36},{72,-22}})));
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
    etaCarnot_nominal=0.5,
    dTEva_nominal=-5,
    QCon_flow_nominal=heatDemand_max)
    annotation (Placement(transformation(extent={{6,-20},{-14,-40}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-26,62},{-40,76}})));
  Modelica.Blocks.Sources.Constant const3(k=(cp_default*deltaT_heatingGridSet))
    annotation (Placement(transformation(extent={{8,48},{-4,60}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem_supHeating(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-36,-26},{-56,-46}})));
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit = "W")
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{156,-58},{116,-18}}),
        iconTransformation(extent={{156,-58},{116,-18}})));
  Modelica.Blocks.Interfaces.RealInput T_supplyHeatingSet(unit = "K")
  "Supply temperature of the heating circuit in the building"
   annotation (Placement(
        transformation(extent={{156,-102},{116,-62}}), iconTransformation(
          extent={{156,-102},{116,-62}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{84,-70},{64,-50}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{56,64},{36,84}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandHeaPum(unit="W")
    "Power demand of heat pump"
    annotation (Placement(transformation(extent={{158,96},{178,116}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandPump(unit = "W")
  "Power demand of distribution pump"
    annotation (Placement(transformation(extent={{158,76},{178,96}})));
  Modelica.Blocks.Math.Sum sumPower(nin=1)
    annotation (Placement(transformation(extent={{108,40},{128,60}})));
  Modelica.Blocks.Interfaces.RealOutput powerDemandSubstation(unit = "W")
    annotation (Placement(transformation(extent={{158,40},{178,60}})));
equation
  connect(port_a,vol. ports[1])
    annotation (Line(points={{-100,0},{-82,0},{-82,6}}, color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{160,0},{78,0},{78,6}}, color={0,127,255}));
  connect(vol.ports[2],pumpHeating. port_a) annotation (Line(points={{-78,6},{-78,
          6},{-78,0},{-66,0}}, color={0,127,255}));
  connect(pumpHeating.port_b, heaPum.port_a2) annotation (Line(points={{-46,0},{
          -30,0},{-30,-24},{-14,-24}}, color={0,127,255}));
  connect(heaPum.port_b2, vol1.ports[2]) annotation (Line(points={{6,-24},{24,-24},
          {24,0},{82,0},{82,6}}, color={0,127,255}));
  connect(sourceHeating.ports[1], heaPum.port_a1)
    annotation (Line(points={{30,-36},{6,-36}}, color={0,127,255}));
  connect(sourceHeating.m_flow_in, division.y) annotation (Line(points={{52,-28},
          {60,-28},{60,-29},{71.3,-29}}, color={0,0,127}));
  connect(division.u2, const.y) annotation (Line(points={{87.4,-33.2},{94,
          -33.2},{94,-40},{99.4,-40}},
                                  color={0,0,127}));
  connect(const3.y, division1.u2) annotation (Line(points={{-4.6,54},{-14,54},{-14,
          64.8},{-24.6,64.8}},color={0,0,127}));
  connect(division1.y,pumpHeating. m_flow_in)
    annotation (Line(points={{-40.7,69},{-56,69},{-56,12}},color={0,0,127}));
  connect(senTem_supHeating.port_a, heaPum.port_b1)
    annotation (Line(points={{-36,-36},{-14,-36}}, color={0,127,255}));
  connect(senTem_supHeating.port_b, sinkHeating.ports[1])
    annotation (Line(points={{-56,-36},{-66,-36}}, color={0,127,255}));
  connect(division.u1,heatDemand)  annotation (Line(points={{87.4,-24.8},{129.7,
          -24.8},{129.7,-38},{136,-38}}, color={0,0,127}));
  connect(T_supplyHeatingSet, heaPum.TSet) annotation (Line(points={{136,-82},{16,
          -82},{16,-39},{8,-39}}, color={0,0,127}));
  connect(deltaT_heatingBuildingSite.y, add.u2) annotation (Line(points={{
          99.3,-67},{97.65,-67},{97.65,-66},{86,-66}}, color={0,0,127}));
  connect(T_supplyHeatingSet, add.u1) annotation (Line(points={{136,-82},{154,-82},
          {154,-54},{86,-54}}, color={0,0,127}));
  connect(add.y, sourceHeating.T_in) annotation (Line(points={{63,-60},{58,-60},
          {58,-32},{52,-32}}, color={0,0,127}));
  connect(heatDemand, add1.u1) annotation (Line(points={{136,-38},{136,-38},{
          136,80},{58,80}},
                        color={0,0,127}));
  connect(heaPum.P, add1.u2) annotation (Line(points={{-15,-30},{-20,-30},{-20,40},
          {70,40},{70,68},{58,68}}, color={0,0,127}));
  connect(division1.u1, add1.y) annotation (Line(points={{-24.6,73.2},{5.7,73.2},
          {5.7,74},{35,74}}, color={0,0,127}));
  connect(heaPum.P, powerDemandHeaPum) annotation (Line(points={{-15,-30},{-20,
          -30},{-20,40},{90,40},{90,106},{168,106}}, color={0,0,127}));
  connect(pumpHeating.P, powerDemandPump) annotation (Line(points={{-45,
          9},{66,9},{66,86},{168,86}}, color={0,0,127}));
  connect(heaPum.P, sumPower.u[1]) annotation (Line(points={{-15,-30},{-20,-30},
          {-20,40},{90,40},{90,50},{106,50}},      color={0,0,127}));
  connect(sumPower.y, powerDemandSubstation)
    annotation (Line(points={{129,50},{168,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{160,120}}), graphics={
        Rectangle(
          extent={{-100,120},{140,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,34},{98,-80}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,34},{98,34}}, color={28,108,200}),
        Polygon(
          points={{-64,34},{22,112},{110,34},{-64,34}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-18,18},{10,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,18},{68,-12}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{8,-28},{34,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
            120}})),
    Documentation(revisions="<html>
<ul>
<li><i>November 25, 2019</i> ,by Nils Neuland:<br/>
Adapted to Aixlib conventions. </li>
</ul>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>"));
end SubstationHeating;
