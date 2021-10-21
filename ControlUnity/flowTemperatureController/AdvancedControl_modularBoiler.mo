within ControlUnity.flowTemperatureController;
model AdvancedControl_modularBoiler "Advanced control for modular boiler"
  extends
    ControlUnity.AdvancedControl.partialAdvancedControl.partialAdvancedController;
  parameter Boolean use_BufferStorage=false "true=Pufferspeicher wird ausgewählt, false=Vorlauftemperaturregelung" annotation(choices(
      choice=true "Control with buffer storage",
      choice=false "control with flow temperature control"));

    // Flow temperature control
  flowTemperatureControl_heatingCurve flowTemperatureControl_modularBoiler if
                                            not use_Bufferstorage
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Interfaces.RealInput Tamb if not use_Bufferstorage
    annotation (Placement(transformation(extent={{-120,-84},{-80,-44}})));

  //Two position control with buffer storage
  Modelica.Blocks.Interfaces.RealInput TLayer[n] if use_Bufferstorage
    annotation (Placement(transformation(extent={{-120,26},{-80,66}})));

equation
  //

  if use_Bufferstorage then
  else
    connect(Tin, flowTemperatureControl_modularBoiler.TMea) annotation (Line(
          points={{-100,-4},{-50,-4},{-50,-5.8},{0,-5.8}}, color={0,0,127}));
  connect(Tamb, flowTemperatureControl_modularBoiler.Tamb) annotation (Line(
        points={{-100,-64},{-52,-64},{-52,-11},{0,-11}}, color={0,0,127}));
    connect(flowTemperatureControl_modularBoiler.PLR, PLRset) annotation (Line(
          points={{20,-10.4},{38,-10.4},{38,-10},{56,-10},{56,30},{100,30}},
          color={0,0,127}));
   end if;
end AdvancedControl_modularBoiler;
