within AixLib.Fluid.DataCenters;
model ServerRoomLiquidCooled
  extends AixLib.Fluid.DataCenters.BaseClasses.PartialServerRoom(volumeInlet(
        nPorts=2, V=VInlet), volumeRoom(nPorts=3, V=VRoom));

  Modelica.Fluid.Vessels.ClosedVolume volumeHotAisle1(
    redeclare package Medium = Medium,
    use_portsData=false,
    use_HeatTransfer=true,
    each X_start=X_start,
    nPorts=2,
    T_start=T_start,
    V=0.01)   annotation (Placement(transformation(extent={{-66,20},{-74,28}})));
  Modelica.Fluid.Vessels.ClosedVolume volumeHotAisle4(
    redeclare package Medium = Medium,
    use_portsData=false,
    each X_start=X_start,
    nPorts=2,
    use_HeatTransfer=true,
    T_start=T_start,
    V=0.01)   annotation (Placement(transformation(extent={{76,20},{84,28}})));
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
    V=0.01)   annotation (Placement(transformation(extent={{-8,0},{8,16}})));
  RackLiquidCooled                                               racks1(
      redeclare package Medium = Medium,
    nRacks=10,
    T_startAir=T_start,
    m_flow_nominal=1)
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
  RackLiquidCooled                                               racks2(
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
<p>ReducedOrderModel is a simple component to compute the air temperature, heating load, etc. for a thermal zone. The zone is simplified to one outer wall, one inner wall and one air node. It is build out of standard components and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleOuterWall\">SimpleOuterWall</a> and <a href=\"AixLib.Building.LowOrder.BaseClasses.SimpleInnerWall\">SimpleInnerWall</a>. </p>
<p>The partial class contains following components: </p>
<ul>
<li>inner and outer walls</li>
<li>windows</li>
<li>convective heat transfer of the walls and windows</li>
<li>influence of air temperature caused by infiltration</li>
<li>connectors for internal gains (conv. and rad.) </li>
</ul>
<h4>Main equations</h4>
<p>The concept is described in VDI 6007. All equations can be found in VDI 6007. All outer walls and inner walls (including the windows) are merged together to one wall respectively. The inner walls are used as heat storages only, there is no heat transfer out of the zone (adiabate). This assumption is valid as long as the walls are in the zone or touch zones with a similar temperature. All walls, which touch other thermal zones are put together in the outer walls, which have an heat transfer with <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp\">EqAirTemp</a>.</p>
<h4>Assumption and limitations</h4>
<p>The simplifications are based on the VDI 6007, which describes the thermal behaviour of a thermal zone with the equations for an electric circuit, hence they are equal. The heat transfer is described with resistances and the heat storage with capacitances. </p>
<h4>Typical use and important parameters</h4>
<p>The resolution of the model is very rough (only one air node), so the model is primarly thought for computing the air temperature of the room and with that, the heating and cooling load. It is more a heat load generator than a full building model. It is thought mainly for city district simulations, in which a lot of buildings has to be taken into account and the specific cirumstances in one building can be neglected.</p>
<p>Inputs: The model needs the outdoor air temperature and the Infiltration/VentilationRate for the Ventilation, the equivalent outdoor temperature (see <a href=\"AixLib.Building.LowOrder.BaseClasses.EqAirTemp.partialEqAirTemp\">EqAirTemp</a>) for the heat conductance through the outer walls and the solar radiation through the windows. There are two ports, one thermal, one star, for inner loads, heating etc. . </p>
<p>Parameters: Inner walls: R and C for the heat conductance and storage in the wall, A, alpha and epsilon for the heat transfer. Outer walls: Similar to inner walls, but with two R&apos;s, as there is also a conductance through the walls. Windows: g, A, epsilon and a splitfac. Please see VDI 6007 for computing the R&apos;s and C&apos;s</p>
<h4>Options</h4>
<ul>
<li>Only outer walls are considered</li>
<li>Outer and inner walls are considered </li>
<li>Outer and inner walls as well as windows are considered </li>
</ul>
<h4>Validation</h4>
<p>The model is verified with the VDI 6007, see <a href=\"AixLib.Building.LowOrder.Validation.VDI6007\">Validation.VDI6007</a>. A validation with the use of the standard ASHRAE 140 is in progress </p>
<h4>Implementation</h4>
<h4>References</h4>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms.</li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: 10.1016/j.buildenv.2013.12.016.</li>
</ul>
</html>", revisions="<html>
<ul>
<li><i>June 2015,&nbsp;</i> by Moritz Lauster:<br>Changed name solar radiation input from u1 to solRad_in.</li>
</ul>
<ul>
<li><i>October 2014,&nbsp;</i> by Peter Remmen:<br>Implemented.</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end ServerRoomLiquidCooled;
