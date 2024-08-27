within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses;
model RearrangeInputs
  "Helper model to re-arrange the input order for SDF tables"
  parameter Integer nDim(min=1)=1
                                "Number of dimensions";
  parameter Integer outOrd[nDim]=1:nDim "Output order";

  Modelica.Blocks.Interfaces.RealInput u[nDim]
    "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[nDim]
    "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  for i in 1:nDim loop
    connect(u[i], y[outOrd[i]])
      annotation (Line(points={{-120,0},{110,0}}, color={0,0,127}));
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
  Re-arranges the input vector based on the provided order. 
  For instsance, <code>outOrd={2, 1, 3}</code> switches input 
  two and one.
</p>
</html>"));
end RearrangeInputs;
