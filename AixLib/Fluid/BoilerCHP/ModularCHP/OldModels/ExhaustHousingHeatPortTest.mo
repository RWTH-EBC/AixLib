within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
class ExhaustHousingHeatPortTest
  "Exhaust housing as a simple one layer wall and its heat transfer to the ambient"
  import AixLib.Fluid.BoilerCHP.ModularCHP;

  replaceable package Medium3 =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
                                                           constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);

  parameter Modelica.SIunits.Temperature T_ExhOut
    "Outlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor exhToCooling(G=200)
    annotation (Placement(transformation(extent={{-78,-30},{-58,-10}}, rotation=
           0)));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowExhaustToCoolant
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature logMeanTempExhaust
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature logMeanTempCoolant
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.RealExpression realExpr1(y=T_LogMeanCool)
    annotation (Placement(transformation(extent={{-78,0},{-58,20}})));
  Modelica.Blocks.Nonlinear.VariableLimiter heatLimit1
    annotation (Placement(transformation(extent={{-78,-62},{-62,-46}})));

  Modelica.SIunits.MassFlowRate m_Exh
    "Mass flow rate of exhaust gas" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.SpecificHeatCapacity meanCpExh
    "Mean specific heat capacity of the exhaust gas" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Power Q_ExhMax
    "Maximum heat from exhaust gas" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Power Q_ExhToCool
    "Maximum heat from exhaust gas to the cooling circle" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Power Q_ExhToAmb=heatLimit1.y-heatLimit2.y
    "Remaining heat from exhaust gas to the ambient";
  Modelica.SIunits.Temperature T_CoolSup=363.15
    "Temperature of coolant outlet" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Temperature T_CoolRet=350.15
    "Temperature of coolant inlet" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Temperature T_LogMeanCool
    "Mean logarithmic coolant temperature";
  Real QuoT_SupRet=T_CoolSup/T_CoolRet
    "Quotient of coolant supply and return temperature";
  Modelica.SIunits.Temperature T_ExhIn=T_ExhOut+Q_ExhMax/(meanCpExh*m_Exh)
    "Inlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Temperature T_LogMeanExh
    "Mean logarithmic temperature of exhaust gas";
  Real QuoT_ExhInOut=T_ExhIn/T_ExhOut
    "Quotient of exhaust gas in and outgoing temperature";

  Modelica.Blocks.Sources.RealExpression realExpr2(y=T_LogMeanExh) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-146,18})));
  Modelica.Blocks.Sources.RealExpression maximumExhaustHeat(y=Q_ExhMax)
    annotation (Placement(transformation(extent={{-106,-58},{-86,-38}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-102,-68},{-92,-58}})));
  Modelica.Blocks.Sources.RealExpression realExpr3(y=Q_ExhToAmb)       annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={64,-76})));
  Modelica.Blocks.Nonlinear.VariableLimiter heatLimit2
    annotation (Placement(transformation(extent={{-8,-62},{8,-46}})));
  Modelica.Blocks.Sources.RealExpression maximumHeatToCooling(y=Q_ExhToCool)
    annotation (Placement(transformation(extent={{-38,-58},{-18,-38}})));
  Modelica.Blocks.Sources.Constant const2(
                                         k=0)
    annotation (Placement(transformation(extent={{-30,-68},{-20,-58}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_HeatExchangerIn(redeclare package
      Medium = Medium3)
    annotation (Placement(transformation(extent={{-90,50},{-70,70}}),
        iconTransformation(extent={{-90,50},{-70,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_HeatExchangerOut(redeclare package
      Medium = Medium3)
    annotation (Placement(transformation(extent={{70,50},{90,70}}),
        iconTransformation(extent={{70,50},{90,70}})));
  AixLib.Fluid.Sources.PropertySource_T exhaustStateCHPOutlet(use_T_in=true,
      redeclare package Medium = Medium3)
    annotation (Placement(transformation(extent={{-10,98},{10,78}})));
  Modelica.Blocks.Sources.RealExpression realExpr4(y=T_ExhOut)
    annotation (Placement(transformation(extent={{-38,52},{-18,72}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CoolingCircle
    annotation (Placement(transformation(extent={{88,-12},{112,12}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient
    annotation (Placement(transformation(extent={{-12,-112},{12,-88}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatToAmbient
    annotation (Placement(transformation(extent={{40,-86},{20,-66}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
    exhHeatToCoolingCircle
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
equation

  if abs(QuoT_ExhInOut-1)>0.0001 then
   T_LogMeanExh=(T_ExhIn-T_ExhOut)/Modelica.Math.log(QuoT_ExhInOut);
  else
  T_LogMeanExh=T_ExhIn;
  end if;
  if abs(QuoT_SupRet-1)>0.0001 then
  T_LogMeanCool=(T_CoolSup-T_CoolRet)/Modelica.Math.log(QuoT_SupRet);
  else
  T_LogMeanCool=T_CoolRet;
  end if;

  connect(exhToCooling.port_b, heatFlowExhaustToCoolant.port_a)
    annotation (Line(points={{-58,-20},{-40,-20}}, color={191,0,0}));
  connect(heatFlowExhaustToCoolant.port_b,logMeanTempCoolant. port) annotation (
     Line(points={{-20,-20},{-12,-20},{-12,10},{-20,10}}, color={191,0,0}));
  connect(realExpr1.y,logMeanTempCoolant. T)
    annotation (Line(points={{-57,10},{-42,10}}, color={0,0,127}));
  connect(heatFlowExhaustToCoolant.Q_flow,heatLimit1. u) annotation (Line(
        points={{-30,-30},{-30,-38},{-114,-38},{-114,-54},{-79.6,-54}}, color={0,
          0,127}));
  connect(logMeanTempExhaust.port,exhToCooling. port_a) annotation (Line(points=
         {{-100,0},{-90,0},{-90,-20},{-78,-20}}, color={191,0,0}));
  connect(logMeanTempExhaust.T, realExpr2.y) annotation (Line(points={{-122,0},{
          -128,0},{-128,18},{-135,18}}, color={0,0,127}));
  connect(heatLimit1.limit1,maximumExhaustHeat. y) annotation (Line(points={{-79.6,
          -47.6},{-80,-47.6},{-80,-48},{-85,-48}}, color={0,0,127}));
  connect(heatLimit1.limit2,const1. y) annotation (Line(points={{-79.6,-60.4},{-82,
          -60.4},{-82,-63},{-91.5,-63}}, color={0,0,127}));
  connect(heatLimit1.y,heatLimit2. u)
    annotation (Line(points={{-61.2,-54},{-9.6,-54}}, color={0,0,127}));
  connect(heatLimit2.limit1,maximumHeatToCooling. y) annotation (Line(points={{-9.6,
          -47.6},{-16,-47.6},{-16,-48},{-17,-48}}, color={0,0,127}));
  connect(heatLimit2.limit2,const2. y) annotation (Line(points={{-9.6,-60.4},{-12,
          -60.4},{-12,-63},{-19.5,-63}}, color={0,0,127}));
  connect(port_HeatExchangerOut,exhaustStateCHPOutlet. port_b)
    annotation (Line(points={{80,60},{46,60},{46,88},{10,88}},
                                                color={0,127,255}));
  connect(port_HeatExchangerIn,exhaustStateCHPOutlet. port_a)
    annotation (Line(points={{-80,60},{-46,60},{-46,88},{-10,88}},
                                                  color={0,127,255}));
  connect(realExpr4.y,exhaustStateCHPOutlet. T_in)
    annotation (Line(points={{-17,62},{-4,62},{-4,76}}, color={0,0,127}));
  connect(heatToAmbient.port, port_Ambient)
    annotation (Line(points={{20,-76},{0,-76},{0,-100}}, color={191,0,0}));
  connect(exhHeatToCoolingCircle.port, port_CoolingCircle)
    annotation (Line(points={{62,0},{100,0}}, color={191,0,0}));
  connect(exhHeatToCoolingCircle.Q_flow, heatLimit2.y) annotation (Line(
        points={{42,0},{26,0},{26,-54},{8.8,-54}}, color={0,0,127}));
  connect(heatToAmbient.Q_flow, realExpr3.y)
    annotation (Line(points={{40,-76},{53,-76}}, color={0,0,127}));
  annotation (         Icon(graphics={
        Rectangle(
          extent={{-80,80},{-50,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,80},{-20,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,80},{20,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,80},{50,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,80},{80,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-84,98},{88,82}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="%name")}),
    Documentation(revisions="<html>
<ul>
<li><i>October, 2016&nbsp;</i> by Peter Remmen:<br/>Transfer to AixLib.</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>
", info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p><code><span style=\"color: #006400;\">E</span>xhaust<span style=\"color: #006400;\">&nbsp;housing&nbsp;as&nbsp;a&nbsp;simple&nbsp;o</span>ne<span style=\"color: #006400;\">&nbsp;layer&nbsp;wall </span>and its heat transfer to the ambient.</code></p>
</html>"));
end ExhaustHousingHeatPortTest;
