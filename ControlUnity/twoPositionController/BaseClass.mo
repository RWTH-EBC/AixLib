within ControlUnity.twoPositionController;
package BaseClass "Partielle Modelle zur Erstellung der Regelungen"

  package twoPositionControllerCal
    "This package contains the different methods for the calculation of the twoPositionController"

    model twoPositionController_layers

      extends
        ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(
          realExpression(y=TLayer_dif), onOffController(bandwidth=bandwidth));
       parameter Boolean layerCal=true
        "If true, the two-position controller uses the mean temperature of the buffer storage";

      parameter Modelica.SIunits.TemperatureDifference TLayer_dif=8 "Reference difference temperature for the on off controller for the buffer storage with layer calculation";
      parameter Modelica.SIunits.Temperature Tlayerref=273.15+65;

      Modelica.Blocks.Math.Sum sumTLayers(nin=n)
        annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
      Modelica.Blocks.Math.Division meanTemperatureBufferStorage
        annotation (Placement(transformation(extent={{-34,14},{-14,34}})));
      Modelica.Blocks.Sources.RealExpression realExpressionDynamic(y=n)
        annotation (Placement(transformation(extent={{-74,-10},{-54,10}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=TLayer_dif)
        annotation (Placement(transformation(extent={{-36,-32},{-16,-10}})));
      parameter Real bandwidth "Bandwidth around reference signal";
    equation
      connect(sumTLayers.y, meanTemperatureBufferStorage.u1) annotation (Line(
            points={{-51,30},{-36,30}},                   color={0,0,127}));
      connect(realExpressionDynamic.y, meanTemperatureBufferStorage.u2) annotation (
         Line(points={{-53,0},{-42,0},{-42,18},{-36,18}}, color={0,0,127}));
      connect(meanTemperatureBufferStorage.y, add.u1) annotation (Line(points={{-13,
              24},{-2,24},{-2,32},{10,32}}, color={0,0,127}));
      connect(realExpression.y, add.u2) annotation (Line(points={{-15,-21},{-15,-10},
              {10,-10},{10,20}}, color={0,0,127}));
      connect(TLayers, sumTLayers.u) annotation (Line(points={{-100,36},{-87,36},{-87,
              30},{-74,30}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end twoPositionController_layers;

    model twoPositionController_top
      "Calculation of the temperature of the buffer storage with the temperature on the top level"
      extends
        ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(
          realExpression(y=Tref), onOffController(bandwidth=bandwidth));
      parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference temperature for two position controller using top level temperature";
      parameter Modelica.SIunits.Temperature Ttop=273.15+70 "Temperature on the top level of the buffer storage";


      Modelica.Blocks.Sources.RealExpression realExpression1(y=Ttop)
        annotation (Placement(transformation(extent={{-100,-42},{-80,-22}})));
      parameter Real bandwidth "Bandwidth around reference signal";
    equation

      connect(realExpression1.y, add.u2) annotation (Line(points={{-79,-32},{-34,-32},
              {-34,20},{10,20}}, color={0,0,127}));
      connect(TLayers[1], add.u1) annotation (Line(points={{-100,36},{-46,36},{-46,32},
              {10,32}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end twoPositionController_top;
  end twoPositionControllerCal;

  partial model partialTwoPositionController
    "Base model for the two position controller"

   parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference Temperature for the on off controller";

      parameter Integer n "Number of layers in the buffer storage";

    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{12,16},{32,36}})));
    Modelica.Blocks.Logical.OnOffController onOffController(pre_y_start=true)
      annotation (Placement(transformation(extent={{58,22},{78,42}})));
    Modelica.Blocks.Interfaces.BooleanOutput y
      annotation (Placement(transformation(extent={{90,22},{110,42}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=Tref)
      annotation (Placement(transformation(extent={{12,46},{32,66}})));

    Modelica.Blocks.Interfaces.RealInput TLayers[n]
      "Temperatures of the different layers in the buffer storage"
      annotation (Placement(transformation(extent={{-120,16},{-80,56}})));
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
end BaseClass;
