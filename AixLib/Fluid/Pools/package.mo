within AixLib.Fluid;
package Pools "Models to describe Swimming Pools"
  model IndoorSwimmingPool
    AixLib.DataBase.Pools.TypesOfIndoorSwimmingPools.SportPool poolParam;

    parameter Real openingHours = 16/24;
    parameter Real openAt = 7*3600;
    parameter Modelica.SIunits.Volume V_pool = poolParam.A_pool*poolParam.d_pool;

    parameter Modelica.SIunits.ThermalResistance R_poolCover;
    parameter Modelica.SIunits.SpecificEnergy h_evap = AixLib.Media.Air.enthalpyOfCondensingGas(poolParam.T_pool);
    constant Real epsilon = 0.9*0.95;
    constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air = 3.5;
    constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_W = 820;
    constant Modelica.SIunits.CoefficientOfHeatTransfer alpha_Cover = 40;


    Modelica.Fluid.Vessels.ClosedVolume SwimmingPoolWater(use_HeatTransfer=true,
      V=V_pool,
        nPorts=3,
      redeclare final package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater (                                cp_const=4180,
      d_const=995.65,
      eta_const=0.79722e-3,
      lambda_const=0.61439,
      T0=273.15,
      MM_const=0.018015268),
        final T_start=poolParam.T_pool)
      annotation (Placement(transformation(extent={{-36,-6},{-16,14}})));

    Modelica.Fluid.Vessels.ClosedVolume Watertreatment(use_HeatTransfer=true,
        nPorts=4, redeclare final package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater (                                          cp_const=4180,
      d_const=995.65,
      eta_const=0.79722e-3,
      lambda_const=0.61439,
      T0=273.15,
      MM_const=0.018015268),
        final T_start=poolParam.T_pool)
      annotation (Placement(transformation(extent={{-32,-60},{-12,-40}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b
      annotation (Placement(transformation(extent={{90,-84},{110,-64}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a
      annotation (Placement(transformation(extent={{-110,-78},{-90,-58}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
      annotation (Placement(transformation(extent={{-74,-60},{-54,-40}})));
    Modelica.Thermal.HeatTransfer.Components.Convection Convection
      "Convection between Water and pool wall/ground"
      annotation (Placement(transformation(extent={{22,10},{8,24}})));
    Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={6,80})));
    Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(Gr=
          epsilon)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-54,48})));
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
    ThermalZones.ReducedOrder.RC.BaseClasses.ExteriorWall extWalRC
      "Surounding Walls of Swimming Pool"
      annotation (Placement(transformation(extent={{26,10},{40,24}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TRoom
      "Air Temperature in Zone"
      annotation (Placement(transformation(extent={{0,90},{20,110}})));
    Modelica.Blocks.Logical.Switch switch1 "Neighbouring Soil or different rooms"
      annotation (Placement(transformation(extent={{74,10},{62,22}})));
    Modelica.Blocks.Interfaces.RealInput TSoil
      "Mean Radiation Temperature of surrounding walls" annotation (Placement(
          transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={111,53})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature1 annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=180,
          origin={49,17})));
    Modelica.Blocks.Sources.Constant TNextDoor(k=poolParam.T_pool)
      "Temperature of the room beneath the pool"
      annotation (Placement(transformation(extent={{94,2},{86,10}})));
    Modelica.Blocks.Sources.BooleanConstant booleanNextToSoil(k=poolParam.NextToSoil)
      "Soil or room under the Swimming Pool"
      annotation (Placement(transformation(extent={{96,26},{84,38}})));
    Modelica.Blocks.Sources.Constant Constant_alpha_W(k=alpha_W)
      "heat transfer coefficient between wall and water"
      annotation (Placement(transformation(extent={{30,34},{20,44}})));
    Modelica.Blocks.Sources.Constant Constant_alpha_A(k=alpha_Air)
      "heat transfer coefficient between air and water"
      annotation (Placement(transformation(extent={{-30,72},{-18,84}})));
    Modelica.Fluid.Interfaces.FluidPort_b m_evap
      "Evaporation Mass Flow from Swimming Pool"
      annotation (Placement(transformation(extent={{90,-28},{110,-8}})));
    Modelica.Blocks.Interfaces.RealOutput mEvap
      "Evaporation rate from swimming pool to surrounding air"
      annotation (Placement(transformation(extent={{96,-44},{116,-24}})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRateEvaporation
      annotation (Placement(transformation(extent={{32,-8},{52,-28}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=4) annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-86,-30})));
    Modelica.Blocks.Math.Gain gain(k=h_evap)
      annotation (Placement(transformation(extent={{26,-30},{18,-22}})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
      annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=90,
          origin={-54,22})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor1
      annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=90,
          origin={-14,38})));
    Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor2
      annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=0,
          origin={-2,24})));
    Modelica.Blocks.Sources.BooleanPulse inUse(
      width=openingHours,                      final period= 86400,
      startTime=openAt)
      "is the swimming pool currently in use - pulse between opening hours of swimming hall"
      annotation (Placement(transformation(extent={{70,80},{84,94}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalResistor poolCover(R=R_poolCover)
      "Resistance of pool cover during non opening hours" annotation (Placement(
          transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={-10,58})));
  equation
    connect(port_a, Watertreatment.ports[1]) annotation (Line(points={{-100,-68},{
            -25,-68},{-25,-60}}, color={0,127,255}));
    connect(SwimmingPoolWater.ports[1], Watertreatment.ports[2]) annotation (Line(
          points={{-28.6667,-6},{-48,-6},{-48,-60},{-23,-60}},
                                                          color={0,127,255}));
    connect(Watertreatment.ports[3], SwimmingPoolWater.ports[2]) annotation (Line(
          points={{-21,-60},{-8,-60},{-8,-6},{-26,-6}}, color={0,127,255}));
    connect(Watertreatment.ports[4], port_b) annotation (Line(points={{-19,-60},{-22,
            -60},{-22,-74},{100,-74}}, color={0,127,255}));
    connect(prescribedHeatFlow.port, Watertreatment.heatPort) annotation (Line(
          points={{-54,-50},{-32,-50}},                     color={191,0,0}));
    connect(convection1.fluid, TRoom)
      annotation (Line(points={{6,90},{6,86},{10,86},{10,100}},
                                                  color={191,0,0}));
    connect(TRad, prescribedTemperature.T) annotation (Line(points={{-55,105},{-55,
            94.5},{-55,94.5},{-55,83}}, color={0,0,127}));
    connect(prescribedTemperature.port, bodyRadiation.port_b)
      annotation (Line(points={{-55,72},{-54,72},{-54,58}}, color={191,0,0}));
    connect(extWalRC.port_a, Convection.solid)
      annotation (Line(points={{26,16.3636},{26,17},{22,17}}, color={191,0,0}));
    connect(extWalRC.port_b, prescribedTemperature1.port) annotation (Line(points={{40,
          16.3636},{44,16.3636},{44,17}},       color={191,0,0}));
    connect(switch1.u1, TSoil) annotation (Line(points={{75.2,20.8},{75.2,53},{111,
            53}}, color={0,0,127}));
    connect(TNextDoor.y, switch1.u3)
      annotation (Line(points={{85.6,6},{75.2,6},{75.2,11.2}}, color={0,0,127}));
    connect(switch1.y, prescribedTemperature1.T) annotation (Line(points={{61.4,16},
            {58,16},{58,17},{55,17}}, color={0,0,127}));
    connect(booleanNextToSoil.y, switch1.u2) annotation (Line(points={{83.4,32},{80,
            32},{80,16},{75.2,16}}, color={255,0,255}));
    connect(Constant_alpha_W.y, Convection.Gc)
      annotation (Line(points={{19.5,39},{15,39},{15,24}}, color={0,0,127}));
    connect(Constant_alpha_A.y, convection1.Gc) annotation (Line(points={{-17.4,78},{-8,78},{-8,
            80},{-4,80}},            color={0,0,127}));
    connect(SwimmingPoolWater.ports[3], massFlowRateEvaporation.port_a)
      annotation (Line(points={{-23.3333,-6},{14,-6},{14,-18},{32,-18}}, color=
            {0,127,255}));
    connect(massFlowRateEvaporation.port_b, m_evap)
      annotation (Line(points={{52,-18},{100,-18}}, color={0,127,255}));
    connect(massFlowRateEvaporation.m_flow, mEvap) annotation (Line(points={{42,
            -29},{54,-29},{54,-38},{106,-38},{106,-34}}, color={0,0,127}));
    connect(multiSum.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{
            -86,-37.02},{-86,-50},{-74,-50}}, color={0,0,127}));
    connect(gain.u, massFlowRateEvaporation.m_flow) annotation (Line(points={{
            26.8,-26},{36,-26},{36,-29},{42,-29}}, color={0,0,127}));
    connect(gain.y, multiSum.u[1]) annotation (Line(points={{17.6,-26},{-32,-26},
            {-32,-24},{-82.85,-24}}, color={0,0,127}));
    connect(bodyRadiation.port_a, heatFlowSensor.port_b)
      annotation (Line(points={{-54,38},{-54,30}}, color={191,0,0}));
    connect(heatFlowSensor.port_a, SwimmingPoolWater.heatPort) annotation (Line(
          points={{-54,14},{-54,12},{-36,12},{-36,4}}, color={191,0,0}));
    connect(heatFlowSensor.Q_flow, multiSum.u[2]) annotation (Line(points={{-62,
            22},{-78,22},{-78,10},{-84.95,10},{-84.95,-24}}, color={0,0,127}));
    connect(heatFlowSensor1.port_a, SwimmingPoolWater.heatPort) annotation (
        Line(points={{-14,30},{-14,24},{-36,24},{-36,4}}, color={191,0,0}));
    connect(heatFlowSensor1.Q_flow, multiSum.u[3]) annotation (Line(points={{
            -22,38},{-34,38},{-34,32},{-87.05,32},{-87.05,-24}}, color={0,0,127}));
    connect(SwimmingPoolWater.heatPort, heatFlowSensor2.port_a)
      annotation (Line(points={{-36,4},{-36,24},{-10,24}}, color={191,0,0}));
    connect(heatFlowSensor2.port_b, Convection.fluid)
      annotation (Line(points={{6,24},{8,24},{8,17}}, color={191,0,0}));
    connect(heatFlowSensor2.Q_flow, multiSum.u[4]) annotation (Line(points={{-2,
            32},{-4,32},{-4,34},{-89.15,34},{-89.15,-24}}, color={0,0,127}));
    connect(convection1.solid, poolCover.port_b)
      annotation (Line(points={{6,70},{-10,70},{-10,64}}, color={191,0,0}));
    connect(poolCover.port_a, heatFlowSensor1.port_b)
      annotation (Line(points={{-10,52},{-14,52},{-14,46}}, color={191,0,0}));
    if poolParam.PoolCover and not inUse.y then

    // Pool Cover During non-opening hours

      R_poolCover = (0.25*poolParam.A_pool)^(-1);
    else
      R_poolCover = 0;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end IndoorSwimmingPool;

end Pools;
