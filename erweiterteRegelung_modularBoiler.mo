within ;
model erweiterteRegelung_modularBoiler
  parameter Boolean use_BufferStorage=false "true=Pufferspeicher wird ausgewählt, false=Vorlauftemperaturregelung";

  vorlauftemperaturRegelung_modularBoiler
    vorlauftemperaturRegelung_modularBoiler1
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a if use_BufferStorage
    annotation (Placement(transformation(extent={{-106,-16},{-86,4}})));
  zweipunktRegler_Pufferspeicher zweipunktRegler_Pufferspeicher1 if use_BufferStorage
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b if use_BufferStorage
    annotation (Placement(transformation(extent={{86,-14},{106,6}})));
  Modelica.Blocks.Interfaces.RealInput PLR_ein
    annotation (Placement(transformation(extent={{-120,54},{-80,94}})));
  Modelica.Blocks.Interfaces.RealInput T_ein
    annotation (Placement(transformation(extent={{-120,16},{-80,56}})));
  Modelica.Blocks.Interfaces.RealOutput PLR_aus
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.RealOutput T_Vorlauf
    annotation (Placement(transformation(extent={{90,64},{110,84}})));
equation

  connect(T_ein, zweipunktRegler_Pufferspeicher1.T_ein) annotation (Line(points=
         {{-100,36},{-56,36},{-56,3.2},{-8,3.2}}, color={0,0,127}));
  connect(PLR_ein, zweipunktRegler_Pufferspeicher1.PLR_ein) annotation (Line(
        points={{-100,74},{-112,74},{-112,9},{-8,9}}, color={0,0,127}));
  connect(PLR_ein, vorlauftemperaturRegelung_modularBoiler1.PLR_ein)
    annotation (Line(points={{-100,74},{-56,74},{-56,67},{-10,67}}, color={0,0,127}));
  connect(T_ein, vorlauftemperaturRegelung_modularBoiler1.T_outdoor)
    annotation (Line(points={{-100,36},{-16,36},{-16,59},{-10,59}}, color={0,0,127}));
  connect(vorlauftemperaturRegelung_modularBoiler1.T_Vorlauf, T_Vorlauf)
    annotation (Line(points={{10,59},{50,59},{50,74},{100,74}}, color={0,0,127}));
  connect(vorlauftemperaturRegelung_modularBoiler1.PLR_aus, PLR_aus)
    annotation (Line(points={{10.4,67},{14,67},{14,40},{100,40}}, color={0,0,127}));
  connect(zweipunktRegler_Pufferspeicher1.PLR_aus, PLR_aus) annotation (Line(
        points={{12,3.4},{38,3.4},{38,40},{100,40}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.3")));
end erweiterteRegelung_modularBoiler;
