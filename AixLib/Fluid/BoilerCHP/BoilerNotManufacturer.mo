within AixLib.Fluid.BoilerCHP;
model BoilerNotManufacturer "Simple heat generator without control"
  extends AixLib.Fluid.BoilerCHP.BaseClasses.PartialHeatGenerator(
    redeclare package Medium = Media.Water,
        a=coeffPresLoss, vol(energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial, V=(1.1615*QNom/1000)/1000));

  parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=15 "Nominal temperature difference heat circuit";
  parameter Modelica.Units.SI.TemperatureDifference dTWaterSet=15 "Setpoint temperature difference heat circuit";
  parameter Modelica.Units.SI.Temperature TColdNom=273.15+35 "Nominal TCold";
  parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Nominal thermal power";
  parameter Boolean m_flowVar=false "Boolean for use of variable water massflow";
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";



  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor internalCapacity(final C=C,
      T(start=T_start))            "Boiler thermal capacity (dry weight)"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-18,-50})));
  BaseClasses.Controllers.StationaryBehaviour DemandCalc(
    TColdNom=TColdNom,
    QNom=QNom,
    dTWaterNom=dTWaterNom,
    m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{-30,70},{-10,90}})));
  BaseClasses.Controllers.ReturnInfluence HeatCalc(
    TColdNom=TColdNom,
    QNom=QNom,
    dTWaterNom=dTWaterNom,
    m_flowVar=m_flowVar)
    annotation (Placement(transformation(extent={{4,36},{24,56}})));
  Modelica.Blocks.Interfaces.RealInput PLR "Part Load Ratio" annotation (
      Placement(transformation(extent={{-140,34},{-100,74}}),
        iconTransformation(extent={{-140,34},{-100,74}})));
      Modelica.Blocks.Interfaces.RealInput dTWater
    "temperature difference THot-TCold"            annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,90})));

  Modelica.Blocks.Sources.RealExpression RealZero(y=0) "RealZero"
    annotation (Placement(transformation(extent={{0,62},{20,82}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
    annotation (Placement(transformation(extent={{-76,48},{-64,60}})));
  Modelica.Blocks.Interfaces.RealOutput PowerDemand(quantity="Power", final
      unit="W") "Power demand" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,20}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-70})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ConductanceToEnv(final G=
        QNom*0.003/50)
                 "Thermal resistance of the boiler casing" annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-38,-34})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = 283.15)
    annotation (Placement(transformation(extent={{14,-40},{2,-28}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{-26,-28},{-14,-40}})));
  Modelica.Blocks.Interfaces.RealOutput TVolume "TVolume" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Modelica.Blocks.Math.Gain gain(k=1)
    annotation (Placement(transformation(extent={{-4,-8},{-16,4}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{18,104},{38,124}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{92,82},{112,102}})));
  Modelica.Blocks.Interfaces.BooleanInput OnOff
    annotation (Placement(transformation(extent={{-236,52},{-196,92}})));
  Modelica.Blocks.Interfaces.RealOutput TColdBoiler annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={152,-2}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-70})));
protected
    parameter Real coeffPresLoss=7.143*10^8*exp(-0.007078*QNom/1000)
    "Pressure loss coefficient of the heat generator";
  parameter Modelica.Units.SI.HeatCapacity C=1.5*QNom
    "Heat capacity of metal (J/K)";

