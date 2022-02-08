within ControlUnity.twoPositionController;
model ModularBufferStorage
  parameter Modelica.SIunits.Temperature TAmb=283.15   "Outdoor temperature for heat losses of the buffer storage";

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

       parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
          parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
            parameter Modelica.SIunits.HeatFlowRate QNom=modularBoiler_Controller.QNom "Thermal dimension power";
            parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
             parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";
             parameter Modelica.SIunits.Time t=3600  "Time until the buffer storage is fully loaded" annotation(Dialog(enable= advancedVolume, group="Control"));
     parameter Modelica.SIunits.Density rhoW=Medium.d_const "Density of water";
     parameter Modelica.SIunits.HeatCapacity cW=Medium.cp_const "Heat Capacity of water";
     parameter Modelica.SIunits.TemperatureDifference dT=20;
     parameter Real l=1.73 "Relation between height and diameter of the buffer storage" annotation(Dialog(enable= advancedVolume, group="Control"));
      parameter Modelica.SIunits.Height hTank=(QNom*t*l^2/( Modelica.Constants.pi/4*rhoW*cW*dT))^(1/3) annotation (Dialog(enable= not advancedVolume, group="Control"));
     parameter Modelica.SIunits.Diameter dTank=hTank/l annotation (Dialog(enable= not advancedVolume, group="Control"));
     parameter Modelica.SIunits.Height hUpperPortDemand=hTank - 0.1;
     parameter Modelica.SIunits.Height hUpperPortSupply=hTank - 0.1;


     parameter Boolean advancedVolume "Choice between conventional and advanced volume dimensioning" annotation(Dialog(group="Control"), choices(
      choice=true "Advanced volume dimensioning",
      choice=false "Convenctional volume dimensioning",
      radioButtons=true));




  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T(
        displayUnit="K") = TAmb)                                                      annotation(Placement(transformation(extent={{-96,-6},
            {-84,6}})));
  Modelica.Fluid.Interfaces.FluidPort_a fluidportTop1(h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a fluidportBottom2(h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b fluidportBottom1(h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b fluidportTop2(h_outflow(start=Medium.h_default, nominal=Medium.h_default))
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));

  AixLib.Fluid.Storage.BufferStorage bufferStorage(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    m1_flow_nominal=m1_flow_nominal,
    m2_flow_nominal=m2_flow_nominal,
    mHC1_flow_nominal=boundary3.m_flow,
    n=n,
    redeclare package Medium = AixLib.Media.Water,
    data=data,
    useHeatingCoil1=false,
    useHeatingCoil2=false,
    upToDownHC1=false,
    upToDownHC2=false,
    useHeatingRod=false,
    redeclare model HeatTransfer =
        AixLib.Fluid.Storage.BaseClasses.HeatTransferBuoyancyWetter,
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    TStart=303.15)           annotation (Placement(transformation(extent={{22,-28},{-22,28}})));
  parameter AixLib.DataBase.Storage.BufferStorageBaseDataDefinition data=
      AixLib.DataBase.Storage.Generic_New_2000l(
      hTank=hTank,
      hUpperPortDemand=hUpperPortDemand,
      hUpperPortSupply=hUpperPortSupply,
      dTank=dTank)                                "Data record for Storage" annotation(Dialog(group="Control"));
  parameter Integer n=10 " Model assumptions Number of Layers";

  Modelica.Blocks.Interfaces.RealOutput TLayer[n]
    "Temperatures of the different layers of the buffer storage"
    annotation (Placement(transformation(extent={{-100,40},{-120,60}})));
  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal=m_flow_nominal
    "Nominal mass flow rate of fluid 1 ports";
  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal=m_flow_nominal/2
    "Nominal mass flow rate of fluid 2 ports";
equation
  connect(bufferStorage.fluidportTop2, fluidportTop2) annotation (Line(points={{-6.875,
          28.28},{-6.875,80},{-60,80},{-60,100}}, color={0,127,255}));
  connect(bufferStorage.fluidportTop1, fluidportTop1) annotation (Line(points={{7.7,28.28},
          {7.7,80},{60,80},{60,100}}, color={0,127,255}));
  connect(bufferStorage.fluidportBottom1, fluidportBottom1) annotation (Line(points={
          {7.425,-28.56},{7.425,-80},{60,-80},{60,-100}}, color={0,127,255}));
  connect(bufferStorage.fluidportBottom2, fluidportBottom2) annotation (Line(points={
          {-6.325,-28.28},{-6.325,-80},{-60,-80},{-60,-100}}, color={0,127,255}));
  connect(fixedTemperature.port, bufferStorage.heatportOutside) annotation (Line(
        points={{-84,0},{-52,0},{-52,1.68},{-21.45,1.68}}, color={191,0,0}));
  connect(bufferStorage.TLayer, TLayer) annotation (Line(points={{-22,15.68},{-90,
          15.68},{-90,50},{-110,50}},
                          color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularBufferStorage;
