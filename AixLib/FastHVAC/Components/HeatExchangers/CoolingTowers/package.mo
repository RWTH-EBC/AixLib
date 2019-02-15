within AixLib.FastHVAC.Components.HeatExchangers;
package CoolingTowers "This Package contains simple cooling towers for the FastHVAC, e.g. for combination with Chillers"
  model CoolingTowerSimpleTest
    parameter Modelica.SIunits.Temperature TAdiabaticMax = 308.15 "Maximum air temperature where maximum water flow rate occures";
    parameter Modelica.SIunits.Temperature TAdiabaticSwitch = 297.15 "Adiabatic Switch Temperature, Air Temperatures over that";
    parameter Modelica.SIunits.TemperatureDifference TApproach = 2 "Approach Temperature, Difference between water outflow and air inflow temperatures in K";
    parameter Modelica.SIunits.MassFlowRate m_flow_water_min = 3 "Minimum water consumption in adiabatic mode";
    parameter Modelica.SIunits.MassFlowRate m_flow_water_max = 15 "Maximum water consumption in adiabatic mode";

    Modelica.SIunits.MassFlowRate m_flow_water_value;
      AixLib.FastHVAC.Interfaces.EnthalpyPort_a
                                            enthalpyPort_a
      "FastHVAC connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-104,-4},{-96,4}})));
    AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(m_fluid=0.1)
                                                          annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={0,0})));
      AixLib.FastHVAC.Interfaces.EnthalpyPort_b
                                            enthalpyPort_b
      "FastHVAC connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{104,-4},{96,4}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature
      annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=270,
          origin={-1,25})));
    Modelica.Blocks.Interfaces.RealInput TAirDry(min=0, unit="K")
      "Entering air dry or wet bulb temperature"
      annotation (Placement(transformation(extent={{-138,60},{-98,100}})));
    Modelica.Blocks.Interfaces.RealInput TAirWetBulb(min=0, unit="K")
      "Entering air dry or wet bulb temperature"
      annotation (Placement(transformation(extent={{-138,20},{-98,60}})));
    Modelica.Blocks.Logical.Less less
      annotation (Placement(transformation(extent={{-62,50},{-42,70}})));
    Modelica.Blocks.Logical.Switch adiabaticSwitch
      annotation (Placement(transformation(extent={{-20,50},{0,70}})));
    Modelica.Blocks.Math.Add add annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={30,42})));
    Modelica.Blocks.Sources.Constant ApproachTemperatureSource(k=TApproach)
      annotation (Placement(transformation(extent={{80,40},{60,60}})));
    Modelica.Blocks.Sources.Constant AdiabaticSwitchTemperature(k=
          TAdiabaticSwitch)
      "Constant temperature where the cooler switches to adiabatic mode"
      annotation (Placement(transformation(extent={{-92,48},{-84,56}})));
    Modelica.Blocks.Interfaces.RealOutput m_flow_water
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=m_flow_water_value)
      annotation (Placement(transformation(extent={{54,-50},{74,-30}})));
  equation
      if TAirDry >= TAdiabaticMax and not less.y then
      m_flow_water_value = m_flow_water_max;

    elseif not less.y then
      m_flow_water_value = ((m_flow_water_max - m_flow_water_min)/(TAdiabaticMax - TAdiabaticSwitch)) * (TAirDry - TAdiabaticSwitch) + m_flow_water_min;

    else
      m_flow_water_value = 0;

    end if;

    connect(enthalpyPort_a, workingFluid.enthalpyPort_a)
      annotation (Line(points={{-100,0},{-9,0}}, color={176,0,0}));
    connect(workingFluid.enthalpyPort_b, enthalpyPort_b)
      annotation (Line(points={{9,0},{100,0}}, color={176,0,0}));
    connect(prescribedTemperature.port, workingFluid.heatPort)
      annotation (Line(points={{-1,20},{0,20},{0,9.4}}, color={191,0,0}));
    connect(TAirWetBulb, adiabaticSwitch.u3)
      annotation (Line(points={{-118,40},{-22,40},{-22,52}}, color={0,0,127}));
    connect(TAirDry, less.u1) annotation (Line(points={{-118,80},{-74,80},{-74,60},
            {-64,60}}, color={0,0,127}));
    connect(TAirDry, adiabaticSwitch.u1) annotation (Line(points={{-118,80},{-82,80},
            {-82,82},{-36,82},{-36,68},{-22,68}}, color={0,0,127}));
    connect(less.y, adiabaticSwitch.u2)
      annotation (Line(points={{-41,60},{-22,60}}, color={255,0,255}));
    connect(AdiabaticSwitchTemperature.y, less.u2)
      annotation (Line(points={{-83.6,52},{-64,52}}, color={0,0,127}));
    connect(adiabaticSwitch.y, add.u2)
      annotation (Line(points={{1,60},{26.4,60},{26.4,49.2}}, color={0,0,127}));
    connect(add.u1, ApproachTemperatureSource.y) annotation (Line(points={{33.6,49.2},
            {45.8,49.2},{45.8,50},{59,50}}, color={0,0,127}));
    connect(add.y, prescribedTemperature.T) annotation (Line(points={{30,35.4},{30,
            34},{-1,34},{-1,31}}, color={0,0,127}));
    connect(realExpression.y, m_flow_water)
      annotation (Line(points={{75,-40},{110,-40}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      uses(AixLib(version="0.7.4"), Modelica(version="3.2.2")));
  end CoolingTowerSimpleTest;
end CoolingTowers;
