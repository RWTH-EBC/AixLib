within AixLib.Electrical.AC.OnePhase.Sources.Examples;
model WindTurbine "Example for the WindTurbine AC model"
  extends Modelica.Icons.Example;
  AixLib.Electrical.AC.OnePhase.Sources.WindTurbine  tur(
    table=[3.5, 0;
           5.5,   100;
           12, 900;
           14, 1000;
           25, 1000], h=10,
    scale=10,
    V_nominal=120) "Wind turbine"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={60,0})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      computeWetBulbTemperature=false, filNam=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data"
    annotation (Placement(transformation(extent={{-52,36},{-32,56}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{16,36},{36,56}})));
  AixLib.Electrical.AC.OnePhase.Loads.Resistive
                                            res(P_nominal=-500, V_nominal=120)
    "Resistive line"
    annotation (Placement(transformation(extent={{-22,-30},{-2,-10}})));
  AixLib.Electrical.AC.OnePhase.Sources.Grid sou(f=60, V=120)
    "Voltage source"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  AixLib.Electrical.AC.OnePhase.Lines.TwoPortResistance
                                                  lin(R=0.1)
    "Transmission line"
    annotation (Placement(transformation(extent={{-22,-10},{-2,10}})));
  AixLib.Electrical.AC.OnePhase.Sensors.GeneralizedSensor
                                                    sen "Generalized sensor"
    annotation (Placement(transformation(extent={{8,-10},{28,10}})));
equation
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-32,46},{26,46}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaBus.winSpe,tur. vWin) annotation (Line(
      points={{26,46},{60,46},{60,12}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(sou.terminal, lin.terminal_n) annotation (Line(
      points={{-70,10},{-70,0},{-22,0}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(sou.terminal, res.terminal) annotation (Line(
      points={{-70,10},{-70,-20},{-22,-20}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(lin.terminal_p, sen.terminal_n) annotation (Line(
      points={{-2,0},{8,0}},
      color={0,120,120},
      smooth=Smooth.None));
  connect(sen.terminal_p, tur.terminal) annotation (Line(
      points={{28,0},{50,0}},
      color={0,120,120},
      smooth=Smooth.None));
  annotation (    experiment(StopTime=172800, Tolerance=1e-6),
Documentation(info="<html>
<p>
This model illustrates the use of the wind turbine model which is connected to a AC voltage source and a resistance.
This voltage source can represent the grid to which the
circuit is connected.
Wind data for San Francisco, CA, are used.
The turbine cut-in wind speed is <i>3.5</i> m/s,
and hence it is off in the first day when the wind speed is low.
</p>
</html>",
      revisions="<html>
<ul>
<li>
September 22, 2014, by Marco Bonvini:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://AixLib/Resources/Scripts/Dymola/Electrical/AC/OnePhase/Sources/Examples/WindTurbine.mos"
        "Simulate and plot"), 
   __Dymola_LockedEditing="Model from IBPSA");
end WindTurbine;
