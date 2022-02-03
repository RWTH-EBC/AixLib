within ControlUnity.Modules;
model ModularBoiler_FlowTemperatureControlAdmix
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium =AixLib.Media.Water,
                           final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));

  parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Temperature TColdNom=273.15+35 "Return temperature TCold"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Thermal dimension power"
   annotation (Dialog(group="Nominal condition"));
  parameter Boolean m_flowVar=false "Use variable water massflow"
  annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

  parameter Boolean Pump=true "Model includes a pump"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));

  parameter Boolean Advanced=false "dTWater is constant for different PLR"
  annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

  parameter Modelica.SIunits.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
   annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));

  parameter Modelica.SIunits.Temperature THotMax=273.15+90 "Maximal temperature to force shutdown";
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  parameter Modelica.SIunits.Temperature TStart=273.15+20 "T start"
   annotation (Dialog(tab="Advanced"));

   parameter Modelica.Media.Interfaces.Types.AbsolutePressure dp_start=0
     "Guess value of dp = port_a.p - port_b.p"
     annotation (Dialog(tab="Advanced", group="Initialization"));
   parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=0
     "Guess value of m_flow = port_a.m_flow"
     annotation (Dialog(tab="Advanced", group="Initialization"));
   parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_start=Medium.p_default
     "Start value of pressure"
     annotation (Dialog(tab="Advanced", group="Initialization"));

  AixLib.Fluid.BoilerCHP.BoilerNotManufacturer heatGeneratorNoControl(
    T_start=TStart,
    dTWaterSet=dTWaterSet,
    QNom=QNom,
    PLRMin=PLRMin,
    redeclare package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    dTWaterNom=dTWaterNom,
    TColdNom=TColdNom,
    m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTHot(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,0})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTCold(
    redeclare final package Medium = AixLib.Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    final initType=Modelica.Blocks.Types.Init.InitialState,
    T_start=TStart,
    final transferHeat=false,
    final allowFlowReversal=false,
    final m_flow_small=0.001)
    "Temperature sensor of hot side of heat generator (supply)"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,0})));
  Modelica.Blocks.Continuous.Integrator integrator1
    annotation (Placement(transformation(extent={{76,-38},{88,-26}})));

  AixLib.Systems.ModularEnergySystems.Controls.ControlBoilerNotManufacturer controlBoilerNotManufacturer(
    DeltaTWaterNom=dTWaterNom,
    QNom=QNom,
    m_flowVar=m_flowVar,
    Advanced=Advanced,
    dTWaterSet=dTWaterSet)
    annotation (Placement(transformation(extent={{-102,40},{-82,60}})));
  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={dp_nominal/0.8,
            dp_nominal,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  flowTemperatureController.renturnAdmixture.BoilerControlBus_admixture
    boilerControlBus_Control(n=n)
    annotation (Placement(transformation(extent={{-50,88},{-30,108}})));

     //
    ///Control unity

  Regulation_modularBoiler regulation_modularBoiler(use_advancedControl=
        use_advancedControl, severalHeatcurcuits=severalHeatcurcuits)
    annotation (Placement(transformation(extent={{-64,48},{-44,68}})));
  parameter Integer n=3 "Number of layers in the buffer storage";
  parameter Boolean use_advancedControl=false
    "Selection between two position control and flow temperature control, if true=flow temperature control is active" annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true));
  parameter Boolean severalHeatcurcuits=false
    "If true, there are two or more heat curcuits" annotation(Dialog(enable=use_advancedControl, group="Flow temperature control"), choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true));
  parameter Modelica.SIunits.Temperature Tb=273.15 + 60
    "Fix boiler temperature for return admixture with several heat curcuits" annotation(Dialog(enable=severalHeatcurcuits, group="Flow temperature control"));
   ///Control unity
   //

  ControlUnity.hierarchicalControl_modularOLD
    hierarchicalControl_modularBoilerNEW1(
    use_advancedControl=true,
    n=n,
    bandwidth=2.5,
    severalHeatcurcuits=true,
    k=k,
    TBoiler=TBoiler,
    Tset=Tset) annotation (Placement(transformation(extent={{-4,48},{16,68}})));
  Modelica.Blocks.Interfaces.RealOutput valPos[k] annotation (Placement(
        transformation(extent={{94,64},{110,80}}), iconTransformation(extent={{
            94,64},{110,80}})));
  Modelica.Blocks.Interfaces.RealInput TMeaCon[k]
    "Measurement temperature of the consumer" annotation (Placement(
        transformation(extent={{116,16},{86,46}}), iconTransformation(extent={{
            116,16},{86,46}})));
  parameter Modelica.SIunits.Temperature TBoiler=273.15 + 75
    "Fix boiler temperature for the admixture";
  parameter Integer k=1 "Number of heat curcuits";
  parameter Modelica.SIunits.Temperature Tset[k];
  Modelica.Blocks.Interfaces.RealInput TCon[k]
    "Set temperature for the consumers" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={40,100})));
