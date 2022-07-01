within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler
  "Simple Modular Boiler Model - Without Pump - Simple PLR regulation"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium =Media.Water, final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));

  parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Temperature TColdNom=308.15 "Return temperature TCold"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Thermal dimension power"
    annotation (Dialog(group="Nominal condition"));
  parameter Boolean m_flowVar=false "Use variable water massflow"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
  parameter Boolean Advanced=false "dTWater is constant for different PLR"
    annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
  parameter Modelica.SIunits.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
    annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));
  parameter Modelica.SIunits.Temperature THotMax=363.15 "Maximal temperature to force shutdown";
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";
  parameter Modelica.SIunits.Temperature TStart=273.15 + 20 "T start"
    annotation (Dialog(tab="Advanced"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=0 "Guess value of dp = port_a.p - port_b.p"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0 "Guess value of m_flow = port_a.m_flow"
    annotation (Dialog(tab="Advanced", group="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default "Start value of pressure"
    annotation (Dialog(tab="Advanced", group="Initialization"));

  Fluid.BoilerCHP.BoilerNotManufacturer heatGeneratorNoControl(
    final T_start=TStart,
    final dTWaterSet=dTWaterSet,
    final QNom=QNom,
    final PLRMin=PLRMin,
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final dTWaterNom=dTWaterNom,
    final TColdNom=TColdNom,
    final m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,38})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{70,76},{52,96}})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
    annotation (Placement(transformation(extent={{-78,62},{-60,80}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-11,71})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTHot(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,0})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCold(
    redeclare final package Medium = Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of cold side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,0})));

  Controls.ControlBoilerNotManufacturer controlBoilerNotManufacturer(
    final DeltaTWaterNom=dTWaterNom,
    final QNom=QNom,
    final m_flowVar=m_flowVar,
    final Advanced=Advanced,
    final dTWaterSet=dTWaterSet)
    annotation (Placement(transformation(extent={{-40,14},{-20,34}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{60,56},{44,72}})));
  Modelica.Blocks.Sources.RealExpression tHotMax(final y=THotMax)
    annotation (Placement(transformation(extent={{90,44},{72,64}})));
  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
   boilerControlBus
    annotation (Placement(transformation(extent={{-12,90},{8,110}})));

protected
  parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;

equation

  connect(port_a, port_a)
   annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));
  connect(switch3.y, heatGeneratorNoControl.PLR)
   annotation (Line(points={{30,27},
          {30,20},{-14,20},{-14,5.4},{-10,5.4}},
                                             color={0,0,127}));
  connect(realExpression.y, switch3.u1)
   annotation (Line(points={{51.1,86},{38,
          86},{38,50}},     color={0,0,127}));
  connect(pLRMin.y, switch4.u2)
   annotation (Line(points={{-59.1,71},{-21.8,71}},
                           color={255,0,255}));
  connect(switch4.y, switch3.u3)
   annotation (Line(points={{-1.1,71},{22,71},{22,
          50}},        color={0,0,127}));
  connect(realExpression.y, switch4.u1)
   annotation (Line(points={{51.1,86},{-42,
          86},{-42,78.2},{-21.8,78.2}},                              color={0,0,
          127}));
  connect(senTHot.port_b, port_b)
   annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
  connect(senTHot.port_a, heatGeneratorNoControl.port_b)
   annotation (Line(points={{50,0},{12,0}}, color={0,127,255}));
  connect(port_a, senTCold.port_a)
   annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(controlBoilerNotManufacturer.DeltaTWater_b, heatGeneratorNoControl.dTWater)
   annotation (Line(points={{-19,18.8},{-16,18.8},{-16,9},{-10,9}},
                   color={0,0,127}));
  connect(greater.y, switch3.u2)
   annotation (Line(points={{43.2,64},{30,64},{30,50}}, color={255,0,255}));
  connect(port_b, port_b)
   annotation (Line(points={{100,0},{106,0},{106,0},{100,
          0}}, color={0,127,255}));
  connect(senTHot.T, greater.u1)
   annotation (Line(points={{60,11},{92,11},{92,64},
          {61.6,64}},     color={0,0,127}));
  connect(tHotMax.y, greater.u2)
   annotation (Line(points={{71.1,54},{68,54},{68,57.6},{61.6,57.6}},
                              color={0,0,127}));
  connect(senTCold.T, controlBoilerNotManufacturer.TCold)
   annotation (Line(
        points={{-80,11},{-80,28},{-62,28},{-62,27},{-42,27}},    color={0,0,127}));
  connect(heatGeneratorNoControl.TVolume, controlBoilerNotManufacturer.THot)
   annotation (Line(points={{2,-11},{2,-20},{-46,-20},{-46,24},{-42,24}},
        color={0,0,127}));
  connect(boilerControlBus.DeltaTWater, controlBoilerNotManufacturer.DeltaTWater_a)
   annotation (Line(
      points={{-1.95,100.05},{-1.95,100},{-100,100},{-100,21},{-42,21}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLR, pLRMin.u)
   annotation (Line(
      points={{-1.95,100.05},{-1.95,100},{-86,100},{-86,71},{-79.8,71}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLR, switch4.u3)
   annotation (Line(
      points={{-1.95,100.05},{-1.95,100},{-50,100},{-50,63.8},{-21.8,63.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTCold.port_b, heatGeneratorNoControl.port_a)
   annotation (Line(points={{-70,0},{-8,0}}, color={0,127,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                              Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),
        Polygon(
          points={{-18.5,-23.5},{-26.5,-7.5},{-4.5,36.5},{3.5,10.5},{25.5,14.5},
              {15.5,-27.5},{-2.5,-23.5},{-8.5,-23.5},{-18.5,-23.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-16.5,-21.5},{-6.5,-1.5},{19.5,-21.5},{-6.5,-21.5},{-16.5,-21.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26.5,-21.5},{27.5,-29.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>A boiler model consisting of physical components. The user has the choice to run the model for three different setpoint options:</p>
<ol>
<li>Setpoint depends on part load ratio (water mass flow=dimension water mass flow; advanced=false &amp; m_flowVar=false)</li>
<li>Setpoint depends on part load ratio and a constant water temperature difference which is idependent from part load ratio (water mass flow is variable; advanced=false &amp; m_flowVar=true)</li>
<li>Setpoint depends on part load ratio an a variable water temperature difference (water mass flow is variable; advanced=true)</li>
</ol>
</html>"),
    experiment(StopTime=10));
end ModularBoiler;
