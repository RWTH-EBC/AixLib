within AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses;
model GasolineEngineChp
  "Thermal and mechanical model of an internal combustion engine with consideration of the individual mass flows"

  replaceable package Medium_Fuel =
      DataBase.CHP.ModularCHPEngineMedia.LiquidFuel_LPG             constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
    "Fuel medium model used in the CHP plant" annotation(choicesAllMatching=true);
  replaceable package Medium_Air =
      AixLib.DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                                                               constrainedby
    DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
    "Air medium model used in the CHP plant" annotation(choicesAllMatching=true);
  replaceable package Medium_Exhaust =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
    "Exhaust gas medium model used in the CHP plant" annotation(choicesAllMatching=true);
  parameter
    DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=AixLib.DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter Data.ModularCHP.EngineMaterialData EngMat=
      AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
    "Thermal engine material data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter Modelica.Units.SI.Temperature T_amb=298.15
    "Default ambient temperature"
    annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.Units.SI.Mass mEng=CHPEngineModel.mEng
    "Total engine mass for heat capacity calculation"
    annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.Units.SI.Thickness dInn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.Units.SI.ThermalConductance GEngToAmb=0.23
    "Thermal conductance from engine housing to the surrounding air"
    annotation (Dialog(tab="Engine Cooling Circle"));

  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineModel
    cHPCombustionEngine(
    redeclare package Medium1 = Medium_Fuel,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_amb,
    CHPEngData=CHPEngineModel,
    inertia(phi(fixed=false), w(fixed=false, displayUnit="rad/s")),
    T_logEngCool=T_logEngCoo,
    T_ExhCHPOut=T_ExhCHPOut,
    modFac=modFac,
    SwitchOnOff=cHPEngBus.isOn)
    "Mean value combustion engine model with mechanical and fluid ports"
    annotation (Placement(transformation(extent={{-30,0},{30,56}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing
    engineToCoolant(
    z=CHPEngineModel.z,
    eps=CHPEngineModel.eps,
    m_Exh=cHPCombustionEngine.m_flow_Exh,
    T_Amb=T_amb,
    redeclare package Medium3 = Medium_Exhaust,
    dCyl=CHPEngineModel.dCyl,
    hStr=CHPEngineModel.hStr,
    meanCpExh=cHPCombustionEngine.meanCpExh,
    cylToInnerWall(maximumEngineHeat(y=cHPCombustionEngine.Q_therm),
        heatLimit(strict=true)),
    T_Com=cHPCombustionEngine.T_Com,
    nEng=cHPCombustionEngine.nEng,
    lambda=EngMat.lambda,
    rhoEngWall=EngMat.rhoEngWall,
    c=EngMat.c,
    EngMatData=EngMat,
    mEng=mEng,
    dInn=dInn,
    T_ExhPowUniOut=T_ExhCHPOut,
    GEngToAmb=GEngToAmb)
    "A physikal model for calculating the thermal, mass and mechanical output of an ice powered CHP"
    annotation (Placement(transformation(extent={{-22,-52},{22,-8}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_eng
    "Mechanical port of the engines output drive"              annotation (
      Placement(transformation(rotation=0, extent={{-114,-6},{-94,14}}),
        iconTransformation(extent={{-114,-6},{-94,14}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_exh(redeclare package Medium =
        Medium_Exhaust)
    "Fluid port of the exhaust gas comming from the combustion engine"
                        annotation (Placement(transformation(rotation=0,
          extent={{92,-8},{112,12}}), iconTransformation(extent={{92,-8},{112,
            12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_amb
    "Heat port to ambient"                                     annotation (
      Placement(transformation(rotation=0, extent={{-10,-100},{10,-80}}),
        iconTransformation(extent={{-10,-100},{10,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_cooCir
    "Heat port to cooling circuit"                                annotation (
     Placement(transformation(rotation=0, extent={{90,-98},{110,-78}}),
        iconTransformation(extent={{90,-98},{110,-78}})));
  AixLib.Controls.Interfaces.CHPControlBus cHPEngBus
    "Signal bus of the combustion engine model"
                                               annotation (Placement(
        transformation(
        extent={{-30,-32},{30,32}},
        rotation=0,
        origin={0,92}), iconTransformation(
        extent={{-26,-26},{26,26}},
        rotation=0,
        origin={0,88})));

protected
  Real modFac=cHPEngBus.modFac
    "Modulation factor for energy outuput control of the Chp unit  "
    annotation (Dialog(group="Engine Parameters"));
  Modelica.Units.SI.Temperature T_logEngCoo=(cHPEngBus.meaTemInEng + cHPEngBus.meaTemOutEng)
      /2 "Logarithmic mean temperature of coolant inside the engine"
    annotation (Dialog(group="Engine Parameters"));
  Modelica.Units.SI.Temperature T_ExhCHPOut=cHPEngBus.meaTemExhHexOut
    "Exhaust gas outlet temperature of CHP unit"
    annotation (Dialog(group="Engine Parameters"));
  Modelica.Units.SI.Temperature T_Exh=engineToCoolant.T_Exh
    "Calculated mean temperature of the exhaust gas inside the cylinders"
    annotation (Dialog(group="Thermal"));

equation
  connect(port_exh, cHPCombustionEngine.port_exh) annotation (Line(points={{
          102,2},{64,2},{64,28},{29.4,28}}, color={0,127,255}));
  connect(port_amb, engineToCoolant.port_amb)
    annotation (Line(points={{0,-90},{0,-52}}, color={191,0,0}));
  connect(port_cooCir, engineToCoolant.port_coo) annotation (Line(points={{
          100,-88},{100,-30},{22,-30}}, color={191,0,0}));
  connect(engineToCoolant.exhaustGasTemperature, cHPCombustionEngine.exhaustGasTemperature)
    annotation (Line(points={{0,-3.16},{0,8.4}}, color={0,0,127}));
  connect(cHPCombustionEngine.flange_a, flange_eng) annotation (Line(points={
          {-30,28},{-64,28},{-64,4},{-104,4}}, color={0,0,0}));
  connect(cHPEngBus, cHPCombustionEngine.cHPEngineBus) annotation (Line(
      points={{0,92},{0,54.88}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(graphics={
          Bitmap(extent={{-136,-134},{144,160}}, fileName=
              "modelica://AixLib/Resources/Images/Fluid/BoilerCHP/Icon_ICE.png")}),
      Documentation(info="<html><p>
  Model of a combustion engine combined from the thermal and mechanical
  engine model. #
</p>
<p>
  Together with the submodels cooling circuit, exhaust gas heat
  exchanger and electric motor, it can be connected to form the power
  unit of a combined heat and power unit.
</p>
<ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
end GasolineEngineChp;
