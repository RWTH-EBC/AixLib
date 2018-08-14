within AixLib.Fluid.DistrictHeatingCooling.Supplies.ClosedLoop;
model IdealPlant

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);

      parameter Modelica.SIunits.Pressure dp_nominal(displayUnit="Pa")=30000;

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet preOut(redeclare package Medium
      = Medium, use_X_wSet=false,
    dp_nominal=dp_nominal,
    m_flow_nominal=2,
    use_TSet=true)
    annotation (Placement(transformation(extent={{-58,-10},{-38,10}})));
  AixLib.Fluid.HeatExchangers.PrescribedOutlet preOut1(redeclare package Medium
      = Medium, use_X_wSet=false,
    m_flow_nominal=2,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{46,-10},{26,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Medium, m_flow_nominal=2)
    annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
  Modelica.Blocks.Interfaces.RealInput T_coolingSet
    annotation (Placement(transformation(extent={{-126,60},{-86,100}})));
  Modelica.Blocks.Interfaces.RealInput T_heatingSet
    annotation (Placement(transformation(extent={{-126,22},{-86,62}})));
equation
  connect(port_b, preOut1.port_a)
    annotation (Line(points={{100,0},{46,0}}, color={0,127,255}));
  connect(senTem.port_b, preOut1.port_b)
    annotation (Line(points={{8,0},{26,0}}, color={0,127,255}));
  connect(preOut.port_b, senTem.port_a)
    annotation (Line(points={{-38,0},{-12,0}}, color={0,127,255}));
  connect(port_a, preOut.port_a)
    annotation (Line(points={{-100,0},{-58,0}}, color={0,127,255}));
  connect(T_heatingSet, preOut.TSet) annotation (Line(points={{-106,42},{-90,42},
          {-90,42},{-74,42},{-74,8},{-60,8}}, color={0,0,127}));
  connect(T_coolingSet, preOut1.TSet) annotation (Line(points={{-106,80},{60,80},
          {60,8},{48,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-80,80},{80,0}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-80},{80,0}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.None)}),                       Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IdealPlant;
