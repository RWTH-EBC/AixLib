within AixLib.Fluid.HeatExchangers.Utilities;
block cpCalc "Calculation of the fluid's specific heat capacity"

  Modelica.Blocks.Math.Add dHCalc(
    k1=+1,
    k2=-1,
    u1(
      min=1.0,
      max=5000.0,
      nominal=4000.0,
      quantity="SpecificEnergy",
      unit="J/kg"),
    u2(
      min=1.0,
      max=5000.0,
      nominal=4000.0,
      quantity="SpecificEnergy",
      unit="J/kg")) "h_out-h_in"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Math.Add dTCalc(
    k1=+1,
    k2=-1,
    u1(
      min=253.15,
      max=323.15,
      nominal=293.15,
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC"),
    u2(
      min=253.15,
      max=323.15,
      nominal=278.15,
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC"),
    y(min=0.001,
      max=50.0,
      nominal=20.0,
      quantity="TemperatureDifference",
      unit="K",
      displayUnit="K")) "T_out-T_in"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Math.Division division_cp(
    u1(
      min=-5000.0,
      max=5000.0,
      nominal=4000.0,
      quantity="SpecificEnergy",
      unit="J/kg"),
    u2(
      min=0.1,
      max=50.0,
      nominal=20.0,
      quantity="TemperatureDifference",
      unit="K",
      displayUnit="K"),
    y(min=1.0,
      max=5000.0,
      nominal=4000.0,
      quantity="SpecificHeatCapacity",
      unit="J/(kg.K)")) "cp = dh/dT"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealInput T_out(
    min=253.15,
    max=323.15,
    nominal=293.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(rotation=0, extent=
           {{-110,-30},{-90,-10}})));
  Modelica.Blocks.Interfaces.RealInput T_in(
    min=253.15,
    max=323.15,
    nominal=278.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(rotation=0, extent=
           {{-110,-70},{-90,-50}})));
  Modelica.Blocks.Interfaces.RealInput h_out(
    min=1.0,
    max=5000.0,
    nominal=4000.0,
    quantity="SpecificEnergy",
    unit="J/kg") annotation (Placement(transformation(rotation=0, extent={{-110,
            50},{-90,70}})));
  Modelica.Blocks.Interfaces.RealInput h_in(
    min=1.0,
    max=5000.0,
    nominal=4000.0,
    quantity="SpecificEnergy",
    unit="J/kg") annotation (Placement(transformation(rotation=0, extent={{-110,
            10},{-90,30}})));
  Modelica.Blocks.Interfaces.RealOutput cp(
    min=1.0,
    max=5000.0,
    nominal=4000.0,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)") "specific heat capacity at constant pressure" annotation (
      Placement(transformation(rotation=0, extent={{90,-10},{110,10}})));
  Modelica.Blocks.Continuous.CriticalDamping criticalDamping(
    x_start={0.001},
    n=1,
    f=10)
         annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
equation
  connect(dHCalc.y, division_cp.u1) annotation (Line(points={{-39,40},{20,40},{20,
          6},{38,6}},     color={0,0,127}));
  connect(T_out, dTCalc.u1) annotation (Line(points={{-100,-20},{-100,-20},{-80,
          -20},{-80,-34},{-62,-34}},
                             color={0,0,127}));
  connect(h_out, dHCalc.u1)
    annotation (Line(points={{-100,60},{-80,60},{-80,46},{-62,46}},
                                                           color={0,0,127}));
  connect(h_in, dHCalc.u2) annotation (Line(points={{-100,20},{-80,20},{-80,34},
          {-62,34}}, color={0,0,127}));
  connect(cp, division_cp.y)
    annotation (Line(points={{100,0},{61,0}}, color={0,0,127}));
  connect(dTCalc.y, criticalDamping.u)
    annotation (Line(points={{-39,-40},{-39,-40},{-22,-40}}, color={0,0,127}));
  connect(criticalDamping.y, division_cp.u2) annotation (Line(points={{1,-40},{1,
          -40},{20,-40},{20,-6},{38,-6}},    color={0,0,127}));
  connect(T_in, dTCalc.u2) annotation (Line(points={{-100,-60},{-80,-60},{-80,-46},
          {-62,-46}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(revisions="<html>
<ul>
<li><i>2017-04-25</i> by Peter Matthes:<br>Renames inputs and outputs. Adds units to inputs and outputs. Changes &QUOT;model&QUOT; into &QUOT;block&QUOT;.<br>(There will be a devision by zero when temperature difference aproaches zero! Also, the override function is for simulation start is a really dirty hack and should not be used. I propagated the hard-coded values a level up and deactivated it by setting the delay time to zero as default value.)</li>
</ul>
</html>"));
end cpCalc;
