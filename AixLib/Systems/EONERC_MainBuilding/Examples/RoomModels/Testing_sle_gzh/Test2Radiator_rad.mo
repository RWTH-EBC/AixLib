within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels.Testing_sle_gzh;
model Test2Radiator_rad
      extends Modelica.Icons.Example;
 package Medium = AixLib.Media.Water "Medium model";
  parameter Modelica.Units.SI.Temperature TRoo=20 + 273.15 "Room temperature"
    annotation (Evaluate=false);
  parameter Modelica.Units.SI.Temperature T_a_nominal=313.15
    "Radiator inlet temperature at nominal condition";
  parameter Modelica.Units.SI.Temperature T_b_nominal=303.15
    "Radiator outlet temperature at nominal condition";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=500/(
      T_a_nominal - T_b_nominal)/Medium.cp_const "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal=3000
    "Pressure drop at m_flow_nominal";
  Fluid.FixedResistances.PressureDrop
                                res1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=3000)
    annotation (Placement(transformation(extent={{26,-12},{46,8}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature convTemp(T=293.15)
    "Convetive heat"
    annotation (Placement(transformation(extent={{-24,40},{-4,60}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature radTemp(T=293.15)
    "Radiative heat"
    annotation (Placement(transformation(extent={{36,40},{16,60}})));
  Fluid.Sources.MassFlowSource_T
                           source(
    redeclare package Medium = Media.Water,
    use_T_in=true,
    m_flow=0.01,
    T=328.15,
    nPorts=1) annotation (Placement(transformation(extent={{-40,-14},{-20,6}})));
  Fluid.Sources.Boundary_pT
                        sink(redeclare package Medium = Media.Water, nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{80,-12},{60,8}})));
  Modelica.Blocks.Sources.Step step(
    startTime=7200,
    offset=313.15,
    height=5)
    annotation (Placement(transformation(extent={{-74,-14},{-54,6}})));
  Fluid.HeatExchangers.Radiators.Radiator        radiator(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=0.0119503,
    T_start(displayUnit="K") = 293.15,
    selectable=true,
    radiatorType=AixLib.DataBase.Radiators.RadiatorBaseDataDefinition(
        NominalPower=500,
        RT_nom=Modelica.Units.Conversions.from_degC({40,30,20}),
        PressureDrop=3000,
        Exponent=1.24,
        VolumeWater=2.9,
        MassSteel=13.15,
        DensitySteel=7900,
        CapacitySteel=551,
        LambdaSteel=60,
        Type=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator11,
        length=1,
        height=0.42),
    N=16,
    calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp)
    "Radiator"
    annotation (Placement(transformation(extent={{-4,-14},{16,6}})));
  Modelica.Blocks.Sources.RealExpression realExpression43(y=source.ports[1].h_outflow)
    annotation (Placement(transformation(extent={{-238,-24},{-218,-4}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-192,-38},{-172,-18}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-228,-58},{-208,-38}})));
  Modelica.Blocks.Sources.RealExpression realExpression44(y=radiator.port_b.h_outflow)
    annotation (Placement(transformation(extent={{-270,-58},{-250,-38}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=2)
    annotation (Placement(transformation(extent={{-152,-40},{-140,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpression45(y=source.m_flow)
    annotation (Placement(transformation(extent={{-178,-70},{-158,-50}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_sum "Value of Real output"
    annotation (Placement(transformation(extent={{-104,-56},{-84,-36}})));
equation
  connect(res1.port_b,sink. ports[1])
    annotation (Line(points={{46,-2},{60,-2}}, color={0,127,255}));
  connect(step.y,source. T_in) annotation (Line(points={{-53,-4},{-46,-4},{-46,
          0},{-42,0}},
                     color={0,0,127}));
  connect(convTemp.port, radiator.ConvectiveHeat)
    annotation (Line(points={{-4,50},{4,50},{4,-2}}, color={191,0,0}));
  connect(radiator.RadiativeHeat, radTemp.port) annotation (Line(points={{10,-2},
          {20,-2},{20,36},{12,36},{12,50},{16,50}}, color={0,0,0}));
  connect(radiator.port_a, source.ports[1])
    annotation (Line(points={{-4,-4},{-20,-4}}, color={0,127,255}));
  connect(radiator.port_b, res1.port_a)
    annotation (Line(points={{16,-4},{16,-2},{26,-2}}, color={0,127,255}));
  connect(realExpression43.y,add. u1) annotation (Line(points={{-217,-14},{-204,
          -14},{-204,-22},{-194,-22}},         color={0,0,127}));
  connect(realExpression44.y,gain. u)
    annotation (Line(points={{-249,-48},{-230,-48}},   color={0,0,127}));
  connect(gain.y,add. u2) annotation (Line(points={{-207,-48},{-200,-48},{-200,
          -42},{-202,-42},{-202,-34},{-194,-34}},          color={0,0,127}));
  connect(add.y,multiProduct. u[1]) annotation (Line(points={{-171,-28},{-158,
          -28},{-158,-35.05},{-152,-35.05}},    color={0,0,127}));
  connect(realExpression45.y,multiProduct. u[2]) annotation (Line(points={{-157,
          -60},{-152,-60},{-152,-44},{-156,-44},{-156,-32.95},{-152,-32.95}},
                     color={0,0,127}));
  connect(multiProduct.y,Q_flow_sum)  annotation (Line(points={{-138.98,-34},{
          -110,-34},{-110,-46},{-94,-46}},     color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test2Radiator_rad;
