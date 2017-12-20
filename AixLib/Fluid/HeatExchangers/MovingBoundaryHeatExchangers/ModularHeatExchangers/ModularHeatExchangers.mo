within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.ModularHeatExchangers;
model ModularHeatExchangers
  "Model that describes modular moving boundary heat exchangers"
  extends BaseClasses.PartialModularHeatExchangers;

equation
  // Connect missing ports
  //
  for i in 1:nHeaExc loop
    connect(heaExc[i].port_b2,port_b2);
  end for;

  annotation (Diagram(graphics={
                    Line(points={{10,-36},{70,-36},{70,0},{100,0}},
            color={0,127,255})}));
end ModularHeatExchangers;
