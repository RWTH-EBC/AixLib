within AixLib.Fluid.HeatExchangers.Examples;
model HeatingRod "Example for the usage of the heating rod model"
  extends Modelica.Icons.Example;
  extends AixLib.Fluid.HeatExchangers.Examples.BaseClasses.Heater(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=V*heatingRod.rho_default/3600,
    Q_flow_nominal=100,
    conPI(k=10),
    vol(V=V/1000),
    mov(nominalValuesDefineDefaultPressureCurve=true));
  AixLib.Fluid.HeatExchangers.HeatingRod heatingRod(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=1000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=289.15,
    Q_flow_nominal=10*Q_flow_nominal,
    eta=0.97)
    annotation (Placement(transformation(extent={{-30,-54},{-2,-26}})));
  Modelica.Blocks.Interfaces.IntegerOutput numSwiHR
    "Number of on switches of heating rod"
    annotation (Placement(transformation(extent={{120,-90},{140,-70}})));
  Modelica.Blocks.Interfaces.RealOutput Pel
    "Electrical power used to provide current heat flow"
    annotation (Placement(transformation(extent={{120,-70},{140,-50}})));
equation
  connect(mov.port_b, heatingRod.port_a)
    annotation (Line(points={{-50,-40},{-30,-40}}, color={0,127,255}));
  connect(heatingRod.port_b, THeaOut.port_a)
    annotation (Line(points={{-2,-40},{20,-40}}, color={0,127,255}));

  connect(conPI.y, heatingRod.u) annotation (Line(points={{-39,30},{-38,30},{-38,
          -31.6},{-32.8,-31.6}}, color={0,0,127}));
  connect(heatingRod.numSwi, numSwiHR) annotation (Line(points={{-1.16,-47.28},
          {-1.16,-46},{0,-46},{0,-80},{130,-80}}, color={255,127,0}));
  connect(heatingRod.Pel, Pel) annotation (Line(points={{-0.6,-31.6},{4,-31.6},
          {4,-60},{130,-60}}, color={0,0,127}));
 annotation(__Dymola_Commands(file= "modelica://AixLib/Resources/Scripts/Dymola/Fluid/HeatExchangers/Examples/HeatingRod.mos"
        "Simulate and plot"),
    experiment(
      StopTime=172800,
      Tolerance=1e-6),
    Diagram(coordinateSystem(extent={{-100,-100},{120,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{120,100}})),
    Documentation(info="<html><p>
  This example illustrates how to use the heating rod model.
</p>
<p>
  The model consist of a water volume with heat loss to the ambient.
  The set point of the water temperature is different between night and
  day. The heater tracks the set point temperature, except for the
  periods in which the water temperature is above the set point.
</p>
<p>
  As output, the number of times the heating rod was used is given
  along with the energy required to supply the heat.
</p>
</html>", revisions="<html>
<ul>
  <li>May 5, 2021, by Fabian Wuellhorst:<br/>
    Added model.<br/>
    This is for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1092\">AixLib, #1092</a>.
  </li>
</ul>
</html>"));
end HeatingRod;
