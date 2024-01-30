within AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop;
model SourcePowerDoubleMvar
  "Open loop supply source with prescribed power feed-in"
  extends BaseClasses.Supplies.OpenLoop.PartialSupplyLessInputs;

  parameter Modelica.Units.SI.AbsolutePressure pReturn
    "Fixed return pressure";

  Sources.MassFlowSource_T         source(          redeclare package Medium =
        Medium,
    use_m_flow_in=true,
    use_T_in=false,
    T=6 + 273.15,
    nPorts=1)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={18,0})));

  Modelica.Blocks.Interfaces.RealInput Q_flow_input(unit="W")
    "Prescribed heat flow rate" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,104}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={2,80})));

protected
  final parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
    T=Medium.T_default,
    p=Medium.p_default,
    X=Medium.X_default[1:Medium.nXi]) "Medium state at default properties";
  final parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

public
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-18,-40})));
  Modelica.Blocks.Math.Add deltaT(k2=-1)
    "Differernce of flow and return line temperature in K" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,54})));
  Modelica.Blocks.Sources.Constant temperatureSupply(k=273.15 + 6)
    "Temperature of supply line in °C"
    annotation (Placement(transformation(extent={{-30,24},{-50,44}})));
  Modelica.Blocks.Math.Gain gain2(
                                 k=cp_default)
    annotation (Placement(transformation(extent={{-62,62},{-42,82}})));
  Modelica.Blocks.Math.Division heat2massFlow
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,50})));
  Sources.MassFlowSource_T         source1(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=false,
    T=6 + 273.15,
    nPorts=1)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-56,-40})));
equation

  connect(deltaT.y, gain2.u) annotation (Line(points={{-80,65},{-80,72},{-64,72},
          {-64,72}}, color={0,0,127}));
  connect(source1.m_flow_in, gain1.y) annotation (Line(points={{-44,-32},{-34,
          -32},{-34,-40},{-29,-40}}, color={0,0,127}));
  connect(source1.ports[1], senT_return.port_b) annotation (Line(points={{-66,
          -40},{-70,-40},{-70,-20},{-40,-20},{-40,0},{-60,0}}, color={0,127,255}));
  connect(source.ports[1], senT_supply.port_a)
    annotation (Line(points={{28,0},{40,0}}, color={0,127,255}));
  connect(heat2massFlow.u1, Q_flow_input)
    annotation (Line(points={{6,62},{6,80},{0,80},{0,104}}, color={0,0,127}));
  connect(heat2massFlow.u2, gain2.y)
    annotation (Line(points={{-6,62},{-41,62},{-41,72}}, color={0,0,127}));
  connect(heat2massFlow.y, source.m_flow_in) annotation (Line(points={{
          -1.9984e-15,39},{-1.9984e-15,28},{-8,28},{-8,8},{6,8}}, color={0,0,
          127}));
  connect(gain1.u, source.m_flow_in) annotation (Line(points={{-6,-40},{2,-40},
          {2,0},{-8,0},{-8,8},{6,8}}, color={0,0,127}));
  connect(senT_return.T, deltaT.u1) annotation (Line(points={{-70,11},{-72,11},
          {-72,22},{-86,22},{-86,42}}, color={0,0,127}));
  connect(deltaT.u2, temperatureSupply.y) annotation (Line(points={{-74,42},{
          -74,32},{-51,32},{-51,34}}, color={0,0,127}));
  annotation (Icon(graphics={Ellipse(
          extent={{-78,40},{2,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html><ul>
  <li>March 17, 2018, by Marcus Fuchs:<br/>
    Implemented for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 403</a>.
  </li>
</ul>
</html>", info="<html>
<p>
  This model is a quick draft of a supply model with prescribed heat
  flow rate input. The same resulting mass flow rate is drawn from the
  supply network and fed back into the return network. The substation
  has a variable dT.
</p>
</html>"));
end SourcePowerDoubleMvar;
