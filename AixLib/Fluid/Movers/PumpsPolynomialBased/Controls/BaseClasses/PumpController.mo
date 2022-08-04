within AixLib.Fluid.Movers.PumpsPolynomialBased.Controls.BaseClasses;
partial model PumpController "Pump controller base class"

  parameter AixLib.DataBase.Pumps.PumpPolynomialBased.PumpBaseRecord pumpParam "pump parameter record"
    annotation (choicesAllMatching=true);
  AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus pumpControllerBus
    annotation (Placement(transformation(extent={{-20,80},{20,120}})));
  AixLib.Fluid.Movers.PumpsPolynomialBased.BaseClasses.PumpBus pumpBus
    annotation (Placement(transformation(extent={{-20,-120},{20,-80}}),
        iconTransformation(extent={{-20,-120},{20,-80}})));
  annotation (
    Icon(coordinateSystem(initialScale=0.1),
                    graphics={
        Rectangle(extent={{-58,52},{52,-36}}, pattern=LinePattern.None),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,50},{76,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Text(
          extent={{-70,38},{64,8}},
          lineColor={135,135,135},
          fillColor={0,216,108},
          fillPattern=FillPattern.Solid,
          textString="BaseController"),
        Rectangle(
          extent={{-10,11},{10,-11}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={1,-64},
          rotation=270),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={2,-63},
          rotation=180),
        Rectangle(
          extent={{22,-38},{42,-58}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={32,-47},
          rotation=270),
        Rectangle(
          extent={{-10,10},{10,-10}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={-30,-48},
          rotation=180),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={-30,-49},
          rotation=90),
        Rectangle(
          extent={{-10,11},{10,-11}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          origin={1,-32},
          rotation=90),
        Polygon(
          points={{1,8},{-7,-6},{9,-6},{1,8}},
          lineColor={0,0,0},
          fillColor={79,79,79},
          fillPattern=FillPattern.Solid,
          origin={0,-33},
          rotation=360)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, initialScale=0.1)),
    Documentation(info="<html><p>
  Partial pump controller with states. Currently the states only
  provide on and off mode. This can as well be replaced by the bolean
  onOff signal from the pumpControllerBus.
</p>
</html>",
        revisions="<html><ul>
  <li>2018-01-26 by Peter Matthes:<br/>
    Changes icon to white color to mark it as base class model.
  </li>
  <li>2018-01-10 by Peter Matthes:<br/>
    Removes state graph controller parts from this partial model and
    transfers it to the controllers where they are needed. Not all
    controller will need this why we decided to remove it from here.
  </li>
  <li>2017-12-05 by Peter Matthes<br/>
    Adds parameter pumpParam in oder der pre-configure it for the user.
    Otherwise the pumpBaseRecord will be used if the user does not
    explicitely redeclares the parameter. That will lead to strange
    results because some parameter will be calculated from the these
    pump data.
  </li>
  <li>2017-11-22 by Peter Matthes<br/>
    Initial implementation. Derived from boiler controller.
  </li>
</ul>
</html>"));
end PumpController;
