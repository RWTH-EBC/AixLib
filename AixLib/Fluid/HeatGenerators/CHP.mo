within AixLib.Fluid.HeatGenerators;
model CHP
  extends AixLib.Fluid.HeatGenerators.BaseClasses.PartialHeatGenerator;
  BaseClasses.Controllers.delayedOnOffController delayedOnOffController
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  BaseClasses.Controllers.PIcontroller pIcontroller
    annotation (Placement(transformation(extent={{0,42},{20,62}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-50,68},{50,28}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString="CHP",
          textStyle={TextStyle.Bold})}),                         Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CHP;
