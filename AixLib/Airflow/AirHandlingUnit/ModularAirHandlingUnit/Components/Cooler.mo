within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model Cooler "Idealized model for cooler considering condensation"
  extends BaseClasses.PartialCooler;

  parameter Modelica.SIunits.Length s=0.003 "distance of parallel heat exchanger plates (fins)" annotation (HideResult = (use_T_set));

  parameter Boolean use_constant_heatTransferCoefficient=false "if true then a constant heat transfer coefficient is used";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer k=60 "constant heat transfer coefficient (only used if use_constan_heatTransferCoefficient is true)" annotation (HideResult = (not use_constant_heatTransferCoefficient));

  // Variables
  Modelica.SIunits.Temperature T_dew "dew point temperature";

  // Objects
  BaseClasses.HeatTransfer.ConvectiveHeatTransferCoefficient heatTransfer(
    m_flow=m_flow_airIn,
    length=length,
    width=width,
    nFins=nFins,
    s=s);

  Modelica.Blocks.Interfaces.RealInput T_coolingSurf(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") "temperature of cooling Surface"
                                     annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-108}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={-49,-99})));
  AixLib.Utilities.Psychrometrics.pW_X pWat(use_p_in=false)
    annotation (Placement(transformation(extent={{-64,68},{-44,88}})));
  AixLib.Utilities.Psychrometrics.TDewPoi_pW dewPoi
    annotation (Placement(transformation(extent={{-32,68},{-12,88}})));
  AixLib.Utilities.Psychrometrics.SaturationPressure pSat
    annotation (Placement(transformation(extent={{-46,-70},{-66,-50}})));
  AixLib.Utilities.Psychrometrics.X_pW humRat(use_p_in=false)
    annotation (Placement(transformation(extent={{-74,-70},{-94,-50}})));
protected
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=20)
    annotation (Placement(transformation(extent={{40,-72},{60,-52}})));
  Modelica.Blocks.Sources.Constant Q_ref(k=0)
    annotation (Placement(transformation(extent={{20,-60},{28,-52}})));
equation
  T_dew = dewPoi.T;

  // convective heat transfer
  if use_constant_heatTransferCoefficient then
    k_air = k;
  else
    k_air = heatTransfer.alpha;
  end if;

  if onOffController.y and not use_X_set then
    X_airOut = smooth(1, if T_coolingSurf > T_dew then X_airIn else humRat.X_w + (X_airIn - humRat.X_w)*0.3);
  elseif not use_X_set then
    X_airOut = X_airIn;
  end if;
  // Efficiency of dehumidfication assumed to 70 %.

  connect(X_airIn, pWat.X_w) annotation (Line(points={{-120,10},{-80,10},{-80,78},
          {-65,78}}, color={0,0,127}));
  connect(pWat.p_w, dewPoi.p_w) annotation (Line(points={{-43,78},{-33,78}},
                         color={0,0,127}));
  connect(T_coolingSurf, pSat.TSat) annotation (Line(points={{-40,-108},{-40,-60},
          {-45,-60}}, color={0,0,127}));
  connect(pSat.pSat, humRat.p_w)
    annotation (Line(points={{-67,-60},{-73,-60}}, color={0,0,127}));
  connect(heatFlowSensor.Q_flow, onOffController.u) annotation (Line(points={{-2,
          20},{14,20},{14,-68},{38,-68}}, color={0,0,127}));
  connect(Q_ref.y, onOffController.reference)
    annotation (Line(points={{28.4,-56},{38,-56}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(
          points={{100,94},{-100,-94}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-94,-64},{-86,-64}},
          color={0,0,0},
          thickness=1),
        Ellipse(
          extent={{54,-14},{64,-24}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{54,-20},{54,-16},{56,-12},{60,-8},{64,-6},{62,-10},{62,-14},{
              64,-18},{60,-18},{54,-20}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{72,-8},{82,-18}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{72,-14},{72,-10},{74,-6},{78,-2},{82,0},{80,-4},{80,-8},{82,-12},
              {78,-12},{72,-14}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{70,-34},{80,-44}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{70,-40},{70,-36},{72,-32},{76,-28},{80,-26},{78,-30},{78,-34},
              {80,-38},{76,-38},{70,-40}},
          lineThickness=1,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}), Documentation(info="<html><p>
  This model provides a idealized cooler. The model considers the
  convective heat transfer from the heat transfer surface in the air
  stream. Moreover the heat capacity of the heating surface and the
  housing of the heat exchanger is considered.
</p>
<p>
  If the temperature of the cooling surface lies below the dew point,
  condensation is considered.
</p>
<h4>
  Heat transfer model:
</h4>
<p>
  The model assumes a heat transfer in a plane gap. Hence the
  convective heat transfer coefficient is calculated using the
  Nusselt-correlation for a plane gap as described in the
  VDI-Wärmeatlas 2013 (p.800, eq. 45).
</p>
<p style=\"text-align:center;\">
  <i>Nu<sub>m</sub> = 7.55 + (0.024 {Re Pr d<sub>h</sub> ⁄
  l}<sup>1.14</sup>) ⁄ (1 + 0.0358 {Re Pr d<sub>h</sub> ⁄
  l}<sup>0.64</sup> Pr<sup>0.17</sup>)</i>
</p>
</html>", revisions="<html>
<ul>
  <li>April, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end Cooler;
