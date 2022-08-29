within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.HierarchicalControl_ModularBoiler.InternalControl_ModularBoiler.flowTemperatureController.returnAdmixture.Example;
model Admixture
  extends Modelica.Icons.Example;

  package MediumWater = AixLib.Media.Water;
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominalCon = 0.5  "Nominal mass flow rate for the individual consumers" annotation(Dialog(group="Nominal conditions"));
  parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominalCon=m_flow_nominalCon/MediumWater.d_const "Nominal Volume flow rate for the indididual consumers" annotation(Dialog(group="Nominal conditions"));
  parameter Modelica.Units.SI.PressureDifference dp_nominalCon = 2000000
    "Pressure drop at nominal conditions for the individual consumers"
    annotation(Dialog(group="Nominal conditions"));

  AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.HierarchicalControl_ModularBoiler.InternalControl_ModularBoiler.flowTemperatureController.returnAdmixture.Admixture
    admixture(m_flow_nominalCon=m_flow_nominalCon, dp_nominalCon=dp_nominalCon,
    dp_Valve(displayUnit="Pa") = 1)
              annotation (Placement(transformation(extent={{-38,-36},{38,40}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=0.5,
    freqHz=1/3600,
    offset=0.5)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,74})));
  BaseClasses.AdmixtureBus admixtureBus
    annotation (Placement(transformation(extent={{-10,64},{10,84}}), iconTransformation(extent={{0,0},{0,0}})));

  Fluid.Sources.Boundary_pT
                      bou1(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=2)
    annotation (Placement(transformation(extent={{92,-12},{68,12}})));
  Fluid.Sources.Boundary_pT
                      bou2(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=2)
    annotation (Placement(transformation(extent={{-92,-8},{-68,16}})));
equation
  connect(admixtureBus, admixture.admixtureBus) annotation (Line(
      points={{0,74},{0,38.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(sine.y, admixtureBus.valveSet) annotation (Line(points={{-59,74},{-32,
          74},{-32,74.05},{0.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bou1.ports[1], admixture.port_b1) annotation (Line(points={{68,-1.2},{
          56,-1.2},{56,24.8},{38,24.8}},color={0,127,255}));
  connect(bou1.ports[2], admixture.port_a2) annotation (Line(points={{68,1.2},{57,
          1.2},{57,-20.8},{38,-20.8}},      color={0,127,255}));
  connect(bou2.ports[1], admixture.port_a1) annotation (Line(points={{-68,2.8},{
          -52,2.8},{-52,24.8},{-38,24.8}},  color={0,127,255}));
  connect(bou2.ports[2], admixture.port_b2) annotation (Line(points={{-68,5.2},{
          -54,5.2},{-54,-20.8},{-38,-20.8}},  color={0,127,255}));
end Admixture;
