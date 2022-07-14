within AixLib.Fluid.BoilerCHP.ModularCHP;
model ModularCHPIntegrated
  "Modular combined heat and power system model integrated into a heating circuit"
  import AixLib;

  replaceable package Medium_Fuel =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.NaturalGasMixture_TypeAachen
                                                                    constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
    "Fuel medium model used in the CHP plant" annotation(choicesAllMatching=true);
  replaceable package Medium_Coolant = Modelica.Media.Air.DryAirNasa
                                                           constrainedby
    Modelica.Media.Interfaces.PartialMedium
    "Coolant medium model used in the CHP plant" annotation (choicesAllMatching=true);

  replaceable package Medium_HeatingCircuit =
      Modelica.Media.CompressibleLiquids.LinearColdWater   constrainedby
    Modelica.Media.Interfaces.PartialMedium
    "Heating circuit medium model" annotation (
      __Dymola_choicesAllMatching=true);

  parameter
    AixLib.DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_Kirsch_L4_12()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));

  parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData EngMat=
      AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
    "Thermal engine material data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter Modelica.Units.SI.Temperature T_amb=293.15
    "Default ambient temperature"
    annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.Units.SI.AbsolutePressure p_amb=101325
    "Default ambient pressure" annotation (Dialog(group="Ambient Parameters"));
  parameter Real s_til=abs((cHP_PowerUnit.inductionMachine.s_nominal*(
      cHP_PowerUnit.inductionMachine.M_til/cHP_PowerUnit.inductionMachine.M_nominal)
       + cHP_PowerUnit.inductionMachine.s_nominal*sqrt(abs(((cHP_PowerUnit.inductionMachine.M_til
      /cHP_PowerUnit.inductionMachine.M_nominal)^2) - 1 + 2*cHP_PowerUnit.inductionMachine.s_nominal
      *((cHP_PowerUnit.inductionMachine.M_til/cHP_PowerUnit.inductionMachine.M_nominal)
       - 1))))/(1 - 2*cHP_PowerUnit.inductionMachine.s_nominal*((cHP_PowerUnit.inductionMachine.M_til
      /cHP_PowerUnit.inductionMachine.M_nominal) - 1)))
    "Tilting slip of electric machine" annotation (Dialog(tab="Calibration parameters",
        group="Fast calibration - Electric power and fuel usage"));
  parameter Real calFac=0.94
    "Calibration factor for electric power output (default=1)"
    annotation (Dialog(tab="Calibration parameters",
    group="Fast calibration - Electric power and fuel usage"));
  parameter Modelica.Units.SI.ThermalConductance GEngToCoo=33
    "Thermal conductance of engine housing from the cylinder wall to the water cooling channels"
    annotation (Dialog(tab="Calibration parameters", group=
          "Fast calibration - Thermal power output"));
  parameter Modelica.Units.SI.ThermalConductance GCooExhHex=400
    "Thermal conductance of the coolant heat exchanger at nominal flow"
    annotation (Dialog(tab="Calibration parameters", group=
          "Fast calibration - Thermal power output"));
  parameter Modelica.Units.SI.HeatCapacity CExhHex=50000
    "Heat capacity of exhaust heat exchanger(default= 4000 J/K)" annotation (
      Dialog(tab="Calibration parameters", group=
          "Advanced calibration parameters"));
  parameter Modelica.Units.SI.Mass Cal_mEng=0
    "Added engine mass for calibration purposes of the system´s thermal inertia"
    annotation (Dialog(tab="Calibration parameters", group=
          "Advanced calibration parameters"));
  parameter Modelica.Units.SI.Area A_surExhHea=100
    "Surface for exhaust heat transfer" annotation (Dialog(tab=
          "Calibration parameters", group="Advanced calibration parameters"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_Coo=0.4
    "Nominal mass flow rate of coolant inside the engine cooling circle"
    annotation (Dialog(tab="Calibration parameters", group=
          "Advanced calibration parameters"));
  parameter Modelica.Units.SI.Thickness dInn=0.01
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Calibration parameters", group=
          "Fast calibration - Thermal power output"));
  parameter Modelica.Units.SI.ThermalConductance GEngToAmb=2
    "Thermal conductance from engine housing to the surrounding air"
    annotation (Dialog(tab="Calibration parameters", group=
          "Advanced calibration parameters"));
  parameter Modelica.Units.SI.ThermalConductance GAmb=10
    "Constant heat transfer coefficient of engine housing to ambient"
    annotation (Dialog(tab="Calibration parameters", group=
          "Advanced calibration parameters"));
  parameter Real modTab[:,2]=[0.0,0.8; 7200,0.8; 7200,0.93; 10800,0.93; 10800,0.62;
      14400,0.62; 14400,0.8; 18000,0.8; 18000,0.0]
    "Table for unit modulation (time = first column; modulation factors = second column)"
    annotation (Dialog(tab="Calibration parameters", group="Fast calibration - Electric power and fuel usage"));
  parameter Boolean ConTec=true
    "Is condensing technology used and should latent heat be considered?"
    annotation (Dialog(tab="Advanced", group="Latent heat use"));
  parameter Boolean useGenHea=true
    "Is the thermal loss energy of the elctric machine used?"
    annotation (Dialog(tab="Advanced", group="Generator heat use"));
  parameter Boolean allowFlowReversalExhaust=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for exhaust medium"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Boolean allowFlowReversalCoolant=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for coolant medium"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mExh_flow_small=0.001
    "Small exhaust mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mCool_flow_small=0.005
    "Small coolant mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));

  Modelica.Units.SI.Temperature T_Ret=temRetFlo.T "Coolant return temperature";
  Modelica.Units.SI.Temperature T_Sup=temSupFlo.T "Coolant supply temperature";
  Modelica.Units.SI.Power Q_Therm_th=cHP_PowerUnit.Q_Therm
    "Thermal power output of the CHP unit to the coolant media";
  Modelica.Units.SI.Power Q_Therm=coolantHex.Q2_flow
    "Effective thermal power output of the CHP unit to the heating circuit";
  Modelica.Units.SI.Power P_Mech=cHP_PowerUnit.P_Mech
    "Mechanical power output of the CHP unit";
  Modelica.Units.SI.Power P_El=cHP_PowerUnit.P_El
    "Electrical power output of the CHP unit";
  Modelica.Units.SI.Power P_Fuel=cHP_PowerUnit.P_Fuel "CHP fuel expenses";
  Modelica.Units.SI.Power Q_TotUnused=cHP_PowerUnit.Q_TotUnused
    "Total heat error of the CHP unit";
  Modelica.Units.SI.MassFlowRate m_flow_CO2=cHP_PowerUnit.m_flow_CO2
    "CO2 emission output rate";
  Modelica.Units.SI.MassFlowRate m_flow_Fue=cHP_PowerUnit.m_flow_Fue
    "Fuel consumption rate of CHP unit";
  Real FueUtiRate = cHP_PowerUnit.FueUtiRate "Fuel utilization rate of the CHP unit";
  Real PowHeatRatio = cHP_PowerUnit.PowHeatRatio "Power to heat ration of the CHP unit";
  Real eta_Therm = cHP_PowerUnit.eta_Therm "Thermal efficiency of the CHP unit";
  Real eta_Mech = cHP_PowerUnit.eta_Mech "Mechanical efficiency of the CHP unit";
  Real eta_El = cHP_PowerUnit.eta_El "Mechanical efficiency of the CHP unit";

  inner Modelica.Fluid.System system(p_ambient=p_amb, T_ambient=T_amb)
    annotation (Placement(transformation(extent={{-100,-100},{-84,-84}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.ModularCHP_PowerUnit
    cHP_PowerUnit(
    redeclare package Medium_Fuel = Medium_Fuel,
    CHPEngineModel=CHPEngineModel,
    EngMat=EngMat,
    T_amb=T_amb,
    p_amb=p_amb,
    m_flow=m_flow_Coo,
    GEngToCoo=GEngToCoo,
    ConTec=ConTec,
    useGenHea=useGenHea,
    allowFlowReversalExhaust=allowFlowReversalExhaust,
    allowFlowReversalCoolant=allowFlowReversalCoolant,
    mExh_flow_small=mExh_flow_small,
    mCool_flow_small=mCool_flow_small,
    A_surExhHea=A_surExhHea,
    mEng=mEng,
    redeclare package Medium_Coolant = Medium_Coolant,
    GCooExhHex=GCooExhHex,
    CExhHex=CExhHex,
    inductionMachine(J_Gen=1),
    dInn=dInn,
    GEngToAmb=GEngToAmb,
    GAmb=GAmb,
    calFac=calFac,
    s_til=s_til)
    "Model of the main heat and power generating components of a CHP unit"
    annotation (Placement(transformation(extent={{-20,0},{20,48}})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness coolantHex(
    allowFlowReversal1=allowFlowReversalCoolant,
    allowFlowReversal2=allowFlowReversalCoolant,
    m2_flow_nominal=CHPEngineModel.m_floCooNominal,
    m1_flow_small=mCool_flow_small,
    m2_flow_small=mCool_flow_small,
    redeclare package Medium1 = Medium_Coolant,
    m1_flow_nominal=m_flow_Coo,
    redeclare package Medium2 = Medium_HeatingCircuit,
    dp1_nominal(displayUnit="kPa") = 10000,
    dp2_nominal(displayUnit="kPa") = 10000,
    eps=0.9) "Heat exchanger between inner cooling and outer heating circuit"
             annotation (Placement(transformation(extent={{20,-72},{-20,-32}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temRetFlo(
    m_flow_small=mCool_flow_small,
    m_flow_nominal=CHPEngineModel.m_floCooNominal,
    redeclare package Medium = Medium_HeatingCircuit)
    "Heating circuit return flow temperature sensor"
    annotation (Placement(transformation(extent={{-58,-72},{-42,-56}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort temSupFlo(
    m_flow_small=mCool_flow_small,
    m_flow_nominal=CHPEngineModel.m_floCooNominal,
    redeclare package Medium = Medium_HeatingCircuit)
    "Heating circuit supply flow temperature sensor"
    annotation (Placement(transformation(extent={{42,-72},{58,-56}})));
  AixLib.Fluid.BoilerCHP.BaseClasses.Controllers.ControllerOnOffModularCHP
    ControllerCHP(
    CHPEngineModel=CHPEngineModel,
    startTimeChp=3600,
    modTab=modTab) "On/Off control with modulation factor setting"
                   annotation (Placement(transformation(rotation=0, extent={{-76,
            64},{-44,96}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_retHea(redeclare package Medium =
        Medium_Coolant)
    "Fluid port for the return flow side of the heating circuit"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_supHea(redeclare package Medium =
        Medium_Coolant)
    "Fluid port for the supply flow side of the heating circuit"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Fluid.Sources.FixedBoundary fixedPressureLevel(
    nPorts=1,
    redeclare package Medium = Medium_Coolant,
    T(displayUnit="K"),
    p=300000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-74,-20})));

protected
  replaceable package Medium_Air =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                               constrainedby
    DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
    "Air medium model used in the CHP plant" annotation(choicesAllMatching=true);

  replaceable package Medium_Exhaust =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
    "Exhaust gas medium model used in the CHP plant" annotation(choicesAllMatching=true);

  parameter Modelica.Units.SI.Mass mEng=CHPEngineModel.mEng + Cal_mEng
    "Total engine mass for heat capacity calculation" annotation (Dialog(tab=
          "Calibration parameters", group="Advanced calibration parameters"));

equation
  connect(coolantHex.port_a2, temRetFlo.port_b)
    annotation (Line(points={{-20,-64},{-42,-64}}, color={0,127,255}));
  connect(coolantHex.port_b2, temSupFlo.port_a)
    annotation (Line(points={{20,-64},{42,-64}}, color={0,127,255}));
  connect(ControllerCHP.modCHPConBus, cHP_PowerUnit.sigBusCHP) annotation (Line(
      points={{-44,80},{0.25,80},{0.25,46.32}},
      color={255,204,51},
      thickness=0.5));
  connect(coolantHex.port_b1,cHP_PowerUnit.port_retCoo)  annotation (Line(
        points={{-20,-40},{-60,-40},{-60,10.08},{-20,10.08}},   color={0,127,
          255}));
  connect(cHP_PowerUnit.port_supCoo, coolantHex.port_a1) annotation (Line(
        points={{20,10.08},{60,10.08},{60,-40},{20,-40}},   color={0,127,255}));
  connect(temSupFlo.port_b, port_supHea) annotation (Line(points={{58,-64},{90,
          -64},{90,0},{100,0}}, color={0,127,255}));
  connect(port_retHea, temRetFlo.port_a) annotation (Line(points={{-100,0},{-90,
          0},{-90,-64},{-58,-64}}, color={0,127,255}));
  connect(fixedPressureLevel.ports[1], cHP_PowerUnit.port_retCoo) annotation (
      Line(points={{-64,-20},{-60,-20},{-60,10.08},{-20,10.08}},   color={0,127,
          255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-50,58},{50,18}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString="CHP",
          textStyle={TextStyle.Bold}),
                              Rectangle(
          extent={{-60,80},{60,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={170,170,255}),                                       Text(
          extent={{-50,68},{50,28}},
          lineColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textStyle={TextStyle.Bold},
          textString="Modular
CHP"),  Rectangle(
          extent={{-12,6},{12,-36}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-10,-16},{-10,-36},{-8,-30},{8,-30},{10,-36},{10,-16},{-10,-16}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-2,-26},{4,-32}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,-54},{-8,-64}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,-30},{-14,-54},{-10,-56},{0,-32},{-2,-30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4.5,-15.5},{-8,-10},{0,4},{6,-4},{10,-4},{8,-8},{8,-12},{5.5,
              -15.5},{-4.5,-15.5}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={255,127,0}),
        Polygon(
          points={{-4.5,-13.5},{0,-4},{6,-10},{2,-14},{-4.5,-13.5}},
          lineColor={255,255,170},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-90,0},{-60,0}},
          color={0,127,255},
          thickness=1),
        Line(
          points={{60,0},{90,0}},
          color={0,127,255},
          thickness=1)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This model of a gas engine CHP plant is using the CHP power unit
  <a href=
  \"modelica://AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.ModularCHP_PowerUnit\">
  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.ModularCHP_PowerUnit</a>
  extended by a heat exchanger to the heating circuit. Also, a simple
  controller model is added to simulate different operation conditions
  by transferring an On-/Off-Signal and the modulation factor via the
  bus port.
</p>
<h4>
  Calibration and limitations:
</h4>
<p>
  Model calibration and limitations can be found in <a href=
  \"modelica://AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.ModularCHP_PowerUnit\">
  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.ModularCHP_PowerUnit</a>
</p>
<ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
end ModularCHPIntegrated;
