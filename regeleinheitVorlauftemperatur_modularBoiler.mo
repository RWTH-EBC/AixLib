within ;
model regeleinheitVorlauftemperatur_modularBoiler
 parameter Modelica.SIunits.HeatCapacity c_p=4190;
 parameter Modelica.SIunits.HeatFlowRate QNom=50000 "Nominal thermal power";
 parameter Real PLRmin=0.15;
  Modelica.Blocks.Interfaces.RealInput Tset=273.15+70
    annotation (Placement(transformation(extent={{-120,-8},{-80,32}})));
 //Wärmestrom Q_flow berechnen
  Modelica.Blocks.Interfaces.RealInput T_m=273.15 + 50
    "Measurement temperature" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-80,-100})));
  Modelica.Blocks.Interfaces.RealInput m_flow=0.2 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-6,-100})));

  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-70,-4},{-50,16}})));
  Modelica.Blocks.Math.Gain gain(k=c_p)
    annotation (Placement(transformation(extent={{-36,-4},{-16,16}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Interfaces.RealInput Q_losses annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={28,-100})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));


  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{20,54},{40,74}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Qnom)
    annotation (Placement(transformation(extent={{-42,48},{-22,68}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.1,
    Ti=10,
    yMax=1,
    yMin=PLRmin)
    annotation (Placement(transformation(extent={{62,74},{82,94}})));
equation
//Q_flow=m_flow*c_p*(Tset-T_cold);

  connect(Tset, add.u1) annotation (Line(points={{-100,12},{-72,12}},
                color={0,0,127}));
  connect(T_m, add.u2)
    annotation (Line(points={{-80,-100},{-80,0},{-72,0}}, color={0,0,127}));
  connect(add.y, gain.u)
    annotation (Line(points={{-49,6},{-38,6}},   color={0,0,127}));
  connect(m_flow, product1.u2)
    annotation (Line(points={{-6,-100},{-6,-6},{-2,-6}},color={0,0,127}));
  connect(gain.y, product1.u1)
    annotation (Line(points={{-15,6},{-2,6}},                color={0,0,127}));
  connect(Q_losses, add1.u2)
    annotation (Line(points={{28,-100},{28,-6},{44,-6}}, color={0,0,127}));
  connect(product1.y, add1.u1)
    annotation (Line(points={{21,0},{38,0},{38,6},{44,6}}, color={0,0,127}));
  connect(realExpression.y, division.u2)
    annotation (Line(points={{-21,58},{18,58}}, color={0,0,127}));
  connect(add1.y, division.u1) annotation (Line(points={{67,0},{70,0},{70,38},{-68,
          38},{-68,70},{18,70}}, color={0,0,127}));
  annotation (uses(Modelica(version="3.2.3")));
end regeleinheitVorlauftemperatur_modularBoiler;
