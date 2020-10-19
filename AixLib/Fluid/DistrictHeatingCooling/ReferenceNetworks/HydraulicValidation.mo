within AixLib.Fluid.DistrictHeatingCooling.ReferenceNetworks;
model HydraulicValidation
  "Network with 2 supplies, 3 sinks, and 1 loop from Larock et al. 2000"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Medium in the network";

  parameter Modelica.SIunits.Pressure pressureReference1 = 201450.8
    "Reference result for pressure at demand node B1";

  parameter Modelica.SIunits.Pressure pressureReference2 = 169453.5
    "Reference result for pressure at demand node B2";

  parameter Modelica.SIunits.Pressure pressureReference3 = 200612.4
    "Reference result for pressure at demand node B3";

  FixedResistances.PressureDrop pipe2(
    redeclare package Medium = Medium,
    m_flow_nominal=29.8378,
    dp_nominal(displayUnit="bar") = 32058.5034) "Pipe 2"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  FixedResistances.PressureDrop pipe1(
    redeclare package Medium = Medium,
    dp_nominal(displayUnit="bar") = 97097.181,
    m_flow_nominal=59.7352) "Pipe 1" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,50})));
  FixedResistances.PressureDrop pipe3(
    redeclare package Medium = Medium,
    m_flow_nominal=12.4528,
    dp_nominal(displayUnit="bar") = 31210.5678) "Pipe 3" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,10})));
  FixedResistances.PressureDrop pipe4(
    redeclare package Medium = Medium,
    m_flow_nominal=1.7144,
    dp_nominal(displayUnit="bar") = 839.9775) "Pipe 4"
    annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
  FixedResistances.PressureDrop pipe5(
    redeclare package Medium = Medium,
    m_flow_nominal=33.2923,
    dp_nominal(displayUnit="bar") = 68038.0678) "Pipe 5"
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Sources.Boundary_pT S1(
    redeclare package Medium = Medium,
    nPorts=1,
    p=298900) "Supply node S1" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,80})));
  Sources.Boundary_pT S2(
    redeclare package Medium = Medium,
    nPorts=1,
    p=269020) "Supply node S2" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-60})));
  Sources.MassFlowSource_T B1(
    redeclare package Medium = Medium,
    m_flow=-28.175,
    nPorts=1) "Demand node B1"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Sources.MassFlowSource_T B2(
    redeclare package Medium = Medium,
    nPorts=2,
    m_flow=-42.213) "Demand node B2" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,62})));
  Sources.MassFlowSource_T B3(
    redeclare package Medium = Medium,
    nPorts=1,
    m_flow=-22.6) "Demand node B3"
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure1(final unit="1")
    "Relative deviation of pressure at demand node B1"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure2(final unit="1")
    "Relative deviation of pressure at demand node B2"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput deviationPressure3(final unit="1")
    "Relative deviation of pressure at demand node B3"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));

