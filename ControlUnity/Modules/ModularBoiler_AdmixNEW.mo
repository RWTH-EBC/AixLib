within ControlUnity.Modules;
model ModularBoiler_AdmixNEW
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(
    allowFlowReversal=false,                              redeclare package Medium =
              AixLib.Media.Water,
                           final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));

  parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.Temperature TColdNom=273.15 + 35
                                                            "Return temperature TCold"
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

  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  parameter Modelica.SIunits.Temperature TStart=273.15 + 20
                                                          "T start"
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
    annotation (Placement(transformation(extent={{-100,36},{-80,56}})));
  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={dp_nominal/0.8,
            dp_nominal,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-74,88},{-54,108}})));

     //
    ///Control unity

  Regulation_modularBoiler regulation_modularBoiler(use_advancedControl=false)
    annotation (Placement(transformation(extent={{-62,46},{-42,66}})));
  parameter Integer n= if simpleTwoPosition then 1 else n "Number of layers in the buffer storage" annotation(Dialog(enable=not use_advancedControl,tab="Control", group="Two position control"));
  parameter Boolean simpleTwoPosition "Decides if the two position control is used with or without a buffer storage; if true n=1, else n is the number of layers of the buffer storage" annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"), choices(
      choice=true "Simple Two position control",
      choice=false "With buffer storage",
      radioButtons=true));
  parameter Boolean use_advancedControl
    "Selection between two position control and flow temperature control, if true=flow temperature control is active"
                                                                                                                     annotation(choices(
      choice=true "Flow temperature control",
      choice=false "Two position control",
      radioButtons=true), Dialog(tab="Control", group="Parameters"));

   ///Control unity
   //
  ControlUnity.hierarchicalControl_modularOLD
    hierarchicalControl_modularBoilerNEW1(
    use_advancedControl=use_advancedControl,
    n=n,
    bandwidth=bandwidth,
    severalHeatcurcuits=severalHeatcurcuits,
    k=k,
    TBoiler=TBoiler,
    Tref=Tref,
    declination=declination,
    day_hour=day_hour,
    night_hour=night_hour,
    TOffset=TOffset,
    TMax=TMax) annotation (Placement(transformation(extent={{0,40},{20,60}})));
  parameter Modelica.SIunits.Temperature Tref
    "Reference Temperature for the on off controller"
                                                     annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"));
  parameter Real bandwidth=2.5 "Bandwidth around reference signal" annotation(Dialog(enable=not use_advancedControl, tab="Control", group="Two position control"));
  Modelica.Blocks.Interfaces.RealInput TLayers[n] if not use_advancedControl
     and not simpleTwoPosition                                               annotation (Placement(
        transformation(
        extent={{-17,-17},{17,17}},
        rotation=-90,
        origin={53,99}), iconTransformation(extent={{4,74},{38,108}})));
  parameter Integer k=3 "Number of heat curcuits"  annotation(Dialog(enable=use_advancedControl and severalHeatcurcuits, tab="Control", group="Admixture control"));
  parameter Modelica.SIunits.Temperature TBoiler=273.15 + 75
    "Fix boiler temperature for the admixture" annotation(Dialog(enable=use_advancedControl and severalHeatcurcuits,tab="Control", group="Admixture control"));
  parameter Boolean severalHeatcurcuits
    "If true, there are two or more heat curcuits"
                                                  annotation(choices(
      choice=true "Several heat curcuits",
      choice=false "One heat curcuit",
      radioButtons=true), Dialog(enable=use_advancedControl, tab="Control", group="Flow temperature control"));
  Modelica.Blocks.Interfaces.RealInput TCon[k] if use_advancedControl and
    severalHeatcurcuits "Set temperature for the consumers" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-8,100})));
  parameter Real declination=1 "Declination of curve" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));
  parameter Real day_hour=6 "Hour of day in which day mode is enabled" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));
  parameter Real night_hour=22 "Hour of night in which night mode is enabled" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));
  parameter Modelica.SIunits.ThermodynamicTemperature TOffset=0
    "Offset to heating curve temperature" annotation(Dialog(enable=use_advancedControl and not severalHeatcurcuits, tab="Control", group="Flow temperature control"));
  parameter Modelica.SIunits.Temperature TMax=273.15 + 105
    "Maximum temperature, at which the system is shut down" annotation(Dialog(tab="Control", group="Security-related systems"));
  flowTemperatureController.renturnAdmixture.Admixture admixture[k](
    redeclare package Medium = Medium,
    k=k,
    m_flow_nominalCon=m_flow_nominalCon,
    dp_nominalCon=dp_nominalCon,
    QNomCon=QNomCon,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Kv=10) if use_advancedControl and severalHeatcurcuits annotation (Placement(
        transformation(
        extent={{-16,-14},{16,14}},
        rotation=0,
        origin={22,-72})));
  flowTemperatureController.renturnAdmixture.AdmixtureBus admixtureBus[k]
    annotation (Placement(transformation(extent={{40,-84},{60,-64}})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominalCon[:]
    "Nominal mass flow rate for the individual consumers";
  parameter Modelica.SIunits.PressureDifference dp_nominalCon[:]
    "Pressure drop at nominal conditions for the individual consumers";
  parameter Modelica.SIunits.HeatFlowRate QNomCon[:] "Nominal heat power that the consumers need";
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


     ///Admixture

 if use_advancedControl and severalHeatcurcuits then
 for m in 1:k loop
 connect(senTHot.port_b, admixture[m].port_a1);
 connect(admixture[m].port_b1, port_b);
 connect(admixture[m].port_b2, port_a);
 connect(heatGeneratorNoControl.port_a, admixture[m].port_a2);

 end for;
 else
connect(fan1.port_b, heatGeneratorNoControl.port_a)
    annotation (Line(points={{-40,0},{-8,0}}, color={0,127,255}));
  connect(senTHot.port_b, port_b) annotation (Line(points={{70,0},{100,0}}, color={0,127,255}));
   end if;






  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));

  if Pump==false then
  connect(port_a, heatGeneratorNoControl.port_a) annotation (Line(points={{-100,0},
            {-100,-20},{-8,-20},{-8,0}},     color={0,127,255}));
  else
    connect(port_a, senTCold.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));

  end if;

  ///Connections of Two position controller
 if simpleTwoPosition then
  connect(senTHot.T, hierarchicalControl_modularBoilerNEW1.TLayers[1])
    annotation (Line(points={{60,11},{60,66},{10.6,66},{10.6,60}}, color={0,0,127}));
    else
  connect(TLayers, hierarchicalControl_modularBoilerNEW1.TLayers) annotation (
      Line(points={{53,99},{53,80},{10.6,80},{10.6,60}}, color={0,0,127}));
   end if;
   ///


  connect(senTHot.port_a, heatGeneratorNoControl.port_b)
    annotation (Line(points={{50,0},{12,0}}, color={0,127,255}));
  connect(heatGeneratorNoControl.PowerDemand, integrator1.u) annotation (Line(
        points={{13,-7},{30,-7},{30,-32},{74.8,-32}},
                                                   color={0,0,127}));

  connect(senTCold.port_b, fan1.port_a)
    annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
  connect(controlBoilerNotManufacturer.DeltaTWater_b, heatGeneratorNoControl.dTWater)
    annotation (Line(points={{-79,40.8},{-70,40.8},{-70,16},{-26,16},{-26,9},{
          -10,9}}, color={0,0,127}));
  connect(port_b, port_b) annotation (Line(points={{100,0},{100,0}},
               color={0,127,255}));
  connect(senTCold.T, controlBoilerNotManufacturer.TCold) annotation (Line(
        points={{-80,11},{-80,26},{-114,26},{-114,49},{-102,49}}, color={0,0,127}));
  connect(heatGeneratorNoControl.TVolume, controlBoilerNotManufacturer.THot)
    annotation (Line(points={{2,-11},{2,-32},{-114,-32},{-114,46},{-102,46}},
        color={0,0,127}));
  connect(boilerControlBus.DeltaTWater, controlBoilerNotManufacturer.DeltaTWater_a)
    annotation (Line(
      points={{-63.95,98.05},{-63.95,92},{-106,92},{-106,43},{-102,43}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator1.y, boilerControlBus.EnergyDemand) annotation (Line(points={{88.6,
          -32},{110,-32},{110,106},{-63.95,106},{-63.95,98.05}},      color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(boilerControlBus.PLR, regulation_modularBoiler.PLRin) annotation (
      Line(
      points={{-63.95,98.05},{-63.95,92},{-74,92},{-74,59},{-62,59}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(controlBoilerNotManufacturer.mFlowRel, regulation_modularBoiler.mFlow_rel)
    annotation (Line(points={{-79,54},{-74,54},{-74,54.2},{-62,54.2}}, color={0,
          0,127}));
  connect(regulation_modularBoiler.mFlow_relB, fan1.y) annotation (Line(points={{-41.8,
          55},{-34,55},{-34,20},{-50,20},{-50,12}},        color={0,0,127}));
  connect(boilerControlBus.isOn, hierarchicalControl_modularBoilerNEW1.isOn)
    annotation (Line(
      points={{-63.95,98.05},{-34,98.05},{-34,92},{-26,92},{-26,53.6},{0,53.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

  connect(regulation_modularBoiler.PLRset,
    hierarchicalControl_modularBoilerNEW1.PLRin) annotation (Line(points={{-42,59.6},
          {-20,59.6},{-20,57.4},{0,57.4}},       color={0,0,127}));
  connect(senTHot.T, hierarchicalControl_modularBoilerNEW1.Tb) annotation (Line(
        points={{60,11},{56,11},{56,72},{-4,72},{-4,48.4},{-0.2,48.4}}, color={0,
          0,127}));
  connect(hierarchicalControl_modularBoilerNEW1.PLRset, heatGeneratorNoControl.PLR)
    annotation (Line(points={{20,56},{30,56},{30,16},{-16,16},{-16,5.4},{-10,5.4}},
                 color={0,0,127}));
  connect(hierarchicalControl_modularBoilerNEW1.PLRset,
    regulation_modularBoiler.PLRMea) annotation (Line(points={{20,56},{30,56},{30,
          32},{-68,32},{-68,49.4},{-62,49.4}},    color={0,0,127}));

  connect(TCon, hierarchicalControl_modularBoilerNEW1.TCon) annotation (Line(
        points={{-8,100},{-8,34},{13.8,34},{13.8,38.4}}, color={0,0,127}));
  connect(boilerControlBus.Tamb, hierarchicalControl_modularBoilerNEW1.Tamb) annotation (
      Line(
      points={{-64,98},{-50,98},{-50,86},{-28,86},{-28,42.2},{0,42.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(regulation_modularBoiler.mFlow_relB, boilerControlBus.mFlow_relB) annotation (Line(
        points={{-41.8,55},{-34,55},{-34,80},{-64,80},{-64,98}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(admixtureBus, admixture.admixtureBus) annotation (Line(
      points={{50,-74},{68,-74},{68,-66},{50,-66},{50,-48},{22,-48},{22,-58.7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(hierarchicalControl_modularBoilerNEW1.valPos, admixtureBus.valveSet) annotation (Line(
        points={{20,43.4},{46,43.4},{46,-56},{50.05,-56},{50.05,-73.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(admixtureBus.Tsen_b1, hierarchicalControl_modularBoilerNEW1.TMeaCon) annotation (Line(
      points={{50.05,-73.95},{70,-73.95},{70,-44},{19,-44},{19,38.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));


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
end ModularBoiler_AdmixNEW;
