within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
class EngineHousing1812 "Engine housing as a simple two layer wall."

  replaceable package Medium3 =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
                                                           constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);

  parameter Modelica.SIunits.Thickness dInn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Calibration properties"));
  parameter Modelica.SIunits.ThermalConductivity lambda=44.5
    "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.Density rhoEngWall=72000
    "Density of the the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.SpecificHeatCapacity c=535
    "Specific heat capacity of the cylinder wall material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Real z
    "Number of engine cylinders"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Thickness dCyl
    "Engine cylinder diameter"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Thickness hStr
    "Engine stroke"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Real eps
    "Engine compression ratio"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Mass mEng
    "Total engine mass"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air = 3.84 "Coefficient of heat transfer for air inside and outside the power unit (for DeltaT=15K)"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GCoolChannel=45
    "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
    annotation (Dialog(tab="Calibration properties"));
  parameter Modelica.SIunits.ThermalConductance GAirToAmb=0.36
    "Thermal conductance from the sorrounding air to the ambient"
    annotation (Dialog(tab="Calibration properties"));
  parameter Modelica.SIunits.Temperature T_Amb=298.15
    "Ambient temperature"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.Temperature T_ExhPowUniOut
    "Outlet temperature of exhaust gas"
    annotation (Dialog(tab="Thermal"));

protected
  parameter Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 + hStr*(1 + 1/(eps - 1))))
    "Area of heat transporting surface from cylinder wall to outer engine block"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.SIunits.Mass mEngWall=A_WInn*rhoEngWall*dInn
    "Calculated mass of cylinder wall between combustion chamber and cooling circle"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.SIunits.Mass mEngBlo=mEng - mEngWall
    "Calculated mass of the remaining engine body"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.SIunits.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
    "Thickness of outer wall of the remaining engine body"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.SIunits.HeatCapacity CEngWall=dInn*A_WInn*rhoEngWall*c
    "Heat capacity of cylinder wall between combustion chamber and cooling circle"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
    "Heat capacity of the remaining engine body"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
   "Thermal conductance of the inner engine wall"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GEngBlo=lambda*A_WInn/dOut
   "Thermal conductance of the remaining engine body"
   annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GEngToAir = A_WInn*alpha_Air
   "Thermal conductance from engine housing to the surrounding air"
   annotation (Dialog(tab="Thermal"));

public
  Modelica.SIunits.Temperature T_Com
    "Calculated maximum combustion temperature inside of cylinder wall"
   annotation (Dialog(tab="Thermal"));
  Modelica.SIunits.Temperature T_CylWall
    "Temperature of cylinder wall";
  Modelica.SIunits.Temperature T_LogMeanCool
    "Mean logarithmic coolant temperature" annotation (Dialog(tab="Thermal"));
  Modelica.SIunits.Temperature T_Exh
    "Inlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));
  type RotationSpeed=Real(final unit="1/s", min=0);
  Modelica.SIunits.MassFlowRate m_Exh
    "Mass flow rate of exhaust gas" annotation (Dialog(tab="Thermal"));
  Modelica.SIunits.SpecificHeatCapacity meanCpExh
    "Mean specific heat capacity of the exhaust gas" annotation (Dialog(tab="Thermal"));

protected
  Modelica.SIunits.ThermalConductance CalT_Exh
 "Calculation condition for the inlet temperature of exhaust gas";

/*Modelica.SIunits.Temperature T_CoolSup=363.15
    "Temperature of coolant outlet" annotation (Dialog(tab="Thermal"));
  Modelica.SIunits.Temperature T_CoolRet=350.15
    "Temperature of coolant inlet" annotation (Dialog(tab="Thermal"));
  Real QuoT_SupRet=T_CoolSup/T_CoolRet
    "Quotient of coolant supply and return temperature";
*/

