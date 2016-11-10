within AixLib.HVAC.FacadeVentilationUnit;
model Example
  import ExergyBasedControl;
  extends Modelica.Icons.Example;

  package Medium1 = AixLib.Media.Air;
  package Medium2 = AixLib.Media.Water;

  Modelica.Blocks.Sources.Constant roomTemperature(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-94,48},{-74,68}})));
  Modelica.Blocks.Sources.Sine     outdoorTemperature(
    freqHz=2/3600,
    offset=273.15 + 10,
    amplitude=20)
    annotation (Placement(transformation(extent={{-94,8},{-74,28}})));
  Modelica.Blocks.Sources.Constant roomSetTemperature(k=273.15 + 22)
    annotation (Placement(transformation(extent={{-94,-28},{-74,-8}})));
  Modelica.Blocks.Sources.Constant co2Concentration(k=800)
    annotation (Placement(transformation(extent={{-94,-72},{-74,-52}})));
  AixLib.Fluid.Sources.Boundary_pT ambient_out(
    redeclare package Medium = Medium1,
    use_T_in=true,
    p(displayUnit="Pa") = 101300)
    annotation (Placement(transformation(extent={{6,-88},{26,-68}})));
  AixLib.Fluid.Sources.Boundary_pT ambient_in(
    redeclare package Medium = Medium1,
    p(displayUnit="Pa") = 101300)
    annotation (Placement(transformation(extent={{4,-58},{24,-38}})));
  AixLib.Fluid.Sources.Boundary_pT heating_sink(
    redeclare package Medium = Medium2,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={26,30})));
  AixLib.Fluid.Sources.Boundary_pT cooling_sink(
    redeclare package Medium = Medium2,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={102,32})));
  AixLib.Fluid.Sources.Boundary_pT cooling_source(
    redeclare package Medium = Medium2,
    use_T_in=true,
    p=140000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={126,31})));
  AixLib.Fluid.Sources.Boundary_pT heating_source(
    redeclare package Medium = Medium2,
    use_T_in=true,
    p=140000) annotation (Placement(transformation(
        extent={{-9,-10},{9,10}},
        rotation=270,
        origin={54,31})));
  AixLib.Fluid.Sources.Boundary_pT room_in(
    redeclare package Medium = Medium1,
    use_T_in=false,
    p(displayUnit="Pa") = 101300)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={170,-27})));
  AixLib.Fluid.Sources.Boundary_pT room_out(
    redeclare package Medium = Medium1,
    use_T_in=true,
    p(displayUnit="Pa") = 101300)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={168,-66})));
  Modelica.Blocks.Sources.Constant heatSourceTemperature(k=273.15 + 30)
    annotation (Placement(transformation(extent={{24,74},{44,94}})));
  Modelica.Blocks.Sources.Constant coldsourceTemperature(k=273.15 + 17)
    annotation (Placement(transformation(extent={{84,74},{104,94}})));
  FacadeVentilationUnit facadeVentilationUnit
    annotation (Placement(transformation(extent={{-42,-14},{-6,6}})));
  FacadeVentilationUnit facadeVentilationUnit1
    annotation (Placement(transformation(extent={{74,-44},{110,-24}})));
equation
  connect(heatSourceTemperature.y, heating_source.T_in)
    annotation (Line(points={{45,84},{58,84},{58,41.8}}, color={0,0,127}));
  connect(coldsourceTemperature.y, cooling_source.T_in) annotation (Line(points=
         {{105,84},{105,84},{130,84},{130,43}}, color={0,0,127}));
  connect(roomTemperature.y, room_out.T_in) annotation (Line(points={{-73,58},{-73,
          58},{198,58},{198,-70},{180,-70}},            color={0,0,127}));
  connect(outdoorTemperature.y, ambient_out.T_in) annotation (Line(points={{-73,18},
          {-58,18},{-58,-74},{4,-74}},     color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,100}})),
    experiment(StopTime=3600),
    Documentation(revisions="<html>
<ul>
<li><i><span style=\"font-family: Arial,sans-serif;\">November 10, 2016&nbsp;</i> by Roozbeh Sangi and Marc Baranski:<br>Implemented</span></li>
</ul>
</html>", info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This model shows the usage of the facade ventilation unit and its controller.</span></p>
</html>"),
    __Dymola_experimentSetupOutput);
end Example;
