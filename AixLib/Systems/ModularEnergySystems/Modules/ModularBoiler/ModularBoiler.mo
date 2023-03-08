within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler;
model ModularBoiler
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
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

  AixLib.Systems.ModularEnergySystems.Interfaces.BoilerControlBus
    boilerControlBus
    annotation (Placement(transformation(extent={{-12,90},{8,110}})));
  Modelica.Blocks.Sources.RealExpression one1(y=QNom/4180/dTWaterNom)
    annotation (Placement(transformation(extent={{-66,48},{-54,64}})));
  Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=QNom/4180/dTWaterNom,
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-56,-10},{-36,10}})));
  Modelica.Blocks.Sources.RealExpression dTWaterNom1(y=20)
    "Real input temperature difference dimension point"
    annotation (Placement(transformation(extent={{-152,32},{-126,50}})));
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

  connect(port_b, port_b) annotation (Line(points={{100,0},{106,0},{106,0},{100,
          0}}, color={0,127,255}));
  connect(integrator1.y, boilerControlBus.EnergyDemand) annotation (Line(points={{88.6,
          -32},{110,-32},{110,106},{-1.95,106},{-1.95,100.05}},       color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senTHot.T, boilerControlBus.THot) annotation (Line(points={{60,11},{
          58,11},{58,50},{8,50},{8,100.05},{-1.95,100.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus.PLR, heatGeneratorNoControl.Qrel) annotation (Line(
      points={{-1.95,100.05},{-4,100.05},{-4,5.4},{-10,5.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fan.port_b, heatGeneratorNoControl.port_a)
    annotation (Line(points={{-36,0},{-8,0}}, color={0,127,255}));
  connect(senTCold.port_b, fan.port_a)
    annotation (Line(points={{-70,0},{-56,0}}, color={0,127,255}));
  connect(one1.y, fan.m_flow_in) annotation (Line(points={{-53.4,56},{-48,56},{
          -48,12},{-46,12}}, color={0,0,127}));
  connect(dTWaterNom1.y, heatGeneratorNoControl.dTWater) annotation (Line(
        points={{-124.7,41},{-20,41},{-20,9},{-10,9}}, color={0,0,127}));
  connect(heatGeneratorNoControl.PowerDemand, boilerControlBus.PowerDemand)
    annotation (Line(points={{13,-7},{26,-7},{26,100.05},{-1.95,100.05}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
