within ControlUnity.AdvancedControl;
model AdvancedControl_modularBoiler
  "Advanced control for modular boiler"
  parameter Boolean use_BufferStorage=false "true=Pufferspeicher wird ausgewählt, false=Vorlauftemperaturregelung" annotation(choices(
      choice=true "Control with buffer storage",
      choice=false "control without buffer storage"));

  ControlUnity.flowTemperatureController.flowTemperatureControl_modularBoiler
    vorlauftemperaturRegelung_modularBoiler1 if not use_BufferStorage
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Interfaces.RealInput PLR_ein
    annotation (Placement(transformation(extent={{-120,54},{-80,94}})));
  Modelica.Blocks.Interfaces.RealInput T_ein
    annotation (Placement(transformation(extent={{-120,16},{-80,56}})));
  Modelica.Blocks.Interfaces.RealOutput PLR_aus
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  twoPositionController.twoPositionControllerAdvanced_modularBoiler
    twoPositionControllerAdvanced_modularBoiler if use_BufferStorage
    annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
equation

  connect(PLR_ein, vorlauftemperaturRegelung_modularBoiler1.PLR_ein)
    annotation (Line(points={{-100,74},{-56,74},{-56,67},{-10,67}}, color={0,0,127}));
  connect(T_ein, vorlauftemperaturRegelung_modularBoiler1.Tamb) annotation (
      Line(points={{-100,36},{-16,36},{-16,59},{-10,59}}, color={0,0,127}));
  connect(vorlauftemperaturRegelung_modularBoiler1.PLRset, PLR_aus) annotation (
     Line(points={{10,59.6},{52,59.6},{52,40},{100,40}}, color={0,0,127}));
  connect(PLR_ein, twoPositionControllerAdvanced_modularBoiler.PLR_ein)
    annotation (Line(points={{-100,74},{-54,74},{-54,9},{-4,9}}, color={0,0,127}));
  connect(twoPositionControllerAdvanced_modularBoiler.PLR_aus, PLR_aus)
    annotation (Line(points={{16,3.4},{54,3.4},{54,40},{100,40}}, color={0,0,127}));
end AdvancedControl_modularBoiler;