public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient
    annotation (Placement(transformation(extent={{-12,-112},{12,-88}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor innerWall(
    C=CEngWall,
    der_T(fixed=false, start=0),
    T(fixed=true, start=298.15)) annotation (Placement(transformation(
        origin={-24,-58},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.RealExpression realExpr1(y=innerWall.T)
    annotation (Placement(transformation(extent={{-116,-48},{-96,-28}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerWallToCoolingCircle(G=GCoolChannel)
    annotation (Placement(transformation(extent={{20,-10},{40,10}},rotation=0)));
  Modelica.Blocks.Sources.RealExpression realExpr2(y=T_CylWall) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-106,-58})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerThermalCond2_1(G=GInnWall/2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                                                                   rotation=0,
        origin={-10,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow actualHeatFlowEngine
    annotation (Placement(transformation(extent={{-56,-58},{-36,-38}})));
  Modelica.Fluid.Vessels.ClosedVolume   exhaustStateCHPOutlet(
      redeclare package Medium = Medium3,
    nPorts=2,
    use_portsData=false,
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer,
    T_start=T_Amb,
    V=0.005,
    use_HeatTransfer=false)
    annotation (Placement(transformation(extent={{-10,80},{10,60}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_EngineIn(redeclare package Medium =
        Medium3)
    annotation (Placement(transformation(extent={{-90,50},{-70,70}}),
        iconTransformation(extent={{-90,50},{-70,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_EngineOut(redeclare package Medium =
        Medium3) annotation (Placement(transformation(extent={{70,50},{90,70}}),
        iconTransformation(extent={{70,50},{90,70}})));
  CylToInnerWall cylToInnerWall(
    GInnWall=GInnWall,
    dInn=dInn,
    lambda=lambda,
    A_WInn=A_WInn,
    z=z) annotation (Placement(transformation(rotation=0, extent={{-84,-58},{
            -64,-38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CoolingCircle
    annotation (Placement(transformation(extent={{88,-12},{112,12}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor engHeatToCoolant
    annotation (Placement(transformation(extent={{58,-10},{78,10}})));
  OldModels.engineBlockToAmbient1812 engineBlock(
    CEngBlo=CEngBlo,
    GEngToAir=GEngToAir,
    GAirToAmb=GAirToAmb,
    GInnWall=GInnWall,
    GEngBlo=GEngBlo,
    dInn=dInn,
    dOut=dOut,
    lambda=lambda,
    rhoEngWall=rhoEngWall,
    c=c,
    alpha_Air=alpha_Air,
    A_WInn=A_WInn,
    z=z,
    mEngBlo=mEngBlo,
    mEng=mEng,
    mEngWall=mEngWall) annotation (Placement(transformation(rotation=0, extent=
            {{-6,-46},{14,-26}})));

  Modelica.Blocks.Sources.RealExpression calculatedExhaustTemp(y=T_Exh)
    annotation (Placement(transformation(extent={{-30,10},{-48,30}})));
  Modelica.Blocks.Interfaces.RealOutput exhaustGasTemperature
    annotation (Placement(transformation(extent={{-72,8},{-96,32}})));
equation

 /* if EngOp and m_Exh>0.001 then
  T_CylWall=0.5*(T_Com+T_Amb)*CalTCyl;
  else
  T_CylWall=T_Amb;
  end if;*/
  CalT_Exh = if (meanCpExh*m_Exh<0.001) then 1 else meanCpExh*m_Exh;
  T_Exh=T_ExhPowUniOut + (cylToInnerWall.maximumEngineHeat.y
 - actualHeatFlowEngine.Q_flow)/CalT_Exh;
  T_CylWall=(T_Com-T_Amb)/Modelica.Math.log(T_Com/T_Amb);
// T_CylWall=0.5*(T_Com+T_Amb)*CalTCyl;

 /* if abs(QuoT_SupRet-1)>0.0001 then
  T_LogMeanCool=(T_CoolSup-T_CoolRet)/Modelica.Math.log(QuoT_SupRet);
  else
  T_LogMeanCool=T_CoolRet;
  end if; */

  connect(actualHeatFlowEngine.port,innerWall. port)
    annotation (Line(points={{-36,-48},{-24,-48}},color={191,0,0}));
  connect(engineBlock.port_a, innerWall.port) annotation (Line(points={{-5,-32},
          {-24,-32},{-24,-48}},      color={191,0,0}));
  connect(cylToInnerWall.y, actualHeatFlowEngine.Q_flow)
    annotation (Line(points={{-63.4,-48},{-56,-48}}, color={0,0,127}));
  connect(cylToInnerWall.T, realExpr2.y) annotation (Line(points={{-83.8,-51},{
          -92,-51},{-92,-58},{-95,-58}},
                                       color={0,0,127}));
  connect(realExpr1.y, cylToInnerWall.T1) annotation (Line(points={{-95,-38},{
          -92,-38},{-92,-45},{-83.8,-45}},
                                        color={0,0,127}));
  connect(engineBlock.port_a1, port_Ambient)
    annotation (Line(points={{0,-45},{0,-100}}, color={191,0,0}));
  connect(innerThermalCond2_1.port_b, innerWallToCoolingCircle.port_a)
    annotation (Line(points={{0,0},{20,0}}, color={191,0,0}));
  connect(innerThermalCond2_1.port_a, innerWall.port)
    annotation (Line(points={{-20,0},{-24,0},{-24,-48}}, color={191,0,0}));
  connect(innerWallToCoolingCircle.port_b, engHeatToCoolant.port_a)
    annotation (Line(points={{40,0},{58,0}}, color={191,0,0}));
  connect(port_CoolingCircle, engHeatToCoolant.port_b)
    annotation (Line(points={{100,0},{78,0}}, color={191,0,0}));
  connect(port_EngineIn, exhaustStateCHPOutlet.ports[1]) annotation (Line(
        points={{-80,60},{-60,60},{-60,80},{-2,80}}, color={0,127,255}));
  connect(port_EngineOut, exhaustStateCHPOutlet.ports[2]) annotation (Line(
        points={{80,60},{60,60},{60,80},{2,80}}, color={0,127,255}));
  connect(calculatedExhaustTemp.y, exhaustGasTemperature)
    annotation (Line(points={{-48.9,20},{-84,20}}, color={0,0,127}));
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
end EngineHousing1812;
