within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
class EngineHousingToCooling "Engine housing as a simple two layer wall."

  replaceable package Medium3 =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
                                                           constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);

  parameter Modelica.SIunits.Thickness dInn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
    "Thickness of outer wall of the remaining engine body"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.ThermalConductivity lambda=44.5
    "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.Density rhoEngWall=72000
    "Density of the the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.HeatCapacity CEngWall=dInn*A_WInn*rhoEngWall*c
    "Heat capacity of cylinder wall between combustion chamber and cooling circle"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
    "Heat capacity of the remaining engine body"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.SpecificHeatCapacity c=535
    "Specific heat capacity of the cylinder wall material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Real z
  annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Thickness dCyl
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.Thickness hStr
    annotation (Dialog(tab="Structure Calculations"));
  parameter Real eps
  annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Mass mEng
  annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Mass mEngWall=A_WInn*rhoEngWall*dInn
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.Mass mEngBlo=mEng - mEngWall
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air = 3.84 "Coefficient of heat transfer for air inside and outside the power unit (for DeltaT=15K)"
   annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GCoolChannel=45
    "Thermal conductance of engine housing from the cylinder wall to the water cooling channels" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GEngToAir = A_WInn*alpha_Air
    "Thermal conductance from engine housing to the surrounding air" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GAirToAmb=0.3612
    "Thermal conductance from the sorrounding air to the ambient" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Temperature T_Amb=298.15
    "Ambient temperature" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Temperature T_ExhPowUniOut
    "Outlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 +
      hStr*(1 + 1/(eps - 1))))
    "Area of heat transporting surface from cylinder wall to outer engine block"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
  "Thermal conductance of the inner engine wall"
  annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GEngBlo=lambda*A_WInn/dOut
  "Thermal conductance of the outer engine wall"
  annotation (Dialog(group="Thermal"));

  Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerThermalConductor1(G=
        GInnWall/2) annotation (Placement(transformation(extent={{-78,-30},{-58,
            -10}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond(G=GEngBlo/2)
    annotation (Placement(transformation(extent={{34,-46},{54,-26}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor outerEngineBlock(
    der_T(fixed=false, start=0),
    C=CEngBlo,
    T(fixed=true, start=298.15)) annotation (Placement(transformation(
        origin={64,-46},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowEngine
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor engineToAir(G=GEngToAir)
    annotation (Placement(transformation(extent={{102,-46},{122,-26}},
                                                                     rotation=
           0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambientTemperature(T=T_Amb) annotation (Placement(transformation(extent={{104,-14},
            {124,6}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature logMeanTempCylWall
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor innerWall(
    C=CEngWall,
    der_T(fixed=false, start=0),
    T(fixed=true, start=298.15)) annotation (Placement(transformation(
        origin={-6,-64},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature temperatureInnerWall
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.RealExpression realExpr1(y=innerWall.T)
    annotation (Placement(transformation(extent={{-78,0},{-58,20}})));
  Modelica.Blocks.Nonlinear.VariableLimiter heatLimit
    annotation (Placement(transformation(extent={{-78,-62},{-62,-46}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor toAmbient(G=GAirToAmb)
    annotation (Placement(transformation(extent={{128,-46},{148,-26}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerWallToCoolingCircle(G=GCoolChannel)
    annotation (Placement(transformation(extent={{30,24},{50,44}}, rotation=0)));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature logMeanTempCoolant
    annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=180,
        origin={109,47})));
  Modelica.Blocks.Sources.RealExpression realExpr4(y=T_LogMeanCool) annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={140,48})));

  Modelica.SIunits.MassFlowRate m_Exh
    "Mass flow rate of exhaust gas" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.SpecificHeatCapacity meanCpExh
    "Mean specific heat capacity of the exhaust gas" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Temperature T_Com
    "Calculated maximum combustion temperature inside of cylinder wall"
   annotation (Dialog(group
                           "Thermal"));
  Modelica.SIunits.Temperature T_CylWall
    "Temperature of cylinder wall";
  Modelica.SIunits.Temperature T_CoolSup=363.15
    "Temperature of coolant outlet" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Temperature T_CoolRet=350.15
    "Temperature of coolant inlet" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Temperature T_LogMeanCool
    "Mean logarithmic coolant temperature";
  Modelica.SIunits.Temperature T_Exh=T_ExhPowUniOut+(maximumEngineHeat.y-
      actualHeatFlowEngine.Q_flow)                                                                   /(meanCpExh*m_Exh)
    "Inlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));
  Real QuoT_SupRet=T_CoolSup/T_CoolRet
    "Quotient of coolant supply and return temperature";
  Modelica.Blocks.Sources.RealExpression realExpr2(y=T_CylWall) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-146,18})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerThermalCond2_2(G=GInnWall/2)
    annotation (Placement(transformation(extent={{2,-46},{22,-26}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond2(G=GEngBlo/2)
    annotation (Placement(transformation(extent={{74,-46},{94,-26}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerThermalCond2_1(G=GInnWall/2)
    annotation (Placement(transformation(extent={{-4,24},{16,44}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowCoolingCircle
    annotation (Placement(transformation(extent={{64,24},{84,44}})));
  Modelica.Blocks.Sources.RealExpression maximumEngineHeat
    annotation (Placement(transformation(extent={{-106,-58},{-86,-38}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow actualHeatFlowEngine
    annotation (Placement(transformation(extent={{-48,-64},{-28,-44}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-102,-68},{-92,-58}})));
  Modelica.Blocks.Interfaces.RealOutput engHeatToAmbient annotation (
      Placement(transformation(extent={{96,-96},{124,-68}}),
        iconTransformation(
        extent={{12,-12},{-12,12}},
        rotation=0,
        origin={-88,0})));
  Modelica.Blocks.Interfaces.RealOutput engHeatToCoolant annotation (Placement(
        transformation(extent={{96,4},{124,32}}),  iconTransformation(extent={{-14,-14},
            {14,14}},
        rotation=-90,
        origin={0,-86})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(extent={{152,-14},{132,6}})));
  AixLib.Fluid.Sources.PropertySource_T exhaustStateCHPOutlet(use_T_in=true,
      redeclare package Medium = Medium3)
    annotation (Placement(transformation(extent={{-10,98},{10,78}})));
  Modelica.Blocks.Sources.RealExpression realExpr3(y=T_Exh)
    annotation (Placement(transformation(extent={{-38,52},{-18,72}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_EngineIn(redeclare package Medium =
        Medium3)
    annotation (Placement(transformation(extent={{-90,50},{-70,70}}),
        iconTransformation(extent={{-90,50},{-70,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_EngineOut(redeclare package Medium =
        Medium3) annotation (Placement(transformation(extent={{70,50},{90,70}}),
        iconTransformation(extent={{70,50},{90,70}})));
equation

  T_CylWall=(T_Com-T_Amb)/Modelica.Math.log(T_Com/T_Amb);
  if abs(QuoT_SupRet-1)>0.0001 then
  T_LogMeanCool=(T_CoolSup-T_CoolRet)/Modelica.Math.log(QuoT_SupRet);
  else
  T_LogMeanCool=T_CoolRet;
  end if;

  connect(outerThermalCond.port_b,outerEngineBlock. port)
    annotation (Line(points={{54,-36},{64,-36}}, color={191,0,0}));
  connect(innerThermalConductor1.port_b, heatFlowEngine.port_a)
    annotation (Line(points={{-58,-20},{-40,-20}}, color={191,0,0}));
  connect(heatFlowEngine.port_b,temperatureInnerWall. port) annotation (Line(
        points={{-20,-20},{-12,-20},{-12,10},{-20,10}}, color={191,0,0}));
  connect(realExpr1.y,temperatureInnerWall. T)
    annotation (Line(points={{-57,10},{-42,10}}, color={0,0,127}));
  connect(heatFlowEngine.Q_flow,heatLimit. u) annotation (Line(points={{-30,-30},
          {-30,-38},{-114,-38},{-114,-54},{-79.6,-54}}, color={0,0,127}));
  connect(logMeanTempCylWall.port, innerThermalConductor1.port_a) annotation (
     Line(points={{-100,0},{-90,0},{-90,-20},{-78,-20}}, color={191,0,0}));
  connect(engineToAir.port_b,toAmbient. port_a)
    annotation (Line(points={{122,-36},{128,-36}},
                                                 color={191,0,0}));
  connect(logMeanTempCylWall.T, realExpr2.y) annotation (Line(points={{-122,0},{
          -128,0},{-128,18},{-135,18}}, color={0,0,127}));
  connect(outerThermalCond.port_a,innerThermalCond2_2. port_b)
    annotation (Line(points={{34,-36},{22,-36}}, color={191,0,0}));
  connect(outerEngineBlock.port,outerThermalCond2. port_a)
    annotation (Line(points={{64,-36},{74,-36}}, color={191,0,0}));
  connect(engineToAir.port_a,outerThermalCond2. port_b)
    annotation (Line(points={{102,-36},{94,-36}}, color={191,0,0}));
  connect(innerWallToCoolingCircle.port_a,innerThermalCond2_1. port_b)
    annotation (Line(points={{30,34},{16,34}},color={191,0,0}));
  connect(innerWallToCoolingCircle.port_b, heatFlowCoolingCircle.port_a)
    annotation (Line(points={{50,34},{64,34}}, color={191,0,0}));
  connect(heatLimit.limit1,maximumEngineHeat. y) annotation (Line(points={{-79.6,
          -47.6},{-80,-47.6},{-80,-48},{-85,-48}}, color={0,0,127}));
  connect(heatLimit.y,actualHeatFlowEngine. Q_flow)
    annotation (Line(points={{-61.2,-54},{-48,-54}}, color={0,0,127}));
  connect(actualHeatFlowEngine.port,innerWall. port)
    annotation (Line(points={{-28,-54},{-6,-54}}, color={191,0,0}));
  connect(innerWall.port,innerThermalCond2_1. port_a) annotation (Line(points={{-6,-54},
          {-6,34},{-4,34}},                            color={191,0,0}));
  connect(innerThermalCond2_2.port_a,innerWall. port) annotation (Line(points={{2,-36},
          {-6,-36},{-6,-54},{-6,-54}},        color={191,0,0}));
  connect(heatLimit.limit2,const. y) annotation (Line(points={{-79.6,-60.4},{-82,
          -60.4},{-82,-63},{-91.5,-63}}, color={0,0,127}));
  connect(heatFlowCoolingCircle.Q_flow,engHeatToCoolant)
    annotation (Line(points={{74,24},{74,18},{110,18}}, color={0,0,127}));
  connect(toAmbient.port_b, heatFlowSensor.port_a) annotation (Line(points={{148,
          -36},{158,-36},{158,-4},{152,-4}}, color={191,0,0}));
  connect(heatFlowSensor.port_b,ambientTemperature. port)
    annotation (Line(points={{132,-4},{124,-4}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, engHeatToAmbient) annotation (Line(points={{
          142,-14},{142,-22},{152,-22},{152,-58},{78,-58},{78,-82},{110,-82}},
        color={0,0,127}));
  connect(port_EngineIn,exhaustStateCHPOutlet. port_a)
    annotation (Line(points={{-80,60},{-56,60},{-56,88},{-10,88}},
                                                  color={0,127,255}));
  connect(realExpr3.y,exhaustStateCHPOutlet. T_in)
    annotation (Line(points={{-17,62},{-4,62},{-4,76}}, color={0,0,127}));
  connect(exhaustStateCHPOutlet.port_b, port_EngineOut)
    annotation (Line(points={{10,88},{66,88},{66,60},{80,60}},
                                                color={0,127,255}));
  connect(realExpr4.y,logMeanTempCoolant. T) annotation (Line(points={{129,48},{
          124,48},{124,47},{119.8,47}}, color={0,0,127}));
  connect(logMeanTempCoolant.port, heatFlowCoolingCircle.port_b) annotation (
      Line(points={{100,47},{92,47},{92,34},{84,34}}, color={191,0,0}));
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
         Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
              graphics={
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
          extent={{20,80},{52,-80}},
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
          extent={{-86,98},{84,82}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="%name")}),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end EngineHousingToCooling;