equation
TVolume=vol.T;

  connect(vol.heatPort, internalCapacity.port) annotation (Line(points={{-50,-70},
          {-50,-50},{-28,-50}},           color={191,0,0}));
  connect(dTWater, DemandCalc.dTWater) annotation (Line(points={{-120,90},{-76,90},
          {-76,82},{-32,82}}, color={0,0,127}));
  connect(dTWater, HeatCalc.dTWater) annotation (Line(points={{-120,90},{-84,90},
          {-84,39},{2,39}}, color={0,0,127}));
  connect(PLR, limiter.u) annotation (Line(points={{-120,54},{-77.2,54}},
                              color={0,0,127}));
  connect(limiter.y, HeatCalc.PLR) annotation (Line(points={{-63.4,54},{-40,54},
          {-40,46},{2,46}}, color={0,0,127}));
  connect(limiter.y, DemandCalc.PLR) annotation (Line(points={{-63.4,54},{-60,54},
          {-60,86},{-32,86}}, color={0,0,127}));
  connect(heatFlowSensor.port_b, fixedTemperature.port)
    annotation (Line(points={{-14,-34},{2,-34}}, color={191,0,0}));
  connect(ConductanceToEnv.port_b, heatFlowSensor.port_a)
    annotation (Line(points={{-32,-34},{-26,-34}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, DemandCalc.QLosses)
    annotation (Line(points={{-20,-27.4},{-20,68}},
                                                  color={0,0,127}));
  connect(senTCold.T, HeatCalc.TColdMeasure) annotation (Line(points={{-70,-69},
          {-70,4},{-26,4},{-26,53},{2,53}}, color={0,0,127}));
  connect(heatFlowSensor.Q_flow, HeatCalc.QLosses) annotation (Line(points={{-20,
          -27.4},{-20,20},{14,20},{14,34}},
                                          color={0,0,127}));
  connect(ConductanceToEnv.port_a, vol.heatPort)
    annotation (Line(points={{-44,-34},{-50,-34},{-50,-70}}, color={191,0,0}));
  connect(gain.y, heater.Q_flow) annotation (Line(points={{-16.6,-2},{-60,-2},{
          -60,-40}},  color={0,0,127}));
  connect(DemandCalc.PowerDemand, switch1.u1)
    annotation (Line(points={{-20,91},{-20,122},{16,122}}, color={0,0,127}));
  connect(switch1.y, PowerDemand) annotation (Line(points={{39,114},{170,114},{
          170,60},{92,60},{92,20},{110,20}}, color={0,0,127}));
  connect(HeatCalc.Q_flow, switch2.u1) annotation (Line(points={{25,46},{52,46},
          {52,100},{90,100}}, color={0,0,127}));
  connect(switch2.y, gain.u) annotation (Line(points={{113,92},{118,92},{118,62},
          {68,62},{68,-2},{-2.8,-2}}, color={0,0,127}));
  connect(RealZero.y, switch1.u3) annotation (Line(points={{21,72},{30,72},{30,
          94},{6,94},{6,106},{16,106}}, color={0,0,127}));
  connect(RealZero.y, switch2.u3) annotation (Line(points={{21,72},{40,72},{40,
          84},{90,84}}, color={0,0,127}));
  connect(OnOff, switch1.u2) annotation (Line(points={{-216,72},{-164,72},{-164,
          114},{16,114}},                     color={255,0,255}));
  connect(OnOff, switch2.u2) annotation (Line(points={{-216,72},{-126,72},{-126,
          74},{78,74},{78,92},{90,92}}, color={255,0,255}));
  connect(senTCold.T, TColdBoiler) annotation (Line(points={{-70,-69},{-70,-16},
          {128,-16},{128,-2},{152,-2}}, color={0,0,127}));
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>A boiler model consisting of physical components.The efficiency is based on the part load rate and the inflow water temperature.</p>
<p><br>Assumptions for predefined parameter values (based on Vissmann data cheat) as given by BoilerNoControl:</p>
<p>G: a heat loss of 0.3 &percnt; of nominal power at a temperature difference of 50 K to ambient is assumed.</p>
<p>C: factor C/Q_nom is in range of 1.2 to 2 for boilers with nominal power between 460 kW and 80 kW (with c of 500J/kgK for steel). Thus, a value of 1.5 is used as default.</p>
<p><br>Further informations are described in the submodels &quot;Set&quot; and &quot;ReturnInfluence&quot;. </p>
</html>",
        revisions="<html>
<ul>
<li><i>December 08, 2016&nbsp;</i> by Moritz Lauster:<br/>Adapted to AixLib
conventions</li>
<li><i>October 11, 2016&nbsp;</i> by Pooyan Jahangiri:<br/>First
implementation</li>
</ul>
</html>"));
end BoilerNotManufacturer;
