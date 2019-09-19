within AixLib.Fluid.BoilerCHP;
model BoilerNoControl "Boiler model with physics only"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(pressureDrop(a=a),
                                     vol(V=V));

  parameter AixLib.DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
    paramBoiler "Parameters for Boiler" annotation (Dialog(tab="General", group=
         "Boiler type"), choicesAllMatching=true);
  parameter Modelica.SIunits.ThermalConductance G
    "Constant thermal conductance to environment";
  parameter Modelica.SIunits.HeatCapacity C=10000
    "Heat capacity of element (= cp*m)";
  parameter Modelica.SIunits.Volume V=paramBoiler.volume "Volume";

  parameter Modelica.SIunits.Power Q_nom=paramBoiler.Q_nom
    "Nominal heating power";
  parameter Real eta_nom=1 "Nominal efficiency";

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(
      final C=C, T(start=T_start)) "Boiler thermal capacity (dry weight)"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={2,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(
      final G=G) "Thermal resistance of the boiler casing" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,-20})));
  Modelica.Blocks.Math.Product QgasCalculation
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=1, final uMin=0)
    annotation (Placement(transformation(extent={{-74,54},{-62,66}})));
  Modelica.Blocks.Sources.RealExpression NominalGasConsumption(final y=Q_nom/
        eta_nom)
    "etaRP is calculated in the algorithm section"
    annotation (Placement(transformation(extent={{-76,78},{-48,94}})));
  Modelica.Blocks.Interfaces.RealOutput fuelPower
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{100,90},{120,110}}), iconTransformation(extent={{-10,-10},{
            10,10}},
        rotation=0,
        origin={72,110})));
  Modelica.Blocks.Interfaces.RealOutput thermalPower "Value of Real output"
    annotation (Placement(transformation(extent={{100,70},{120,90}}),
        iconTransformation(extent={{62,74},{82,94}})));
  Modelica.Blocks.Interfaces.RealInput u_rel "Connector of Real input signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,70})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b T_amb annotation (
      Placement(transformation(extent={{30,-30},{50,-10}}), iconTransformation(
          extent={{58,-60},{78,-40}})));

  Modelica.Blocks.Tables.CombiTable1D efficiencyTable(
    final tableOnFile=false,
    final table=paramBoiler.eta,
    final columns={2},
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "Table with efficiency parameters"
    annotation (Placement(transformation(extent={{-40,40},{-19,61}})));
  Modelica.Blocks.Math.Product QflowCalculation annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,10})));

  parameter Real a=paramBoiler.pressureDrop
    "Coefficient for quadratic pressure drop term";
  Modelica.Blocks.Interfaces.RealOutput T_out
    "Temperature of the passing fluid" annotation (Placement(transformation(
          extent={{100,50},{120,70}}), iconTransformation(extent={{62,22},{82,
            42}})));
  Modelica.Blocks.Interfaces.RealOutput T_in "Temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{62,48},{82,68}})));
equation
  connect(vol.heatPort, ConductanceToEnv.port_a)
    annotation (Line(points={{-50,-70},{-50,-20},{-40,-20}}, color={191,0,0}));
  connect(vol.heatPort, internalCapacity.port)
    annotation (Line(points={{-50,-70},{-50,-40},{-8,-40}}, color={191,0,0}));
  connect(QgasCalculation.y, fuelPower) annotation (Line(points={{-19,80},{-18,80},
          {-18,100},{110,100}}, color={0,0,127}));
  connect(limiter.u, u_rel)
    annotation (Line(points={{-75.2,60},{-80,60},{-80,120}}, color={0,0,127}));
  connect(ConductanceToEnv.port_b, T_amb)
    annotation (Line(points={{-20,-20},{40,-20}}, color={191,0,0}));
  connect(QgasCalculation.u1, NominalGasConsumption.y)
    annotation (Line(points={{-42,86},{-46.6,86}}, color={0,0,127}));
  connect(limiter.y, QgasCalculation.u2) annotation (Line(points={{-61.4,60},{-50,
          60},{-50,74},{-42,74}}, color={0,0,127}));
  connect(limiter.y, efficiencyTable.u[1]) annotation (Line(points={{-61.4,60},{
          -50,60},{-50,50.5},{-42.1,50.5}}, color={0,0,127}));
  connect(QflowCalculation.y, heater.Q_flow)
    annotation (Line(points={{-60,-1},{-60,-40}}, color={0,0,127}));
  connect(QflowCalculation.y, thermalPower) annotation (Line(points={{-60,-1},{-18,
          -1},{-18,0},{24,0},{24,80},{110,80}},color={0,0,127}));
  connect(QgasCalculation.y, QflowCalculation.u2) annotation (Line(points={{-19,
          80},{-18,80},{-18,134},{-100,134},{-100,22},{-66,22}}, color={0,0,127}));
  connect(efficiencyTable.y[1], QflowCalculation.u1) annotation (Line(points={{-17.95,
          50.5},{-8,50.5},{-8,22},{-54,22}}, color={0,0,127}));
  connect(senTHot.T, T_out) annotation (Line(points={{40,-69},{52,-69},{52,-56},
          {60,-56},{60,60},{110,60}}, color={0,0,127}));
  connect(senTCold.T, T_in) annotation (Line(points={{-70,-69},{-70,-102},{110,-102},
          {110,40}}, color={0,0,127}));
  connect(port_b, port_b)
    annotation (Line(points={{100,0},{100,0}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-32,-50},{-36,-38},{-28,-22},{-20,-32},{-22,-46},{-24,-50},{
              -24,-50},{-24,-50},{-32,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-30.5,-49.5},{-28,-32},{-24,-50},{-24,-50},{-30.5,-49.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,-50},{42,-58}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Polygon(
          points={{-4,-50},{-8,-38},{0,-22},{8,-32},{6,-46},{4,-50},{4,-50},{4,
              -50},{-4,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-2.5,-49.5},{0,-32},{4,-50},{4,-50},{-2.5,-49.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{22,-50},{18,-38},{26,-22},{34,-32},{32,-46},{30,-50},{30,-50},
              {30,-50},{22,-50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{23.5,-49.5},{26,-32},{30,-50},{30,-50},{23.5,-49.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,70},{-48,70},{-48,-54},{-44,-54}},
          color={0,0,0},
          thickness=0.5,
          pattern=LinePattern.Dot),
        Line(
          points={{-90,0},{-38,0},{-38,-12},{36,-12},{36,2},{-30,2},{-30,16},{
              36,16},{36,32},{-30,32},{-30,48},{50,48},{50,0},{90,0}},
          color={28,108,200},
          thickness=1)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>A boiler model consisting of physical components. Temperature depending efficiency for condensing boilers can be activated.</p>
</html>", revisions="<html>
<ul>
<li><i>September 19, 2019&nbsp;</i> by Alexander Kümpel:<br/>First implementation</li>
</ul>
</html>"));
end BoilerNoControl;
