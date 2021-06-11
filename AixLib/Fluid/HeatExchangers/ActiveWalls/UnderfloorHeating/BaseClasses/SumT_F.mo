within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
model SumT_F "Calculation of average floor surface temperature"
  parameter Integer dis(min=1);

  Modelica.Blocks.Math.MultiSum multiSum(nu=dis, k=fill(1, dis))
    annotation (Placement(transformation(extent={{-16,12},{-2,26}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_F[dis]
    annotation (Placement(transformation(extent={{-68,10},{-48,30}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{46,-8},{62,8}})));
  Modelica.Blocks.Sources.Constant const(k=dis)
    annotation (Placement(transformation(extent={{-18,-34},{-2,-18}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a[dis]
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput T_Fm
    annotation (Placement(transformation(extent={{92,-10},{112,10}})));
equation
  connect(multiSum.y,division. u1)
    annotation (Line(points={{-0.81,19},{32,19},{32,4.8},{44.4,4.8}},
                                                  color={0,0,127}));
  connect(division.u2,const. y) annotation (Line(points={{44.4,-4.8},{32,
         -4.8},{32,-26},{-1.2,-26}},
                      color={0,0,127}));

  connect(division.y, T_Fm)
    annotation (Line(points={{62.8,0},{102,0}}, color={0,0,127}));
    for i in 1:dis loop
      connect(T_F[i].port, port_a[i]) annotation (Line(points={{-68,20},{-84,20},
            {-84,0},{-100,0}},        color={191,0,0}));
      connect(T_F[i].T,multiSum. u[i])
    annotation (Line(points={{-48,20},{-16,20},{-16,19}},color={0,0,127}));
    end for;
 annotation (Icon(graphics={
       Rectangle(
         extent={{-100,100},{100,-100}},
         lineColor={28,108,200},
         fillColor={255,255,255},
         fillPattern=FillPattern.Solid),
       Line(points={{-62,36},{4,36},{-30,36},{-30,-36}}, color={28,108,200}),
       Line(points={{-6,-56},{-6,-20},{12,-20},{-6,-20},{-6,-38},{4,-38}},
           color={28,108,200}),
       Line(points={{14,-52},{14,-58}}, color={28,108,200}),
       Line(points={{24,-56},{24,-40},{38,-40},{38,-56},{38,-40},{52,-40},
             {52,-56}}, color={28,108,200})}),
                 Documentation(info="<html>
<h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
Model for the calculation of the medium floor surface temperature using an underfloor heating circuit with <span style=
\"font-family: Courier New;\">dis</span> elements
</p>
</html>"));
end SumT_F;
