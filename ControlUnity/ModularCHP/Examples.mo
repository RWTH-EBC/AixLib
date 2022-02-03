within ControlUnity.ModularCHP;
package Examples
  model CHPSimpleTwoPosition

    ModularCHP modularCHP(
      PelNom(displayUnit="kW") = 100000,
      use_advancedControl=false,
      TVar=false,
      bandwidth=4,
      Tref=358.15,
      severalHeatcurcuits=true,
      simpleTwoPosition=true) annotation (Placement(transformation(extent={{-26,-12},{-6,8}})));
    AixLib.Controls.Interfaces.CHPControlBus cHPControlBus
      annotation (Placement(transformation(extent={{-86,-6},{-46,34}})));

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=2)
      annotation (Placement(transformation(extent={{46,6},{66,26}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={32,52})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{-34,62},{-14,82}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{58,-24},{78,-4}})));
    Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      allowFlowReversal=true,
      length=5,
      isCircular=true,
      diameter=0.03,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=0, m_flow_nominal=0.4785))
      annotation (Placement(transformation(extent={{38,-40},{16,-20}})));
    AixLib.Fluid.Sources.Boundary_pT
                        bou(
      use_T_in=false,
      redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
      annotation (Placement(transformation(extent={{6,-54},{-14,-34}})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-104,4},{-92,24}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-98,-24},{-78,-4}})));
  equation
    connect(cHPControlBus, modularCHP.cHPControlBus) annotation (Line(
        points={{-66,14},{-22,14},{-22,8.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(heater.port, vol.heatPort)
      annotation (Line(points={{32,42},{32,16},{46,16}}, color={191,0,0}));
    connect(sine.y, heater.Q_flow)
      annotation (Line(points={{-13,72},{32,72},{32,62}}, color={0,0,127}));
    connect(temperatureSensor.port, vol.heatPort)
      annotation (Line(points={{58,-14},{46,-14},{46,16}}, color={191,0,0}));
    connect(modularCHP.port_b, vol.ports[1]) annotation (Line(points={{-6,-2},{
            26,-2},{26,6},{54,6}}, color={0,127,255}));
    connect(vol.ports[2], pipe.port_a) annotation (Line(points={{58,6},{56,6},{
            56,-30},{38,-30}}, color={0,127,255}));
    connect(pipe.port_b, modularCHP.port_a) annotation (Line(points={{16,-30},{
            -36,-30},{-36,-2},{-26,-2}}, color={0,127,255}));
    connect(bou.ports[1], modularCHP.port_a) annotation (Line(points={{-14,-44},
            {-30,-44},{-30,-2},{-26,-2}}, color={0,127,255}));
    connect(isOn.y, cHPControlBus.isOn) annotation (Line(points={{-77,-14},{
            -65.9,-14},{-65.9,14.1}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(PLR.y, cHPControlBus.PLR) annotation (Line(points={{-91.4,14},{-78,
            14},{-78,14},{-66,14}},       color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=5000));
  end CHPSimpleTwoPosition;

  model CHPFlowTemperature

    ModularCHP modularCHP(
      PelNom(displayUnit="kW") = 100000,
      use_advancedControl=true,
      TVar=false,
      bandwidth=4,
      Tref=358.15,
      severalHeatcurcuits=false,
      declination=5,
      TOffset(displayUnit="K"),
      simpleTwoPosition=true) annotation (Placement(transformation(extent={{-24,-14},
              {-4,6}})));
    AixLib.Controls.Interfaces.CHPControlBus cHPControlBus
      annotation (Placement(transformation(extent={{-86,-6},{-46,34}})));

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=2)
      annotation (Placement(transformation(extent={{46,6},{66,26}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={32,52})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{-34,62},{-14,82}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{58,-24},{78,-4}})));
    Modelica.Fluid.Pipes.StaticPipe pipe(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      allowFlowReversal=true,
      length=5,
      isCircular=true,
      diameter=0.03,
      redeclare model FlowModel =
          Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
            dp_nominal=0, m_flow_nominal=0.4785))
      annotation (Placement(transformation(extent={{38,-40},{16,-20}})));
    AixLib.Fluid.Sources.Boundary_pT
                        bou(
      use_T_in=false,
      redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
      annotation (Placement(transformation(extent={{6,-54},{-14,-34}})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-104,4},{-92,24}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-98,-24},{-78,-4}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=-20,
      duration=20000,
      offset=273.15,
      startTime=0) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-66,66})));
  equation
    connect(cHPControlBus, modularCHP.cHPControlBus) annotation (Line(
        points={{-66,14},{-20,14},{-20,6.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(heater.port, vol.heatPort)
      annotation (Line(points={{32,42},{32,16},{46,16}}, color={191,0,0}));
    connect(sine.y, heater.Q_flow)
      annotation (Line(points={{-13,72},{32,72},{32,62}}, color={0,0,127}));
    connect(temperatureSensor.port, vol.heatPort)
      annotation (Line(points={{58,-14},{46,-14},{46,16}}, color={191,0,0}));
    connect(modularCHP.port_b, vol.ports[1]) annotation (Line(points={{-4,-4},{
            26,-4},{26,6},{54,6}}, color={0,127,255}));
    connect(vol.ports[2], pipe.port_a) annotation (Line(points={{58,6},{56,6},{
            56,-30},{38,-30}}, color={0,127,255}));
    connect(pipe.port_b, modularCHP.port_a) annotation (Line(points={{16,-30},{
            -36,-30},{-36,-4},{-24,-4}}, color={0,127,255}));
    connect(bou.ports[1], modularCHP.port_a) annotation (Line(points={{-14,-44},
            {-30,-44},{-30,-4},{-24,-4}}, color={0,127,255}));
    connect(isOn.y, cHPControlBus.isOn) annotation (Line(points={{-77,-14},{
            -65.9,-14},{-65.9,14.1}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(PLR.y, cHPControlBus.PLR) annotation (Line(points={{-91.4,14},{-78,
            14},{-78,14},{-66,14}},       color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ramp.y, cHPControlBus.Tamb) annotation (Line(points={{-66,55},{
            -65.9,55},{-65.9,14.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=5000));
  end CHPFlowTemperature;

  model CHPSimpleTwoPositionBufferStorage

     replaceable package Medium =
       Modelica.Media.Water.ConstantPropertyLiquidWater
       constrainedby Modelica.Media.Interfaces.PartialMedium;

         parameter Modelica.SIunits.VolumeFlowRate V_flow_nominal=m_flow_nominal/Medium.d_const;
            parameter Modelica.SIunits.PressureDifference dp_nominal=7.143*10^8*exp(-0.007078*QNom/1000)*(V_flow_nominal)^2;
              parameter Modelica.SIunits.HeatFlowRate QNom=modularCHP.QNom "Thermal dimension power";
              parameter Modelica.SIunits.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
               parameter Modelica.SIunits.TemperatureDifference dTWaterNom=20 "Temperature difference nominal";
               parameter Modelica.SIunits.Time t=60*60 "Time until the buffer storage is fully loaded" annotation(Dialog(enable= advancedVolume, group="Control"));
       parameter Modelica.SIunits.Density rhoW=997 "Density of water";
       parameter Modelica.SIunits.HeatCapacity cW=4180 "Heat Capacity of water";
       parameter Modelica.SIunits.TemperatureDifference dT=20;
       parameter Real l=1.73 "Relation between height and diameter of the buffer storage" annotation(Dialog(group="Control"));
        parameter Modelica.SIunits.Height hTank=(QNom*t*1.73^2/( Modelica.Constants.pi/4*rhoW*cW*dT))^(1/3) annotation(Evaluate=true, Dialog(group="Control"));
       parameter Modelica.SIunits.Diameter dTank=hTank/1.73 annotation(Evaluate=true, Dialog(group="Control"));
       parameter Modelica.SIunits.Height hUpperPortDemand=hTank - 0.1;
       parameter Modelica.SIunits.Height hUpperPortSupply=hTank - 0.1;


       //Consumer pump parametrizing
       parameter Modelica.SIunits.VolumeFlowRate V_flow_nominalC1=m_flow_nominalC1/Medium.d_const;
       parameter Modelica.SIunits.MassFlowRate m_flow_nominalC1=abs(sine.offset+sine.amplitude)/(Medium.cp_const*dTWaterNom);
        parameter Modelica.SIunits.VolumeFlowRate V_flow_nominalC2=m_flow_nominalC2/Medium.d_const;
         parameter Modelica.SIunits.MassFlowRate m_flow_nominalC2=abs(sine1.offset+sine1.amplitude)/(Medium.cp_const*dTWaterNom);

    ModularCHP modularCHP(
      PelNom(displayUnit="kW") = 100000,
      use_advancedControl=true,
      TVar=false,
      bandwidth=4,
      Tref=358.15,
      severalHeatcurcuits=true,
      simpleTwoPosition=true) annotation (Placement(transformation(extent={{-26,-12},{-6,8}})));
    AixLib.Controls.Interfaces.CHPControlBus cHPControlBus
      annotation (Placement(transformation(extent={{-86,-6},{-46,34}})));

    AixLib.Fluid.MixingVolumes.MixingVolume vol(
      T_start=293.15,
      m_flow_nominal=1,
      redeclare package Medium = AixLib.Media.Water,
      V=3,
      nPorts=3)
      annotation (Placement(transformation(extent={{34,28},{54,48}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-16,58})));
    Modelica.Blocks.Sources.Sine sine(
      amplitude=-30000,
      freqHz=1/3600,
      offset=-30000)
      annotation (Placement(transformation(extent={{-56,66},{-36,86}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
      annotation (Placement(transformation(extent={{56,-4},{76,16}})));
    AixLib.Fluid.Sources.Boundary_pT
                        bou(
      use_T_in=false,
      redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
      annotation (Placement(transformation(extent={{86,18},{66,38}})));
    Modelica.Blocks.Sources.RealExpression PLR(y=1)
      annotation (Placement(transformation(extent={{-104,4},{-92,24}})));
    Modelica.Blocks.Sources.BooleanExpression isOn(y=true)
      annotation (Placement(transformation(extent={{-98,-24},{-78,-4}})));
    twoPositionController.ModularBufferStorage modularBufferStorage(
      QNom=QNom,
      dTWaterNom=modularBoiler_Controller.dTWaterNom,
      t(displayUnit="min") = 3600,
      hTank=2.4,
      dTank=1.2,
      advancedVolume=false,
      n=10,
      x=9,
      m2_flow_nominal=abs(sine.offset + sine.amplitude + sine1.offset + sine1.amplitude)
          /(Medium.cp_const*dTWaterNom))
           annotation (Placement(transformation(extent={{6,-38},{26,-18}})));
    AixLib.Fluid.Movers.SpeedControlled_y fan1(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_small=0.001,
      per(pressure(V_flow={0,V_flow_nominalC1,2*V_flow_nominalC1}, dp={dp_nominal/
              0.8,dp_nominal,0})),
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{68,-42},{48,-22}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=0.5)
      annotation (Placement(transformation(extent={{80,-20},{66,-6}})));
    AixLib.Fluid.MixingVolumes.MixingVolume vol1(
      redeclare package Medium = AixLib.Media.Water,
      m_flow_nominal=1,
      V=3,
      nPorts=2)
      annotation (Placement(transformation(extent={{30,-78},{46,-62}})));
    AixLib.Fluid.Movers.SpeedControlled_y fan2(
      redeclare package Medium = AixLib.Media.Water,
      allowFlowReversal=false,
      m_flow_small=0.001,
      per(pressure(V_flow={0,V_flow_nominalC2,2*V_flow_nominalC2}, dp={dp_nominal/
              0.8,dp_nominal,0})),
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{-2,-94},{-18,-78}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater1
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=-90,
          origin={11,-61})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
      annotation (Placement(transformation(extent={{46,-98},{60,-84}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=0.5)
      annotation (Placement(transformation(extent={{4,-70},{-10,-56}})));
  equation
    connect(cHPControlBus, modularCHP.cHPControlBus) annotation (Line(
        points={{-66,14},{-22,14},{-22,8.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(heater.port, vol.heatPort)
      annotation (Line(points={{-16,48},{-16,38},{34,38}},
                                                         color={191,0,0}));
    connect(sine.y, heater.Q_flow)
      annotation (Line(points={{-35,76},{-16,76},{-16,68}},
                                                          color={0,0,127}));
    connect(temperatureSensor.port, vol.heatPort)
      annotation (Line(points={{56,6},{34,6},{34,38}},     color={191,0,0}));
    connect(isOn.y, cHPControlBus.isOn) annotation (Line(points={{-77,-14},{
            -65.9,-14},{-65.9,14.1}}, color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(PLR.y, cHPControlBus.PLR) annotation (Line(points={{-91.4,14},{-78,14},
            {-78,14},{-66,14}},           color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(bou.ports[1], vol.ports[1])
      annotation (Line(points={{66,28},{41.3333,28}}, color={0,127,255}));
    connect(modularBufferStorage.TLayer, modularCHP.TCon) annotation (Line(points=
           {{5,-23},{0,-23},{0,16},{-17,16},{-17,8.2}}, color={0,0,127}));
    connect(modularCHP.port_b, modularBufferStorage.fluidportTop1)
      annotation (Line(points={{-6,-2},{22,-2},{22,-18}}, color={0,127,255}));
    connect(modularBufferStorage.fluidportTop2, vol.ports[2])
      annotation (Line(points={{10,-18},{10,28},{44,28}}, color={0,127,255}));
    connect(vol.ports[3], fan1.port_a) annotation (Line(points={{46.6667,28},{
            48,28},{48,-8},{80,-8},{80,-32},{68,-32}},
                                                color={0,127,255}));
    connect(realExpression.y, fan1.y)
      annotation (Line(points={{65.3,-13},{58,-13},{58,-20}}, color={0,0,127}));
    connect(fan1.port_b, modularBufferStorage.fluidportBottom2) annotation (Line(
          points={{48,-32},{34,-32},{34,-42},{10,-42},{10,-38}}, color={0,127,255}));
    connect(modularBufferStorage.fluidportBottom1, modularCHP.port_a) annotation (
       Line(points={{22,-38},{22,-48},{-40,-48},{-40,-2},{-26,-2}}, color={0,127,255}));
    connect(heater1.port, vol1.heatPort) annotation (Line(points={{11,-68},{10,-68},
            {10,-70},{30,-70}}, color={191,0,0}));
    connect(temperatureSensor1.port, vol1.heatPort) annotation (Line(points={{46,-91},
            {38,-91},{38,-90},{30,-90},{30,-70}}, color={191,0,0}));
    connect(modularBufferStorage.fluidportTop2, vol1.ports[1]) annotation (Line(
          points={{10,-18},{10,-10},{42,-10},{42,-58},{52,-58},{52,-78},{36.4,-78}},
          color={0,127,255}));
    connect(vol1.ports[2], fan2.port_a) annotation (Line(points={{39.6,-78},{36,-78},
            {36,-86},{-2,-86}}, color={0,127,255}));
    connect(realExpression1.y, fan2.y) annotation (Line(points={{-10.7,-63},{-14,-63},
            {-14,-70},{-10,-70},{-10,-76.4}}, color={0,0,127}));
    connect(fan2.port_b, modularBufferStorage.fluidportBottom2) annotation (Line(
          points={{-18,-86},{-24,-86},{-24,-84},{-30,-84},{-30,-42},{10,-42},{10,-38}},
          color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=5000));
  end CHPSimpleTwoPositionBufferStorage;
end Examples;
