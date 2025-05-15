within AixLib.Systems.HydraulicModules.Controller;
model CalcHydraulicPower

  parameter Real rho = 1000 "Density of Medium";
  parameter Real cp = 4180 "Heat Capacity of Medium";
  Modelica.Blocks.Math.Add add(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-20,22},{0,42}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  Modelica.Blocks.Math.Gain gain(k=rho)
    annotation (Placement(transformation(extent={{-56,-8},{-38,10}})));
  Modelica.Blocks.Math.Gain gain1(k=cp)
    annotation (Placement(transformation(extent={{-22,-10},{-4,8}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow "Connector of Real output signal"
    annotation (Placement(transformation(extent={{98,64},{118,84}})));
  EONERC_MainBuilding.BaseClasses.TabsBus2 tabsBus2
    annotation (Placement(transformation(extent={{-108,-12},{-88,8}})));
  Modelica.Blocks.Math.Add add1(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-22,-56},{-2,-36}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{56,-88},{76,-68}})));
  Modelica.Blocks.Math.Gain gain2(k=rho)
    annotation (Placement(transformation(extent={{-58,-86},{-40,-68}})));
  Modelica.Blocks.Math.Gain gain3(k=cp)
    annotation (Placement(transformation(extent={{-24,-88},{-6,-70}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_h "Connector of Real output signal" annotation (Placement(
        transformation(extent={{98,-6},{118,14}}), iconTransformation(extent={{98,-6},{118,14}})));
  Modelica.Blocks.Math.Add add2(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{-30,-140},{-10,-120}})));
  Modelica.Blocks.Math.Product product3
    annotation (Placement(transformation(extent={{48,-172},{68,-152}})));
  Modelica.Blocks.Math.Gain gain4(k=rho)
    annotation (Placement(transformation(extent={{-66,-170},{-48,-152}})));
  Modelica.Blocks.Math.Gain gain5(k=cp)
    annotation (Placement(transformation(extent={{-32,-172},{-14,-154}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_c "Connector of Real output signal" annotation (Placement(
        transformation(extent={{98,-96},{118,-76}}), iconTransformation(extent={{98,-96},{118,-76}})));
equation
  connect(product1.u1, add.y) annotation (Line(points={{56,6},{12,6},{12,32},{1,
          32}},   color={0,0,127}));
  connect(gain.y, gain1.u)
    annotation (Line(points={{-37.1,1},{-30,1},{-30,-1},{-23.8,-1}},
                                                     color={0,0,127}));
  connect(gain1.y, product1.u2) annotation (Line(points={{-3.1,-1},{8,-1},{8,-6},
          {56,-6}},     color={0,0,127}));
  connect(product1.y, Q_flow)
    annotation (Line(points={{79,0},{94,0},{94,74},{108,74}},
                                              color={0,0,127}));
  connect(Q_flow, Q_flow)
    annotation (Line(points={{108,74},{108,74}},
                                               color={0,0,127}));
  connect(gain.u, tabsBus2.pumpBus.VFlowOutMea) annotation (Line(points={{-57.8,1},{-82,1},{-82,-1.95},{
          -97.95,-1.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u2, tabsBus2.pumpBus.TFwrdOutMea) annotation (Line(points={{-22,26},{-84,26},{-84,-1.95},{
          -97.95,-1.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add.u1, tabsBus2.pumpBus.TRtrnInMea) annotation (Line(points={{-22,38},{-84,38},{-84,-1.95},{
          -97.95,-1.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(product2.u1, add1.y)
    annotation (Line(points={{54,-72},{10,-72},{10,-46},{-1,-46}}, color={0,0,127}));
  connect(gain2.y, gain3.u)
    annotation (Line(points={{-39.1,-77},{-32,-77},{-32,-79},{-25.8,-79}}, color={0,0,127}));
  connect(gain3.y,product2. u2) annotation (Line(points={{-5.1,-79},{6,-79},{6,-84},{54,-84}},
                        color={0,0,127}));
  connect(product2.y, Q_flow_h)
    annotation (Line(points={{77,-78},{94,-78},{94,4},{108,4}}, color={0,0,127}));
  connect(gain2.u, tabsBus2.hotThrottleBus.VFlowOutMea) annotation (Line(points={{-59.8,-77},{-59.8,-78},{
          -82,-78},{-82,-1.95},{-97.95,-1.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(add1.u2, tabsBus2.hotThrottleBus.TFwrdOutMea) annotation (Line(points={{-24,-52},{-82,-52},{-82,
          -1.95},{-97.95,-1.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add1.u1, tabsBus2.hotThrottleBus.TRtrnInMea) annotation (Line(points={{-24,-40},{-82,-40},{-82,
          -1.95},{-97.95,-1.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(product3.u1, add2.y)
    annotation (Line(points={{46,-156},{2,-156},{2,-130},{-9,-130}}, color={0,0,127}));
  connect(gain4.y, gain5.u)
    annotation (Line(points={{-47.1,-161},{-40,-161},{-40,-163},{-33.8,-163}}, color={0,0,127}));
  connect(gain5.y,product3. u2) annotation (Line(points={{-13.1,-163},{-2,-163},{-2,-168},{46,-168}},
                        color={0,0,127}));
  connect(product3.y, Q_flow_c)
    annotation (Line(points={{69,-162},{86,-162},{86,-86},{108,-86}}, color={0,0,127}));
  connect(gain4.u, tabsBus2.coldThrottleBus.VFlowOutMea) annotation (Line(points={{-67.8,-161},{-67.8,-168},
          {-82,-168},{-82,-1.95},{-97.95,-1.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(add2.u2, tabsBus2.coldThrottleBus.TFwrdOutMea) annotation (Line(points={{-32,-136},{-82,-136},{
          -82,-1.95},{-97.95,-1.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add2.u1, tabsBus2.coldThrottleBus.TRtrnInMea) annotation (Line(points={{-32,-124},{-82,-124},{-82,
          -1.95},{-97.95,-1.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Line(
          points={{-100,100},{-36,-2},{-100,-100}},
          color={95,95,95},
          thickness=0.5),
          Text(
          extent={{-48,20},{98,-20}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Control")}), Diagram(coordinateSystem(preserveAspectRatio=
           false)),
    Documentation(revisions="<html><ul>
  <li>December 9, 2021, by Phillip Stoffel:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Calculates the power auf hydraulic modules and returns the power as
  real
</p>
</html>"));
end CalcHydraulicPower;
