within Regelungseinheit.BaseClass;
partial model partialTwoPositionController
  "Base model for the two position controller"

 parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference Temperature for the on off controller";
  parameter Boolean layerCal=true
    "If true, the two-position controller uses the mean temperature of the buffer storage";
    parameter Integer n "Number of layers in the buffer storage";


  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{12,16},{32,36}})));
  Modelica.Blocks.Logical.OnOffController onOffController(pre_y_start=true)
    annotation (Placement(transformation(extent={{58,22},{78,42}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation (Placement(transformation(extent={{90,22},{110,42}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Tref)
    annotation (Placement(transformation(extent={{12,46},{32,66}})));

  Modelica.Blocks.Interfaces.RealInput TLayers[n] if layerCal
    "Temperatures of the different layers in the buffer storage"
    annotation (Placement(transformation(extent={{-120,16},{-80,56}})));
  Modelica.Blocks.Interfaces.RealInput TTop if not layerCal "Temperature on the top layer"
    annotation (Placement(transformation(extent={{-120,-22},{-80,18}})));
equation
  connect(add.y,onOffController. u)
    annotation (Line(points={{33,26},{56,26}}, color={0,0,127}));
  connect(onOffController.y, y)
    annotation (Line(points={{79,32},{100,32}}, color={255,0,255}));
  connect(realExpression.y, onOffController.reference) annotation (Line(points={
          {33,56},{42,56},{42,38},{56,38}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end partialTwoPositionController;
