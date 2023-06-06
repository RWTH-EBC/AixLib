within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model PlateHeatExchanger

  parameter Modelica.Units.SI.SpecificHeatCapacity c_wat = 4180 "specific heat capacity of water";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.Units.SI.SpecificHeatCapacity c_steel = 920 "specific heat capacity of heat exchanger material";
  parameter Modelica.Units.SI.Density rho_air = 1.2 "Density of air";

  parameter Modelica.Units.SI.Mass m_steel = 3 "mass of heat exchanger";

  parameter Modelica.Units.SI.Area area = 2 "heat exchange surface area";
  parameter Modelica.Units.SI.Length delta = 0.002 "thickness of exchange plate";
  parameter Modelica.Units.SI.ThermalConductivity lambda = 670 "thermal conduction of exchange plate";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_air = 600 "convective heat transfer coefficient";

  parameter Modelica.Units.SI.Temperature T_start = 293.15 "start temperature of plates" annotation(Dialog(tab="Initialization"));

  constant Modelica.Units.SI.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  Modelica.Units.SI.Temperature T_airOutOda_max "maximum outdoor air temperature";

  Modelica.Units.SI.SpecificEnthalpy h_airInOda "specific enthalpy of incoming outdoor air";
  Modelica.Units.SI.SpecificEnthalpy h_airOutOda "specific enthalpy of outgoing outdoor air";
  Modelica.Units.SI.SpecificEnthalpy h_airOutOda_max "maximum specific enthalpy of outgoing outdoor air";
  //Modelica.Units.SI.SpecificEnthalpy h_airOutOda_set "specific enthalpy of set temperature";
  Modelica.Units.SI.SpecificEnthalpy h_airInEta "specific enthalpy of incoming exhaust air";
  Modelica.Units.SI.SpecificEnthalpy h_airOutEta "specific enthalpy of outgoing exhaust air";

  Modelica.Units.SI.HeatFlowRate Q_flow "heat flow";
  Modelica.Units.SI.HeatFlowRate Q_flow_max "max heat flow";
  //Modelica.Units.SI.HeatFlowRate Q_flow_set "heat flow at set temperature";

   replaceable model PartialPressureDrop =
      Components.PressureDrop.BaseClasses.partialPressureDrop annotation(choicesAllMatching=true);

      PartialPressureDrop partialPressureDrop(m_flow = m_flow_airInOda,
      rho = rho_air);

      PartialPressureDrop partialPressureDrop2(m_flow = m_flow_airInEta,
      rho = rho_air);

  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutEta(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of outgoing exhaust air"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-110,-20})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutEta(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,-60},{-120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutEta(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of outgoing exhaust air"
    annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_airInEta(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,60},{100,100}}),
        iconTransformation(extent={{120,70},{100,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airInEta(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,30},{100,70}}),
        iconTransformation(extent={{120,40},{100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airInEta(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of incoming exhaust air"
    annotation (Placement(transformation(extent={{140,0},{100,40}}),
        iconTransformation(extent={{120,10},{100,30}})));

 Modelica.Blocks.Interfaces.RealInput m_flow_airInOda(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of incoming outdoor air" annotation (Placement(
        transformation(extent={{-140,60},{-100,100}}), iconTransformation(
          extent={{-120,70},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airInOda(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of incoming outdoor air"
                                          annotation (Placement(transformation(
          extent={{-140,30},{-100,70}}), iconTransformation(extent={{-120,40},{
            -100,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airInOda(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of incoming outdoor air" annotation (Placement(
        transformation(extent={{-140,0},{-100,40}}), iconTransformation(extent=
            {{-120,10},{-100,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutOda(
    final quantity = "MassFlowRate",
    final unit = "kg/s")
    "mass flow rate of outgoing outdoor air"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutOda(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "temperature of outgoing outdoor air" annotation (Placement(transformation(extent={{100,-60},
            {120,-40}}),        iconTransformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutOda(
    final quantity = "MassFraction",
    final unit = "kg/kg")
    "absolute humidity of outgoing outdoor air" annotation (Placement(transformation(
          extent={{100,-90},{120,-70}}),
                                       iconTransformation(extent={{100,-90},{
            120,-70}})));

Modelica.Blocks.Sources.RealExpression T_airEta(y=(T_airInEta +
        T_airOutEta)/2)
    annotation (Placement(transformation(extent={{-64,4},{-84,24}})));

  Modelica.Thermal.HeatTransfer.Components.Convection convectionEta
                                                                 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-44,-56})));
  Modelica.Blocks.Sources.RealExpression convectiveHeatTransferCoefficientEta(y=k_air*
        area)
    annotation (Placement(transformation(extent={{-94,-66},{-74,-46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperatureEta
    annotation (Placement(transformation(extent={{-84,-42},{-64,-22}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=lambda*
        area/delta)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-12,-54})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=m_steel
        *c_steel, T(start=T_start))
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={34,-28})));
  Modelica.Thermal.HeatTransfer.Components.Convection convectionOda  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-12,-6})));
  Modelica.Blocks.Sources.RealExpression convectiveHeatTransferCoefficientOda(y=k_air*
        area)
    annotation (Placement(transformation(extent={{-66,-16},{-46,4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperatureOda
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Blocks.Sources.RealExpression T_airOda(y=(T_airInOda +
        T_airOutOda_max)/2)
    annotation (Placement(transformation(extent={{8,46},{-12,66}})));

  Modelica.Blocks.Interfaces.RealInput T_set(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "set temperature for outgoing outdoor air" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,110})));
  Modelica.Blocks.Interfaces.RealOutput dp "pressure difference"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=2,
      pre_y_start=true)
    annotation (Placement(transformation(extent={{-52,64},{-32,84}})));
equation

  //mass balances
    m_flow_airInOda - m_flow_airOutOda = 0;
    m_flow_airInEta - m_flow_airOutEta = 0;

  // mass balance moisture
    X_airInOda = X_airOutOda;
    X_airInEta = X_airOutEta;

  //heat flows
    Q_flow_max = -(m_flow_airInOda * h_airInOda - m_flow_airOutOda * h_airOutOda_max);
//     Q_flow_set = -(m_flow_airInOda * h_airInOda - m_flow_airOutOda * h_airOutOda_set);
    if onOffController.y then
      //Q_flow = min(Q_flow_set,Q_flow_max);
      T_airOutOda = min(T_set,T_airOutOda_max);
    else
      T_airOutOda = max(T_set,T_airOutOda_max);
    end if;
    Q_flow = -(m_flow_airInOda * h_airInOda - m_flow_airOutOda * h_airOutOda);
    Q_flow = m_flow_airInEta * h_airInEta - m_flow_airOutEta * h_airOutEta;

    -Q_flow_max = convectionOda.fluid.Q_flow;

   // sepcific enthalpies
    h_airInOda = cp_air * (T_airInOda - 273.15) + X_airInOda * (cp_steam * (T_airInOda - 273.15) + r0);
    h_airOutOda_max = cp_air * (T_airOutOda_max - 273.15) + X_airOutOda * (cp_steam * (T_airOutOda_max - 273.15) + r0);
//     h_airOutOda_set = cp_air * (T_set - 273.15) + X_airOutOda * (cp_steam * (T_set - 273.15) + r0);

    h_airOutOda = cp_air * (T_airOutOda - 273.15) + X_airOutOda * (cp_steam * (T_airOutOda - 273.15) + r0);

    h_airInEta = cp_air * (T_airInEta - 273.15) + X_airInEta * (cp_steam * (T_airInEta - 273.15) + r0);
    h_airOutEta = cp_air * (T_airOutEta - 273.15) + X_airOutEta * (cp_steam * (T_airOutEta - 273.15) + r0);

    partialPressureDrop.dp + partialPressureDrop2.dp = dp;

  connect(convectiveHeatTransferCoefficientEta.y, convectionEta.Gc) annotation (
      Line(points={{-73,-56},{-54,-56}},                     color={0,0,127}));
  connect(T_airEta.y, prescribedTemperatureEta.T) annotation (Line(points={{-85,
          14},{-92,14},{-92,-32},{-86,-32}}, color={0,0,127}));
  connect(prescribedTemperatureEta.port, convectionEta.fluid)
    annotation (Line(points={{-64,-32},{-44,-32},{-44,-46}}, color={191,0,0}));
  connect(thermalConductor.port_a,heatCapacitor.port)
    annotation (Line(points={{-12,-44},{-12,-28},{24,-28}}, color={191,0,0}));
  connect(heatCapacitor.port,convectionOda.solid)
    annotation (Line(points={{24,-28},{-12,-28},{-12,-16}}, color={191,0,0}));
  connect(convectiveHeatTransferCoefficientOda.y,convectionOda.Gc)
    annotation (Line(points={{-45,-6},{-22,-6}}, color={0,0,127}));
  connect(prescribedTemperatureOda.port,convectionOda.fluid)
    annotation (Line(points={{-30,30},{-12,30},{-12,4}}, color={191,0,0}));
  connect(T_airOda.y,prescribedTemperatureOda.T) annotation (Line(points={{-13,56},{
          -60,56},{-60,30},{-52,30}},
                                  color={0,0,127}));

  connect(thermalConductor.port_b, convectionEta.solid) annotation (Line(points=
         {{-12,-64},{-12,-76},{-44,-76},{-44,-66}}, color={191,0,0}));
  connect(T_set, onOffController.reference) annotation (Line(points={{0,110},{0,
          82},{-24,82},{-24,94},{-64,94},{-64,80},{-54,80}}, color={0,0,127}));
  connect(T_airInOda, onOffController.u) annotation (Line(points={{-120,50},{-84,
          50},{-84,68},{-54,68}}, color={0,0,127}));
   annotation (
    preferredView="info",
    Documentation(info="<html><p>
  This model describes an idealized plate heat exchanger. The model
  considers heat convection, thermal conduction and the heat capacity
  of the steel plates.
</p>
<p>
  If the maximum possible temperature at the outlet overshoots the set
  temperature for the supply air, it will be reduced to the set
  temperature for heating case. In summer it will be vice versa.
</p>
<h4>
  Main equations
</h4>
<p>
  The heat flow is described with following equation.:
</p>
<p style=\"text-align:center;\">
  <i>Q̇ = -(ṁ<sub>airInOda</sub> · h<sub>airInOda</sub> -
  ṁ<sub>airOutOda</sub> · h<sub>airOutOda</sub>)=
  ṁ<sub>airInEta</sub> · h<sub>airInEta</sub> - ṁ<sub>airOutEta</sub>
  · h<sub>airOutEta</sub></i>
</p>
</html>", revisions="<html>
<ul>
  <li>May 2019, by Ervin Lejlic:<br/>
    First implementation.
  </li>
  <li>May 2019, by Martin Kremer:<br/>
    Changed variable names for naming convention.
  </li>
  <li>August 2019, by Martin Kremer:<br/>
    Added limitation for temperature at outdoor outlet.
  </li>
</ul>
</html>"),                  Icon(coordinateSystem(preserveAspectRatio=false),
        graphics={
        Rectangle(
          extent={{-100,94},{100,-94}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-100,94},{100,-94}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{98,94},{-100,-92}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{100,92},{-98,-94}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-14,12},{14,-14}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-58,86},{54,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                               Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                 Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PlateHeatExchanger;
