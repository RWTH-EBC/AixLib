within AixLib.ThermalZones.HighOrder.Components.Shadow;
model WeaDatPrcs "Weather data processing"
  extends RadTrans;
  parameter Integer nDryBulPort=1 "Number of output";
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
    connect(weaBus.TDryBul, preTemp[i].T);
  end for;
end WeaDatPrcs;
