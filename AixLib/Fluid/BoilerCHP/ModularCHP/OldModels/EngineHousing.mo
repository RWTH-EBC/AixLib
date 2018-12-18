within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
class EngineHousing "Engine housing as a simple two layer wall."

  parameter Modelica.SIunits.Thickness d_Inn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.Thickness d_Out=m_OuterBlock/A_WInn/rho_EngineWall
    "Thickness of outer wall of the remaining engine body"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.ThermalConductivity lambda=44.5
    "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.Density rho_EngineWall=72000
    "Density of the the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.HeatCapacity C_inn=d_Inn*A_WInn*rho_EngineWall*c
    "Heat capacity of cylinder wall between combustion chamber and cooling circle"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.HeatCapacity C_out=d_Out*A_WInn*rho_EngineWall*c
    "Heat capacity of the remaining engine body"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.SpecificHeatCapacity c=535
    "Specific heat capacity of the cylinder wall material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Real z
  annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Thickness d_Cyl
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.Thickness h_Stroke
    annotation (Dialog(tab="Structure Calculations"));
  parameter Real eps
  annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Mass m_EngineBlock
  annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Mass m_InnerBlock=A_WInn*rho_EngineWall*d_Inn
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.Mass m_OuterBlock=m_EngineBlock-m_InnerBlock
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.Temperature T_CoolantSupplyFlow=363.15
    "Temperature of cylinder wall" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Temperature T_CoolantReturnFlow=350.15
    "Temperature of cylinder wall" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air = 3.84 "Coefficient of heat transfer for air inside and outside the power unit (for DeltaT=15K)"
   annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance G_CoolingChannel=45
    "Thermal conductance of engine housing from the cylinder wall to the water cooling channels" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance G_EngToAir = A_WInn*alpha_Air
    "Thermal conductance from engine housing to the surrounding air" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance G_AirToAmb=0.3612
    "Thermal conductance from the sorrounding air to the ambient" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Temperature T_Amb=298.15
    "Ambient temperature" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Temperature T_ExhaustPowUnitOut
    "Outlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*d_Cyl*(d_Cyl/2+h_Stroke*(1+1/(eps-1))))
    "Area of heat transporting surface from cylinder wall to outer engine block"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.ThermalConductance G_inn=lambda*A_WInn/d_Inn
  "Thermal conductance of the inner engine wall"
  annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance G_out=lambda*A_WInn/d_Out
  "Thermal conductance of the outer engine wall"
  annotation (Dialog(group="Thermal"));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor InnerThermalConductor(G=G_inn/2)
    annotation (Placement(transformation(extent={{-78,-30},{-58,-10}}, rotation=
           0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor OuterThermalCond(G=G_out/2)
    annotation (Placement(transformation(extent={{34,-30},{54,-10}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor OuterEngineBlock(
    der_T(fixed=false, start=0),
    C=C_out,
    T(fixed=true, start=298.15)) annotation (Placement(transformation(
        origin={64,-30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowEngine
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor EngineToAir(G=G_EngToAir)
    annotation (Placement(transformation(extent={{102,-30},{122,-10}},
                                                                     rotation=
           0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature AmbientTemperature(T=T_Amb) annotation (Placement(transformation(extent={{104,2},
            {124,22}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature LogMeanTempCylWall
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor InnerWall(
    C=C_inn,
    der_T(fixed=false, start=0),
    T(fixed=true, start=298.15)) annotation (Placement(transformation(
        origin={-6,-64},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TemperatureInnerWall
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.RealExpression realExpr1(y=InnerWall.T)
    annotation (Placement(transformation(extent={{-78,0},{-58,20}})));
  Modelica.Blocks.Nonlinear.VariableLimiter HeatLimit
    annotation (Placement(transformation(extent={{-78,-62},{-62,-46}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor ToAmbient(G=G_AirToAmb)
    annotation (Placement(transformation(extent={{128,-30},{148,-10}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor InnerWallToCoolingCircle(G=G_CoolingChannel)
    annotation (Placement(transformation(extent={{22,42},{42,62}}, rotation=0)));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature LogMeanTempCoolant
    annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=270,
        origin={87,73})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=T_LogMeanCool)
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,90})));

  Modelica.SIunits.MassFlowRate m_Exh
    "Mass flow rate of exhaust gas" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.SpecificHeatCapacity meanCp_Exhaust
    "Mean specific heat capacity of the exhaust gas" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Temperature T_Combustion
    "Calculated maximum combustion temperature inside of cylinder wall"
   annotation (Dialog(group
                           "Thermal"));
  Modelica.SIunits.Temperature T_CylWall
    "Temperature of cylinder wall";
  Modelica.SIunits.Temperature T_LogMeanCool
    "Mean logarithmic coolant temperature";
  Modelica.SIunits.Temperature T_Exhaust=T_ExhaustPowUnitOut+(MaximumEngineHeat.y-ActualHeatFlowEngine.Q_flow)/(meanCp_Exhaust*m_Exh)
    "Inlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));
  Real QuoT_SupRet=T_CoolantSupplyFlow/T_CoolantReturnFlow
    "Quotient of coolant supply and return temperature";
  Modelica.Blocks.Sources.RealExpression realExpr2(y=T_CylWall) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-146,18})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor InnerThermalCond2_2(G=G_inn/2)
    annotation (Placement(transformation(extent={{2,-30},{22,-10}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor OuterThermalCond2(G=G_out/2)
    annotation (Placement(transformation(extent={{74,-30},{94,-10}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor InnerThermalCond2_1(G=G_inn/2)
    annotation (Placement(transformation(extent={{-12,42},{8,62}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowCoolingCircle
    annotation (Placement(transformation(extent={{56,42},{76,62}})));
  Modelica.Blocks.Sources.RealExpression MaximumEngineHeat
    annotation (Placement(transformation(extent={{-106,-58},{-86,-38}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ActualHeatFlowEngine
    annotation (Placement(transformation(extent={{-48,-64},{-28,-44}})));
  Modelica.Blocks.Sources.Constant Const(k=0)
    annotation (Placement(transformation(extent={{-102,-58},{-92,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Output_EngHeatToAmbient annotation (
      Placement(transformation(extent={{96,-96},{124,-68}}),
        iconTransformation(
        extent={{12,-12},{-12,12}},
        rotation=0,
        origin={-86,0})));
  Modelica.Blocks.Interfaces.RealOutput EngHeatToCoolant annotation (Placement(
        transformation(extent={{96,24},{124,52}}), iconTransformation(extent={{-14,-14},
            {14,14}},
        rotation=-90,
        origin={2,-84})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{152,2},{132,22}})));
equation

  T_CylWall=(T_Combustion-T_Amb)/Modelica.Math.log(T_Combustion/T_Amb);
  if abs(QuoT_SupRet-1)>0.0001 then
  T_LogMeanCool=(T_CoolantSupplyFlow-T_CoolantReturnFlow)/Modelica.Math.log(QuoT_SupRet);
  else
  T_LogMeanCool=T_CoolantReturnFlow;
  end if;

  connect(OuterThermalCond.port_b, OuterEngineBlock.port)
    annotation (Line(points={{54,-20},{64,-20}}, color={191,0,0}));
  connect(InnerThermalConductor.port_b, heatFlowEngine.port_a)
    annotation (Line(points={{-58,-20},{-40,-20}}, color={191,0,0}));
  connect(heatFlowEngine.port_b, TemperatureInnerWall.port) annotation (Line(
        points={{-20,-20},{-12,-20},{-12,10},{-20,10}}, color={191,0,0}));
  connect(realExpr1.y, TemperatureInnerWall.T)
    annotation (Line(points={{-57,10},{-42,10}}, color={0,0,127}));
  connect(heatFlowEngine.Q_flow, HeatLimit.u) annotation (Line(points={{-30,-30},
          {-30,-38},{-114,-38},{-114,-54},{-79.6,-54}}, color={0,0,127}));
  connect(LogMeanTempCylWall.port, InnerThermalConductor.port_a) annotation (
      Line(points={{-100,0},{-90,0},{-90,-20},{-78,-20}}, color={191,0,0}));
  connect(EngineToAir.port_b, ToAmbient.port_a)
    annotation (Line(points={{122,-20},{128,-20}},
                                                 color={191,0,0}));
  connect(LogMeanTempCylWall.T, realExpr2.y) annotation (Line(points={{-122,0},{
          -128,0},{-128,18},{-135,18}}, color={0,0,127}));
  connect(OuterThermalCond.port_a, InnerThermalCond2_2.port_b)
    annotation (Line(points={{34,-20},{22,-20}}, color={191,0,0}));
  connect(OuterEngineBlock.port, OuterThermalCond2.port_a)
    annotation (Line(points={{64,-20},{74,-20}}, color={191,0,0}));
  connect(EngineToAir.port_a, OuterThermalCond2.port_b)
    annotation (Line(points={{102,-20},{94,-20}}, color={191,0,0}));
  connect(InnerWallToCoolingCircle.port_a, InnerThermalCond2_1.port_b)
    annotation (Line(points={{22,52},{8,52}}, color={191,0,0}));
  connect(InnerWallToCoolingCircle.port_b, heatFlowCoolingCircle.port_a)
    annotation (Line(points={{42,52},{56,52}}, color={191,0,0}));
  connect(LogMeanTempCoolant.port, heatFlowCoolingCircle.port_b)
    annotation (Line(points={{87,64},{87,52},{76,52}}, color={191,0,0}));
  connect(realExpression.y, LogMeanTempCoolant.T)
    annotation (Line(points={{81,90},{87,90},{87,83.8}}, color={0,0,127}));
  connect(HeatLimit.limit1, MaximumEngineHeat.y) annotation (Line(points={{-79.6,
          -47.6},{-80,-47.6},{-80,-48},{-85,-48}}, color={0,0,127}));
  connect(HeatLimit.y, ActualHeatFlowEngine.Q_flow)
    annotation (Line(points={{-61.2,-54},{-48,-54}}, color={0,0,127}));
  connect(ActualHeatFlowEngine.port, InnerWall.port)
    annotation (Line(points={{-28,-54},{-6,-54}}, color={191,0,0}));
  connect(InnerWall.port, InnerThermalCond2_1.port_a) annotation (Line(points={{
          -6,-54},{-6,38},{-18,38},{-18,52},{-12,52}}, color={191,0,0}));
  connect(InnerThermalCond2_2.port_a, InnerWall.port) annotation (Line(points={{
          2,-20},{-2,-20},{-2,-54},{-6,-54}}, color={191,0,0}));
  connect(HeatLimit.limit2, Const.y) annotation (Line(points={{-79.6,-60.4},{-82,
          -60.4},{-82,-63},{-91.5,-63}}, color={0,0,127}));
  connect(heatFlowCoolingCircle.Q_flow, EngHeatToCoolant)
    annotation (Line(points={{66,42},{66,38},{110,38}}, color={0,0,127}));
  connect(ToAmbient.port_b, heatFlowSensor.port_a) annotation (Line(points={{
          148,-20},{158,-20},{158,12},{152,12}}, color={191,0,0}));
  connect(heatFlowSensor.port_b, AmbientTemperature.port)
    annotation (Line(points={{132,12},{124,12}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, Output_EngHeatToAmbient) annotation (Line(
        points={{142,2},{142,-6},{152,-6},{152,-62},{80,-62},{80,-82},{110,
          -82}}, color={0,0,127}));
  annotation (
    Documentation(revisions="<html>
<ul>
<li><i>October, 2016&nbsp;</i> by Peter Remmen:<br/>Transfer to AixLib.</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>
", info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p><code><span style=\"color: #006400;\">Engine&nbsp;housing&nbsp;as&nbsp;a&nbsp;simple&nbsp;t</span>wo<span style=\"color: #006400;\">&nbsp;layer&nbsp;wall.</span></code></p>
</html>"),
         Icon(graphics={
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
          extent={{-80,96},{82,82}},
          lineColor={28,108,200},
          textString="Heat from Engine",
          textStyle={TextStyle.Bold})}));
end EngineHousing;
