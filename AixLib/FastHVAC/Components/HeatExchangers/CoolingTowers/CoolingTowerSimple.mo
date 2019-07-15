within AixLib.FastHVAC.Components.HeatExchangers.CoolingTowers;
model CoolingTowerSimple

  parameter Modelica.SIunits.TemperatureDifference TApproach = 2 "Approach Temperature, Difference between water outflow and air inflow temperatures in K";

  parameter Modelica.SIunits.Temperature TAdiabaticSwitch = 297.15 "Adiabatic Switch Temperature, Air Temperatures over that";

  parameter Modelica.SIunits.MassFlowRate m_flow_water_min = 3 "Minimum water consumption in adiabatic mode";

  parameter Modelica.SIunits.MassFlowRate m_flow_water_max = 15 "Maximum water consumption in adiabatic mode";

  parameter Modelica.SIunits.Temperature TAdiabaticMax = 308.15 "Maximum air temperature where maximum water flow rate occures";

  Modelica.SIunits.MassFlowRate m_flow_water_value;

  Modelica.Blocks.Interfaces.RealInput TAirDry(min=0, unit="K")
    "Entering air dry or wet bulb temperature"
    annotation (Placement(transformation(extent={{-138,60},{-98,100}})));
  Interfaces.EnthalpyPort_a enthalpyPort_a "hot inflow"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b "cool outflow"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=massFlowRate.dotm)
    annotation (Placement(transformation(extent={{4,-18},{24,2}})));
  Modelica.Blocks.Interfaces.RealInput TAirWetBulb(min=0, unit="K")
    "Entering air dry or wet bulb temperature"
    annotation (Placement(transformation(extent={{-138,20},{-98,60}})));
  Modelica.Blocks.Logical.Switch adiabaticSwitch
    annotation (Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={32,20})));
  Modelica.Blocks.Sources.Constant ApproachTemperatureSource(k=
        TApproach)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-62,50},{-42,70}})));
  Modelica.Blocks.Sources.Constant AdiabaticSwitchTemperature(k=
        TAdiabaticSwitch)
    "Constant temperature where the cooler switches to adiabatic mode"
    annotation (Placement(transformation(extent={{-92,48},{-84,56}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_water
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Sensors.MassFlowSensor massFlowRate
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=m_flow_water_value)
    annotation (Placement(transformation(extent={{56,-50},{76,-30}})));
equation

  if TAirDry >= TAdiabaticMax and not less.y then
    m_flow_water_value = m_flow_water_max;

  elseif not less.y then
    m_flow_water_value = ((m_flow_water_max - m_flow_water_min)/(TAdiabaticMax - TAdiabaticSwitch)) * (TAirDry - TAdiabaticSwitch) + m_flow_water_min;

  else
    m_flow_water_value = 0;

  end if;


  connect(fluidSource.enthalpyPort_b, enthalpyPort_b)
    annotation (Line(points={{66,1},{80,1},{80,0},{100,0}}, color={176,0,0}));
  connect(realExpression1.y, fluidSource.dotm) annotation (Line(points={{25,-8},
          {36,-8},{36,-2.6},{48,-2.6}}, color={0,0,127}));
  connect(add.y, fluidSource.T_fluid)
    annotation (Line(points={{32,13.4},{32,4.2},{48,4.2}}, color={0,0,127}));
  connect(ApproachTemperatureSource.y, add.u1)
    annotation (Line(points={{59,50},{35.6,50},{35.6,27.2}}, color={0,0,127}));
  connect(adiabaticSwitch.y, add.u2)
    annotation (Line(points={{1,60},{28.4,60},{28.4,27.2}}, color={0,0,127}));
  connect(TAirDry, adiabaticSwitch.u1) annotation (Line(points={{-118,80},{-40,80},
          {-40,68},{-22,68}}, color={0,0,127}));
  connect(TAirWetBulb, adiabaticSwitch.u3) annotation (Line(points={{-118,40},{-40,
          40},{-40,52},{-22,52}}, color={0,0,127}));
  connect(less.y, adiabaticSwitch.u2)
    annotation (Line(points={{-41,60},{-22,60}}, color={255,0,255}));
  connect(TAirDry, less.u1) annotation (Line(points={{-118,80},{-80,80},{-80,60},
          {-64,60}}, color={0,0,127}));
  connect(AdiabaticSwitchTemperature.y, less.u2)
    annotation (Line(points={{-83.6,52},{-64,52}}, color={0,0,127}));
  connect(m_flow_water, m_flow_water)
    annotation (Line(points={{110,-40},{110,-40}}, color={0,0,127}));
  connect(enthalpyPort_a, massFlowRate.enthalpyPort_a) annotation (Line(points={
          {-100,0},{-92,0},{-92,-0.1},{-78.8,-0.1}}, color={176,0,0}));
  connect(massFlowRate.enthalpyPort_b, vessel.enthalpyPort_a) annotation (Line(
        points={{-61,-0.1},{-54.5,-0.1},{-54.5,0},{-47,0}}, color={176,0,0}));
  connect(realExpression.y, m_flow_water)
    annotation (Line(points={{77,-40},{110,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-70,60},{70,-60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-101,5},{100,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-4},{100,5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,86},{70,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,41},{-70,38}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-102,5},{99,-5}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-172,44},{-142,6}},
          lineColor={0,0,127},
          textString="TAirDry"),
        Text(
          extent={{-172,100},{-142,62}},
          lineColor={0,0,127},
          textString="TAirWet"),
        Rectangle(
          extent={{-100,81},{-70,78}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CoolingTowerSimple;
