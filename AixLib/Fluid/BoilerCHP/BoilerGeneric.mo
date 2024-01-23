within AixLib.Fluid.BoilerCHP;
model BoilerGeneric "Generic performance map based boiler"

  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    T_start=TSupNom,
    a=coeffPresLoss,
    redeclare package Medium=AixLib.Media.Water,
    vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(1.1615*
          QNom/1000)/1000),
    final m_flow_nominal=QNom/(Medium.cp_const*(TSupNom - TRetNom)),
    final dp_nominal=m_flow_nominal^2*a/(Medium.d_const^2));

  parameter Modelica.Units.SI.HeatFlowRate QNom       "Design thermal capacity";

  parameter Modelica.Units.SI.Temperature TSupNom=353.15
    "Design supply temperature" annotation (Dialog(group="Design"),Evaluate=false);

  parameter Modelica.Units.SI.Temperature TRetNom=333.15
    "Design return temperature" annotation (Dialog(group="Design"),Evaluate=false);

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=C,
      T(start=T_start))            "Boiler thermal capacity (dry weight)"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-18,-50})));
  BaseClasses.OffDesignOperation offDesignOperation(
    QNom=QNom,
    TSupNom=TSupNom,
    TRetNom=TRetNom) "off design operation"
    annotation (Placement(transformation(extent={{30,70},{50,90}})));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor conductanceToEnv(final G=
        0.0465*QNom/1000 + 4.9891)
                             "Thermal resistance of the boiler casing"
    annotation (Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-38,-34})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = 293.15) "Temperature of environment around the boiler to account for heat losses"
    annotation (Placement(transformation(extent={{14,-40},{2,-28}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-26,-28},{-14,-40}})));
  Controls.Interfaces.BoilerControlBus                     boilerControlBus
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor( final T(unit="K"))
    annotation (Placement(transformation(extent={{-50,-26},{-30,-6}})));
  BaseClasses.DesignOperation designOperation(
    QNom=QNom,
    TSupNom=TSupNom,
    TRetNom=TRetNom) "designOperation for design fuel power"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Math.Product fuelPower(final y(unit="W")) "fuel power" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-44,48})));
  Modelica.Blocks.Math.Product thermalPower(final y(unit="W")) "thermal power"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-38,14})));
protected
  parameter Real coeffPresLoss=7.143*10^8*exp(-0.007078*QNom/1000)
    "Pressure loss coefficient of the heat generator";
  parameter Modelica.Units.SI.HeatCapacity C=1.5*QNom
    "Heat capacity of metal (J/K)";

equation

  connect(vol.heatPort, internalCapacity.port) annotation (Line(points={{-50,-70},
          {-50,-50},{-28,-50}},           color={191,0,0}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{-14,-34},{2,-34}}, color={191,0,0}));
  connect(conductanceToEnv.port_b, heatFlowSensor.port_a)
    annotation (Line(points={{-32,-34},{-26,-34}}, color={191,0,0}));
  connect(conductanceToEnv.port_a, vol.heatPort)
    annotation (Line(points={{-44,-34},{-50,-34},{-50,-70}}, color={191,0,0}));
  connect(vol.heatPort, temperatureSensor.port)
    annotation (Line(points={{-50,-70},{-50,-16}}, color={191,0,0}));
  connect(designOperation.NomFueDem, fuelPower.u2)
    annotation (Line(points={{-50,69},{-50,60}}, color={0,0,127}));
  connect(thermalPower.y, heater.Q_flow) annotation (Line(points={{-38,3},{-38,
          0},{-60,0},{-60,-40}},           color={0,0,127}));
  connect(boilerControlBus.FirRatSet, fuelPower.u1) annotation (Line(
      points={{0,100},{0,66},{-38,66},{-38,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thermalPower.y, boilerControlBus.ThermalPower) annotation (Line(
        points={{-38,3},{-38,0},{0,0},{0,100}},                      color={0,0,
          127}), Text(
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
  connect(fuelPower.y, thermalPower.u2)
    annotation (Line(points={{-44,37},{-44,26}}, color={0,0,127}));
  connect(boilerControlBus.Efficiency, thermalPower.u1) annotation (Line(
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
  connect(temperatureSensor.T, boilerControlBus.TSupMea) annotation (Line(
        points={{-29,-16},{-14,-16},{-14,-14},{0,-14},{0,100}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fuelPower.y, boilerControlBus.fuelPower) annotation (Line(points={{-44,
          37},{-44,32},{0,32},{0,100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>The model differs between <a href=\"AixLib.Fluid.BoilerCHP.BaseClasses.DesignOperation\">DesignOperation</a> and <a href=\"AixLib.Fluid.BoilerCHP.BaseClasses.OffDesignOperation\">OffDesignOperation</a>.</p>
<p>In <a href=\"AixLib.Fluid.BoilerCHP.BaseClasses.DesignOperation\">DesignOperation</a> for nominal conditions the (max) fuel power is estimated. The <a href=\"AixLib.Fluid.BoilerCHP.BaseClasses.OffDesignOperation\">OffDesignOperation</a> fuel consumption is estimated via firing rate. </p>
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
