within AixLib.HVAC;
package HeatExchanger "Simple heat exchanger models for HVAC applications"
  extends Modelica.Icons.Package;
  model RecuperatorNoMedium
    "recuperator model with selectable flow arrangement"

    parameter Integer flowType = 3 "Flow type" annotation (choices( choice = 1 "counter", choice = 2 "co", choice = 3 "cross", radioButtons = true));

    parameter Modelica.SIunits.Temperature T1in0 = 273.15 + 5
      "Medium 1 inlet temperature at design point";
    parameter Modelica.SIunits.Temperature T1out0 = 296.558
      "Medium 1 inlet temperature at design point";
    parameter Modelica.SIunits.Temperature T2in0 = 273.15 + 26
      "Medium 2 inlet temperature at design point";
    parameter Modelica.SIunits.Temperature T2out0 = 281.0248
      "Medium 2 inlet temperature at design point";
    parameter Modelica.SIunits.MassFlowRate m_flow10 = 0.029949
      "mass flow rate at design point";
    parameter Modelica.SIunits.MassFlowRate m_flow20 = 0.029954
      "mass flow rate at design point";
    final parameter Modelica.SIunits.ThermalConductance C10 = m_flow10*1011
      "Heat capacity flow rate of medium 1 at design point";
    final parameter Modelica.SIunits.ThermalConductance C20 = m_flow20*1011
      "Heat capacity flow rate of medium 2 at design point";

    final parameter Real epsilon0 = C10/min(C10,C20)*(T1out0 - T1in0)/(T2in0 - T1in0)
      "Heat exchanger characterisic in design point";
    final parameter Real Z0 = min(C10, C20) / max(C10, C20)
      "heat capacity flow ratio";

    parameter Real expo = 0.78
      "exponent. h = 7.2 * v^0.78 [W/(m2.K)]. 5 <= v <= 30 m/s. See Jurges 1924.";
    final parameter Real r = (m_flow10 * (T1in0+T1out0)/2 / (m_flow20 * (T2in0+T2out0)/2)) ^expo
      "(hA)10/(hA)20 ";

    Real NTU0(start=6.71699) "Number of transfer units at design point";
    discrete Modelica.SIunits.ThermalConductance UA0
      "U * A value at design condition";

    Real NTU(nominal=7) "Number of transfer units";
    Real epsilon(nominal=epsilon0, start=epsilon0)
      "Heat exchanger characteristic";
    Real Z "Ratio of heat capacity flow rates";
    Modelica.SIunits.Power Q "transfered thermal power";

    Modelica.SIunits.ThermalConductance UA "U * A value";
    Modelica.SIunits.ThermalConductance C1
      "Heat capacity flow rate of medium 1";
    Modelica.SIunits.ThermalConductance C2
      "Heat capacity flow rate of medium 2";

    Modelica.Blocks.Interfaces.RealInput T1in(nominal=T1in0)
      "standard: colder medium"
      annotation (Placement(transformation(extent={{120,60},{80,100}})));
    Modelica.Blocks.Interfaces.RealOutput T1out(nominal=T1out0) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={100,-60})));
    Modelica.Blocks.Interfaces.RealInput T2in(nominal=T2in0)
      "standard: warmer medium"               annotation (Placement(
          transformation(
          extent={{20,20},{-20,-20}},
          rotation=180,
          origin={-100,-80})));
    Modelica.Blocks.Interfaces.RealOutput T2out(nominal=T2out0) annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-100,80})));
    Modelica.Blocks.Interfaces.RealInput m1in(nominal=m_flow10)
      annotation (Placement(transformation(extent={{120,20},{80,60}})));
    Modelica.Blocks.Interfaces.RealInput m2in(nominal=m_flow20) annotation (Placement(
          transformation(
          extent={{20,20},{-20,-20}},
          rotation=180,
          origin={-100,-40})));
  equation
    when initial() then
      UA0 = NTU0*min(C10, C20);
    end when;

    if flowType == 1 then
      NTU0 = if abs(1 - Z0) < Modelica.Constants.eps then epsilon0/(1 - epsilon0) else 1/(
        Z0-1)*log((1 - epsilon0)/(1 - epsilon0*Z0)) "counter-current flow";
    elseif flowType == 2 then
      NTU0 = -(log(-epsilon0 - epsilon0*Z0 + 1)/(Z0 + 1)) "co-current flow";
    else
      exp((exp(-NTU0^0.78*Z0) - 1)/(Z0*NTU0^(-0.22))) = 1 - epsilon0
        "cross flow (no explicit formula available)";
    end if;

    UA = UA0 * (1+r) / ( (m_flow10 * T1in0 / (m1in * T1in)) ^expo + r*(m_flow20 * T2in0 / (m2in * T2in))^expo);
    C1 = m1in*1011;
    C2 = m2in*1011;
    Z = min(C1, C2) / max(C1, C2);

    NTU = UA / min(C1, C2);

    if flowType == 1 then
      epsilon = if abs(1-Z) < Modelica.Constants.eps then 1 / (1 + 1/NTU) else (1 - exp(-NTU * (1-Z)))/(1 - Z * exp(-NTU * (1-Z)))
        "counter-current flow";
    elseif flowType == 2 then
      epsilon = (1 - exp(-NTU * (1+Z)))/(1 + Z) "co-current flow";
    else
      epsilon = 1 - exp((exp(-NTU * Z * NTU^(-0.22)) - 1) / (Z * NTU^(-0.22)))
        "cross flow";
    end if;

    T1out = T1in + epsilon * min(C1, C2)/C1 * (T2in - T1in);

    Q = C1 * (T1out - T1in);

    T2out = T2in - Q/C2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={Polygon(
            points={{-80,80},{-80,-80},{80,80},{-80,80}},
            lineColor={175,175,175},
            smooth=Smooth.None,
            fillColor={255,85,85},
            fillPattern=FillPattern.Solid), Polygon(
            points={{-80,-80},{80,-80},{80,80},{-80,-80}},
            lineColor={175,175,175},
            smooth=Smooth.None,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            textString="%flowType%")}),       Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simple heat exchanger modell based on calculation of the characteristic value for counter current flow, co current flow and cross flow arrangement (Wetter1999).</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Note that the initial values (index 0) will determin the characteristic of the heat exchanger. Think of the initial values as the design point (working point) of the heat exchanger. Changes from this working point will result in a change of heat exchanger efficiency (it&apos;s characteristic). Therefore, you need no geometrical data for this heat exchanger model, just give the condions in a working point you know - all other operating points can be calculated from there. </p>
