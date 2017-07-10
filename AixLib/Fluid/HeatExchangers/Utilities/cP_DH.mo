within AixLib.Fluid.HeatExchangers.Utilities;
model cP_DH
  "Calculation of the fluid's specific heat capacity in the cold circuit"

  Modelica.Blocks.Math.Add dh_cp_DH(
    k1=+1,
    k2=-1,
    u1(
      min=1,
      max=5000,
      nominal=4000),
    u2(
      min=1,
      max=5000,
      nominal=4000)) "h_out-h_in"
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica.Blocks.Math.Add dT_cp_DH(
    k1=+1,
    k2=-1,
    u1(
      min=253.15,
      max=323.15,
      nominal=293.15),
    u2(
      min=253.15,
      max=323.15,
      nominal=278.15)) "T_out-T_in"
    annotation (Placement(transformation(extent={{-78,-52},{-58,-32}})));
  Modelica.Blocks.Math.Division division_cp_DH(
    u1(
      min=-5000,
      max=5000,
      nominal=4000),
    u2(
      min=0.1,
      max=50,
      nominal=20),
    y(min=1,
      max=5000,
      nominal=4000)) "cp = dh/dT"
    annotation (Placement(transformation(extent={{12,-10},{32,10}})));
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
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificEnergy",
    unit="J/kg") annotation (Placement(transformation(rotation=0, extent={{-110,
            50},{-90,70}})));
  Modelica.Blocks.Interfaces.RealInput h_in(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificEnergy",
    unit="J/kg") annotation (Placement(transformation(rotation=0, extent={{-110,
            10},{-90,30}})));
  Modelica.Blocks.Interfaces.RealOutput cp(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)") "specific heat capacity at constant pressure" annotation (
      Placement(transformation(rotation=0, extent={{90,-10},{110,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{54,-68},{74,-48}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=
        tempDiffOverrideAtStart)
    annotation (Placement(transformation(extent={{14,-58},{34,-38}})));
  Modelica.Blocks.Sources.Clock clock
    annotation (Placement(transformation(extent={{-34,-64},{-24,-54}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent={{-2,-70},{12,-54}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=
        delayOverrideTempDiffAtStart)
    annotation (Placement(transformation(extent={{-42,-64},{-22,-84}})));
  parameter Modelica.SIunits.Time delayOverrideTempDiffAtStart=0
    "during this amount of seconds at simulation start temperature difference will be ==1 K. After that time switch to real dT occurs (what a mess).";
  parameter Modelica.SIunits.TemperatureDifference tempDiffOverrideAtStart=1
    "The override value for temperature difference at start of simulation.";
equation
  connect(dh_cp_DH.y, division_cp_DH.u1) annotation (Line(points={{-29,40},{-16,
          40},{-16,6},{10,6}}, color={0,0,127}));
  connect(T_out, dT_cp_DH.u1) annotation (Line(points={{-100,-20},{-100,-20.4},
          {-80,-20.4},{-80,-36}}, color={0,0,127}));
  connect(T_in, dT_cp_DH.u2) annotation (Line(points={{-100,-60},{-100,-61.6},{
          -80,-61.6},{-80,-48}}, color={0,0,127}));
  connect(h_out, dh_cp_DH.u1)
    annotation (Line(points={{-100,60},{-52,60},{-52,46}}, color={0,0,127}));
  connect(h_in, dh_cp_DH.u2) annotation (Line(points={{-100,20},{-80,20},{-80,
          34},{-52,34}}, color={0,0,127}));
  connect(cp, division_cp_DH.y)
    annotation (Line(points={{100,0},{62,0},{33,0}}, color={0,0,127}));
  connect(realExpression.y, switch1.u1) annotation (Line(points={{35,-48},{44,-48},
          {44,-50},{52,-50}}, color={0,0,127}));
  connect(switch1.y, division_cp_DH.u2) annotation (Line(points={{75,-58},{80,-58},
          {80,-22},{-12,-22},{-12,-6},{10,-6}}, color={0,0,127}));
  connect(clock.y, less.u1) annotation (Line(
      points={{-23.5,-59},{-13.75,-59},{-13.75,-62},{-3.4,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realExpression3.y, less.u2) annotation (Line(
      points={{-21,-74},{-14,-74},{-14,-68.4},{-3.4,-68.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(less.y, switch1.u2) annotation (Line(
      points={{12.7,-62},{32,-62},{32,-58},{52,-58}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(dT_cp_DH.y, switch1.u3) annotation (Line(
      points={{-57,-42},{-54,-42},{-54,-90},{42,-90},{42,-66},{52,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(revisions="<html>
<ul>
<li><i>2017-04-25</i> by Peter Matthes:<br>Renames inputs and outputs. Adds units to inputs and outputs. Changes &QUOT;model&QUOT; into &QUOT;block&QUOT;.<br>(There will be a devision by zero when temperature difference aproaches zero! Also, the override function is for simulation start is a really dirty hack and should not be used. I propagated the hard-coded values a level up and deactivated it by setting the delay time to zero as default value.)</li>
</ul>
</html>"));
end cP_DH;
