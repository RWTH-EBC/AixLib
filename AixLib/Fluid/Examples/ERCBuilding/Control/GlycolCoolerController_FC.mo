within AixLib.Fluid.Examples.ERCBuilding.Control;
model GlycolCoolerController_FC

  parameter Integer n = 4 "Number of storage layers";

  Modelica.Blocks.Sources.Constant Air_v_flow(k=81600/3600/4)
    annotation (Placement(transformation(extent={{-40,36},{-28,48}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-20,24},{-8,36}})));
  Modelica.Blocks.Sources.RealExpression Air_density(y=1.2)
    annotation (Placement(transformation(extent={{-20,36},{-8,48}})));
  Modelica.Blocks.Math.Product product10
    annotation (Placement(transformation(extent={{0,24},{12,36}})));
  Modelica.Blocks.Math.Product product11
    annotation (Placement(transformation(extent={{22,24},{34,36}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{-40,14},{-28,26}})));
  Modelica.Blocks.Sources.Constant Pel_Vent(k=6800/4)
    annotation (Placement(transformation(extent={{0,-6},{12,6}})));
  Modelica.Blocks.Math.Product product2
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={28,2})));
  Modelica.Blocks.Sources.RealExpression NumberFans(y=Number_Fans_Table.y[1])
    annotation (Placement(transformation(extent={{-76,-10},{-50,8}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{48,-16},{60,-4}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{24,-28},{36,-16}})));
  Modelica.Blocks.Interfaces.RealOutput Pel_GC
    annotation (Placement(transformation(extent={{84,-76},{104,-56}}),
        iconTransformation(extent={{86,-104},{126,-64}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{90,20},{110,40}}),
        iconTransformation(extent={{84,64},{122,102}})));
  Modelica.Blocks.Tables.CombiTable1D Number_Fans_Table_Real(smoothness=
        Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,4; 20,4])
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-26,-36})));
  Modelica.Blocks.Tables.CombiTable1D Number_Fans_Table(
      smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, table=[0,4;
        20,4])
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-26,-72})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
    annotation (Placement(transformation(extent={{6,-6},{-6,6}},
        rotation=180,
        origin={-62,-56})));
  Modelica.Blocks.Interfaces.RealInput temperature_in annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-56}), iconTransformation(extent={{-116,-100},{-76,-60}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.001)
    annotation (Placement(transformation(extent={{-62,24},{-50,36}})));
  Modelica.Blocks.Interfaces.RealInput FC_Glycol
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}})));
equation
  connect(Air_v_flow.y,switch3. u1) annotation (Line(points={{-27.4,42},{-24,42},
          {-24,34.8},{-21.2,34.8}},color={0,0,127}));
  connect(Air_density.y,product10. u1) annotation (Line(points={{-7.4,42},{-6,42},
          {-6,33.6},{-1.2,33.6}},   color={0,0,127}));
  connect(switch3.y,product10. u2) annotation (Line(points={{-7.4,30},{-6,30},{-6,
          26.4},{-1.2,26.4}},       color={0,0,127}));
  connect(const4.y,switch3. u3) annotation (Line(points={{-27.4,20},{-24,20},{-24,
          25.2},{-21.2,25.2}},       color={0,0,127}));
  connect(product10.y,product11. u1) annotation (Line(points={{12.6,30},{16,30},
          {16,33.6},{20.8,33.6}},        color={0,0,127}));
  connect(Pel_Vent.y,product2. u2) annotation (Line(points={{12.6,0},{16,0},{16,
          -1.6},{20.8,-1.6}},            color={0,0,127}));
  connect(product2.y,switch1. u1) annotation (Line(points={{34.6,2},{40,2},{40,-5.2},
          {46.8,-5.2}},             color={0,0,127}));
  connect(NumberFans.y,product11. u2) annotation (Line(points={{-48.7,-1},{-20,-1},
          {-20,16},{16,16},{16,26.4},{20.8,26.4}},        color={0,0,127}));
  connect(product2.u1,NumberFans. y) annotation (Line(points={{20.8,5.6},{16,5.6},
          {16,16},{-20,16},{-20,-1},{-48.7,-1}},          color={0,0,127}));
  connect(switch1.y,Pel_GC)  annotation (Line(points={{60.6,-10},{66,-10},{66,
          -66},{94,-66}},  color={0,0,127}));
  connect(switch1.u3,const1. y) annotation (Line(points={{46.8,-14.8},{40,-14.8},
          {40,-22},{36.6,-22}},        color={0,0,127}));

  connect(product11.y, m_flow_out)
    annotation (Line(points={{34.6,30},{67.3,30},{100,30}}, color={0,0,127}));
  connect(greaterThreshold.y, switch3.u2) annotation (Line(points={{-49.4,30},{
          -21.2,30}},      color={255,0,255}));
  connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{-49.4,30},{-44,
          30},{-44,-10},{46.8,-10}}, color={255,0,255}));
  connect(temperature_in, fromKelvin.Kelvin)
    annotation (Line(points={{-100,-56},{-69.2,-56}}, color={0,0,127}));
  connect(fromKelvin.Celsius, Number_Fans_Table.u[1]) annotation (Line(points={{-55.4,
          -56},{-46,-56},{-46,-72},{-38,-72}},            color={0,0,127}));
  connect(fromKelvin.Celsius, Number_Fans_Table_Real.u[1]) annotation (Line(
        points={{-55.4,-56},{-46,-56},{-46,-36},{-38,-36}},     color={0,0,127}));
  connect(FC_Glycol, greaterThreshold.u) annotation (Line(points={{-100,80},{
          -82,80},{-82,30},{-63.2,30}}, color={0,0,127}));
  annotation (Icon(graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid), Text(
          extent={{-38,30},{52,-26}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Cooler
Controller")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
            -100,-100},{100,100}})));
end GlycolCoolerController_FC;
