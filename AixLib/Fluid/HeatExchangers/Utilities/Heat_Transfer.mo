within AixLib.Fluid.HeatExchangers.Utilities;
block Heat_Transfer
  "Calculation of the heat which is transported in the plate heat exchanger"

  Utilities.TempCalcOutflow tempCalcOutflow
    "calculates outflowing temperatures based on heat exchanger characteristic."
    annotation (Placement(transformation(rotation=0, extent={{-10,46},{10,66}})));
protected
  Modelica.Blocks.Math.Add tempDiff1(k2=-1, u2(
      min=253.15,
      max=323.15,
      nominal=278.15,
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC")) "y = T_Return_1 - T_1_in" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-46,20})));
  Modelica.Blocks.Math.Add tempDiff2(
    k1=-1,
    k2=+1,
    u1(
      min=253.15,
      max=323.15,
      nominal=278.15,
      quantity="ThermodynamicTemperature",
      unit="K",
      displayUnit="degC")) "y = - T2_in + T_Forward_2" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={46,20})));
  Modelica.Blocks.Math.Product capacityFlow_2(u1(
      min=0.0,
      max=50.0,
      nominal=17.5,
      quantity="MassFlowRate",
      unit="kg/s"),
      u2(
      min=1.0,
      max=5000.0,
      nominal=4000.0,
      quantity="SpecificHeatCapacity",
      unit="J/(kg.K)")) "y = m_flow_2 * cp_2" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,-10})));
  Modelica.Blocks.Math.Product capacityFlow_1(u1(
      min=1.0,
      max=5000.0,
      nominal=4000.0,
      quantity="SpecificHeatCapacity",
      unit="J/(kg.K)"),
      u2(
      min=0.0,
      max=50.0,
      nominal=17.5,
      quantity="MassFlowRate",
      unit="kg/s")) "y = cp_1 *  m_flow_1" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-10})));
public
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
  Modelica.Blocks.Interfaces.RealInput T2_in(
    min=253.15,
    max=323.15,
    nominal=303.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={80,100})));
  Modelica.Blocks.Interfaces.RealInput T1_in(
    min=253.15,
    max=323.15,
    nominal=278.15,
    quantity="ThermodynamicTemperature",
    unit="K",
    displayUnit="degC") annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-80,100})));
  Modelica.Blocks.Interfaces.RealInput mFlow2(
    min=0.0,
    max=50.0,
    nominal=17.5,
    quantity="MassFlowRate",
    unit="kg/s") "side 2" annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={20,100})));
  Modelica.Blocks.Interfaces.RealInput cP2(
    min=1.0,
    max=5000.0,
    nominal=4000.0,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)") "side 2" annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={40,100})));
  Modelica.Blocks.Interfaces.RealInput cP1(
    min=1.0,
    max=5000.0,
    nominal=4000.0,
    quantity="SpecificHeatCapacity",
    unit="J/(kg.K)") "side 1" annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-40,100})));
  Modelica.Blocks.Interfaces.RealInput mFlow1(
    min=0.0,
    max=50.0,
    nominal=17.5,
    quantity="MassFlowRate",
    unit="kg/s") "side 1" annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-20,100})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_1(quantity="Power", unit="W")
    "heat flow into side 1" annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={-40,-100})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_2(quantity="Power", unit="W")
    "heat flow into side 2" annotation (Placement(transformation(
        rotation=-90,
        extent={{-10,-10},{10,10}},
        origin={40,-100})));
