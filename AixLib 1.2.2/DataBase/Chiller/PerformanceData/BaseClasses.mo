within AixLib.DataBase.Chiller.PerformanceData;
package BaseClasses "Package with partial classes of Performance Data"
  partial model PartialPerformanceData
    "Model with a replaceable for different methods of data aggregation"
    Modelica.Blocks.Interfaces.RealOutput Pel(final unit="W", final displayUnit="kW")
                                                        "Electrical Power consumed by HP" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,-110})));
    Modelica.Blocks.Interfaces.RealOutput QCon(final unit="W", final displayUnit="kW")
      "Heat flow rate through Condenser" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-80,-110})));
    AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus
      "Bus-connector used in a chiller" annotation (Placement(
          transformation(
          extent={{-15,-14},{15,14}},
          rotation=0,
          origin={1,104})));
    Modelica.Blocks.Interfaces.RealOutput QEva(final unit="W", final displayUnit="kW")
                                                                           "Heat flow rate through Evaporator"  annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={80,-110})));
  protected
    parameter Real scalingFactor=1 "Scaling factor of chiller";

  end PartialPerformanceData;
annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Ellipse(
          extent={{-30.0,-30.0},{30.0,30.0}},
          lineColor={128,128,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains base classes for the package <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData\">AixLib.Fluid.Chillers.BaseClasses.PerformanceData</a>.
</p>
</html>"));
end BaseClasses;
