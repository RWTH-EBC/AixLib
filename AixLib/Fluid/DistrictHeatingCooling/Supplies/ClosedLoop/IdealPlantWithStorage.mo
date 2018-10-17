within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlantWithStorage

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

      parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000
      "Nominal pressure drop";

      parameter Modelica.SIunits.MassFlowRate m_flow_nominal = m_flow_nominal
    "Nominal mass flow rate";

      parameter Modelica.SIunits.Volume V_Tank "Volume of thermal storage tank";

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
     "Fluid connector for connecting the ideal plant with storage to the cold line of the network"
    annotation (Placement(transformation(extent={{-130,-10},{-110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
     "Fluid connector for connecting the ideal plant with storage to the warm line of the network"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet preOut(redeclare package Medium =
        Medium, use_X_wSet=false,
    dp_nominal=dp_nominal,
    use_TSet=true,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-66,-10},{-86,10}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet preOut1(redeclare package Medium =
        Medium, use_X_wSet=false,
    dp_nominal=dp_nominal,
    m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-92,-10},{-112,10}})));
  Modelica.Blocks.Interfaces.RealInput T_coolingSet(unit = "K")
  "Maximum supply temperature of the cold line of the bidirectional low-temperature network"
    annotation (Placement(transformation(extent={{-148,30},{-108,70}})));
  Modelica.Blocks.Interfaces.RealInput T_heatingSet(unit = "K")
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
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem1(
                                                 redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{90,-10},{70,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemStoHea(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{26,-10},{6,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTemStoCoo(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
  Modelica.Blocks.Math.Min min
    annotation (Placement(transformation(extent={{-44,28},{-56,40}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{20,28},{32,40}})));
equation
  connect(port_b, senTem1.port_a)
    annotation (Line(points={{100,0},{90,0}}, color={0,127,255}));
  connect(preOut1.port_b, senTem1.port_b)
    annotation (Line(points={{62,0},{70,0}}, color={0,127,255}));
  connect(senTemStoHea.port_a, preOut1.port_a)
    annotation (Line(points={{26,0},{42,0}}, color={0,127,255}));
  connect(tan.port_a, senTemStoHea.port_b)
    annotation (Line(points={{0,0},{6,0}}, color={0,127,255}));
  connect(senTemStoCoo.T, min.u2) annotation (Line(points={{-40,11},{-40,30.4},
          {-42.8,30.4}}, color={0,0,127}));
  connect(max.y, preOut1.TSet) annotation (Line(points={{32.6,34},{36,34},{36,8},
          {40,8}}, color={0,0,127}));
  connect(senTemStoHea.T, max.u2)
    annotation (Line(points={{16,11},{16,30.4},{18.8,30.4}}, color={0,0,127}));
  connect(tan.port_b, senTemStoCoo.port_a)
    annotation (Line(points={{-20,0},{-30,0}}, color={0,127,255}));
  connect(senTemStoCoo.port_b, preOut.port_a)
    annotation (Line(points={{-50,0},{-66,0}}, color={0,127,255}));
  connect(port_a, senTem.port_b)
    annotation (Line(points={{-120,0},{-112,0}}, color={0,127,255}));
  connect(senTem.port_a, preOut.port_b)
    annotation (Line(points={{-92,0},{-86,0}}, color={0,127,255}));
  connect(preOut.TSet, min.y) annotation (Line(points={{-64,8},{-58,8},{-58,34},
          {-56.6,34}}, color={0,0,127}));
  connect(T_coolingSet, min.u1) annotation (Line(points={{-128,50},{-34,50},{
          -34,37.6},{-42.8,37.6}}, color={0,0,127}));
  connect(T_heatingSet, max.u1) annotation (Line(points={{-128,80},{12,80},{12,
          37.6},{18.8,37.6}}, color={0,0,127}));
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
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>"));
end IdealPlantWithStorage;
