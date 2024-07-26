within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model SubstationDirectHeatingDirectCoolingDHW "Substation model for bidirctional low-temperature networks for buildings with 
  heat pump,direct cooling and DHW demand. For simultaneous cooling and heat demands, 
  the return flows are used as supply flows for the other application."

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

    parameter Modelica.Units.SI.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";

    parameter Modelica.Units.SI.HeatFlowRate heatDemand_max "Maximum heat demand for scaling of heat pump";

    parameter Modelica.Units.SI.TemperatureDifference deltaT_heatingSet "Set temperature difference for heating on the site of building";

    parameter Modelica.Units.SI.TemperatureDifference  deltaT_coolingGridSet "Set temperature difference for cooling on the side of the thermal network";

    parameter Modelica.Units.SI.Pressure dp_nominal(displayUnit="Pa")=30000 "Nominal pressure drop";

    parameter Modelica.Units.SI.Temperature T_supplyDHWSet "Set supply temperature for space heating";

    parameter Modelica.Units.SI.Temperature T_returnSpaceHeatingSet "Set return temperature";

    parameter Modelica.Units.SI.MassFlowRate m_flow_nominal = m_flow_nominal
    "Nominal mass flow rate";

  AixLib.Fluid.Delays.DelayFirstOrder vol(
    T_start=305.15,
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60) annotation (Placement(transformation(extent={{-242,4},{-222,24}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol1(
    nPorts=2,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=60) annotation (Placement(transformation(extent={{188,8},{208,28}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpHeating(
    redeclare package Medium = Medium,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    use_inputFilter=false,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
  AixLib.Fluid.Sources.MassFlowSource_T sourceHeating(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={146,-56})));
  Modelica.Blocks.Sources.Constant T_return(k=deltaT_heatingSet)
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=0,
        origin={213,-97})));
  AixLib.Fluid.Sources.Boundary_pT sinkHeating(redeclare package Medium =
        Medium, nPorts=1)
    annotation (Placement(transformation(extent={{14,-62},{34,-42}})));
  Modelica.Blocks.Sources.Constant const(k=(cp_default*deltaT_heatingSet))
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=0,
        origin={214,-52})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{7,-7},{-7,7}},
        rotation=0,
        origin={187,-39})));
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
  AixLib.Fluid.HeatPumps.Carnot_TCon heaPum(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    use_eta_Carnot_nominal=true,
    show_T=true,
    etaCarnot_nominal=0.5,
    QCon_flow_nominal=heatDemand_max,
    dp1_nominal=0,
    dp2_nominal=0)
    annotation (Placement(transformation(extent={{104,4},{84,-16}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-196,104},{-180,120}})));
  Modelica.Blocks.Interfaces.RealInput heatDemand(unit = "W")
  "Input for heat demand profile of substation"
    annotation (Placement(transformation(extent={{-288,128},{-248,168}}),
        iconTransformation(extent={{-180,116},{-140,156}})));

  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={182,-80})));

  AixLib.Fluid.Delays.DelayFirstOrder del(
    redeclare package Medium = Medium,
    T_start=305.15,
    m_flow_nominal=m_flow_nominal,
    nPorts=2) annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Blocks.Interfaces.RealInput coolingDemand(unit = "W")
    "Input for cooling demand profile of substation"
    annotation (Placement(
        transformation(extent={{-290,92},{-250,132}}),
                                                    iconTransformation(extent={{-180,22},
            {-140,62}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_GridCool(redeclare package Medium
      =        Medium)
    annotation (Placement(transformation(extent={{152,-10},{172,10}})));
  Modelica.Blocks.Sources.Constant const4(k=T_supplyDHWSet)
    annotation (Placement(transformation(extent={{192,-150},{172,-130}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-22,32})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{66,-62},{46,-42}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{130,-66},{110,-44}})));
  Modelica.Blocks.Interfaces.RealOutput P_el_HP( unit = "W")
    "Electrical power consumed by heat pump"
    annotation (Placement(transformation(extent={{216,-30},{236,-10}})));
  Modelica.Blocks.Math.Add add2(k1=-1, k2=1)
    annotation (Placement(transformation(extent={{-140,132},{-120,152}})));
  Modelica.Blocks.Interfaces.RealInput dhwDemand(unit="W")
    "Input for domestic hot water demand profile of substation" annotation (
      Placement(transformation(extent={{-290,54},{-250,94}}),
        iconTransformation(extent={{-180,70},{-140,110}})));
  Modelica.Blocks.Math.Add add3(k1=1, k2=1)
    annotation (Placement(transformation(extent={{-226,40},{-206,60}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{-196,76},{-180,92}})));
  Modelica.Blocks.Sources.Constant const1(k=(cp_default*deltaT_coolingGridSet))
    annotation (Placement(transformation(extent={{-226,70},{-214,82}})));
  Modelica.Blocks.Math.Division division3
    annotation (Placement(transformation(extent={{-152,50},{-136,66}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemHPin(redeclare package Medium
      =        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{28,-10},{48,12}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=cp_default*(senTemIn.T
         - 15 - 273.15))
    annotation (Placement(transformation(extent={{-214,0},{-194,20}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-162,90},{-142,110}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{-122,54},{-102,74}})));
  Modelica.Blocks.Math.Max max2
    annotation (Placement(transformation(extent={{-174,6},{-154,26}})));
  Modelica.Blocks.Sources.Constant const2(k=2*cp_default)
    "min temperatur difference for dhw"
    annotation (Placement(transformation(extent={{-204,28},{-192,40}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemIn(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=305.15)
    annotation (Placement(transformation(extent={{-138,-12},{-118,10}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-152,-62},{-172,-42}})));
  Modelica.Blocks.Sources.Constant const5(k=T_returnSpaceHeatingSet)
    annotation (Placement(transformation(extent={{-142,-78},{-154,-66}})));
  Modelica.Blocks.Math.Gain gain(k=cp_default)
    annotation (Placement(transformation(extent={{-186,-62},{-206,-42}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemOut(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start=305.15)
    annotation (Placement(transformation(extent={{114,-12},{134,10}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=7200)
    annotation (Placement(transformation(extent={{-118,32},{-106,44}})));
    Modelica.Blocks.Logical.Switch mass_flow_heatExchangerHeating1
    "calculation of mass flow through heat exchanger (heating)"
    annotation (Placement(transformation(extent={{-76,46},{-56,66}})));
  Modelica.Blocks.Sources.Constant const3(k=m_flow_nominal)
    annotation (Placement(transformation(extent={{-104,12},{-92,24}})));
  Modelica.Blocks.Math.Max max3
    annotation (Placement(transformation(extent={{20,68},{40,88}})));
  Modelica.Blocks.Sources.Constant const6(k=0.1*m_flow_nominal)
    annotation (Placement(transformation(extent={{26,114},{38,126}})));
equation

  connect(port_a,vol. ports[1])
    annotation (Line(points={{-260,0},{-233,0},{-233,4}},
                                                        color={0,127,255}));
  connect(port_b,vol1. ports[1])
    annotation (Line(points={{220,0},{197,0},{197,8}},
                                                     color={0,127,255}));
  connect(division.u2, const.y) annotation (Line(points={{195.4,-43.2},{198,
          -43.2},{198,-52},{207.4,-52}},
                                  color={0,0,127}));
  connect(division.y, sourceHeating.m_flow_in) annotation (Line(points={{179.3,
          -39},{168,-39},{168,-48},{158,-48}},
                                             color={0,0,127}));
  connect(add.y, sourceHeating.T_in) annotation (Line(points={{171,-80},{166,
          -80},{166,-52},{158,-52}},
                              color={0,0,127}));
  connect(senMasFlo_GridCool.port_b, vol1.ports[2])
    annotation (Line(points={{172,0},{199,0},{199,8}}, color={0,127,255}));
  connect(port_a, port_a)
    annotation (Line(points={{-260,0},{-260,0}}, color={0,127,255}));
  connect(const4.y, add.u1) annotation (Line(points={{171,-140},{162,-140},{162,
          -122},{202,-122},{202,-74},{194,-74}},
                          color={0,0,127}));
  connect(const4.y, heaPum.TSet) annotation (Line(points={{171,-140},{134,-140},
          {134,-14},{106,-14},{106,-15}},
                             color={0,0,127}));
  connect(prescribedHeatFlow.port, del.heatPort) annotation (Line(points={{-22,22},
          {-22,10},{-10,10}},              color={191,0,0}));
  connect(senTem3.port_b, heaPum.port_a1)
    annotation (Line(points={{110,-55},{110,-54},{106,-54},{106,-12},{104,-12}},
                                                          color={0,127,255}));
  connect(senTem2.port_a, heaPum.port_b1) annotation (Line(points={{66,-52},{78,
          -52},{78,-12},{84,-12}},       color={0,127,255}));
  connect(pumpHeating.port_b, del.ports[1])
    annotation (Line(points={{-44,0},{-1,0}}, color={0,127,255}));
  connect(heatDemand, add2.u1)
    annotation (Line(points={{-268,148},{-142,148}}, color={0,0,127}));
  connect(coolingDemand, add2.u2) annotation (Line(points={{-270,112},{-212,112},
          {-212,136},{-142,136}}, color={0,0,127}));
  connect(add2.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-119,142},{-22,142},{-22,42}},
                                                           color={0,0,127}));
  connect(heatDemand, division1.u1) annotation (Line(points={{-268,148},{-226,148},
          {-226,116.8},{-197.6,116.8}}, color={0,0,127}));
  connect(const1.y, division2.u2) annotation (Line(points={{-213.4,76},{-206,76},
          {-206,79.2},{-197.6,79.2}}, color={0,0,127}));
  connect(coolingDemand, division2.u1) annotation (Line(points={{-270,112},{-228,
          112},{-228,88.8},{-197.6,88.8}}, color={0,0,127}));
  connect(dhwDemand, add3.u1) annotation (Line(points={{-270,74},{-240,74},{-240,
          56},{-228,56}}, color={0,0,127}));
  connect(heaPum.P, add3.u2) annotation (Line(points={{83,-6},{90,-6},{90,-20},
          {-252,-20},{-252,44},{-228,44}}, color={0,0,127}));
  connect(add3.y, division3.u1) annotation (Line(points={{-205,50},{-196,50},{-196,
          62.8},{-153.6,62.8}}, color={0,0,127}));
  connect(del.ports[2], senTemHPin.port_a)
    annotation (Line(points={{1,0},{28,0},{28,1}},         color={0,127,255}));
  connect(senTemHPin.port_b, heaPum.port_a2) annotation (Line(points={{48,1},{
          84,1},{84,0}},      color={0,127,255}));
  connect(division1.y, max.u1) annotation (Line(points={{-179.2,112},{-172,112},
          {-172,106},{-164,106}}, color={0,0,127}));
  connect(division2.y, max.u2) annotation (Line(points={{-179.2,84},{-172,84},{-172,
          94},{-164,94}}, color={0,0,127}));
  connect(max.y, max1.u1) annotation (Line(points={{-141,100},{-138,100},{-138,70},
          {-124,70}}, color={0,0,127}));
  connect(heaPum.P, P_el_HP) annotation (Line(points={{83,-6},{90,-6},{90,-20},
          {226,-20}},color={0,0,127}));
  connect(dhwDemand, division.u1) annotation (Line(points={{-270,74},{-258,74},
          {-258,72},{-248,72},{-248,-26},{204,-26},{204,-34},{196,-34},{196,
          -34.8},{195.4,-34.8}},
        color={0,0,127}));
  connect(division3.y, max1.u2)
    annotation (Line(points={{-135.2,58},{-124,58}}, color={0,0,127}));
  connect(realExpression.y, max2.u2)
    annotation (Line(points={{-193,10},{-176,10}}, color={0,0,127}));
  connect(const2.y, max2.u1) annotation (Line(points={{-191.4,34},{-182,34},{-182,
          22},{-176,22}}, color={0,0,127}));
  connect(max2.y, division3.u2) annotation (Line(points={{-153,16},{-146,16},{-146,
          40},{-164,40},{-164,53.2},{-153.6,53.2}}, color={0,0,127}));
  connect(T_return.y, add.u2) annotation (Line(points={{205.3,-97},{200,-97},{
          200,-86},{194,-86}}, color={0,0,127}));
  connect(senTem2.port_b, sinkHeating.ports[1])
    annotation (Line(points={{46,-52},{34,-52}}, color={0,127,255}));
  connect(vol.ports[2], senTemIn.port_a) annotation (Line(points={{-231,4},{-231,
          -1},{-138,-1}}, color={0,127,255}));
  connect(senTemIn.port_b, pumpHeating.port_a) annotation (Line(points={{-118,-1},
          {-102,-1},{-102,0},{-64,0}}, color={0,127,255}));
  connect(senTemIn.T, feedback.u1) annotation (Line(points={{-128,11.1},{-128,18},
          {-142,18},{-142,-52},{-154,-52}}, color={0,0,127}));
  connect(gain.u, feedback.y)
    annotation (Line(points={{-184,-52},{-171,-52}}, color={0,0,127}));
  connect(gain.y, division1.u2) annotation (Line(points={{-207,-52},{-248,-52},{
          -248,108},{-197.6,108},{-197.6,107.2}}, color={0,0,127}));
  connect(const5.y, feedback.u2) annotation (Line(points={{-154.6,-72},{-162,-72},
          {-162,-60}}, color={0,0,127}));
  connect(heaPum.port_b2, senTemOut.port_a) annotation (Line(points={{104,0},{110,
          0},{110,-1},{114,-1}}, color={0,127,255}));
  connect(senTemOut.port_b, senMasFlo_GridCool.port_a) annotation (Line(points={
          {134,-1},{142,-1},{142,0},{152,0}}, color={0,127,255}));
  connect(max1.y, mass_flow_heatExchangerHeating1.u1)
    annotation (Line(points={{-101,64},{-78,64}}, color={0,0,127}));
  connect(booleanStep.y, mass_flow_heatExchangerHeating1.u2) annotation (Line(
        points={{-105.4,38},{-92,38},{-92,56},{-78,56}}, color={255,0,255}));
  connect(const3.y, mass_flow_heatExchangerHeating1.u3) annotation (Line(points={{-91.4,
          18},{-84,18},{-84,48},{-78,48}},        color={0,0,127}));
  connect(max3.u2, mass_flow_heatExchangerHeating1.y) annotation (Line(points={
          {18,72},{-18,72},{-18,56},{-55,56}}, color={0,0,127}));
  connect(const6.y, max3.u1) annotation (Line(points={{38.6,120},{68,120},{68,
          100},{4,100},{4,84},{18,84}}, color={0,0,127}));
  connect(max3.y, pumpHeating.m_flow_in) annotation (Line(points={{41,78},{64,
          78},{64,36},{-54,36},{-54,12}}, color={0,0,127}));
  connect(senTem3.port_a, sourceHeating.ports[1]) annotation (Line(points={{130,
          -55},{130,-56},{136,-56}}, color={0,127,255}));
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
    <li><i>February 20, 2024</i> by Rahul Karuvingal:<br/>
    Revised to make it compatible with MSL 4.0.0 and Aixlib 1.3.2.
    </li>
<li><i>August 09, 2018</i> by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>"));
end SubstationDirectHeatingDirectCoolingDHW;
