within AixLib.Fluid.Humidifiers;
model GenericHumidifier_u
  "Steam or adiabatic humidifier with relative mass flow rate as input"
  extends AixLib.Fluid.Interfaces.TwoPortHeatMassExchanger(
    redeclare replaceable package Medium =
        Modelica.Media.Interfaces.PartialCondensingGases,
    redeclare final AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir vol(
    final prescribedHeatFlowRate=true));

  parameter Modelica.Units.SI.MassFlowRate mWat_flow_nominal
    "Water mass flow rate at u=1, positive for humidification";

  parameter Modelica.Units.SI.Temperature TLiqWat_in
    "Temperature of liquid water that is vaporized";

  parameter Boolean steamHumidifier=true  "True: steam humidifier, false: adiabatic (water) humidifier";

  parameter Boolean TVapFixed = true "True: fixed vaporization temperature, false: vaporization temperature from pressure" annotation (Dialog(enable=steamHumidifier, tab = "Advanced", group = "Vaporization"));

  parameter Modelica.Units.SI.Temperature TVap=373.15
    "Vaporization temperature of steam" annotation (Dialog(
      enable=TVapFixed and steamHumidifier,
      tab="Advanced",
      group="Vaporization"));

  Modelica.Blocks.Interfaces.RealInput u(unit="1") "Control input"
    annotation (Placement(transformation(
          extent={{-140,40},{-100,80}}), iconTransformation(extent={{-120,50},{
            -100,70}})));

  Modelica.Blocks.Interfaces.RealOutput mWat_flow(unit="kg/s")
    "Water added to the fluid"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));

  Modelica.Blocks.Interfaces.RealOutput powerEva if steamHumidifier
    "Consumed power for evaporization" annotation (Placement(transformation(
          extent={{100,90},{120,110}}), iconTransformation(extent={{100,90},{120,
            110}})));
  Modelica.Blocks.Sources.RealExpression steamEnthalpyFlow(y=
        Medium.enthalpyOfCondensingGas(T=Tsteam_intern)*mWat_flow) if steamHumidifier
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Sources.RealExpression waterEnthalpyFlow(y=Medium.enthalpyOfLiquid(T=TLiqWat_in)*mWat_flow) annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Sources.RealExpression TVapPoint(y=
        AixLib.Utilities.Psychrometrics.Functions.TDewPoi_pW(vol.p)) if not TVapFixed and steamHumidifier
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  Modelica.Blocks.Sources.RealExpression TVapPointFix(y=TVap) if TVapFixed and steamHumidifier
    annotation (Placement(transformation(extent={{-100,-104},{-80,-84}})));
  Modelica.Blocks.Routing.RealPassThrough Tsteam if steamHumidifier
    annotation (Placement(transformation(extent={{-60,-98},{-40,-78}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y = mWat_flow_nominal)  annotation (
    Placement(visible = true, transformation(origin = {-62, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation (
    Placement(visible = true, transformation(origin = {-20, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  Modelica.Blocks.Interfaces.RealInput Tsteam_intern;
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));

  Modelica.Blocks.Math.Add add(k2=-1) if steamHumidifier
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
equation
  if not steamHumidifier then
    Tsteam_intern = 273.15;
  end if;

  connect(Tsteam.y, Tsteam_intern);
  connect(product.y, vol.mWat_flow) annotation (Line(
      points={{-9,60},{-30,60},{-30,-18},{-11,-18}},
      color={0,0,127}));
  connect(u, limiter.u)
    annotation (Line(points={{-120,60},{-92,60}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, vol.heatPort) annotation (Line(points={{-20,-40},
          {-20,-10},{-9,-10}},           color={191,0,0}));

  connect(steamEnthalpyFlow.y, add.u1) annotation (Line(points={{-79,-40},{-76,-40},
          {-76,-44},{18,-44}}, color={0,0,127}));
  connect(waterEnthalpyFlow.y, add.u2) annotation (Line(points={{-79,-60},{-76,-60},
          {-76,-56},{18,-56}}, color={0,0,127}));
  connect(add.y, powerEva) annotation (Line(points={{41,-50},{60,-50},{60,100},{
          110,100}}, color={0,0,127},
      pattern=LinePattern.Dash));
  if steamHumidifier then
      connect(steamEnthalpyFlow.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-79,-40},{-40,-40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  else
    connect(waterEnthalpyFlow.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{-79,-60},{-40,-60},{-40,-40}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  end if;
  connect(TVapPoint.y, Tsteam.u) annotation (Line(
      points={{-79,-80},{-72,-80},{-72,-88},{-62,-88}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TVapPointFix.y, Tsteam.u) annotation (Line(
      points={{-79,-94},{-72,-94},{-72,-88},{-62,-88}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(limiter.y, product.u1) annotation (
    Line(points={{-69,60},{-48,60},{-48,66},{-32,66}},          color = {0, 0, 127}));
  connect(realExpression.y, product.u2) annotation (
    Line(points={{-51,32},{-40,32},{-40,54},{-32,54}},          color = {0, 0, 127}));
  connect(product.y, mWat_flow) annotation (
    Line(points = {{-9, 60}, {110, 60}}, color = {0, 0, 127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Text(lineColor = {0, 0, 127}, extent = {{-52, -60}, {58, -120}}, textString = "m=%m_flow_nominal"),
        Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 127}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, 61}, {-70, 58}}),
        Text(lineColor = {0, 0, 127}, extent = {{-118, 104}, {-74, 76}}, textString = "u"),
        Rectangle(lineColor = {0, 0, 255}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, 5}, {101, -5}}),
        Rectangle(lineColor = {0, 0, 255}, fillColor = {95, 95, 95}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-70, 60}, {70, -60}}),
        Polygon(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{42, 42}, {54, 34}, {54, 34}, {42, 28}, {42, 30}, {50, 34}, {50, 34}, {42, 40}, {42, 42}}),
        Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{58, -54}, {54, 52}}),
        Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 127}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{70, 61}, {100, 58}}),
        Text(lineColor = {0, 0, 127}, extent = {{32, 98}, {98, 44}}, textString = "mWat_flow"),
        Polygon(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{42, 10}, {54, 2}, {54, 2}, {42, -4}, {42, -2}, {50, 2}, {50, 2}, {42, 8}, {42, 10}}),
        Polygon(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{42, -26}, {54, -34}, {54, -34}, {42, -40}, {42, -38}, {50, -34}, {50, -34}, {42, -28}, {42, -26}}),
        Text(lineColor = {0, 0, 127}, extent = {{30, 130}, {96, 76}}, textString = "powerEva"),
        Ellipse(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-14, 44}, {10, 30}}),
        Ellipse(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{24, 38}, {34, 32}}),
        Ellipse(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{26, 30}, {8, 42}}),
        Ellipse(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-28, 12}, {-4, -2}}),
        Ellipse(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{12, -2}, {-6, 10}}),
        Ellipse(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{10, 6}, {20, 0}}),
        Ellipse(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-12, -24}, {12, -38}}),
        Ellipse(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{28, -38}, {10, -26}}),
        Ellipse(lineColor = {28, 108, 200}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{26, -30}, {36, -36}}),
        Line(visible = false, points = {{28, 40}, {14, 40}}, color = {28, 108, 200}, thickness = 0.5),
        Line(visible = false, points = {{-6, 36}, {-20, 30}}, color = {28, 108, 200}, thickness = 0.5),
        Line(visible = false, points = {{30, 4}, {16, 6}}, color = {28, 108, 200}, thickness = 0.5),
        Line(visible = false, points = {{0, 4}, {-14, -2}}, color = {28, 108, 200}, thickness = 0.5),
        Line(visible = false, points = {{30, -32}, {16, -30}}, color = {28, 108, 200}, thickness = 0.5),
        Line(visible = false, points = {{0, -34}, {-14, -40}}, color = {28, 108, 200}, thickness = 0.5),
        Line(visible = false, points = {{-32, -24}, {-42, -38}}, color = {28, 108, 200}, thickness = 0.5),
        Line(visible = false, points = {{-32, 10}, {-42, -4}}, color = {28, 108, 200}, thickness = 0.5)}),
defaultComponentName="hum",
Documentation(info="<html><p>
  Model for an air humidifier.
</p>
<p>
  This model adds moisture to the air stream. The moisture can be
  either liquid (adiabatic) or steam. If steam is chosen, the
  vaporization temperature can be fixed or calculated from the
  pressure.
</p>
<p>
  The amount of added moisture is equal to
</p>
<p style=\"text-align:center;font-style:italic;\">
  ṁ<sub>wat</sub> = u ṁ<sub>wat,nom</sub>,
</p>
<p>
  where <i>u</i> is the control input signal and
  <i>ṁ<sub>wat,nom</sub></i> is equal to the parameter
  <code>mWat_flow_nominal</code>. The parameter
  <code>mWat_flow_nominal</code> must be positive.
</p>
<p>
  Twater_in is used to calculate the thermal power for the vaporization
  (sensible and latent heat) of the steam humidifier and to calculate
  the enthalpy for the liquid in the adiabatic case.
</p>
</html>",
revisions="<html><ul>
  <li>December 06, 2022, by EBC-Modelica group:<br/>
    Fixes to increase compatability to OpenModelica <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1378\">#1378</a>.
  </li>
  <li>October 22, 2019, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end GenericHumidifier_u;
