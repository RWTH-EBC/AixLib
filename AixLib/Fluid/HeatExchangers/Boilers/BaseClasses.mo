within AixLib.Fluid.HeatExchangers.Boilers;
package BaseClasses

 extends Modelica.Icons.BasesPackage;

  model PhysicalModel
    import BaseLib;
    extends Modelica.Fluid.Interfaces.PartialTwoPort(
    final port_a_exposesState=true,
    final port_b_exposesState=true);

    //Parameters
    parameter DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
      paramBoiler=
      DataBase.Boiler.General.Boiler_Vitogas200F_11kW() "Parameters for Boiler"
    annotation (Dialog(tab = "General", group = "Boiler type"), choicesAllMatching = true);

     parameter Modelica.SIunits.Temperature T_start= Modelica.SIunits.Conversions.from_degC(20)
      "initial temperature of heat source"
      annotation (Evaluate=true, Dialog(tab = "General", group = "Simulation"));

   Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow Heater
      annotation (Placement(transformation(extent={{-68.5,38},{-49,56}})));
  protected
    Modelica.Fluid.Vessels.ClosedVolume WaterVolume(
      redeclare package Medium = Medium,
      T_start(displayUnit="K") = T_start,
      V=paramBoiler.volume,
      nPorts=2,
      use_HeatTransfer=true,
      use_portsData=false)
      annotation (Placement(transformation(extent={{-37,10.5},{-16,31.5}})));

  public
    Modelica.Fluid.Fittings.GenericResistances.VolumeFlowRate
      pressureDropBoiler(redeclare package Medium = Medium,
      a=paramBoiler.PressureDrop,
      b=0)
      annotation (Placement(transformation(extent={{-9.5,-5},{11.5,16}})));

    Modelica.Fluid.Sensors.TemperatureTwoPort Tcold(redeclare package Medium =
          Medium) annotation (Placement(transformation(
          extent={{-9.75,9.75},{9.75,-9.75}},
          rotation=0,
          origin={-76.75,-0.75})));

    Modelica.Blocks.Interfaces.RealInput QflowHeater annotation (Placement(
          transformation(extent={{-120,28},{-80,68}}), iconTransformation(
            extent={{-106,42},{-80,68}})));
    Modelica.Blocks.Interfaces.RealOutput mFlow
      "Mass flow through the boiler [kg/s]"
      annotation (Placement(transformation(extent={{80.5,26.5},{100.5,46.5}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor THot
                        annotation (Placement(transformation(extent={{-26.5,56},
              {-10,72.5}})));
    Modelica.Blocks.Interfaces.RealOutput Tflow_hot
      "Absolute temperature as output signal [K]"
      annotation (Placement(transformation(extent={{80,82},{100,102}})));
    Modelica.Blocks.Interfaces.RealOutput Tflow_cold
      "Temperature of the passing fluid [K]"
      annotation (Placement(transformation(extent={{80,56},{100,76}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium
        = Medium)
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  equation
    connect(WaterVolume.heatPort, Heater.port) annotation (Line(
        points={{-37,21},{-38,21},{-38,22},{-44,22},{-44,46},{-49,46},{-49,47}},
        color={191,0,0},
        smooth=Smooth.None));

    connect(WaterVolume.ports[1], pressureDropBoiler.port_a)
                                                        annotation (Line(
        points={{-28.6,10.5},{-28.6,0},{-9.5,0},{-9.5,5.5}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(port_a, Tcold.port_a) annotation (Line(
        points={{-100,0},{-86.5,0},{-86.5,-0.75}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(Tcold.port_b, WaterVolume.ports[2]) annotation (Line(
        points={{-67,-0.75},{-68,-0.75},{-68,0},{-24.4,0},{-24.4,10.5}},
        color={0,127,255},
        smooth=Smooth.None));

    connect(Heater.Q_flow, QflowHeater) annotation (Line(
        points={{-68.5,47},{-78.25,47},{-78.25,48},{-100,48}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(THot.port, WaterVolume.heatPort) annotation (Line(
        points={{-26.5,64.25},{-26.5,46},{-44,46},{-44,22},{-37,22},{-37,21}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(THot.T, Tflow_hot) annotation (Line(
        points={{-10,64.25},{70,64.25},{70,92},{90,92}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Tcold.T, Tflow_cold) annotation (Line(
        points={{-76.75,-11.475},{50,-11.475},{50,20},{70,20},{70,66},{90,66}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(pressureDropBoiler.port_b, massFlowRate.port_a) annotation (Line(
        points={{11.5,5.5},{12,5.5},{12,0},{60,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_b, massFlowRate.port_b) annotation (Line(
        points={{100,0},{80,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(massFlowRate.m_flow, mFlow) annotation (Line(
        points={{70,11},{70,36.5},{90.5,36.5}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                      graphics={
          Rectangle(
            extent={{-40.5,74.5},{53.5,-57.5}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={170,170,255}),
          Polygon(
            points={{-12.5,-19.5},{-20.5,-3.5},{1.5,40.5},{9.5,14.5},{31.5,18.5},
                {21.5,-23.5},{3.5,-19.5},{-2.5,-19.5},{-12.5,-19.5}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={255,127,0}),
          Rectangle(
            extent={{-20.5,-17.5},{33.5,-25.5}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Polygon(
            points={{-10.5,-17.5},{-0.5,2.5},{25.5,-17.5},{-0.5,-17.5},{-10.5,-17.5}},
            lineColor={255,255,170},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Physical model of a boiler.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>This model is a derivation of BoilerTaktTable.</p>
<p>The model represents the fluid volume inside the boiler that is heated up via a prescribed heat flow and has a pressure drop caused by hydraulic losses.</p>
</html>"));
  end PhysicalModel;

model InternalControl
  import BaseLib;

  //Parameters
  parameter DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
    paramBoiler=
    DataBase.Boiler.General.Boiler_Vitogas200F_11kW() "Parameters for Boiler"
  annotation (Dialog(tab = "General", group = "Boiler type"), choicesAllMatching = true);

  parameter Real KR = 1 "Gain of Boiler heater";
  parameter Modelica.SIunits.Time TN = 0.1
      "Time Constant of boiler heater (T>0 required)";
  parameter Modelica.SIunits.Time RiseTime=30
      "Rise/Fall time for step input(T>0 required)";

    //Variable
    Real OutputPower;
  public
  PITemp                            ControlerHeater(
    RangeSwitch=false,
    KR=KR,
    TN=TN,
    h=paramBoiler.Q_nom,
    l=paramBoiler.Q_min,
    triggeredTrapezoid(rising=RiseTime, falling=RiseTime))
    annotation (Placement(transformation(extent={{-40.5,36},{-24,52.5}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn "On/Off switch for the boiler"
    annotation (Placement(transformation(extent={{-112.5,27},{-87,52.5}}),
        iconTransformation(
        extent={{-12.75,-12.75},{12.75,12.75}},
        rotation=-90,
        origin={-24.75,102.75})));
  AixLib.Utilities.Sensors.EEnergyMeter eEnergyMeter_P
      "for primary energy consumption"
    annotation (Placement(transformation(extent={{30,63},{49.5,84}})));

  AixLib.Utilities.Sensors.EEnergyMeter eEnergyMeter_S
      "for secondary energy consumption"
    annotation (Placement(transformation(extent={{30,82.5},{49.5,103.5}})));
  Modelica.Blocks.Tables.CombiTable1D EfficiencyTable(
    tableOnFile=false,
    table=paramBoiler.eta,
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{4.5,4.5},{15,15}})));
  Modelica.Blocks.Interfaces.RealInput Tflow_set
      "target Temperature of the controller[K]"  annotation (Placement(
        transformation(
        extent={{-15.25,-15.25},{15.25,15.25}},
        rotation=0,
        origin={-100.75,81.25}), iconTransformation(
        extent={{-12.875,-12.875},{12.875,12.875}},
        rotation=-90,
        origin={20.375,101.125})));
  Modelica.Blocks.Math.Gain QNormated(k=1/paramBoiler.Q_nom)
    annotation (Placement(transformation(extent={{-13.5,6},{-4.5,15}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{21,24},{30,33}})));
  Modelica.Blocks.Interfaces.RealInput Tflow_hot "outgoing Temperature [K]"
    annotation (Placement(transformation(extent={{-126.5,-20},{-86.5,20}}),
        iconTransformation(extent={{113,3},{87,29}})));
  Modelica.Blocks.Interfaces.RealOutput QflowHeater
      "Connector of Real output signal"
    annotation (Placement(transformation(extent={{66.5,18.5},{86.5,38.5}}),
        iconTransformation(extent={{-90.5,29},{-110.5,49}})));
  Modelica.Blocks.Interfaces.RealInput mFlow
      "Mass flow through the boiler [kg/s]"
    annotation (Placement(transformation(extent={{-125,-84.5},{-85,-44.5}}),
        iconTransformation(extent={{114.5,-63},{87,-35.5}})));
  Modelica.Blocks.Interfaces.RealInput Tflow_cold
      "Temperature of the cold water[K]"   annotation (Placement(transformation(
          extent={{-125,-51.5},{-85,-11.5}}), iconTransformation(extent={{114.5,
            -30},{87,-2.5}})));
equation

  if cardinality(isOn) < 2 then
    isOn = true;
  end if;

  OutputPower = mFlow * 4184 * (Tflow_hot - Tflow_cold);
  eEnergyMeter_S.p=OutputPower;

  connect(ControlerHeater.y, eEnergyMeter_P.p)
                                    annotation (Line(
      points={{-24.825,44.25},{4.5,44.25},{4.5,73.5},{31.365,73.5}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ControlerHeater.y, QNormated.u) annotation (Line(
      points={{-24.825,44.25},{-18,44.25},{-18,10.5},{-14.4,10.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QNormated.y, EfficiencyTable.u[1]) annotation (Line(
      points={{-4.05,10.5},{-0.3,10.5},{-0.3,9.75},{3.45,9.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ControlerHeater.y, product.u1) annotation (Line(
      points={{-24.825,44.25},{4.5,44.25},{4.5,31.5},{12,31.5},{20.1,31.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(EfficiencyTable.y[1], product.u2) annotation (Line(
      points={{15.525,9.75},{19.5,9.75},{19.5,25.8},{20.1,25.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ControlerHeater.set, Tflow_set) annotation (Line(
      points={{-38.85,51.675},{-38.85,81},{-100.75,81},{-100.75,81.25}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, QflowHeater) annotation (Line(
      points={{30.45,28.5},{76.5,28.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ControlerHeater.isOn, isOn) annotation (Line(
      points={{-39.675,40.125},{-90.3375,40.125},{-90.3375,39.75},{-99.75,39.75}},
      color={255,0,255},
      smooth=Smooth.None));

  connect(Tflow_hot, ControlerHeater.is) annotation (Line(
      points={{-106.5,0},{-37.5,0},{-37.5,36.825},{-38.025,36.825}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5}), graphics), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5}), graphics={Rectangle(
          extent={{-82.5,87},{88.5,-73.5}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-79.5,27},{87,-3}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Internal control of the boiler</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><br><h4><span style=\"color:#008000\">Concept</span></h4></p>
<p>This model is a derivation of BoilerTaktTable.</p>
<p>There is a differentiation made between primary and secondary energy consumption.</p>
<p>The primary power output can be read at the output of <b>ControlerHeater. </b>It is then multiplied with an efficienca factor to calculate the the effective heat flow that heats up the fluid in the boiler<b>.</b></p>
<p>There are two energy meters: one for the primary energy and one for the secondary. The secondary power output is calculated as:</p>
<p><img src=\"modelica://HVAC/Images/equations/equation-4pZqzkAy.png\" alt=\"P_sec = m_flow *c_p*(T_2-T_1)\"/></p>
<p>Where T2 is the temperature of the fluid leaving the heater and T1 ist the temperature of the fluid entering the heater. </p>
</html>",
revisions="<html>
<p><ul>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>July 12, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
end InternalControl;

  partial model PartialExternalControl
    "with measurement of primary and secondary energy consumption"

    Modelica.Blocks.Interfaces.RealInput Toutside "Outside temperature [K]"
      annotation (Placement(transformation(
          extent={{-13.5,-13.5},{13.5,13.5}},
          rotation=0,
          origin={-100,-39}), iconTransformation(extent={{-10.75,-10.5},{10.75,10.5}},
            origin={-97.25,-36})));
  public
    Modelica.Blocks.Interfaces.BooleanInput isOn "On/Off switch for the boiler"
      annotation (Placement(transformation(extent={{-115.5,6},{-90,31.5}}),
          iconTransformation(extent={{-108,13.5},{-90,31.5}})));
  public
    Modelica.Blocks.Interfaces.BooleanInput SwitchToNightMode
      "Connector of Boolean input signal"
      annotation (Placement(transformation(extent={{-13.75,-13.75},{13.75,13.75}},
          rotation=0,
          origin={-101.75,49.75}), iconTransformation(
          extent={{-8.25,-8.5},{8.25,8.5}},
          rotation=0,
          origin={-99.5,56.25})));

  public
    Modelica.Blocks.Interfaces.BooleanOutput isOn_Final annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-15,-99}), iconTransformation(extent={{92,8},{112,28}},
            rotation=0)));
    Modelica.Blocks.Interfaces.RealOutput Tflow_set
      "target Temperature of the controller [K]"    annotation (Placement(
          transformation(extent={{92,38},{112,58}}), iconTransformation(extent={
              {92,38},{112,58}})));
    Modelica.Blocks.Interfaces.RealInput Tflow_is
      "actual outgoing temperature [K]"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          rotation=90,
          origin={75,-100.5}),
          iconTransformation(
          extent={{11.5,-11.5},{-11.5,11.5}},
          rotation=-90,
          origin={65,-92})));
  equation
    if cardinality(isOn) < 2 then
      isOn = true;
    end if;

    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1.5,1.5}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1.5,1.5}), graphics={
                              Rectangle(
            extent={{-84,85.5},{91.5,-82.5}},
            lineColor={175,175,175},
            lineThickness=0.5,
            fillPattern=FillPattern.Solid,
            fillColor={255,255,170}),
          Text(
            extent={{-79.5,19.5},{82.5,-4.5}},
            lineColor={0,0,0},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
            textString="%name")}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This is a controller model, modelled after the <a href=\"DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10\">Vitotronic 200</a>. </p>
<p>This model is derived from <a href=\"HVAC.Components.HeatGenerators.Boiler.BaseClasses.Controller\">HVAC.Components.HeatGenerators.Boiler.BaseClasses.Controller</a>.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following control decisions are implemented:</p>
<ul>
<li>Switch on/off when the fluid temperature is under/over the set fluid temperature </li>
<li>Heating curve: fluid temperature depending on the outside temperature</li>
<li>Average outside temperature</li>
<li>Increase the set fluid temperature when going to day mode in order to shorten the heating up period </li>
</ul>
</html>",
  revisions="<html>
<p><ul>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>October 12, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
  end PartialExternalControl;

  model ExternalControl_nightDayHC
    "with night and day modes, both with heating curves"
    extends PartialExternalControl;
    import BaseLib;

    //Parameters
    parameter
      DataBase.Boiler.DayNightMode.HeatingCurvesDayNightBaseDataDefinition
      paramHC = DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10()
      "Parameters for heating curve"
    annotation (Dialog( group= "Heating curves"), choicesAllMatching = true);

    parameter Real declination = 1.1 "Neigung" annotation (Dialog( group= "Heating curves"));

    parameter Modelica.SIunits.TemperatureDifference Tdelta_Max = 2
      "difference from set flow temperature over which boiler stops" annotation ( Dialog(group = "OnOff"));
      parameter Modelica.SIunits.TemperatureDifference Tdelta_Min= 2
      "difference from set flow temperature under which boiler starts"                                                                 annotation ( Dialog(group = "OnOff"));

      parameter Modelica.SIunits.Time Fb = 3600
      "Period of time for increased set temperature"                                           annotation ( Dialog(group = "Day/Night Mode"));
      parameter Real FA = 0.2 "Increment for increased set temperature" annotation ( Dialog(group = "Day/Night Mode"));

  protected
    Modelica.Blocks.Tables.CombiTable2D FlowTempNight(table=paramHC.varFlowTempNight)
      "Table for setting the flow temperature during night according to the outside temperature"
      annotation (Placement(transformation(extent={{-49.5,49.5},{-31.5,67.5}})));
    Modelica.Blocks.Tables.CombiTable2D FlowTempDay(table=paramHC.varFlowTempDay)
      "Table for setting the flow temperature druing day according to the outside temperature"
      annotation (Placement(transformation(extent={{-49.5,22.5},{-31.5,40.5}})));
    Modelica.Blocks.Math.UnitConversions.To_degC to_degC
      annotation (Placement(transformation(extent={{-3.75,-3.75},{3.75,3.75}},
          rotation=90,
          origin={-66.75,-8.25})));
  public
    Modelica.Blocks.Logical.Switch switchDayNight
      annotation (Placement(transformation(extent={{-19.5,39},{-3,55.5}})));
  protected
    Modelica.Blocks.Math.UnitConversions.From_degC from_degC
      annotation (Placement(transformation(extent={{66,45},{72,51}})));

  public
    ControllerOnOff                                                   controlerOnOff
      annotation (Placement(transformation(
          extent={{9.75,-9.75},{-9.75,9.75}},
          rotation=90,
          origin={-17.25,-35.25})));
  protected
    Modelica.Blocks.Logical.GreaterThreshold Higher(threshold=Tdelta_Max)
                                   annotation (Placement(transformation(
            extent={{34.5,-27},{19.5,-12}})));
    Modelica.Blocks.Logical.LessThreshold Lower(threshold=-Tdelta_Min)
                                   annotation (Placement(transformation(
            extent={{36,-76.5},{21,-61.5}})));
  protected
    Modelica.Blocks.Math.Feedback Difference
                                           annotation (Placement(
          transformation(extent={{78,-54},{64.5,-40.5}})));

  public
    Modelica.Blocks.Logical.Timer timer
      annotation (Placement(transformation(extent={{-19.5,67.5},{-9,78}})));
    Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=Fb)
      annotation (Placement(transformation(extent={{0,67.5},{10.5,78}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{13.5,79.5},{24,90}})));
  public
    Modelica.Blocks.Logical.Switch switchIncreasedSetTemp
      annotation (Placement(transformation(extent={{30,39},{46.5,55.5}})));
    Modelica.Blocks.Math.Gain Increase(k=1 + FA)
      annotation (Placement(transformation(extent={{7.5,49.5},{18,60}})));
    Modelica.Blocks.Math.Gain NoIncrease(k=1)
      annotation (Placement(transformation(extent={{7.5,34.5},{18,45}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-19.5,81},{-9,91.5}})));
    Modelica.Blocks.Sources.Constant Declination(k=declination)
      annotation (Placement(transformation(extent={{-84,48},{-76.5,55.5}})));
  equation
    if cardinality(isOn) < 2 then
      isOn = true;
    end if;

    connect(Higher.y, controlerOnOff.T_high)             annotation (Line(
        points={{18.75,-19.5},{6,-19.5},{6,-39.735},{-7.5,-39.735}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Lower.y, controlerOnOff.T_low)               annotation (Line(
        points={{20.25,-69},{6,-69},{6,-27.645},{-7.5,-27.645}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Higher.u, Difference.y)      annotation (Line(
        points={{36,-19.5},{63,-19.5},{63,-48},{65.175,-48},{65.175,-47.25}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(timer.y, lessEqualThreshold.u) annotation (Line(
        points={{-8.475,72.75},{-4.2375,72.75},{-4.2375,72.75},{-1.05,72.75}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(lessEqualThreshold.y, and1.u2) annotation (Line(
        points={{11.025,72.75},{12.45,72.75},{12.45,80.55}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(switchDayNight.y, Increase.u) annotation (Line(
        points={{-2.175,47.25},{3,47.25},{3,54.75},{6.45,54.75}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Increase.y, switchIncreasedSetTemp.u1) annotation (Line(
        points={{18.525,54.75},{22.0125,54.75},{22.0125,53.85},{28.35,53.85}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(switchDayNight.y, NoIncrease.u) annotation (Line(
        points={{-2.175,47.25},{3,47.25},{3,39.75},{6.45,39.75}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(NoIncrease.y, switchIncreasedSetTemp.u3) annotation (Line(
        points={{18.525,39.75},{24,39.75},{24,42},{28.35,42},{28.35,40.65}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(and1.y, switchIncreasedSetTemp.u2) annotation (Line(
        points={{24.525,84.75},{30,84.75},{30,75},{21,75},{21,47.25},{28.35,47.25}},
        color={255,0,255},
        smooth=Smooth.None));

    connect(switchIncreasedSetTemp.y, from_degC.u) annotation (Line(
        points={{47.325,47.25},{64.9125,47.25},{64.9125,48},{65.4,48}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(not1.y, timer.u) annotation (Line(
        points={{-8.475,86.25},{-9,79.5},{-27,79.5},{-27,72.75},{-20.55,
            72.75}},
        color={255,0,255},
        smooth=Smooth.None));

    connect(not1.y, and1.u1) annotation (Line(
        points={{-8.475,86.25},{1.7625,86.25},{1.7625,84.75},{12.45,84.75}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(to_degC.y, FlowTempNight.u1) annotation (Line(
        points={{-66.75,-4.125},{-66.75,63.9},{-51.3,63.9}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(to_degC.y, FlowTempDay.u1) annotation (Line(
        points={{-66.75,-4.125},{-66.75,36.9},{-51.3,36.9}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Declination.y, FlowTempNight.u2) annotation (Line(
        points={{-76.125,51.75},{-66,51.75},{-66,53.1},{-51.3,53.1}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Declination.y, FlowTempDay.u2) annotation (Line(
        points={{-76.125,51.75},{-66,51.75},{-66,25.5},{-51.3,25.5},{-51.3,26.1}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(FlowTempNight.y, switchDayNight.u1) annotation (Line(
        points={{-30.6,58.5},{-25.5,58.5},{-25.5,53.85},{-21.15,53.85}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(FlowTempDay.y, switchDayNight.u3) annotation (Line(
        points={{-30.6,31.5},{-25.5,31.5},{-25.5,40.65},{-21.15,40.65}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Difference.u1, Tflow_is) annotation (Line(
        points={{76.65,-47.25},{81,-47.25},{81,-100.5},{75,-100.5}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(from_degC.y, Difference.u2) annotation (Line(
        points={{72.3,48},{81,48},{81,-58.5},{70.5,-58.5},{70.5,-52.65},{71.25,
            -52.65}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(Difference.y, Lower.u) annotation (Line(
        points={{65.175,-47.25},{65.175,-48},{63,-48},{63,-69},{37.5,-69}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(SwitchToNightMode, not1.u) annotation (Line(
        points={{-101.75,49.75},{-87,49.75},{-87,85.5},{-54,85.5},{-54,86.25},{-20.55,
            86.25}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(SwitchToNightMode, switchDayNight.u2) annotation (Line(
        points={{-101.75,49.75},{-87,49.75},{-87,43.5},{-54,43.5},{-54,47.25},{-21.15,
            47.25}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Toutside, to_degC.u) annotation (Line(
        points={{-100,-39},{-67.5,-39},{-67.5,-12.75},{-66.75,-12.75}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(isOn, controlerOnOff.OnOffExtern) annotation (Line(
        points={{-102.75,18.75},{-58.5,18.75},{-58.5,-12},{-15,-12},{-15,-25.5},{-14.715,
            -25.5}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(controlerOnOff.OnOffFinal, isOn_Final) annotation (Line(
        points={{-14.91,-45.39},{-14.91,-66.945},{-15,-66.945},{-15,-99}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(Tflow_set, from_degC.y) annotation (Line(
        points={{102,48},{72.3,48}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1.5,1.5}), graphics={
          Ellipse(
            extent={{4.5,-48},{49.5,-91.5}},
            lineColor={175,175,175},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{4.5,1.5},{49.5,-43.5}},
            lineColor={175,175,175},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-70.5,102},{102,4.5}},
            fillColor={255,170,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None,
            startAngle=0,
            endAngle=360),
          Text(
            extent={{-31.5,21},{49.5,10.5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid,
            textString="Day/Night-Mode"),
          Text(
            extent={{10.5,-31.5},{46.5,-37.5}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5,
            textString="Temp too high"),
          Text(
            extent={{12,-81},{45,-87}},
            lineColor={0,127,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="Temp too low"),
          Ellipse(
            extent={{-31.5,97.5},{36,63}},
            lineColor={0,0,255},
            lineThickness=0.5)}),     Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1.5,1.5}), graphics={
                              Rectangle(
            extent={{-84,85.5},{91.5,-82.5}},
            lineColor={175,175,175},
            lineThickness=0.5,
            fillPattern=FillPattern.Solid,
            fillColor={255,255,170}),
          Text(
            extent={{-79.5,19.5},{82.5,-4.5}},
            lineColor={0,0,0},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
            textString="%name")}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This is a controller model, modelled after the <a href=\"DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day25_Night10\">Vitotronic 200</a>. </p>
<p>This model is derived from <a href=\"HVAC.Components.HeatGenerators.Boiler.BaseClasses.Controller\">HVAC.Components.HeatGenerators.Boiler.BaseClasses.Controller</a>.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The following control decisions are implemented:</p>
<ul>
<li>Switch on/off when the fluid temperature is under/over the set fluid temperature </li>
<li>Heating curve: fluid temperature depending on the outside temperature</li>
<li>Average outside temperature</li>
<li>Increase the set fluid temperature when going to day mode in order to shorten the heating up period </li>
</ul>
</html>",
  revisions="<html>
<p><ul>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>October 12, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
  end ExternalControl_nightDayHC;

model PITemp "PI Controler that can switch the output range of the controler"
  import BaseLib;

  Modelica.Blocks.Interfaces.RealInput set annotation (Placement(
        transformation(
        origin={-80,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  parameter Real h=1 "upper limit controler output"
    annotation (Dialog(group="Control"));
  parameter Real l=0 "lower limit of controler output"
    annotation (Dialog(group="Control"));
  parameter Real KR=1 "Gain" annotation (Dialog(group="Control"));
  parameter Modelica.SIunits.Time TN=1 "Time Constant (T>0 required)"
    annotation (Dialog(group="Control"));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{80,-10},{100,10}}, rotation=
           0), iconTransformation(extent={{80,-10},{100,10}})));
  parameter Modelica.Blocks.Interfaces.BooleanInput RangeSwitch=false
      "Switch controler output range"
    annotation (Placement(transformation(
        origin={80,100},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,90})));
  Modelica.Blocks.Interfaces.BooleanInput isOn "Switches Controler on and off"
                                    annotation (Placement(transformation(
          extent={{-120,-80},{-80,-40}}, rotation=0), iconTransformation(
          extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-40,6},{-20,-14}}, rotation=
           0)));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{56,-18},{76,2}}, rotation=0)));
  Modelica.Blocks.Logical.TriggeredTrapezoid triggeredTrapezoid(rising=0,
      falling=60)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}},
          rotation=0)));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{26,-34},{46,-54}}, rotation=
           0)));
  Modelica.Blocks.Continuous.LimPID PI(
    k=KR,
    initType=Modelica.Blocks.Types.Init.NoInit,
    yMax=if RangeSwitch then -l else h,
    yMin=if RangeSwitch then -h else l,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=TN,
    Td=0.1)  annotation (Placement(transformation(extent={{-16,30},{4,50}},
          rotation=0)));

  Modelica.Blocks.Interfaces.RealInput is
      "Connector of first Real input signal"
                                           annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-60,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-90})));
equation
  connect(isOn, switch1.u2) annotation (Line(points={{-100,-60},{-80,-60},{-80,
          -4},{-42,-4}}, color={255,0,255}));
  connect(switch2.y, y) annotation (Line(points={{77,-8},{79.5,-8},{79.5,0},{
          90,0}},  color={0,0,127}));
  connect(isOn, switch2.u2) annotation (Line(points={{-100,-60},{-80,-60},{-80,
          -30},{-16,-30},{-16,-12},{30,-12},{30,-8},{54,-8}}, color={255,0,255}));
  connect(isOn, triggeredTrapezoid.u) annotation (Line(points={{-100,-60},{-80,
          -60},{-80,-30},{-50,-30},{-50,-50},{-42,-50}}, color={255,0,255}));
  connect(triggeredTrapezoid.y, product.u1) annotation (Line(points={{-19,-50},
          {24,-50}}, color={0,0,127}));
  connect(product.y, switch2.u3) annotation (Line(points={{47,-44},{50,-44},{
          50,-16},{54,-16}}, color={0,0,127}));
  connect(switch1.y, PI.u_m) annotation (Line(points={{-19,-4},{-6,-4},{-6,28}},
        color={0,0,127}));
  connect(PI.y, switch2.u1) annotation (Line(points={{5,40},{24,40},{24,0},{
          54,0}}, color={0,0,127}));
  connect(PI.y, product.u2) annotation (Line(points={{5,40},{14,40},{14,-38},
          {24,-38}}, color={0,0,127}));
  connect(set, PI.u_s)
    annotation (Line(points={{-80,90},{-80,40},{-18,40}}, color={0,0,127}));
  connect(set, switch1.u3) annotation (Line(points={{-80,90},{-80,6},{-42,6},{
          -42,4}}, color={0,0,127}));
  connect(switch1.u1, is) annotation (Line(
      points={{-42,-12},{-64,-12},{-64,-100},{-60,-100}},
      color={0,0,127},
      smooth=Smooth.None));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics),
                       Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Based on a model by Alexander Hoh with some modifications and the Modelica-Standard PI controller. If set to &QUOT;on&QUOT; it will controll the thermal port temperature to the target value (soll). If set to &QUOT;off&QUOT; the controller error will become zero and therefore the current output level of the PI controller will remain constant. When this switching occurs the TriggeredTrapezoid will level the current controller output down to zero in a selectable period of time. </p>
<p>This model is derived from <a href=\"HVAC.Components.Controller.PITemp\">HVAC.Components.Controller.PITemp</a>, but the actual temperature is given via a real input instead of a heat port. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
        revisions="<html>
<ul>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li>
         by Peter Matthes:<br>
         implemented</li>
</ul>
</html> "),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
         graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={135,135,135},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-58,32},{62,-20}},
          lineColor={175,175,175},
          textString="%name")}));
end PITemp;

model ControllerOnOff

  Modelica.Blocks.Interfaces.BooleanInput OnOffExtern annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={-100,0}), iconTransformation(extent={{-112,-38},{-88,-14}})));
  Modelica.Blocks.Interfaces.BooleanInput T_high
      "Medium temperature is too high"
                                     annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={46,-100})));
  Modelica.Blocks.Interfaces.BooleanInput T_low "Medium temperature is too low"
    annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=90,
        origin={-78,-100})));
  Modelica.Blocks.Interfaces.BooleanOutput OnOffFinal annotation (Placement(
        transformation(
        extent={{-11,-10},{11,10}},
        rotation=0,
        origin={99,0}), iconTransformation(extent={{93,-34},{115,-14}})));

  Modelica.Blocks.Logical.And OnOff
    annotation (Placement(transformation(extent={{-12,-8},{4,8}})));

equation
  connect(OnOffExtern, OnOff.u1)
                               annotation (Line(
      points={{-100,0},{-13.6,0}},
      color={255,0,255},
      thickness=0.5,
      smooth=Smooth.None));
  connect(OnOff.y, OnOffFinal)
                             annotation (Line(
      points={{4.8,0},{99,0}},
      color={255,0,255},
      thickness=0.5,
      smooth=Smooth.None));

algorithm
  if T_low then
    OnOff.u2 :=true;
  elseif T_high then
    OnOff.u2 :=false;
  end if;

  annotation (Icon(graphics={Rectangle(
          extent={{-88,22},{92,-90}},
          lineColor={175,175,175},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-82,-12},{88,-52}},
          lineColor={175,175,175},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="Controller")}),       Diagram(graphics),
    Documentation(revisions="<html>
<ul>
  <li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>Mai 23, 2011&nbsp;</i>
         by Ana Constantin:<br>
         Adapted from a model of Kristian Huchtemann.</li>
</ul>
</html>",
info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Swicthes the boiler off if the flow temperature is too high.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>"),
    experiment,
    experimentSetupOutput);
end ControllerOnOff;

end BaseClasses;
