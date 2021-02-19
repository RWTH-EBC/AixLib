within AixLib.Fluid;
package Pools "Models to describe Swimming Pools"
  model IndoorSwimmingPool

    package Medium = AixLib.Fluid.Pools.BaseClasses.Water30degC;

    parameter AixLib.DataBase.Pools.IndoorSwimmingPoolBaseRecord poolParam
      "setup for Swimming Pools " annotation (choicesAllMatching=true);
    // *************************************
    // MUSS IN DEN RECORD WEIL VORGEGEBENE GROESSEN
    //**************************************

    parameter String name "Name of Pool";
    parameter String poolType "Type of Pool";

    parameter Modelica.SIunits.Length d_pool "Depth of Swimming Pool";
    parameter Modelica.SIunits.Area A_pool "Surface Area of Swimming Pool";
    parameter Modelica.SIunits.Length u_pool "Circumference of Swimming Pool";

    parameter Modelica.SIunits.Temperature T_pool "Temperature of pool";

    parameter Boolean NextToSoil "Does the pool border to soil?";
    parameter Boolean PoolCover "Is the pool covered during non-opening hours?";

    parameter Real k "Belastungsfaktor";
    parameter Real N "Nennbelastung";
    parameter Real beta_inUse "Wasserübergangskoeffizient in use";
    parameter Real beta_nonUse "Wasserübergangskoeffizient non-use";

    parameter Modelica.SIunits.Velocity v_Filter "Velocity of Filtering";
    parameter Modelica.SIunits.VolumeFlowRate Q_hygenic( min= 1)
      "Hygenic motivated Volume Flow Rate";
    parameter Modelica.SIunits.VolumeFlowRate Q_hydraulic
      "Hydraulic motivated Volume Flow Rate";
    parameter Modelica.SIunits.Volume V_storage "Volume of Waterstorage";
    parameter Real x_recycling
      "Share of recycled water of the overall water supply";
    parameter Real x_partialLoad "Percentage of original Volume flow for partial load during non-opening hours";
    parameter Boolean PartialLoad "Operating on partial load during non opening hours";

    //Pool Wall
    parameter Integer nExt(min=1) "Number of RC-elements of exterior walls"
      annotation (Dialog(group="Exterior walls"));
    parameter Modelica.SIunits.ThermalResistance RExt[nExt](each min=Modelica.Constants.small)
      "Vector of resistors, from port_a to port_b"
      annotation (Dialog(group="Thermal mass"));
    parameter Modelica.SIunits.ThermalResistance RExtRem(min=Modelica.Constants.small)
      "Resistance of remaining resistor RExtRem between capacitor n and port_b"
      annotation (Dialog(group="Thermal mass"));
    parameter Modelica.SIunits.HeatCapacity CExt[nExt](each min=Modelica.Constants.small)
      "Vector of heat capacities, from port_a to port_b"
      annotation (Dialog(group="Thermal mass"));
    parameter Real openingHours=16/24
      "Open for x hours during the day, no closed time in between";
    parameter Real openAt=7*3600 "Opens at this time during the day";

    parameter Modelica.SIunits.Volume V_pool=A_pool*d_pool;

    //Cover specs
    parameter Modelica.SIunits.ThermalConductivity lambda_poolCover
      "Thermal Conductivity of the pool cover";
    parameter Modelica.SIunits.Length t_poolCover "Thickness of the pool cover";

    //Mass flow pre calculated
    parameter Modelica.SIunits.MassFlowRate m_flow_people
      "Water exchange due to visitors";
    parameter Modelica.SIunits.MassFlowRate m_flow_filter
      "Water exchange due to filter cleansing";

    //***********************************************
    //ENDE RECORD GROESSEN
    //************************************


    //Mass flow variable
    //Defined perspective Swimming Pool
  //   flow Modelica.SIunits.MassFlowRate m_flow_toPool
  //     "Mass flow from Watertreatment to Swimming pool";
  //   flow Modelica.SIunits.MassFlowRate m_flow_evap "Evaporation Mass Flow";
  //   flow Modelica.SIunits.MassFlowRate m_flow_toWT
  //     "Mass flow from  Swimming pool to Watertreatment";
  //   //defined perspective Watertreatment
  //   flow Modelica.SIunits.MassFlowRate m_flow_fresh
  //     "Mass flow from  fresh Water to Watertreatment";
  //   flow Modelica.SIunits.MassFlowRate m_flow_recycled
  //     "Mass flow from  recycled Water to Watertreatment";
    flow Modelica.SIunits.MassFlowRate m_flow_sewage
      "Mass flow from  Watertreatment to Sewage";


    //Modelica.SIunits.HeatFlowRate Q_flow_evap "Heatloss due to evaporation";


    Modelica.SIunits.Pressure psat_T_pool=
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
        T_pool);
    Modelica.SIunits.Pressure psat_T_Air=
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
        TAir);
    Real phi=absToRelHum.relHum;

    //Calculation Convection, Evaporation and Radiation
    Modelica.Blocks.Math.Gain Q_evap(k=-1) "Q_flow due to evaporation"
      annotation (Placement(transformation(extent={{-62,-4},{-54,4}})));
    Modelica.Blocks.Sources.Constant Head(k=pumpHead)
      "Constant head for the pump"
      annotation (Placement(transformation(extent={{-36,-40},{-28,-32}})));
    Modelica.Blocks.Interfaces.RealOutput P_pump
      "electric power consumed by circulation pump"
      annotation (Placement(transformation(extent={{96,-56},{116,-36}})));
    Movers.FlowControlled_dp pump(redeclare final package Medium = Medium, m_flow_nominal=m_flow_toPoolStart, addPowerToMedium=false)
      "circulation pump" annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-1,-39})));
    FixedResistances.PressureDrop res(redeclare final package Medium = Medium,m_flow_nominal=m_flow_toPoolStart, dp_nominal=
          pumpHead) annotation (Placement(transformation(
          extent={{-5,-8},{5,8}},
          rotation=90,
          origin={-4,-21})));

    final parameter Modelica.SIunits.SpecificEnergy h_evap=
        AixLib.Media.Air.enthalpyOfCondensingGas(T_pool);
    final constant Real epsilon=0.9*0.95
      "Product of emissivity of water and the emissivity of surrounding walls";
    final constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air=3.5
      "Coefficient of heat transfer between the water surface and the room air";
    final constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_W=820
      "Coefficient of heat transfer between the water and the pool walls";
    final constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Cover=40
      "Coefficient of heat transfer between the water and the pool cover";
    final constant Real R_D(final unit="J/(kg.K)") = 461.52
      "Specific gas constant for steam";
    final parameter Modelica.SIunits.Pressure pumpHead = 170000 "Mean Pump head which is needed to overcome pipe and filterresistance etc. ";
    final parameter Modelica.SIunits.MassFlowRate m_flow_toPoolStart = Q_hygenic*Medium.d_const;




    BaseClasses.MixingVolumeEvapLosses SwimmingPoolWater(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      V=V_pool,
      nPorts=3,
      redeclare final package Medium = Medium,
      m_flow_nominal=0,
      final T_start=poolParam.T_pool) "Water Volume in the swimming pool"
      annotation (Placement(transformation(extent={{-36,-6},{-16,14}})));

    MixingVolumes.MixingVolume Watertreatment( redeclare final package Medium = Medium,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      allowFlowReversal=false,
      V=V_storage,
      nPorts=5,
      m_flow_nominal=0,
      prescribedHeatFlowRate = true,
      final T_start=poolParam.T_pool)
      annotation (Placement(transformation(extent={{-32,-72},{-12,-52}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_sewer(redeclare final package
        Medium = Medium)
      annotation (Placement(transformation(extent={{90,-84},{110,-64}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_freshWater(redeclare package
        Medium = Medium) "Fresh cold water at 10°C "
      annotation (Placement(transformation(extent={{-110,-86},{-90,-66}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_recycledWater(redeclare package
        Medium = Medium) "Port for recycled warm Water at 25°C"
      annotation (Placement(transformation(extent={{-110,-104},{-90,-84}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-72,-72},{-52,-52}})));
    Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(Gr=
          epsilon) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-55,55})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=-90,
          origin={-55,77})));
    Modelica.Blocks.Interfaces.RealInput TRad(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Mean Radiation Temperature of surrounding walls"
      annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={-55,105}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={-72,106})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TRoom
      "Air Temperature in Zone"
      annotation (Placement(transformation(extent={{-22,88},{2,112}})));
    Modelica.Blocks.Interfaces.RealInput TSoil(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Temperature of Soil" annotation (Placement(
          transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={103,53})));
    Modelica.Fluid.Interfaces.FluidPort_b port_mEvap(redeclare final package
        Medium = Medium) "Evaporation Mass Flow from Swimming Pool"
      annotation (Placement(transformation(extent={{90,-16},{110,4}})));
    Modelica.Blocks.Interfaces.RealOutput Q_Lat_mEvap
      "Latent heat of evaporation rate from swimming pool to surrounding air"
      annotation (Placement(transformation(extent={{96,-34},{116,-14}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRateEvaporation(redeclare
      final package
                Medium = Medium)
      annotation (Placement(transformation(extent={{32,0},{44,-12}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=4) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-86,-44})));
    Modelica.Blocks.Math.Gain EvaporationLoss(k=h_evap)
      "Calculcation of heat loss due to evaporation"
      annotation (Placement(transformation(extent={{28,-18},{20,-10}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=90,
          origin={-54,22})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor2
      annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=0,
          origin={-2,24})));
    Modelica.Blocks.Sources.BooleanPulse inUse(
      width=openingHours,
      final period=86400,
      startTime=openAt)
      "is the swimming pool currently in use - pulse between opening hours of swimming hall"
      annotation (Placement(transformation(extent={{20,76},{34,90}})));

    BaseClasses.HeatTransferWaterSurface heatTransferWaterSurface(
      final alpha_Air=alpha_Air,
      final alpha_Cover=alpha_Cover,
      final lambda_poolCover=poolParam.lambda_poolCover,
      final t_poolCover=poolParam.t_poolCover,
      final A=poolParam.A_pool)
      annotation (Placement(transformation(extent={{-20,44},{-4,60}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor
      HeatFlowSensor_poolSurface
      "Heatflow sensor to measure the heatflow at the water surface" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=90,
          origin={-12,76})));
    BaseClasses.HeatTransferConduction heatTransferConduction(
      final alpha_W=alpha_W,
      final T_nextDoor=poolParam.T_pool,
      final NextToSoil=poolParam.NextToSoil,
      final RExt=poolParam.RExt,
      final RExtRem=poolParam.RExtRem,
      final nExt=poolParam.nExt,
      final CExt=poolParam.CExt)
      annotation (Placement(transformation(extent={{20,14},{40,34}})));
    Modelica.Blocks.Interfaces.RealInput TAir(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Temperature of the surrounding room air" annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={43,105})));
    Modelica.Blocks.Interfaces.RealInput X_w "Absolute humidty of the room Air"
      annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={73,105})));
    ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum
      annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=-90,
          origin={59,81})));
    inner Modelica.Fluid.System system(T_ambient=T_pool + 2)
      annotation (Placement(transformation(extent={{-98,80},{-78,100}})));
  Movers.BaseClasses.IdealSource prescribed_m_flow_toPool(control_m_flow=true,
      control_dp=false) annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={1,-59})));
  Movers.BaseClasses.IdealSource prescribed_m_flow_evap(control_m_flow=true,
      control_dp=false)
    annotation (Placement(transformation(extent={{-6,-14},{10,2}})));
  Movers.BaseClasses.IdealSource prescribed_m_flow_freshWater(control_m_flow=
        true, control_dp=false)
    annotation (Placement(transformation(extent={{-74,-84},{-58,-68}})));
  Movers.BaseClasses.IdealSource prescribed_m_flow_recycledWater(control_m_flow
      =true, control_dp=false)
    annotation (Placement(transformation(extent={{-74,-102},{-60,-88}})));
  equation
    // Mass/volume flow
    //m_flow_toPool = SwimmingPoolWater.ports[3].m_flow;
   // m_flow_evap = SwimmingPoolWater.ports[2].m_flow;
   // m_flow_toWT = SwimmingPoolWater.ports[1].m_flow;

   // m_flow_fresh = Watertreatment.ports[1].m_flow;
   // m_flow_recycled = Watertreatment.ports[4].m_flow;
   // m_flow_evap = Watertreatment.ports[3].m_flow;

  //   if inUse.y or not PartialLoad then
  //     SwimmingPoolWater.ports[3].m_flow = Q_hygenic*Medium.d_const;
  //     SwimmingPoolWater.ports[2].m_flow = -(beta_inUse)/(R_D*0.5*(T_pool + TAir))*(psat_T_pool - phi*
  //      psat_T_Air)*A_pool;
  //    else if not inUse.y and PartialLoad then
  //    SwimmingPoolWater.ports[3].m_flow = Q_hygenic*x_partialLoad*Medium.d_const;
  //    SwimmingPoolWater.ports[2].m_flow = -(beta_nonUse)/(R_D*0.5*(T_pool + TAir))*(psat_T_pool - phi*
  //       psat_T_Air)*A_pool;
  //    end if;
  //   end if;
  //
  //
  //
  //   if m_flow_filter > m_flow_people then
  //     m_flow_sewage = -m_flow_filter;
  //   else
  //     m_flow_sewage = -m_flow_people;
  //   end if;
  //
  //   if x_recycling >0 then
  //     0 = Watertreatment.ports[1].m_flow + (m_flow_sewage+SwimmingPoolWater.ports[2].m_flow)*(1-x_recycling);
  //     0 = Watertreatment.ports[4].m_flow + x_recycling*(m_flow_sewage+SwimmingPoolWater.ports[2].m_flow);
  //   else
  //     Watertreatment.ports[1].m_flow = m_flow_sewage + SwimmingPoolWater.ports[2].m_flow;
  //   end if;
  //
  //   SwimmingPoolWater.ports[1].m_flow = SwimmingPoolWater.ports[2].m_flow +SwimmingPoolWater.ports[3].m_flow;
  //
  //   0 = port_mEvap.m_flow + port_freshWater.m_flow + port_recycledWater.m_flow + port_sewer.m_flow;





    connect(SwimmingPoolWater.ports[1], Watertreatment.ports[1]) annotation (Line(
          points={{-28.6667,-6},{-48,-6},{-48,-72},{-25.2,-72}}, color={0,127,255}));
    connect(Watertreatment.ports[2], port_sewer) annotation (Line(points={{-23.6,
          -72},{-23.6,-74},{100,-74}},
                                  color={0,127,255}));
    connect(prescribedHeatFlow.port, Watertreatment.heatPort)
      annotation (Line(points={{-52,-62},{-32,-62}}, color={191,0,0}));
    connect(TRad, prescribedTemperature.T) annotation (Line(points={{-55,105},{-55,
            94.5},{-55,94.5},{-55,83}}, color={0,0,127}));
    connect(prescribedTemperature.port, bodyRadiation.port_b)
      annotation (Line(points={{-55,72},{-55,62}}, color={191,0,0}));
    connect(massFlowRateEvaporation.port_b, port_mEvap)
      annotation (Line(points={{44,-6},{100,-6}}, color={0,127,255}));
    connect(multiSum.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-86,-51.02},
            {-86,-62},{-72,-62}}, color={0,0,127}));
    connect(EvaporationLoss.u, massFlowRateEvaporation.m_flow) annotation (Line(
          points={{28.8,-14},{36,-14},{36,-12.6},{38,-12.6}},
                                                          color={0,0,127}));
    connect(EvaporationLoss.y, multiSum.u[1]) annotation (Line(points={{19.6,-14},
            {-82,-14},{-82,-38},{-82.85,-38}}, color={0,0,127}));
    connect(bodyRadiation.port_a, heatFlowSensor.port_b) annotation (Line(points={
            {-55,48},{-55,36},{-54,36},{-54,30}}, color={191,0,0}));
    connect(heatFlowSensor.Q_flow, multiSum.u[2]) annotation (Line(points={{-62,22},
            {-78,22},{-78,10},{-84.95,10},{-84.95,-38}}, color={0,0,127}));
    connect(heatFlowSensor2.Q_flow, multiSum.u[3]) annotation (Line(points={{-2,32},
            {-4,32},{-4,34},{-87.05,34},{-87.05,-38}}, color={0,0,127}));


    connect(TRoom, HeatFlowSensor_poolSurface.port_b)
      annotation (Line(points={{-10,100},{-10,90},{-12,90},{-12,82}},
                                                   color={191,0,0}));
    connect(heatTransferWaterSurface.heatPort_b, HeatFlowSensor_poolSurface.port_a)
      annotation (Line(points={{-12.16,60.5333},{-8,60.5333},{-8,70},{-12,70}},
          color={191,0,0}));
    connect(HeatFlowSensor_poolSurface.Q_flow, multiSum.u[4]) annotation (Line(
          points={{-18,76},{-90,76},{-90,66},{-89.15,66},{-89.15,-38}}, color={0,0,
            127}));
    connect(heatTransferConduction.TSoil, TSoil) annotation (Line(points={{40.6,27.6},
            {73.3,27.6},{73.3,53},{103,53}}, color={0,0,127}));
    connect(heatFlowSensor2.port_b, heatTransferConduction.heatport_a)
      annotation (Line(points={{6,24},{16,24},{16,24.2},{20,24.2}}, color={191,0,0}));
    connect(X_w, absToRelHum.absHum) annotation (Line(points={{73,105},{60,105},
          {60,87},{61.6,87}},
                            color={0,0,127}));
    connect(TAir, absToRelHum.TDryBul)
      annotation (Line(points={{43,105},{56.2,105},{56.2,87}}, color={0,0,127}));
    connect(EvaporationLoss.y, Q_Lat_mEvap) annotation (Line(points={{19.6,-14},{14,
            -14},{14,-24},{106,-24}},           color={0,0,127}));
    connect(Q_evap.u, EvaporationLoss.y) annotation (Line(points={{-62.8,0},{-70,0},
            {-70,-14},{19.6,-14}}, color={0,0,127}));
    connect(P_pump, P_pump) annotation (Line(points={{106,-46},{100,-46},{100,-46},
            {106,-46}}, color={0,0,127}));
    connect(Head.y, pump.dp_in) annotation (Line(points={{-27.6,-36},{-22,-36},
          {-22,-40},{-9.4,-40},{-9.4,-39}},
                                         color={0,0,127}));
    connect(pump.P, P_pump) annotation (Line(points={{-7.3,-31.3},{30,-31.3},{
          30,-46},{106,-46}},
                        color={0,0,127}));
    connect(pump.port_b, res.port_a) annotation (Line(points={{-1,-32},{0,-32},
          {0,-26},{-4,-26}},
                       color={0,127,255}));
    connect(res.port_b, SwimmingPoolWater.ports[2]) annotation (Line(points={{-4,-16},
          {-8,-16},{-8,-10},{-26,-10},{-26,-6}},             color={0,127,255}));
    connect(SwimmingPoolWater.QEvap_in, Q_evap.y) annotation (Line(points={{-36.6,
            0.2},{-50,0.2},{-50,-2},{-53.6,-2},{-53.6,0}}, color={0,0,127}));
    connect(SwimmingPoolWater.heatPort, heatFlowSensor.port_a) annotation (Line(
          points={{-36,4},{-46,4},{-46,10},{-54,10},{-54,14}}, color={191,0,0}));
    connect(SwimmingPoolWater.heatPort, heatTransferWaterSurface.heatport_noCover)
      annotation (Line(points={{-36,4},{-36,44},{-12,44}}, color={191,0,0}));
    connect(SwimmingPoolWater.heatPort, heatFlowSensor2.port_a)
      annotation (Line(points={{-36,4},{-36,24},{-10,24}}, color={191,0,0}));
  connect(Watertreatment.ports[3], prescribed_m_flow_toPool.port_b) annotation
    (Line(points={{-22,-72},{-10,-72},{-10,-66},{1,-66}}, color={0,127,255}));
  connect(prescribed_m_flow_toPool.port_a, pump.port_a)
    annotation (Line(points={{1,-52},{-1,-52},{-1,-46}}, color={0,127,255}));
  connect(SwimmingPoolWater.ports[3], prescribed_m_flow_evap.port_a)
    annotation (Line(points={{-23.3333,-6},{-6,-6}}, color={0,127,255}));
  connect(prescribed_m_flow_evap.port_b, massFlowRateEvaporation.port_a)
    annotation (Line(points={{10,-6},{32,-6}}, color={0,127,255}));
  connect(port_recycledWater, prescribed_m_flow_recycledWater.port_a)
    annotation (Line(points={{-100,-94},{-84,-94},{-84,-95},{-74,-95}}, color={
          0,127,255}));
  connect(prescribed_m_flow_recycledWater.port_b, Watertreatment.ports[4])
    annotation (Line(points={{-60,-95},{-20,-95},{-20,-84},{-20.4,-84},{-20.4,
          -72}}, color={0,127,255}));
  connect(port_freshWater, prescribed_m_flow_freshWater.port_a)
    annotation (Line(points={{-100,-76},{-74,-76}}, color={0,127,255}));
  connect(prescribed_m_flow_freshWater.port_b, Watertreatment.ports[5])
    annotation (Line(points={{-58,-76},{-18.8,-76},{-18.8,-72}}, color={0,127,
          255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},
              {100,100}}), graphics={Rectangle(
          extent={{-74,24},{72,-54}},
          lineColor={255,213,170},
          lineThickness=0.5,
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid), Rectangle(
          extent={{-60,24},{58,-42}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),
                            Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}})));
  end IndoorSwimmingPool;

  model IndoorSwimmingPool_2

    package Medium = AixLib.Fluid.Pools.BaseClasses.Water30degC;

    parameter Modelica.SIunits.Temperature T_pool;
    final parameter Modelica.SIunits.Volume V_pool= A_pool * d_pool;
    parameter Modelica.SIunits.Volume V_storage;
    parameter Modelica.SIunits.Area A_pool;
    parameter Modelica.SIunits.Length d_pool;

    parameter Real openAt = 7;
    parameter Real openingHours = 16/24;

    parameter Real beta_inUse;
    parameter Real beta_nonUse;
    parameter Boolean PartialLoad;
    parameter Real x_partialLoad;
    parameter Boolean poolCover;
    parameter Boolean WaterRecycling;
    parameter Real x_recycling;
    parameter Boolean NextToSoil;

    final parameter Real epsilon = 0.9*0.95;
    final constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air=3.5
      "Coefficient of heat transfer between the water surface and the room air";
    final constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_W=820
      "Coefficient of heat transfer between the water and the pool walls";
    final constant Real R_D(final unit="J/(kg.K)") = 461.52
      "Specific gas constant for steam";


    //Pool Wall
    parameter Integer nExt(min=1) "Number of RC-elements of exterior walls"
      annotation (Dialog(group="Exterior walls"));
    parameter Modelica.SIunits.ThermalResistance RExt[nExt](each min=Modelica.Constants.small)
      "Vector of resistors, from port_a to port_b"
      annotation (Dialog(group="Thermal mass"));
    parameter Modelica.SIunits.ThermalResistance RExtRem(min=Modelica.Constants.small)
      "Resistance of remaining resistor RExtRem between capacitor n and port_b"
      annotation (Dialog(group="Thermal mass"));
    parameter Modelica.SIunits.HeatCapacity CExt[nExt](each min=Modelica.Constants.small)
      "Vector of heat capacities, from port_a to port_b"
      annotation (Dialog(group="Thermal mass"));

    //Cover specs
    parameter Modelica.SIunits.ThermalConductivity lambda_poolCover
      "Thermal Conductivity of the pool cover";
    parameter Modelica.SIunits.Length t_poolCover "Thickness of the pool cover";




    parameter Modelica.SIunits.VolumeFlowRate Q(  min= 0.1)
      "Volume Flow Rate";

    parameter Modelica.SIunits.Pressure psat_T_pool=
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
        T_pool);
    Modelica.SIunits.Pressure psat_T_Air=
        Modelica.Media.Air.ReferenceMoistAir.Utilities.Water95_Utilities.psat(
        TAir);
    Real phi=absToRelHum.relHum;

    Modelica.SIunits.MassFlowRate m_flow_evap;
    Modelica.SIunits.MassFlowRate m_flow_toPool;
    Modelica.SIunits.MassFlowRate m_flow_freshWater;
    Modelica.SIunits.MassFlowRate m_flow_recycledWater;

    parameter Modelica.SIunits.MassFlowRate m_flow_start;

    final parameter Modelica.SIunits.SpecificEnergy h_evap = AixLib.Media.Air.enthalpyOfCondensingGas(T_pool);

    MixingVolumes.MixingVolume Watertreatment(
      redeclare package Medium = AixLib.Fluid.Pools.BaseClasses.Water30degC,
      T_start=T_pool,
      m_flow_nominal=m_flow_start,
      V=V_storage,
      nPorts=5) annotation (Placement(transformation(extent={{-6,-64},{14,-44}})));
    BaseClasses.MixingVolumeEvapLosses PoolWater(
      redeclare package Medium = Media.Water,
      T_start=T_pool,
      m_flow_nominal=m_flow_start,
      V=V_pool,
      nPorts=3) annotation (Placement(transformation(extent={{-2,4},{18,24}})));
    Modelica.Fluid.Interfaces.FluidPort_a freshWater(redeclare package Medium =
          AixLib.Fluid.Pools.BaseClasses.Water30degC)
      annotation (Placement(transformation(extent={{-112,-106},{-92,-86}})));
    Modelica.Fluid.Interfaces.FluidPort_a recycledWater(redeclare package Medium =
          AixLib.Fluid.Pools.BaseClasses.Water30degC)
      annotation (Placement(transformation(extent={{-110,-86},{-90,-66}})));
    Modelica.Fluid.Interfaces.FluidPort_b sewer(redeclare package Medium =
          AixLib.Fluid.Pools.BaseClasses.Water30degC)
      annotation (Placement(transformation(extent={{90,-64},{110,-44}})));
    Modelica.Fluid.Interfaces.FluidPort_b MEvap(redeclare package Medium =
          AixLib.Fluid.Pools.BaseClasses.Water30degC)
      annotation (Placement(transformation(extent={{92,2},{112,22}})));

    Movers.BaseClasses.IdealSource mFlow_toPool(redeclare package Medium =
          AixLib.Fluid.Pools.BaseClasses.Water30degC,
      m_flow_small=0.00000000001,
      control_m_flow=true,
      control_dp=false) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=90,
          origin={45,-39})));

    Movers.BaseClasses.IdealSource mFlow_recycledWater(redeclare package Medium =
          AixLib.Fluid.Pools.BaseClasses.Water30degC,
      m_flow_small=0.00000000001,
      control_m_flow=true,
      control_dp=false) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-40,-76})));

    Movers.BaseClasses.IdealSource mFlow_freshWater(redeclare package Medium =
          AixLib.Fluid.Pools.BaseClasses.Water30degC,
      m_flow_small=0.00000000001,
      control_m_flow=true,
      control_dp=false) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=0,
          origin={-41,-95})));


    Movers.BaseClasses.IdealSource mFlow_Evap(redeclare package Medium =
          AixLib.Fluid.Pools.BaseClasses.Water30degC,
      m_flow_small=0.00000000001,
      control_m_flow=true,
      control_dp=false)
      annotation (Placement(transformation(extent={{46,0},{56,10}})));

    Modelica.Blocks.Sources.RealExpression mFlowRecycledWater(final y=
          m_flow_recycledWater) "Prescribed MassFlow"
      annotation (Placement(transformation(extent={{-74,-66},{-60,-54}})));

    Modelica.Blocks.Sources.RealExpression mFlowFreshWater(final y=m_flow_freshWater)
      "Prescribed Mass flow"
      annotation (Placement(transformation(extent={{-72,-94},{-58,-82}})));

    Modelica.Blocks.Sources.RealExpression mFlowToPool(final y=m_flow_toPool)
      "Prescribed mass flow"
      annotation (Placement(transformation(extent={{22,-48},{36,-36}})));

    Modelica.Blocks.Sources.RealExpression mFlowEvap(final y=m_flow_evap)
      "Prescribed mass flow"
      annotation (Placement(transformation(extent={{32,10},{46,22}})));

    Modelica.Blocks.Math.Gain gain(final k=h_evap)
      annotation (Placement(transformation(extent={{-22,28},{-30,36}})));

    Modelica.Blocks.Sources.BooleanPulse inUse(
      final width=openingHours,
      final period=86400,
      final startTime=openAt)
      "is the swimming pool currently in use - pulse between opening hours of swimming hall"
      annotation (Placement(transformation(extent={{16,74},{30,88}})));
    ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum
      annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=-90,
          origin={59,81})));
    Modelica.Blocks.Interfaces.RealInput TAir(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Temperature of the surrounding room air" annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={43,105})));

    Modelica.Blocks.Interfaces.RealInput X_w "Absolute humidty of the room Air"
      annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={73,105})));
    Modelica.Blocks.Math.Gain gain1(final k=-1)
      annotation (Placement(transformation(extent={{4,-4},{-4,4}},
          rotation=180,
          origin={-20,6})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-66,-52},{-46,-32}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=4) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-80,-24})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TRoom
      "Air Temperature in Zone"
      annotation (Placement(transformation(extent={{-22,88},{2,112}})));
    BaseClasses.HeatTransferWaterSurface heatTransferWaterSurface(final alpha_Air=alpha_Air,
    final A= A_pool,
    final lambda_poolCover = lambda_poolCover,
    final t_poolCover = t_poolCover)
      annotation (Placement(transformation(extent={{-22,52},{-4,66}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor QFlow_Conv_Sensor
      annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={-13,79})));
    Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(final Gr=
          epsilon) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-55,55})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=-90,
          origin={-55,77})));

    Modelica.Blocks.Interfaces.RealInput TRad(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Mean Radiation Temperature of surrounding walls"
      annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={-55,105}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={-72,106})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor QFlow_Rad_Sensor
      annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={-53,29})));
    BaseClasses.HeatTransferConduction heatTransferConduction( final alpha_W = alpha_W,
      final nExt=nExt,
      final CExt = CExt,
      final NextToSoil = NextToSoil,
      final RExt=RExt,
      final RExtRem=RExtRem,
      final T_nextDoor= T_pool)
      annotation (Placement(transformation(extent={{52,42},{72,62}})));
    Modelica.Blocks.Interfaces.RealInput TSoil(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Temperature of Soil" annotation (Placement(
          transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={107,55})));

    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor QFlow_Cond_Sensor
      annotation (Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={29,41})));
  equation



   if inUse.y or not PartialLoad then
       m_flow_toPool = Q*Medium.d_const;
       m_flow_evap = -(beta_inUse)/(R_D*0.5*(T_pool + TAir))*(psat_T_pool - phi*
         psat_T_Air)*A_pool;
   else
       m_flow_toPool= Q*x_partialLoad*Medium.d_const;
       m_flow_evap = -(beta_nonUse)/(R_D*0.5*(T_pool + TAir))*(psat_T_pool - phi*
          psat_T_Air)*A_pool;
   end if;


    0= m_flow_freshWater + (1-x_recycling)*(sewer.m_flow + m_flow_evap);
    0= m_flow_recycledWater + x_recycling *(sewer.m_flow + m_flow_evap);


    connect(Watertreatment.ports[1], sewer) annotation (Line(points={{0.8,-64},{56,
            -64},{56,-48},{100,-48},{100,-54}},
                                              color={0,127,255}));
    connect(PoolWater.ports[1], Watertreatment.ports[2]) annotation (Line(points={{5.33333,
            4},{-8,4},{-8,-64},{2.4,-64}},  color={0,127,255}));
    connect(mFlowRecycledWater.y, mFlow_recycledWater.m_flow_in) annotation (Line(
          points={{-59.3,-60},{-44.8,-60},{-44.8,-69.6}}, color={0,0,127}));
    connect(mFlowFreshWater.y, mFlow_freshWater.m_flow_in) annotation (Line(
          points={{-57.3,-88},{-45.2,-88},{-45.2,-89.4}}, color={0,0,127}));
    connect(mFlowToPool.y, mFlow_toPool.m_flow_in)
      annotation (Line(points={{36.7,-42},{41,-42}}, color={0,0,127}));
    connect(mFlowEvap.y, mFlow_Evap.m_flow_in) annotation (Line(points={{46.7,16},
            {46.7,10},{48,10},{48,9}}, color={0,0,127}));
    connect(PoolWater.ports[2], mFlow_Evap.port_a)
      annotation (Line(points={{8,4},{46,4},{46,5}}, color={0,127,255}));
    connect(recycledWater, mFlow_recycledWater.port_a)
      annotation (Line(points={{-100,-76},{-48,-76}}, color={0,127,255}));
    connect(mFlow_recycledWater.port_b, Watertreatment.ports[3]) annotation (Line(
          points={{-32,-76},{4,-76},{4,-64}},                     color={0,127,255}));
    connect(Watertreatment.ports[4], mFlow_toPool.port_a) annotation (Line(points={{5.6,-64},
            {12,-64},{12,-60},{45,-60},{45,-44}},           color={0,127,255}));
    connect(mFlow_toPool.port_b, PoolWater.ports[3]) annotation (Line(points={{45,-34},
          {44,-34},{44,-6},{10,-6},{10,4},{10.6667,4}},
                                               color={0,127,255}));
    connect(freshWater, mFlow_freshWater.port_a) annotation (Line(points={{-102,-96},
            {-76,-96},{-76,-95},{-48,-95}}, color={0,127,255}));
    connect(mFlow_freshWater.port_b, Watertreatment.ports[5]) annotation (Line(
          points={{-34,-95},{-18,-95},{-18,-96},{7.2,-96},{7.2,-64}}, color={0,127,
            255}));
    connect(X_w,absToRelHum. absHum) annotation (Line(points={{73,105},{60,105},
          {60,87},{61.6,87}},
                            color={0,0,127}));
    connect(TAir,absToRelHum. TDryBul)
      annotation (Line(points={{43,105},{56.2,105},{56.2,87}}, color={0,0,127}));
    connect(mFlow_Evap.port_b, MEvap) annotation (Line(points={{56,5},{72,5},{72,4},
            {102,4},{102,12}}, color={0,127,255}));
    connect(mFlowEvap.y, gain.u) annotation (Line(points={{46.7,16},{54,16},{54,32},
            {-21.2,32}}, color={0,0,127}));
    connect(PoolWater.QEvap_in, gain1.y) annotation (Line(points={{-2.6,10.2},{-10,
            10.2},{-10,6},{-15.6,6}},   color={0,0,127}));
    connect(gain.y, gain1.u) annotation (Line(points={{-30.4,32},{-34,32},{-34,6},
            {-24.8,6}},  color={0,0,127}));
    connect(multiSum.y,prescribedHeatFlow. Q_flow) annotation (Line(points={{-80,-31.02},
            {-80,-42},{-66,-42}}, color={0,0,127}));
    connect(multiSum.u[1], gain.y) annotation (Line(points={{-76.85,-18},{-76.85,-12},
            {-38,-12},{-38,32},{-30.4,32}}, color={0,0,127}));
    connect(heatTransferWaterSurface.heatport_noCover, PoolWater.heatPort)
      annotation (Line(points={{-13,52},{-14,52},{-14,14},{-2,14}}, color={191,0,0}));
    connect(TRoom, QFlow_Conv_Sensor.port_b) annotation (Line(points={{-10,100},{-12,
            100},{-12,86},{-13,86}}, color={191,0,0}));
    connect(heatTransferWaterSurface.heatPort_b, QFlow_Conv_Sensor.port_a)
      annotation (Line(points={{-13.18,66.4667},{-13,66.4667},{-13,72}}, color={191,
            0,0}));
    connect(QFlow_Conv_Sensor.Q_flow, multiSum.u[2]) annotation (Line(points={{-20,79},
            {-28,79},{-28,44},{-78.95,44},{-78.95,-18}},   color={0,0,127}));
    connect(TRad,prescribedTemperature. T) annotation (Line(points={{-55,105},{-55,
            94.5},{-55,94.5},{-55,83}}, color={0,0,127}));
    connect(prescribedTemperature.port,bodyRadiation. port_b)
      annotation (Line(points={{-55,72},{-55,62}}, color={191,0,0}));
    connect(QFlow_Rad_Sensor.port_b, bodyRadiation.port_a)
      annotation (Line(points={{-53,36},{-55,36},{-55,48}}, color={191,0,0}));
    connect(QFlow_Rad_Sensor.port_a, PoolWater.heatPort) annotation (Line(points={
            {-53,22},{-54,22},{-54,14},{-2,14}}, color={191,0,0}));
    connect(QFlow_Rad_Sensor.Q_flow, multiSum.u[3]) annotation (Line(points={{-60,
            29},{-72,29},{-72,26},{-82.1,26},{-82.1,-18},{-81.05,-18}}, color={0,0,
            127}));
    connect(prescribedHeatFlow.port, Watertreatment.heatPort) annotation (Line(
          points={{-46,-42},{-36,-42},{-36,-52},{-6,-52},{-6,-54}}, color={191,0,0}));
    connect(TSoil, heatTransferConduction.TSoil) annotation (Line(points={{107,55},
            {90,55},{90,55.6},{72.6,55.6}}, color={0,0,127}));
    connect(heatTransferConduction.heatport_a, QFlow_Cond_Sensor.port_b)
      annotation (Line(points={{52,52.2},{48,52.2},{48,48},{29,48}}, color={191,0,
            0}));
    connect(PoolWater.heatPort, QFlow_Cond_Sensor.port_a) annotation (Line(points=
           {{-2,14},{-14,14},{-14,34},{29,34}}, color={191,0,0}));
    connect(QFlow_Cond_Sensor.Q_flow, multiSum.u[4]) annotation (Line(points={{22,
            41},{4,41},{4,40},{-84,40},{-84,-14},{-83.15,-14},{-83.15,-18}},
          color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end IndoorSwimmingPool_2;
end Pools;
