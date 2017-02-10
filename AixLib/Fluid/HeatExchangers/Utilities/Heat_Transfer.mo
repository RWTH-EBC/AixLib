within AixLib.Fluid.HeatExchangers.Utilities;
model Heat_Transfer
  "Calculation of the heat which is transported in the plate heat exchanger"

  Utilities.Temperature_detection temperature_detection
    annotation (Placement(transformation(rotation=0, extent={{-10,46},{10,66}})));
  Modelica.Blocks.Math.Add add2(k2=-1, u2(
      min=253.15,
      max=323.15,
      nominal=278.15)) "y = T_Return_DH - T_DH_in" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-46,20})));
  Modelica.Blocks.Math.Add add1(
    k1=-1,
    k2=+1,
    u1(
      min=253.15,
      max=323.15,
      nominal=278.15)) "y = - T_HS_in + T_Forward_HS" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={46,20})));
  Modelica.Blocks.Math.Product product1(u1(
      min=0,
      max=50,
      nominal=17.5), u2(
      min=1,
      max=5000,
      nominal=4000)) "y = m_flow_HS * cp_HS " annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-10})));
  Modelica.Blocks.Math.Product product2(u1(
      min=1,
      max=5000,
      nominal=4000), u2(
      min=0,
      max=50,
      nominal=17.5)) "y = cp_DH *  m_flow_DH" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-10})));
  Modelica.Blocks.Math.Product productQsink "Qsink" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-50})));
  Modelica.Blocks.Math.Product productQsource "Qsource" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-50})));
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
  Modelica.Blocks.Interfaces.RealInput u3(
    min=0,
    max=50,
    nominal=17.5) annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={20,100})));
  Modelica.Blocks.Interfaces.RealInput u4(
    min=1,
    max=5000,
    nominal=4000) annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealInput u5(
    min=1,
    max=5000,
    nominal=4000) annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput u6(
    min=0,
    max=50,
    nominal=17.5) annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-20,100})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-40,-100})));
  Modelica.Blocks.Interfaces.RealOutput y1 annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={40,-100})));
equation
  connect(product1.y, productQsource.u2) annotation (Line(points={{20,-21},{20,
          -28.25},{34,-28.25},{34,-38}},
                             color={0,0,127}));
  connect(product2.y, productQsink.u1) annotation (Line(points={{-20,-21},{-20,
          -28.25},{-34,-28.25},{-34,-38}},
                               color={0,0,127}));
  connect(add1.y, productQsource.u1) annotation (Line(points={{46,9},{46,2},{46,
          -38}},               color={0,0,127}));
  connect(add2.y, productQsink.u2) annotation (Line(points={{-46,9},{-46,9},{
          -46,-28},{-46,-38}},         color={0,0,127}));
  connect(temperature_detection.y,
                         add1. u2) annotation (Line(points={{8,46},{8,40},{40,
          40},{40,32}}, color={0,0,127}));
  connect(temperature_detection.y1,
                         add2.u1) annotation (Line(points={{-8,46},{-8,40},{-40,
          40},{-40,32}}, color={0,0,127}));
  connect(u1, add1.u1) annotation (Line(points={{80,100},{80,100},{80,50},{80,
          40},{52,40},{52,32}}, color={0,0,127}));
  connect(u2, add2.u2) annotation (Line(points={{-80,100},{-80,100},{-80,48},{
          -80,40},{-52,40},{-52,38},{-52,38},{-52,32},{-52,32}}, color={0,0,127}));
  connect(u3, product1.u1) annotation (Line(points={{20,100},{20,100},{20,94},{
          20,80},{26,80},{26,2}}, color={0,0,127}));
  connect(u4, product1.u2) annotation (Line(points={{40,100},{40,100},{40,56},{
          14,56},{14,54},{14,2}}, color={0,0,127}));
  connect(u5, product2.u1) annotation (Line(points={{-40,100},{-40,100},{-40,56},
          {-38,56},{-14,56},{-14,2}}, color={0,0,127}));
  connect(u6, product2.u2) annotation (Line(points={{-20,100},{-20,100},{-20,80},
          {-26,80},{-26,46},{-26,2}}, color={0,0,127}));
  connect(y, productQsink.y)
    annotation (Line(points={{-40,-100},{-40,-61}}, color={0,0,127}));
  connect(y1, productQsource.y)
    annotation (Line(points={{40,-100},{40,-61}}, color={0,0,127}));
  connect(u6, temperature_detection.C_P_DH) annotation (Line(points={{-20,100},
          {-20,100},{-20,92},{-20,80},{-2,80},{-2,66}}, color={0,0,127}));
  connect(u3, temperature_detection.C_P_HS) annotation (Line(points={{20,100},{
          20,100},{20,94},{20,96},{20,80},{2,80},{2,66}}, color={0,0,127}));
  connect(u5, temperature_detection.MassFlowRate_DH) annotation (Line(points={{
          -40,100},{-40,100},{-40,76},{-14,76},{-4,76},{-4,66}}, color={0,0,127}));
  connect(u4, temperature_detection.MassFlowRate_HS) annotation (Line(points={{
          40,100},{40,100},{40,76},{4,76},{4,66}}, color={0,0,127}));
  connect(u1, temperature_detection.u1) annotation (Line(points={{80,100},{80,
          100},{80,96},{80,80},{80,80},{80,80},{80,70},{8,70},{8,68},{8,66}},
        color={0,0,127}));
  connect(u2, temperature_detection.u2) annotation (Line(points={{-80,100},{-80,
          100},{-80,70},{-44,70},{-8,70},{-8,66}}, color={0,0,127}));
  annotation (                                 Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end Heat_Transfer;
