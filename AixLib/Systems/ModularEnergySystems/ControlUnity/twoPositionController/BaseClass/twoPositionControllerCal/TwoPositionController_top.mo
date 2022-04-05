within AixLib.Systems.ModularEnergySystems.ControlUnity.twoPositionController.BaseClass.twoPositionControllerCal;
model TwoPositionController_top
  "Two position controller using top level of buffer storage for calculation"
  extends
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(
    n=1,
    realExpression(y=Tref),
    onOffController(bandwidth=bandwidth));
  parameter Modelica.SIunits.Temperature Tref=273.15+60 "Reference temperature for two position controller using top level temperature";

    parameter Real bandwidth     "Bandwidth around reference signal";

  parameter Modelica.Blocks.Interfaces.IntegerOutput y=n "Value of Integer output";

equation

  connect(TLayers[n], onOffController.u) annotation (Line(points={{-100,-22},{-34,-22},
          {-34,0},{32,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model for a two-position controller that is used in combination with a buffer storage with n layers. This model regulates the flow temperature of the buffer storage. The user can choose between whether the temperature of the top layer or another layer of the storage should be controlled.</p>
<h4>Important parameters</h4>
<ul>
<li>n: The user can decide how many layers the buffer storage has</li>
<li>Tref: With this parameter, the user can select the set temperature</li>
</ul>
</html>"));
end TwoPositionController_top;
