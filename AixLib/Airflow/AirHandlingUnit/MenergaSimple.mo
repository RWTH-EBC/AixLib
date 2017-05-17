within AixLib.Airflow.AirHandlingUnit;
model MenergaSimple "A first simple model of the Menerga SorpSolair"

    //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
 // replaceable package MediumWater = AixLib.Media.Water;

    //parameter Modelica.SIunits.MassFlowRate mFlowNomOut=0.5
    //"Nominal mass flow rate OutgoingAir";
    //parameter Modelica.SIunits.MassFlowRate mFlowNomIn=0.5
    //"Nominal mass flow rate IntakeAir";


    parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  Modelica.Fluid.Interfaces.FluidPort_a externalAir(
     redeclare package Medium = MediumAir,
     m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
     h_outflow(start = MediumAir.h_default))
    "Fluid connector for external Air (positive design flow direction is from externalAir to SupplyAir)"
    annotation (Placement(transformation(extent={{344,16},{364,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b SupplyAir(
     redeclare package Medium = MediumAir,
     m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = MediumAir.h_default))
    "Fluid connector for suply Air (positive design flow direction is from externalAir to SupplyAir)"
    annotation (Placement(transformation(extent={{-634,14},{-614,34}})));

  Fluid.Movers.FlowControlled_m_flow outsideAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1)
    annotation (Placement(transformation(extent={{96,16},{76,36}})));

  Fluid.FixedResistances.PressureDrop res2(
  redeclare package Medium = MediumAir,
  m_flow_nominal=5.1, dp_nominal=200)
    annotation (Placement(transformation(extent={{-84,16},{-104,36}})));

  Modelica.Blocks.Sources.Constant const2(k=5.1)
    annotation (Placement(transformation(extent={{30,80},{50,100}})));
equation
  connect(externalAir, outsideAirFan.port_a) annotation (Line(points={{354,26},
          {96,26}},                          color={0,127,255}));
  connect(outsideAirFan.port_b, res2.port_a)
    annotation (Line(points={{76,26},{-4,26},{-84,26}},  color={0,127,255}));
  connect(res2.port_b, SupplyAir) annotation (Line(points={{-104,26},{-346,26},
          {-624,26},{-624,24}},          color={0,127,255}));
  connect(const2.y, outsideAirFan.m_flow_in) annotation (Line(points={{51,90},{
          51,90},{86.2,90},{86.2,38}},            color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-640,-100},
            {360,360}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-640,-100},{360,360}})));
end MenergaSimple;
