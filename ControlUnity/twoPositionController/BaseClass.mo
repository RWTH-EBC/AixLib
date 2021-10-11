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

      Modelica.Blocks.Sources.RealExpression realExpression(y=TLayer_dif)
        annotation (Placement(transformation(extent={{30,-40},{10,-20}})));
      parameter Real bandwidth "Bandwidth around reference signal";
      Modelica.Blocks.Math.Sum sumTLayers(nin=n)
        annotation (Placement(transformation(extent={{-72,26},{-52,46}})));
      Modelica.Blocks.Math.Division meanTemperatureDynamicStorage
        annotation (Placement(transformation(extent={{-42,20},{-22,40}})));
      Modelica.Blocks.Sources.RealExpression realExpressionDynamic(y=n)
        annotation (Placement(transformation(extent={{-86,2},{-66,22}})));
    equation
      connect(sumTLayers.y,meanTemperatureDynamicStorage. u1)
        annotation (Line(points={{-51,36},{-44,36}},                       color={0,0,127}));
      connect(realExpressionDynamic.y,meanTemperatureDynamicStorage. u2)
        annotation (Line(points={{-65,12},{-54,12},{-54,24},{-44,24}},     color={0,0,127}));
      connect(TLayers, sumTLayers.u)
        annotation (Line(points={{-100,36},{-74,36}}, color={0,0,127}));
      connect(meanTemperatureDynamicStorage.y, add.u1) annotation (Line(points=
              {{-21,30},{-12,30},{-12,52},{-2,52}}, color={0,0,127}));
      connect(realExpression.y, add.u2) annotation (Line(points={{9,-30},{-8,
              -30},{-8,40},{-2,40}}, color={0,0,127}));
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
        annotation (Placement(transformation(extent={{-92,-6},{-72,14}})));
      parameter Real bandwidth "Bandwidth around reference signal";
    equation

      connect(TLayers[1], add.u1) annotation (Line(points={{-100,36},{-46,36},{
              -46,52},{-2,52}},
                        color={0,0,127}));
      connect(realExpression1.y, add.u2) annotation (Line(points={{-71,4},{-12,
              4},{-12,40},{-2,40}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end twoPositionController_top;
  end twoPositionControllerCal;

  partial model partialTwoPositionController
    "Base model for the two position controller"

   parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference Temperature for the on off controller";

      parameter Integer n "Number of layers in the buffer storage";

    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{0,36},{20,56}})));
    Modelica.Blocks.Logical.OnOffController onOffController(pre_y_start=true)
      annotation (Placement(transformation(extent={{32,42},{52,62}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=Tref)
      annotation (Placement(transformation(extent={{0,64},{20,84}})));

    Modelica.Blocks.Interfaces.RealInput TLayers[n]
      "Temperatures of the different layers in the buffer storage"
      annotation (Placement(transformation(extent={{-120,16},{-80,56}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{76,42},{96,62}})));
    Modelica.Blocks.Interfaces.RealOutput PLRset
      annotation (Placement(transformation(extent={{100,42},{120,62}})));
    Modelica.Blocks.Sources.RealExpression realZero
      annotation (Placement(transformation(extent={{22,14},{42,34}})));
    Modelica.Blocks.Interfaces.RealInput PLRin
      annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
  equation
    connect(add.y,onOffController. u)
      annotation (Line(points={{21,46},{30,46}}, color={0,0,127}));
    connect(realExpression.y, onOffController.reference) annotation (Line(points={{21,74},
            {24,74},{24,58},{30,58}},         color={0,0,127}));
    connect(switch1.y, PLRset)
      annotation (Line(points={{97,52},{110,52}}, color={0,0,127}));
    connect(realZero.y, switch1.u3) annotation (Line(points={{43,24},{68,24},{
            68,44},{74,44}}, color={0,0,127}));
    connect(PLRin, switch1.u1) annotation (Line(points={{-100,90},{68,90},{68,
            60},{74,60}}, color={0,0,127}));
    connect(onOffController.y, switch1.u2)
      annotation (Line(points={{53,52},{74,52}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end partialTwoPositionController;
end BaseClass;
