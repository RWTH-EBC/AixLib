within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model gasolineEngineChp3101
  import AixLib;
  OldModels.CHPCombustionEngine3101 cHPCombustionEngine(
    redeclare package Medium1 = Medium_Fuel,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium3 = Medium_Exhaust,
    T_Amb=T_ambient,
    CHPEngData=CHPEngineModel,
    inertia(phi(fixed=false), w(fixed=false, displayUnit="rad/s")),
    T_logEngCool=T_logEngCool,
    T_ExhCHPOut=T_ExhCHPOut)
    annotation (Placement(transformation(extent={{-30,0},{30,56}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.EngineHousing engineToCoolant(
    z=CHPEngineModel.z,
    eps=CHPEngineModel.eps,
    m_Exh=cHPCombustionEngine.m_Exh,
    T_Amb=T_ambient,
    redeclare package Medium3 = Medium_Exhaust,
    dCyl=CHPEngineModel.dCyl,
    hStr=CHPEngineModel.hStr,
    meanCpExh=cHPCombustionEngine.meanCpExh,
    cylToInnerWall(maximumEngineHeat(y=cHPCombustionEngine.Q_therm), heatLimit(
          strict=true)),
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
  replaceable package Medium_Fuel =
      DataBase.CHP.ModularCHPEngineMedia.LiquidFuel_LPG             constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                annotation(choicesAllMatching=true);
  replaceable package Medium_Air =
      DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir   constrainedby
    DataBase.CHP.ModularCHPEngineMedia.EngineCombustionAir
                         annotation(choicesAllMatching=true);
  replaceable package Medium_Exhaust =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus  constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);
  parameter
    DataBase.CHP.ModularCHPEngineData.CHPEngDataBaseRecord
    CHPEngineModel=DataBase.CHP.ModularCHPEngineData.CHP_ECPowerXRGI15()
    "CHP engine data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter EngineMaterialData                            EngMat=
      Fluid.BoilerCHP.ModularCHP.EngineMaterial_CastIron()
    "Thermal engine material data for calculations"
    annotation (choicesAllMatching=true, Dialog(group="Unit properties"));
  parameter Modelica.SIunits.Temperature T_ambient=298.15
    "Default ambient temperature"
    annotation (Dialog(group="Ambient Parameters"));
  parameter Modelica.SIunits.Mass mEng=CHPEngineModel.mEng
    "Total engine mass for heat capacity calculation"
    annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.Thickness dInn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Engine Cooling Circle"));
  parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
    "Thermal conductance from engine housing to the surrounding air"
    annotation (Dialog(tab="Engine Cooling Circle"));
  Modelica.SIunits.Temperature T_logEngCool=356.15 "Logarithmic mean temperature of coolant inside the engine"
  annotation(Dialog(group="Engine Parameters"));
  Modelica.SIunits.Temperature T_ExhCHPOut=383.15  "Exhaust gas outlet temperature of CHP unit"
  annotation(Dialog(group="Engine Parameters"));
  Modelica.SIunits.Temperature T_Exh=engineToCoolant.T_Exh
                                      "Inlet temperature of exhaust gas"
  annotation (Dialog(group="Thermal"));

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
      Placement(transformation(rotation=0, extent={{-114,-6},{-94,14}}),
        iconTransformation(extent={{-114,-6},{-94,14}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exhaust(redeclare package Medium
      = Medium_Exhaust) annotation (Placement(transformation(rotation=0, extent={{92,-8},
            {112,12}}),         iconTransformation(extent={{92,-8},{112,12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient annotation (
      Placement(transformation(rotation=0, extent={{-10,-100},{10,-80}}),
        iconTransformation(extent={{-10,-100},{10,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CoolingCircle
    annotation (Placement(transformation(rotation=0, extent={{90,-98},{110,-78}}),
        iconTransformation(extent={{90,-98},{110,-78}})));
  Controls.Interfaces.CHPControlBus cHPControlBus(
    meaRotEng=cHPCombustionEngine.nEng,
    meaFuePowEng=cHPCombustionEngine.P_Fue,
    meaThePowEng=cHPCombustionEngine.Q_therm,
    meaTorEng=cHPCombustionEngine.Mmot,
    meaMasFloFueEng=cHPCombustionEngine.m_Fue,
    meaMasFloAirEng=cHPCombustionEngine.m_Air,
    meaMasFloCO2Eng=cHPCombustionEngine.m_CO2Exh) annotation (Placement(
        transformation(
        extent={{-30,-32},{30,32}},
        rotation=0,
        origin={0,92}), iconTransformation(
        extent={{-26,-26},{26,26}},
        rotation=0,
        origin={0,88})));
  Modelica.Blocks.Interfaces.BooleanInput isOn annotation (Placement(
        transformation(rotation=270,
                                   extent={{-10,-10},{10,10}},
        origin={-80,104}),
        iconTransformation(extent={{-11,-11},{11,11}},
        rotation=0,
        origin={-99,47})));
equation
  connect(port_Exhaust, cHPCombustionEngine.port_Exhaust) annotation (Line(
        points={{102,2},{64,2},{64,28},{29.4,28}},   color={0,127,255}));
  connect(port_Ambient, engineToCoolant.port_Ambient)
    annotation (Line(points={{0,-90},{0,-52}}, color={191,0,0}));
  connect(port_CoolingCircle, engineToCoolant.port_CoolingCircle)
    annotation (Line(points={{100,-88},{100,-30},{22,-30}}, color={191,0,0}));
  connect(engineToCoolant.exhaustGasTemperature, cHPCombustionEngine.exhaustGasTemperature)
    annotation (Line(points={{0,-3.16},{0,8.4}}, color={0,0,127}));
  connect(cHPCombustionEngine.flange_a, flange_a) annotation (Line(points={{-30,
          28},{-68,28},{-68,4},{-104,4}}, color={0,0,0}));
  connect(isOn, cHPCombustionEngine.isOn) annotation (Line(points={{-80,104},{
          -80,46},{-30,46},{-30,46.48}}, color={255,0,255}));
  annotation (Icon(graphics={
          Bitmap(extent={{-136,-134},{144,160}}, fileName=
              "modelica://AixLib/../../Nützliches/Modelica Icons_Screenshots/Icon_ICE.png")}));
end gasolineEngineChp3101;
