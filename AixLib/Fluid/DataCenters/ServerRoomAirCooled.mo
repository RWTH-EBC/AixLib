within AixLib.Fluid.DataCenters;
model ServerRoomAirCooled
  extends AixLib.Fluid.DataCenters.BaseClasses.PartialServerRoom(volumeInlet(
        nPorts=2, V=VInlet), volumeRoom(nPorts=3, V=VRoom));



  Modelica.Fluid.Vessels.ClosedVolume volumeHotAisle1(
    redeclare package Medium = Medium,
    use_portsData=false,
    use_HeatTransfer=true,
    each X_start=X_start,
    nPorts=2,
    T_start=T_start,
    V=VHotAisle)
              annotation (Placement(transformation(extent={{-66,20},{-74,28}})));
  Modelica.Fluid.Vessels.ClosedVolume volumeHotAisle4(
    redeclare package Medium = Medium,
    use_portsData=false,
    each X_start=X_start,
    nPorts=2,
    use_HeatTransfer=true,
    T_start=T_start,
    V=VHotAisle)
              annotation (Placement(transformation(extent={{76,20},{84,28}})));
  Modelica.Blocks.Interfaces.RealInput CPUutilization[2] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={70,-100}), iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Fluid.Vessels.ClosedVolume volumeColdAisle(
    redeclare package Medium = Medium,
    use_portsData=false,
    each X_start=X_start,
    use_HeatTransfer=true,
    nPorts=3,
    T_start=T_start,
    V=VColdAisle)
              annotation (Placement(transformation(extent={{-8,0},{8,16}})));
  RackAirCooled                                                  racks1(
      redeclare package Medium = Medium,
    nRacks=10,
    T_startAir=T_start,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
  RackAirCooled                                                  racks2(
      redeclare package Medium = Medium,
    nRacks=10,
    T_startAir=T_start,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Interfaces.RealOutput ITConsumption
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{80,-46},{92,-34}})));
  parameter Modelica.SIunits.Volume VInlet=56.25
    "Volume of the inlet or false floor";
  parameter Modelica.SIunits.Volume VRoom=55
    "Volume of the room excluding the volume taken by racks and other equipment";
  parameter Modelica.SIunits.Volume VColdAisle=13.2 "Volume of the cold aisle";
  parameter Modelica.SIunits.Volume VHotAisle=13.2 "Volume of the hot aisle";
equation

  connect(volumeColdAisle.ports[1], racks1.port_a) annotation (Line(points={{
          -2.13333,-4.44089e-016},{-2.13333,0},{-30,0}},
                                    color={0,127,255}));
  connect(racks2.port_a, volumeColdAisle.ports[2]) annotation (Line(points={{30,0},{
          16,0},{16,-4.44089e-016},{0,-4.44089e-016}},
                                       color={0,127,255}));
  connect(add.y, ITConsumption) annotation (Line(points={{92.6,-40},{104,-40},{
          110,-40}}, color={0,0,127}));
  connect(add.u1, racks2.ITConsumption) annotation (Line(points={{78.8,-36.4},{
          60,-36.4},{60,9},{51,9}}, color={0,0,127}));
  connect(add.u2, racks1.ITConsumption) annotation (Line(points={{78.8,-43.6},{
          -60,-43.6},{-60,9},{-51,9}}, color={0,0,127}));
  connect(volumeInlet.ports[2], volumeColdAisle.ports[3])
    annotation (Line(points={{0,-80},{0,0},{2.13333,0}}, color={0,127,255}));
  connect(volumeHotAisle4.ports[1], volumeRoom.ports[2]) annotation (Line(
        points={{79.2,20},{79.2,20},{0,20},{0,70}}, color={0,127,255}));
  connect(racks2.port_b, volumeHotAisle4.ports[2]) annotation (Line(points={{50,
          0},{68,0},{80.8,0},{80.8,20}}, color={0,127,255}));
  connect(racks1.port_b, volumeHotAisle1.ports[1]) annotation (Line(points={{-50,
          0},{-69.2,0},{-69.2,20}}, color={0,127,255}));
  connect(volumeHotAisle1.ports[2], volumeRoom.ports[3]) annotation (Line(
        points={{-70.8,20},{-70.8,20},{0,20},{0,70}}, color={0,127,255}));
  connect(volumeHotAisle1.heatPort, heatConvOuterwall.port_a) annotation (Line(
        points={{-66,24},{-16,24},{-16,50},{-24,50}}, color={191,0,0}));
  connect(volumeHotAisle4.heatPort, heatConvOuterwall.port_a) annotation (Line(
        points={{76,24},{-16,24},{-16,50},{-24,50}}, color={191,0,0}));
  connect(CPUutilization[1], racks1.CPUutilization) annotation (Line(points={{70,
          -110},{70,-46},{-20,-46},{-20,9},{-29,9}}, color={0,0,127}));
  connect(CPUutilization[2], racks2.CPUutilization) annotation (Line(points={{70,
          -90},{70,-90},{70,-46},{20,-46},{20,9},{29,9}}, color={0,0,127}));
    annotation (
Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{100,100}}),
         graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-92,92},{92,-92}},
          lineColor={0,0,0},
          fillColor={230,230,230},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-58,60},{-36,24}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,60},{-14,24}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-14,60},{8,24}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{8,60},{30,24}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,60},{52,24}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-58,-16},{-36,-52}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,-16},{-14,-52}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-14,-16},{8,-52}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{8,-16},{30,-52}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-16},{52,-52}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This model represents a small server room consisting of two rack rows each contaning 10 racks, a cold and two hot aisles.
The servers are cooled using air.
</p>
</html>", revisions="<html>
<ul>
<li>
<i>June 07, 2017&nbsp;</i>  by Pooyan Jahangiri:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end ServerRoomAirCooled;
