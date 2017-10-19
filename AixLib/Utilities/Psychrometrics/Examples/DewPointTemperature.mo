within AixLib.Utilities.Psychrometrics.Examples;
model DewPointTemperature "Unit test for dew point temperature calculation"
  extends Modelica.Icons.Example;
   package Medium = AixLib.Media.Air "Medium model"
           annotation (choicesAllMatching = true);
  AixLib.Utilities.Psychrometrics.pW_TDewPoi watVapPre
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
    Modelica.Blocks.Sources.Ramp XHum(
    duration=1,
    height=(0.01 - 0.1),
    offset=0.1) "Humidity concentration"
                 annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  AixLib.Utilities.Psychrometrics.pW_X humRat(
                         use_p_in=false)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  AixLib.Utilities.Psychrometrics.TDewPoi_pW TDewPoi
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
equation
  connect(XHum.y, humRat.X_w) annotation (Line(
      points={{-59,10},{-41,10}},
      color={0,0,127}));
  connect(humRat.p_w, TDewPoi.p_w) annotation (Line(
      points={{-19,10},{-1,10}},
      color={0,0,127}));
  connect(TDewPoi.T, watVapPre.T) annotation (Line(
      points={{21,10},{39,10}},
      color={0,0,127}));
  annotation (
experiment(Tolerance=1e-6, StopTime=1.0),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Utilities/Psychrometrics/Examples/DewPointTemperature.mos"
        "Simulate and plot"));
end DewPointTemperature;
