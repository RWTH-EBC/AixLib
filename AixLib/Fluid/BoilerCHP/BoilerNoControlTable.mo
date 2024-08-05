within AixLib.Fluid.BoilerCHP;
model BoilerNoControlTable "Boiler model with physics only"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(a=paramBoiler.pressureDrop,
                                     vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
                                         final V=V));




  parameter AixLib.DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
    paramBoiler "Parameters for Boiler" annotation (Dialog(tab="General", group=
         "Boiler type"), choicesAllMatching=true);
  parameter Modelica.Units.SI.ThermalConductance G=0.003*Q_nom/50
    "Constant thermal conductance to environment(G=Q_loss/dT)";
  parameter Modelica.Units.SI.HeatCapacity C=1.5*Q_nom
    "Heat capacity of metal (J/K)";
  parameter Modelica.Units.SI.Volume V=paramBoiler.volume "Volume";

  parameter Modelica.Units.SI.Power Q_nom=paramBoiler.Q_nom
    "Nominal heating power";

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
  Modelica.Blocks.Math.Product QgasCalculation "Calculate gas usage"
    annotation (Placement(transformation(extent={{10,82},{30,102}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(final uMax=1, final uMin=0)
    "Limits the rel power between 0 and 1"
    annotation (Placement(transformation(extent={{-76,60},{-56,80}})));
  Modelica.Blocks.Sources.RealExpression NominalGasConsumption(final y=19900)
    "Nominal gas power"
    annotation (Placement(transformation(extent={{-46,88},{-6,108}})));
  Modelica.Blocks.Interfaces.RealOutput fuelPower
    "Connector of Real output signal" annotation (Placement(transformation(
          extent={{100,90},{120,110}}), iconTransformation(extent={{-10,-10},{10,
            10}},
        rotation=0,
        origin={72,110})));
  Modelica.Blocks.Interfaces.RealOutput thermalPower "Value of Real output"
    annotation (Placement(transformation(extent={{100,70},{120,90}}),
        iconTransformation(extent={{62,74},{82,94}})));
  Modelica.Blocks.Interfaces.RealInput u_rel "Relative gas power [0,1]"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-80,120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,70})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b T_amb "Heat port for heat losses to ambient" annotation (
      Placement(transformation(extent={{30,-30},{50,-10}}), iconTransformation(
          extent={{58,-60},{78,-40}})));

  Modelica.Blocks.Math.Product QflowCalculation
    "Calculation of the produced heatflow"      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,2})));

  Modelica.Blocks.Interfaces.RealOutput T_out
    "Outflow temperature of the passing fluid" annotation (Placement(transformation(
          extent={{100,50},{120,70}}), iconTransformation(extent={{62,22},{82,42}})));
  Modelica.Blocks.Interfaces.RealOutput T_in "Inflow temperature of the passing fluid"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{62,48},{82,68}})));
  parameter Real etaLoadBased[:,2]=paramBoiler.eta
    "Table matrix for part load based efficiency (e.g. [0,0.99; 0.5, 0.98; 1, 0,97])";
  parameter Real etaTempBased[:,2]=[293.15,1.09; 303.15,1.08; 313.15,1.05; 323.15,1.; 373.15,0.99]
  "Table matrix for temperature based efficiency";
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{48,14},{68,34}})));
  Modelica.Blocks.Tables.CombiTable2Ds effTab(
    final table=table,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints)
    "Look-up table that represents a set of efficiency curves varying with both the firing rate (control signal) and the inlet water temperature"
    annotation (Placement(transformation(extent={{-28,36},{-8,56}})));

  parameter Real table[:,:]
    "Table matrix (grid u1 = first column, grid u2 = first row; e.g., table=[0, 0; 0, 1])";
  Modelica.Blocks.Interfaces.RealOutput efficiency
                                      annotation (Placement(transformation(
          extent={{100,120},{120,140}}),iconTransformation(extent={{-10,-10},{10,
            10}},
        rotation=0,
        origin={72,136})));
