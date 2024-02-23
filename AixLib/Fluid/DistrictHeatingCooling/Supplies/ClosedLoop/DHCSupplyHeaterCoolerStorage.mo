within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model DHCSupplyHeaterCoolerStorage
  "Supply node model with ideal heater and cooler and storage tank without heat losses for heat and cold supply of bidirectional networks"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium "Medium model for water"
      annotation (choicesAllMatching = true);

  parameter Modelica.Units.SI.Pressure dp_nominal(displayUnit="Pa") = 30000
    "Nominal pressure drop";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=m_flow_nominal
    "Nominal mass flow rate";

  parameter Modelica.Units.SI.Volume V_Tank "Volume of thermal storage tank";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
     "Fluid connector for connecting the ideal plant with storage to the cold line of the network"
    annotation (Placement(transformation(extent={{-130,-10},{-110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
     "Fluid connector for connecting the ideal plant with storage to the warm line of the network"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet coo(
    redeclare package Medium = Medium,
    use_X_wSet=false,
    dp_nominal=dp_nominal,
    use_TSet=true,
    m_flow_nominal=m_flow_nominal)
    "Ideal cooler (only in operation if mass flow direction is from port_b to port_a)"
    annotation (Placement(transformation(extent={{-66,-10},{-86,10}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet hea(
    redeclare package Medium = Medium,
    use_X_wSet=false,
    dp_nominal=dp_nominal,
    m_flow_nominal=m_flow_nominal)
    "Ideal heater (only in operation if mass flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_cooOut(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    "Outlet temperature of ideal cooler if mass flow direcetion is from port_b to port_a"
    annotation (Placement(transformation(extent={{-92,-10},{-112,10}})));
  Modelica.Blocks.Interfaces.RealInput T_cooSet(unit="K")
    "Maximum supply temperature of the cold line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-148,30},{-108,70}})));
  Modelica.Blocks.Interfaces.RealInput T_heaSet(unit="K")
    "Minimum supply temperature of the hot line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-148,60},{-108,100}})));
  AixLib.Fluid.Storage.Stratified    tan(
    allowFlowReversal=true,
    hTan=4,
    dIns=0.1,
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    nSeg=3,
    VTan=V_Tank)
              annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_heaOut(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    "Outlet temperature of ideal heater if mass flow direcetion is from port_a to port_b"
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_stoHea(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{26,-10},{6,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_stoCoo(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
  Modelica.Blocks.Math.Min min "Set temperature of ideal heater"
    annotation (Placement(transformation(extent={{-44,28},{-56,40}})));
  Modelica.Blocks.Math.Max max "Set temperature of ideal cooler"
    annotation (Placement(transformation(extent={{20,28},{32,40}})));
  Sources.Boundary_pT bou(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
equation
  connect(port_b, senT_heaOut.port_a)
    annotation (Line(points={{100,0},{90,0}}, color={0,127,255}));
  connect(hea.port_b, senT_heaOut.port_b)
    annotation (Line(points={{62,0},{70,0}}, color={0,127,255}));
  connect(senT_stoHea.port_a, hea.port_a)
    annotation (Line(points={{26,0},{42,0}}, color={0,127,255}));
  connect(tan.port_a, senT_stoHea.port_b)
    annotation (Line(points={{0,0},{6,0}}, color={0,127,255}));
  connect(senT_stoCoo.T, min.u2) annotation (Line(points={{-40,11},{-40,30.4},{
          -42.8,30.4}}, color={0,0,127}));
  connect(max.y, hea.TSet) annotation (Line(points={{32.6,34},{36,34},{36,8},{
          40,8}}, color={0,0,127}));
  connect(senT_stoHea.T, max.u2)
    annotation (Line(points={{16,11},{16,30.4},{18.8,30.4}}, color={0,0,127}));
  connect(tan.port_b, senT_stoCoo.port_a)
    annotation (Line(points={{-20,0},{-30,0}}, color={0,127,255}));
  connect(senT_stoCoo.port_b, coo.port_a)
    annotation (Line(points={{-50,0},{-66,0}}, color={0,127,255}));
  connect(port_a, senT_cooOut.port_b)
    annotation (Line(points={{-120,0},{-112,0}}, color={0,127,255}));
  connect(senT_cooOut.port_a, coo.port_b)
    annotation (Line(points={{-92,0},{-86,0}}, color={0,127,255}));
  connect(coo.TSet, min.y) annotation (Line(points={{-64,8},{-58,8},{-58,34},{-56.6,
          34}}, color={0,0,127}));
  connect(T_cooSet, min.u1) annotation (Line(points={{-128,50},{-34,50},{-34,
          37.6},{-42.8,37.6}}, color={0,0,127}));
  connect(T_heaSet, max.u1) annotation (Line(points={{-128,80},{12,80},{12,37.6},
          {18.8,37.6}}, color={0,0,127}));
  connect(bou.ports[1], coo.port_a) annotation (Line(points={{-70,-40},{-58,-40},
          {-58,0},{-66,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}),                                  graphics={
        Rectangle(
          extent={{-80,80},{80,0}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-80},{80,0}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.None)}),                       Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{100,
            100}})),
    Documentation(revisions="<html><ul>
  <li>
    <i>October 08, 2020</i> ,by Tobias Blacha:<br/>
    Moved to development
  </li>
  <li>
    <i>August 09, 2018</i> ,by Tobias Blacha:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  This model represents the supply node of a bidirectional network with
  ideal heater and ideal cooler and storage tank. The tank is
  integrated into the network directly. The operation mode of the
  supply systems depends on the flow direction. In the case that port_b
  is the outlet, heating operation takes place. In the case that port_a
  is the outlet, cooling operation takes place.
</p>
</html>"));
end DHCSupplyHeaterCoolerStorage;
