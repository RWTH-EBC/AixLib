within AixLib.Fluid.DataCenters.BaseClasses;
partial model PartialServerRoom
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

  parameter Modelica.SIunits.Temperature T_start=295.15
    "Initial temperature for all components" annotation(Dialog(tab="Advanced",group="Initialization"));

  parameter Modelica.SIunits.ThermalResistance RExtRem=0.0427487
    "Resistor Rest outer wall"
    annotation(Dialog(tab="Outer walls"));
  parameter Modelica.SIunits.ThermalResistance RExt=0.004366
    "Resistor 1 outer wall"
    annotation(Dialog(tab="Outer walls"));
  parameter Modelica.SIunits.HeatCapacity CExt=1557570 "Capacity 1 outer wall"
    annotation(Dialog(tab="Outer walls"));
  parameter Modelica.SIunits.Area AExt=238.5 "Outer wall area"
    annotation(Dialog(tab="Outer walls"));

  parameter Modelica.SIunits.CoefficientOfHeatTransfer alphaExt=2.7
    "Outer wall's coefficient of heat transfer (inner side)"
    annotation(Dialog(tab="Outer walls"));

  parameter Modelica.SIunits.Temperature Tmax = 313.15
    "Maximum allowable temperature in the room before a shutdown signal";
  parameter Modelica.Media.Interfaces.Types.MassFraction X_start[Medium.nX]=
      Medium.X_default "Start value of mass fractions m_i/m" annotation(Dialog(tab="Advanced",group="Initialization"));

  ThermalZones.ReducedOrder.RC.BaseClasses.ExteriorWall outerwall(
    port_b(T(
        nominal=293.15,
        min=278.15,
        max=323.15)),
    n=1,
    RExtRem=RExtRem,
    T_start=T_start,
    RExt={RExt},
    CExt={CExt})
    annotation (Placement(transformation(extent={{-68,40},{-50,60}})));

  AixLib.Utilities.HeatTransfer.HeatConv heatConvOuterwall(
                  A=AExt, alpha=alphaExt)
    annotation (Placement(transformation(extent={{-24,40},{-44,60}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a equalAirTemp  annotation (Placement(transformation(extent={{-110,70},{-70,110}}),
                   iconTransformation(extent={{-120,80},{-100,100}})));

  Modelica.Blocks.Interfaces.BooleanOutput emergencyStop
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput T_room
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=Tmax)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,70})));
  Modelica.Fluid.Vessels.ClosedVolume volumeInlet(
    redeclare package Medium = Medium,
    use_portsData=false,
    nPorts=1,
    each X_start=X_start,
    V=56.25,
    T_start=T_start) "Volume of the false floor or liquid dispenser"
    annotation (Placement(transformation(extent={{-10,-80},{10,-100}})));
  Modelica.Fluid.Vessels.ClosedVolume volumeRoom(
    redeclare package Medium = Medium,
    use_portsData=false,
    use_HeatTransfer=true,
    each X_start=X_start,
    nPorts=1,
    V=55,
    T_start=T_start)
              annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
equation
    connect(equalAirTemp, outerwall.port_a) annotation (Line(
        points={{-90,90},{-80,90},{-80,49.0909},{-68,49.0909}},
        color={191,0,0}));
    connect(outerwall.port_b, heatConvOuterwall.port_b) annotation (Line(
        points={{-50,49.0909},{-46.5,49.0909},{-46.5,50},{-44,50}},
        color={191,0,0}));

  connect(greaterThreshold.u, T_room)
    annotation (Line(points={{80,58},{80,50},{110,50}}, color={0,0,127}));
  connect(greaterThreshold.y, emergencyStop) annotation (Line(points={{80,81},{80,
          81},{80,90},{110,90}}, color={255,0,255}));
  connect(volumeRoom.heatPort, heatConvOuterwall.port_a) annotation (Line(
        points={{-10,80},{-16,80},{-16,50},{-24,50}}, color={191,0,0}));
  connect(port_a, volumeInlet.ports[1]) annotation (Line(points={{-100,0},{-100,
          0},{-100,-80},{0,-80}}, color={0,127,255}));

  connect(temperature.port_b, port_b) annotation (Line(points={{50,40},{100,40},
          {100,0},{100,0}},
                          color={0,127,255}));
  connect(temperature.T, T_room)
    annotation (Line(points={{40,51},{40,50},{110,50}}, color={0,0,127}));
  connect(volumeRoom.ports[1], temperature.port_a) annotation (Line(points={{0,70},{
          2,70},{2,40},{30,40}},      color={0,127,255}));
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
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>
Partial server room model based on the multi zone model. This includes an external wall and the convection inside the room. Since server rooms are mainly enclosed in another room, only the temperature of the surrounding room is used as the boundary condition.
</p>
<p>
Classes that extend this model need to implement the structure of the room such as hot and cold aisles and the server racks.
</p>
<p>
Based on the cooling fluid, the size of the inlet and room volume should be modified.
</p>
</html>", revisions="<html>
<ul>
<li>
<i>June 07, 2017&nbsp;</i>  by Pooyan Jahangiri:<br/>
First implementation.
</li>
</ul>
</html>"));
end PartialServerRoom;
