within AixLib.Fluid.BoilerCHP;
model ModularBoilerNotManufacturer
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface(redeclare package
      Medium =Media.Water, final m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom));
//(final m_flow_nominal=QNom/(cp*dTWaterNom))
//pressure(V_flow={0,V_flow_nominal/2,V_flow_nominal}, dp={dp_nominal,7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal/2)^2,0})
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

  Boolean Shutdown;

// protected
//    replaceable package MediumBoiler =Media.Water constrainedby
//     Modelica.Media.Interfaces.PartialMedium "Medium heat source"
//       annotation (choices(
//         choice(redeclare package Medium = AixLib.Media.Water "Water"),
//         choice(redeclare package Medium =
//             AixLib.Media.Antifreeze.PropyleneGlycolWater (
//               property_T=293.15,
//               X_a=0.40)
//               "Propylene glycol water, 40% mass fraction")));



  // parameter Real coeffPresLoss=7.143*10^8*exp(-0.007078*QNom/1000)
   // "Pressure loss coefficient of the heat generator";





  BoilerNotManufacturer heatGeneratorNoControl(
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
  Controls.Interfaces.GeneralModularConnector generalModularConnector
    annotation (Placement(transformation(extent={{-14,86},{14,114}})));
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
        origin={-21,71})));
  Sensors.TemperatureTwoPort senTHot(
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
        origin={40,0})));
  Sensors.TemperatureTwoPort senTCold(
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
  Modelica.Blocks.Interfaces.RealOutput EnergyDemand "Energy demand"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));

  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-50,30})));
  BaseClasses.Controllers.ControlBoilerNotManufacturer
    controlBoilerNotManufacturer(QNom=QNom, m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-100,36},{-80,56}})));
  Movers.SpeedControlled_y fan1(
    redeclare package Medium = Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_nominal,2*V_flow_nominal}, dp={dp_nominal/0.8,
            dp_nominal,0})),
    addPowerToMedium=false)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{62,56},{46,72}})));
  Modelica.Blocks.Sources.RealExpression tHotMax(y=THotMax)
    annotation (Placement(transformation(extent={{98,36},{80,56}})));
protected
   parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
  parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
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

  if senTHot.T > (THotMax+273.15) then
    Shutdown=true;
  else
    Shutdown=false;
  end if;

  connect(port_a, port_a)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,127,255}));

  if Pump==false then
  connect(port_a, heatGeneratorNoControl.port_a) annotation (Line(points={{-100,0},
            {-100,-20},{-8,-20},{-8,0}},     color={0,127,255}));
  else
  end if;

  connect(switch3.y, heatGeneratorNoControl.PLR) annotation (Line(points={{30,27},
          {30,20},{-20,20},{-20,5.4},{-10,5.4}},
                                             color={0,0,127}));
  connect(realExpression.y, switch3.u1) annotation (Line(points={{51.1,86},{38,
          86},{38,50}},     color={0,0,127}));
  connect(pLRMin.y, switch4.u2) annotation (Line(points={{-59.1,71},{-31.8,71}},
                           color={255,0,255}));
  connect(generalModularConnector.PLR, pLRMin.u) annotation (Line(
      points={{0.07,100.07},{0,100.07},{0,90},{-92,90},{-92,71},{-79.8,71}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch4.y, switch3.u3) annotation (Line(points={{-11.1,71},{22,71},{
          22,50}},     color={0,0,127}));
  connect(realExpression.y, switch4.u1) annotation (Line(points={{51.1,86},{-42,
          86},{-42,78.2},{-31.8,78.2}},                              color={0,0,
          127}));
  connect(generalModularConnector.PLR, switch4.u3) annotation (Line(
      points={{0.07,100.07},{0.07,96},{0,96},{0,90},{-46,90},{-46,63.8},{-31.8,
          63.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTHot.port_b, port_b)
    annotation (Line(points={{50,0},{100,0}}, color={0,127,255}));
  connect(senTHot.port_a, heatGeneratorNoControl.port_b)
    annotation (Line(points={{30,0},{12,0}}, color={0,127,255}));
  connect(port_a, senTCold.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(heatGeneratorNoControl.PowerDemand, integrator1.u) annotation (Line(
        points={{13,-7},{30,-7},{30,-32},{74.8,-32}},
                                                   color={0,0,127}));
  connect(integrator1.y, EnergyDemand) annotation (Line(points={{88.6,-32},{100,
          -32},{100,-30},{110,-30}},         color={0,0,127}));

  connect(pLRMin.y, switch7.u2) annotation (Line(points={{-59.1,71},{-50,71},{
          -50,42}},   color={255,0,255}));
  connect(realExpression.y, switch7.u1) annotation (Line(points={{51.1,86},{10,
          86},{10,48},{-58,48},{-58,42}},            color={0,0,127}));
  connect(generalModularConnector.DeltaTWater, controlBoilerNotManufacturer.DeltaTWater_a)
    annotation (Line(
      points={{0.07,100.07},{0.07,100},{-122,100},{-122,43},{-102,43}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTHot.T, controlBoilerNotManufacturer.THot) annotation (Line(points={{40,11},
          {108,11},{108,110},{-106,110},{-106,46},{-102,46}},             color=
         {0,0,127}));
  connect(fan1.port_b, heatGeneratorNoControl.port_a)
    annotation (Line(points={{-40,0},{-8,0}}, color={0,127,255}));
  connect(senTCold.port_b, fan1.port_a)
    annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
  connect(controlBoilerNotManufacturer.mFlowRel, switch7.u3) annotation (Line(
        points={{-79,53.2},{-42,53.2},{-42,42}}, color={0,0,127}));
  connect(switch7.y, fan1.y)
    annotation (Line(points={{-50,19},{-50,12}}, color={0,0,127}));
  connect(controlBoilerNotManufacturer.DeltaTWater_b, heatGeneratorNoControl.dTWater)
    annotation (Line(points={{-79,40.8},{-70,40.8},{-70,16},{-26,16},{-26,9},{
          -10,9}}, color={0,0,127}));
  connect(greater.y, switch3.u2)
    annotation (Line(points={{45.2,64},{30,64},{30,50}}, color={255,0,255}));
  connect(port_b, port_b) annotation (Line(points={{100,0},{106,0},{106,0},{100,
          0}}, color={0,127,255}));
  connect(senTHot.T, greater.u1) annotation (Line(points={{40,11},{108,11},{108,
          64},{63.6,64}}, color={0,0,127}));
  connect(tHotMax.y, greater.u2) annotation (Line(points={{79.1,46},{68,46},{68,
          57.6},{63.6,57.6}}, color={0,0,127}));
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
end ModularBoilerNotManufacturer;
