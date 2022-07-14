within AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents;
class GasolineEngineChp_EngineHousing
  "Engine housing as a simple two layer wall."

  replaceable package Medium3 =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
                                                           constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
    "Exhaust gas medium model used in the CHP plant" annotation(choicesAllMatching=true);

  parameter Modelica.Units.SI.Thickness dInn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Calibration properties"));
  parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData
    EngMatData=AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
    "Thermal engine material data for calculations (most common is cast iron)"
    annotation (choicesAllMatching=true, Dialog(tab="Structure", group=
          "Material Properties"));
  constant Modelica.Units.SI.ThermalConductivity lambda=EngMatData.lambda
    "Thermal conductivity of the engine block material"
    annotation (Dialog(tab="Structure", group="Material Properties"));
  constant Modelica.Units.SI.Density rhoEngWall=EngMatData.rhoEngWall
    "Density of the the engine block material"
    annotation (Dialog(tab="Structure", group="Material Properties"));
  constant Modelica.Units.SI.SpecificHeatCapacity c=EngMatData.c
    "Specific heat capacity of the cylinder wall material"
    annotation (Dialog(tab="Structure", group="Material Properties"));
  constant Real z
    "Number of engine cylinders"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  constant Modelica.Units.SI.Thickness dCyl "Engine cylinder diameter"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  constant Modelica.Units.SI.Thickness hStr "Engine stroke"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  constant Real eps
    "Engine compression ratio"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.Units.SI.Mass mEng "Total engine mass"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.Units.SI.ThermalConductance GEngToAmb=0.23
    "Thermal conductance from engine housing to the surrounding air"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.Units.SI.Temperature T_Amb=298.15 "Ambient temperature"
    annotation (Dialog(tab="Thermal"));
  Real nEng
    "Current engine speed"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  Modelica.Units.SI.ThermalConductance CalT_Exh
    "Calculation variable for the temperature of the exhaust gas";
  Modelica.Units.SI.Temperature T_Com
    "Calculated maximum combustion temperature inside the engine"
    annotation (Dialog(tab="Thermal"));
  Modelica.Units.SI.Temperature T_CylWall "Temperature of cylinder wall";
 /* Modelica.SIunits.Temperature T_LogMeanCool
 "Mean logarithmic coolant temperature" annotation (Dialog(tab="Thermal")); */
  Modelica.Units.SI.Temperature T_Exh "Inlet temperature of exhaust gas"
    annotation (Dialog(group="Thermal"));
  Modelica.Units.SI.Temperature T_ExhPowUniOut
    "Outlet temperature of exhaust gas" annotation (Dialog(tab="Thermal"));
  type RotationSpeed=Real(final unit="1/s", min=0);
  Modelica.Units.SI.MassFlowRate m_Exh "Mass flow rate of exhaust gas"
    annotation (Dialog(tab="Thermal"));
  Modelica.Units.SI.SpecificHeatCapacity meanCpExh
    "Mean specific heat capacity of the exhaust gas"
    annotation (Dialog(tab="Thermal"));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_amb
    "Heat port to ambient"                                     annotation (
      Placement(transformation(extent={{-12,-112},{12,-88}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor innerWall(
    C=CEngWall,
    der_T(fixed=false, start=0),
    T(start=T_Amb,
      fixed=true)) "Thermal capacity model of the cylinder wall"
                         annotation (Placement(transformation(
        origin={-24,-58},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.RealExpression realExpr1(y=innerWall.T)
    annotation (Placement(transformation(extent={{-116,-48},{-96,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpr2(y=T_CylWall) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-106,-58})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerThermalCond(G=
        GInnWall/2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow actualHeatFlowEngine
    "Heat flow from engine combustion"
    annotation (Placement(transformation(extent={{-56,-58},{-36,-38}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing_CylToInnerWall
    cylToInnerWall(
    GInnWall=GInnWall,
    dInn=dInn,
    lambda=lambda,
    A_WInn=A_WInn,
    z=z) "Thermal model of the cylinder wall"
         annotation (Placement(transformation(rotation=0, extent={{-84,-58},
            {-64,-38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_coo
    "Heat port to cooling circuit"                             annotation (
      Placement(transformation(extent={{88,-12},{112,12}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor engHeatToCoolant
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing_EngineBlock
    engineBlock(
    CEngBlo=CEngBlo,
    GInnWall=GInnWall,
    GEngBlo=GEngBlo,
    dInn=dInn,
    dOut=dOut,
    lambda=lambda,
    rhoEngWall=rhoEngWall,
    c=c,
    A_WInn=A_WInn,
    z=z,
    mEngBlo=mEngBlo,
    mEng=mEng,
    mEngWall=mEngWall,
    GEngToAmb=GEngToAmb,
    outerEngineBlock(T(start=T_Amb))) "Thermal model of the engine block"
                                      annotation (Placement(transformation(
          rotation=0, extent={{-6,-46},{14,-26}})));

  Modelica.Blocks.Sources.RealExpression calculatedExhaustTemp(y=T_Exh)
    annotation (Placement(transformation(extent={{28,40},{10,60}})));
  Modelica.Blocks.Interfaces.RealOutput exhaustGasTemperature
    "Calculated exhaust gas temperature output to the mechanical engine model"
    annotation (Placement(transformation(extent={{12,-12},{-12,12}},
        rotation=270,
        origin={0,106}),
        iconTransformation(extent={{14,-14},{-14,14}},
        rotation=270,
        origin={0,122})));

protected
  constant Modelica.Units.SI.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2
       + hStr*(1 + 1/(eps - 1))))
    "Area of heat transporting surface from cylinder wall to outer engine block"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.Units.SI.Mass mEngWall=A_WInn*rhoEngWall*dInn
    "Calculated mass of cylinder wall between combustion chamber and cooling circle"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.Units.SI.Mass mEngBlo=mEng - mEngWall
    "Calculated mass of the remaining engine body"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.Units.SI.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
    "Thickness of outer wall of the remaining engine body"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.Units.SI.HeatCapacity CEngWall=dInn*A_WInn*rhoEngWall*c
    "Heat capacity of cylinder wall between combustion chamber and cooling circle"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.Units.SI.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
    "Heat capacity of the remaining engine body"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.Units.SI.ThermalConductance GInnWall=lambda*A_WInn/dInn
    "Thermal conductance of the inner engine wall"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.Units.SI.ThermalConductance GEngBlo=lambda*A_WInn/dOut
    "Thermal conductance of the remaining engine body"
    annotation (Dialog(tab="Thermal"));

equation

 /* if EngOp and m_Exh>0.001 then
  T_CylWall=0.5*(T_Com+T_Amb)*CalTCyl;
  else
  T_CylWall=T_Amb;
  end if;*/
  CalT_Exh = meanCpExh*m_Exh;

  if noEvent(nEng*60<800) then
  T_CylWall=innerWall.T;
  T_Exh=innerWall.T;
  else
  T_CylWall=T_Amb+0.2929*(T_Com-T_Amb);
  T_Exh=T_ExhPowUniOut + abs((cylToInnerWall.maximumEngineHeat.y-actualHeatFlowEngine.Q_flow)/CalT_Exh);
  end if;

 // T_CylWall=T_Amb+0.2929*(T_Com-T_Amb);
  // T_CylWall=(T_Com-T_Amb)/Modelica.Math.log(T_Com/T_Amb);

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
  connect(engineBlock.port_a1, port_amb)
    annotation (Line(points={{0,-45},{0,-100}}, color={191,0,0}));
  connect(innerThermalCond.port_a, innerWall.port)
    annotation (Line(points={{-20,0},{-24,0},{-24,-48}}, color={191,0,0}));
  connect(port_coo, engHeatToCoolant.port_b)
    annotation (Line(points={{100,0},{50,0}}, color={191,0,0}));
  connect(innerThermalCond.port_b, engHeatToCoolant.port_a)
    annotation (Line(points={{0,0},{30,0}}, color={191,0,0}));
  connect(calculatedExhaustTemp.y, exhaustGasTemperature)
    annotation (Line(points={{9.1,50},{0,50},{0,106}}, color={0,0,127}));
  annotation (
    Documentation(revisions="<html><ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>
", info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  <br/>
  The model of the motor housing uses a build-up scheme as a two-layer
  wall with thermal transitions to a circulating cooling medium.
  Assumptions were made to simplify the thermal simulation.
</p>
<h4>
  Assumptions
</h4>
<p>
  From individual cylinders, a total area (assumption: cylinder is at
  bottom dead center) is calculated and the heat conduction is modeled
  as a flat wall. This approximation of the unknown motor geometry with
  heat transfers to the environment and the cooling water circuit needs
  to be calibrated.
</p>
<p>
  The engine block consists of a homogeneous material with known total
  weight and is divided into an inner and an outer part (default is
  grey cast iron)
</p>
<p>
  For simplicity the oil circuit is considered as a capacity in the
  outer engine block that needs to calibrated as well. The cooling
  water circuit is assumed to run between these two parts (only the
  outer part interacts with the environment).
</p>
<p>
  The thickness of the inner engine block is an essential, but unknown
  variable (literature indicates values ​​around 5mm for car engines).
  Attachments and individual different material layers in the engine
  block are not taken into account for simplicity and can be
  approximated by calibration. The insulating housing of the power unit
  has no own capacity.
</p>
<p>
  The heat transfer (cylinder wall to cooling water circuit) is
  calibrated and assumed to be proportional to the temperature
  difference because due to unknown cooling channel geometry the
  calculation of a convective heat transfer coefficient is not
  possible.
</p>
<p>
  The temperature profile of the cylinder wall is homogeneously formed
  from the ambient temperature and the maximum combustion temperature
  (temperature curve in cylinder as a triangle with T_Amb - T_Com -
  T_Amb). Therefore a mean cylinder wall temperature is determinated
  using a bisector in the temperature profile as shown in the following
  figure.
</p>
<p style=\"text-align:center;\">
  <br/>
  <span style=\"font-size: 12pt;\"><img src=
  \"modelica://AixLib/Resources/Images/Fluid/BoilerCHP/CylinderWallTemperature.png\"
  width=\"550\" height=\"375\" alt=\"\"></span>
</p>
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
end GasolineEngineChp_EngineHousing;
