within AixLib.Fluid.HeatPumps.ModularHeatPumps.SimpleHeatPumps;
package MyModels
  model S1_Condensation
    "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;


    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 343.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-25)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of subcomponents
    //
    Sources.MassFlowSource_T sourceHP(
      redeclare package Medium = MediumHP,
      m_flow=m_flow_source_HP,
      T=TSouHP,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{60,20},{40,40}})));
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSouHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-70,30})));

    HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers.SimpleCondenser
      simpleCondenser(redeclare package Medium2 = MediumHP,
      typHX=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.TypeHX.CounterCurrent,
      useFixModCV=true,
      modCVPar=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.ModeCV.SH,
      redeclare package Medium1 = MediumCO,
      m_flow_nominalPri=0.05,
      pIni=pSouHP,
      geoCV(nFloCha=20),
      TSCIniWal=318.15,
      TTPIniWal=318.15,
      TSHIniWal=318.15,
      TSCIniSec=306.15,
      TTPIniSec=306.15,
      TSHIniSec=306.15)
      annotation (Placement(transformation(extent={{-10,26},{10,46}})));

    Sources.MassFlowSource_T sourceCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={80,80})));
  equation
    // Connection of main components
    //

    connect(sourceHP.ports[1], simpleCondenser.port_a2)
      annotation (Line(points={{40,30},{25,30},{10,30}}, color={0,127,255}));
    connect(simpleCondenser.port_b2, sinkHP.ports[1])
      annotation (Line(points={{-10,30},{-35,30},{-60,30}}, color={0,127,255}));
    connect(sourceCO.ports[1], simpleCondenser.port_a1) annotation (Line(points={{
            -68,80},{-54,80},{-40,80},{-40,42},{-10,42}}, color={0,127,255}));
    connect(sinkCO.ports[1], simpleCondenser.port_b1) annotation (Line(points={{70,
            80},{50,80},{20,80},{20,42},{10,42}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S1_Condensation;

  model S2_Compressor
    "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R134aCoolProp
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);

    // Definition of subcomponents
    //
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      nPorts=1,
      p=pSinHP) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-70,48})));

    HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers.SimpleCondenser
      simpleCondenser(redeclare package Medium2 = MediumHP,
      typHX=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.TypeHX.CounterCurrent,
      useFixModCV=true,
      modCVPar=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.ModeCV.SH,
      redeclare package Medium1 = MediumCO,
      m_flow_nominalPri=0.05,
      pIni=pSouHP,
      geoCV(nFloCha=20),
      TSCIniWal=318.15,
      TTPIniWal=318.15,
      TSHIniWal=318.15,
      TSCIniSec=306.15,
      TTPIniSec=306.15,
      TSHIniSec=306.15)
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={80,80})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      risTim={5},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true)
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Sources.Boundary_pT sourceHP(
      redeclare package Medium = MediumHP,
      nPorts=1,
      T=TSouHP,
      p=pSouHP) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-50})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,70},{-18,90}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,70},{-42,90}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,70},{36,90}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repMea1(nout=1)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    // Connection of main components
    //

    connect(simpleCondenser.port_b2, sinkHP.ports[1])
      annotation (Line(points={{-10,68},{-35,48},{-60,48}}, color={0,127,255}));
    connect(simpleCondenser.port_a2, modCom.port_b)
      annotation (Line(points={{10,68},{50,68},{50,20}}, color={0,127,255}));
    connect(sourceHP.ports[1], modCom.port_a)
      annotation (Line(points={{50,-40},{50,-20}}, color={0,127,255}));
    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(senSpeEntInl.port_b, simpleCondenser.port_a1)
      annotation (Line(points={{-18,80},{-10,80}}, color={0,127,255}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,80},{-62,80}}, color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,80},{36,80}}, color={0,127,255}));
    connect(senSpeEntOut.port_a, simpleCondenser.port_b1)
      annotation (Line(points={{16,80},{10,80}}, color={0,127,255}));
    connect(setHeaCap.y, repMea1.u)
      annotation (Line(points={{20,39},{20,32}},
                                               color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repMea1.y, datBus.comBus.intSetPoiCom)
      annotation (Line(points={{20,9},{20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,
            0.05}},                                         color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Compressor;

  model S2_Compressor1 "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R134aCoolProp
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);

    // Definition of subcomponents
    //
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSinHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={-70,-50})));

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={80,80})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      risTim={5},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true)
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Sources.Boundary_pT sourceHP(
      redeclare package Medium = MediumHP,
      nPorts=1,
      T=TSouHP,
      p=pSouHP) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-50})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,70},{-18,90}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,70},{-42,90}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,70},{36,90}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,50})));
    Modelica.Blocks.Routing.Replicator repMea1(nout=1)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    HeatExchangers.ConstantEffectiveness con(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=0.25,
      m2_flow_nominal=0.025,
      dp1_nominal=0,
      dp2_nominal=0)
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
  equation
    // Connection of main components
    //

    connect(sourceHP.ports[1], modCom.port_a)
      annotation (Line(points={{50,-40},{50,-20}}, color={0,127,255}));
    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,80},{-62,80}}, color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,80},{36,80}}, color={0,127,255}));
    connect(setHeaCap.y, repMea1.u)
      annotation (Line(points={{0,39},{0,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{0,-39},{0,-32}}, color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{16,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{0,-9},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(repMea1.y, datBus.comBus.intSetPoiCom)
      annotation (Line(points={{0,9},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, con.port_a1) annotation (Line(points={{-18,80},
            {-14,80},{-10,80}}, color={0,127,255}));
    connect(con.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{16,80}}, color={0,127,255}));
    connect(con.port_a2, modCom.port_b)
      annotation (Line(points={{10,68},{50,68},{50,20}}, color={0,127,255}));
    connect(sinkHP.ports[1], con.port_b2) annotation (Line(points={{-70,-40},{
            -70,68},{-10,68}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Compressor1;

  model S2_Valve "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R134aCoolProp
      "Current medium of the heat pump";
    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);

    // Definition of subcomponents
    //
    Sources.Boundary_ph sinkHP(
      redeclare package Medium = MediumHP,
      p=pSinHP,
      nPorts=1) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={-50,-80})));

    HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers.SimpleCondenser
      simpleCondenser(redeclare package Medium2 = MediumHP,
      typHX=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.TypeHX.CounterCurrent,
      useFixModCV=true,
      modCVPar=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.ModeCV.SH,
      redeclare package Medium1 = MediumCO,
      m_flow_nominalPri=0.05,
      pIni=pSouHP,
      geoCV(nFloCha=20),
      TSCIniWal=318.15,
      TTPIniWal=318.15,
      TSHIniWal=318.15,
      TSCIniSec=306.15,
      TTPIniSec=306.15,
      TSHIniSec=306.15)
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={80,80})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      risTim={5},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true)
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Sources.Boundary_pT sourceHP(
      redeclare package Medium = MediumHP,
      nPorts=1,
      T=TSouHP,
      p=pSouHP) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=270,
          origin={50,-80})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,70},{-18,90}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,70},{-42,90}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,70},{36,90}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=false) annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(redeclare package Medium =
          MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.55)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
  equation
    // Connection of main components
    //

    connect(simpleCondenser.port_a2, modCom.port_b)
      annotation (Line(points={{10,68},{50,68},{50,20}}, color={0,127,255}));
    connect(sourceHP.ports[1], modCom.port_a)
      annotation (Line(points={{50,-70},{50,-36},{50,-20}},
                                                   color={0,127,255}));
    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(senSpeEntInl.port_b, simpleCondenser.port_a1)
      annotation (Line(points={{-18,80},{-10,80}}, color={0,127,255}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,80},{-62,80}}, color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,80},{36,80}}, color={0,127,255}));
    connect(senSpeEntOut.port_a, simpleCondenser.port_b1)
      annotation (Line(points={{16,80},{10,80}}, color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points=
           {{20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(simpleCondenser.port_b2, modExpVal.port_a) annotation (Line(points=
            {{-10,68},{-50,68},{-50,20}}, color={0,127,255}));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a) annotation (Line(
          points={{-50,-20},{-50,-25},{-50,-30}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, sinkHP.ports[1]) annotation (Line(points=
           {{-50,-50},{-50,-60},{-50,-70}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u) annotation (Line(points={{-20,39},{-20,35.5},
            {-20,32}}, color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points=
           {{-20,9},{-20,4},{0,4},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve;

  model S2_Valve11 "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Air
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 273.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 5
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));


    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={80,80})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      risTim={5},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false)
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,70},{-18,90}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,70},{-42,90}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,70},{36,90}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true)  annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(redeclare package Medium =
          MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.9)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
    WorkingVersion.Tank_pL tan(
      redeclare package Medium = MediumHP,
      impose_L=true,
      Vtot(displayUnit="l") = 0.004,
      pstart=3000000)
      annotation (Placement(transformation(extent={{-60,32},{-40,52}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV,
      dp1_nominal=1,
      dp2_nominal=1,
      m1_flow_small=1e-10,
      m2_flow_small=1e-10,
      homotopyInitialization=true)
                     "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{10,-64},{-10,-84}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-90},{68,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-80})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,80},{-62,80}}, color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,80},{36,80}}, color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a) annotation (Line(
          points={{-50,-20},{-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(condenser.port_b2, tan.InFlow) annotation (Line(points={{-10,68},{-50,
            68},{-50,50.4}}, color={0,127,255}));
    connect(tan.OutFlow, modExpVal.port_a)
      annotation (Line(points={{-50,33.2},{-50,20}}, color={0,0,255}));
    connect(portsAThroughPortB.port_b, evaporatpr.port_a2) annotation (Line(
          points={{-50,-50},{-50,-50},{-50,-68},{-10,-68}}, color={0,127,255}));
    connect(evaporatpr.port_b2, modCom.port_a)
      annotation (Line(points={{10,-68},{50,-68},{50,-20}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_a1)
      annotation (Line(points={{68,-80},{39,-80},{10,-80}}, color={0,127,255}));
    connect(sinkEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-70,-80},
            {-40,-80},{-10,-80}}, color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{
            -20,9},{-20,0.05},{0.05,0.05}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve11;

  model S2_Valve22 "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 288.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={80,80})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      risTim={5},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false)
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,70},{-18,90}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,70},{-42,90}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,70},{36,90}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      dp_start=1650000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(redeclare package Medium =
          MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.9)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      show_T=true,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV,
      dp1_nominal=1,
      dp2_nominal=1,
      m1_flow_small=1e-10,
      m2_flow_small=1e-10,
      homotopyInitialization=true,
      m2_flow_nominal=0.5*m_flow_nominal_HP,
      linearizeFlowResistance1=true,
      linearizeFlowResistance2=true)
                     "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{10,-64},{-10,-84}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-90},{68,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-80})));
    WorkingVersion.Tank tan(
      redeclare package Medium = MediumHP,
      Vtot(displayUnit="l") = 0.005,
      pstart=3000000,
      hstart=300e3,
      impose_pressure=true)
      annotation (Placement(transformation(extent={{-60,32},{-40,52}})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,80},{-62,80}}, color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,80},{36,80}}, color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a) annotation (Line(
          points={{-50,-20},{-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, evaporatpr.port_a2) annotation (Line(
          points={{-50,-50},{-50,-50},{-50,-68},{-10,-68}}, color={0,127,255}));
    connect(evaporatpr.port_b2, modCom.port_a)
      annotation (Line(points={{10,-68},{50,-68},{50,-20}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_a1)
      annotation (Line(points={{68,-80},{39,-80},{10,-80}}, color={0,127,255}));
    connect(sinkEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-70,-80},
            {-40,-80},{-10,-80}}, color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{
            -20,9},{-20,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(modExpVal.port_a, tan.OutFlow)
      annotation (Line(points={{-50,20},{-50,33.2}}, color={0,127,255}));
    connect(condenser.port_b2, tan.InFlow) annotation (Line(points={{-10,68},{-50,
            68},{-50,50.4}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve22;

  model S2_Valve23 "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 288.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={80,80})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      risTim={5},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false)
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,70},{-18,90}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,70},{-42,90}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,70},{36,90}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      dp_start=1650000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(redeclare package Medium =
          MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.9)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-90},{68,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-80})));
    WorkingVersion.Tank_pL tan(
      redeclare package Medium = MediumHP,
      Vtot(displayUnit="l") = 0.005,
      pstart=3000000,
      impose_L=true,
      impose_pressure=true)
      annotation (Placement(transformation(extent={{-60,32},{-40,52}})));
    HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers.SimpleEvaporator
      simpleEvaporator(
      redeclare package Medium1 = MediumEV,
      redeclare package Medium2 = MediumHP,
      useFixModCV=true,
      modCVPar=AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.Types.ModeCV.SC)
      annotation (Placement(transformation(extent={{10,-64},{-10,-84}})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,80},{-62,80}}, color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,80},{36,80}}, color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a) annotation (Line(
          points={{-50,-20},{-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{
            -20,9},{-20,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(modExpVal.port_a, tan.OutFlow)
      annotation (Line(points={{-50,20},{-50,33.2}}, color={0,127,255}));
    connect(condenser.port_b2, tan.InFlow) annotation (Line(points={{-10,68},{-50,
            68},{-50,50.4}}, color={0,127,255}));
    connect(simpleEvaporator.port_a2, portsAThroughPortB.port_b) annotation (Line(
          points={{-10,-68},{-22,-68},{-50,-68},{-50,-50}}, color={0,127,255}));
    connect(simpleEvaporator.port_b2, modCom.port_a)
      annotation (Line(points={{10,-68},{50,-68},{50,-20}}, color={0,127,255}));
    connect(sourceEV.ports[1], simpleEvaporator.port_a1)
      annotation (Line(points={{68,-80},{40,-80},{10,-80}}, color={0,127,255}));
    connect(simpleEvaporator.port_b1, sinkEV.ports[1]) annotation (Line(points={{-10,
            -80},{-40,-80},{-70,-80}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve23;

  model S2_Valve24 "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 288.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={80,80})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      risTim={5},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false)
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,70},{-18,90}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,70},{-42,90}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,70},{36,90}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      dp_start=1650000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB portsAThroughPortB(redeclare package Medium =
          MediumHP) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.9)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-90},{68,-70}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-80})));
    WorkingVersion.Tank_pL tan(
      redeclare package Medium = MediumHP,
      Vtot(displayUnit="l") = 0.005,
      pstart=3000000,
      impose_L=true,
      impose_pressure=true)
      annotation (Placement(transformation(extent={{-60,32},{-40,52}})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX basicHX(
      length=1,
      redeclare package Medium_1 = MediumEV,
      redeclare package Medium_2 = MediumHP,
      crossArea_1=1.76e-4,
      crossArea_2=1.2e-4,
      perimeter_1(displayUnit="mm") = 0.015,
      perimeter_2=17,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=2000),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=200),
      area_h_1=2,
      area_h_2=2.1,
      s_wall=0.002,
      k_wall=100,
      c_wall=450,
      rho_wall=8000,
      Twall_start=293.15,
      dT=283.15)
      annotation (Placement(transformation(extent={{10,-70},{-10,-90}})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,80},{-62,80}}, color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,80},{36,80}}, color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, portsAThroughPortB.ports_a) annotation (Line(
          points={{-50,-20},{-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{
            -20,9},{-20,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(modExpVal.port_a, tan.OutFlow)
      annotation (Line(points={{-50,20},{-50,33.2}}, color={0,127,255}));
    connect(condenser.port_b2, tan.InFlow) annotation (Line(points={{-10,68},{-50,
            68},{-50,50.4}}, color={0,127,255}));
    connect(portsAThroughPortB.port_b, basicHX.port_a2) annotation (Line(points={{
            -50,-50},{-50,-75.4},{-11,-75.4}}, color={0,127,255}));
    connect(basicHX.port_b1, sinkEV.ports[1]) annotation (Line(points={{-11,-79.8},
            {-39.5,-79.8},{-39.5,-80},{-70,-80}}, color={0,127,255}));
    connect(sourceEV.ports[1], basicHX.port_a1) annotation (Line(points={{68,-80},
            {11,-80},{11,-79.8}}, color={0,127,255}));
    connect(basicHX.port_b2, modCom.port_a) annotation (Line(points={{11,-84.6},{50,
            -84.6},{50,-20}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve24;

  model S2_Valve99 "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 5000
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);
    Modelica.SIunits.TemperatureDifference TSup = senTemOut.T-senTemInl.T;

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,98},{-68,78}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={80,88})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false,
      m_flow_start=0.05,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={15},
      k={0.1})   annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,90},{-18,70}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,90},{-42,70}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,90},{36,70}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      h_out_start=280e3,
      dp_start=2300000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB pasThr(redeclare package Medium = MediumHP)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.75)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0,
      eps=1)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      show_T=true,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV,
      dp1_nominal=1,
      dp2_nominal=1,
      homotopyInitialization=true,
      m2_flow_nominal=0.5*m_flow_nominal_HP,
      linearizeFlowResistance1=true,
      linearizeFlowResistance2=true,
      eps=1)         "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{10,-64},{-10,-84}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-98},{68,-78}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-88})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      useHeatLoss=false,
      hTan0=300e3,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      steSta=false,
      VTanInn(displayUnit="l") = 0.0025,
      pTan0=2500000)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{-46,-78},{-26,-58}})));
    Sensors.TemperatureTwoPort senTemOut(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{26,-78},{46,-58}})));
    Modelica.Blocks.Sources.RealExpression TSupHea(y=TSup) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-20,-50})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=1)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={-20,-20})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,88},{-66,88},{-66,80},{-62,80}},
                                                   color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,88},{54,88},{54,80},{36,80}},
                                                 color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, pasThr.ports_a) annotation (Line(points={{-50,-20},
            {-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_a1)
      annotation (Line(points={{68,-88},{42,-88},{20,-88},{20,-80},{10,-80}},
                                                            color={0,127,255}));
    connect(sinkEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-70,-88},
            {-20,-88},{-20,-80},{-10,-80}},
                                  color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,9},
            {-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(modExpVal.port_a, tan.port_b)
      annotation (Line(points={{-50,20},{-50,30}}, color={0,127,255}));
    connect(condenser.port_b2, tan.port_a)
      annotation (Line(points={{-10,68},{-50,68},{-50,50}}, color={0,127,255}));
    connect(pasThr.port_b, senTemInl.port_a) annotation (Line(points={{-50,-50},{-50,
            -68},{-46,-68}}, color={0,127,255}));
    connect(senTemInl.port_b, evaporatpr.port_a2)
      annotation (Line(points={{-26,-68},{-10,-68}}, color={0,127,255}));
    connect(evaporatpr.port_b2, senTemOut.port_a)
      annotation (Line(points={{10,-68},{26,-68}}, color={0,127,255}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{46,-68},{50,-68},{50,-20}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -9},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(repTSup.u, TSupHea.y)
      annotation (Line(points={{-20,-32},{-20,-32},{-20,-39}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve99;

  model S2_Valve100
    "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 1
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);
    Modelica.SIunits.TemperatureDifference TSup = senTemOut.T-senTemInl.T;

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,98},{-68,78}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={80,88})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false,
      m_flow_start=0.05,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={15},
      k={0.1})   annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,90},{-18,70}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,90},{-42,70}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,90},{36,70}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      h_out_start=280e3,
      dp_start=1700000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB pasThr(redeclare package Medium = MediumHP)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.75)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0,
      eps=1)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-98},{68,-78}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-88})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      useHeatLoss=false,
      hTan0=300e3,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      steSta=false,
      VTanInn(displayUnit="l") = 0.0015,
      pTan0=2500000)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{-46,-78},{-26,-58}})));
    Sensors.TemperatureTwoPort senTemOut(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{26,-78},{46,-58}})));
    Modelica.Blocks.Sources.RealExpression TSupHea(y=TSup) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-20,-50})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=1)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={-20,-20})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX HEX(
      c_wall=500,
      use_T_start=true,
      m_flow_start_1=0.2,
      m_flow_start_2=0.2,
      k_wall=100,
      s_wall=0.005,
      crossArea_1=4.5e-4,
      crossArea_2=4.5e-4,
      perimeter_1=0.075,
      perimeter_2=0.075,
      rho_wall=900,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.LocalPipeFlowHeatTransfer
          (alpha0=1000),
      length=20,
      area_h_1=0.075*20,
      area_h_2=0.075*20,
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=2000),
      redeclare package Medium_1 = MediumHP,
      redeclare package Medium_2 = MediumEV,
      nNodes=2,
      Twall_start=300,
      dT=10,
      T_start_1=304,
      T_start_2=300)       annotation (Placement(transformation(extent={{-10,-94},
              {10,-72}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
        use_eps_Re=true)             annotation (Placement(transformation(extent={{88,-54},
              {108,-34}})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,88},{-66,88},{-66,80},{-62,80}},
                                                   color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,88},{54,88},{54,80},{36,80}},
                                                 color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, pasThr.ports_a) annotation (Line(points={{-50,-20},
            {-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,9},
            {-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(modExpVal.port_a, tan.port_b)
      annotation (Line(points={{-50,20},{-50,30}}, color={0,127,255}));
    connect(condenser.port_b2, tan.port_a)
      annotation (Line(points={{-10,68},{-50,68},{-50,50}}, color={0,127,255}));
    connect(pasThr.port_b, senTemInl.port_a) annotation (Line(points={{-50,-50},{-50,
            -68},{-46,-68}}, color={0,127,255}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{46,-68},{50,-68},{50,-20}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -9},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(repTSup.u, TSupHea.y)
      annotation (Line(points={{-20,-32},{-20,-32},{-20,-39}}, color={0,0,127}));
    connect(senTemInl.port_b, HEX.port_a1) annotation (Line(points={{-26,-68},{
            -20,-68},{-20,-83.22},{-11,-83.22}}, color={0,127,255}));
    connect(HEX.port_b1, senTemOut.port_a) annotation (Line(points={{11,-83.22},
            {16,-83.22},{16,-68},{26,-68}}, color={0,127,255}));
    connect(sourceEV.ports[1], HEX.port_a2) annotation (Line(points={{68,-88},{
            11,-88},{11,-88.06}}, color={0,127,255}));
    connect(HEX.port_b2, sinkEV.ports[1]) annotation (Line(points={{-11,-77.94},
            {-26,-77.94},{-26,-90},{-26,-88},{-70,-88}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve100;

  model S2_Valve1001 "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 1
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);
    Modelica.SIunits.TemperatureDifference TSup = senTemOut.T-senTemInl.T;

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,98},{-68,78}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={80,88})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false,
      m_flow_start=0.05,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={15},
      k={0.1})   annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,90},{-18,70}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,90},{-42,70}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,90},{36,70}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      h_out_start=280e3,
      dp_start=1700000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB pasThr(redeclare package Medium = MediumHP)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.75)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0,
      eps=1)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-98},{68,-78}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-88})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      useHeatLoss=false,
      hTan0=300e3,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      steSta=false,
      VTanInn(displayUnit="l") = 0.0015,
      pTan0=2500000)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{-46,-78},{-26,-58}})));
    Sensors.TemperatureTwoPort senTemOut(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{26,-78},{46,-58}})));
    Modelica.Blocks.Sources.RealExpression TSupHea(y=TSup) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-20,-50})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=1)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={-20,-20})));
    HeatExchangers.HeaterCooler_u hea(
      redeclare package Medium = MediumHP,
      m_flow_nominal=1e-4,
      dp_nominal=1,
      Q_flow_nominal=300,
      p_start=300000)
      annotation (Placement(transformation(extent={{-10,-58},{10,-78}})));
    Modelica.Blocks.Sources.Constant preOpe1(k=1)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-82,-50})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,88},{-66,88},{-66,80},{-62,80}},
                                                   color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,88},{54,88},{54,80},{36,80}},
                                                 color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, pasThr.ports_a) annotation (Line(points={{-50,-20},
            {-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,9},
            {-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(modExpVal.port_a, tan.port_b)
      annotation (Line(points={{-50,20},{-50,30}}, color={0,127,255}));
    connect(condenser.port_b2, tan.port_a)
      annotation (Line(points={{-10,68},{-50,68},{-50,50}}, color={0,127,255}));
    connect(pasThr.port_b, senTemInl.port_a) annotation (Line(points={{-50,-50},{-50,
            -68},{-46,-68}}, color={0,127,255}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{46,-68},{50,-68},{50,-20}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -9},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(repTSup.u, TSupHea.y)
      annotation (Line(points={{-20,-32},{-20,-32},{-20,-39}}, color={0,0,127}));
    connect(sourceEV.ports[1], sinkEV.ports[1]) annotation (Line(points={{68,
            -88},{-2,-88},{-70,-88}}, color={0,127,255}));
    connect(senTemInl.port_b, hea.port_a) annotation (Line(points={{-26,-68},{
            -18,-68},{-10,-68}}, color={0,127,255}));
    connect(hea.port_b, senTemOut.port_a) annotation (Line(points={{10,-68},{18,
            -68},{26,-68}}, color={0,127,255}));
    connect(preOpe1.y, hea.u) annotation (Line(points={{-82,-61},{-82,-75},{-78,
            -75},{-12,-75},{-12,-74}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve1001;

  model S2_Valve99999
    "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Air
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 5000
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);
    Modelica.SIunits.TemperatureDifference TSup = senTemOut.T-senTemInl.T;

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1,
      use_m_flow_in=true,
      use_T_in=true)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,98},{-68,78}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO,
      use_p_in=true) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={80,88})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false,
      m_flow_start=0.05,
      h_out_start=400e3,
      risTim={5},
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      k={0.75},
      VDis={17.2e-6})
                 annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,90},{-18,70}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,90},{-42,70}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,90},{36,70}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      freqHz=1/3200,
      amplitude=1000,
      offset=3000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      h_out_start=280e3,
      AVal={1.52e-6},
      dp_start=2300000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB pasThr(redeclare package Medium = MediumHP)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=1)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0,
      eps=0.85)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      show_T=true,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV,
      dp1_nominal=1,
      dp2_nominal=1,
      homotopyInitialization=true,
      m2_flow_nominal=0.5*m_flow_nominal_HP,
      linearizeFlowResistance1=true,
      linearizeFlowResistance2=true,
      eps=1)         "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{10,-64},{-10,-84}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1,
      use_m_flow_in=true,
      use_T_in=true)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-98},{68,-78}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1,
      use_p_in=true) "Sink that provides a constant pressure"
                                                         annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-88})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      useHeatLoss=false,
      hTan0=300e3,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      steSta=false,
      VTanInn(displayUnit="l") = 0.05,
      pTan0=2500000)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{-46,-78},{-26,-58}})));
    Sensors.TemperatureTwoPort senTemOut(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{26,-78},{46,-58}})));
    Modelica.Blocks.Sources.RealExpression TSupHea(y=TSup) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-20,-50})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=1)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={-20,-20})));
    Modelica.Blocks.Sources.RealExpression mFlowCon(y=0.85)
                                                           annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-110,76})));
    Modelica.Blocks.Sources.RealExpression pCon(y=1.10325e5) annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={110,96})));
    Modelica.Blocks.Sources.RealExpression pEva(y=1.10325e5) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-110,-80})));
    Modelica.Blocks.Sources.RealExpression mFlowCon1(y=5)  annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={110,-76})));
    Modelica.Blocks.Sources.Sine setHeaCap1(
      freqHz=1/3200,
      amplitude=2.5,
      offset=303.15)
                   annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-112,100})));
    Modelica.Blocks.Sources.Sine setHeaCap2(
      freqHz=1/3200,
      amplitude=5,
      offset=273.15)
                   annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={110,-94})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,88},{-66,88},{-66,80},{-62,80}},
                                                   color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,88},{54,88},{54,80},{36,80}},
                                                 color={0,127,255}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, pasThr.ports_a) annotation (Line(points={{-50,-20},
            {-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(sourceEV.ports[1], evaporatpr.port_a1)
      annotation (Line(points={{68,-88},{42,-88},{20,-88},{20,-80},{10,-80}},
                                                            color={0,127,255}));
    connect(sinkEV.ports[1], evaporatpr.port_b1) annotation (Line(points={{-70,-88},
            {-20,-88},{-20,-80},{-10,-80}},
                                  color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,9},
            {-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(modExpVal.port_a, tan.port_b)
      annotation (Line(points={{-50,20},{-50,30}}, color={0,127,255}));
    connect(condenser.port_b2, tan.port_a)
      annotation (Line(points={{-10,68},{-50,68},{-50,50}}, color={0,127,255}));
    connect(pasThr.port_b, senTemInl.port_a) annotation (Line(points={{-50,-50},{-50,
            -68},{-46,-68}}, color={0,127,255}));
    connect(senTemInl.port_b, evaporatpr.port_a2)
      annotation (Line(points={{-26,-68},{-10,-68}}, color={0,127,255}));
    connect(evaporatpr.port_b2, senTemOut.port_a)
      annotation (Line(points={{10,-68},{26,-68}}, color={0,127,255}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{46,-68},{50,-68},{50,-20}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -9},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(repTSup.u, TSupHea.y)
      annotation (Line(points={{-20,-32},{-20,-32},{-20,-39}}, color={0,0,127}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,35.5},{20,32}}, color={0,0,127}));
    connect(mFlowCon.y, sourceCO.m_flow_in) annotation (Line(points={{-99,76},{-94,
            76},{-94,80},{-88,80}}, color={0,0,127}));
    connect(pCon.y, sinkCO.p_in) annotation (Line(points={{99,96},{98,96},{98,80},
            {92,80}}, color={0,0,127}));
    connect(pEva.y, sinkEV.p_in) annotation (Line(points={{-99,-80},{-95.5,-80},{-92,
            -80}}, color={0,0,127}));
    connect(mFlowCon1.y, sourceEV.m_flow_in) annotation (Line(points={{99,-76},{94,
            -76},{94,-80},{88,-80}}, color={0,0,127}));
    connect(setHeaCap1.y, sourceCO.T_in) annotation (Line(points={{-101,100},{
            -90,100},{-90,84}}, color={0,0,127}));
    connect(setHeaCap2.y, sourceEV.T_in) annotation (Line(points={{99,-94},{96,
            -94},{96,-84},{90,-84}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve99999;

  model S2_Valve9999999
    "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 5000
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);
    Modelica.SIunits.TemperatureDifference TSup = senTemOut.T-senTemInl.T;

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,98},{-68,78}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO)
      "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={80,88})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false,
      m_flow_start=0.05,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={5},
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      k={0.1})   annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,90},{-18,70}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,90},{-42,70}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,90},{36,70}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      freqHz=1/3200,
      amplitude=0,
      offset=1000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      h_out_start=280e3,
      dp_start=2300000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB pasThr(redeclare package Medium = MediumHP)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.75)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-98},{68,-78}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-88})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      useHeatLoss=false,
      hTan0=300e3,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      steSta=false,
      VTanInn(displayUnit="l") = 0.0025,
      pTan0=2500000)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{-46,-78},{-26,-58}})));
    Sensors.TemperatureTwoPort senTemOut(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{26,-78},{46,-58}})));
    Modelica.Blocks.Sources.RealExpression TSupHea(y=TSup) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-20,-50})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=1)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={-20,-20})));
    HeatExchangers.MovingBoundaryHeatExchangers.SimpleHeatExchangers.OneVolumeHeatExchanger
      oneVolumeHeatExchanger1(
      hInlPri(start=425e3),
      hOutPri(start=375e3),
      redeclare package Medium1 = MediumEV,
      redeclare package Medium2 = MediumHP,
      pPri(start=2700000, fixed=true))
      annotation (Placement(transformation(extent={{-12,64},{8,84}})));
    HeatExchangers.ConstantEffectiveness evaporatpr(
      redeclare package Medium2 = MediumHP,
      show_T=true,
      redeclare package Medium1 = MediumEV,
      m1_flow_nominal=m_flow_nominal_EV,
      dp1_nominal=1,
      dp2_nominal=1,
      homotopyInitialization=true,
      m2_flow_nominal=0.5*m_flow_nominal_HP,
      linearizeFlowResistance1=true,
      linearizeFlowResistance2=true,
      eps=1)         "Simple evaporator using a constant effectiveness"
      annotation (Placement(transformation(extent={{10,-66},{-10,-86}})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,88},{-66,88},{-66,80},{-62,80}},
                                                   color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,88},{54,88},{54,80},{36,80}},
                                                 color={0,127,255}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, pasThr.ports_a) annotation (Line(points={{-50,-20},
            {-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,9},
            {-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(modExpVal.port_a, tan.port_b)
      annotation (Line(points={{-50,20},{-50,30}}, color={0,127,255}));
    connect(pasThr.port_b, senTemInl.port_a) annotation (Line(points={{-50,-50},{-50,
            -68},{-46,-68}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -9},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(repTSup.u, TSupHea.y)
      annotation (Line(points={{-20,-32},{-20,-32},{-20,-39}}, color={0,0,127}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,35.5},{20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, oneVolumeHeatExchanger1.port_a1)
      annotation (Line(points={{-18,80},{-15,80},{-12,80}}, color={0,127,255}));
    connect(oneVolumeHeatExchanger1.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{8,80},{12,80},{16,80}}, color={0,127,255}));
    connect(oneVolumeHeatExchanger1.port_b2, tan.port_a) annotation (Line(points={
            {-12,68},{-30,68},{-30,62},{-50,62},{-50,50}}, color={0,127,255}));
    connect(oneVolumeHeatExchanger1.port_a2, modCom.port_b) annotation (Line(
          points={{8,68},{26,68},{26,70},{50,70},{50,20}}, color={0,127,255}));
    connect(senTemOut.port_b, modCom.port_a) annotation (Line(points={{46,-68},{50,
            -68},{50,-64},{50,-20}}, color={0,127,255}));
    connect(senTemInl.port_b, evaporatpr.port_a2) annotation (Line(points={{-26,-68},
            {-18,-68},{-18,-70},{-10,-70}}, color={0,127,255}));
    connect(evaporatpr.port_b1, sinkEV.ports[1]) annotation (Line(points={{-10,-82},
            {-40,-82},{-40,-88},{-70,-88}}, color={0,127,255}));
    connect(evaporatpr.port_a1, sourceEV.ports[1]) annotation (Line(points={{10,-82},
            {40,-82},{40,-88},{68,-88}}, color={0,127,255}));
    connect(evaporatpr.port_b2, senTemOut.port_a) annotation (Line(points={{10,-70},
            {18,-70},{18,-68},{26,-68}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve9999999;

  model S2_Thesis "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 5000
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);
    Modelica.SIunits.TemperatureDifference TSup = senTemOut.T-senTemInl.T;

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCon(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,98},{-68,78}})));
    Sources.Boundary_ph sinkCon(
      redeclare package Medium = MediumCO,
      p=pSouCO,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={80,88})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false,
      m_flow_start=0.05,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={5},
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      k={0.1})   annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,20},{80,40}})));
    Modelica.Blocks.Sources.RealExpression setHeaCap(y=Q_flow_heaCap)
                                                                 annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={30,-32})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-7,7},{7,-7}},
          rotation=90,
          origin={13,-13})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      h_out_start=280e3,
      dp_start=2300000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Sources.MassFlowSource_T sourceEva(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-98},{68,-78}})));
    Sources.Boundary_ph sinkEva(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-88})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      useHeatLoss=false,
      hTan0=300e3,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      steSta=false,
      VTanInn(displayUnit="l") = 0.0025,
      pTan0=2500000)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Modelica.Blocks.Sources.RealExpression setTSup(y=TSup) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-30,-32})));
    Modelica.Blocks.Routing.Replicator repSetTSup(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{7,7},{-7,-7}},
          rotation=-90,
          origin={-13,-13})));
    HeatExchangers.MovingBoundaryHeatExchangers.ModularHeatExchangers.ModularHeatExchangersSensors
      modEva(useModPortsb_a=true)
      annotation (Placement(transformation(extent={{-20,-40},{20,-80}})));
    HeatExchangers.MovingBoundaryHeatExchangers.ModularHeatExchangers.ModularHeatExchangersSensors
      modCon(useModPortsb_a=false)
      annotation (Placement(transformation(extent={{20,40},{-20,80}})));
    Interfaces.PortsAThroughPortB pasThrSinEva(redeclare package Medium =
          MediumHP) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={-50,-88})));
    Interfaces.PortsAThroughPortB pasThrSinCon(redeclare package Medium =
          MediumHP) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={50,88})));
    Interfaces.PortAThroughPortsB pasThrSouCon
      annotation (Placement(transformation(extent={{-60,98},{-40,78}})));
    Interfaces.PortAThroughPortsB pasThrSouEva
      annotation (Placement(transformation(extent={{60,-98},{40,-78}})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,30},{80,30},{70,30},{70,2},{70,2},{70,0},{70,
            0}},                                      color={191,0,0}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repSetHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{13,-5.3},{13,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.port_a, tan.port_b)
      annotation (Line(points={{-50,20},{-50,30}}, color={0,127,255}));
    connect(repSetTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(
          points={{-13,-5.3},{-13,-4},{0,-4},{0,0.05},{0.05,0.05}}, color={0,0,
            127}));
    connect(setTSup.y, repSetTSup.u) annotation (Line(points={{-19,-32},{-13,
            -32},{-13,-21.4}}, color={0,0,127}));
    connect(repSetHeaCap.u, setHeaCap.y) annotation (Line(points={{13,-21.4},{
            13,-32},{19,-32}}, color={0,0,127}));
    connect(modExpVal.ports_b, modEva.ports_a2) annotation (Line(points={{-50,
            -20},{-50,-60},{-20,-60}}, color={0,127,255}));
    connect(modEva.port_b2, modCom.port_a) annotation (Line(points={{20,-60},{
            50,-60},{50,-20}}, color={0,127,255}));
    connect(modEva.dataBus, datBus) annotation (Line(
        points={{0,-40},{0,-20},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modCon.port_b2, tan.port_a) annotation (Line(points={{-20,60},{-34,
            60},{-50,60},{-50,50}}, color={0,127,255}));
    connect(modCon.port_a2, modCom.port_b)
      annotation (Line(points={{20,60},{50,60},{50,20}}, color={0,127,255}));
    connect(modCon.dataBus, datBus) annotation (Line(
        points={{0,40},{0,40},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(sinkEva.ports[1], pasThrSinEva.port_b)
      annotation (Line(points={{-70,-88},{-60,-88}}, color={0,127,255}));
    connect(pasThrSinEva.ports_a, modEva.ports_b1) annotation (Line(points={{
            -40,-88},{-40,-88},{-10,-88},{-10,-80}}, color={0,127,255}));
    connect(sinkCon.ports[1], pasThrSinCon.port_b)
      annotation (Line(points={{70,88},{65,88},{60,88}}, color={0,127,255}));
    connect(pasThrSinCon.ports_a, modCon.ports_b1) annotation (Line(points={{40,
            88},{28,88},{10,88},{10,80}}, color={0,127,255}));
    connect(sourceCon.ports[1], pasThrSouCon.port_a) annotation (Line(points={{
            -68,88},{-64,88},{-60,88}}, color={0,127,255}));
    connect(pasThrSouCon.ports_b, modCon.ports_a1) annotation (Line(points={{
            -40,88},{-10,88},{-10,80}}, color={0,127,255}));
    connect(sourceEva.ports[1], pasThrSouEva.port_a) annotation (Line(points={{
            68,-88},{64,-88},{60,-88}}, color={0,127,255}));
    connect(pasThrSouEva.ports_b, modEva.ports_a1) annotation (Line(points={{40,
            -88},{32,-88},{10,-88},{10,-80}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Thesis;

  model S2_Valve99FINAL "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R134aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 5000
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);
    Modelica.SIunits.TemperatureDifference TSup = senTemOut.T-senTemInl.T;

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,98},{-68,78}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={80,88})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false,
      m_flow_start=0.05,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={15},
      k={0.1})   annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,90},{-18,70}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,90},{-42,70}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,90},{36,70}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      h_out_start=280e3,
      dp_start=2300000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB pasThr(redeclare package Medium = MediumHP)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.75)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0,
      eps=1)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-98},{68,-78}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-88})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      useHeatLoss=false,
      hTan0=300e3,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      steSta=false,
      VTanInn(displayUnit="l") = 0.0025,
      pTan0=2500000)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{-46,-78},{-26,-58}})));
    Sensors.TemperatureTwoPort senTemOut(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{26,-78},{46,-58}})));
    Modelica.Blocks.Sources.RealExpression TSupHea(y=TSup) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-20,-50})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=1)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={-20,-20})));
    HeatPlateExchanger.HeatPlateExchanger.HeatPlateExchanger3
      heatPlateExchanger3_1(
      redeclare package Medium1 = MediumHP,
      redeclare package Medium2 = MediumEV,
      m1_flow_nominal=0.04,
      m2_flow_nominal=0.1,
      A=4,
      k=250,
      dp_DistrictHeating=0,
      dp_HeatingSystem=0,
      V_ColdCircuit(displayUnit="l") = 0.00025,
      V_WarmCircuit(displayUnit="l") = 0.00025,
      m_flow_DH_nom=0.04,
      m_flow_HS_nom=0.1,
      StartTime=1,
      m1_flow(start=0.04),
      m2_flow(start=0.1))
      annotation (Placement(transformation(extent={{-14,-86},{10,-66}})));
    inner Modelica.Fluid.System system(energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
        use_eps_Re=true)             annotation (Placement(transformation(extent={{80,-20},
              {100,-40}})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,88},{-66,88},{-66,80},{-62,80}},
                                                   color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,88},{54,88},{54,80},{36,80}},
                                                 color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, pasThr.ports_a) annotation (Line(points={{-50,-20},
            {-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,9},
            {-20,4},{0,4},{0,0},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(modExpVal.port_a, tan.port_b)
      annotation (Line(points={{-50,20},{-50,30}}, color={0,127,255}));
    connect(condenser.port_b2, tan.port_a)
      annotation (Line(points={{-10,68},{-50,68},{-50,50}}, color={0,127,255}));
    connect(pasThr.port_b, senTemInl.port_a) annotation (Line(points={{-50,-50},{-50,
            -68},{-46,-68}}, color={0,127,255}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{46,-68},{50,-68},{50,-20}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -9},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(repTSup.u, TSupHea.y)
      annotation (Line(points={{-20,-32},{-20,-32},{-20,-39}}, color={0,0,127}));
    connect(senTemInl.port_b, heatPlateExchanger3_1.port_a1) annotation (Line(
          points={{-26,-68},{-20,-68},{-20,-70},{-12,-70}}, color={0,127,255}));
    connect(heatPlateExchanger3_1.port_b1, senTemOut.port_a) annotation (Line(
          points={{8,-70},{18,-70},{18,-68},{26,-68}}, color={0,127,255}));
    connect(sourceEV.ports[1], heatPlateExchanger3_1.port_a2) annotation (Line(
          points={{68,-88},{42,-88},{16,-88},{16,-82},{8,-82}}, color={0,127,
            255}));
    connect(heatPlateExchanger3_1.port_b2, sinkEV.ports[1]) annotation (Line(
          points={{-12,-82},{-16,-82},{-16,-80},{-20,-80},{-20,-88},{-70,-88}},
          color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve99FINAL;

  model S2_Valve9911111111
    "Model that describes condensation of working fluid"
    extends Modelica.Icons.Example;

    // Definition of media
    //
    replaceable package MediumHP =
      ExternalMedia.Examples.R410aCoolProp
      "Current medium of the heat pump";

    replaceable package MediumCO =
      AixLib.Media.Water
      "Current medium of the condenser";
    replaceable package MediumEV =
      AixLib.Media.Water
      "Current medium of the evaporator";

    // Further media models
    //
    // AixLib.Media.Water
    // Modelica.Media.R134a.R134a_ph
    // HelmholtzMedia.HelmholtzFluids.R134a
    // ExternalMedia.Examples.R410aCoolProp
    // WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner

    // Definition of parameters
    //
    parameter Modelica.SIunits.Temperature TSouHP = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSinHP = 353.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSinHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSinHP-15)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouHP=
      MediumHP.pressure(MediumHP.setDewState(MediumHP.setSat_T(TSouHP-1)))
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.Temperature TSouCO = 308.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouCO=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.Temperature TSouEV = 275.15
      "Actual temperature at outlet conditions"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.AbsolutePressure pSouEV=1.01325e5
      "Actual set point of the heat exchanger's outlet pressure"
      annotation (Dialog(tab="General",group="Prescribed state properties"));

    parameter Modelica.SIunits.MassFlowRate m_flow_source_HP = 0.05
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HP = m_flow_source_HP
      "Prescribed mass flow rate of working fluid"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_CO = 0.7
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_CO = m_flow_source_CO
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));
    parameter Modelica.SIunits.MassFlowRate m_flow_source_EV = 15
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Prescribed state properties"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_EV = 0.5*m_flow_source_EV
      "Prescribed mass flow rate of secondary fluid of condesator"
      annotation (Dialog(tab="General",group="Nominal conditions"));

    // Definition of further variables
    //
    Modelica.SIunits.Power Q_flow_H = senMasFlo.m_flow*(senSpeEntOut.h_out-senSpeEntInl.h_out);
    Modelica.SIunits.TemperatureDifference TSup = senTemOut.T-senTemInl.T;

    // Definition of subcomponents
    //

    Sources.MassFlowSource_T sourceCO(
      redeclare package Medium = MediumCO,
      m_flow=m_flow_source_CO,
      T=TSouCO,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{-88,98},{-68,78}})));
    Sources.Boundary_ph sinkCO(
      nPorts=1,
      redeclare package Medium = MediumCO,
      p=pSouCO) "Sink that provides a constant pressure"
      annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={80,88})));
    Movers.Compressors.ModularCompressors.ModularCompressorsSensors modCom(
      redeclare package Medium = MediumHP,
      redeclare model SimpleCompressor =
          Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor,
      rotSpeMax={130},
      redeclare model EngineEfficiency =
          Movers.Compressors.Utilities.EngineEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model VolumetricEfficiency =
          Movers.Compressors.Utilities.VolumetricEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model IsentropicEfficiency =
          Movers.Compressors.Utilities.IsentropicEfficiency.SpecifiedEfficiencies.Generic_VarRef_VarDisVol_RotaryScroll,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularCompressorController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={125},
      yMin={30},
      dp_start=-15e5,
      m_flow_nominal=0.024,
      show_staEff=true,
      show_qua=true,
      show_parCom=true,
      show_parCon=true,
      show_parSen=true,
      useExt=false,
      m_flow_start=0.05,
      h_out_start=400e3,
      VDis={13e-6},
      risTim={15},
      k={0.1})   annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=90,
          origin={50,0})));

    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambTem[1](each T=298.15)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntInl(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{-38,90},{-18,70}})));
    Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumCO)
      annotation (Placement(transformation(extent={{-62,90},{-42,70}})));
    Sensors.SpecificEnthalpyTwoPort senSpeEntOut(redeclare package Medium =
          MediumCO, m_flow_nominal=m_flow_nominal_CO)
      annotation (Placement(transformation(extent={{16,90},{36,70}})));
    Modelica.Blocks.Sources.RealExpression CurHeaCap(y=Q_flow_H) annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-50})));
    Modelica.Blocks.Routing.Replicator repCurHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={20,-20})));
    Modelica.Blocks.Sources.Sine setHeaCap(
      amplitude=1000,
      freqHz=1/3200,
      offset=2000) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,50})));
    Modelica.Blocks.Routing.Replicator repSetHeaCap(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={20,20})));
    Controls.Interfaces.ModularHeatPumpControlBus datBus(
      nVal=1,
      nCom=1,
      nCon=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Actuators.Valves.ExpansionValves.ModularExpansionValves.ModularExpansionValvesSensors
      modExpVal(
      redeclare model SimpleExpansionValve =
          Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsenthalpicExpansionValve,
      AVal={1.32e-6},
      useInpFil={true},
      risTim={5},
      redeclare model FlowCoefficient =
          Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Poly_R22R407CR410A_EEV_15_22,
      redeclare model ModularController =
          Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController,
      controllerType={Modelica.Blocks.Types.SimpleController.P},
      yMax={0.95},
      yMin={0.15},
      redeclare package Medium = MediumHP,
      useExt=true,
      h_out_start=280e3,
      dp_start=2300000)
                    annotation (Placement(transformation(
          extent={{-20,20},{20,-20}},
          rotation=-90,
          origin={-50,0})));

    Interfaces.PortsAThroughPortB pasThr(redeclare package Medium = MediumHP)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-40})));
    Modelica.Blocks.Sources.Constant preOpe(k=0.75)
      annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,50})));
    Modelica.Blocks.Routing.Replicator repPreOpe(nout=1)
      "Replicating the current value of the manipulated variables" annotation (
        Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={-20,20})));
    HeatExchangers.ConstantEffectiveness condenser(
      redeclare package Medium1 = MediumCO,
      redeclare package Medium2 = MediumHP,
      m1_flow_nominal=m_flow_nominal_CO,
      m2_flow_nominal=m_flow_nominal_HP,
      show_T=true,
      dp1_nominal=0,
      dp2_nominal=0,
      eps=1)
      "Simple condenser using a constant effectiveness"
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));

    Sources.MassFlowSource_T sourceEV(
      redeclare package Medium = MediumEV,
      m_flow=m_flow_source_EV,
      T=TSouEV,
      nPorts=1)
      "Source that provides a constant mass flow rate with a prescribed temperature"
      annotation (Placement(transformation(extent={{88,-98},{68,-78}})));
    Sources.Boundary_ph sinkEV(
      redeclare package Medium = MediumEV,
      p=pSouEV,
      nPorts=1) "Sink that provides a constant pressure" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-80,-88})));
    Storage.TwoPhaseSeparator tan(
      redeclare package Medium = MediumHP,
      useHeatLoss=false,
      hTan0=300e3,
      show_tankProperties=true,
      show_tankPropertiesDetailed=true,
      steSta=false,
      VTanInn(displayUnit="l") = 0.0025,
      pTan0=2500000)
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Sensors.TemperatureTwoPort senTemInl(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{-46,-78},{-26,-58}})));
    Sensors.TemperatureTwoPort senTemOut(redeclare package Medium = MediumHP,
        m_flow_nominal=m_flow_nominal_HP)
      annotation (Placement(transformation(extent={{26,-78},{46,-58}})));
    Modelica.Blocks.Sources.RealExpression TSupHea(y=TSup) annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-20,-50})));
    Modelica.Blocks.Routing.Replicator repTSup(nout=1)
      "Replicating the current value of the manipulated variables"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={-20,-20})));
    Modelica.Fluid.Examples.HeatExchanger.BaseClasses.BasicHX basicHX(
      length=20,
      nNodes=2,
      modelStructure_1=Modelica.Fluid.Types.ModelStructure.av_b,
      modelStructure_2=Modelica.Fluid.Types.ModelStructure.a_vb,
      crossArea_1=4.5e-4,
      crossArea_2=4.5e-4,
      perimeter_1=0.075,
      perimeter_2=0.075,
      area_h_1=20*0.075,
      area_h_2=20*0.075,
      s_wall=0.005,
      k_wall=100,
      c_wall=500,
      rho_wall=900,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      momentumDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
      allowFlowReversal=true,
      redeclare package Medium_1 = MediumEV,
      redeclare package Medium_2 = MediumHP,
      m_flow_start_1=0.045,
      m_flow_start_2=1,
      redeclare model HeatTransfer_1 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=250),
      redeclare model HeatTransfer_2 =
          Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer
          (alpha0=10000),
      Twall_start=273.15,
      dT=283.15,
      p_a_start1=101325,
      p_b_start1=101325,
      p_a_start2=900000,
      p_b_start2=900000)
      annotation (Placement(transformation(extent={{10,-62},{-10,-82}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-110,-8},{-90,12}})));
  equation
    // Connection of main components
    //

    connect(ambTem.port, modCom.heatPort)
      annotation (Line(points={{80,0},{75,0},{70,0}}, color={191,0,0}));
    connect(sourceCO.ports[1], senMasFlo.port_a)
      annotation (Line(points={{-68,88},{-66,88},{-66,80},{-62,80}},
                                                   color={0,127,255}));
    connect(senMasFlo.port_b, senSpeEntInl.port_a)
      annotation (Line(points={{-42,80},{-38,80}}, color={0,127,255}));
    connect(sinkCO.ports[1], senSpeEntOut.port_b)
      annotation (Line(points={{70,88},{54,88},{54,80},{36,80}},
                                                 color={0,127,255}));
    connect(setHeaCap.y, repSetHeaCap.u)
      annotation (Line(points={{20,39},{20,32}}, color={0,0,127}));
    connect(CurHeaCap.y, repCurHeaCap.u)
      annotation (Line(points={{20,-39},{20,-32}},
                                                 color={0,0,127}));
    connect(modCom.dataBus, datBus) annotation (Line(
        points={{30,0},{30,0},{0,0}},
        color={255,204,51},
        thickness=0.5));
    connect(repCurHeaCap.y, datBus.comBus.meaConVarCom)
      annotation (Line(points={{20,-9},{20,-4},{0,-4},{0,0.05},{0.05,0.05}},
                                                             color={0,0,127}));
    connect(repSetHeaCap.y, datBus.comBus.intSetPoiCom) annotation (Line(points={{
            20,9},{20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(datBus, modExpVal.dataBus) annotation (Line(
        points={{0,0},{-15,0},{-30,0}},
        color={255,204,51},
        thickness=0.5));
    connect(modExpVal.ports_b, pasThr.ports_a) annotation (Line(points={{-50,-20},
            {-50,-25},{-50,-30}}, color={0,127,255}));
    connect(preOpe.y, repPreOpe.u)
      annotation (Line(points={{-20,39},{-20,35.5},{-20,32}}, color={0,0,127}));
    connect(senSpeEntInl.port_b, condenser.port_a1)
      annotation (Line(points={{-18,80},{-14,80},{-10,80}}, color={0,127,255}));
    connect(condenser.port_b1, senSpeEntOut.port_a)
      annotation (Line(points={{10,80},{13,80},{16,80}}, color={0,127,255}));
    connect(condenser.port_a2, modCom.port_b) annotation (Line(points={{10,68},{30,
            68},{50,68},{50,20}}, color={0,127,255}));
    connect(repPreOpe.y, datBus.expValBus.extManVarVal) annotation (Line(points={{-20,9},
            {-20,4},{0,4},{0,0},{0,0.05},{0.05,0.05}},
                                            color={0,0,127}));
    connect(modExpVal.port_a, tan.port_b)
      annotation (Line(points={{-50,20},{-50,30}}, color={0,127,255}));
    connect(condenser.port_b2, tan.port_a)
      annotation (Line(points={{-10,68},{-50,68},{-50,50}}, color={0,127,255}));
    connect(pasThr.port_b, senTemInl.port_a) annotation (Line(points={{-50,-50},{-50,
            -68},{-46,-68}}, color={0,127,255}));
    connect(senTemOut.port_b, modCom.port_a)
      annotation (Line(points={{46,-68},{50,-68},{50,-20}}, color={0,127,255}));
    connect(repTSup.y, datBus.expValBus.meaConVarVal) annotation (Line(points={{-20,
            -9},{-20,-4},{0,-4},{0,0.05},{0.05,0.05}}, color={0,0,127}));
    connect(repTSup.u, TSupHea.y)
      annotation (Line(points={{-20,-32},{-20,-32},{-20,-39}}, color={0,0,127}));
    connect(basicHX.port_a2, senTemInl.port_b) annotation (Line(points={{-11,-67.4},
            {-18.5,-67.4},{-18.5,-68},{-26,-68}}, color={0,127,255}));
    connect(basicHX.port_b2, senTemOut.port_a) annotation (Line(points={{11,-76.6},
            {18.5,-76.6},{18.5,-68},{26,-68}}, color={0,127,255}));
    connect(sourceEV.ports[1], basicHX.port_a1) annotation (Line(points={{68,-88},
            {14,-88},{14,-71.8},{11,-71.8}}, color={0,127,255}));
    connect(basicHX.port_b1, sinkEV.ports[1]) annotation (Line(points={{-11,-71.8},
            {-16,-71.8},{-16,-88},{-70,-88}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=6400));
  end S2_Valve9911111111;
end MyModels;
