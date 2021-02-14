within AixLib.Fluid;
package Pools "Models to describe Swimming Pools"
  model IndoorSwimmingPool

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

    constant Modelica.SIunits.Temperature T_pool "Temperature of pool";

    parameter Boolean NextToSoil "Does the pool border to soil?";
    parameter Boolean PoolCover "Is the pool covered during non-opening hours?";

    parameter Real k "Belastungsfaktor";
    parameter Real N "Nennbelastung";
    parameter Real beta_inUse "Wasserübergangskoeffizient in use";
    parameter Real beta_nonUse "Wasserübergangskoeffizient non-use";

    parameter Modelica.SIunits.Velocity v_Filter "Velocity of Filtering";
    parameter Modelica.SIunits.VolumeFlowRate Q_hygenic "Hygenic motivated Volume Flow Rate";
    parameter Modelica.SIunits.VolumeFlowRate Q_hydraulic "Hydraulic motivated Volume Flow Rate";
    parameter Modelica.SIunits.Volume V_storage "Volume of Waterstorage";


    //Pool Wall
    parameter Integer nExt(min = 1) "Number of RC-elements of exterior walls"
      annotation(Dialog(group="Exterior walls"));
    parameter Modelica.SIunits.ThermalResistance RExt[nExt](
      each min=Modelica.Constants.small) "Vector of resistors, from port_a to port_b"
      annotation(Dialog(group="Thermal mass"));
    parameter Modelica.SIunits.ThermalResistance RExtRem(
      min=Modelica.Constants.small)
                                   "Resistance of remaining resistor RExtRem between capacitor n and port_b"
       annotation(Dialog(group="Thermal mass"));
    parameter Modelica.SIunits.HeatCapacity CExt[nExt](
      each min=Modelica.Constants.small) "Vector of heat capacities, from port_a to port_b"
      annotation(Dialog(group="Thermal mass"));
    parameter Real openingHours = 16/24 "Open for x hours during the day, no closed time in between";
    parameter Real openAt = 7*3600 "Opens at this time during the day";

    parameter Modelica.SIunits.Volume V_pool = A_pool*d_pool;

    //Cover specs
    constant Modelica.SIunits.ThermalConductivity lambda_poolCover "Thermal Conductivity of the pool cover";
    constant Modelica.SIunits.Length t_poolCover "Thickness of the pool cover";

    //***********************************************
    //ENDE RECORD GROESSEN
    //************************************

    //Calculation Convection, Evaporation and Radiation

    constant Modelica.SIunits.SpecificEnergy h_evap = AixLib.Media.Air.enthalpyOfCondensingGas(T_pool);
    constant Real epsilon = 0.9*0.95 "Product of emissivity of water and the emissivity of surrounding walls";
    constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air = 3.5 "Coefficient of heat transfer between the water surface and the room air";
    constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_W = 820 "Coefficient of heat transfer between the water and the pool walls";
    constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Cover = 40 "Coefficient of heat transfer between the water and the pool cover";




    MixingVolumes.MixingVolume SwimmingPoolWater(
      V=V_pool,nPorts=3,
      redeclare final package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater (cp_const=4180,
        d_const=995.65,
        eta_const=0.79722e-3,
        lambda_const=0.61439,
        T0=273.15,
        MM_const=0.018015268),
      final T_start=poolParam.T_pool) "Water Volume in the swimming pool"
      annotation (Placement(transformation(extent={{-36,-6},{-16,14}})));

    MixingVolumes.MixingVolume Watertreatment(
      allowFlowReversal=false,
      V=V_storage,nPorts=5,
      redeclare final package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater (cp_const=4180,
        d_const=995.65,
        eta_const=0.79722e-3,
        lambda_const=0.61439,
        T0=273.15,
        MM_const=0.018015268),
      final T_start=poolParam.T_pool)
      annotation (Placement(transformation(extent={{-32,-60},{-12,-40}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b
      annotation (Placement(transformation(extent={{90,-84},{110,-64}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_freshWater
      "Fresh cold water at 10°C "
      annotation (Placement(transformation(extent={{-110,-78},{-90,-58}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-74,-60},{-54,-40}})));
    Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(Gr=
          epsilon)
      annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-55,55})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=-90,
          origin={-55,77})));
    Modelica.Blocks.Interfaces.RealInput TRad
      "Mean Radiation Temperature of surrounding walls" annotation (Placement(
          transformation(
          extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={-55,105})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TRoom
      "Air Temperature in Zone"
      annotation (Placement(transformation(extent={{-22,88},{-2,108}})));
    Modelica.Blocks.Interfaces.RealInput TSoil "Temperature of Soil"
                                                        annotation (Placement(
          transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={111,53})));
    Modelica.Fluid.Interfaces.FluidPort_b m_evap
      "Evaporation Mass Flow from Swimming Pool"
      annotation (Placement(transformation(extent={{90,-28},{110,-8}})));
    Modelica.Blocks.Interfaces.RealOutput Q_Lat_mEvap
      "Latent heat of evaporation rate from swimming pool to surrounding air"
      annotation (Placement(transformation(extent={{96,-44},{116,-24}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRateEvaporation
      annotation (Placement(transformation(extent={{32,-8},{52,-28}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=4) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-86,-30})));
    Modelica.Blocks.Math.Gain gain(k=-h_evap)
      annotation (Placement(transformation(extent={{26,-30},{18,-22}})));
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
      width=openingHours,                      final period= 86400,
      startTime=openAt)
      "is the swimming pool currently in use - pulse between opening hours of swimming hall"
      annotation (Placement(transformation(extent={{20,76},{34,90}})));
    Modelica.Blocks.Math.Gain gain1(k=h_evap)
      annotation (Placement(transformation(extent={{64,-42},{72,-34}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a_recycledWater
      "Port for recycled warm Water at 25°C"
      annotation (Placement(transformation(extent={{-110,-96},{-90,-76}})));
    BaseClasses.HeatTransferWaterSurface heatTransferWaterSurface(
      final alpha_Air = alpha_Air,
      final alpha_Cover = alpha_Cover,
      final lambda_poolCover = poolParam.poolCover,
      final t_poolCover = poolPara.poolCover)
      annotation (Placement(transformation(extent={{-20,44},{-4,60}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor HeatFlowSensor_poolSurface
    "Heatflow sensor to measure the heatflow at the water surface" annotation (
      Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={-12,76})));
    BaseClasses.HeatTransferConduction heatTransferConduction(
      final alpha_W = poolParam.alpha_W,
      final T_nextDoor = poolParam.T_pool,
      final NextToSoil=poolParam.NextToSoil,
      final RExt = poolParam.RExt,
      final RExtRem = poolParam.RExtRem,
      final nExt = poolParam.nExt,
      final CExt=poolParam.CExt)
      annotation (Placement(transformation(extent={{20,14},{40,34}})));
  equation



    // Heattransfer at Water surface

    if PoolCover and not inUse.y then
      heatTransferWaterSurface.heatport_noCover.Q_flow = 0;
    else
      heatTransferWaterSurface.heatport_Cover.Q_flow = 0;
    end if;




    connect(port_a_freshWater, Watertreatment.ports[1]) annotation (Line(points={{-100,
          -68},{-25.2,-68},{-25.2,-60}},        color={0,127,255}));
    connect(SwimmingPoolWater.ports[1], Watertreatment.ports[2]) annotation (Line(
          points={{-28.6667,-6},{-48,-6},{-48,-60},{-23.6,-60}},
                                                          color={0,127,255}));
    connect(Watertreatment.ports[3], port_b) annotation (Line(points={{-22,-60},
          {-22,-60},{-22,-74},{100,-74}},
                                       color={0,127,255}));
    connect(port_a_recycledWater, Watertreatment.ports[4]) annotation (Line(
          points={{-100,-86},{-68,-86},{-68,-80},{-20.4,-80},{-20.4,-60}}, color={
            0,127,255}));
    connect(prescribedHeatFlow.port, Watertreatment.heatPort) annotation (Line(
          points={{-54,-50},{-32,-50}},                     color={191,0,0}));
    connect(TRad, prescribedTemperature.T) annotation (Line(points={{-55,105},{-55,
            94.5},{-55,94.5},{-55,83}}, color={0,0,127}));
    connect(prescribedTemperature.port, bodyRadiation.port_b)
      annotation (Line(points={{-55,72},{-55,62}},          color={191,0,0}));
    connect(SwimmingPoolWater.ports[2], massFlowRateEvaporation.port_a)
      annotation (Line(points={{-26,-6},{14,-6},{14,-18},{32,-18}},      color=
            {0,127,255}));
    connect(massFlowRateEvaporation.port_b, m_evap)
      annotation (Line(points={{52,-18},{100,-18}}, color={0,127,255}));
    connect(multiSum.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{
            -86,-37.02},{-86,-50},{-74,-50}}, color={0,0,127}));
    connect(gain.u, massFlowRateEvaporation.m_flow) annotation (Line(points={{
            26.8,-26},{36,-26},{36,-29},{42,-29}}, color={0,0,127}));
    connect(gain.y, multiSum.u[1]) annotation (Line(points={{17.6,-26},{-32,-26},
          {-32,-24},{-82.85,-24}},   color={0,0,127}));
    connect(bodyRadiation.port_a, heatFlowSensor.port_b)
      annotation (Line(points={{-55,48},{-55,36},{-54,36},{-54,30}},
                                                   color={191,0,0}));
    connect(heatFlowSensor.port_a, SwimmingPoolWater.heatPort) annotation (Line(
          points={{-54,14},{-54,12},{-36,12},{-36,4}}, color={191,0,0}));
    connect(heatFlowSensor.Q_flow, multiSum.u[2]) annotation (Line(points={{-62,22},
          {-78,22},{-78,10},{-84.95,10},{-84.95,-24}},       color={0,0,127}));
    connect(SwimmingPoolWater.heatPort, heatFlowSensor2.port_a)
      annotation (Line(points={{-36,4},{-36,24},{-10,24}}, color={191,0,0}));
    connect(heatFlowSensor2.Q_flow, multiSum.u[3]) annotation (Line(points={{-2,32},
          {-4,32},{-4,34},{-87.05,34},{-87.05,-24}},       color={0,0,127}));


    connect(massFlowRateEvaporation.m_flow, gain1.u) annotation (Line(points={{42,
            -29},{54,-29},{54,-38},{63.2,-38}}, color={0,0,127}));
    connect(gain1.y, Q_Lat_mEvap) annotation (Line(points={{72.4,-38},{106,-38},{106,
            -34}}, color={0,0,127}));
    connect(port_a_recycledWater, port_a_recycledWater)
      annotation (Line(points={{-100,-86},{-100,-86}}, color={0,127,255}));

  connect(SwimmingPoolWater.heatPort, heatTransferWaterSurface.heatport_noCover)
    annotation (Line(points={{-36,4},{-36,40},{-7.84,40},{-7.84,44.2667}},
        color={191,0,0}));
  connect(SwimmingPoolWater.heatPort, heatTransferWaterSurface.heatport_Cover)
    annotation (Line(points={{-36,4},{-36,40},{-15.68,40},{-15.68,44}}, color={
          191,0,0}));
  connect(TRoom, HeatFlowSensor_poolSurface.port_b)
    annotation (Line(points={{-12,98},{-12,82}}, color={191,0,0}));
  connect(heatTransferWaterSurface.heatPort_b, HeatFlowSensor_poolSurface.port_a)
    annotation (Line(points={{-12.16,60.5333},{-8,60.5333},{-8,70},{-12,70}},
        color={191,0,0}));
  connect(HeatFlowSensor_poolSurface.Q_flow, multiSum.u[4]) annotation (Line(
        points={{-18,76},{-90,76},{-90,66},{-89.15,66},{-89.15,-24}}, color={0,
          0,127}));
    connect(heatTransferConduction.TSoil, TSoil) annotation (Line(points={{40.6,27.6},
            {73.3,27.6},{73.3,53},{111,53}}, color={0,0,127}));
    connect(heatFlowSensor2.port_b,heatTransferConduction.heatport_a)
      annotation (Line(points={{6,24},{16,24},{16,24.2},{20,24.2}}, color={191,0,0}));
  connect(Watertreatment.ports[5], SwimmingPoolWater.ports[3]) annotation (Line(
        points={{-18.8,-60},{-6,-60},{-6,-6},{-23.3333,-6}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},
              {100,100}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
  end IndoorSwimmingPool;

end Pools;
