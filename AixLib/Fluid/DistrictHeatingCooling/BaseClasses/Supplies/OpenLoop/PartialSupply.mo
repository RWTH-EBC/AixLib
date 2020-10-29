within AixLib.Fluid.DistrictHeatingCooling.BaseClasses.Supplies.OpenLoop;
partial model PartialSupply
  "Base class for modeling supply nodes in DHC systems without return lines"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);

  AixLib.Fluid.Sensors.TemperatureTwoPort senT_supply(redeclare package Medium =
        Medium, m_flow_nominal=1,
    tau=0)                        "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Medium) "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Interfaces.RealInput TIn(unit="K")
    "Prescribed supply temperature"  annotation (Placement(transformation(
          extent={{-126,50},{-86,90}}), iconTransformation(extent={{-126,50},{-86,
            90}})));
  Modelica.Blocks.Interfaces.RealInput dpIn(unit="Pa")
    "Prescribed pressure rise" annotation (Placement(transformation(extent={{-126,
            -90},{-86,-50}}), iconTransformation(extent={{-126,-90},{-86,-50}})));
  Sensors.TemperatureTwoPort              senT_return(redeclare package Medium =
        Medium, m_flow_nominal=1,
    tau=0)                        "Return temperature sensor"
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));
equation
  connect(senMasFlo.port_a, senT_supply.port_b)
    annotation (Line(points={{70,0},{60,0}}, color={0,127,255}));
  connect(senMasFlo.port_b, port_b)
    annotation (Line(points={{90,0},{100,0}}, color={0,127,255}));
  connect(port_a, senT_return.port_b)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Polygon(
          points={{20,40},{20,-40},{90,0},{20,40}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This base class provides a common interface for supply node models
  that represent the return flow back from the network but keep the
  loop within the supply model open.
</p>
<ul>
  <li>March 3, 2018, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end PartialSupply;
