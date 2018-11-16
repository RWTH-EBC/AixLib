within AixLib.Fluid.HeatExchangers;
package BasicHX
  model BasicHXnew "Simple heat exchanger model"
    extends AixLib.Fluid.Interfaces.PartialFourPort( redeclare final package
        Medium2 =
          MediumWater,                                                                                     redeclare
        final package Medium1 = MediumAir);

    //General
    parameter Integer nNodes(min=1) = 2 "Spatial segmentation";
    replaceable package MediumAir=AixLib.Media.Air constrainedby
      Modelica.Media.Interfaces.PartialMedium "Fluid Air" annotation(choicesAllMatching, Dialog(tab="General",group="Fluid Air"));
    replaceable package MediumWater = Modelica.Media.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialMedium "Fluid Water"  annotation(choicesAllMatching,Dialog(tab="General", group="Fluid Water"));

    parameter Modelica.SIunits.PressureDifference dp_nom_Air = 66 "Nominal Pressure drop of Medium Air in Pa" annotation (ialog(tab="General", group="Nominal Parameters"));
    parameter Modelica.SIunits.PressureDifference dp_nom_Water = 6000 "Nominal Pressure drop of Medium Water in Pa" annotation (Dialog(tab="General", group="Nominal Parameters"));

    parameter Modelica.SIunits.MassFlowRate m_flow_nom_Air = 3000/3600*1.2 "nominal mass flow rate in kg/s medium Air" annotation (Dialog(tab="General", group="Nominal Parameters"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nom_Water = 2.866/3600*1000 "nominal mass flow rate in kg/s of medium Water" annotation (Dialog(tab="General", group="Nominal Parameters"));

    parameter Modelica.SIunits.Volume volume_Air = 0.5 "nominal mass flow rate in kg/s medium Air" annotation (Dialog(tab="General", group="Parameters"));
    parameter Modelica.SIunits.Volume volume_Water = 0.02 "nominal mass flow rate in kg/s of medium Water" annotation (Dialog(tab="General", group="Parameters"));

    parameter Modelica.SIunits.HeatCapacity C_wall_Water=1000
      "Heat capacity of wall material 1"
      annotation (Dialog(tab="General", group="Wall properties"));
        parameter Modelica.SIunits.HeatCapacity C_wall_Air=1000
      "Heat capacity of wall material 2"
      annotation (Dialog(tab="General", group="Wall properties"));
    parameter Modelica.SIunits.ThermalConductance Gc = 1200 "Thermal conductivity of wall material" annotation(Dialog(tab="General", group="Wall properties"));

    // Assumptions
    parameter Boolean allowFlowReversal = true
      "allow flow reversal, false restricts to design direction (port_a -> port_b)"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);

    //Initialization pipe 1
    parameter Boolean use_T_start=true
      "Use T_start if true, otherwise h_start"
      annotation(Evaluate=true, Dialog(tab = "Initialization"));
    parameter MediumAir.AbsolutePressure p_a_start_Air=MediumAir.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Fluid Air"));
    parameter MediumAir.AbsolutePressure p_b_start_Air=MediumAir.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Fluid Air"));
    parameter MediumAir.Temperature T_start_Air=if use_T_start then MediumAir.
        T_default else MediumAir.temperature_phX(
          (p_a_start_Air + p_b_start_Air)/2,
          h_start_Air,
          X_start_Air) "Start value of temperature"
      annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Air", enable = use_T_start));
    parameter MediumAir.SpecificEnthalpy h_start_Air=if use_T_start then MediumAir.specificEnthalpy_pTX(
          (p_a_start_Air + p_b_start_Air)/2,
          T_start_Air,
          X_start_Air) else MediumAir.h_default
      "Start value of specific enthalpy"
      annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Air", enable = not use_T_start));
    parameter MediumAir.MassFraction X_start_Air[MediumAir.nX]=MediumAir.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Fluid Air", enable=(MediumAir.nXi > 0)));
    parameter MediumAir.MassFlowRate m_flow_start_Air = m_flow_nom_Air
      "Start value of mass flow rate" annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Air"));
    //Initialization pipe Water

    parameter MediumWater.AbsolutePressure p_a_startWater=MediumWater.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Fluid Water"));
    parameter MediumWater.AbsolutePressure p_b_startWater=MediumWater.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Fluid Water"));
    parameter MediumWater.Temperature T_start_Water=if use_T_start then MediumWater.
        T_default else MediumWater.temperature_phX(
          (p_a_startWater + p_b_startWater)/2,
          h_start_Water,
          X_start_Water) "Start value of temperature"
      annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Water", enable = use_T_start));
    parameter MediumWater.SpecificEnthalpy h_start_Water=if use_T_start then MediumWater.specificEnthalpy_pTX(
          (p_a_startWater + p_b_startWater)/2,
          T_start_Water,
          X_start_Water) else MediumWater.h_default
      "Start value of specific enthalpy"
      annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Water", enable = not use_T_start));
    parameter MediumWater.MassFraction X_start_Water[MediumWater.nX]=MediumWater.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Fluid Water", enable=MediumWater.nXi>0));
    parameter MediumWater.MassFlowRate m_flow_start_Water = m_flow_nom_Water
      "Start value of mass flow rate"    annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Water"));

    //Display variables
    Modelica.SIunits.HeatFlowRate Q_flow_Water "Total heat flow rate of pipe Air";
    Modelica.SIunits.HeatFlowRate Q_flow_Air "Total heat flow rate of pipe Water";

    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitorWater[nNodes](
        each C=C_wall_Water/nNodes, each T(start=T_start_Water)) annotation (
        Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=270,
          origin={14,-26})));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitorAir[nNodes](each C=
          C_wall_Air/nNodes, each T(start=T_start_Air))
                       annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=270,
          origin={18,58})));
    AixLib.Fluid.FixedResistances.PressureDrop resWater(
      redeclare package Medium = MediumWater,
      final allowFlowReversal=allowFlowReversal,
      final m_flow_nominal=m_flow_nom_Water,
      final dp_nominal=dp_nom_Water)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={74,-60})));
    AixLib.Fluid.FixedResistances.PressureDrop resAir(
      redeclare package Medium = MediumAir,
      final m_flow_nominal=m_flow_nom_Air,
      final dp_nominal=dp_nom_Air) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-70,60})));
    AixLib.Fluid.MixingVolumes.MixingVolumeMoistAir volAir[nNodes](
      final allowFlowReversal=allowFlowReversal, nPorts=2,
      final m_flow_nominal=m_flow_nom_Air,
      V=volume_Air,
      redeclare package Medium = MediumAir)
      annotation (Placement(transformation(extent={{-14,72},{6,92}})));
    AixLib.Fluid.MixingVolumes.MixingVolume volWater[nNodes](final allowFlowReversal=
          allowFlowReversal, nPorts=2,
      m_flow_nominal=m_flow_nom_Water,
      V=volume_Water,
      redeclare package Medium = MediumWater)
      annotation (Placement(transformation(extent={{-18,-60},{2,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression[nNodes]
      annotation (Placement(transformation(extent={{-60,78},{-40,98}})));
    Modelica.Thermal.HeatTransfer.Components.Convection convection [nNodes]       annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-6,14})));
    Modelica.Blocks.Sources.RealExpression realExpression1
                                                         [nNodes](y=Gc)
      annotation (Placement(transformation(extent={{-68,4},{-48,24}})));
  equation
    Q_flow_Air = sum(volAir.heatPort.Q_flow);
    Q_flow_Water = sum(volWater.heatPort.Q_flow);
    connect(volAir.heatPort, heatCapacitorAir.port) annotation (Line(points={{-14,82},
            {-18,82},{-18,58},{8,58}}, color={191,0,0}));
    connect(volWater.heatPort, heatCapacitorWater.port) annotation (Line(points={{-18,-50},
            {-24,-50},{-24,-26},{6,-26}},           color={191,0,0}));

    connect(port_a1, resAir.port_a)
      annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
    connect(resWater.port_a, port_a2)
      annotation (Line(points={{84,-60},{100,-60}}, color={0,127,255}));
    connect(resWater.port_b, volWater[1].ports[1])
      annotation (Line(points={{64,-60},{-10,-60}},color={0,127,255}));
    connect(resAir.port_b, volAir[1].ports[1]) annotation (Line(points={{-60,60},{
            -34,60},{-34,72},{-6,72}},
                                   color={0,127,255}));
    connect(volAir[nNodes].ports[2], port_b1) annotation (Line(points={{-2,72},{48,72},{48,
            60},{100,60}}, color={0,127,255}));
    connect(volWater[nNodes].ports[2], port_b2)
      annotation (Line(points={{-6,-60},{-100,-60}}, color={0,127,255}));
    for i in 1:nNodes-1 loop
      connect(volAir[i].ports[2],volAir[i+1].ports[1]);
      connect(volWater[i].ports[2],volWater[i+1].ports[1]);
    end for;
    connect(realExpression.y, volAir.mWat_flow) annotation (Line(points={{-39,
            88},{-28,88},{-28,90},{-16,90}}, color={0,0,127}));
    connect(convection.solid, heatCapacitorWater.port) annotation (Line(points={{-6,
            4},{-6,4},{-6,-26},{6,-26}}, color={191,0,0}));
    connect(heatCapacitorAir.port, convection.fluid)
      annotation (Line(points={{8,58},{2,58},{2,24},{-6,24}},  color={191,0,0}));
    connect(realExpression1.y, convection.Gc)
      annotation (Line(points={{-47,14},{-16,14}}, color={0,0,127}));
    annotation (   Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,-26},{100,-30}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-100,30},{100,26}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-100,60},{100,30}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,63,125}),
          Rectangle(
            extent={{-100,-30},{100,-60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,63,125}),
          Rectangle(
            extent={{-100,26},{100,-26}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,128,255}),
          Line(
            points={{64,-85},{-26,-85}},
            color={0,128,255}),
          Polygon(
            points={{-20,15},{20,0},{-20,-15},{-20,15}},
            lineColor={0,128,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            origin={-46,-85},
            rotation=180),
          Line(
            points={{22,77},{-68,77}},
            color={0,128,255}),
          Polygon(
            points={{20,15},{-20,0},{20,-15},{20,15}},
            lineColor={0,128,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            origin={42,77},
            rotation=180),
          Text(
            extent={{-54,106},{6,82}},
            lineColor={28,108,200},
            textString="Air"),
          Text(
            extent={{-18,-88},{44,-106}},
            lineColor={28,108,200},
            textString="Water")}),
      Documentation(info="<html>
<p>Simple model of a heat exchanger consisting of two pipes and one wall in between.
For both fluids geometry parameters, such as heat transfer area and cross section as well as heat transfer and pressure drop correlations may be chosen.
The flow scheme may be concurrent or counterflow, defined by the respective flow directions of the fluids entering the component.
The design flow direction with positive m_flow variables is counterflow.</p>
</html>"));
  end BasicHXnew;

  model BasicHX "Simple heat exchanger model"
    extends AixLib.Fluid.Interfaces.PartialFourPort( redeclare final package
        Medium2 =
          MediumWater,                                                                                     redeclare
        final package Medium1 =                                                                                                              MediumAir);

    //General
    parameter Integer nNodes(min=1) = 2 "Spatial segmentation";
    replaceable package MediumWater = Modelica.Media.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialMedium "Fluid Air" annotation(choicesAllMatching, Dialog(tab="General",group="Fluid Air"));
    replaceable package MediumAir = Modelica.Media.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialMedium "Fluid Water"  annotation(choicesAllMatching,Dialog(tab="General", group="Fluid Water"));

    parameter Modelica.SIunits.PressureDifference dp_nom_Air = 66 "Nominal Pressure drop of Medium Air in Pa" annotation (Dialog(tab="General", group="Nominal Parameters"));
    parameter Modelica.SIunits.PressureDifference dp_nom_Water = 6000 "Nominal Pressure drop of Medium Water in Pa" annotation (Dialog(tab="General", group="Nominal Parameters"));

    parameter Modelica.SIunits.TemperatureDifference dT_mean_nom = 50 "Mean of Temperature difference between medium Air and Water" annotation (Dialog(tab="General", group="Nominal Parameters"));
    parameter Modelica.SIunits.HeatFlowRate Q_nom = 57700 "Nominal heating power" annotation (Dialog(tab="General", group="Nominal Parameters"));

    parameter Modelica.SIunits.MassFlowRate m_flow_nom_Air = 3000/3600*1.2 "nominal mass flow rate in kg/s medium Air" annotation (Dialog(tab="General", group="Nominal Parameters"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nom_Water = 2.866/3600*1000 "nominal mass flow rate in kg/s of medium Water" annotation (Dialog(tab="General", group="Nominal Parameters"));

    parameter Modelica.SIunits.Volume volume_Air = 0.5 "nominal mass flow rate in kg/s medium Air" annotation (Dialog(tab="General", group="Parameters"));
    parameter Modelica.SIunits.Volume volume_Water = 0.02 "nominal mass flow rate in kg/s of medium Water" annotation (Dialog(tab="General", group="Parameters"));

    parameter Modelica.SIunits.ThermalConductance G = Q_nom/dT_mean_nom
      "Thermal conductivity of wall material"
      annotation (Dialog(group="Wall properties"));
    parameter Modelica.SIunits.HeatCapacity C_wall_Water=1000
      "Heat capacity of wall material 1"
      annotation (Dialog(tab="General", group="Wall properties"));
        parameter Modelica.SIunits.HeatCapacity C_wall_Air=1000
      "Heat capacity of wall material 2"
      annotation (Dialog(tab="General", group="Wall properties"));

    // Assumptions
    parameter Boolean allowFlowReversal = true
      "allow flow reversal, false restricts to design direction (port_a -> port_b)"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);

    //Initialization pipe 1
    parameter Boolean use_T_start=true
      "Use T_start if true, otherwise h_start"
      annotation(Evaluate=true, Dialog(tab = "Initialization"));
    parameter MediumAir.AbsolutePressure p_a_start_Air=MediumAir.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Fluid Air"));
    parameter MediumAir.AbsolutePressure p_b_start_Air=MediumAir.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Fluid Air"));
    parameter MediumAir.Temperature T_start_Air=if use_T_start then MediumAir.
        T_default else MediumAir.temperature_phX(
          (p_a_start_Air + p_b_start_Air)/2,
          h_start_Air,
          X_start_Air) "Start value of temperature"
      annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Air", enable = use_T_start));
    parameter MediumAir.SpecificEnthalpy h_start_Air=if use_T_start then MediumAir.specificEnthalpy_pTX(
          (p_a_start_Air + p_b_start_Air)/2,
          T_start_Air,
          X_start_Air) else MediumAir.h_default
      "Start value of specific enthalpy"
      annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Air", enable = not use_T_start));
    parameter MediumAir.MassFraction X_start_Air[MediumAir.nX]=MediumAir.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Fluid Air", enable=(MediumAir.nXi > 0)));
    parameter MediumAir.MassFlowRate m_flow_start_Air = m_flow_nom_Air
      "Start value of mass flow rate" annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Air"));
    //Initialization pipe Water

    parameter MediumWater.AbsolutePressure p_a_startWater=MediumWater.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Fluid Water"));
    parameter MediumWater.AbsolutePressure p_b_startWater=MediumWater.p_default
      "Start value of pressure"
      annotation(Dialog(tab = "Initialization", group = "Fluid Water"));
    parameter MediumWater.Temperature T_start_Water=if use_T_start then MediumWater.
        T_default else MediumWater.temperature_phX(
          (p_a_startWater + p_b_startWater)/2,
          h_start_Water,
          X_start_Water) "Start value of temperature"
      annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Water", enable = use_T_start));
    parameter MediumWater.SpecificEnthalpy h_start_Water=if use_T_start then MediumWater.specificEnthalpy_pTX(
          (p_a_startWater + p_b_startWater)/2,
          T_start_Water,
          X_start_Water) else MediumWater.h_default
      "Start value of specific enthalpy"
      annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Water", enable = not use_T_start));
    parameter MediumWater.MassFraction X_start_Water[MediumWater.nX]=MediumWater.X_default
      "Start value of mass fractions m_i/m"
      annotation (Dialog(tab="Initialization", group = "Fluid Water", enable=MediumWater.nXi>0));
    parameter MediumWater.MassFlowRate m_flow_start_Water = m_flow_nom_Water
      "Start value of mass flow rate"    annotation(Evaluate=true, Dialog(tab = "Initialization", group = "Fluid Water"));

    //Display variables
    Modelica.SIunits.HeatFlowRate Q_flow_Water "Total heat flow rate of pipe Air";
    Modelica.SIunits.HeatFlowRate Q_flow_Air "Total heat flow rate of pipe Water";

    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitorWater[nNodes](
        each C=C_wall_Water/nNodes, each T(start=T_start_Water)) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={12,-18})));
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitorAir[nNodes](each C=
          C_wall_Air/nNodes, each T(start=T_start_Air))
                       annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={14,30})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[
      nNodes](each G=G/nNodes)      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-16,10})));
    AixLib.Fluid.FixedResistances.PressureDrop resWater(
      redeclare package Medium = MediumWater,
      allowFlowReversal=allowFlowReversal,
      m_flow_nominal=m_flow_nom_Water,
      dp_nominal=dp_nom_Water)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=180,
          origin={74,-60})));
    AixLib.Fluid.FixedResistances.PressureDrop resAir(
      redeclare package Medium = MediumAir,
      m_flow_nominal=m_flow_nom_Air,
      dp_nominal=dp_nom_Air) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-70,60})));
    AixLib.Fluid.MixingVolumes.MixingVolume         volAir[nNodes](
                                             nPorts=2,
      m_flow_nominal=m_flow_nom_Air,
      redeclare package Medium = MediumAir,
      T_start=T_start_Air,
      V=volume_Air/nNodes,
      energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
      annotation (Placement(transformation(extent={{-14,72},{6,92}})));
    AixLib.Fluid.MixingVolumes.MixingVolume volWater[nNodes](allowFlowReversal=
          allowFlowReversal, nPorts=2,
      m_flow_nominal=m_flow_nom_Water,
      redeclare package Medium = MediumWater,
      T_start=T_start_Water,
      V=volume_Water/nNodes)
      annotation (Placement(transformation(extent={{-18,-60},{2,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression[nNodes]
      annotation (Placement(transformation(extent={{-60,78},{-40,98}})));
  equation
    Q_flow_Air = sum(volAir.heatPort.Q_flow);
    Q_flow_Water = sum(volWater.heatPort.Q_flow);
    connect(thermalConductor.port_b, heatCapacitorAir.port) annotation (Line(points={{-16,20},
            {-8,20},{-8,30},{4,30}},          color={191,0,0}));
    connect(thermalConductor.port_a, heatCapacitorWater.port) annotation (Line(
          points={{-16,0},{-8,0},{-8,-18},{2,-18}}, color={191,0,0}));
    connect(volAir.heatPort, heatCapacitorAir.port) annotation (Line(points={{-14,82},
            {-20,82},{-20,30},{4,30}}, color={191,0,0}));
    connect(volWater.heatPort, heatCapacitorWater.port) annotation (Line(points=
           {{-18,-50},{-24,-50},{-24,-18},{2,-18}}, color={191,0,0}));

    connect(port_a1, resAir.port_a)
      annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
    connect(resWater.port_a, port_a2)
      annotation (Line(points={{84,-60},{100,-60}}, color={0,127,255}));
    connect(resWater.port_b, volWater[1].ports[1])
      annotation (Line(points={{64,-60},{-10,-60}},color={0,127,255}));
    connect(resAir.port_b, volAir[1].ports[1]) annotation (Line(points={{-60,60},{
            -34,60},{-34,72},{-6,72}},
                                   color={0,127,255}));
    connect(volAir[nNodes].ports[2], port_b1) annotation (Line(points={{-2,72},{48,72},{48,
            60},{100,60}}, color={0,127,255}));
    connect(volWater[nNodes].ports[2], port_b2)
      annotation (Line(points={{-6,-60},{-100,-60}}, color={0,127,255}));
    for i in 1:nNodes-1 loop
      connect(volAir[i].ports[2],volAir[i+1].ports[1]);
      connect(volWater[i].ports[2],volWater[i+1].ports[1]);
    end for;
    annotation (   Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,-26},{100,-30}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-100,30},{100,26}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Forward),
          Rectangle(
            extent={{-100,60},{100,30}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,63,125}),
          Rectangle(
            extent={{-100,-30},{100,-60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,63,125}),
          Rectangle(
            extent={{-100,26},{100,-26}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,128,255}),
          Text(
            extent={{-150,110},{150,70}},
            lineColor={0,0,255},
            textString="%name"),
          Line(
            points={{30,-85},{-60,-85}},
            color={0,128,255}),
          Polygon(
            points={{20,-70},{60,-85},{20,-100},{20,-70}},
            lineColor={0,128,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{30,77},{-60,77}},
            color={0,128,255}),
          Polygon(
            points={{-50,92},{-90,77},{-50,62},{-50,92}},
            lineColor={0,128,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<p>Simple model of a heat exchanger consisting of two pipes and one wall in between.
For both fluids geometry parameters, such as heat transfer area and cross section as well as heat transfer and pressure drop correlations may be chosen.
The flow scheme may be concurrent or counterflow, defined by the respective flow directions of the fluids entering the component.
The design flow direction with positive m_flow variables is counterflow.</p>
</html>"));
  end BasicHX;
  annotation (
    conversion(noneFromVersion=""));
end BasicHX;
