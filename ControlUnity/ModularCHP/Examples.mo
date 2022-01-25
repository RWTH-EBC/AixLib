within ControlUnity.ModularCHP;
package Examples
  model CHP

    ModularCHP modularCHP(
      PelNom(displayUnit="kW") = 100000,
      use_advancedControl=false,
      TVar=false,
      bandwidth=2.5,
      Tref=353.15,
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
      offset=-50000)
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
            14},{-78,14.1},{-65.9,14.1}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=5000));
  end CHP;
end Examples;
