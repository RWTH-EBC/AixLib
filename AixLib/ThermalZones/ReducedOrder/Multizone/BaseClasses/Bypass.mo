within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Bypass
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{8,-10},{28,10}})));
  Modelica.Blocks.Interfaces.BooleanInput u1
                                    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput natural
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealOutput y1
                                 "Connector of Real output signal"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Sources.Constant const(k=0.01)
    annotation (Placement(transformation(extent={{-58,-34},{-38,-14}})));
equation
  connect(switch1.u2, u1)
    annotation (Line(points={{6,0},{-100,0}}, color={255,0,255}));
  connect(switch1.y, y1)
    annotation (Line(points={{29,0},{100,0}}, color={0,0,127}));
  connect(natural, switch1.u1) annotation (Line(points={{-100,-40},{-68,-40},{
          -68,8},{6,8}}, color={0,0,127}));
  connect(const.y, switch1.u3) annotation (Line(points={{-37,-24},{-6,-24},{-6,
          -8},{6,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Bypass;
