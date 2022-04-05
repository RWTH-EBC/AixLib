within AixLib.Systems.ModularEnergySystems.ControlUnity.twoPositionController;
model TwoPositionControllerSimple_modularBoiler
  "Simple two position controller"
  extends
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController(n
      =1, onOffController(bandwidth=bandwidth, pre_y_start=false));

  parameter Modelica.SIunits.Temperature T_ref           "Solltemperatur";
   parameter Real bandwidth     "Bandwidth around reference signal";

equation

  connect(TLayers[1], onOffController.u) annotation (Line(points={{-100,-22},{
          -36,-22},{-36,0},{32,0}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{-122,0},{-82,40}})),
    Documentation(info="<html>
<p>Simple two position controller for heat generators. This model regulates the flow temperature of the boiler, which has a fix value determined by the user before the beginning of the simulation. </p>
<h4>Important parameters</h4>
<ul>
<li>Tref: With this parameter, the user can select the set temperature</li>
</ul>
</html>"));
end TwoPositionControllerSimple_modularBoiler;