equation
  connect(vol.heatPort, ConductanceToEnv.port_a)
    annotation (Line(points={{-50,-70},{-50,-20},{-40,-20}}, color={191,0,0}));
  connect(vol.heatPort, internalCapacity.port)
    annotation (Line(points={{-50,-70},{-50,-40},{-8,-40}}, color={191,0,0}));
  connect(QgasCalculation.y, fuelPower) annotation (Line(points={{31,92},{60,92},
          {60,100},{110,100}},  color={0,0,127}));
  connect(limiter.u, u_rel)
    annotation (Line(points={{-78,70},{-78,96},{-80,96},{-80,120}},
                                                             color={0,0,127}));
  connect(ConductanceToEnv.port_b, T_amb)
    annotation (Line(points={{-20,-20},{40,-20}}, color={191,0,0}));
  connect(limiter.y, QgasCalculation.u2) annotation (Line(points={{-55,70},{-50,
          70},{-50,86},{8,86}},   color={0,0,127}));
  connect(QflowCalculation.y, heater.Q_flow)
    annotation (Line(points={{-60,-9},{-60,-40}}, color={0,0,127}));
  connect(QflowCalculation.y, thermalPower) annotation (Line(points={{-60,-9},{-18,
          -9},{-18,0},{24,0},{24,80},{110,80}},color={0,0,127}));
  connect(QgasCalculation.y, QflowCalculation.u2) annotation (Line(points={{31,92},
          {60,92},{60,140},{-96,140},{-96,14},{-66,14}},         color={0,0,127}));
  connect(senTCold.T, T_in) annotation (Line(points={{-70,-69},{-70,-102},{110,-102},
          {110,40}}, color={0,0,127}));
  connect(port_b, port_b)
    annotation (Line(points={{100,0},{100,0}}, color={0,127,255}));
  connect(temperatureSensor.T, T_out) annotation (Line(points={{69,24},{82,24},
          {82,60},{110,60}}, color={0,0,127}));
  connect(temperatureSensor.port, vol.heatPort) annotation (Line(points={{48,24},
          {44,24},{44,10},{42,10},{42,-70},{-50,-70}}, color={191,0,0}));
  connect(u_rel, effTab.u1)
    annotation (Line(points={{-80,120},{-80,52},{-30,52}}, color={0,0,127}));
  connect(senTCold.T, effTab.u2)
    annotation (Line(points={{-70,-69},{-70,40},{-30,40}}, color={0,0,127}));
  connect(effTab.y, QflowCalculation.u1) annotation (Line(points={{-7,46},{0,46},
          {0,44},{8,44},{8,24},{-54,24},{-54,14}}, color={0,0,127}));
  connect(NominalGasConsumption.y, QgasCalculation.u1)
    annotation (Line(points={{-4,98},{8,98}}, color={0,0,127}));
  connect(effTab.y, efficiency) annotation (Line(points={{-7,46},{30,46},{30,
          130},{110,130}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{-32,-50},{-36,-38},{-28,-22},{-20,-32},{-22,-46},{-24,-50},{-24,
              -50},{-24,-50},{-32,-50}},
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
          points={{-4,-50},{-8,-38},{0,-22},{8,-32},{6,-46},{4,-50},{4,-50},{4,-50},
              {-4,-50}},
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
          points={{-90,0},{-38,0},{-38,-12},{36,-12},{36,2},{-30,2},{-30,16},{36,
              16},{36,32},{-30,32},{-30,48},{50,48},{50,0},{90,0}},
          color={28,108,200},
          thickness=1)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  A boiler model consisting of physical components.The efficiency is
  based on the part load rate and the inflow water temperature.
</p>
<p>
  <br/>
  Assumptions for predefined parameter values (based on <i><a href=
  \"http://www.viessmann.com/web/netherlands/nl_tdis.nsf/39085ab6c8b4f206c1257195003fd054/8A84BA9E240BA23DC12575210055DB56/$file/5811_009-DE_Simplex-PS.pdf\">
  Vissmann data cheat</a></i>):
</p>
<p>
  G: a heat loss of 0.3 % of nominal power at a temperature difference
  of 50 K to ambient is assumed.
</p>
<p>
  C: factor C/Q_nom is in range of 1.2 to 2 for boilers with nominal
  power between 460 kW and 80 kW (with c of 500J/kgK for steel). Thus,
  a value of 1.5 is used as default.
</p>
<ul>
  <li>
    <i>September 19, 2019&#160;</i> by Alexander Kümpel:<br/>
    First implementation
  </li>
</ul>
</html>"));
end BoilerNoControlTable;
