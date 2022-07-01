within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control;
model Control_wPump

  parameter Modelica.SIunits.TemperatureDifference dTWaterNom "Temperature difference nominal"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Thermal dimension power"
    annotation (Dialog(group="Nominal condition"));
  parameter Boolean m_flowVar=false "Use variable water massflow"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
  parameter Boolean Pump=true "Model includes a pump"
    annotation (choices(checkBox=true), Dialog(descriptionLabel=true));
  parameter Boolean Advanced=false "dTWater is constant for different PLR"
    annotation (choices(checkBox=true), Dialog(enable=m_flowVar,descriptionLabel=true, tab="Advanced",group="Boiler behaviour"));
  parameter Modelica.SIunits.TemperatureDifference dTWaterSet=15 "Temperature difference setpoint"
    annotation (Dialog(enable=Advanced,tab="Advanced",group="Boiler behaviour"));
  parameter Modelica.SIunits.Temperature THotMax=363.15 "Maximal temperature to force shutdown";
  parameter Real PLRMin=0.15 "Minimal Part Load Ratio";

  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,2})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{90,40},{72,60}})));
  Modelica.Blocks.Logical.LessThreshold pLRMin(final threshold=PLRMin)
    annotation (Placement(transformation(extent={{-58,26},{-40,44}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=0,
        origin={9,35})));
  Modelica.Blocks.Logical.Switch switch7
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-30,-6})));
  Controls.ControlBoilerNotManufacturer controlBoilerNotManufacturer(
    final DeltaTWaterNom=dTWaterNom,
    final QNom=QNom,
    final m_flowVar=m_flowVar,
    final Advanced=Advanced,
    final dTWaterSet=dTWaterSet)
    annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
  Modelica.Blocks.Logical.Greater greater
    annotation (Placement(transformation(extent={{80,20},{64,36}})));
  Modelica.Blocks.Sources.RealExpression tHotMax(final y=THotMax)
    annotation (Placement(transformation(extent={{9.5,-10.5},{-9.5,10.5}},
        rotation=270,
        origin={84.5,-8.5})));
  Modelica.Blocks.Interfaces.RealInput TCold
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-100,-20})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-60})));
  Modelica.Blocks.Interfaces.RealOutput dTWater
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-60})));
  Modelica.Blocks.Interfaces.RealOutput PLR
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-60})));
  Modelica.Blocks.Interfaces.RealInput THot_Boiler
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-100,-40})));
  Modelica.Blocks.Interfaces.RealInput THot
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-100,-60})));
  Modelica.Blocks.Interfaces.RealInput dTwater_in
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-100,40})));
  Modelica.Blocks.Interfaces.RealInput PLR_in
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={-100,60})));

equation

  connect(realExpression.y, switch3.u1)
    annotation (Line(points={{71.1,50},{58,50},
          {58,14}},         color={0,0,127}));
  connect(pLRMin.y, switch4.u2)
    annotation (Line(points={{-39.1,35},{-1.8,35}},
                           color={255,0,255}));
  connect(switch4.y, switch3.u3)
    annotation (Line(points={{18.9,35},{42,35},{42,
          14}},        color={0,0,127}));
  connect(realExpression.y, switch4.u1)
    annotation (Line(points={{71.1,50},{-22,
          50},{-22,42.2},{-1.8,42.2}},                               color={0,0,
          127}));
  connect(pLRMin.y, switch7.u2)
    annotation (Line(points={{-39.1,35},{-30,35},{-30,
          6}},        color={255,0,255}));
  connect(realExpression.y, switch7.u1)
    annotation (Line(points={{71.1,50},{30,50},
          {30,12},{-38,12},{-38,6}},                 color={0,0,127}));
  connect(controlBoilerNotManufacturer.mFlowRel, switch7.u3)
    annotation (Line(
        points={{-51,18},{-22,18},{-22,6}},      color={0,0,127}));
  connect(greater.y, switch3.u2)
    annotation (Line(points={{63.2,28},{50,28},{50,14}}, color={255,0,255}));
  connect(tHotMax.y, greater.u2)
    annotation (Line(points={{84.5,1.95},{84,1.95},
          {84,21.6},{81.6,21.6}},
                              color={0,0,127}));
  connect(TCold, controlBoilerNotManufacturer.TCold)
    annotation (Line(points={{-100,
          -20},{-82,-20},{-82,13},{-74,13}},    color={0,0,127}));
  connect(y, switch7.y)
    annotation (Line(points={{-40,-60},{-40,-40},{-30,-40},{-30,-17}},
                                                  color={0,0,127}));
  connect(controlBoilerNotManufacturer.DeltaTWater_b, dTWater)
    annotation (Line(
        points={{-51,4.8},{-48,4.8},{-48,-32},{0,-32},{0,-60}},       color={0,0,
          127}));
  connect(switch3.y, PLR)
    annotation (Line(points={{50,-9},{50,-40},{-20,-40},{-20,
          -60}}, color={0,0,127}));
  connect(THot_Boiler, controlBoilerNotManufacturer.THot)
    annotation (Line(
        points={{-100,-40},{-78,-40},{-78,10},{-74,10}},    color={0,0,127}));
  connect(THot, greater.u1)
    annotation (Line(points={{-100,-60},{-80,-60},{-80,-42},{96,-42},{96,28},{81.6,
          28}},                                             color={0,0,127}));
  connect(PLR_in, pLRMin.u)
    annotation (Line(points={{-100,60},{-66,60},{-66,35},
          {-59.8,35}}, color={0,0,127}));
  connect(PLR_in, switch4.u3)
    annotation (Line(points={{-100,60},{-26,60},{-26,27.8},
          {-1.8,27.8}},                    color={0,0,127}));
  connect(dTwater_in, controlBoilerNotManufacturer.DeltaTWater_a)
    annotation (
      Line(points={{-100,40},{-80,40},{-80,7},{-74,7}},      color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},
            {100,80}})),                                         Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},{100,80}})),
    Documentation(info="<html>
<p>A boiler model consisting of physical components. The user has the choice to run the model for three different setpoint options:</p>
<ol>
<li>Setpoint depends on part load ratio (water mass flow=dimension water mass flow; advanced=false &amp; m_flowVar=false)</li>
<li>Setpoint depends on part load ratio and a constant water temperature difference which is idependent from part load ratio (water mass flow is variable; advanced=false &amp; m_flowVar=true)</li>
<li>Setpoint depends on part load ratio an a variable water temperature difference (water mass flow is variable; advanced=true)</li>
</ol>
</html>"),
    experiment(StopTime=10));
end Control_wPump;
