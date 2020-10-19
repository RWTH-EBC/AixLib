within AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop;
model SourcePowerDoubleMvar
  "Open loop supply source with prescribed power feed-in"
  extends BaseClasses.Supplies.OpenLoop.PartialSupplyLessInputs;

  parameter Modelica.SIunits.AbsolutePressure pReturn
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
  final parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
    Medium.specificHeatCapacityCp(sta_default)
    "Specific heat capacity of the fluid";

public
  Sources.MassFlowSource_T         source1(         redeclare package Medium =
        Medium,
    use_m_flow_in=true,
    use_T_in=false,
    T=6 + 273.15,
    nPorts=1)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,0})));
  Modelica.Blocks.Math.Gain gain1(k=-1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-14,-8})));
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
equation

  connect(senT_supply.port_a, source.ports[1])
    annotation (Line(points={{40,0},{28,0}}, color={0,127,255}));
  connect(source1.m_flow_in, gain1.y)
    annotation (Line(points={{-28,-8},{-25,-8}}, color={0,0,127}));
  connect(senT_return.T, deltaT.u1)
    annotation (Line(points={{-70,11},{-86,11},{-86,42}}, color={0,0,127}));
  connect(temperatureSupply.y, deltaT.u2)
    annotation (Line(points={{-51,34},{-74,34},{-74,42}}, color={0,0,127}));
  connect(deltaT.y, gain2.u) annotation (Line(points={{-80,65},{-80,72},{-64,72},
          {-64,72}}, color={0,0,127}));
  connect(gain2.y, heat2massFlow.u2) annotation (Line(points={{-41,72},{-36,72},
          {-36,62},{-6,62}}, color={0,0,127}));
  connect(Q_flow_input, heat2massFlow.u1)
    annotation (Line(points={{0,104},{0,62},{6,62}}, color={0,0,127}));
  connect(heat2massFlow.y, source.m_flow_in)
    annotation (Line(points={{0,39},{0,8},{6,8}}, color={0,0,127}));
  connect(heat2massFlow.y, gain1.u)
    annotation (Line(points={{0,39},{0,16},{0,-8},{-2,-8}}, color={0,0,127}));
  connect(senT_return.port_a, source1.ports[1])
    annotation (Line(points={{-60,0},{-50,0}}, color={0,127,255}));
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
