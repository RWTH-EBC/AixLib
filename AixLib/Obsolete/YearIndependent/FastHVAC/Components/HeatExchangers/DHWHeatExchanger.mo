within AixLib.Obsolete.YearIndependent.FastHVAC.Components.HeatExchangers;
model DHWHeatExchanger "Counterflow heat exchanger"
extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  /* *******************************************************************
      Medium
     ******************************************************************* */

  parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Standard charastics for water (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);
protected
  parameter Real c_p=medium.c "Heat capacity of medium";
  /* *******************************************************************
  Heat exchanger
      ******************************************************************* */

public
  parameter Modelica.Units.SI.Area A_HE=2 "Area of the heat exchanger ";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer k_HE=1500
    "Thermal transmission coefficient";
  parameter Modelica.Units.SI.Temperature T_inlet_DHW=283.15
    "DHW Temperature at inlet";
  parameter Modelica.Units.SI.Temperature T_set_DHW_ideal=333.15
    "DHW set temperature";
  parameter Integer n(min=3) = 5
    "Number of segments the heat exchanger is separated to";
  parameter Modelica.Units.SI.Mass m_heater=10
    "How much fluid is inside the heat exchanger at the side of the heater";
  parameter Modelica.Units.SI.Mass m_DHW=10
    "How much fluid is inside the heat exchanger at the side of the DHW";
  Modelica.Units.SI.HeatFlowRate dotQ;
  parameter Modelica.Units.SI.Temperature T0=
      Modelica.Units.Conversions.from_degC(20)
    "Initial temperature, in degrees Celsius";

  /* *******************************************************************
      Components
     ******************************************************************* */

  Modelica.Blocks.Interfaces.RealOutput T_DHW( unit="degC")
    "output temperature of domestic hot water"                                           annotation (Placement(
        transformation(extent={{80,-30},{120,10}}),   iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,90})));
  FastHVAC.BaseClasses.WorkingFluid layer_heater[n](
    each medium=medium,
    each m_fluid=m_heater/n,
    each T0=T0) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-54,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor heat_transfer[
    n](each G=k_HE*A_HE/n) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={0,0})));
  FastHVAC.BaseClasses.WorkingFluid layer_dHW[n](
    each medium=medium,
    each m_fluid=m_heater/n,
    each T0=T0) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={52,0})));

  Modelica.Blocks.Interfaces.RealOutput T_return( unit="degC") annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-100,-10}),                          iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,90})));
  Interfaces.EnthalpyPort_a enthalpyPort_heaterIn "flow" annotation (Placement(
        transformation(extent={{-106,18},{-86,38}}), iconTransformation(extent={
            {-106,18},{-86,38}})));
  Interfaces.EnthalpyPort_b enthalpyPort_heaterOut "return" annotation (
      Placement(transformation(extent={{-108,-82},{-88,-62}}),
        iconTransformation(extent={{-108,-82},{-88,-62}})));
  Interfaces.EnthalpyPort_a enthalpyPort_dHWIn "DHW input" annotation (
      Placement(transformation(extent={{68,-82},{88,-62}}), iconTransformation(
          extent={{68,-82},{88,-62}})));
  Interfaces.EnthalpyPort_b enthalpyPort_dHWOut "DHW output" annotation (
      Placement(transformation(extent={{70,18},{90,38}}), iconTransformation(
          extent={{70,18},{90,38}})));
   Modelica.Blocks.Math.UnitConversions.To_degC to_degC
     annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,90})));
   Modelica.Blocks.Math.UnitConversions.To_degC to_degC1
     annotation (Placement(transformation(extent={{20,80},{40,100}})));
equation
  //Heater layers numbered from left to right, DHW layers numbered from right to left (both are numbered from entering to leaving the heat exchanger)

  for k in 1:n loop

    // Connection of neighboring heater and DHW plates
    connect(layer_heater[k].heatPort,heat_transfer [k].port_a);
    connect(layer_dHW[n - k + 1].heatPort,heat_transfer [k].port_b);

    // Connection of enthalpy elements with according layers

  end for;

  for k in 1:(n - 1) loop

    // Connection of neighboring enthalpy elements (heater and DHW side)
    connect(layer_heater[k].enthalpyPort_b, layer_heater[k + 1].enthalpyPort_a);
    connect(layer_dHW[k].enthalpyPort_b,layer_dHW [k + 1].enthalpyPort_a);
  end for;

  //Entering and leaving the heat exchanger

  T_DHW= to_degC1.y;
  to_degC1.u= enthalpyPort_dHWOut.T;
  T_return =to_degC.y;
  to_degC.u= enthalpyPort_heaterOut.T;
  dotQ = sum(heat_transfer.Q_flow);

  connect(layer_heater[1].enthalpyPort_a, enthalpyPort_heaterIn);
  connect(layer_heater[n].enthalpyPort_b, enthalpyPort_heaterOut);
  connect(layer_dHW[1].enthalpyPort_a, enthalpyPort_dHWIn);
  connect(layer_dHW[n].enthalpyPort_b, enthalpyPort_dHWOut);

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{80,100}},
        grid={2,2},
        initialScale=0.1),
        defaultComponentName="dHWHeatExchanger",
                      graphics), Icon(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{80,100}},
        grid={2,2},
        initialScale=0.1),            graphics={Bitmap(extent={{-120,84},{100,-100}},
            fileName="modelica://FastHVAC/Images/Heat-exchanger_final.jpg"),
          Text(
          extent={{-152,-90},{148,-130}},
          textString="%name",
          lineColor={0,0,255})}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a counterflow heat exchanger for two circuits. In the first
  instance this heat exchanger is used to warm domestic hot water.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The heat transfer between the two circuits is based on the model
  <a href=
  \"modelica:/Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">
  ThermalConductor</a>. The fluid inside the heat exchanger (each side
  separately) is represented by the model <a href=
  \"modelica:/Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">HeatCapacitor</a>.
</p>The heat exchanger is discretized in n single layers (min. 3
layers) towards the flow direction at the heater side.
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  <a href=
  \"AixLib.FastHVAC.Examples.HeatExchangers.DHWHeatExchanger.DHWHeatExchanger\">
  DHWHeatExchanger</a>
</p>
</html>",
    revisions="<html><ul>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>January 12, 2015&#160;</i> by Konstantin Finkbeiner:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>December 16, 2014&#160;</i> by Sebastian Stinner:<br/>
    Implemented
  </li>
</ul>
</html> "));
end DHWHeatExchanger;
