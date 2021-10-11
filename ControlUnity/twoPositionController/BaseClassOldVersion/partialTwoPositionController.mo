within ControlUnity.twoPositionController.BaseClassOldVersion;
partial model partialTwoPositionController
  "Base model for the two position controller"

 parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference Temperature for the on off controller";

    parameter Integer n "Number of layers in the buffer storage";

  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-22,-16},{-2,4}})));
  Modelica.Blocks.Logical.OnOffController onOffController(pre_y_start=true)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{36,-10},{56,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Tref)
    annotation (Placement(transformation(extent={{-22,12},{-2,32}})));

  Modelica.Blocks.Interfaces.RealInput TLayers[n]
    "Temperatures of the different layers in the buffer storage"
    annotation (Placement(transformation(extent={{-120,16},{-80,56}})));
equation
  connect(add.y,onOffController. u)
    annotation (Line(points={{-1,-6},{8,-6}},  color={0,0,127}));
  connect(onOffController.y, y)
    annotation (Line(points={{31,0},{46,0}},    color={255,0,255}));
  connect(realExpression.y, onOffController.reference) annotation (Line(points={{-1,22},
          {2,22},{2,6},{8,6}},              color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialTwoPositionController;
