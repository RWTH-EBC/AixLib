within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model InternalControl

  parameter AixLib.DataBase.Boiler.General.BoilerTwoPointBaseDataDefinition
    paramBoiler = AixLib.DataBase.Boiler.General.Boiler_Vitogas200F_11kW()
    "Parameters for boiler"
  annotation (Dialog(tab = "General", group = "Boiler type"), choicesAllMatching = true);
  parameter Real KR = 1 "Gain of boiler heater";
  parameter Modelica.SIunits.Time TN = 0.1
      "Time constant of boiler heater (T>0 required)";
  parameter Modelica.SIunits.Time riseTime=30
      "Rise/fall time for step input(T>0 required)";
  Real outputPower;
  Controls.Continuous.PITemp                ControlerHeater(
    KR=KR,
    TN=TN,
    h=paramBoiler.Q_nom,
    l=paramBoiler.Q_min,
    triggeredTrapezoid(rising=riseTime, falling=riseTime),
    rangeSwitch=false) "PI temperature controller"
    annotation (Placement(transformation(extent={{-40.5,36},{-24,52.5}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn "On/Off switch for the boiler"
    annotation (Placement(transformation(extent={{-112.5,27},{-87,52.5}}),
        iconTransformation(
        extent={{-12.75,-12.75},{12.75,12.75}},
        rotation=-90,
        origin={-24.75,102.75})));
  Utilities.Sensors.EnergyMeter         eEnergyMeter_P
      "For primary energy consumption"
    annotation (Placement(transformation(extent={{30,63},{49.5,84}})));

  Utilities.Sensors.EnergyMeter         eEnergyMeter_S
      "For secondary energy consumption"
    annotation (Placement(transformation(extent={{30,82.5},{49.5,103.5}})));
  Modelica.Blocks.Tables.CombiTable1D efficiencyTable(
    tableOnFile=false,
    table=paramBoiler.eta,
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) "Table with efficiency parameters"
    annotation (Placement(transformation(extent={{4.5,4.5},{15,15}})));
  Modelica.Blocks.Interfaces.RealInput Tflow_set
      "Target temperature of the controller[K]"  annotation (Placement(
        transformation(
        extent={{-15.25,-15.25},{15.25,15.25}},
        rotation=0,
        origin={-100.75,81.25}), iconTransformation(
        extent={{-12.875,-12.875},{12.875,12.875}},
        rotation=-90,
        origin={20.375,101.125})));
  Modelica.Blocks.Math.Gain QNormated(k=1/paramBoiler.Q_nom)
    annotation (Placement(transformation(extent={{-13.5,6},{-4.5,15}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{21,24},{30,33}})));
  Modelica.Blocks.Interfaces.RealInput Tflow_hot "Outgoing temperature [K]"
    annotation (Placement(transformation(extent={{-126.5,-20},{-86.5,20}}),
        iconTransformation(extent={{113,3},{87,29}})));
  Modelica.Blocks.Interfaces.RealOutput QflowHeater
      "Connector of real output signal"
    annotation (Placement(transformation(extent={{66.5,18.5},{86.5,38.5}}),
        iconTransformation(extent={{-90.5,29},{-110.5,49}})));
  Modelica.Blocks.Interfaces.RealInput mFlow
      "Mass flow through the boiler [kg/s]"
    annotation (Placement(transformation(extent={{-125,-84.5},{-85,-44.5}}),
        iconTransformation(extent={{114.5,-63},{87,-35.5}})));
  Modelica.Blocks.Interfaces.RealInput Tflow_cold
      "Temperature of the cold water[K]"   annotation (Placement(transformation(
          extent={{-125,-51.5},{-85,-11.5}}), iconTransformation(extent={{114.5,
            -30},{87,-2.5}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature "Converts Tflow_hot real input to temperature"
    annotation (Placement(transformation(extent={{-69,-7.5},{-54,7.5}})));
equation

  if cardinality(isOn) < 2 then
    isOn = true;
  end if;

  outputPower = mFlow * 4184 * (Tflow_hot - Tflow_cold);
  eEnergyMeter_S.p=outputPower;

  connect(ControlerHeater.y, eEnergyMeter_P.p)
                                    annotation (Line(
      points={{-24.825,44.25},{4.5,44.25},{4.5,73.5},{30.65,73.5}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ControlerHeater.y, QNormated.u) annotation (Line(
      points={{-24.825,44.25},{-18,44.25},{-18,10.5},{-14.4,10.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(QNormated.y,efficiencyTable. u[1]) annotation (Line(
      points={{-4.05,10.5},{-0.3,10.5},{-0.3,9.75},{3.45,9.75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ControlerHeater.y, product.u1) annotation (Line(
      points={{-24.825,44.25},{4.5,44.25},{4.5,31.5},{12,31.5},{20.1,31.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(efficiencyTable.y[1], product.u2) annotation (Line(
      points={{15.525,9.75},{19.5,9.75},{19.5,25.8},{20.1,25.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(product.y, QflowHeater) annotation (Line(
      points={{30.45,28.5},{76.5,28.5}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ControlerHeater.setPoint, Tflow_set) annotation (Line(points={{-38.85,
          51.675},{-38.85,81.25},{-100.75,81.25}}, color={0,0,127}));
  connect(ControlerHeater.onOff, isOn) annotation (Line(points={{-39.675,40.125},
          {-66.3375,40.125},{-66.3375,39.75},{-99.75,39.75}}, color={255,0,255}));
  connect(Tflow_hot, prescribedTemperature.T) annotation (Line(points={{-106.5,
          0},{-88.5,0},{-70.5,0}}, color={0,0,127}));
  connect(prescribedTemperature.port, ControlerHeater.Therm1) annotation (Line(
        points={{-54,0},{-37.2,0},{-37.2,36.825}}, color={191,0,0}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5})),           Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1.5,1.5}), graphics={Rectangle(
          extent={{-82.5,87},{88.5,-73.5}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-79.5,27},{87,-3}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Internal control of the boiler</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><br><h4><span style=\"color:#008000\">Concept</span></h4></p>
<p>This model is a derivation of BoilerTaktTable.</p>
<p>There is a differentiation made between primary and secondary energy consumption.</p>
<p>The primary power output can be read at the output of <b>ControlerHeater. </b>It is then multiplied with an efficienca factor to calculate the the effective heat flow that heats up the fluid in the boiler<b>.</b></p>
<p>There are two energy meters: one for the primary energy and one for the secondary. The secondary power output is calculated as:</p>
<p><img src=\"modelica://HVAC/Images/equations/equation-4pZqzkAy.png\" alt=\"P_sec = m_flow *c_p*(T_2-T_1)\"/></p>
<p>Where T2 is the temperature of the fluid leaving the heater and T1 ist the temperature of the fluid entering the heater. </p>
</html>",
revisions="<html>
<p><ul>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>Merged with AixLib</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>July 12, 2011</i> by Ana Constantin:<br/>Implemented</li>
</ul></p>
</html>"));
end InternalControl;
