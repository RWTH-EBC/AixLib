within AixLib.ThermalZones.HighOrder.Components.Shadow;
model WeatherDataProcessing "Weather data processing"
  extends RadiationTransfer;
  parameter Integer nDryBulPort=1 "Number of output port(s)";
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemp[
    nDryBulPort]
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b TDryBul[nDryBulPort]
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
equation
  connect(preTemp.port, TDryBul)
    annotation (Line(points={{60,-50},{80,-50},{80,-100},{100,-100}},
                                                  color={191,0,0}));
  for i in 1:nDryBulPort loop
    connect(weaBus.TDryBul, preTemp[i].T)
      annotation (Line(points={{-100,0},{-80,0},{-80,-50},{38,-50}},
                      color={0,0,127}));
  end for;

  annotation (Documentation(revisions="<html>
<ul>
<li><i>December 2023,&nbsp;</i>by Jun Jiang:<br>Implemented.<br>This is for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/1433\">#1433</a>.</li>
</ul>
</html>", info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>This model converts weather data to the solar radiation port and heat port.</p>
<p><b><span style=\"color: #008000;\">Concept</span> </b></p>
<p>See the submodules in the model.</p>
<p><b><span style=\"color: #008000;\">Assumptions</span> </b></p>
<p>Vertical wall surface (til = 90&deg;).</p>
</html>"));
end WeatherDataProcessing;
