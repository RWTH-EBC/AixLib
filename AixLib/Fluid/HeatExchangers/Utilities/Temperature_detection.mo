within AixLib.Fluid.HeatExchangers.Utilities;
block Temperature_detection "Temperature detection for Heat Transfer"

  Modelica.Blocks.Math.Add T_HS_return(k1=+1, u1(
      min=253.15,
      max=323.15,
      nominal=278.15)) "y = T_HS_in * y(prod3)" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-50})));
  Modelica.Blocks.Math.Add T_DH_return(k1=-1, u2(
      min=253.15,
      max=323.15,
      nominal=278.15)) "y = y(prod4) *  T_DH_in" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-50})));
  Modelica.Blocks.Math.Product prod4 "y = Delta_T * P1(effectiveness)"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-16})));
  Modelica.Blocks.Math.Product prod3 "y =P2(effectiveness) * Delta_T"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-16})));
  Modelica.Blocks.Math.Add Delta_T(
    k1=-1,
    u1(
      min=253.15,
      max=323.15,
      nominal=278.15),
    u2(
      min=253.15,
      max=323.15,
      nominal=278.15)) "Delta_T = - T_HS_in + T_DH_in" annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={0,22})));
  Utilities.Inputs4toOutputs2 effectiveness(A=140, k=4000)
    annotation (Placement(transformation(extent={{-10,46},{10,66}})));
  Modelica.Blocks.Interfaces.RealInput T_HS_in(
    min=253.15,
    max=323.15,
    nominal=303.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={80,100})));
  Modelica.Blocks.Interfaces.RealInput T_DH_in(
    min=253.15,
    max=323.15,
    nominal=278.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-80,100})));
  Modelica.Blocks.Interfaces.RealOutput T_HS_out(
    min=253.15,
    max=323.15,
    nominal=278.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={80,-100})));
  Modelica.Blocks.Interfaces.RealOutput T_DH_out(
    min=253.15,
    max=323.15,
    nominal=303.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-80,-100})));
  Modelica.Blocks.Interfaces.RealInput cp_DH(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-20,100})));
  Modelica.Blocks.Interfaces.RealInput cp_HS(
    min=1,
    max=5000,
    nominal=4000,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={20,100})));
  Modelica.Blocks.Interfaces.RealInput m_flow_DH(
    min=0,
    max=50,
    nominal=17.5,
    quantity="MassFlowRate",
    unit="kg/s") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput m_flow_HS(
    min=0,
    max=50,
    nominal=17.5,
    quantity="MassFlowRate",
    unit="kg/s") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={40,100})));
equation
  connect(prod3.y, T_HS_return.u2)
    annotation (Line(points={{40,-27},{74,-27},{74,-38}}, color={0,0,127}));
  connect(prod4.y, T_DH_return.u1) annotation (Line(points={{-40,-27},{-40,-30},
          {-74,-30},{-74,-38}}, color={0,0,127}));
  connect(Delta_T.y, prod3.u2) annotation (Line(points={{-2.22045e-015,8.8},{-2.22045e-015,
          4.85},{34,4.85},{34,-4}}, color={0,0,127}));
  connect(Delta_T.y, prod4.u1) annotation (Line(points={{-2.22045e-015,8.8},{-2.22045e-015,
          4.85},{-34,4.85},{-34,-4}}, color={0,0,127}));
  connect(effectiveness.P2, prod3.u1)
    annotation (Line(points={{4,46},{4,42},{46,42},{46,-4}}, color={0,0,127}));
  connect(effectiveness.P1, prod4.u2) annotation (Line(points={{-4,46},{-4,42},
          {-46,42},{-46,-4}}, color={0,0,127}));
  connect(T_HS_in, Delta_T.u1) annotation (Line(points={{80,100},{80,100},{80,
          60},{20,60},{20,44},{7.2,44},{7.2,36.4}}, color={0,0,127}));
  connect(T_DH_in, Delta_T.u2) annotation (Line(points={{-80,100},{-80,100},{-80,
          60},{-20,60},{-20,44},{-7.2,44},{-7.2,40},{-7.2,36.4}}, color={0,0,
          127}));
  connect(T_HS_in, T_HS_return.u1) annotation (Line(points={{80,100},{80,60},{
          86,60},{86,-38}}, color={0,0,127}));
  connect(T_HS_out, T_HS_return.y)
    annotation (Line(points={{80,-100},{80,-84},{80,-61}}, color={0,0,127}));
  connect(T_DH_in, T_DH_return.u2) annotation (Line(points={{-80,100},{-80,100},
          {-80,82},{-80,22},{-86,22},{-86,-38}}, color={0,0,127}));
  connect(T_DH_out, T_DH_return.y) annotation (Line(points={{-80,-100},{-80,-82},
          {-80,-61}}, color={0,0,127}));
  connect(cp_DH, effectiveness.cp_DH) annotation (Line(points={{-20,100},{-20,
          100},{-20,84},{-2,84},{-2,66}}, color={0,0,127}));
  connect(cp_HS, effectiveness.cp_HS) annotation (Line(points={{20,100},{20,84},
          {2,84},{2,66}}, color={0,0,127}));
  connect(m_flow_DH, effectiveness.m_flow_DH) annotation (Line(points={{-40,100},
          {-40,100},{-40,72},{-38,72},{-6,72},{-6,66}}, color={0,0,127}));
  connect(m_flow_HS, effectiveness.m_flow_HS) annotation (Line(points={{40,100},
          {40,100},{40,84},{40,72},{6,72},{6,66}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(revisions="<html>
<ul>
<li><i>2017-04-25</i> by Peter Matthes:<br>Renames inputs and outputs. Adds units to inputs and outputs. Changes &QUOT;model&QUOT; into &QUOT;block&QUOT;.</li>
</ul>
</html>"));
end Temperature_detection;