equation

  deviationPressure1 = (B1.ports[1].p - pressureReference1)/pressureReference1;
  deviationPressure2 = (B2.ports[1].p - pressureReference2)/pressureReference2;
  deviationPressure3 = (B3.ports[1].p - pressureReference3)/pressureReference3;

  connect(S1.ports[1], pipe1.port_b)
    annotation (Line(points={{-70,70},{-70,60}}, color={0,127,255}));
  connect(pipe2.port_b, B2.ports[1]) annotation (Line(points={{-20,30},{-6,30},{
          12,30},{12,52}}, color={0,127,255}));
  connect(B2.ports[2], pipe3.port_b) annotation (Line(points={{8,52},{12,52},{12,
          30},{30,30},{30,20}}, color={0,127,255}));
  connect(pipe4.port_b, pipe3.port_a) annotation (Line(points={{10,-28},{20,-28},
          {30,-28},{30,0}}, color={0,127,255}));
  connect(pipe4.port_b, pipe5.port_a) annotation (Line(points={{10,-28},{30,-28},
          {30,-60},{50,-60}}, color={0,127,255}));
  connect(pipe5.port_a, B3.ports[1])
    annotation (Line(points={{50,-60},{10,-60}}, color={0,127,255}));
  connect(pipe5.port_b, S2.ports[1])
    annotation (Line(points={{70,-60},{75,-60},{80,-60}}, color={0,127,255}));
  connect(pipe2.port_a, pipe4.port_a) annotation (Line(points={{-40,30},{-70,30},
          {-70,-28},{-10,-28}}, color={0,127,255}));
  connect(B1.ports[1], pipe1.port_a) annotation (Line(points={{-80,30},{-80,30},
          {-70,30},{-70,40}}, color={0,127,255}));
  connect(pipe2.port_a, pipe1.port_a)
    annotation (Line(points={{-40,30},{-70,30},{-70,40}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This example implements Example 4.24 from Larock et al. [2000] as a
  reference network to validate the modeling of static hydraulic
  network examples. The network contains two supply nodes, three demand
  nodes and one pipe loop.
</p>
<p style=\"text-align:center;\">
  <img src=
  \"modelica://AixLib/Resources/Images/Fluid/DistrictHeatingCooling/ReferenceNetworks/HydraulicValidationNetwork.png\"
  alt=\"Network scheme\">
</p>
<h4>
  Assumptions and limitations
</h4>
<p>
  This model is the simplest implementation of the reference network.
  This currently leads to inefficiencies like non-linear systems of
  equations for the initialization problem. Thus, it can serve as a
  reference case for improving efficiencies of similar network models.
</p>
<h4>
  Validation
</h4>
<p>
  Larock et al. [2000] give detailed reference results for this example
  network. For this validation example, the values have been converted
  to SI units.
</p>
<p>
  The supply pressures of S1 and S2 are originally given in feet of
  pressure head and have been converted to pressure in bar:
</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"50%\" summary=
\"Supply pressures\">
  <tr>
    <td></td>
    <td>
      <p>
        S1
      </p>
    </td>
    <td>
      <p>
        S2
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Pressure head [Larock et al., 2000]
      </p>
    </td>
    <td>
      <p>
        100 ft
      </p>
    </td>
    <td>
      <p>
        90 ft
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Prescribed supply pressure
      </p>
    </td>
    <td>
      <p>
        2.9890 bar
      </p>
    </td>
    <td>
      <p>
        2.6902 bar
      </p>
    </td>
  </tr>
</table>
<p>
  The discharges at the demand nodes B1, B2, and B3 were originally
  given in ft**3/s and have been converted to mass flow rates in kg/s
  using the density of 995.586 kg/m**3:
</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"50%\" summary=
\"Discharges\">
  <tr>
    <td></td>
    <td>
      <p>
        B1
      </p>
    </td>
    <td>
      <p>
        B2
      </p>
    </td>
    <td>
      <p>
        B3
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Discharge [Larock et al., 2000]
      </p>
    </td>
    <td>
      <p>
        1.0 ft**3/s
      </p>
    </td>
    <td>
      <p>
        1.5 ft**3/s
      </p>
    </td>
    <td>
      <p>
        0.8 ft**3/s
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Prescribed mass flow rate
      </p>
    </td>
    <td>
      <p>
        28.175 kg/s
      </p>
    </td>
    <td>
      <p>
        42.213 kg/s
      </p>
    </td>
    <td>
      <p>
        22.600 kg/s
      </p>
    </td>
  </tr>
</table>
<p>
  For the pipes, Larock et al. [2000] give an exponential equation to
  calculate the pressure losses as a function of the mass flow rate.
  This model implementation uses the reference results' mass flow rates
  and pressure losses as nominal values in the Pressure Drop model:
</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"50%\" summary=
\"Nominal values\">
  <tr>
    <td></td>
    <td>
      <p>
        1
      </p>
    </td>
    <td>
      <p>
        2
      </p>
    </td>
    <td>
      <p>
        3
      </p>
    </td>
    <td>
      <p>
        4
      </p>
    </td>
    <td>
      <p>
        5
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Nominal mass flow rate im kg/s
      </p>
    </td>
    <td>
      <p>
        59.7352
      </p>
    </td>
    <td>
      <p>
        29.8378
      </p>
    </td>
    <td>
      <p>
        12.4528
      </p>
    </td>
    <td>
      <p>
        1.7144
      </p>
    </td>
    <td>
      <p>
        33.2923
      </p>
    </td>
  </tr>
  <tr>
    <td>
      <p>
        Nominal pressure drop in bar
      </p>
    </td>
    <td>
      <p>
        0.9710 bar
      </p>
    </td>
    <td>
      <p>
        0.3206
      </p>
    </td>
    <td>
      <p>
        0.3121
      </p>
    </td>
    <td>
      <p>
        0.0084
      </p>
    </td>
    <td>
      <p>
        0.6804
      </p>
    </td>
  </tr>
</table>
<p>
  The outputs compare the relative deviations between the calculated
  pressures at the demand nodes B1, B2, and B3 with the reference
  results given in Larock et al. [2000]. The results show deviations
  below 0.3 percent.
</p>
<h4>
  References
</h4>
<ul>
  <li>
    <a href=
    \"https://www.crcpress.com/Hydraulics-of-Pipeline-Systems/Larock-Jeppson-Watters/p/book/9780849318061\">
    Larock, Bruce E., Roland W. Jeppson, and Gary Z. Watters.
    <i>Hydraulics of pipeline systems</i>. Boca Raton, FL: CRC Press,
    2000.</a>
  </li>
  <li>AixLib issue <a href=
  \"https://github.com/RWTH-EBC/AixLib/issues/402\">#402</a>
  </li>
</ul>
<ul>
  <li>May 25, 2017, by Marcus Fuchs:<br/>
    Implemented for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 402</a>.
  </li>
</ul>
</html>"));
end HydraulicValidation;