protected
   parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
   replaceable package MediumBoiler =AixLib.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium heat source"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
              property_T=293.15,
              X_a=0.40)
              "Propylene glycol water, 40% mass fraction")));

equation

  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));

  if Pump==false then
  connect(port_a, heatGeneratorNoControl.port_a) annotation (Line(points={{-100,0},
            {-100,-20},{-8,-20},{-8,0}},     color={0,127,255}));
  else
  end if;

  connect(senTHot.port_b, port_b)
    annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
  connect(senTHot.port_a, heatGeneratorNoControl.port_b)
    annotation (Line(points={{50,0},{12,0}}, color={0,127,255}));
  connect(port_a, senTCold.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(heatGeneratorNoControl.PowerDemand, integrator1.u) annotation (Line(
        points={{13,-7},{30,-7},{30,-32},{74.8,-32}},
                                                   color={0,0,127}));

  connect(fan1.port_b, heatGeneratorNoControl.port_a)
    annotation (Line(points={{-40,0},{-8,0}}, color={0,127,255}));
  connect(senTCold.port_b, fan1.port_a)
    annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
  connect(controlBoilerNotManufacturer.DeltaTWater_b, heatGeneratorNoControl.dTWater)
    annotation (Line(points={{-81,44.8},{-70,44.8},{-70,16},{-26,16},{-26,9},{
          -10,9}}, color={0,0,127}));
  connect(port_b, port_b) annotation (Line(points={{100,0},{106,0},{106,0},{100,
          0}}, color={0,127,255}));
  connect(senTCold.T, controlBoilerNotManufacturer.TCold) annotation (Line(
        points={{-80,11},{-80,26},{-114,26},{-114,53},{-104,53}}, color={0,0,127}));
  connect(heatGeneratorNoControl.TVolume, controlBoilerNotManufacturer.THot)
    annotation (Line(points={{2,-11},{2,-40},{-110,-40},{-110,50},{-104,50}},
        color={0,0,127}));
  connect(boilerControlBus_Control.DeltaTWater, controlBoilerNotManufacturer.DeltaTWater_a)
    annotation (Line(
      points={{-39.95,98.05},{-39.95,92},{-106,92},{-106,47},{-104,47}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator1.y, boilerControlBus_Control.EnergyDemand) annotation (
      Line(points={{88.6,-32},{110,-32},{110,106},{-39.95,106},{-39.95,98.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(controlBoilerNotManufacturer.mFlowRel, regulation_modularBoiler.mFlow_rel)
    annotation (Line(points={{-81,58},{-70,58},{-70,56.2},{-64,56.2}}, color={0,
          0,127}));
  connect(regulation_modularBoiler.mFlow_relB, fan1.y) annotation (Line(points={{-43.8,
          57},{-34,57},{-34,22},{-50,22},{-50,12}},         color={0,0,127}));
  connect(boilerControlBus_Control.isOn, hierarchicalControl_modularBoilerNEW1.isOn)
    annotation (Line(
      points={{-39.95,98.05},{-20,98.05},{-20,61.6},{-4,61.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(hierarchicalControl_modularBoilerNEW1.PLRset,
    regulation_modularBoiler.PLRMea) annotation (Line(points={{16,64},{16,32},{
          -66,32},{-66,51.4},{-64,51.4}}, color={0,0,127}));
  connect(hierarchicalControl_modularBoilerNEW1.PLRset, heatGeneratorNoControl.PLR)
    annotation (Line(points={{16,64},{16,16},{-10,16},{-10,5.4}}, color={0,0,
          127}));
  connect(senTHot.T, hierarchicalControl_modularBoilerNEW1.Tb) annotation (Line(
        points={{60,11},{60,78},{-6,78},{-6,56.4},{-4.2,56.4}}, color={0,0,127}));
  connect(boilerControlBus_Control.PLR, regulation_modularBoiler.PLRin)
    annotation (Line(
      points={{-39.95,98.05},{-39.95,74},{-72,74},{-72,61},{-64,61}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTHot.T, hierarchicalControl_modularBoilerNEW1.TMeaBoiler)
    annotation (Line(points={{60,11},{60,36},{1.8,36},{1.8,47.2}}, color={0,0,
          127}));
  connect(regulation_modularBoiler.PLRset,
    hierarchicalControl_modularBoilerNEW1.PLRin) annotation (Line(points={{-44,
          61.6},{-24,61.6},{-24,65.4},{-4,65.4}}, color={0,0,127}));
  connect(TMeaCon, hierarchicalControl_modularBoilerNEW1.TMeaCon) annotation (
      Line(points={{101,31},{76,31},{76,42},{15,42},{15,46.4}},   color={0,0,
          127}));
  connect(hierarchicalControl_modularBoilerNEW1.valPos, valPos) annotation (
      Line(points={{16,51.4},{56,51.4},{56,72},{102,72}}, color={0,0,127}));
  connect(TCon, hierarchicalControl_modularBoilerNEW1.TCon) annotation (Line(
        points={{40,100},{40,38},{9.8,38},{9.8,46.4}}, color={0,0,127}));
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
end ModularBoiler_FlowTemperatureControlAdmix;
