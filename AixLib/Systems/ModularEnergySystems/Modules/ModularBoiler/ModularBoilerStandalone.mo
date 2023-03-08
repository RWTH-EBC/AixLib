within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoilerStandalone
                              extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare
      package
      Medium = AixLib.Media.Water,
                           final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));

  parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Temperature difference nominal"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.Temperature TColdNom=273.15 + 35
                                                             "Return temperature TCold"
   annotation (Dialog(group="Nominal condition"));
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Thermal dimension power"
   annotation (Dialog(group="Nominal condition"));
  parameter Boolean m_flowVar=false "Use variable water massflow"
  annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

  parameter Boolean Pump=true "Model includes a pump"
   annotation (choices(checkBox=true), Dialog(descriptionLabel=true));


  parameter Boolean Advanced=false "dTWater is constant for different PLR"
  annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));

  parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
   annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));

  parameter Modelica.Units.SI.Temperature THotMax=273.15 + 90
                                                            "Maximal temperature to force shutdown";
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  parameter Modelica.Units.SI.Temperature TStart=273.15 + 20
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


  Fluid.BoilerCHP.BoilerNotManufacturer
                        heatGeneratorNoControl(
    T_start=TStart,
    dTWaterSet=dTWaterSet,
    QNom=QNom,
    PLRMin=PLRMin,
    redeclare package Medium = Media.Water,
    final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom),
    dTWaterNom=dTWaterNom,
    TColdNom=TColdNom,
    m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  inner Modelica.Fluid.System system(p_start=system.p_ambient)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTHot(
    redeclare final package Medium = Media.Water,
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
    redeclare final package Medium = Media.Water,
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

  Controls.ControlBoilerNotManufacturer
    controlBoilerNotManufacturer(
    DeltaTWaterNom=dTWaterNom,
    TColdNom=TColdNom,           QNom=QNom, m_flowVar=m_flowVar,
    Advanced=Advanced,
    dTWaterSet=dTWaterSet,
    THotMax=THotMax,
    TStart=TStart)
    annotation (Placement(transformation(extent={{-80,34},{-60,54}})));
  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium = Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={dp_nominal/0.8,
            dp_nominal,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-12,90},{8,110}})));
protected
   parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  parameter Modelica.Units.SI.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
   replaceable package MediumBoiler =Media.Water constrainedby
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
    annotation (Line(points={{-59,37.2},{-10,37.2},{-10,9}},
                   color={0,0,127}));
  connect(port_b, port_b) annotation (Line(points={{100,0},{106,0},{106,0},{100,
          0}}, color={0,127,255}));
  connect(senTCold.T, controlBoilerNotManufacturer.TCold) annotation (Line(
        points={{-80,11},{-80,30},{-92,30},{-92,42.6667},{-82,42.6667}},
                                                                  color={0,0,127}));
  connect(boilerControlBus.DeltaTWater, controlBoilerNotManufacturer.DeltaTWater_a)
    annotation (Line(
      points={{-1.95,100.05},{-1.95,74},{-96,74},{-96,38.6667},{-82,38.6667}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(integrator1.y, boilerControlBus.EnergyDemand) annotation (Line(points={{88.6,
          -32},{110,-32},{110,106},{-1.95,106},{-1.95,100.05}},       color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(controlBoilerNotManufacturer.plr_b, heatGeneratorNoControl.Qrel)
    annotation (Line(points={{-59,49.4667},{-16,49.4667},{-16,5.4},{-10,5.4}},
        color={0,0,127}));
  connect(controlBoilerNotManufacturer.mFlowRel, fan1.y) annotation (Line(
        points={{-57,46.5333},{-50,46.5333},{-50,12}}, color={0,0,127}));
  connect(boilerControlBus.PLR, controlBoilerNotManufacturer.plr_a) annotation (
     Line(
      points={{-1.95,100.05},{-1.95,58},{-92,58},{-92,50.9333},{-82,50.9333}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTHot.T, controlBoilerNotManufacturer.THot) annotation (Line(points={{60,11},
          {60,28},{-90,28},{-90,40.6667},{-82,40.6667}},         color={0,0,127}));
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
end ModularBoilerStandalone;
