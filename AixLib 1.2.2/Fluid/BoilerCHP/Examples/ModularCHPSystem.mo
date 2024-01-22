within AixLib.Fluid.BoilerCHP.Examples;
model ModularCHPSystem
  "Example of the modular CHP power unit model inside a heating circuit"
  extends Modelica.Icons.Example;

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
  parameter Real s_til=abs((cHP_PowerUnit.cHP_PowerUnit.inductionMachine.s_nominal
      *(cHP_PowerUnit.cHP_PowerUnit.inductionMachine.M_til/cHP_PowerUnit.cHP_PowerUnit.inductionMachine.M_nominal)
       + cHP_PowerUnit.cHP_PowerUnit.inductionMachine.s_nominal*sqrt(abs(((
      cHP_PowerUnit.cHP_PowerUnit.inductionMachine.M_til/cHP_PowerUnit.cHP_PowerUnit.inductionMachine.M_nominal)
      ^2) - 1 + 2*cHP_PowerUnit.cHP_PowerUnit.inductionMachine.s_nominal*((
      cHP_PowerUnit.cHP_PowerUnit.inductionMachine.M_til/cHP_PowerUnit.cHP_PowerUnit.inductionMachine.M_nominal)
       - 1))))/(1 - 2*cHP_PowerUnit.cHP_PowerUnit.inductionMachine.s_nominal*((
      cHP_PowerUnit.cHP_PowerUnit.inductionMachine.M_til/cHP_PowerUnit.cHP_PowerUnit.inductionMachine.M_nominal)
       - 1)))
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
  parameter Modelica.Units.SI.Temperature T_HeaRet=303.15
    "Constant heating circuit return temperature"
    annotation (Dialog(tab="Engine Cooling Circle"));
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
  parameter Boolean VolCon=true  "Is volume flow rate control used?"
    annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mExh_flow_small=0.001
    "Small exhaust mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate
    mCool_flow_small=0.005
    "Small coolant mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced", group="Assumptions"));
  parameter Modelica.Units.SI.Efficiency eps=0.9 "Heat exchanger effectiveness"
    annotation (Dialog(tab="Calibration parameters", group=
          "Advanced calibration parameters"));

  Modelica.Units.SI.MassFlowRate m_flow_HeaCir=if not VolCon then
      CHPEngineModel.m_floCooNominal else V_flow_HeaCir*senDen.d
    "Nominal mass flow rate inside the heating circuit"
    annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.Units.SI.VolumeFlowRate V_flow_HeaCir=0.3/3600
    "Nominal volume flow rate inside the heating circuit"
    annotation (Dialog(tab="Engine Cooling Circle"));

  Modelica.Fluid.Sources.MassFlowSource_T source(
    use_T_in=true,
    redeclare package Medium = Medium_HeatingCircuit,
    nPorts=1,
    use_m_flow_in=true) "Flow source of heating circuit"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Sources.FixedBoundary sink(redeclare package Medium =
        Medium_HeatingCircuit, nPorts=1) "Sink of the heating circuit"
    annotation (Placement(transformation(extent={{88,-10},{68,10}})));

  Modelica.Blocks.Sources.RealExpression tempFlowHeating(y=T_HeaRet)
    annotation (Placement(transformation(extent={{-98,-12},{-74,8}})));
  AixLib.Fluid.Sensors.DensityTwoPort senDen(
    m_flow_small=mCool_flow_small,
    m_flow_nominal=CHPEngineModel.m_floCooNominal,
    redeclare package Medium = Medium_HeatingCircuit)
    "Density sensor for volume and mass flow calculation"
    annotation (Placement(transformation(extent={{-28,-8},{-12,8}})));
  Modelica.Blocks.Sources.RealExpression massFlowHeating(y=m_flow_HeaCir)
    annotation (Placement(transformation(extent={{-98,4},{-74,24}})));

  AixLib.Fluid.BoilerCHP.ModularCHP.ModularCHPIntegrated cHP_PowerUnit(
    redeclare package Medium_Fuel = Medium_Fuel,
    CHPEngineModel=CHPEngineModel,
    EngMat=EngMat,
    T_amb=T_amb,
    p_amb=p_amb,
    ConTec=ConTec,
    useGenHea=useGenHea,
    allowFlowReversalExhaust=allowFlowReversalExhaust,
    allowFlowReversalCoolant=allowFlowReversalCoolant,
    mExh_flow_small=mExh_flow_small,
    mCool_flow_small=mCool_flow_small,
    A_surExhHea=A_surExhHea,
    redeclare package Medium_Coolant = Medium_Coolant,
    GCooExhHex=GCooExhHex,
    CExhHex=CExhHex,
    dInn=dInn,
    GAmb=GAmb,
    calFac=calFac,
    GEngToCoo=GEngToCoo,
    GEngToAmb=GEngToAmb,
    m_flow_Coo=m_flow_Coo,
    redeclare package Medium_HeatingCircuit = Medium_HeatingCircuit,
    s_til=s_til,
    Cal_mEng=Cal_mEng,
    modTab=modTab,
    cHP_PowerUnit(inductionMachine(s_til=cHP_PowerUnit.cHP_PowerUnit.s_til)),
    coolantHex(eps=eps)) "Model of a CHP unit"
    annotation (Placement(transformation(extent={{0,-26},{52,26}})));

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
  connect(source.T_in, tempFlowHeating.y) annotation (Line(points={{-62,4},{-68,
          4},{-68,-2},{-72.8,-2}}, color={0,0,127}));
  connect(source.ports[1], senDen.port_a)
    annotation (Line(points={{-40,0},{-28,0}}, color={0,127,255}));
  connect(massFlowHeating.y, source.m_flow_in) annotation (Line(points={{-72.8,
          14},{-68,14},{-68,8},{-60,8}}, color={0,0,127}));
  connect(cHP_PowerUnit.port_supHea, sink.ports[1])
    annotation (Line(points={{52,0},{68,0}}, color={0,127,255}));
  connect(senDen.port_b,cHP_PowerUnit.port_retHea)
    annotation (Line(points={{-12,0},{0,0}},   color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)), experiment(StopTime=18000, Interval=5),
    Documentation(info="<html><p>
  An example of the use of modular CHP components combined as a power
  unit with interfaces to a controller and to the heating circuit.
</p>
<p>
  It allows an impression of the versatile and complex application
  possibilities of the model by the changeability of many variables of
  individual components and the detailed investigation capability.
</p>
<p>
  For a better understanding the controller modulates the fuel
  consumption of the CHP unit. The effects to the thermal output can be
  visualized by looking at <b>T_Ret</b> and <b>T_Sup</b>.
</p>
<p>
  The return temperature as well as the volume flow in the heating
  circuit are considered constant in this example.
</p>
<p>
  <br/>
  <br/>
  Caution:
</p>
<p>
  If the prime coolant cirlce of the power unit is using a gasoline
  medium instead of a liquid fluid, you may need to adjust (raise) the
  nominal mass flow and pressure drop of the cooling to heating heat
  exchanger to run the model, because of a background calculation for
  the nominal flow.
</p>
<ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
end ModularCHPSystem;
