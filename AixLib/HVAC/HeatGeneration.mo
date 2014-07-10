within AixLib.HVAC;
package HeatGeneration "Contains models for heat generation equipment"
  model Boiler "Model of a boiler for space heating"
    import AixLib;

    parameter AixLib.DataBase.Boiler.BoilerEfficiencyBaseDataDefinition
      boilerEfficiencyB=AixLib.DataBase.Boiler.BoilerConst()
      "boiler efficiency as a function of part-load factor"
      annotation (choicesAllMatching=true);

    parameter Modelica.SIunits.Power Q_flow_max = 20000
      "Maximum heat output of boiler at full load";
    parameter Modelica.SIunits.Volume Volume = 0.01
      "Fluid volume inside the heat generation unit";

    extends BaseClasses.PartialHeatGen(volume(V=Volume));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,50})));
    Utilities.HeatDemand   heatDemand
      annotation (Placement(transformation(extent={{-64,60},{-44,80}})));
    Utilities.FuelCounter   fuelCounter
      annotation (Placement(transformation(extent={{80,60},{100,80}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Q_flow_max, uMin=0)
      annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
    Utilities.BoilerEfficiency   boilerEfficiency(
        boilerEfficiencyBE=boilerEfficiencyB)
      annotation (Placement(transformation(extent={{40,60},{60,80}})));
    Modelica.Blocks.Interfaces.RealInput T_set
      annotation (Placement(transformation(extent={{-128,50},{-88,90}})));
  equation
    connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(
        points={{0,40},{0,10}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(T_in.signal, heatDemand.T_in) annotation (Line(
        points={{-70,10},{-70,38},{-60,38},{-60,60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(massFlowSensor.signal, heatDemand.m_flow_in) annotation (Line(
        points={{-40,10},{-40,30},{-52,30},{-52,60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(heatDemand.Q_flow_out, limiter.u) annotation (Line(
        points={{-43.4,70},{-32,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(limiter.y, prescribedHeatFlow.Q_flow) annotation (Line(
        points={{-9,70},{0,70},{0,60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(limiter.y, boilerEfficiency.heatDemand) annotation (Line(
        points={{-9,70},{40,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(boilerEfficiency.fuelUse, fuelCounter.fuel_in) annotation (Line(
        points={{60.6,70},{80,70}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(heatDemand.T_set, T_set) annotation (Line(
        points={{-64,70},{-108,70}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p><br>This basic boiler model calculates the heat demand in order to reach the fluid set temperature. The heat input to the fluid is limited between 0 and the maximum heat output of the boiler. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The idea is to have a very simple heating mechanism, which heats the fluid to a given set temperature using any amount of heat flow between 0 and the boiler&apos;s maximum heat output. As the model should be able to answer interesting questions for the students, one important value is fuel consumption. Therefore the model calculates fuel consumption as the integral of heat intput to the fluid divided by the boiler efficiency. This efficiency part is replaceable and can be either a fixed value or a table with part load efficiencies.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTConst</a></p>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTVar\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTVar</a></p>
</html>",
        revisions="<html>
<p>09.10.2013, Marcus Fuchs</p>
<p><ul>
<li>included the unit&apos;s volume as a parameter</li>
</ul></p>
<p>07.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
      Icon(graphics={
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
            points={{-10.5,-17.5},{-0.5,2.5},{25.5,-17.5},{-0.5,-17.5},{-10.5,
                -17.5}},
            lineColor={255,255,170},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid)}));
  end Boiler;
  extends Modelica.Icons.Package;
  model HeatPump

    Interfaces.Port_a port_a_source
      annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
    Interfaces.Port_b port_b_source
      annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
    Interfaces.Port_a port_a_sink
      annotation (Placement(transformation(extent={{80,-80},{100,-60}})));
    Interfaces.Port_b port_b_sink
      annotation (Placement(transformation(extent={{80,60},{100,80}})));
    Volume.Volume volumeEvaporator(V=VolumeEvaporator)
                                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-50})));
    Volume.Volume volumeCondenser(V=VolumeCondenser)
                                  annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={80,-40})));
    Sensors.TemperatureSensor temperatureSinkOut
                                                annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={80,50})));
    Modelica.Blocks.Interfaces.BooleanInput OnOff annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,80})));
    Sensors.TemperatureSensor temperatureSourceIn
                                                 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,36})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatFlowCondenser
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={56,-40})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow HeatFlowEvaporator
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-56,-50})));
    Modelica.Blocks.Tables.CombiTable2D PowerTable(table=tablePower)
      annotation (Placement(transformation(extent={{-52,20},{-32,40}})));
    Modelica.Blocks.Tables.CombiTable2D HeatFlowCondenserTable(table=
          tableHeatFlowCondenser)
      annotation (Placement(transformation(extent={{-52,-12},{-32,8}})));
    Modelica.Blocks.Logical.Switch SwitchHeatFlowCondenser
      annotation (Placement(transformation(extent={{14,-20},{34,0}})));
    Modelica.Blocks.Sources.Constant constZero2(k=0)
      annotation (Placement(transformation(extent={{-26,-28},{-6,-8}})));
    Modelica.Blocks.Logical.Switch SwitchPower
      annotation (Placement(transformation(extent={{14,12},{34,32}})));
    Modelica.Blocks.Sources.Constant constZero1(k=0)
      annotation (Placement(transformation(extent={{-26,4},{-6,24}})));
    Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
      annotation (Placement(transformation(extent={{10,-60},{-10,-40}})));
    Modelica.Blocks.Interfaces.RealOutput Power
      "Connector of Real output signal" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-90})));
    parameter Modelica.SIunits.Volume VolumeEvaporator=0.01 "Volume im m3";
    parameter Modelica.SIunits.Volume VolumeCondenser=0.01 "Volume im m3";
    parameter Real tablePower[:,:]=fill(
            0.0,
            0,
            2)
      "table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])";
    parameter Real tableHeatFlowCondenser[:,:]=fill(
            0.0,
            0,
            2)
      "table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0,0;0,1])";
    Modelica.Blocks.Math.Gain gain(k=-1)
      annotation (Placement(transformation(extent={{-18,-60},{-38,-40}})));
  equation
    connect(temperatureSourceIn.port_b, volumeEvaporator.port_a)
                                                                annotation (
        Line(
        points={{-80,26},{-80,-40}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volumeEvaporator.port_b, port_b_source) annotation (Line(
        points={{-80,-60},{-80,-70},{-90,-70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(temperatureSourceIn.port_a, port_a_source)
                                                      annotation (Line(
        points={{-80,46},{-80,70},{-90,70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(temperatureSinkOut.port_b, port_b_sink)
                                                   annotation (Line(
        points={{80,60},{80,70},{90,70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(temperatureSinkOut.port_a, volumeCondenser.port_b)
                                                              annotation (
        Line(
        points={{80,40},{80,-30}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volumeCondenser.port_a, port_a_sink) annotation (Line(
        points={{80,-50},{80,-70},{90,-70}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(HeatFlowEvaporator.port, volumeEvaporator.heatPort) annotation (
        Line(
        points={{-66,-50},{-70,-50}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(HeatFlowCondenser.port, volumeCondenser.heatPort) annotation (
        Line(
        points={{66,-40},{70,-40}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(OnOff, SwitchHeatFlowCondenser.u2) annotation (Line(
        points={{0,80},{0,-10},{12,-10}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(HeatFlowCondenserTable.y, SwitchHeatFlowCondenser.u1) annotation (
       Line(
        points={{-31,-2},{12,-2}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(constZero2.y, SwitchHeatFlowCondenser.u3) annotation (Line(
        points={{-5,-18},{12,-18}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(SwitchHeatFlowCondenser.y, HeatFlowCondenser.Q_flow) annotation (
        Line(
        points={{35,-10},{40,-10},{40,-40},{46,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(constZero1.y, SwitchPower.u3) annotation (Line(
        points={{-5,14},{12,14}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(SwitchPower.u2, SwitchHeatFlowCondenser.u2) annotation (Line(
        points={{12,22},{0,22},{0,-10},{12,-10}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(PowerTable.y, SwitchPower.u1) annotation (Line(
        points={{-31,30},{12,30}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(SwitchPower.y, Power) annotation (Line(
        points={{35,22},{38,22},{38,-70},{0,-70},{0,-90}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(SwitchPower.y, feedbackHeatFlowEvaporator.u2)
                                        annotation (Line(
        points={{35,22},{38,22},{38,-70},{0,-70},{0,-58}},
        color={0,0,127},
        smooth=Smooth.None));

    connect(SwitchHeatFlowCondenser.y, feedbackHeatFlowEvaporator.u1)
      annotation (Line(
        points={{35,-10},{40,-10},{40,-50},{8,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, HeatFlowEvaporator.Q_flow) annotation (Line(
        points={{-39,-50},{-46,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.u, feedbackHeatFlowEvaporator.y) annotation (Line(
        points={{-16,-50},{-9,-50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(temperatureSourceIn.signal, PowerTable.u2) annotation (Line(
        points={{-70,36},{-64,36},{-64,24},{-54,24}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(temperatureSourceIn.signal, HeatFlowCondenserTable.u2)
      annotation (Line(
        points={{-70,36},{-64,36},{-64,-8},{-54,-8}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(temperatureSinkOut.signal, PowerTable.u1) annotation (Line(
        points={{70,50},{-60,50},{-60,36},{-54,36}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(temperatureSinkOut.signal, HeatFlowCondenserTable.u1) annotation (
       Line(
        points={{70,50},{-60,50},{-60,4},{-54,4}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,255},
            fillColor={249,249,249},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-80,80},{-60,-80}},
            lineColor={0,0,255},
            fillColor={170,213,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{60,80},{80,-80}},
            lineColor={0,0,255},
            fillColor={255,170,213},
            fillPattern=FillPattern.Solid),
                    Text(
            extent={{-100,20},{100,-20}},
            lineColor={0,0,255},
            textString="%name")}),Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple model of an on/off-controlled heat pump. The refrigerant circuit is a black-box model represented by tables which calculate the electric power and heat flows of the condenser depending on the source and sink temperature. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem\">AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem</a></p>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem2\">AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem2</a></p>
</html>",
        revisions="<html>
<p>25.11.2013, Kristian Huchtemann</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end HeatPump;

  model SolarThermal "Model of a solar thermal panel"
    import AixLib;
    extends BaseClasses.PartialHeatGen;

    parameter Real A = 1 "Area of solar thermal collector in m2";

    parameter AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition
      Collector=AixLib.DataBase.SolarThermal.SimpleAbsorber()
      "Properties of Solar Thermal Collector"
      annotation (choicesAllMatching=true);

    Modelica.Blocks.Interfaces.RealInput T_air "Outdoor air temperature in K"
                                               annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-60,108})));
    Modelica.Blocks.Interfaces.RealInput Irradiation
      "Solar irradiation on a horizontal plane in W/m2"
                                                     annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={10,108})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,34})));
    Utilities.SolarThermalEfficiency solarThermalEfficiency(Collector=Collector)
      annotation (Placement(transformation(extent={{-76,48},{-56,68}})));
    Modelica.Blocks.Math.Max max1
      annotation (Placement(transformation(extent={{-46,40},{-26,60}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{-66,30},{-58,38}})));
    Modelica.Blocks.Math.Gain gain(k=A)
      annotation (Placement(transformation(extent={{-16,44},{-4,56}})));
  equation
    connect(T_in.signal, solarThermalEfficiency.T_col) annotation (Line(
        points={{-70,10},{-70,26},{-71,26},{-71,47.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(T_air, solarThermalEfficiency.T_air) annotation (Line(
        points={{-60,108},{-60,78},{-71,78},{-71,68.6}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(solarThermalEfficiency.G, Irradiation) annotation (Line(
        points={{-65,68.6},{-65,74},{10,74},{10,108}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(
        points={{0,24},{0,10}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(solarThermalEfficiency.Q_flow, max1.u1) annotation (Line(
        points={{-55.2,58},{-52,58},{-52,56},{-48,56}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(const.y, max1.u2) annotation (Line(
        points={{-57.6,34},{-54,34},{-54,44},{-48,44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(max1.y, gain.u) annotation (Line(
        points={{-25,50},{-17.2,50}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(gain.y, prescribedHeatFlow.Q_flow) annotation (Line(
        points={{-3.4,50},{0,50},{0,44}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),      graphics), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p><br>Model of a solar thermal collector. Inputs are outdoor air temperature and solar irradiation. Based on these values and the collector properties from database, this model creates a heat flow to the fluid circuit.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The model maps solar collector efficiency based on the equation</p>
<p><img src=\"modelica://AixLib/Images/equations/equation-vRK5Io7E.png\" alt=\"eta = eta_o - c_1 * deltaT / G - c_2 * deltaT^2/ G\"/></p>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<ul>
<li>Connected directly with Sources.TempAndRad, this model only represents a horizontal collector. There is no calculation for radiation on tilted surfaces. </li>
<li>With the standard BaseParameters, this model uses water as working fluid</li>
</ul>
<p><br><b><font style=\"color: #008000; \">Example Results</font></b></p>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector\">AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector</a></p>
</html>", revisions="<html>
<p>19.11.2013, Marcus Fuchs: implemented</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Rectangle(
            extent={{-80,80},{88,-80}},
            lineColor={255,128,0},
            fillPattern=FillPattern.Solid,
            fillColor={255,128,0}),
          Rectangle(
            extent={{-70,70},{-64,-72}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-70,70},{-40,64}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-40,70},{-46,-72}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-44,-72},{-22,-66}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-4,-72},{22,-66}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{2,70},{-4,-72}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-24,70},{2,64}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-24,70},{-18,-72}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{40,-72},{62,-66}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{44,70},{38,-72}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{18,70},{44,64}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{18,70},{24,-72}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{76,-72},{96,-66}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{82,70},{76,-72}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{56,70},{82,64}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{56,70},{62,-72}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-88,-72},{-64,-66}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end SolarThermal;

  package Utilities "Utility models for heat generation models"
    extends Modelica.Icons.Package;
    model HeatDemand
      "Calculates heat demand to heat m_flow_in from T_in to T_set"

      outer BaseParameters baseParameters "System properties";

      Modelica.Blocks.Interfaces.RealInput T_set
        annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
      Modelica.Blocks.Interfaces.RealInput T_in annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-60,-100})));
      Modelica.Blocks.Interfaces.RealInput m_flow_in annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={20,-100})));
      Modelica.Blocks.Interfaces.RealOutput Q_flow_out
         annotation (Placement(transformation(extent={{96,-10},{116,10}})));
    protected
      parameter Modelica.SIunits.SpecificHeatCapacity cp=baseParameters.cp_Water
        "Specific heat capacity";

    equation
      Q_flow_out = m_flow_in * cp * (T_set - T_in);

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>This control is very simple. Its inputs are a given set temperature T_set, the temperature of the fluid T_in and the mass flow rate of the fluid m_flow_in. The model then calculates which Q_flow would be necessary to heat the fluid to the set temperature by equation </p>
<pre>Q_flow_out&nbsp;=&nbsp;m_flow_in&nbsp;*&nbsp;cp&nbsp;*&nbsp;(T_set&nbsp;-&nbsp;T_in)</pre>
<p>Should T_in &GT; T_set, this would result in a negative Q_flow_out (i.e. a cooling load). A limiter after this model can be used to ensure Q_flow is always &GT;= 0. </p>
</html>",
        revisions="<html>
<p>07.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end HeatDemand;

    model HeatCurve
      "Given a reference temperature, this heat curve calculates a set-point temperature"

      parameter Modelica.SIunits.Temp_C T_fwd_max = 80
        "Maximum forward temperature of the heating system at lowest reference temperature, both in Celcius";
      parameter Modelica.SIunits.Temp_C T_ref_min = -12
        "Lowest reference temperature in Celcius";

      Modelica.Blocks.Interfaces.RealInput T_ref
        annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
      Modelica.Blocks.Interfaces.RealOutput T_set
        annotation (Placement(transformation(extent={{98,-10},{118,10}})));

    protected
      Modelica.SIunits.Temp_C TAtZero
        "T_set of the heat curve at 0 degrees Celcius";

    equation
      TAtZero = (T_fwd_max - 20) * 20 / (20 - T_ref_min);
      T_set = (20 + TAtZero - (T_ref - 273.15) / 20 * TAtZero) + 273.15;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>This model calculates a set-point temperature for the forward flow of a heating system as a funktion of a reference temperature. In most cases this reference temperature will be the outside air temperature.</p>
<p>The heating curve is defined so that a given maximum forward temperature of the heating system is reached at a given lowest design reference temperature. At a reference temperature of 20 &deg;C, the heating curve also reaches 20 &deg;C for the set-point temperature.</p>
</html>",
        revisions="<html>
<p>09.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end HeatCurve;

    model FuelCounter
      "Fuel counter monitoring fuel consumption in a boiler model"
      extends Modelica.Icons.TranslationalSensor;
      Modelica.SIunits.Conversions.NonSIunits.Energy_kWh counter;

      Modelica.Blocks.Interfaces.RealInput fuel_in
        annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));

    equation
      der(counter) = fuel_in/3600/1000;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-76,76},{76,42}},
              lineColor={135,135,135},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid,
              textString="Fuel Counter")}), Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>This fuel counter integrates the actual fuel use to arrive at the overall fuel consumption. </p>
</html>",
        revisions="<html>
<p>09.10.2013, Marcus Fuchs</p>
<p><ul>
<li>corrected error in equation</li>
</ul></p>
<p>07.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented (similar to HVAC.Meter.EEnergyMeter)</li>
</ul></p>
</html>"));
    end FuelCounter;

    model BoilerEfficiency
      "Boiler efficiency as a linear interpolation between table values for a basic boiler model"
      import AixLib;

      parameter AixLib.DataBase.Boiler.BoilerEfficiencyBaseDataDefinition
        boilerEfficiencyBE=AixLib.DataBase.Boiler.BoilerConst()
        "boiler efficiency as a function of part-load factor"
        annotation (choicesAllMatching=true);

      parameter Modelica.SIunits.Power Q_flow_max = 20000
        "Maximum heat output of boiler at full load";

      Modelica.Blocks.Interfaces.RealInput heatDemand
        annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
      Modelica.Blocks.Interfaces.RealOutput fuelUse
        annotation (Placement(transformation(extent={{96,-10},{116,10}})));
      Modelica.Blocks.Math.Division division
        annotation (Placement(transformation(extent={{40,30},{60,50}})));

      Modelica.Blocks.Tables.CombiTable1Ds tableBoilerEff(columns={2}, table=
            boilerEfficiencyBE.boilerEfficiency)
        annotation (Placement(transformation(extent={{0,10},{20,30}})));
      Modelica.Blocks.Math.Division division1
        annotation (Placement(transformation(extent={{-30,-16},{-10,4}})));
      Modelica.Blocks.Sources.Constant const1(k=Q_flow_max)
        annotation (Placement(transformation(extent={{-78,-50},{-58,-30}})));
    equation

      connect(const1.y, division1.u2) annotation (Line(
          points={{-57,-40},{-52,-40},{-52,-12},{-32,-12}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(heatDemand, division1.u1) annotation (Line(
          points={{-100,0},{-32,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(heatDemand, division.u1) annotation (Line(
          points={{-100,0},{-60,0},{-60,46},{38,46}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(division.y, fuelUse) annotation (Line(
          points={{61,40},{74,40},{74,0},{106,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(division1.y, tableBoilerEff.u) annotation (Line(
          points={{-9,-6},{-8,-6},{-8,20},{-2,20}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(tableBoilerEff.y[1], division.u2) annotation (Line(
          points={{21,20},{28,20},{28,34},{38,34}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Documentation(revisions="<html>
<p>09.10.2013, Marcus Fuchs</p>
<p><ul>
<li>Changed table values to be calculated according to a given value of eta at full load operation</li>
</ul></p>
<p>07.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>",
        info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>This boiler efficiency specifies a table for eta at different part load conditions. The values are somewhat similar to the lowest curve in Recknagel, Sprenger 2009 DVD p. 822. This describes a simple boiler (no low temperature operation, no flue gas condensation)</p>
</html>"));
    end BoilerEfficiency;

    model SolarThermalEfficiency
      "Calculates the efficiency of a solar thermal collector"
      import AixLib;

      parameter AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition
        Collector=AixLib.DataBase.SolarThermal.SimpleAbsorber()
        "Properties of Solar Thermal Collector"
        annotation (choicesAllMatching=true);

      Modelica.Blocks.Interfaces.RealInput T_air "Air temperature in K" annotation (
         Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-50,106})));
      Modelica.Blocks.Interfaces.RealInput G "Solar irradiation in W/m2"
        annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={10,106})));
      Modelica.Blocks.Interfaces.RealInput T_col "Collector temperature in K"
        annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-50,-106})));
      Modelica.Blocks.Interfaces.RealOutput Q_flow
        "Useful heat flow from solar collector in W/m2"
        annotation (Placement(transformation(extent={{98,-10},{118,10}})));

    protected
      Real eta "Efficiency of solar thermal collector";
      Modelica.SIunits.TemperatureDifference dT
        "Temperature difference between collector and air in K";

    equation
      dT = T_col - T_air;
      eta = Collector.eta_zero - (Collector.c1 * dT / G) - (Collector.c2 * dT * dT / G);
      Q_flow = G * eta;

      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>Model for the efficiency of a solar thermal collector. Inputs are outdoor air temperature, fluid temperature and solar irradiation. Based on these values and the collector properties from database, this model calculates the heat flow to the fluid circuit. We assume that the fluid temperature is equal to the collector temperature.</p>
</html>", revisions="<html>
<p>19.11.2013, Marcus Fuchs: implemented</p>
</html>"));
    end SolarThermalEfficiency;
  end Utilities;

  package BaseClasses
    "Contains base classes for the modelling of heat generation equipment"
    extends Modelica.Icons.BasesPackage;
    partial model PartialHeatGen
      "Base Class for modelling heat generation equipment of different types"

      outer BaseParameters baseParameters "System properties";

        parameter Modelica.SIunits.Temperature T_ref = baseParameters.T_ref;

      Volume.Volume volume
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Interfaces.Port_a port_a
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.Port_b port_b
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Sensors.TemperatureSensor T_in(T_ref=T_ref)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Sensors.MassFlowSensor massFlowSensor
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    equation
      connect(volume.port_b, port_b) annotation (Line(
          points={{10,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(port_a, T_in.port_a)              annotation (Line(
          points={{-100,0},{-80,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(T_in.port_b, massFlowSensor.port_a) annotation (Line(
          points={{-60,0},{-50,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(massFlowSensor.port_b, volume.port_a) annotation (Line(
          points={{-30,0},{-10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>This partial model is a base class for modelling all heat generation equipment. It includes the necessary fluid port and a fluid volume with a thermal connector for heating the fluid.</p>
<p>This model is just a start and is likely to change in order to be suitable for all heat generation equipment within the lecture.</p>
</html>",     revisions="<html>
<p>27.11.2013, Marcus Fuchs</p>
<p><ul>
<li>removed input for T_set as this is not applicable with solar thermal collectors</li>
</ul></p>
<p>02.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics));
    end PartialHeatGen;

    annotation (Documentation(info="<html>
<p>This package is currently in development. One open question is how many base classes are needed. Is is feasable to have a general base class for all heat generation equipment? And should we extend another base class for each type of equipment like boilers, heat pumps, etc. ? </p>
</html>"));
  end BaseClasses;

  package Examples "Illustrating the use of models from HeatGeneration package"
    extends Modelica.Icons.ExamplesPackage;
    model BoilerSystemTConst
      "Test case for boiler model with constant supply temperature"

      extends Modelica.Icons.Example;

      Pumps.Pump      pumpSimple(Head_max=1)
                                          annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,10})));
      Sources.Boundary_p  staticPressure annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,-10})));
      Pipes.StaticPipe
                 pipe(l=25, D=0.01)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={70,10})));
      Pipes.StaticPipe
                 pipe1(l=25, D=0.01)
                             annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={10,-50})));
      inner BaseParameters      baseParameters
        annotation (Placement(transformation(extent={{80,80},{100,100}})));
      Sensors.MassFlowSensor massFlowSensor
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{0,60},{20,80}})));
      Boiler boiler annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,50})));
      Modelica.Blocks.Sources.Constant const(k=80 + 273.15)
        annotation (Placement(transformation(extent={{-100,26},{-80,46}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{12,-90},{32,-70}})));
      Modelica.Blocks.Sources.Sine sine(
        amplitude=1000,
        startTime=60,
        freqHz=0.0002,
        offset=-1000)
        annotation (Placement(transformation(extent={{-28,-90},{-8,-70}})));
      Volume.Volume volume annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={50,-50})));
      Modelica.Blocks.Sources.BooleanExpression Source_IsNight
        annotation (Placement(transformation(extent={{-96,0},{-76,20}})));
    equation
      connect(staticPressure.port_a, pumpSimple.port_a) annotation (Line(
          points={{-90,-20},{-90,-24},{-50,-24},{-50,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe1.port_b, pumpSimple.port_a) annotation (Line(
          points={{0,-50},{-50,-50},{-50,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(massFlowSensor.port_b, temperatureSensor.port_a) annotation (
          Line(
          points={{-20,70},{0,70}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureSensor.port_b, pipe.port_a) annotation (Line(
          points={{20,70},{70,70},{70,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pumpSimple.port_b, boiler.port_a) annotation (Line(
          points={{-50,20},{-50,40}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boiler.port_b, massFlowSensor.port_a) annotation (Line(
          points={{-50,60},{-50,70},{-40,70}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(const.y, boiler.T_set) annotation (Line(
          points={{-79,36},{-57,36},{-57,39.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(sine.y, prescribedHeatFlow.Q_flow) annotation (Line(
          points={{-7,-80},{12,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pipe.port_b, volume.port_a) annotation (Line(
          points={{70,0},{70,-50},{60,-50}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volume.port_b, pipe1.port_a) annotation (Line(
          points={{40,-50},{20,-50}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(
          points={{32,-80},{50,-80},{50,-60}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Source_IsNight.y, pumpSimple.IsNight) annotation (Line(
          points={{-75,10},{-60.2,10}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
        experiment(StopTime=82800, Interval=60),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>This example models a simple fluid circuit in order to test the boiler model for plausibility</p>
</html>",
        revisions="<html>
<p>07.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end BoilerSystemTConst;

    model BoilerSystemTVar "Test case for boiler model with heating curve"
      import AixLib;

      extends Modelica.Icons.Example;

      Pumps.Pump      pumpSimple(Head_max=1)
                                          annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,10})));
      Sources.Boundary_p  staticPressure annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,-10})));
      Pipes.StaticPipe
                 pipe(l=25, D=0.01)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={70,10})));
      Pipes.StaticPipe
                 pipe1(l=25, D=0.01)
                             annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={10,-50})));
      inner BaseParameters      baseParameters
        annotation (Placement(transformation(extent={{80,80},{100,100}})));
      Sensors.MassFlowSensor massFlowSensor
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{0,60},{20,80}})));
      Boiler boiler(boilerEfficiencyB=AixLib.DataBase.Boiler.BoilerCondensing())
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,50})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{12,-90},{32,-70}})));
      Modelica.Blocks.Sources.Sine sine(
        amplitude=1000,
        startTime=60,
        freqHz=0.0002,
        offset=-1000)
        annotation (Placement(transformation(extent={{-28,-90},{-8,-70}})));
      Volume.Volume volume annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={50,-50})));
      Modelica.Blocks.Sources.BooleanExpression Source_IsNight
        annotation (Placement(transformation(extent={{-96,0},{-76,20}})));
      Utilities.HeatCurve heatCurve
        annotation (Placement(transformation(extent={{-90,26},{-70,46}})));
      Sources.OutdoorTemp outdoorTemp annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-80,82})));
    equation
      connect(staticPressure.port_a, pumpSimple.port_a) annotation (Line(
          points={{-90,-20},{-90,-24},{-50,-24},{-50,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe1.port_b, pumpSimple.port_a) annotation (Line(
          points={{0,-50},{-50,-50},{-50,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(massFlowSensor.port_b, temperatureSensor.port_a) annotation (
          Line(
          points={{-20,70},{0,70}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureSensor.port_b, pipe.port_a) annotation (Line(
          points={{20,70},{70,70},{70,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pumpSimple.port_b, boiler.port_a) annotation (Line(
          points={{-50,20},{-50,40}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boiler.port_b, massFlowSensor.port_a) annotation (Line(
          points={{-50,60},{-50,70},{-40,70}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(sine.y, prescribedHeatFlow.Q_flow) annotation (Line(
          points={{-7,-80},{12,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pipe.port_b, volume.port_a) annotation (Line(
          points={{70,0},{70,-50},{60,-50}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volume.port_b, pipe1.port_a) annotation (Line(
          points={{40,-50},{20,-50}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(
          points={{32,-80},{50,-80},{50,-60}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Source_IsNight.y, pumpSimple.IsNight) annotation (Line(
          points={{-75,10},{-60.2,10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(heatCurve.T_set, boiler.T_set) annotation (Line(
          points={{-69.2,36},{-64,36},{-64,39.2},{-57,39.2}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(outdoorTemp.T_out, heatCurve.T_ref) annotation (Line(
          points={{-80,71.4},{-80,60},{-96,60},{-96,36},{-90,36}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
        experiment(StopTime=82800, Interval=60),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>This example models a simple fluid circuit in order to test the boiler model for plausibility</p>
</html>",
        revisions="<html>
<p>07.10.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
    end BoilerSystemTVar;

    model TestCombiTable2D "Test case for boiler model"

      extends Modelica.Icons.Example;

      Modelica.Blocks.Tables.CombiTable2D HeatFlowCondenserTable(table=[0.0,
            273.15,283.15; 308.15,4800,6300; 328.15,4400,5750])
        annotation (Placement(transformation(extent={{0,40},{20,60}})));
      Modelica.Blocks.Sources.Ramp rampSourceTemp(
        height=20,
        duration=1000,
        offset=-5)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Blocks.Sources.Constant constSinkTemp(k=55)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica.Blocks.Math.UnitConversions.From_degC from_degC
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica.Blocks.Math.UnitConversions.From_degC from_degC1
        annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
    equation
      connect(from_degC.u, rampSourceTemp.y) annotation (Line(
          points={{-42,30},{-59,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(constSinkTemp.y, from_degC1.u) annotation (Line(
          points={{-59,70},{-42,70}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(from_degC.y, HeatFlowCondenserTable.u2) annotation (Line(
          points={{-19,30},{-14,30},{-14,44},{-2,44}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(from_degC1.y, HeatFlowCondenserTable.u1) annotation (Line(
          points={{-19,70},{-14,70},{-14,56},{-2,56}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
        experiment(StopTime=1000, Interval=1),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Example to test the tables used within the HeatPump model</p>
</html>",
        revisions="<html>
<p>25.11.2013, Kristian Huchtemann</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
    end TestCombiTable2D;

    model HeatPumpSystem "Test case for boiler model"
      import AixLib;

      extends Modelica.Icons.Example;

      Pumps.Pump Pump2(Head_max=1)        annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,10})));
      Sources.Boundary_p  staticPressure annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-10,-10})));
      Pipes.StaticPipe
                 pipe(      D=0.01, l=15)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={90,10})));
      Pipes.StaticPipe
                 pipe1(      D=0.01, l=15)
                             annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={30,-50})));
      inner BaseParameters     baseParameters
        annotation (Placement(transformation(extent={{100,80},{120,100}})));
      Sensors.MassFlowSensor massFlowSensor
        annotation (Placement(transformation(extent={{20,60},{40,80}})));
      Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
        prescribedHeatFlow
        annotation (Placement(transformation(extent={{32,-90},{52,-70}})));
      Modelica.Blocks.Sources.Sine sine(
        amplitude=1000,
        startTime=60,
        freqHz=0.0002,
        offset=-1000)
        annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
      Volume.Volume volume annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={70,-50})));
      HeatPump heatPump(tablePower=[0.0,273.15,283.15; 308.15,1100,1150; 328.15,
            1600,1750], tableHeatFlowCondenser=[0.0,273.15,283.15; 308.15,4800,
            6300; 328.15,4400,5750])
        annotation (Placement(transformation(extent={{-18,40},{2,60}})));
      Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=5)
        annotation (Placement(transformation(extent={{-36,74},{-16,94}})));
      Modelica.Blocks.Sources.Constant const(k=273.15 + 40)
        annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
      Pumps.Pump Pump1(MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1(),
          ControlStrategy=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-38,58})));
      Sources.Boundary_ph boundary_ph(h=4184*8)
        annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
      Pipes.StaticPipe
                 pipe2(     D=0.01, l=2)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-64,58})));
      Sources.Boundary_ph boundary_ph1
        annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
      Modelica.Blocks.Sources.BooleanExpression Source_IsNight
        annotation (Placement(transformation(extent={{-102,4},{-82,24}})));
      Utilities.FuelCounter electricityCounter
        annotation (Placement(transformation(extent={{-14,16},{6,36}})));
    equation
      connect(staticPressure.port_a, Pump2.port_a)      annotation (Line(
          points={{-10,-20},{10,-20},{10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe1.port_b, Pump2.port_a)      annotation (Line(
          points={{20,-50},{10,-50},{10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(massFlowSensor.port_b, temperatureSensor.port_a) annotation (
          Line(
          points={{40,70},{60,70}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureSensor.port_b, pipe.port_a) annotation (Line(
          points={{80,70},{90,70},{90,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(sine.y, prescribedHeatFlow.Q_flow) annotation (Line(
          points={{21,-80},{32,-80}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pipe.port_b, volume.port_a) annotation (Line(
          points={{90,0},{90,-50},{80,-50}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(volume.port_b, pipe1.port_a) annotation (Line(
          points={{60,-50},{40,-50}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(prescribedHeatFlow.port, volume.heatPort) annotation (Line(
          points={{52,-80},{70,-80},{70,-60}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(Pump2.port_b, heatPump.port_a_sink)      annotation (Line(
          points={{10,20},{10,43},{1,43}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(heatPump.port_b_sink, massFlowSensor.port_a) annotation (Line(
          points={{1,57},{6,57},{6,56},{10,56},{10,70},{20,70}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(onOffController.y, heatPump.OnOff) annotation (Line(
          points={{-15,84},{-8,84},{-8,58}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(temperatureSensor.signal, onOffController.u) annotation (Line(
          points={{70,80},{70,100},{-46,100},{-46,78},{-38,78}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(const.y, onOffController.reference) annotation (Line(
          points={{-59,90},{-38,90}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boundary_ph.port_a, pipe2.port_a) annotation (Line(
          points={{-80,62},{-78,62},{-78,58},{-74,58}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundary_ph1.port_a, heatPump.port_b_source) annotation (Line(
          points={{-80,34},{-30,34},{-30,42},{-24,42},{-24,43},{-17,43}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe2.port_b, Pump1.port_a)       annotation (Line(
          points={{-54,58},{-48,58}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Pump1.port_b, heatPump.port_a_source)       annotation (Line(
          points={{-28,58},{-20,58},{-20,57},{-17,57}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Source_IsNight.y, Pump2.IsNight) annotation (Line(
          points={{-81,14},{-40,14},{-40,10},{-0.2,10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(Source_IsNight.y, Pump1.IsNight) annotation (Line(
          points={{-81,14},{-68,14},{-68,68.2},{-38,68.2}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(electricityCounter.fuel_in, heatPump.Power) annotation (Line(
          points={{-14,26},{-22,26},{-22,36},{-8,36},{-8,41}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
        experiment(StopTime=10800, Interval=1),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This example models a simple fluid circuit in order to test the heat pump model for plausibility</p>
</html>",
        revisions="<html>
<p>25.11.2013, Kristian Huchtemann</p>
<p><ul>
<li>changed BoilerSystem to HeatPumpSystem</li>
</ul></p>
</html>"),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
    end HeatPumpSystem;

    model HeatPumpSystem2 "Test case for boiler model"
      import AixLib;

      extends Modelica.Icons.Example;

      Pumps.Pump Pump2(
        MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1(),
        ControlStrategy=1,
        Head_max=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,10})));
      Sources.Boundary_p  staticPressure annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-10,-10})));
      Pipes.StaticPipe
                 pipe(      D=0.01, l=15)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={90,10})));
      inner BaseParameters     baseParameters
        annotation (Placement(transformation(extent={{100,80},{120,100}})));
      Sensors.MassFlowSensor massFlowSensor
        annotation (Placement(transformation(extent={{20,60},{40,80}})));
      Sensors.TemperatureSensor temperatureSensor
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      HeatPump heatPump(tablePower=[0.0,273.15,283.15; 308.15,1100,1150; 328.15,
            1600,1750], tableHeatFlowCondenser=[0.0,273.15,283.15; 308.15,4800,
            6300; 328.15,4400,5750])
        annotation (Placement(transformation(extent={{-18,40},{2,60}})));
      Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=5)
        annotation (Placement(transformation(extent={{-36,74},{-16,94}})));
      Pumps.Pump Pump1(MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1(),
          ControlStrategy=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-38,58})));
      Sources.Boundary_ph boundary_ph(h=4184*8)
        annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
      Pipes.StaticPipe
                 pipe2(     D=0.01, l=2)
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-64,58})));
      Sources.Boundary_ph boundary_ph1
        annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
      Modelica.Blocks.Sources.BooleanExpression Source_IsNight
        annotation (Placement(transformation(extent={{-102,4},{-82,24}})));
      Utilities.FuelCounter electricityCounter
        annotation (Placement(transformation(extent={{-14,16},{6,36}})));
      Modelica.Blocks.Sources.Constant Source_Temp(k=273.15 + 20)
        annotation (Placement(transformation(extent={{4,-94},{24,-74}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature AirTemp
        annotation (Placement(transformation(extent={{92,-78},{80,-66}})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature RadTemp
        annotation (Placement(transformation(extent={{42,-78},{54,-66}})));
      Radiators.Radiator radiator(RadiatorType=
            AixLib.DataBase.Radiators.ThermX2_ProfilV_979W()) annotation (
          Placement(transformation(
            extent={{-11,-10},{11,10}},
            rotation=180,
            origin={69,-50})));
      Pipes.StaticPipe
                 pipe1(l=10, D=0.01)
        annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
      Modelica.Blocks.Sources.Constant const(k=273.15 + 55)
        annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
    equation
      connect(staticPressure.port_a, Pump2.port_a)      annotation (Line(
          points={{-10,-20},{10,-20},{10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(massFlowSensor.port_b, temperatureSensor.port_a) annotation (
          Line(
          points={{40,70},{60,70}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperatureSensor.port_b, pipe.port_a) annotation (Line(
          points={{80,70},{90,70},{90,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Pump2.port_b, heatPump.port_a_sink)      annotation (Line(
          points={{10,20},{10,43},{1,43}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(heatPump.port_b_sink, massFlowSensor.port_a) annotation (Line(
          points={{1,57},{6,57},{6,56},{10,56},{10,70},{20,70}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(onOffController.y, heatPump.OnOff) annotation (Line(
          points={{-15,84},{-8,84},{-8,58}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(temperatureSensor.signal, onOffController.u) annotation (Line(
          points={{70,80},{70,100},{-46,100},{-46,78},{-38,78}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boundary_ph.port_a, pipe2.port_a) annotation (Line(
          points={{-80,62},{-78,62},{-78,58},{-74,58}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(boundary_ph1.port_a, heatPump.port_b_source) annotation (Line(
          points={{-80,34},{-30,34},{-30,42},{-24,42},{-24,43},{-17,43}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe2.port_b, Pump1.port_a)       annotation (Line(
          points={{-54,58},{-48,58}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Pump1.port_b, heatPump.port_a_source)       annotation (Line(
          points={{-28,58},{-20,58},{-20,57},{-17,57}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Source_IsNight.y, Pump2.IsNight) annotation (Line(
          points={{-81,14},{-40,14},{-40,10},{-0.2,10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(Source_IsNight.y, Pump1.IsNight) annotation (Line(
          points={{-81,14},{-68,14},{-68,68.2},{-38,68.2}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(electricityCounter.fuel_in, heatPump.Power) annotation (Line(
          points={{-14,26},{-22,26},{-22,36},{-8,36},{-8,41}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_Temp.y,RadTemp. T) annotation (Line(
          points={{25,-84},{38,-84},{38,-72},{40.8,-72}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(Source_Temp.y,AirTemp. T) annotation (Line(
          points={{25,-84},{93.2,-84},{93.2,-72}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pipe1.port_a, radiator.port_b) annotation (Line(
          points={{40,-50},{58.88,-50},{58.88,-50}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe1.port_b, Pump2.port_a) annotation (Line(
          points={{20,-50},{10,-50},{10,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(RadTemp.port, radiator.radPort) annotation (Line(
          points={{54,-72},{64,-72},{64,-57.8},{64.6,-57.8}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(AirTemp.port, radiator.convPort) annotation (Line(
          points={{80,-72},{73.62,-72},{73.62,-57.6}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(const.y, onOffController.reference) annotation (Line(
          points={{-59,90},{-38,90}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(pipe.port_b, radiator.port_a) annotation (Line(
          points={{90,0},{92,0},{92,-50},{79.12,-50}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),      graphics),
        experiment(StopTime=10800, Interval=1),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This example models a simple fluid circuit with a heat pump and a radiator in order to test the heat pump model for plausibility.</p>
</html>",
        revisions="<html>
<p>25.11.2013, Kristian Huchtemann</p>
<p><ul>
<li>changed HeatPumpSystem to new example HeatPumpSystem2 by adding a radiator as heat sink</li>
</ul></p>
</html>"),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
    end HeatPumpSystem2;

    model SolarThermalCollector
      "Example to demonstrate the function of the solar thermal collector model"
      import AixLib;
      extends Modelica.Icons.Example;
      inner BaseParameters     baseParameters
        annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
      Sources.Boundary_ph boundary_ph(
        h=125823,
        use_p_in=false,
        p=100020)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Sources.Boundary_ph boundary_ph1(use_p_in=false)
        annotation (Placement(transformation(extent={{100,-10},{80,10}})));
      Sensors.MassFlowSensor massFlowSensor
        annotation (Placement(transformation(extent={{-54,-10},{-34,10}})));
      Sensors.TemperatureSensor T1
        annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
      SolarThermal solarThermal(A=2, Collector=
            AixLib.DataBase.SolarThermal.VacuumCollector())
        annotation (Placement(transformation(extent={{0,-10},{20,10}})));
      Sources.TempAndRad tempAndRad(temperatureOT=
            AixLib.DataBase.Weather.SummerDay()) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={8,86})));
      Pipes.StaticPipe
                 pipe(l=100)
        annotation (Placement(transformation(extent={{54,-10},{74,10}})));
      Sensors.TemperatureSensor T2
        annotation (Placement(transformation(extent={{28,-10},{48,10}})));
    equation
      connect(boundary_ph.port_a, massFlowSensor.port_a) annotation (Line(
          points={{-60,0},{-54,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(massFlowSensor.port_b, T1.port_a) annotation (Line(
          points={{-34,0},{-28,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(T1.port_b, solarThermal.port_a) annotation (Line(
          points={{-8,0},{0,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(solarThermal.port_b, T2.port_a) annotation (Line(
          points={{20,0},{28,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(T2.port_b, pipe.port_a) annotation (Line(
          points={{48,0},{54,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe.port_b, boundary_ph1.port_a) annotation (Line(
          points={{74,0},{80,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(tempAndRad.Rad, solarThermal.Irradiation) annotation (Line(
          points={{12,75.4},{12,10.8},{11,10.8}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(tempAndRad.T_out, solarThermal.T_air) annotation (Line(
          points={{4,75.4},{4,75.4},{4,10.8}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}),       graphics),
        experiment(StopTime=82600, Interval=3600),
        __Dymola_experimentSetupOutput(events=false),
        Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p><br/>This test demonstrates the solar thermal collector model. Different types of collectors can be tested at fixed boundary conditions. To test the collectors at different fluid temperatures, adjust h at left boundary accordung to this table:</p>
<p>T in &deg;C | h in J/kg</p>
<p>20 | 84007</p>
<p>30 | 125823</p>
<p>40 | 167616</p>
<p>50 | 209418</p>
<p>60 | 251249</p>
<p>70 | 293123</p>
<p>80 | 335055</p>
<p>90 | 377063</p>
<p>(values are according to wolframalpha.com for water at p = 1 atm ) </p>
</html>", revisions="<html>
<p>26.11.2013, Marcus Fuchs</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
    end SolarThermalCollector;
  end Examples;
  annotation (Documentation(info="<html>
<p>This package can contain different heat generation equipment like boilers, heat pumps, solar thermal, and chp units. The package is currently in development</p>
</html>",
        revisions=""));
end HeatGeneration;
