within AixLib.Controls.HeatPump.BaseClasses;
model CalcQdot "Model to calculate needed heat flow rate"
  parameter Modelica.SIunits.HeatFlowRate QdotSecHeaGen_nominal "Nominal heating power of second heat generator" annotation (Dialog(enable=use_secHeaGen));
  parameter Real mediumConc_p "Specific heat capacity of condenser medium";

  Modelica.Blocks.Interfaces.RealOutput ySecHeaGen if use_secHeaGen
                                                   "Relative power of second heat generator, from 0 to 1"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={110,0})));
  Modelica.Blocks.Interfaces.RealInput TSet "Set temperature"
    annotation (Placement(transformation(extent={{-132,44},{-100,76}})));
  Modelica.Blocks.Interfaces.RealInput mFlow_con "Set temperature" annotation (Placement(transformation(extent={{-132,-76},{-100,-44}})));
  Modelica.Blocks.Interfaces.RealInput TCon_out "Output temperature at condenser" annotation (Placement(transformation(extent={{-132,-16},{-100,16}})));
equation
  y = (mFlow_con*mediumConc_p*(TSet-TCon_out))/QdotSecHeaGen_nominal;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end CalcQdot;
