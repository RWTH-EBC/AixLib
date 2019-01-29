within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model gasolineEngineChp2901
  import AixLib;
  OldModels.CHPCombustionEngine2901 cHPCombustionEngine(
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

  Modelica.Blocks.Interfaces.RealOutput airFlow annotation (Placement(
        transformation(
        rotation=90,
        extent={{-11,-11},{11,11}},
        origin={71,107}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={73,99})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
      Placement(transformation(rotation=0, extent={{-10,88},{10,108}}),
        iconTransformation(extent={{-10,88},{10,108}})));
  Modelica.Blocks.Interfaces.RealOutput fuelFlow annotation (Placement(
        transformation(
        rotation=90,
        extent={{-11,-11},{11,11}},
        origin={41,107}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=90,
        origin={41,99})));
  Modelica.Blocks.Interfaces.BooleanInput isOn annotation (Placement(
        transformation(rotation=0, extent={{-110,-18},{-90,2}}),
        iconTransformation(extent={{-110,-18},{-90,2}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_Exhaust(redeclare package Medium =
        Medium_Exhaust) annotation (Placement(transformation(rotation=0, extent=
           {{90,-16},{110,4}}), iconTransformation(extent={{90,-16},{110,4}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient annotation (
      Placement(transformation(rotation=0, extent={{-10,-100},{10,-80}}),
        iconTransformation(extent={{-10,-100},{10,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CoolingCircle
    annotation (Placement(transformation(rotation=0, extent={{90,-98},{110,-78}}),
        iconTransformation(extent={{90,-98},{110,-78}})));
equation
  connect(flange_a, cHPCombustionEngine.flange_a)
    annotation (Line(points={{0,98},{0,56}}, color={0,0,0}));
  connect(fuelFlow, cHPCombustionEngine.fuelFlow) annotation (Line(points={{41,107},
          {41,50.4},{31.2,50.4}}, color={0,0,127}));
  connect(isOn, cHPCombustionEngine.isOn) annotation (Line(points={{-100,-8},{-64,
          -8},{-64,28},{-29.4,28}}, color={255,0,255}));
  connect(port_Exhaust, cHPCombustionEngine.port_Exhaust) annotation (Line(
        points={{100,-6},{64,-6},{64,28},{29.4,28}}, color={0,127,255}));
  connect(port_Ambient, engineToCoolant.port_Ambient)
    annotation (Line(points={{0,-90},{0,-52}}, color={191,0,0}));
  connect(port_CoolingCircle, engineToCoolant.port_CoolingCircle)
    annotation (Line(points={{100,-88},{100,-30},{22,-30}}, color={191,0,0}));
  connect(cHPCombustionEngine.airFlow, airFlow) annotation (Line(points={{31.2,
          40.88},{71,40.88},{71,107}},
                                color={0,0,127}));
  connect(engineToCoolant.exhaustGasTemperature, cHPCombustionEngine.exhaustGasTemperature)
    annotation (Line(points={{0,-3.16},{0,8.4}}, color={0,0,127}));
  annotation (Icon(graphics={
          Bitmap(extent={{-140,-146},{140,148}}, fileName=
              "modelica://AixLib/../../Nützliches/Modelica Icons_Screenshots/Icon_ICE.png")}));
end gasolineEngineChp2901;
