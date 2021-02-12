within AixLib.ThermalZones.ReducedOrder.Validation.VDI6007;
model TestCaseCwe "Test Case for TABS Integration #1064, Parameters for thermalZoneTwoElements based on TestCase5"
  extends Modelica.Icons.Example;
  RC.TwoElements thermalZoneTwoElements(
    redeclare package Medium = Modelica.Media.Air.SimpleAir,
    hConExt=2.7,
    hConWin=2.7,
    gWin=1,
    nExt=1,
    nInt=1,
    ratioWinConRad=0.09,
    AInt=75.5,
    hConInt=2.24,
    RWin=0.00000001,
    hRad=5,
    RExt={0.00436791293674},
    RExtRem=0.03895919557,
    CExt={1600848.94},
    RInt={0.000595693407511},
    CInt={14836354.6282},
    VAir=0,
    nOrientations=1,
    AWin={0},
    ATransparent={7},
    AExt={10.5},
    extWallRC(thermCapExt(each T(fixed=true))),
    intWallRC(thermCapInt(each T(fixed=true))),
    T_start=283.15)
    "Thermal zone"
    annotation (Placement(transformation(extent={{28,40},{76,76}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature preTem(T=283.15)
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-8,48},{4,60}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall(Q_flow(start=0))
    "Outdoor convective heat transfer"
    annotation (Placement(transformation(extent={{20,60},{10,50}})));
  Modelica.Blocks.Sources.Constant hConWall(k=25*10.5)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(
    transformation(
    extent={{-4,-4},{4,4}},
    rotation=90,
    origin={14,42})));
  Modelica.Blocks.Sources.Constant const(k=0)
    "Solar radiation"
    annotation (Placement(transformation(extent={{4,68},{14,78}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow tabsExtHeaCoo
    "Ideal heater/cooler with limit"
    annotation (Placement(transformation(extent={{42,12},{62,32}})));
  Modelica.Blocks.Math.Gain tabsExtGainHeaCoo(k=0)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-6,16},{6,28}})));
  Modelica.Blocks.Math.Gain fhkExtGainHeaCoo(k=0.122)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-6,-20},{6,-8}})));
  Modelica.Blocks.Math.Gain fhkIntGainHeaCoo(k=0.878)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-6,-38},{6,-26}})));
  Modelica.Blocks.Math.Gain hkConvGainHeaCoo(k=0.5)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-6,-96},{6,-84}})));
  Modelica.Blocks.Math.Gain hkRadExtGainHeaCoo(k=0.061)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-6,-60},{6,-48}})));
  Modelica.Blocks.Math.Gain hkRadIntGainHeaCoo(k=0.439)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-6,-78},{6,-66}})));
  Modelica.Blocks.Math.Gain tabsIntGainHeaCoo(k=1)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-6,-2},{6,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow hkRadExtHeaCoo
    "Ideal heater/cooler with limit"
    annotation (Placement(transformation(extent={{42,-64},{62,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow hkConvHeaCoo
    "Ideal heater/cooler with limit"
    annotation (Placement(transformation(extent={{42,-100},{62,-80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow hkRadIntHeaCoo
    "Ideal heater/cooler with limit"
    annotation (Placement(transformation(extent={{42,-82},{62,-62}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow tabsIntHeaCoo
    "Ideal heater/cooler with limit"
    annotation (Placement(transformation(extent={{42,-6},{62,14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow fhkExtHeaCoo
    "Ideal heater/cooler with limit"
    annotation (Placement(transformation(extent={{42,-24},{62,-4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow fhkIntHeaCoo
    "Ideal heater/cooler with limit"
    annotation (Placement(transformation(extent={{42,-42},{62,-22}})));
  Modelica.Blocks.Sources.Step           setTemp1(
    height=10,
    offset=10,
    startTime=2*86400)
    "Set temperature for ideal heater/cooler"
    annotation (Placement(transformation(extent={{-118,-4},{-102,12}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
    "Convert set temperature from degC to Kelvin"
    annotation (Placement(transformation(extent={{-76,-28},{-64,-16}})));
  Controls.Continuous.LimPID conHeaCoo1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    k=18,
    Ti=2300)
    "Heating and cooling controller"
    annotation (Placement(transformation(extent={{-54,4},{-38,20}})));
  Modelica.Blocks.Math.Gain powerTabs(k=600)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-30,6},{-18,18}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-5,5},{5,-5}},
        rotation=90,
        origin={89,85})));
  Modelica.Blocks.Math.Gain gainTempOp(k=0.5)
    annotation (Placement(transformation(extent={{78,86},{68,96}})));
  Controls.Continuous.LimPID conHeaCoo2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    k=0.1,
    Ti=4)
    "Heating and cooling controller"
    annotation (Placement(transformation(extent={{-54,-30},{-38,-14}})));
  Modelica.Blocks.Math.Gain powerFhk(k=0)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-30,-28},{-18,-16}})));
  Controls.Continuous.LimPID conHeaCoo3(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1,
    yMin=0,
    k=0.1,
    Ti=4)
    "Heating and cooling controller"
    annotation (Placement(transformation(extent={{-54,-80},{-38,-64}})));
  Modelica.Blocks.Math.Gain powerHK(k=0)
    "Gain for heating and cooling controller"
    annotation (Placement(transformation(extent={{-30,-78},{-18,-66}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow intGainsRadfixedHeatFlow(
      Q_flow=0)
    annotation (Placement(transformation(extent={{100,62},{90,72}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow
    intGainsConvfixedHeatFlow1(Q_flow=0)
    annotation (Placement(transformation(extent={{100,50},{90,60}})));
  Modelica.Blocks.Interaction.Show.RealValue TempOp
    annotation (Placement(transformation(extent={{40,86},{20,106}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-96,-28},{-84,-16}})));
  Modelica.Blocks.Sources.BooleanStep booleanStepTwoWeeks(startTime=864000,
      startValue=true)
    annotation (Placement(transformation(extent={{-118,-28},{-106,-16}})));
  Modelica.Blocks.Sources.Pulse pulseNachtabsenkung(
    amplitude=5,
    width=41.67,
    period=86400,
    offset=15,
    startTime=28800)
    annotation (Placement(transformation(extent={{-118,-58},{-102,-42}})));
  Modelica.Blocks.Interaction.Show.RealValue hkGesamt
    annotation (Placement(transformation(extent={{30,-70},{36,-58}})));
  Modelica.Blocks.Math.Add3 add3Hk
    annotation (Placement(transformation(extent={{14,-70},{26,-58}})));
  Modelica.Blocks.Math.Add add2Tabs
    annotation (Placement(transformation(extent={{12,6},{24,18}})));
  Modelica.Blocks.Interaction.Show.RealValue tabsGesamt
    annotation (Placement(transformation(extent={{32,6},{38,18}})));
  Modelica.Blocks.Math.Add add2Fhk annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={18,-24})));
  Modelica.Blocks.Interaction.Show.RealValue fhkGesamt
    annotation (Placement(transformation(extent={{32,-30},{38,-18}})));
equation
  connect(theConWall.fluid,preTem. port)
    annotation (Line(points={{10,55},{8,55},{8,54},{4,54}},color={191,0,0}));
  connect(thermalZoneTwoElements.extWall,theConWall. solid)
    annotation (Line(points={{28,54},{24,54},{24,55},{20,55}},
                                                             color={191,0,0}));
  connect(hConWall.y,theConWall. Gc)
    annotation (Line(points={{14,46.4},{15,46.4},{15,50}},   color={0,0,127}));
  connect(const.y,thermalZoneTwoElements. solRad[1])
    annotation (Line(points={{14.5,73},{27,73}},            color={0,0,127}));
  connect(tabsExtGainHeaCoo.y,tabsExtHeaCoo. Q_flow) annotation (Line(points={{6.6,22},
          {42,22}},                              color={0,0,127}));
  connect(fhkExtGainHeaCoo.y,fhkExtHeaCoo. Q_flow) annotation (Line(points={{6.6,-14},
          {42,-14}},                                               color={0,0,
          127}));
  connect(hkConvGainHeaCoo.y,hkConvHeaCoo. Q_flow) annotation (Line(points={{6.6,-90},
          {42,-90}},                             color={0,0,127}));
  connect(fhkIntGainHeaCoo.y,fhkIntHeaCoo. Q_flow) annotation (Line(points={{6.6,-32},
          {42,-32}},                             color={0,0,127}));
  connect(hkRadIntGainHeaCoo.y,hkRadIntHeaCoo. Q_flow) annotation (Line(points={{6.6,-72},
          {42,-72}},                               color={0,0,127}));
  connect(tabsIntGainHeaCoo.y,tabsIntHeaCoo. Q_flow) annotation (Line(points={{6.6,4},
          {42,4}},                               color={0,0,127}));
  connect(tabsExtHeaCoo.port,thermalZoneTwoElements. tabsExtWalls)
    annotation (Line(points={{62,22},{70.8,22},{70.8,40}},   color={191,0,0}));
  connect(hkRadExtHeaCoo.port,thermalZoneTwoElements. hkRadExtWalls)
    annotation (Line(points={{62,-54},{76,-54},{76,40}},         color={191,0,0}));
  connect(hkConvHeaCoo.port,thermalZoneTwoElements. hkConv) annotation (Line(
        points={{62,-90},{96,-90},{96,45},{76,45}},
                                                  color={191,0,0}));
  connect(hkRadIntHeaCoo.port,thermalZoneTwoElements. hkRadIntWalls)
    annotation (Line(points={{62,-72},{92,-72},{92,49.8},{76,49.8}},
                                                                   color={191,0,
          0}));
  connect(tabsIntHeaCoo.port,thermalZoneTwoElements. tabsIntWalls) annotation (
      Line(points={{62,4},{84,4},{84,56},{76,56}},       color={191,0,0}));
  connect(fhkIntHeaCoo.port,thermalZoneTwoElements. fhkIntWalls) annotation (
      Line(points={{62,-32},{88,-32},{88,47.4},{76,47.4}},  color={191,0,0}));
  connect(fhkExtHeaCoo.port,thermalZoneTwoElements. fhkExtWalls) annotation (
      Line(points={{62,-14},{86,-14},{86,42.6},{76,42.6}},  color={191,0,0}));
  connect(from_degC1.y, conHeaCoo1.u_s) annotation (Line(points={{-63.4,-22},{-60,
          -22},{-60,12},{-55.6,12}}, color={0,0,127}));
  connect(conHeaCoo1.y, powerTabs.u)
    annotation (Line(points={{-37.2,12},{-31.2,12}}, color={0,0,127}));
  connect(hkRadExtGainHeaCoo.y, hkRadExtHeaCoo.Q_flow)
    annotation (Line(points={{6.6,-54},{42,-54}}, color={0,0,127}));
  connect(thermalZoneTwoElements.TAir, add.u1)
    annotation (Line(points={{77,74},{92,74},{92,79}}, color={0,0,127}));
  connect(thermalZoneTwoElements.TRad, add.u2)
    annotation (Line(points={{77,70},{86,70},{86,79}}, color={0,0,127}));
  connect(add.y, gainTempOp.u) annotation (Line(points={{89,90.5},{82.5,90.5},{82.5,
          91},{79,91}}, color={0,0,127}));
  connect(conHeaCoo2.y, powerFhk.u)
    annotation (Line(points={{-37.2,-22},{-31.2,-22}}, color={0,0,127}));
  connect(conHeaCoo3.y, powerHK.u)
    annotation (Line(points={{-37.2,-72},{-31.2,-72}}, color={0,0,127}));
  connect(powerHK.y, hkRadExtGainHeaCoo.u) annotation (Line(points={{-17.4,-72},
          {-12,-72},{-12,-54},{-7.2,-54}}, color={0,0,127}));
  connect(powerHK.y, hkRadIntGainHeaCoo.u)
    annotation (Line(points={{-17.4,-72},{-7.2,-72}}, color={0,0,127}));
  connect(powerHK.y, hkConvGainHeaCoo.u) annotation (Line(points={{-17.4,-72},{-12,
          -72},{-12,-90},{-7.2,-90}}, color={0,0,127}));
  connect(powerFhk.y, fhkExtGainHeaCoo.u) annotation (Line(points={{-17.4,-22},{
          -12,-22},{-12,-14},{-7.2,-14}}, color={0,0,127}));
  connect(powerFhk.y, fhkIntGainHeaCoo.u) annotation (Line(points={{-17.4,-22},{
          -12,-22},{-12,-32},{-7.2,-32}}, color={0,0,127}));
  connect(powerTabs.y, tabsExtGainHeaCoo.u) annotation (Line(points={{-17.4,12},
          {-12,12},{-12,22},{-7.2,22}}, color={0,0,127}));
  connect(powerTabs.y, tabsIntGainHeaCoo.u) annotation (Line(points={{-17.4,12},
          {-12,12},{-12,4},{-7.2,4}}, color={0,0,127}));
  connect(conHeaCoo1.u_m, gainTempOp.y) annotation (Line(points={{-46,2.4},{-80,
          2.4},{-80,91},{67.5,91}}, color={0,0,127}));
  connect(conHeaCoo2.u_m, gainTempOp.y) annotation (Line(points={{-46,-31.6},{-80,
          -31.6},{-80,91},{67.5,91}}, color={0,0,127}));
  connect(conHeaCoo3.u_m, gainTempOp.y) annotation (Line(points={{-46,-81.6},{-80,
          -81.6},{-80,91},{67.5,91}}, color={0,0,127}));
  connect(from_degC1.y, conHeaCoo2.u_s)
    annotation (Line(points={{-63.4,-22},{-55.6,-22}}, color={0,0,127}));
  connect(from_degC1.y, conHeaCoo3.u_s) annotation (Line(points={{-63.4,-22},{-60,
          -22},{-60,-72},{-55.6,-72}}, color={0,0,127}));
  connect(intGainsRadfixedHeatFlow.port, thermalZoneTwoElements.intGainsRad)
    annotation (Line(points={{90,67},{90,66},{76,66}}, color={191,0,0}));
  connect(intGainsConvfixedHeatFlow1.port, thermalZoneTwoElements.intGainsConv)
    annotation (Line(points={{90,55},{86,55},{86,62},{76,62}}, color={191,0,0}));
  connect(TempOp.numberPort, gainTempOp.y) annotation (Line(points={{41.5,96},{54,
          96},{54,91},{67.5,91}}, color={0,0,127}));
  connect(switch1.y, from_degC1.u)
    annotation (Line(points={{-83.4,-22},{-77.2,-22}}, color={0,0,127}));
  connect(booleanStepTwoWeeks.y, switch1.u2)
    annotation (Line(points={{-105.4,-22},{-97.2,-22}}, color={255,0,255}));
  connect(setTemp1.y, switch1.u1) annotation (Line(points={{-101.2,4},{-100,4},{
          -100,-17.2},{-97.2,-17.2}}, color={0,0,127}));
  connect(pulseNachtabsenkung.y, switch1.u3) annotation (Line(points={{-101.2,-50},
          {-100,-50},{-100,-26.8},{-97.2,-26.8}}, color={0,0,127}));
  connect(hkRadExtGainHeaCoo.y, add3Hk.u1) annotation (Line(points={{6.6,-54},{8,
          -54},{8,-59.2},{12.8,-59.2}}, color={0,0,127}));
  connect(hkRadIntGainHeaCoo.y, add3Hk.u2) annotation (Line(points={{6.6,-72},{8,
          -72},{8,-66},{10,-66},{10,-64},{12.8,-64}}, color={0,0,127}));
  connect(hkConvGainHeaCoo.y, add3Hk.u3) annotation (Line(points={{6.6,-90},{10,
          -90},{10,-68.8},{12.8,-68.8}}, color={0,0,127}));
  connect(add3Hk.y, hkGesamt.numberPort)
    annotation (Line(points={{26.6,-64},{29.55,-64}}, color={0,0,127}));
  connect(tabsExtGainHeaCoo.y, add2Tabs.u1) annotation (Line(points={{6.6,22},{10,
          22},{10,15.6},{10.8,15.6}}, color={0,0,127}));
  connect(tabsIntGainHeaCoo.y, add2Tabs.u2) annotation (Line(points={{6.6,4},{
          10,4},{10,8.4},{10.8,8.4}},
                                   color={0,0,127}));
  connect(add2Tabs.y, tabsGesamt.numberPort)
    annotation (Line(points={{24.6,12},{31.55,12}}, color={0,0,127}));
  connect(add2Fhk.y, fhkGesamt.numberPort)
    annotation (Line(points={{24.6,-24},{31.55,-24}}, color={0,0,127}));
  connect(add2Fhk.u2, fhkIntGainHeaCoo.y) annotation (Line(points={{10.8,-27.6},
          {10.8,-28.8},{6.6,-28.8},{6.6,-32}}, color={0,0,127}));
  connect(add2Fhk.u1, fhkExtGainHeaCoo.y) annotation (Line(points={{10.8,-20.4},
          {10.8,-20},{6.6,-20},{6.6,-14}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-120,-100},{120,100}}),
                      graphics={
  Rectangle(
    extent={{62,100},{100,78}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,34},{68,-4}},
          lineColor={28,108,200},
          fillColor={34,133,247},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{18,32},{32,32}},
          lineColor={0,0,0},
          fillColor={34,133,247},
          fillPattern=FillPattern.Solid,
          textString="TABS"),
        Line(points={{-36,114}}, color={28,108,200}),
        Rectangle(
          extent={{-12,-4},{68,-42}},
          lineColor={28,108,200},
          fillColor={0,197,98},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{18,-6},{32,-6}},
          lineColor={0,0,0},
          fillColor={34,133,247},
          fillPattern=FillPattern.Solid,
          textString="FHK"),
        Text(
          extent={{44,66},{58,66}},
          lineColor={0,0,0},
          fillColor={34,133,247},
          fillPattern=FillPattern.Solid,
          textString="TABS"),
        Text(
          extent={{92,98},{92,96}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="TempOp"),
        Rectangle(
          extent={{-12,-42},{68,-100}},
          lineColor={28,108,200},
          fillColor={128,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{16,-44},{30,-44}},
          lineColor={0,0,0},
          fillColor={34,133,247},
          fillPattern=FillPattern.Solid,
          textString="Rest HK")}), experiment(
      StopTime=2592000,
      Interval=900,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-120,-100},{120,100}})));
end TestCaseCwe;
