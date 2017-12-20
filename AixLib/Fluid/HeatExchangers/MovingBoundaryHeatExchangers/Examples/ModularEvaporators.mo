within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Examples;
model ModularEvaporators
  "Example model that shows the usage of a modular evaporator model"
  extends BaseExample(modHeaExc(
      redeclare model MovBouHeaExc = SimpleHeatExchangers.SimpleEvaporator,
      nHeaExc=2,
      dataBus(final nVal=modHeaExc.nHeaExc),
      calBalEquPri=false,
      calBalEquWal=false));
  extends Modelica.Icons.Example;
  annotation (experiment(StopTime=6400));
end ModularEvaporators;
