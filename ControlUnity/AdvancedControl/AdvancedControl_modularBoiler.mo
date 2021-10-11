within ControlUnity.AdvancedControl;
model AdvancedControl_modularBoiler
  "Advanced control for modular boiler"
  extends ControlUnity.AdvancedControl.partialAdvancedControl.partialAdvancedController;
  parameter Boolean use_BufferStorage=false "true=Pufferspeicher wird ausgewählt, false=Vorlauftemperaturregelung" annotation(choices(
      choice=true "Control with buffer storage",
      choice=false "control with flow temperature control"));


    // Flow temperature control
 flowTemperatureController.flowTemperatureControl_modularBoiler
    flowTemperatureControl_modularBoiler if not use_Bufferstorage
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Interfaces.RealInput Tamb if not use_Bufferstorage
    annotation (Placement(transformation(extent={{-120,-84},{-80,-44}})));



  //Two position control with buffer storage
twoPositionController.twoPositionControllerAdvanced_modularBoiler
    twoPositionControllerAdvanced_modularBoiler(redeclare
      twoPositionController.BaseClass.twoPositionControllerCal.twoPositionController_top
      twoPositionController_layers) if             use_BufferStorage
    annotation (Placement(transformation(extent={{2,46},{22,66}})));
  Modelica.Blocks.Interfaces.RealInput TLayer[n] if use_Bufferstorage
    annotation (Placement(transformation(extent={{-120,26},{-80,66}})));

equation
  //


  if use_Bufferstorage then
  connect(PLRin, twoPositionControllerAdvanced_modularBoiler.PLR_ein)
    annotation (Line(points={{-100,90},{-50,90},{-50,65},{2,65}}, color={0,0,127}));
  connect(TLayer, twoPositionControllerAdvanced_modularBoiler.TLayers)
    annotation (Line(points={{-100,46},{-50,46},{-50,59.8},{2,59.8}}, color={0,0,
          127}));
  connect(twoPositionControllerAdvanced_modularBoiler.PLR_aus, PLRset)
    annotation (Line(points={{22,59.4},{56,59.4},{56,30},{100,30}}, color={0,0,127}));
  else
  connect(Tin, flowTemperatureControl_modularBoiler.Tin) annotation (Line(
        points={{-100,-4},{-50,-4},{-50,-5.8},{0,-5.8}}, color={0,0,127}));
  connect(Tamb, flowTemperatureControl_modularBoiler.Tamb) annotation (Line(
        points={{-100,-64},{-52,-64},{-52,-11},{0,-11}}, color={0,0,127}));
  connect(flowTemperatureControl_modularBoiler.PLRset, PLRset) annotation (Line(
        points={{20,-10.4},{38,-10.4},{38,-10},{56,-10},{56,30},{100,30}},
        color={0,0,127}));
   end if;
end AdvancedControl_modularBoiler;