<p><br>The (U*A)_avg value will be output. It is an assumption that the (UA)_wall value is much smaller than the coefficient of heat transfer on either side of the heat exchanger wall. Therefore, (UA)_wall will not be used in the calaculation of (UA)_avg. Also, heat storage inside the heat exchanger is not considered in this model.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<a href=\"modelica://AixLib.HVAC.HeatExchanger.Examples.NoMedium\">AixLib.HVAC.HeatExchanger.Examples.NoMedium</a>
<p><br><b><font style=\"color: #008000; \">References</font></b> </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p>[Wetter1999]</p></td>
<td><p>Wetter, M.: Simulation Model -- Air-to-Air Plate Heat Exchanger, Techreport, <i>Ernest Orlando Lawrence Berkeley National Laboratory, Berkeley, CA (US), </i><b>1999</b>, URL: <a href=\"http://simulationresearch.lbl.gov/dirpubs/42354.pdf\">http://simulationresearch.lbl.gov/dirpubs/42354.pdf</a></p></td>
</tr>
<tr>
<td><p>[Jurges1924]</p></td>
<td><p>Jurges, W.: Gesundheitsingenieur, Nr. 19. (1) <b>1924</b></p></td>
</tr>
<tr>
<td><p>[McAdams1954]</p></td>
<td><p>McAdams, W. H.: Heat Transmission, 3rd ed., McGraw-Hill, <i>New York</i> <b>1954</b></p></td>
</tr>
</table>
</html>",   revisions="<html>
<p>02.01.2014, Peter Matthes</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end RecuperatorNoMedium;

  partial model RecuperatorNoMediumVarcp
    "recuperator model with selectable flow arrangement and variable cp for integration with media model."

    parameter Integer flowType = 3 "Flow type" annotation (choices( choice = 1 "counter", choice = 2 "co", choice = 3 "cross", radioButtons = true));

    parameter Modelica.SIunits.Temperature T1in0 = 273.15 + 5
      "Medium 1 inlet temperature at design point";
    parameter Modelica.SIunits.Temperature T1out0 = 295.495
      "Medium 1 inlet temperature at design point";
    parameter Modelica.SIunits.Temperature T2in0 = 273.15 + 26
      "Medium 2 inlet temperature at design point";
    parameter Modelica.SIunits.Temperature T2out0 = 282.0586
      "Medium 2 inlet temperature at design point";
    parameter Modelica.SIunits.MassFlowRate m_flow10 = 0.079866
      "mass flow rate at design point";
    parameter Modelica.SIunits.MassFlowRate m_flow20 = 0.079883
      "mass flow rate at design point";
    final parameter Modelica.SIunits.ThermalConductance C10 = m_flow10*1011
      "Heat capacity flow rate of medium 1 at design point";
    final parameter Modelica.SIunits.ThermalConductance C20 = m_flow20*1011
      "Heat capacity flow rate of medium 2 at design point";

    final parameter Real epsilon0 = C10/min(C10,C20)*(T1out0 - T1in0)/(T2in0 - T1in0)
      "Heat exchanger characterisic in design point";
    final parameter Real Z0 = min(C10, C20) / max(C10, C20)
      "heat capacity flow ratio";

    parameter Real expo = 0.78
      "exponent. h = 7.2 * v^0.78 [W/(m2.K)]. 5 <= v <= 30 m/s. See Jurges 1924.";
    final parameter Real r = (m_flow10 * (T1in0+T1out0)/2 / (m_flow20 * (T2in0+T2out0)/2)) ^expo
      "(hA)10/(hA)20 ";

    Real NTU0(start=4.57158) "Number of transfer units at design point";
    discrete Modelica.SIunits.ThermalConductance UA0
      "U * A value at design condition";

    Real NTU(nominal=4.57158) "Number of transfer units";
    Real epsilon(nominal=epsilon0, start=epsilon0)
      "Heat exchanger characteristic";
    Real Z "Ratio of heat capacity flow rates";
    Modelica.SIunits.Power Q "transfered thermal power";

    Modelica.SIunits.ThermalConductance UA "U * A value";
    Modelica.SIunits.ThermalConductance C1
      "Heat capacity flow rate of medium 1";
    Modelica.SIunits.ThermalConductance C2
      "Heat capacity flow rate of medium 2";

    Modelica.SIunits.Temperature T1in(nominal=T1in0) "standard: colder medium";
    Modelica.SIunits.Temperature T1out(nominal=T1out0);
    Modelica.SIunits.Temperature T2in(nominal=T2in0) "standard: warmer medium";
    Modelica.SIunits.Temperature T2out(nominal=T2out0);
    Modelica.SIunits.MassFlowRate m1in(nominal=m_flow10);
    Modelica.SIunits.MassFlowRate m2in(nominal=m_flow20);

    Modelica.SIunits.SpecificHeatCapacity cp1(min=900, max=1300, start=1011, nominal=1011)
      "Specific heat capacity of medium 1. Will be provided by media model";
    Modelica.SIunits.SpecificHeatCapacity cp2(min=900, max=1300, start=1011, nominal=1011)
      "Specific heat capacity of medium 2. Will be provided by media model";

  equation
    when initial() then
      UA0 = NTU0*min(C10, C20);
    end when;

    if flowType == 1 then
      NTU0 = if abs(1 - Z0) < Modelica.Constants.eps then epsilon0/(1 - epsilon0) else 1/(
        Z0-1)*log((1 - epsilon0)/(1 - epsilon0*Z0)) "counter-current flow";
    elseif flowType == 2 then
      NTU0 = -(log(-epsilon0 - epsilon0*Z0 + 1)/(Z0 + 1)) "co-current flow";
    else
      exp((exp(-NTU0^0.78*Z0) - 1)/(Z0*NTU0^(-0.22))) = 1 - epsilon0
        "cross flow (no explicit formula available)";
    end if;

    UA = UA0 * (1+r) / ( (m_flow10 * T1in0 / abs(m1in * T1in)) ^expo + r*(m_flow20 * T2in0 / abs(m2in * T2in))^expo);
    C1 = m1in*cp1;
    C2 = m2in*cp2;
    Z = min(C1, C2) / max(C1, C2);

    NTU = UA / min(C1, C2);

    if flowType == 1 then
      epsilon = if abs(1-Z) < Modelica.Constants.eps then 1 / (1 + 1/NTU) else (1 - exp(-NTU * (1-Z)))/(1 - Z * exp(-NTU * (1-Z)))
        "counter-current flow";
    elseif flowType == 2 then
      epsilon = (1 - exp(-NTU * (1+Z)))/(1 + Z) "co-current flow";
    else
      epsilon = 1 - exp((exp(-NTU * Z * NTU^(-0.22)) - 1) / (Z * NTU^(-0.22)))
        "cross flow";
    end if;

    T1out = T1in + epsilon * min(C1, C2)/C1 * (T2in - T1in);

    Q = C1 * (T1out - T1in);

    T2out = T2in - Q/C2;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={Polygon(
            points={{-80,80},{-80,-80},{80,80},{-80,80}},
            lineColor={175,175,175},
            smooth=Smooth.None,
            fillColor={255,85,85},
            fillPattern=FillPattern.Solid), Polygon(
            points={{-80,-80},{80,-80},{80,80},{-80,-80}},
            lineColor={175,175,175},
            smooth=Smooth.None,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            textString="%flowType%")}),       Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This model will be used as computational core of the heat exchanger model with a medium model. The difference to <a href=\"modelica://AixLib.HVAC.HeatExchanger.RecuperatorNoMedium\">RecuperatorNoMedium</a> is that the specific heat capacities are variable here and the input and output connectors have been replaced by normal variables with the correct unit.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The design point has been increased to a larger mass flow rate.</p>
