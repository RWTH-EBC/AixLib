within AixLib.Fluid.HeatExchangers.Examples;
model HeatingRod "Example for the usage of the heating rod model"
  extends Modelica.Icons.Example;
  extends AixLib.Fluid.HeatExchangers.Examples.BaseClasses.Heater(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=V*1000/3600,
    Q_flow_nominal=100,
    conPI(k=10),
    vol(V=V/1000),
    mov(nominalValuesDefineDefaultPressureCurve=true));
  AixLib.Fluid.HeatExchangers.HeatingRod hea(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=1000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_start=289.15,
    Q_flow_nominal=10*Q_flow_nominal)
    annotation (Placement(transformation(extent={{-30,-54},{-2,-26}})));
equation
  connect(mov.port_b, hea.port_a)
    annotation (Line(points={{-50,-40},{-30,-40}}, color={0,127,255}));
  connect(hea.port_b, THeaOut.port_a)
    annotation (Line(points={{-2,-40},{20,-40}},color={0,127,255}));

  connect(conPI.y, hea.u) annotation (Line(points={{-39,30},{-38,30},{-38,-31.6},
          {-32.8,-31.6}}, color={0,0,127}));
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
