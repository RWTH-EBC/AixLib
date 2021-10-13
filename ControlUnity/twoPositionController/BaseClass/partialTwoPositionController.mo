within ControlUnity.twoPositionController.BaseClass;
partial model partialTwoPositionController
  "Base model for the two position controller"

 parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference Temperature for the on off controller";

    parameter Integer n = 3 "Number of layers in the buffer storage";

  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{0,36},{20,56}})));
  Modelica.Blocks.Logical.OnOffController onOffController(pre_y_start=true)
    annotation (Placement(transformation(extent={{32,42},{52,62}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Tref)
    annotation (Placement(transformation(extent={{0,64},{20,84}})));

  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{76,42},{96,62}})));
  Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{100,42},{120,62}})));
  Modelica.Blocks.Sources.RealExpression realZero
    annotation (Placement(transformation(extent={{22,14},{42,34}})));
  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
  Modelica.Blocks.Interfaces.RealInput TLayers[n] "Temperatures of the different layers of the buffer storage"
    annotation (Placement(transformation(extent={{-120,16},{-80,56}})));
equation
  connect(add.y,onOffController. u)
    annotation (Line(points={{21,46},{30,46}}, color={0,0,127}));
  connect(realExpression.y, onOffController.reference) annotation (Line(points={{21,74},
          {24,74},{24,58},{30,58}},         color={0,0,127}));
  connect(switch1.y, PLRset)
    annotation (Line(points={{97,52},{110,52}}, color={0,0,127}));
  connect(realZero.y, switch1.u3) annotation (Line(points={{43,24},{68,24},{68,44},
          {74,44}}, color={0,0,127}));
  connect(PLRin, switch1.u1) annotation (Line(points={{-100,90},{68,90},{68,60},
          {74,60}}, color={0,0,127}));
  connect(onOffController.y, switch1.u2)
    annotation (Line(points={{53,52},{74,52}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialTwoPositionController;