<p><br><b><font style=\"color: #008000; \">References</font></b> </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p>[Wetter1999]</p></td>
<td><p>Wetter, M.: Simulation Model -- Air-to-Air Plate Heat Exchanger, Techreport, <i>Ernest Orlando Lawrence Berkeley National Laboratory, Berkeley, CA (US), </i><b>1999</b>, URL: <a href=\"http://simulationresearch.lbl.gov/dirpubs/42354.pdf\">http://simulationresearch.lbl.gov/dirpubs/42354.pdf</a></p></td>
</tr>
<tr>
<td><p>[Jurges1924]</p></td>
<td><p>Jurges, W.: Gesundheitsingenieur, Nr. 19. (1) <b>1924</b></p></td>
</tr>
<tr>
<td><p>[McAdams1954]</p></td>
<td><p>McAdams, W. H.: Heat Transmission, 3rd ed., McGraw-Hill, <i>New York</i> <b>1954</b></p></td>
</tr>
</table>
</html>",   revisions="<html>
<p>10.01.2014, Peter Matthes</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics));
  end RecuperatorNoMediumVarcp;

  model Recuperator "recuperator model with selectable flow arrangement"
    extends Interfaces.FourPortMoistAir;
    outer BaseParameters baseParameters "System properties";

    // Pressure loss
    parameter Modelica.SIunits.Area Aflow[2] = {0.193 * 0.300/2, 0.193 * 0.300/2}
      "flow area for media";
    parameter Real zeta[2](each min=0)={2*130/1.225/(400/3600/Aflow[1])^2, 2*130/1.225/(400/3600/Aflow[2])^2}
      "pressure loss coefficients";

    extends RecuperatorNoMediumVarcp;

    Volume.VolumeMoistAir volume1(useTstart=false, V=1e-4)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,0})));
    Sensors.PropertySensorMoistAir sensor1
      annotation (Placement(transformation(extent={{-84,50},{-64,70}})));
    Sensors.PropertySensorMoistAir sensor2
      annotation (Placement(transformation(extent={{84,-70},{64,-50}})));
    Volume.VolumeMoistAir volume2(useTstart=false, V=1e-4)
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=270,
          origin={40,0})));
    BaseClasses.SimpleHeatTransfer simpleHeatTransfer annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,0})));
    Ductwork.PressureLoss pressureLoss1(D=2*sqrt(Aflow[1]/Modelica.Constants.pi),
        zeta=zeta[1])                  annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-40,40})));
    Ductwork.PressureLoss pressureLoss2(D=2*sqrt(Aflow[2]/Modelica.Constants.pi),
        zeta=zeta[2])                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={40,-40})));
    Sensors.PropertySensorMoistAir sensor3
      annotation (Placement(transformation(extent={{60,50},{80,70}})));
  equation
    m1in = port_1a.m_flow "reverse flow not handled yet";
    m2in = port_2a.m_flow;

    T1in = sensor1.Temperature "medium temperature";
    T2in = sensor2.Temperature "medium temperature";
    // T2out = sensor3.Temperature;

    cp1 = baseParameters.cp_Air "constant property";
    cp2 = baseParameters.cp_Air;

    simpleHeatTransfer.Q = Q;

    connect(port_1a, sensor1.portMoistAir_a) annotation (Line(
        points={{-100,60},{-84,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_2a, sensor2.portMoistAir_a) annotation (Line(
        points={{100,-60},{84,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volume1.portMoistAir_b, port_1b) annotation (Line(
        points={{-40,-10},{-40,-60},{-100,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sensor1.portMoistAir_b, pressureLoss1.portMoistAir_a)
                                                                 annotation (Line(
        points={{-64,60},{-40,60},{-40,50}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pressureLoss1.portMoistAir_b, volume1.portMoistAir_a)
                                                                 annotation (Line(
        points={{-40,30},{-40,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sensor2.portMoistAir_b,pressureLoss2. portMoistAir_a) annotation (
        Line(
        points={{64,-60},{40,-60},{40,-50}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pressureLoss2.portMoistAir_b, volume2.portMoistAir_a) annotation (
        Line(
        points={{40,-30},{40,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volume2.portMoistAir_b, sensor3.portMoistAir_a) annotation (Line(
        points={{40,10},{40,60},{60,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(sensor3.portMoistAir_b, port_2b) annotation (Line(
        points={{80,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(volume2.heatPort, simpleHeatTransfer.port_a) annotation (Line(
        points={{30,0},{10,0}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(simpleHeatTransfer.port_b, volume1.heatPort) annotation (Line(
        points={{-10,0},{-30,0}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics={Polygon(
            points={{-80,80},{-80,-80},{80,80},{-80,80}},
            lineColor={175,175,175},
            smooth=Smooth.None,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid), Polygon(
            points={{-80,-80},{80,-80},{80,80},{-80,-80}},
            lineColor={175,175,175},
            smooth=Smooth.None,
            fillColor={255,85,85},
            fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
      Documentation(revisions="<html>
<p>12.01.2014, Peter Matthes</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>",   info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This model extends <a href=\"AixLib.HVAC.HeatExchanger.RecuperatorNoMediumVarcp\">RecuperatorNoMediumVarcp</a> as computational core (heat exchange model). </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>The hydraulic components are taken from other packages to facilitate heat exchange (<a href=\"Volume.VolumeMoistAir\">Volume.VolumeMoistAir</a>), sensors for medium temperature (<a href=\"Sensors.PropertySensorMoistAir\">Sensors.PropertySensorMoistAir</a>) and pressure loss (<a href=\"Ductwork.PressureLoss\">Ductwork.PressureLoss</a>). The necessary inputs for the heat exchange model will be taken from the medium components. The heat transfer from one medium to the other will be calculated by the heat exchange model. The heat flow occurs through the <a href=\"HeatExchanger.BaseClasses.SimpleHeatTransfer\">HeatExchanger.BaseClasses.SimpleHeatTransfer</a> model.</p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<table cellspacing=\"2\" cellpadding=\"0\" border=\"0\"><tr>
<td><p>[Wetter1999]</p></td>
<td><p>Wetter, M.: Simulation Model -- Air-to-Air Plate Heat Exchanger, Techreport, <i>Ernest Orlando Lawrence Berkeley National Laboratory, Berkeley, CA (US), </i><b>1999</b>, URL: <a href=\"http://simulationresearch.lbl.gov/dirpubs/42354.pdf\">http://simulationresearch.lbl.gov/dirpubs/42354.pdf</a></p></td>
</tr>
<tr>
<td><p>[Jurges1924]</p></td>
<td><p>Jurges, W.: Gesundheitsingenieur, Nr. 19. (1) <b>1924</b></p></td>
</tr>
<tr>
<td><p>[McAdams1954]</p></td>
<td><p>McAdams, W. H.: Heat Transmission, 3rd ed., McGraw-Hill, <i>New York</i> <b>1954</b></p><h4><span style=\"color:#008000\">Example Results</span></h4><p><a href=\"modelica://AixLib.HVAC.HeatExchanger.Examples.Medium\">AixLib.HVAC.HeatExchanger.Examples.Medium</a> </p></td>
</tr>
</table>
</html>"));
  end Recuperator;

  package Examples "examples and tests of heat exchanger models"
  extends Modelica.Icons.ExamplesPackage;
    package NoMedium
      "Testing without medium to check heat exchanger priciple first."
      extends Modelica.Icons.ExamplesPackage;

      model Test_RecuperatorNoMedium
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Ramp m1flow(
          duration=1,
          offset=1,
          startTime=1.5,
          height=-0.5)
          annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
        Modelica.Blocks.Sources.Ramp m2flow(
          duration=1,
          offset=1,
          startTime=1.5,
          height=-0.9)
          annotation (Placement(transformation(extent={{66,-20},{46,0}})));
        Modelica.Blocks.Sources.Ramp T1in(
          duration=1,
          offset=273.15 + 5,
          height=10) annotation (Placement(transformation(extent={{66,10},{46,30}})));
        Modelica.Blocks.Sources.Ramp T2in(
          height=0,
          duration=1,
          offset=273.15 + 26)
          annotation (Placement(transformation(extent={{-72,-30},{-52,-10}})));
        RecuperatorNoMedium recuperatorNoMedium1(flowType=1)
          annotation (Placement(transformation(extent={{-10,50},{10,70}})));
        RecuperatorNoMedium recuperatorNoMedium2(flowType=2)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        RecuperatorNoMedium recuperatorNoMedium3(
          T1in0=273.15 + 5,
          T1out0=273.15 + 22.123622,
          T2in0=273.15 + 26,
          m_flow10=0.3,
          m_flow20=0.3,
          NTU0(start=4.3815))
          annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
      equation
        connect(m2flow.y, recuperatorNoMedium3.m1in) annotation (Line(
            points={{45,-10},{26,-10},{26,-56},{10,-56}},
            color={128,0,255},
            smooth=Smooth.None));
        connect(T1in.y, recuperatorNoMedium3.T1in) annotation (Line(
            points={{45,20},{28,20},{28,-52},{10,-52}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(T2in.y, recuperatorNoMedium3.T2in) annotation (Line(
            points={{-51,-20},{-30,-20},{-30,-68},{-10,-68}},
            color={255,85,85},
            smooth=Smooth.None));
        connect(m1flow.y, recuperatorNoMedium3.m2in) annotation (Line(
            points={{-51,10},{-32,10},{-32,-64},{-10,-64}},
            color={0,128,255},
            smooth=Smooth.None));
        connect(T2in.y, recuperatorNoMedium2.T2in) annotation (Line(
            points={{-51,-20},{-30,-20},{-30,-8},{-10,-8}},
            color={255,85,85},
            smooth=Smooth.None));
        connect(m1flow.y, recuperatorNoMedium2.m2in) annotation (Line(
            points={{-51,10},{-32,10},{-32,-4},{-10,-4}},
            color={0,128,255},
            smooth=Smooth.None));
        connect(T2in.y, recuperatorNoMedium1.T2in) annotation (Line(
            points={{-51,-20},{-30,-20},{-30,52},{-10,52}},
            color={255,85,85},
            smooth=Smooth.None));
        connect(m1flow.y, recuperatorNoMedium1.m2in) annotation (Line(
            points={{-51,10},{-32,10},{-32,56},{-10,56}},
            color={0,128,255},
            smooth=Smooth.None));
        connect(T1in.y, recuperatorNoMedium2.T1in) annotation (Line(
            points={{45,20},{28,20},{28,8},{10,8}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(m2flow.y, recuperatorNoMedium2.m1in) annotation (Line(
            points={{45,-10},{26,-10},{26,4},{10,4}},
            color={128,0,255},
            smooth=Smooth.None));
        connect(T1in.y, recuperatorNoMedium1.T1in) annotation (Line(
            points={{45,20},{28,20},{28,68},{10,68}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(m2flow.y, recuperatorNoMedium1.m1in) annotation (Line(
            points={{45,-10},{26,-10},{26,64},{10,64}},
            color={128,0,255},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}), graphics={Text(
                extent={{30,-74},{98,-96}},
                lineColor={135,135,135},
                textString="1: counter-current flow
2: co-current flow
3: cross flow", horizontalAlignment=TextAlignment.Left)}),
          experiment(StopTime=3),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Testing each flow arrangement. </p>
<p>Take care of initial conditions! Parallel flow cannot have an efficiency above 0.5.</p>
</html>"));
      end Test_RecuperatorNoMedium;

      model Test_RecuperatorNoMedium_temperatureSwitch
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Ramp m1flow(
          duration=1,
          offset=1,
          startTime=1.5,
          height=-0.5)
          annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
        Modelica.Blocks.Sources.Ramp m2flow(
          duration=1,
          offset=1,
          startTime=1.5,
          height=-0.9)
          annotation (Placement(transformation(extent={{66,-20},{46,0}})));
        Modelica.Blocks.Sources.Ramp T1in(
          duration=1,
          offset=273.15 + 5,
          height=10) annotation (Placement(transformation(extent={{66,10},{46,30}})));
        Modelica.Blocks.Sources.Ramp T2in(
          height=0,
          duration=1,
          offset=273.15 + 26)
          annotation (Placement(transformation(extent={{-72,-30},{-52,-10}})));
        RecuperatorNoMedium recuperatorNoMedium1(flowType=1)
          annotation (Placement(transformation(extent={{-10,50},{10,70}})));
        RecuperatorNoMedium recuperatorNoMedium2(flowType=3)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        RecuperatorNoMedium recuperatorNoMedium3
          annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
      equation
        connect(m2flow.y, recuperatorNoMedium3.m1in) annotation (Line(
            points={{45,-10},{26,-10},{26,-56},{10,-56}},
            color={128,0,255},
            smooth=Smooth.None));
        connect(T1in.y, recuperatorNoMedium3.T1in) annotation (Line(
            points={{45,20},{28,20},{28,-52},{10,-52}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(T2in.y, recuperatorNoMedium3.T2in) annotation (Line(
            points={{-51,-20},{-30,-20},{-30,-68},{-10,-68}},
            color={255,85,85},
            smooth=Smooth.None));
        connect(m1flow.y, recuperatorNoMedium3.m2in) annotation (Line(
            points={{-51,10},{-32,10},{-32,-64},{-10,-64}},
            color={0,128,255},
            smooth=Smooth.None));
        connect(T2in.y, recuperatorNoMedium2.T2in) annotation (Line(
            points={{-51,-20},{-30,-20},{-30,-8},{-10,-8}},
            color={255,85,85},
            smooth=Smooth.None));
        connect(m1flow.y, recuperatorNoMedium2.m2in) annotation (Line(
            points={{-51,10},{-32,10},{-32,-4},{-10,-4}},
            color={0,128,255},
            smooth=Smooth.None));
        connect(T2in.y, recuperatorNoMedium1.T2in) annotation (Line(
            points={{-51,-20},{-30,-20},{-30,52},{-10,52}},
            color={255,85,85},
            smooth=Smooth.None));
        connect(m1flow.y, recuperatorNoMedium1.m2in) annotation (Line(
            points={{-51,10},{-32,10},{-32,56},{-10,56}},
            color={0,128,255},
            smooth=Smooth.None));
        connect(T1in.y, recuperatorNoMedium2.T1in) annotation (Line(
            points={{45,20},{28,20},{28,8},{10,8}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(m2flow.y, recuperatorNoMedium2.m1in) annotation (Line(
            points={{45,-10},{26,-10},{26,4},{10,4}},
            color={128,0,255},
            smooth=Smooth.None));
        connect(T1in.y, recuperatorNoMedium1.T1in) annotation (Line(
            points={{45,20},{28,20},{28,68},{10,68}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(m2flow.y, recuperatorNoMedium1.m1in) annotation (Line(
            points={{45,-10},{26,-10},{26,64},{10,64}},
            color={128,0,255},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}), graphics={Text(
                extent={{30,-74},{98,-96}},
                lineColor={135,135,135},
                textString="1: counter-current flow
2: co-current flow
3: cross flow", horizontalAlignment=TextAlignment.Left)}),
          experiment(StopTime=3),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Testing the heat exchanger models with changing temperature.</p>
<ol>
<li>Increase of medium 1 temperature (T medium 2 stays constant)</li>
<li>Reduce mass flow rate of both media differently</li>
</ol>
</html>"));
      end Test_RecuperatorNoMedium_temperatureSwitch;

      model Test_RecuperatorNoMedium_crossflow
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Ramp m2flow(
          duration=1,
          startTime=1.5,
          offset=recuperatorNoMedium3.m_flow20,
          height=0.19306019 - 0.053254238)
          annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
        Modelica.Blocks.Sources.Ramp m1flow(
          duration=1,
          startTime=1.5,
          offset=recuperatorNoMedium3.m_flow10,
          height=0.193011111 - 0.0532444444444444)
          annotation (Placement(transformation(extent={{66,-20},{46,0}})));
        Modelica.Blocks.Sources.Ramp T1in(
          duration=1,
          offset=recuperatorNoMedium3.T1in0,
          height=0) annotation (Placement(transformation(extent={{66,10},{46,30}})));
        Modelica.Blocks.Sources.Ramp T2in(
          height=0,
          duration=1,
          offset=recuperatorNoMedium3.T2in0)
          annotation (Placement(transformation(extent={{-72,-30},{-52,-10}})));
        RecuperatorNoMedium recuperatorNoMedium3(
          T1in0=273.15 + 5,
          T2in0=273.15 + 26,
          T1out0=273.15 + 22.76911287,
          m_flow10=0.0532444444444444,
          m_flow20=0.0532542382284563,
          NTU0(start=5.280922181))
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.Ramp T1out_ideal(
          duration=1,
          offset=22.76911287 + 273.15,
          startTime=1.5,
          height=21.44346553 - 22.76911287)
          annotation (Placement(transformation(extent={{-10,-58},{10,-38}})));
        Modelica.Blocks.Math.Add subtract(k2=-1)
          annotation (Placement(transformation(extent={{22,-50},{32,-40}})));
        Modelica.Blocks.Math.Division division
          annotation (Placement(transformation(extent={{44,-50},{54,-40}})));
        Modelica.Blocks.Sources.Ramp T2out_ideal(
          duration=1,
          offset=8.47730010108955 + 273.15,
          startTime=1.5,
          height=9.790807952 - 8.47730010108955)
          annotation (Placement(transformation(extent={{10,40},{-10,60}})));
        Modelica.Blocks.Math.Add subtract2(k1=-1)
          annotation (Placement(transformation(extent={{-22,42},{-32,52}})));
        Modelica.Blocks.Math.Division division2
          annotation (Placement(transformation(extent={{-42,42},{-52,52}})));
      equation
        connect(m1flow.y, recuperatorNoMedium3.m1in) annotation (Line(
            points={{45,-10},{26,-10},{26,4},{10,4}},
            color={128,0,255},
            smooth=Smooth.None));
        connect(T1in.y, recuperatorNoMedium3.T1in) annotation (Line(
            points={{45,20},{28,20},{28,8},{10,8}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(T2in.y, recuperatorNoMedium3.T2in) annotation (Line(
            points={{-51,-20},{-30,-20},{-30,-8},{-10,-8}},
            color={255,85,85},
            smooth=Smooth.None));
        connect(m2flow.y, recuperatorNoMedium3.m2in) annotation (Line(
            points={{-51,10},{-32,10},{-32,-4},{-10,-4}},
            color={0,128,255},
            smooth=Smooth.None));
        connect(recuperatorNoMedium3.T1out, subtract.u1) annotation (Line(
            points={{10,-6},{16,-6},{16,-42},{21,-42}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T1out_ideal.y, subtract.u2) annotation (Line(
            points={{11,-48},{21,-48}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(subtract.y, division.u1) annotation (Line(
            points={{32.5,-45},{37.25,-45},{37.25,-42},{43,-42}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T1out_ideal.y, division.u2) annotation (Line(
            points={{11,-48},{16,-48},{16,-56},{38,-56},{38,-48},{43,-48}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T2out_ideal.y, subtract2.u1) annotation (Line(
            points={{-11,50},{-21,50}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(recuperatorNoMedium3.T2out, subtract2.u2) annotation (Line(
            points={{-10,8},{-16,8},{-16,44},{-21,44}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T2out_ideal.y, division2.u2) annotation (Line(
            points={{-11,50},{-16,50},{-16,60},{-36,60},{-36,44},{-41,44}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(subtract2.y, division2.u1) annotation (Line(
            points={{-32.5,47},{-38.25,47},{-38.25,50},{-41,50}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}), graphics={Text(
                extent={{30,-74},{98,-96}},
                lineColor={135,135,135},
                textString="1: counter-current flow
2: co-current flow
3: cross flow", horizontalAlignment=TextAlignment.Left)}),
          experiment(StopTime=3),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Testing cross flow charakteristic (no explicit formua available). Provide means to compare with manufacturer data. Manufacturer data is stored in files in the Examples package. You can also switch to co-current flow and observe the differences.</p>
</html>"));
      end Test_RecuperatorNoMedium_crossflow;

      model Test_RecuperatorNoMedium_counterflow_switchTemperature
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Ramp m2flow(
          duration=1,
          startTime=1.5,
          offset=recuperatorNoMedium3.m_flow20,
          height=0)
          annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
        Modelica.Blocks.Sources.Ramp m1flow(
          duration=1,
          offset=recuperatorNoMedium3.m_flow10,
          startTime=0,
          height=0)
          annotation (Placement(transformation(extent={{66,-20},{46,0}})));
        Modelica.Blocks.Sources.Ramp T1in(
          duration=1,
          offset=recuperatorNoMedium3.T1in0,
          height=recuperatorNoMedium3.T2in0 - recuperatorNoMedium3.T1in0,
          startTime=0.5)
                    annotation (Placement(transformation(extent={{66,10},{46,30}})));
        Modelica.Blocks.Sources.Ramp T2in(
          duration=1,
          offset=recuperatorNoMedium3.T2in0,
          height=recuperatorNoMedium3.T1in0 - recuperatorNoMedium3.T2in0,
          startTime=2)
          annotation (Placement(transformation(extent={{-72,-30},{-52,-10}})));
        RecuperatorNoMedium recuperatorNoMedium3(
          T1in0=273.15 + 5,
          T2in0=273.15 + 26,
          T1out0=273.15 + 22.76911287,
          m_flow10=0.0532444444444444,
          m_flow20=0.0532542382284563,
          NTU0(start=5.280922181),
          expo=0.55,
          flowType=3)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.Ramp T1out_ideal(
          duration=1,
          offset=22.76911287 + 273.15,
          startTime=1.5,
          height=21.44346553 - 22.76911287)
          annotation (Placement(transformation(extent={{-10,-58},{10,-38}})));
        Modelica.Blocks.Math.Add subtract(k2=-1)
          annotation (Placement(transformation(extent={{22,-50},{32,-40}})));
        Modelica.Blocks.Math.Division division
          annotation (Placement(transformation(extent={{44,-50},{54,-40}})));
        Modelica.Blocks.Sources.Ramp T2out_ideal(
          duration=1,
          offset=8.47730010108955 + 273.15,
          startTime=1.5,
          height=9.790807952 - 8.47730010108955)
          annotation (Placement(transformation(extent={{10,40},{-10,60}})));
        Modelica.Blocks.Math.Add subtract2(k1=-1)
          annotation (Placement(transformation(extent={{-22,42},{-32,52}})));
        Modelica.Blocks.Math.Division division2
          annotation (Placement(transformation(extent={{-42,42},{-52,52}})));
      equation
        connect(m1flow.y, recuperatorNoMedium3.m1in) annotation (Line(
            points={{45,-10},{26,-10},{26,4},{10,4}},
            color={128,0,255},
            smooth=Smooth.None));
        connect(T1in.y, recuperatorNoMedium3.T1in) annotation (Line(
            points={{45,20},{28,20},{28,8},{10,8}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(T2in.y, recuperatorNoMedium3.T2in) annotation (Line(
            points={{-51,-20},{-30,-20},{-30,-8},{-10,-8}},
            color={255,85,85},
            smooth=Smooth.None));
        connect(m2flow.y, recuperatorNoMedium3.m2in) annotation (Line(
            points={{-51,10},{-32,10},{-32,-4},{-10,-4}},
            color={0,128,255},
            smooth=Smooth.None));
        connect(recuperatorNoMedium3.T1out, subtract.u1) annotation (Line(
            points={{10,-6},{16,-6},{16,-42},{21,-42}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T1out_ideal.y, subtract.u2) annotation (Line(
            points={{11,-48},{21,-48}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(subtract.y, division.u1) annotation (Line(
            points={{32.5,-45},{37.25,-45},{37.25,-42},{43,-42}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T1out_ideal.y, division.u2) annotation (Line(
            points={{11,-48},{16,-48},{16,-56},{38,-56},{38,-48},{43,-48}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T2out_ideal.y, subtract2.u1) annotation (Line(
            points={{-11,50},{-21,50}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(recuperatorNoMedium3.T2out, subtract2.u2) annotation (Line(
            points={{-10,8},{-16,8},{-16,44},{-21,44}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T2out_ideal.y, division2.u2) annotation (Line(
            points={{-11,50},{-16,50},{-16,60},{-36,60},{-36,44},{-41,44}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(subtract2.y, division2.u1) annotation (Line(
            points={{-32.5,47},{-38.25,47},{-38.25,50},{-41,50}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}), graphics={Text(
                extent={{30,-74},{98,-96}},
                lineColor={135,135,135},
                textString="1: counter-current flow
2: co-current flow
3: cross flow", horizontalAlignment=TextAlignment.Left)}),
          experiment(StopTime=3.5),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Test the model with the extreme case of temperature difference between the media becomes zero. This kind of test is important for dynamic simulations to understand how the model can be used or improved. No temeprature difference seems to be no problem for the model (in contrast to the case where the mass flow rate will go to zero).</p>
</html>"));
      end Test_RecuperatorNoMedium_counterflow_switchTemperature;

      model Test_RecuperatorNoMedium_counterflow_stopMassFlow
        "Switching is too complicated to take care of for now and practically not needed. So we use the case of stopping the mass flow."
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Ramp m2flow(
          duration=1,
          startTime=1.5,
          offset=recuperatorNoMedium3.m_flow20,
          height=-recuperatorNoMedium3.m_flow20)
          annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
        Modelica.Blocks.Sources.Ramp m1flow(
          duration=1,
          offset=recuperatorNoMedium3.m_flow10,
          startTime=0,
          height=-recuperatorNoMedium3.m_flow10)
          annotation (Placement(transformation(extent={{66,-20},{46,0}})));
        Modelica.Blocks.Sources.Ramp T1in(
          duration=1,
          offset=recuperatorNoMedium3.T1in0,
          startTime=0.5,
          height=0) annotation (Placement(transformation(extent={{66,10},{46,30}})));
        Modelica.Blocks.Sources.Ramp T2in(
          duration=1,
          offset=recuperatorNoMedium3.T2in0,
          startTime=2,
          height=0)
          annotation (Placement(transformation(extent={{-72,-30},{-52,-10}})));
        RecuperatorNoMedium recuperatorNoMedium3(
          T1in0=273.15 + 5,
          T2in0=273.15 + 26,
          T1out0=273.15 + 22.76911287,
          m_flow10=0.0532444444444444,
          m_flow20=0.0532542382284563,
          NTU0(start=5.280922181),
          expo=0.55,
          flowType=3)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.Ramp T1out_ideal(
          duration=1,
          offset=22.76911287 + 273.15,
          startTime=1.5,
          height=21.44346553 - 22.76911287)
          annotation (Placement(transformation(extent={{-10,-58},{10,-38}})));
        Modelica.Blocks.Math.Add subtract(k2=-1)
          annotation (Placement(transformation(extent={{22,-50},{32,-40}})));
        Modelica.Blocks.Math.Division division
          annotation (Placement(transformation(extent={{44,-50},{54,-40}})));
        Modelica.Blocks.Sources.Ramp T2out_ideal(
          duration=1,
          offset=8.47730010108955 + 273.15,
          startTime=1.5,
          height=9.790807952 - 8.47730010108955)
          annotation (Placement(transformation(extent={{10,40},{-10,60}})));
        Modelica.Blocks.Math.Add subtract2(k1=-1)
          annotation (Placement(transformation(extent={{-22,42},{-32,52}})));
        Modelica.Blocks.Math.Division division2
          annotation (Placement(transformation(extent={{-42,42},{-52,52}})));
      equation
        connect(m1flow.y, recuperatorNoMedium3.m1in) annotation (Line(
            points={{45,-10},{26,-10},{26,4},{10,4}},
            color={128,0,255},
            smooth=Smooth.None));
        connect(T1in.y, recuperatorNoMedium3.T1in) annotation (Line(
            points={{45,20},{28,20},{28,8},{10,8}},
            color={0,127,0},
            smooth=Smooth.None));
        connect(T2in.y, recuperatorNoMedium3.T2in) annotation (Line(
            points={{-51,-20},{-30,-20},{-30,-8},{-10,-8}},
            color={255,85,85},
            smooth=Smooth.None));
        connect(m2flow.y, recuperatorNoMedium3.m2in) annotation (Line(
            points={{-51,10},{-32,10},{-32,-4},{-10,-4}},
            color={0,128,255},
            smooth=Smooth.None));
        connect(recuperatorNoMedium3.T1out, subtract.u1) annotation (Line(
            points={{10,-6},{16,-6},{16,-42},{21,-42}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T1out_ideal.y, subtract.u2) annotation (Line(
            points={{11,-48},{21,-48}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(subtract.y, division.u1) annotation (Line(
            points={{32.5,-45},{37.25,-45},{37.25,-42},{43,-42}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T1out_ideal.y, division.u2) annotation (Line(
            points={{11,-48},{16,-48},{16,-56},{38,-56},{38,-48},{43,-48}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T2out_ideal.y, subtract2.u1) annotation (Line(
            points={{-11,50},{-21,50}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(recuperatorNoMedium3.T2out, subtract2.u2) annotation (Line(
            points={{-10,8},{-16,8},{-16,44},{-21,44}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(T2out_ideal.y, division2.u2) annotation (Line(
            points={{-11,50},{-16,50},{-16,60},{-36,60},{-36,44},{-41,44}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(subtract2.y, division2.u1) annotation (Line(
            points={{-32.5,47},{-38.25,47},{-38.25,50},{-41,50}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}}), graphics={Text(
                extent={{30,-74},{98,-96}},
                lineColor={135,135,135},
                textString="1: counter-current flow
2: co-current flow
3: cross flow", horizontalAlignment=TextAlignment.Left)}),
          experiment(StopTime=3.5),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Going to zero with mass flow will lead to singularities in several equations and therefore, the solver will fail at a specific point. To overcome this problem the equations must be switched to non-singular representations at a specific condition or formulated in a different way for the whole range. For the time being the valid variable range (for mass flow rate for example) can be limited to a lower value above zero. In a more advanced model the flow direction of both media streams should be taken care of automatically.</p>
</html>"));
      end Test_RecuperatorNoMedium_counterflow_stopMassFlow;
    end NoMedium;

    package Medium
      extends Modelica.Icons.ExamplesPackage;
      model SingleHX_mflow
        "Testing single HX model changing the mass flow rate"
        import Anlagensimulation_WS1314 = AixLib.HVAC;
      extends Modelica.Icons.Example;
        Sources.BoundaryMoistAir_phX Medium1out(
          use_p_in=false,
          X=0,
          p=101325)   annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={-60,-20})));
        inner Anlagensimulation_WS1314.BaseParameters
                                  baseParameters
          annotation (Placement(transformation(extent={{60,66},{80,86}})));
        Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium1in(
          m=0.075,
          X=0,
          use_m_in=true,
          h=5.03e3)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-60,20})));
        Anlagensimulation_WS1314.HeatExchanger.Recuperator HX(flowType=1)
          annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
        Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium2in(
          m=0.075,
          X=0,
          use_m_in=true,
          h=26.13e3)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={62,-20})));
        Sources.BoundaryMoistAir_phX Medium2out(
          use_p_in=false,
          X=0,
          p=101325)   annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={60,20})));
        Modelica.Blocks.Sources.Ramp mflow(
          duration=1,
          startTime=1,
          height=0.01 - HX.m_flow10,
          offset=HX.m_flow10)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      equation

        connect(Medium2in.portMoistAir_a, HX.port_2a) annotation (Line(
            points={{52,-20},{36,-20},{36,-12},{20,-12}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HX.port_2b, Medium2out.portMoistAir_a) annotation (Line(
            points={{20,12},{36,12},{36,20},{50,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(Medium1in.portMoistAir_a, HX.port_1a) annotation (Line(
            points={{-50,20},{-36,20},{-36,12},{-20,12}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HX.port_1b, Medium1out.portMoistAir_a) annotation (Line(
            points={{-20,-12},{-36,-12},{-36,-20},{-50,-20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(mflow.y, Medium1in.m_in) annotation (Line(
            points={{-79,50},{-72,50},{-72,28}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(mflow.y, Medium2in.m_in) annotation (Line(
            points={{-79,50},{74,50},{74,-12}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),      graphics),
         Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A small example of an heat exchanger with varying mass flow rate of both media.</p>
</html>",   revisions="<html>
<p>12.01.2014, Peter Matthes</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),experiment(StopTime=3),
          __Dymola_experimentSetupOutput);
      end SingleHX_mflow;

      model SingleHX_Temperature "Changing outdoor air temperature"
        import Anlagensimulation_WS1314 = AixLib.HVAC;
      extends Modelica.Icons.Example;
        Sources.BoundaryMoistAir_phX Medium1out(
          use_p_in=false,
          X=0,
          p=101325)   annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={-60,-20})));
        inner Anlagensimulation_WS1314.BaseParameters
                                  baseParameters
          annotation (Placement(transformation(extent={{60,66},{80,86}})));
        Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium1in(
          X=0,
          h=5.03e3,
          m=0.07987,
          use_m_in=false,
          use_h_in=true)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-60,20})));
        Anlagensimulation_WS1314.HeatExchanger.Recuperator HX(flowType=1)
          annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
        Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium2in(
          X=0,
          h=26.13e3,
          use_m_in=false,
          m=0.07987)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={62,-20})));
        Sources.BoundaryMoistAir_phX Medium2out(
          use_p_in=false,
          X=0,
          p=101325)   annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={60,20})));
        Modelica.Blocks.Sources.Ramp Toda(
          duration=1,
          startTime=1,
          height=20e3,
          offset=5.03e3) "outdoor air temperature"
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      equation

        connect(Medium2in.portMoistAir_a, HX.port_2a) annotation (Line(
            points={{52,-20},{36,-20},{36,-12},{20,-12}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HX.port_2b, Medium2out.portMoistAir_a) annotation (Line(
            points={{20,12},{36,12},{36,20},{50,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(Medium1in.portMoistAir_a, HX.port_1a) annotation (Line(
            points={{-50,20},{-36,20},{-36,12},{-20,12}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HX.port_1b, Medium1out.portMoistAir_a) annotation (Line(
            points={{-20,-12},{-36,-12},{-36,-20},{-50,-20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(Toda.y, Medium1in.h_in) annotation (Line(
            points={{-79,50},{-76,50},{-76,20},{-72,20}},
            color={0,0,127},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),      graphics),
         Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A small example of an heat exchanger with varying temperature of the cold medium.</p>
</html>",   revisions="<html>
<p>12.01.2014, Peter Matthes</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),experiment(StopTime=3),
          __Dymola_experimentSetupOutput);
      end SingleHX_Temperature;

      model DoubleHX_mflow
        "Testing double HX configuration and changing the mass flow rate"
        import Anlagensimulation_WS1314 = AixLib.HVAC;
      extends Modelica.Icons.Example;
        Sources.BoundaryMoistAir_phX Medium1out(
          use_p_in=false,
          X=0,
          p=101325,
          h=25e3)     annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={-60,-40})));
        inner Anlagensimulation_WS1314.BaseParameters
                                  baseParameters
          annotation (Placement(transformation(extent={{60,66},{80,86}})));
        Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium1in(
          m=0.075,
          X=0,
          use_m_in=true,
          h=5.03e3)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-60,20})));
        Anlagensimulation_WS1314.HeatExchanger.Recuperator HX(flowType=1,
          pressureLoss1(dp(start=40)),
          pressureLoss2(dp(start=40)),
          port_2a(m_flow(start=0.079866)),
          volume1(T(start=273.15 + 15), T0=273.15 + 15))
          annotation (Placement(transformation(extent={{-16,-4},{16,26}})));
        Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX Medium2in(
          m=0.075,
          X=0,
          use_m_in=true,
          h=26.13e3)
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=0,
              origin={60,-40})));
        Sources.BoundaryMoistAir_phX Medium2out(
          use_p_in=false,
          X=0,
          p=101325,
          h=6e3)      annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={60,20})));
        Modelica.Blocks.Sources.Ramp mflow(
          duration=1,
          startTime=1,
          height=0.01 - HX.m_flow10,
          offset=HX.m_flow10)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        Anlagensimulation_WS1314.HeatExchanger.Recuperator HX1(
                                                              flowType=1,
          pressureLoss1(dp(start=40)),
          pressureLoss2(dp(start=40)),
          port_1a(m_flow(start=0.079866)),
          volume2(T(start=273.15 + 16), T0=273.15 + 16))
          annotation (Placement(transformation(extent={{-16,-46},{16,-16}})));
      equation

        connect(Medium1in.portMoistAir_a, HX.port_1a) annotation (Line(
            points={{-50,20},{-16,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(mflow.y, Medium1in.m_in) annotation (Line(
            points={{-79,50},{-72,50},{-72,28}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(mflow.y, Medium2in.m_in) annotation (Line(
            points={{-79,50},{72,50},{72,-32}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(Medium2in.portMoistAir_a, HX1.port_2a) annotation (Line(
            points={{50,-40},{16,-40}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HX.port_2b, Medium2out.portMoistAir_a) annotation (Line(
            points={{16,20},{50,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HX1.port_1b, Medium1out.portMoistAir_a) annotation (Line(
            points={{-16,-40},{-50,-40}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HX1.port_2b, HX.port_2a) annotation (Line(
            points={{16,-22},{24,-22},{24,2},{16,2}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HX.port_1b, HX1.port_1a) annotation (Line(
            points={{-16,2},{-24,2},{-24,-22},{-16,-22}},
            color={0,127,255},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),      graphics),
         Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A small example of two coupled heat exchangers with varying mass flow rate of both media.</p>
</html>",   revisions="<html>
<p>12.01.2014, Peter Matthes</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),experiment(StopTime=3),
          __Dymola_experimentSetupOutput);
      end DoubleHX_mflow;

      model SingleHX_room
        "heat recovery in simple ventilation system with internal room sources."
        import Anlagensimulation_WS1314 = AixLib.HVAC;
      extends Modelica.Icons.Example;
        inner Anlagensimulation_WS1314.BaseParameters
                                  baseParameters
          annotation (Placement(transformation(extent={{60,66},{80,86}})));
        Anlagensimulation_WS1314.HeatExchanger.Recuperator HX(flowType=1)
          annotation (Placement(transformation(extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-10,0})));
        Sources.BoundaryMoistAir_phX Medium2out(
          use_p_in=false,
          X=0,
          p=101325)   annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={-50,20})));
        Modelica.Blocks.Sources.Ramp Toda(
          duration=1,
          startTime=1,
          height=20e3,
          offset=5.03e3) "outdoor air temperature"
          annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
        Anlagensimulation_WS1314.Volume.VolumeMoistAir volumeMoistAir(V=0.0001)
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={30,0})));
        Anlagensimulation_WS1314.Sources.MassflowsourceMoistAir_mhX
                                     Medium2out1(
          X=0,
          use_h_in=true,
          m=0.07987)  annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={-50,-20})));
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=500,
            T_ref=baseParameters.T_ref)
          annotation (Placement(transformation(extent={{68,-10},{48,10}})));
      equation

        connect(HX.port_1b, volumeMoistAir.portMoistAir_a) annotation (Line(
            points={{2,-20},{30,-20},{30,-10}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(volumeMoistAir.portMoistAir_b, HX.port_2a) annotation (Line(
            points={{30,10},{30,20},{2,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(HX.port_2b, Medium2out.portMoistAir_a) annotation (Line(
            points={{-22,20},{-40,20}},
            color={0,127,255},
            smooth=Smooth.None));
        connect(Toda.y, Medium2out1.h_in) annotation (Line(
            points={{-69,-20},{-62,-20}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(fixedHeatFlow.port, volumeMoistAir.heatPort) annotation (Line(
            points={{48,0},{40,0}},
            color={191,0,0},
            smooth=Smooth.None));
        connect(Medium2out1.portMoistAir_a, HX.port_1a) annotation (Line(
            points={{-40,-20},{-22,-20}},
            color={0,127,255},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),      graphics),
         Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>A small example of an heat exchanger in combination with a room model with a heat load (ventilation system with heat recovery). The outdoor air temperature will be varied.</p>
</html>",   revisions="<html>
<p>03.02.2014, Peter Matthes</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"),experiment(StopTime=3),
          __Dymola_experimentSetupOutput);
      end SingleHX_room;
    end Medium;
  end Examples;

  package BaseClasses
    extends Modelica.Icons.BasesPackage;

    model SimpleHeatTransfer "Just passing heat flow through"

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Blocks.Interfaces.RealInput Q "Heat flow from port a to port b"
        annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));

    equation
      port_a.Q_flow = Q;
      port_b.Q_flow = -Q;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Line(
              points={{0,-60},{0,60}},
              color={0,0,255},
              smooth=Smooth.None), Line(
              points={{-20,40},{0,60},{20,40}},
              color={0,0,255},
              smooth=Smooth.None)}), Documentation(revisions="<html>
<p>12.01.2014, Peter Matthes</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>",     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Model transfers a given power from one thermal port to a second.</p>
</html>"));
    end SimpleHeatTransfer;
  end BaseClasses;
end HeatExchanger;
