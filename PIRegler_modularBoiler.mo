within ;
model PIRegler_modularBoiler
 //parameters
 parameter Modelica.SIunits.HeatCapacity c_p=4190;

  Modelica.Blocks.Interfaces.RealInput Tset "Vorlauftemperatur"
    annotation (Placement(transformation(extent={{-120,30},{-80,70}})));
  Modelica.Blocks.Interfaces.RealInput T_m "Measurement temperature"
    annotation (Placement(transformation(extent={{-120,-50},{-80,-10}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01,
    Ti=5,
    yMax=1,
    yMin=0)      annotation (Placement(transformation(extent={{4,40},{24,60}})));
  Modelica.Blocks.Interfaces.RealOutput PLR_vorlauf
    annotation (Placement(transformation(extent={{90,40},{110,60}})));
equation


  connect(Tset, PID.u_s)
    annotation (Line(points={{-100,50},{2,50}}, color={0,0,127}));
  connect(T_m, PID.u_m)
    annotation (Line(points={{-100,-30},{14,-30},{14,38}}, color={0,0,127}));
  connect(PID.y, PLR_vorlauf)
    annotation (Line(points={{25,50},{100,50}}, color={0,0,127}));

  annotation (uses(Modelica(version="3.2.3")));
end PIRegler_modularBoiler;
