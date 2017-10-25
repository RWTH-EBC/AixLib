within AixLib.Fluid.HeatExchangers.BaseClasses;
partial model PartialHeatGen
  "Base Class for modelling heat generation equipment of different types"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  parameter Modelica.SIunits.Temperature T_ref = 293.15;
  Fluid.MixingVolumes.MixingVolume
                volume(
    nPorts=2,
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_small=m_flow_small,
    final allowFlowReversal=allowFlowReversal,
    V=vol)             annotation(Placement(transformation(extent={{-10,0},{10,20}})));

  Fluid.Sensors.TemperatureTwoPort
                            T_in(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)            annotation(Placement(transformation(extent = {{-80, -10}, {-60, 10}})));
  Fluid.Sensors.MassFlowRate
                         massFlowSensor annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
  Fluid.Sensors.TemperatureTwoPort
                            T_out(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)            annotation(Placement(transformation(extent={{30,-10},
            {50,10}})));
equation
  connect(port_a, T_in.port_a) annotation (Line(
      points={{-100,0},{-80,0}},
      color={0,127,255}));
  connect(T_in.port_b, massFlowSensor.port_a) annotation (Line(
      points={{-60,0},{-50,0}},
      color={0,127,255}));
  connect(massFlowSensor.port_b, volume.ports[1]) annotation (Line(
      points={{-30,0},{-2,0}},
      color={0,127,255}));
  connect(volume.ports[2], T_out.port_a)
    annotation (Line(points={{2,0},{30,0}}, color={0,127,255}));
  connect(T_out.port_b, port_b)
    annotation (Line(points={{50,0},{100,0}}, color={0,127,255}));
  annotation(Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>This partial model is a base class for modelling all heat generation
 equipment. It includes the necessary fluid port and a fluid volume with a
 thermal connector for heating the fluid.</p>
 <p>This model is just a start and is likely to change in order to be suitable
 for all heat generation equipment within the lecture.</p>
 </html>", revisions="<html>
 <ul>
 <li><i>November 2014&nbsp;</i>
    by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class</li>
 <li><i>November 27, 2013&nbsp;</i>
    by Marcus Fuchs:<br/>
    Removed input for T_set as this is not applicable with solar thermal
    collectors</li>
 <li><i>October 2, 2013&nbsp;</i>
    by Marcus Fuchs:<br/>
    Implemented</li>
 </ul>
 </html>"));
end PartialHeatGen;
