within AixLib.Fluid.HeatExchangers.BaseClasses;
partial model PartialHeatGen
  "Base Class for modelling heat generation equipment of different types"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  parameter Modelica.SIunits.Temperature T_ref = 293.15;
  Fluid.MixingVolumes.MixingVolume
                volume(
    m_flow_nominal=0.01,
    V=0.01,
    nPorts=2)          annotation(Placement(transformation(extent={{-10,0},{10,20}})));

  Fluid.Sensors.TemperatureTwoPort
                            T_in(
      m_flow_nominal=0.01)                      annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  Fluid.Sensors.MassFlowRate
                         massFlowSensor annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
equation
  connect(port_a, T_in.port_a) annotation (Line(
      points={{-100,0},{-80,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(T_in.port_b, massFlowSensor.port_a) annotation (Line(
      points={{-60,0},{-50,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(massFlowSensor.port_b, volume.ports[1]) annotation (Line(
      points={{-30,0},{-2,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(volume.ports[2], port_b) annotation (Line(
      points={{2,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation(Documentation(info = "<html>
 <p><h4><font color=\"#008000\">Overview</font></h4></p>
 <p><br/>This partial model is a base class for modelling all heat generation equipment. It includes the necessary fluid port and a fluid volume with a thermal connector for heating the fluid.</p>
 <p>This model is just a start and is likely to change in order to be suitable for all heat generation equipment within the lecture.</p>
 </html>", revisions="<html>
 <p>November 2014, Marcus Fuchs</p>
 <p><ul>
 <li>Changed model to use Annex 60 base class</li>
 </ul></p>
 <p>27.11.2013, Marcus Fuchs</p>
 <p><ul>
 <li>removed input for T_set as this is not applicable with solar thermal collectors</li>
 </ul></p>
 <p>02.10.2013, Marcus Fuchs</p>
 <p><ul>
 <li>implemented</li>
 </ul></p>
 </html>"), Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                          graphics));
end PartialHeatGen;
