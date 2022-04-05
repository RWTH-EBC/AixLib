within AixLib.Systems.ModularEnergySystems.ControlUnity.twoPositionController.BaseClass.twoPositionControllerCal;
model TwoPositionController_layers
  "Two position controller using mean temperature of buffer storage for calculation"

  extends
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(
      onOffController(bandwidth=bandwidth));
   parameter Boolean layerCal=true
    "If true, the two-position controller uses the mean temperature of the buffer storage";
    parameter Modelica.SIunits.Temperature TMean=273.15 + 70
                                                           "Mean temperature of all layers of the buffer storage";

  parameter Modelica.SIunits.TemperatureDifference TLayer_dif=8 "Reference difference temperature for the on off controller for the buffer storage with layer calculation";
  parameter Modelica.SIunits.Temperature Tref=273.15+60;
  parameter Real bandwidth     "Bandwidth around reference signal";

  parameter Real Layer=1;

  Modelica.Blocks.Math.Sum sumTLayers(nin=n)
    annotation (Placement(transformation(extent={{-52,18},{-32,38}})));
  Modelica.Blocks.Math.Division meanTemperatureDynamicStorage
    annotation (Placement(transformation(extent={{-22,12},{-2,32}})));
  Modelica.Blocks.Sources.RealExpression realExpressionDynamic(y=n)
    annotation (Placement(transformation(extent={{-60,-6},{-40,14}})));
equation
  connect(sumTLayers.y,meanTemperatureDynamicStorage. u1)
    annotation (Line(points={{-31,28},{-24,28}},                       color={0,0,127}));
  connect(realExpressionDynamic.y,meanTemperatureDynamicStorage. u2)
    annotation (Line(points={{-39,4},{-34,4},{-34,16},{-24,16}},       color={0,0,127}));
  connect(TLayers, sumTLayers.u)
    annotation (Line(points={{-100,-22},{-70,-22},{-70,28},{-54,28}},
                                                  color={0,0,127}));
  connect(meanTemperatureDynamicStorage.y, onOffController.u) annotation (Line(
        points={{-1,22},{20,22},{20,0},{32,0}},  color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model for a two-position controller that is used in combination with a buffer storage with n layers. This model regulates the flow temperature of the buffer storage. The arithmetic mean value of the temperature of the n layers of the buffer storage is used is calculated and regulated.</p>
<h4>Important parameters</h4>
<ul>
<li>n: The user can decide how many layers the buffer storage has</li>
<li>Tref: With this parameter, the user can select the set temperature</li>
</ul>
</html>"));
end TwoPositionController_layers;