equation
  connect(capacityFlow_2.y, productQsource.u2) annotation (Line(points={{20,-21},
          {20,-28.25},{34,-28.25},{34,-38}}, color={0,0,127}));
  connect(capacityFlow_1.y, productQsink.u1) annotation (Line(points={{-20,-21},
          {-20,-28.25},{-34,-28.25},{-34,-38}}, color={0,0,127}));
  connect(tempDiff2.y, productQsource.u1)
    annotation (Line(points={{46,9},{46,2},{46,-38}}, color={0,0,127}));
  connect(tempDiff1.y, productQsink.u2) annotation (Line(points={{-46,9},{-46,9},
          {-46,-28},{-46,-38}}, color={0,0,127}));
  connect(tempCalcOutflow.T2_out, tempDiff2.u2)
    annotation (Line(points={{8,46},{8,40},{40,40},{40,32}}, color={0,0,127}));
  connect(tempCalcOutflow.T1_out, tempDiff1.u1) annotation (Line(points={{-8,46},
          {-8,40},{-40,40},{-40,32}}, color={0,0,127}));
  connect(T2_in, tempDiff2.u1) annotation (Line(points={{80,100},{80,100},{80,50},
          {80,40},{52,40},{52,32}}, color={0,0,127}));
  connect(T1_in, tempDiff1.u2) annotation (Line(points={{-80,100},{-80,100},{-80,
          48},{-80,40},{-52,40},{-52,38},{-52,32}}, color={0,0,127}));
  connect(mFlow2, capacityFlow_2.u1) annotation (Line(points={{20,100},{20,100},
          {20,94},{20,80},{26,80},{26,2}}, color={0,0,127}));
  connect(cP2, capacityFlow_2.u2) annotation (Line(points={{40,100},{40,100},{40,
          56},{14,56},{14,54},{14,2}}, color={0,0,127}));
  connect(cP1, capacityFlow_1.u1) annotation (Line(points={{-40,100},{-40,100},{
          -40,56},{-38,56},{-14,56},{-14,2}}, color={0,0,127}));
  connect(mFlow1, capacityFlow_1.u2) annotation (Line(points={{-20,100},{-20,100},
          {-20,80},{-26,80},{-26,46},{-26,2}}, color={0,0,127}));
  connect(Q_flow_1, productQsink.y)
    annotation (Line(points={{-40,-100},{-40,-61}}, color={0,0,127}));
  connect(Q_flow_2, productQsource.y)
    annotation (Line(points={{40,-100},{40,-61}}, color={0,0,127}));
  connect(T2_in, tempCalcOutflow.T2_in) annotation (Line(points={{80,100},{80,
          100},{80,96},{80,80},{80,70},{8,70},{8,68},{8,66}}, color={0,0,127}));
  connect(T1_in, tempCalcOutflow.T1_in) annotation (Line(points={{-80,100},{-80,
          100},{-80,70},{-44,70},{-8,70},{-8,66}}, color={0,0,127}));
  connect(mFlow1, tempCalcOutflow.mFlow1) annotation (Line(points={{-20,100},{-20,
          100},{-20,80},{-4,80},{-4,66}}, color={0,0,127}));
  connect(cP1, tempCalcOutflow.cP1) annotation (Line(points={{-40,100},{-40,84},
          {-2,84},{-2,66}}, color={0,0,127}));
  connect(mFlow2, tempCalcOutflow.mFlow2) annotation (Line(points={{20,100},{20,
          100},{20,80},{4,80},{4,66}}, color={0,0,127}));
  connect(cP2, tempCalcOutflow.cP2) annotation (Line(points={{40,100},{40,100},
          {40,84},{2,84},{2,66}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(revisions="<html>
<ul>
<li><i>2017-04-25</i> by Peter Matthes:<br>Renames inputs and outputs.<br>Renames components (&QUOT;add&QUOT; becomes tempDiff, product becomes capacityFlow) and protect them.<br>Renames block &QUOT;temperature_detection&QUOT; in &QUOT;tempCalcOutflow&QUOT;<br>Adds units to inputs and outputs.<br>Changes &QUOT;model&QUOT; into &QUOT;block&QUOT;.<br>Flip connections of cp and m_flow on temperatureDetection block.</li>
</ul>
</html>"));
end Heat_Transfer;
