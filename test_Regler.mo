within ;
model test_Regler
 parameter Modelica.SIunits.HeatCapacity c_p=4190;
 parameter Real PLRmin=0.15;
  Modelica.Blocks.Interfaces.RealInput Tset=27.15+80 "Vorlauftemperatur"
    annotation (Placement(transformation(extent={{-120,30},{-80,70}})));
  Modelica.Blocks.Interfaces.RealInput Q_losses "Wärmeverlust" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={36,-100})));
  Modelica.Blocks.Interfaces.RealInput T_m=273.15+70 "Measurement temperature"
    annotation (Placement(transformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Interfaces.RealInput m_flow "Massenstrom" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-38,-100})));
  Modelica.Blocks.Interfaces.RealOutput Q_bedarf
    "Berechneter Bedarfswärmestrom"
    annotation (Placement(transformation(extent={{90,-38},{110,-18}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=0.1,
    yMax=1,
    yMin=PLRmin) annotation (Placement(transformation(extent={{4,40},{24,60}})));
  Modelica.Blocks.Interfaces.RealOutput PLR_vorlauf
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
equation

Q_bedarf=m_flow*c_p*(Tset-T_m);
  connect(Tset, PID.u_s)
    annotation (Line(points={{-100,50},{2,50}}, color={0,0,127}));
  connect(T_m, PID.u_m)
    annotation (Line(points={{-100,-30},{14,-30},{14,38}}, color={0,0,127}));
  connect(Q_bedarf, Q_bedarf) annotation (Line(points={{100,-28},{94,-28},{94,-28},
          {100,-28}}, color={0,0,127}));
  connect(PID.y, PLR_vorlauf)
    annotation (Line(points={{25,50},{100,50}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.3")));
end test_Regler;
