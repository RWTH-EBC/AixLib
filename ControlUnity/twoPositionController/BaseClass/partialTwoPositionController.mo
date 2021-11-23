within ControlUnity.twoPositionController.BaseClass;
partial model partialTwoPositionController
  "Base model for the two position controller"
  //Parameters
 parameter Modelica.SIunits.Temperature Tref=273.15+70 "Reference Temperature for the on off controller";
 parameter Integer n  "Number of layers in the buffer storage";
 parameter Boolean variablePLR=false "If true, the user can determine the PLR between PLRmin and 1; else you have a two position conttol with the values 0 and 1 for PLR";

  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=bandwidth,
                                                          pre_y_start=true)
    annotation (Placement(transformation(extent={{34,-4},{54,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Tref)
    annotation (Placement(transformation(extent={{2,32},{22,52}})));

  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{78,-4},{98,16}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{102,-4},{122,16}})));
  Modelica.Blocks.Sources.RealExpression realZero
    annotation (Placement(transformation(extent={{24,-32},{44,-12}})));
  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
  Modelica.Blocks.Interfaces.RealInput TLayers[n] "Temperatures of the different layers of the buffer storage"
    annotation (Placement(transformation(extent={{-120,-42},{-80,-2}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-22,72},{-2,92}})));
  Modelica.Blocks.Interfaces.BooleanInput isOn
    annotation (Placement(transformation(extent={{-120,14},{-80,54}})));
  Modelica.Blocks.Sources.RealExpression realExpression1
    annotation (Placement(transformation(extent={{-54,54},{-34,74}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{38,64},{58,84}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=1)
    annotation (Placement(transformation(extent={{10,50},{22,66}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=variablePLR)
    annotation (Placement(transformation(extent={{6,64},{20,82}})));
  parameter Real bandwidth=2.5 "Bandwidth around reference signal";
equation
  connect(realExpression.y, onOffController.reference) annotation (Line(points={{23,42},
          {26,42},{26,12},{32,12}},         color={0,0,127}));
  connect(switch1.y, PLRset)
    annotation (Line(points={{99,6},{112,6}},   color={0,0,127}));
  connect(realZero.y, switch1.u3) annotation (Line(points={{45,-22},{70,-22},{70,
          -2},{76,-2}},
                    color={0,0,127}));
  connect(onOffController.y, switch1.u2)
    annotation (Line(points={{55,6},{76,6}},   color={255,0,255}));
  connect(PLRin, switch2.u1)
    annotation (Line(points={{-100,90},{-24,90}}, color={0,0,127}));
  connect(isOn, switch2.u2) annotation (Line(points={{-100,34},{-60,34},{-60,82},
          {-24,82}}, color={255,0,255}));
  connect(realExpression1.y, switch2.u3) annotation (Line(points={{-33,64},{-32,
          64},{-32,74},{-24,74}}, color={0,0,127}));
  connect(switch2.y, switch3.u1)
    annotation (Line(points={{-1,82},{36,82}}, color={0,0,127}));
  connect(realExpression2.y, switch3.u3) annotation (Line(points={{22.6,58},{30,
          58},{30,66},{36,66}}, color={0,0,127}));
  connect(booleanExpression.y, switch3.u2) annotation (Line(points={{20.7,73},{28.35,
          73},{28.35,74},{36,74}}, color={255,0,255}));
  connect(switch3.y, switch1.u1) annotation (Line(points={{59,74},{68,74},{68,14},
          {76,14}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialTwoPositionController;
