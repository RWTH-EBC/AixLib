within AixLib.Fluid.HeatExchangers.Utilities;
block cP_HS
  "Calculation of the fluid's specific heat capacity in the warm circuit"

  Modelica.Blocks.Math.Add dh_cp_HS(
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
    annotation (Placement(transformation(extent={{58,34},{46,46}})));
  Modelica.Blocks.Math.Add dT_cp_HS(
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
    annotation (Placement(transformation(extent={{56,-46},{44,-34}})));
  Modelica.Blocks.Math.Division division_cp_HS(
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
    annotation (Placement(transformation(extent={{-26,-10},{-46,10}})));
  Modelica.Blocks.Interfaces.RealInput T_out(
    min=253.15,
    max=323.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC",
    nominal=278.15) annotation (Placement(transformation(rotation=0, extent={{110,
            -30},{90,-10}})));
  Modelica.Blocks.Interfaces.RealInput T_in(
    min=253.15,
    max=323.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC",
    nominal=303.15) annotation (Placement(transformation(rotation=0, extent={{110,
            -70},{90,-50}})));
  Modelica.Blocks.Interfaces.RealInput h_out(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificEnergy",
    unit="J/kg") annotation (Placement(transformation(rotation=0, extent={{110,
            50},{90,70}})));
  Modelica.Blocks.Interfaces.RealInput h_in(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificEnergy",
    unit="J/kg") annotation (Placement(transformation(rotation=0, extent={{110,
            10},{90,30}})));
  Modelica.Blocks.Interfaces.RealOutput cp(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)") "specific heat capacity at constant pressure" annotation (
      Placement(transformation(rotation=0, extent={{-90,-10},{-110,10}})));
equation
  connect(dh_cp_HS.y, division_cp_HS.u1) annotation (Line(points={{45.4,40},{16,
          40},{16,6},{-24,6}},           color={0,0,127}));
  connect(T_out, dT_cp_HS.u1) annotation (Line(points={{100,-20},{100,-20},{78,-20},
          {78,-36.4},{68,-36.4},{57.2,-36.4}}, color={0,0,127}));
  connect(T_in, dT_cp_HS.u2) annotation (Line(points={{100,-60},{98,-60},{77.2,-60},
          {77.2,-43.6},{57.2,-43.6}}, color={0,0,127}));
  connect(h_out, dh_cp_HS.u1) annotation (Line(points={{100,60},{90,60},{69.2,60},
          {69.2,43.6},{59.2,43.6}}, color={0,0,127}));
  connect(h_in, dh_cp_HS.u2) annotation (Line(points={{100,20},{100,20},{80,20},
          {69.2,20},{69.2,36.4},{59.2,36.4}}, color={0,0,127}));
  connect(cp, division_cp_HS.y)
    annotation (Line(points={{-100,0},{-47,0}}, color={0,0,127}));
  connect(dT_cp_HS.y, division_cp_HS.u2) annotation (Line(
      points={{43.4,-40},{10,-40},{10,-6},{-24,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (                                 Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Documentation(revisions="<html>
<ul>
<li><i>2017-04-25</i> by Peter Matthes:<br>Renames inputs and outputs. Adds units to inputs and outputs. Changes &QUOT;model&QUOT; into &QUOT;block&QUOT;.<br>(There will be a devision by zero when temperature difference aproaches zero!)</li>
</ul>
</html>"));
end cP_HS;
