within AixLib.Fluid.HeatPumps.BaseClasses.HeatPumpControl;
block TSetToNSet
  "Converts a desired temperature to a certain compressor speed"

  Modelica.Blocks.Logical.Switch swiNull
    "If an error occurs, the value of the conZero block will be used(0)"
    annotation (Placement(transformation(extent={{66,-10},{86,10}})));
  Modelica.Blocks.Sources.Constant conZer(k=0)
    "If an error occurs, the compressor speed is set to zero"
    annotation (Placement(transformation(extent={{38,-24},{50,-12}})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set temperature"
    annotation (Placement(transformation(extent={{-130,26},{-100,56}})));
  Modelica.Blocks.Interfaces.RealOutput nOut
    "Relative speed of compressor. From 0 to 1"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Controls.Interfaces.HeatPumpControlBus sigBusHP
    annotation (Placement(transformation(extent={{-128,-40},{-94,-10}})));
equation
  connect(conZer.y, swiNull.u3) annotation (Line(points={{50.6,-18},{58,-18},{
          58,-8},{64,-8}}, color={0,0,127}));
  connect(swiNull.y, nOut) annotation (Line(points={{87,0},{96,0},{96,0},{102,0},
          {102,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TSetToNSet;
