within AixLib.Fluid.Movers.Compressors.Utilities.HeatTransfer;
model SimpleHeatTransfer
  "Model of a simple 1-dimensional heat transfer for compressor's 
  inlet and outlet"

  // Definition of parameters describing heat transfer
  //
  parameter Types.HeatTransferModels heaTraMod=
    Types.HeatTransferModels.Simplified
    "Choose heat transfer model"
    annotation (Dialog(tab="General",group="Heat transfer"));
  parameter Modelica.SIunits.ThermalConductance kAMea = 25
    "Effective mean thermal conductance between medium and fictitious wall"
    annotation (Dialog(tab="General",group="Heat transfer"));

  // Extensions and parameter propagation
  //
  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport(
    redeclare replaceable package Medium=Modelica.Media.R134a.R134a_ph,
    final dp_start=0,
    m_flow_start=0.5*m_flow_nominal,
    m_flow_small=1e-6*m_flow_nominal,
    show_T=false,
    show_V_flow=false);

  // Definition of parameters describing advanced options
  //
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation(Dialog(tab="Advanced"),
               HideResult=true);

  // Definition of submodels and connectors
  //
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort
    "Heat port to calculate heat losses"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

protected
  Medium.ThermodynamicState staInl
    "Thermodynamic state at inlet";
  Medium.ThermodynamicState staOut
    "Thermodynamic state at outlet";

  Modelica.SIunits.TemperatureDifference logTemDif
    "Logarithmic temperature difference between medium and wall";
  Modelica.SIunits.Power Q_flow
    "Heat flow exchanged between medium and heat port";

equation
  // Calculation of thermodynamic states
  //
  staInl = Medium.setState_phX(p=port_a.p, h=actualStream(port_a.h_outflow))
    "Thermodynamic state at inlet";
  staOut = Medium.setState_phX(p=port_b.p, h=actualStream(port_b.h_outflow))
    "Thermodynamic state at outlet";

  // Calculation of heat flow
  //
  logTemDif = (Medium.temperature(staOut)-Medium.temperature(staInl))/
    log(max((Medium.temperature(staOut)-heatPort.T)/
    (Medium.temperature(staInl)-heatPort.T),1e-6))
    "Logarithmic temperature difference between medium and fictitious wall";
  if heaTraMod == Types.HeatTransferModels.Simplified then
    Q_flow = kAMea*logTemDif "Simplified calculation of heat transfer";
  else
    assert(false, "Invalid choice of heat transfer model");
  end if;

  // Calculation of boundary conditions
  //
  port_a.h_outflow = inStream(port_b.h_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow);
  dp = 0 "Assuming no pressure loss";

  heatPort.Q_flow = Q_flow "Connect heat flow with heat port";

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 28, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"), Icon(graphics={
        Rectangle(
          extent={{-80,-66},{80,-86}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(points={{80,-40},{-80,-40}}, color={0,127,255},
          arrow={Arrow.Filled,Arrow.None},
          thickness=0.5),
        Line(points={{80,40},{-80,40}},   color={0,127,255},
          arrow={Arrow.Filled,Arrow.None},
          thickness=0.5),
        Line(points={{80,0},{-80,0}},     color={0,127,255},
          arrow={Arrow.Filled,Arrow.None},
          thickness=0.5),
        Polygon(
          points={{-58,54},{-58,54}},
          lineColor={0,127,255},
          lineThickness=0.5,
          fillColor={192,192,192},
          fillPattern=FillPattern.Forward),
        Line(points={{-60,60},{-60,-60}}, color={255,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=0.5),
        Line(points={{-20,60},{-20,-60}}, color={255,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=0.5),
        Line(points={{20,60},{20,-60}},   color={255,0,0},
          arrow={Arrow.Filled,Arrow.Filled},
          thickness=0.5)}));
end SimpleHeatTransfer;
