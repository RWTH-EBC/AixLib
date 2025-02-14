within AixLib.Fluid.Examples.ERCBuilding.BaseClasses;
model HT_simple "Example that illustrates use of boiler model"

  replaceable package Medium_Water = AixLib.Media.Water;

  inner Modelica.Fluid.System system(p_start=system.p_ambient,
    p_ambient(displayUnit="Pa")) "Pressure drop"
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.BooleanConstant isNight(k=false)
    "No night-setback"
    annotation (Placement(transformation(extent={{-102,30},{-82,50}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_a_HT(redeclare package Medium =
        Medium_Water)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1_HT(redeclare package Medium =
        Medium_Water)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.BooleanInput onOff annotation (Placement(
        transformation(extent={{-128,-88},{-88,-48}}), iconTransformation(
          extent={{-128,-88},{-88,-48}})));
  Modelica.Blocks.Interfaces.RealInput Toutdoor
    annotation (Placement(transformation(extent={{-128,50},{-88,90}})));

  Modelica.Fluid.Sensors.TemperatureTwoPort Temp_Water_Out_Pump(redeclare
      package Medium = Medium_Water) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=0,
        origin={-26,0})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Temp_Water_In_Pump(redeclare
      package Medium = Medium_Water) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=0,
        origin={-82,0})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Temp_Water_Out_Boiler(redeclare
      package Medium = Medium_Water) annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=0,
        origin={62,0})));
  AixLib.Fluid.BoilerCHP.Boiler boiler(redeclare package Medium =
                       Medium_Water, m_flow_nominal=0.03,
    redeclare model ExtControl =
        BaseClasses.Controllers.ExternalControlNightDayHC,
    declination=1.2,
    FA=0,
    riseTime=0,
    TN=0.05,
    paramBoiler=AixLib.DataBase.Boiler.General.Boiler_Vitogas200F_60kW(),
    paramHC=
        AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10())
    annotation (Placement(transformation(extent={{-4,-8},{16,12}})));
  Modelica.Blocks.Sources.Constant const1(k=15)
    annotation (Placement(transformation(extent={{-12,-26},{-20,-18}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow PumpHT(redeclare package Medium =
        Medium_Water,m_flow_nominal=1,
    addPowerToMedium=false,
    allowFlowReversal=false,
    show_T=true)
    annotation (Placement(transformation(extent={{-58,10},{-38,-10}})));
  Modelica.Fluid.Vessels.ClosedVolume vol_HP_Hot_In(
    redeclare package Medium = Medium_Water,
    use_portsData=false,
    nPorts=2,
    V=0.01,
    T_start=303.15)
    annotation (Placement(transformation(extent={{-80,-26},{-68,-38}})));
equation
  connect(Temp_Water_Out_Pump.port_b, boiler.port_a) annotation (Line(points={{-18,
          0},{-12,0},{-12,2},{-4,2}}, color={0,127,255}));
  connect(boiler.port_b, Temp_Water_Out_Boiler.port_a)
    annotation (Line(points={{16,2},{36,2},{36,0},{54,0}}, color={0,127,255}));
  connect(isNight.y, boiler.switchToNightMode) annotation (Line(points={{-81,40},
          {-10,40},{-10,6},{-1,6}}, color={255,0,255}));
  connect(Toutdoor, boiler.TAmbient) annotation (Line(points={{-108,70},{-6,70},
          {-6,9},{-1,9}}, color={0,0,127}));
  connect(onOff, boiler.isOn) annotation (Line(points={{-108,-68},{12,-68},{12,-7},
          {11,-7}}, color={255,0,255}));
  connect(port_a_HT, Temp_Water_In_Pump.port_a)
    annotation (Line(points={{-100,0},{-90,0}},         color={0,127,255}));
  connect(port_b1_HT, Temp_Water_Out_Boiler.port_b)
    annotation (Line(points={{100,0},{70,0},{70,0}}, color={0,127,255}));
  connect(PumpHT.port_b, Temp_Water_Out_Pump.port_a)
    annotation (Line(points={{-38,0},{-36,0},{-34,0}}, color={0,127,255}));
  connect(Temp_Water_In_Pump.port_b, vol_HP_Hot_In.ports[1]) annotation (Line(
        points={{-74,0},{-74,-26},{-75.2,-26}}, color={0,127,255}));
  connect(vol_HP_Hot_In.ports[2], PumpHT.port_a) annotation (Line(points={{-72.8,
          -26},{-66,-26},{-66,0},{-58,0}}, color={0,127,255}));
  connect(const1.y, PumpHT.m_flow_in) annotation (Line(points={{-20.4,-22},{-36,
          -22},{-36,-12},{-48.2,-12}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  The simulation illustrates the behavior of <a href=
  \"AixLib.Fluid.BoilerCHP.Boiler\">AixLib.Fluid.BoilerCHP.Boiler</a>
  during a day. Flow temperature of the boiler can be compared to the
  heating curve produced by the internal controler of the boiler.
  Change the inlet water temperature, heat curve or day and night mode
  to see the reaction.
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Pooyan Jahangiri:<br/>
    Merged with AixLib
  </li>
  <li>
    <i>April 16, 2014 &#160;</i> by Ana Constantin:<br/>
    Formated documentation.
  </li>
  <li>by Pooyan Jahangiri:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={            Rectangle(
          extent={{-50,90},{70,-70}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),
        Polygon(
          points={{-8.5,-13.5},{-16.5,2.5},{5.5,46.5},{13.5,20.5},{35.5,24.5},{25.5,
              -17.5},{7.5,-13.5},{1.5,-13.5},{-8.5,-13.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-6.5,-11.5},{3.5,8.5},{29.5,-11.5},{3.5,-11.5},{-6.5,-11.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-16.5,-11.5},{37.5,-19.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192})}));
end HT_simple;
