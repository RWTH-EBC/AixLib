within AixLib.Fluid.BoilerCHP;
model BoilerGeneric "Generic performance map based boiler"

  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    T_start=T_start,
    a=coeffPreLos,
    redeclare package Medium = AixLib.Media.Water,
    vol(V=(1.1615*Q_flow_nominal/1000)/1000),
    final m_flow_nominal=Q_flow_nominal/(Medium.cp_const*(TSup_nominal -
        TRet_nominal)),
    final dp_nominal=m_flow_nominal^2*a/(Medium.d_const^2));

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal
    "Design thermal capacity" annotation (Dialog(group="Nominal condition"),Evaluate=false);

  parameter Modelica.Units.SI.Temperature TSup_nominal=353.15
    "Design supply temperature" annotation (Dialog(group="Nominal condition"),Evaluate=false);

  parameter Modelica.Units.SI.Temperature TRet_nominal=333.15
    "Design return temperature" annotation (Dialog(group="Nominal condition"),Evaluate=false);

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor intCap(final C=C, T(start=
          T_start, fixed=true))
                        "Boiler thermal capacity (dry weight)"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=90)));
  AixLib.Fluid.BoilerCHP.BaseClasses.OffDesignOperation offDesignOperation(
    Q_flow_nominal=Q_flow_nominal,
    TSup_nominal=TSup_nominal,
    TRet_nominal=TRet_nominal) "off design operation"
    annotation (Placement(transformation(extent={{30,70},{50,90}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conToEnv(final G=0.0465
        *Q_flow_nominal/1000 + 4.9891)
    "Thermal resistance of the boiler casing" annotation (Placement(
        transformation(extent={{6,-6},{-6,6}}, rotation=180)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TEnvFix(T(displayUnit="K")
       = 293.15)
    "Temperature of environment around the boiler to account for heat losses"
    annotation (Placement(transformation(extent={{26,-38},{14,-26}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heaFloSen
    "Sensor to measure heatflow of heatlosses"
    annotation (Placement(transformation(extent={{-6,-26},{6,-38}})));
  AixLib.Controls.Interfaces.BoilerControlBus boilerControlBus
    "Control bus for boiler"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TSupMea(final T(unit="K"))
    "Measurement of supply/volume temperature"
    annotation (Placement(transformation(extent={{-50,-26},{-30,-6}})));
  AixLib.Fluid.BoilerCHP.BaseClasses.DesignOperation designOperation(
    Q_flow_nominal=Q_flow_nominal,
    TSup_nominal=TSup_nominal,
    TRet_nominal=TRet_nominal) "designOperation for design fuel power"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Math.Product fuePow(final y(unit="W"))
    "Fuel power calculation" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-44,48})));
  Modelica.Blocks.Math.Product thePow(final y(unit="W"))
    "Thermal power calculation" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-38,14})));
protected
  parameter Real coeffPreLos=7.143*10^8*exp(-0.007078*Q_flow_nominal/1000)
    "Pressure loss coefficient of the heat generator";
  parameter Modelica.Units.SI.HeatCapacity C=1.5*Q_flow_nominal
    "Heat capacity of metal (J/K)";

equation

  connect(vol.heatPort, intCap.port)
    annotation (Line(points={{-50,-70},{-50,0},{-10,0}}, color={191,0,0}));
  connect(heaFloSen.port_b, TEnvFix.port)
    annotation (Line(points={{6,-32},{14,-32}}, color={191,0,0}));
  connect(conToEnv.port_b, heaFloSen.port_a) annotation (Line(points={{6,-6.10623e-16},
          {14,-6.10623e-16},{14,-22},{-10,-22},{-10,-32},{-6,-32}}, color={191,0,
          0}));
  connect(conToEnv.port_a, vol.heatPort)
    annotation (Line(points={{-6,0},{-50,0},{-50,-70}}, color={191,0,0}));
  connect(vol.heatPort, TSupMea.port)
    annotation (Line(points={{-50,-70},{-50,-16}}, color={191,0,0}));
  connect(designOperation.NomFueDem, fuePow.u2)
    annotation (Line(points={{-50,69},{-50,60}}, color={0,0,127}));
  connect(thePow.y, heater.Q_flow) annotation (Line(points={{-38,3},{-38,0},{-60,
          0},{-60,-40}}, color={0,0,127}));
  connect(boilerControlBus.FirRatSet, fuePow.u1) annotation (Line(
      points={{0,100},{0,66},{-38,66},{-38,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thePow.y, boilerControlBus.ThermalPower) annotation (Line(points={{-38,
          3},{-38,0},{0,0},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senMasFlo.m_flow, boilerControlBus.m_flowMea) annotation (Line(points={{70,-69},
          {70,100},{0,100}},            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fuePow.y, thePow.u2)
    annotation (Line(points={{-44,37},{-44,26}}, color={0,0,127}));
  connect(boilerControlBus.Efficiency, thePow.u1) annotation (Line(
      points={{0,100},{0,32},{-32,32},{-32,26}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTRet.T, boilerControlBus.TRetMea) annotation (Line(points={{-70,-69},
          {-70,100},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerControlBus, offDesignOperation.boilerControlBus) annotation (
      Line(
      points={{0,100},{40.2,100},{40.2,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(TSupMea.T, boilerControlBus.TSupMea) annotation (Line(points={{-29,-16},
          {-14,-16},{-14,-14},{0,-14},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fuePow.y, boilerControlBus.fuelPower) annotation (Line(points={{-44,37},
          {-44,32},{0,32},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>The model differs between <a href=\"modelica://AixLib.Fluid.BoilerCHP.BaseClasses.DesignOperation\">DesignOperation</a> and <a href=\"modelica://AixLib.Fluid.BoilerCHP.BaseClasses.OffDesignOperation\">OffDesignOperation</a>.</p>
<p>In <a href=\"modelica://AixLib.Fluid.BoilerCHP.BaseClasses.DesignOperation\">DesignOperation</a> for nominal conditions the (max) fuel power is estimated. The <a href=\"modelica://AixLib.Fluid.BoilerCHP.BaseClasses.OffDesignOperation\">OffDesignOperation</a> fuel consumption is estimated via firing rate. </p>
<p>During operation, the transferred heat flow is estimated with respect to actual efficiency within a performance map.</p>
<p><br>Further assumptions are used:</p>
<ul>
<li>The quadratic coefficient <span style=\"font-family: Courier New;\">coeffPresLoss </span>is described by a fit-function from manufacturer data.</li>
<li>The volume <span style=\"font-family: Courier New;\">vol.V</span> bases on a fit from manufacturer data.</li>
<li>G: Thermal conductance is described by a fit 0.0465 * QNom/1000 + 4.9891 from manufacturere data at a temperature difference of 50 K to ambient</li>
<li>C: Factor C/QNom is in range of 1.2 to 2 for boilers with nominal power between 460 kW and 80 kW (with c of 500J/kgK for steel). Thus, a value of 1.5 is used as default. (see AixLib.Fluid.BoilerCHP.BoilerNoControl)</li>
</ul>
</html>",
        revisions="<html>
<ul>
<li><i>June, 2023&nbsp;</i> by Moritz Zuschlag &amp; David Jansen</li>
</ul>
</html>"));
end BoilerGeneric;
