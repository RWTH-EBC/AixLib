within AixLib.Fluid.HeatExchangers.Utilities;
model Temperature_detection "Temperature detection for Heat Transfer"

  Modelica.Blocks.Math.Add T_Forward_HS(k1=+1, u1(
      min=253.15,
      max=323.15,
      nominal=278.15)) "y = T_HS_in * y(prod3)" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-50})));
  Modelica.Blocks.Math.Add T_Return_DH(k1=-1, u2(
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
  Modelica.Blocks.Interfaces.RealInput u1(
    min=253.15,
    max=323.15,
    nominal=278.15) annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={80,100})));
  Modelica.Blocks.Interfaces.RealInput u2(
    min=253.15,
    max=323.15,
    nominal=278.15) annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-80,100})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={80,-100})));
  Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-80,-100})));
  Modelica.Blocks.Interfaces.RealInput C_P_DH annotation (Placement(
        transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-20,100})));
  Modelica.Blocks.Interfaces.RealInput C_P_HS annotation (Placement(
        transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={20,100})));
  Modelica.Blocks.Interfaces.RealInput MassFlowRate_DH annotation (Placement(
        transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput MassFlowRate_HS annotation (Placement(
        transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={40,100})));
equation
  connect(prod3.y, T_Forward_HS.u2) annotation (Line(points={{40,-27},{74,-27},
          {74,-38}},   color={0,0,127}));
  connect(prod4.y, T_Return_DH.u1) annotation (Line(points={{-40,-27},{-40,-30},
          {-74,-30},{-74,-38}},
                            color={0,0,127}));
  connect(Delta_T.y, prod3.u2) annotation (Line(points={{-2.22045e-015,8.8},{
          -2.22045e-015,4.85},{34,4.85},{34,-4}},
                              color={0,0,127}));
  connect(Delta_T.y, prod4.u1) annotation (Line(points={{-2.22045e-015,8.8},{
          -2.22045e-015,4.85},{-34,4.85},{-34,-4}},
                               color={0,0,127}));
  connect(effectiveness.P2_Output, prod3.u1) annotation (Line(points={{4,46},{4,
          42},{46,42},{46,-4}},               color={0,0,127}));
  connect(effectiveness.P1_Output, prod4.u2) annotation (Line(points={{-4,46},{
          -4,42},{-46,42},{-46,-4}},             color={0,0,127}));
  connect(u1, Delta_T.u1) annotation (Line(points={{80,100},{80,100},{80,60},{
          20,60},{20,44},{7.2,44},{7.2,36.4}}, color={0,0,127}));
  connect(u2, Delta_T.u2) annotation (Line(points={{-80,100},{-80,100},{-80,60},
          {-20,60},{-20,44},{-7.2,44},{-7.2,40},{-7.2,36.4}}, color={0,0,127}));
  connect(u1, T_Forward_HS.u1) annotation (Line(points={{80,100},{80,60},{86,60},
          {86,-38}}, color={0,0,127}));
  connect(y, T_Forward_HS.y)
    annotation (Line(points={{80,-100},{80,-84},{80,-61}}, color={0,0,127}));
  connect(u2, T_Return_DH.u2) annotation (Line(points={{-80,100},{-80,100},{-80,
          82},{-80,82},{-80,22},{-86,22},{-86,-38}}, color={0,0,127}));
  connect(y1, T_Return_DH.y) annotation (Line(points={{-80,-100},{-80,-82},{-80,
          -61}}, color={0,0,127}));
  connect(C_P_DH, effectiveness.C_P_DH) annotation (Line(points={{-20,100},{-20,
          100},{-20,84},{-2,84},{-2,66},{-2,66}}, color={0,0,127}));
  connect(C_P_HS, effectiveness.C_P_HS) annotation (Line(points={{20,100},{20,
          84},{2,84},{2,66}}, color={0,0,127}));
  connect(MassFlowRate_DH, effectiveness.MassFlowRate_DH) annotation (Line(
        points={{-40,100},{-40,100},{-40,72},{-38,72},{-38,72},{-6,72},{-6,66},
          {-6,66}}, color={0,0,127}));
  connect(MassFlowRate_HS, effectiveness.MassFlowRate_HS) annotation (Line(
        points={{40,100},{40,100},{40,84},{40,72},{6,72},{6,66}}, color={0,0,
          127}));
  annotation (                                 Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end Temperature_detection;
