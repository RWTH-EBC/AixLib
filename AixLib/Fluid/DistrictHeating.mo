within AixLib.Fluid;
package DistrictHeating "Package with models for district heating network"
  package Components "Components for district heating model "

    model DividerUnit "Divider unit for direct or indirect supply"

      replaceable package Medium = AixLib.Media.Water;

      Modelica.Fluid.Interfaces.FluidPort_a port_a( redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b( redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1( redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening dirSupplyValve( redeclare
          package Medium =
            Medium,
        m_flow_nominal=10,
        dpValve_nominal=6000) "Valve for direct supply"
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
      AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening indirSupplyValve( redeclare
          package Medium =
            Medium,
        m_flow_nominal=10,
        dpValve_nominal=6000) "Valve for indirect supply"
                                    annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-46})));
      Modelica.Blocks.Interfaces.RealInput ValveOpDir
        "valve opening of direct supply" annotation (Placement(transformation(
              extent={{-126,54},{-86,94}}), iconTransformation(extent={{-108,58},{-82,
                84}})));
      Modelica.Blocks.Interfaces.RealInput ValveOpIndir
        "valve opening of indirect supply" annotation (Placement(transformation(
              extent={{-126,26},{-86,66}}), iconTransformation(extent={{-108,30},{-82,
                56}})));
    equation
      connect(port_a, dirSupplyValve.port_a)
        annotation (Line(points={{-100,0},{-74,0},{30,0}}, color={0,127,255}));
      connect(dirSupplyValve.port_b, port_b1)
        annotation (Line(points={{50,0},{100,0}},         color={0,127,255}));
      connect(port_a, indirSupplyValve.port_a)
        annotation (Line(points={{-100,0},{0,0},{0,-36}}, color={0,127,255}));
      connect(indirSupplyValve.port_b, port_b)
        annotation (Line(points={{0,-56},{0,-100}},          color={0,127,255}));
      connect(ValveOpIndir, indirSupplyValve.y) annotation (Line(points={{-106,46},{
              -38,46},{-38,-28},{22,-28},{22,-46},{12,-46}}, color={0,0,127}));
      connect(ValveOpDir, dirSupplyValve.y)
        annotation (Line(points={{-106,74},{40,74},{40,12}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end DividerUnit;

    model CollectorUnit "Collector unit for direct or indirect supply"

      replaceable package Medium = AixLib.Media.Water;

      Modelica.Fluid.Interfaces.FluidPort_b port_a( redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_b( redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={0,100})));
      Modelica.Fluid.Interfaces.FluidPort_a port_b1( redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening dirSupplyValve( redeclare
          package Medium =
            Medium,
        m_flow_nominal=10,
        dpValve_nominal=6000)
        "Valve for direct supply"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={40,0})));
      AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening indirSupplyValve( redeclare
          package Medium =
            Medium,
        m_flow_nominal=10,
        dpValve_nominal=6000) "Valve for indirect supply"
                                    annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,44})));
      Modelica.Blocks.Interfaces.RealInput ValveOpDir
        "valve opening of direct supply" annotation (Placement(transformation(
              extent={{-126,54},{-86,94}}), iconTransformation(extent={{-108,58},{-82,
                84}})));
      Modelica.Blocks.Interfaces.RealInput ValveOpIndir
        "valve opening of indirect supply" annotation (Placement(transformation(
              extent={{-126,26},{-86,66}}), iconTransformation(extent={{-108,30},{-82,
                56}})));
    equation
      connect(port_b, port_b)
        annotation (Line(points={{0,100},{0,100},{0,100}}, color={0,127,255}));
      connect(port_b, indirSupplyValve.port_a)
        annotation (Line(points={{0,100},{0,77},{0,54}}, color={0,127,255}));
      connect(indirSupplyValve.port_b, port_a)
        annotation (Line(points={{0,34},{0,0},{-100,0}}, color={0,127,255}));
      connect(port_b1, dirSupplyValve.port_a)
        annotation (Line(points={{100,0},{75,0},{50,0}}, color={0,127,255}));
      connect(dirSupplyValve.port_b, port_a)
        annotation (Line(points={{30,0},{-100,0},{-100,0}}, color={0,127,255}));
      connect(ValveOpDir, dirSupplyValve.y) annotation (Line(points={{-106,74},{-58,
              74},{-58,-38},{40,-38},{40,-12}}, color={0,0,127}));
      connect(ValveOpIndir, indirSupplyValve.y) annotation (Line(points={{-106,46},
              {-32,46},{-32,74},{30,74},{30,44},{12,44}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end CollectorUnit;

    model BuffStorageExtHEx
      "Buffer storage model with external heat exchanger for solar collectors"

      replaceable package Medium = AixLib.Media.Water;

      AixLib.Fluid.HeatExchangers.ConstantEffectiveness hex(
      redeclare package Medium2 = Medium,
        dp1_nominal=600,
        dp2_nominal=600,
        eps=0.8,
        m1_flow_nominal=10,
        m2_flow_nominal=10,
        redeclare package Medium1 = Medium)
       annotation (Placement(
            transformation(
            extent={{-13,-12},{13,12}},
            rotation=90,
            origin={-29,0})));
      AixLib.Fluid.Storage.BufferStorage bufferStorage(
        useHeatingCoil1=false,
        useHeatingCoil2=false,
        useHeatingRod=false,
        upToDownHC1=false,
        upToDownHC2=false,
        redeclare package Medium = Medium,
        redeclare model HeatTransfer =
            AixLib.Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
        redeclare package MediumHC1 = Medium,
        redeclare package MediumHC2 = Medium,
        n=10,
        TStart=303.15,
        data=AixLib.DataBase.Storage.Generic_New_2000l(
            hTank=4.5,
            hUpperPorts=4.4,
            dTank=6,
            hTS2=1),
        TStartWall=303.15,
        TStartIns=303.15)
        annotation (Placement(transformation(extent={{-19,-24},{19,24}},
            rotation=0,
            origin={51,-2})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a( redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b( redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1( redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{90,-56},{110,-36}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1( redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{90,30},{110,50}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort SolarCollFlowTemp(redeclare
          package Medium =
                   Medium)
        annotation (Placement(transformation(extent={{-72,-50},{-52,-30}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort SolarCollRetTemp(redeclare
          package Medium =
                   Medium)
       annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-62,40})));
      Modelica.Fluid.Sensors.TemperatureTwoPort StorageSideRetTemp(redeclare
          package Medium =                                                                    Medium)
        annotation (Placement(transformation(extent={{-8,-8},{8,8}},
            rotation=180,
            origin={76,-46})));
      AixLib.Fluid.Movers.FlowControlled_m_flow StgLoopPump(redeclare package
          Medium = Medium, m_flow_nominal=10)  annotation (Placement(transformation(
            extent={{-9,-9},{9,9}},
            rotation=180,
            origin={3,-50})));
      Modelica.Fluid.Sensors.TemperatureTwoPort StorageSideFlowTemp(
                                                                   redeclare
          package Medium =                                                                    Medium)
        annotation (Placement(transformation(extent={{-8,-8},{8,8}},
            rotation=0,
            origin={74,40})));
      Modelica.Fluid.Sensors.TemperatureTwoPort StorageLoopOutTemp(redeclare
          package Medium = Medium) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={32,-50})));
      Modelica.Fluid.Sensors.TemperatureTwoPort StorageLoopInTemp(redeclare
          package Medium =
                   Medium) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=0,
            origin={30,40})));
      Modelica.Blocks.Interfaces.RealOutput StgTempTop
        annotation (Placement(transformation(extent={{94,72},{114,92}}),
            iconTransformation(extent={{94,72},{114,92}})));
      Modelica.Blocks.Interfaces.RealOutput StgTempBott
        annotation (Placement(transformation(extent={{96,-88},{116,-68}}),
            iconTransformation(extent={{96,-88},{116,-68}})));
      Modelica.Blocks.Interfaces.RealOutput TempSolColRet
        "Return temperature of solar collector " annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-106,76}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-104,80})));
      Modelica.Blocks.Interfaces.RealOutput TempSolCollFlow
        "Flow temperature of solar collector" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-106,-74}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-106,-80})));
      Modelica.Blocks.Interfaces.RealInput MassFlowStgLoop annotation (Placement(
            transformation(
            extent={{-14,-14},{14,14}},
            rotation=90,
            origin={-16,-100}), iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-96})));
    equation
      connect(port_a, SolarCollFlowTemp.port_a)
        annotation (Line(points={{-100,-40},{-72,-40}}, color={0,127,255}));
      connect(SolarCollFlowTemp.port_b, hex.port_a1) annotation (Line(points={{-52,-40},
              {-36.2,-40},{-36.2,-13}}, color={0,127,255}));
      connect(hex.port_b1, SolarCollRetTemp.port_a) annotation (Line(points={{-36.2,
              13},{-36.2,40},{-52,40}}, color={0,127,255}));
      connect(SolarCollRetTemp.port_b, port_b)
        annotation (Line(points={{-72,40},{-100,40}}, color={0,127,255}));
      connect(port_a1, StorageSideRetTemp.port_a)
        annotation (Line(points={{100,-46},{84,-46}}, color={0,127,255}));
      connect(StorageSideRetTemp.port_b, bufferStorage.fluidportBottom2)
        annotation (Line(points={{68,-46},{56.4625,-46},{56.4625,-26.24}}, color={0,
              127,255}));
      connect(bufferStorage.fluidportTop2, StorageSideFlowTemp.port_a) annotation (
          Line(points={{56.9375,22.24},{56.9375,40},{66,40}}, color={0,127,255}));
      connect(StorageSideFlowTemp.port_b, port_b1)
        annotation (Line(points={{82,40},{100,40}}, color={0,127,255}));
      connect(bufferStorage.fluidportBottom1, StorageLoopOutTemp.port_a)
        annotation (Line(points={{44.5875,-26.48},{44.5875,-50},{40,-50}}, color={0,
              127,255}));
      connect(StorageLoopInTemp.port_b, bufferStorage.fluidportTop1) annotation (
          Line(points={{38,40},{44.35,40},{44.35,22.24}}, color={0,127,255}));
      connect(StorageLoopOutTemp.port_b, StgLoopPump.port_a)
        annotation (Line(points={{24,-50},{12,-50}}, color={0,127,255}));
      connect(StgLoopPump.port_b, hex.port_a2) annotation (Line(points={{-6,-50},{-12,
              -50},{-12,40},{-21.8,40},{-21.8,13}}, color={0,127,255}));
      connect(hex.port_b2, StorageLoopInTemp.port_a) annotation (Line(points={{
              -21.8,-13},{-21.8,-18},{8,-18},{8,40},{22,40}}, color={0,127,255}));
      connect(SolarCollRetTemp.T, TempSolColRet) annotation (Line(
          points={{-62,29},{-62,22},{-86,22},{-86,76},{-106,76}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(SolarCollFlowTemp.T, TempSolCollFlow) annotation (Line(
          points={{-62,-29},{-62,-20},{-84,-20},{-84,-74},{-106,-74}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(bufferStorage.TTop, StgTempTop) annotation (Line(
          points={{32,19.12},{30,19.12},{30,20},{14,20},{14,82},{104,82}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(bufferStorage.TBottom, StgTempBott) annotation (Line(
          points={{32,-21.2},{22,-21.2},{22,-34},{52,-34},{52,-78},{106,-78}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(MassFlowStgLoop, StgLoopPump.m_flow_in) annotation (Line(points={{-16,
              -100},{-16,-80},{3.18,-80},{3.18,-60.8}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{100,-100},{-100,100}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={215,215,215}), Text(
              extent={{-76,86},{78,-76}},
              lineColor={28,108,200},
              textString="Seasonal 
heat storage")}),                                                    Diagram(
            coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
              extent={{-100,100},{-30,-100}},
              lineColor={0,0,0},
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid), Text(
              extent={{-88,104},{-46,80}},
              lineColor={0,0,0},
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid,
              textStyle={TextStyle.Bold},
              textString="Solar collector side
"),         Rectangle(
              extent={{100,-100},{-30,100}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              fillColor={215,215,215}),       Text(
              extent={{14,100},{50,84}},
              lineColor={0,0,0},
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid,
              textStyle={TextStyle.Bold},
              textString="Heat storage side
")}));
    end BuffStorageExtHEx;

    model SolarThermal "Model of a solar thermal panel"
      import AixLib;
      extends AixLib.Fluid.HeatExchangers.BaseClasses.PartialHeatGen(
        volume(redeclare package Medium = Medium, V=MediumVolume),
        massFlowSensor(redeclare package Medium = Medium),
        T_in(redeclare package Medium = Medium));
      parameter Real MediumVolume = 0.2 "Medium volume in solar collector in m3";
      parameter Real A = 1 "Area of solar thermal collector in m2";
      parameter AixLib.DataBase.SolarThermal.SolarThermalBaseDataDefinition
        Collector = AixLib.DataBase.SolarThermal.SimpleAbsorber()
        "Properties of Solar Thermal Collector"                                                                                                     annotation(choicesAllMatching = true);
      Modelica.Blocks.Interfaces.RealInput T_air "Outdoor air temperature in K" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {-60, 108})));
      Modelica.Blocks.Interfaces.RealInput Irradiation
        "Solar irradiation on a horizontal plane in W/m2" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {10, 108})));
      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 34})));
      AixLib.Fluid.Solar.Thermal.BaseClasses.SolarThermalEfficiency
        solarThermalEfficiency(Collector=Collector)
        annotation (Placement(transformation(extent={{-76,48},{-56,68}})));
      Modelica.Blocks.Math.Max max1 annotation(Placement(transformation(extent = {{-46, 40}, {-26, 60}})));
      Modelica.Blocks.Sources.Constant const(k = 0) annotation(Placement(transformation(extent = {{-66, 30}, {-58, 38}})));
      Modelica.Blocks.Math.Gain gain(k = A) annotation(Placement(transformation(extent = {{-16, 44}, {-4, 56}})));
    equation
      connect(T_air, solarThermalEfficiency.T_air) annotation(Line(points = {{-60, 108}, {-60, 78}, {-71, 78}, {-71, 68.6}}, color = {0, 0, 127}));
      connect(solarThermalEfficiency.G, Irradiation) annotation(Line(points = {{-65, 68.6}, {-65, 74}, {10, 74}, {10, 108}}, color = {0, 0, 127}));
      connect(prescribedHeatFlow.port, volume.heatPort) annotation(Line(points={{0,24},{
              -10,10}},                                                                              color = {191, 0, 0}));
      connect(solarThermalEfficiency.Q_flow, max1.u1) annotation(Line(points = {{-55.2, 58}, {-52, 58}, {-52, 56}, {-48, 56}}, color = {0, 0, 127}));
      connect(const.y, max1.u2) annotation(Line(points = {{-57.6, 34}, {-54, 34}, {-54, 44}, {-48, 44}}, color = {0, 0, 127}));
      connect(max1.y, gain.u) annotation(Line(points = {{-25, 50}, {-17.2, 50}}, color = {0, 0, 127}));
      connect(gain.y, prescribedHeatFlow.Q_flow) annotation(Line(points = {{-3.4, 50}, {0, 50}, {0, 44}}, color = {0, 0, 127}));
      connect(T_in.T, solarThermalEfficiency.T_col) annotation (Line(
          points={{-70,11},{-71,47.4}},
          color={0,0,127}));
      annotation (Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p><br/>Model of a solar thermal collector. Inputs are outdoor air temperature and solar irradiation. Based on these values and the collector properties from database, this model creates a heat flow to the fluid circuit.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\"
    alt=\"stars: 3 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Concept</span></h4>
 <p>The model maps solar collector efficiency based on the equation</p>
 <p><img src=\"modelica://AixLib/Resources/Images/Fluid/HeatExchanger/SolarThermal/equation-vRK5Io7E.png\"
    alt=\"eta = eta_o - c_1 * deltaT / G - c_2 * deltaT^2/ G\"/></p>
 <h4><span style=\"color:#008000\">Known Limitations</span></h4>
 <ul>
 <li>Connected directly with Sources.TempAndRad, this model only represents a
    horizontal collector. There is no calculation for radiation on tilted
    surfaces. </li>
 <li>With the standard BaseParameters, this model uses water as working
    fluid</li>
 </ul>
 <p><b><font style=\"color: #008000; \">Example Results</font></b></p>
 <p><a href=\"AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector\">AixLib.HVAC.HeatGeneration.Examples.SolarThermalCollector</a></p>
 </html>",     revisions="<html>
 <ul>
 <li><i>December 15, 2016</i> by Moritz Lauster:<br/>Moved</li>
 <li><i>November 2014&nbsp;</i>
    by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class</li>
 <li><i>November 19, 2013&nbsp;</i>
    by Marcus Fuchs:<br/>
    Implemented</li>
 </ul>
 </html>"),     Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(extent = {{-80, 80}, {88, -80}}, lineColor = {255, 128, 0},
                fillPattern =                                                                                                   FillPattern.Solid, fillColor = {255, 128, 0}), Rectangle(extent = {{-70, 70}, {-64, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-70, 70}, {-40, 64}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-40, 70}, {-46, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-44, -72}, {-22, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-4, -72}, {22, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{2, 70}, {-4, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-24, 70}, {2, 64}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-24, 70}, {-18, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{40, -72}, {62, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{44, 70}, {38, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{18, 70}, {44, 64}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{18, 70}, {24, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{76, -72}, {96, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{82, 70}, {76, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{56, 70}, {82, 64}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{56, 70}, {62, -72}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent = {{-88, -72}, {-64, -66}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0},
                fillPattern =                                                                                                   FillPattern.Solid)}));
    end SolarThermal;
  end Components;

  extends Modelica.Icons.VariantsPackage;

  package Controller
    "Packages that contains controller blocks for district heating model "

    model SolCirController_TempIrradBased
      "Solar circuit controller based on temperatures and irradiation"
      Modelica.Blocks.Interfaces.RealInput CurrIrradiation annotation (Placement(
            transformation(extent={{-186,34},{-146,74}}), iconTransformation(
              extent={{-174,38},{-144,68}})));
      Modelica.Blocks.Tables.CombiTable1D TurnOnCurve(
        table=[-12,380; 15,180],
        tableOnFile=false,
        columns={2})
        annotation (Placement(transformation(extent={{-128,16},{-108,36}})));
      Modelica.Blocks.Interfaces.RealInput ambTemp
        "Ambient temperature in Celcius" annotation (Placement(transformation(
              extent={{-186,6},{-146,46}}), iconTransformation(extent={{-174,4},{
                -144,34}})));
      Modelica.Blocks.Math.Add add1(
                                   k2=-1)
        annotation (Placement(transformation(extent={{-84,22},{-64,42}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(
        uHigh=0,
        uLow=-100,
        pre_y_start=false)
                 annotation (Placement(transformation(extent={{-54,24},{-38,40}})));
      Modelica.Blocks.Interfaces.RealInput FlowTempSol
        "Flow temperature of solar collector" annotation (Placement(
            transformation(extent={{-186,-44},{-146,-4}}), iconTransformation(
              extent={{-174,-34},{-144,-4}})));
      Modelica.Blocks.Interfaces.RealInput StgTempBott
        "Temperature at the bottom of the storage" annotation (Placement(
            transformation(extent={{-186,-72},{-146,-32}}), iconTransformation(
              extent={{-174,-70},{-144,-40}})));
      Modelica.Blocks.Math.Add TempDifference(k2=-1)
        annotation (Placement(transformation(extent={{-112,-46},{-92,-26}})));
      Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
        annotation (Placement(transformation(extent={{84,-38},{104,-18}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{108,14},{128,34}})));
      Modelica.Blocks.Sources.Constant MassFlow(k=8)
        "Mass flow when the pump is on"
        annotation (Placement(transformation(extent={{68,52},{88,72}})));
      Modelica.Blocks.Sources.Constant MassFlowInput(k=0)
        "Mass Flow if the pump is off"
        annotation (Placement(transformation(extent={{52,6},{72,26}})));
      Modelica.Blocks.Interfaces.RealOutput MFSolColPump
        annotation (Placement(transformation(extent={{146,-15},{176,15}})));
      Modelica.Blocks.Interfaces.BooleanOutput OnOffSolPump
        annotation (Placement(transformation(extent={{146,40},{176,70}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis1(
        pre_y_start=false,
        uLow=2,
        uHigh=5) annotation (Placement(transformation(extent={{-74,-46},{-56,-27}})));
      Modelica.Blocks.Logical.And and2
        annotation (Placement(transformation(extent={{-6,-38},{14,-18}})));
    equation
      connect(TurnOnCurve.u[1], ambTemp)
        annotation (Line(points={{-130,26},{-166,26}}, color={0,0,127}));
      connect(CurrIrradiation, add1.u1) annotation (Line(points={{-166,54},{-96,
              54},{-96,38},{-86,38}}, color={0,0,127}));
      connect(TurnOnCurve.y[1], add1.u2)
        annotation (Line(points={{-107,26},{-86,26}}, color={0,0,127}));
      connect(add1.y, hysteresis.u)
        annotation (Line(points={{-63,32},{-55.6,32}}, color={0,0,127}));
      connect(FlowTempSol, TempDifference.u1) annotation (Line(points={{-166,-24},
              {-126,-24},{-126,-30},{-114,-30}}, color={0,0,127}));
      connect(MFSolColPump, MFSolColPump)
        annotation (Line(points={{161,0},{161,0}}, color={0,0,127}));
      connect(switch1.y, MFSolColPump) annotation (Line(points={{129,24},{140,24},
              {140,0},{161,0}}, color={0,0,127}));
      connect(TempDifference.y, hysteresis1.u) annotation (Line(points={{-91,-36},
              {-75.8,-36},{-75.8,-36.5}}, color={0,0,127}));
      connect(StgTempBott, TempDifference.u2) annotation (Line(points={{-166,-52},
              {-138,-52},{-138,-42},{-114,-42}}, color={0,0,127}));
      connect(hysteresis1.y, and2.u2) annotation (Line(points={{-55.1,-36.5},{-8,
              -36.5},{-8,-36}}, color={255,0,255}));
      connect(hysteresis.y, and2.u1) annotation (Line(points={{-37.2,32},{-24,32},
              {-24,-28},{-8,-28}}, color={255,0,255}));
      connect(and2.y, logicalSwitch.u2)
        annotation (Line(points={{15,-28},{82,-28}}, color={255,0,255}));
      connect(and2.y, logicalSwitch.u1) annotation (Line(points={{15,-28},{28,-28},
              {28,-20},{82,-20}}, color={255,0,255}));
      connect(logicalSwitch.y, switch1.u2) annotation (Line(points={{105,-28},{
              116,-28},{116,4},{88,4},{88,24},{106,24}}, color={255,0,255}));
      connect(MassFlow.y, switch1.u1) annotation (Line(points={{89,62},{96,62},{
              96,32},{106,32}}, color={0,0,127}));
      connect(MassFlowInput.y, switch1.u3)
        annotation (Line(points={{73,16},{106,16}},          color={0,0,127}));
      connect(logicalSwitch.y, OnOffSolPump) annotation (Line(points={{105,-28},{
              134,-28},{134,55},{161,55}}, color={255,0,255}));
      connect(hysteresis1.y, logicalSwitch.u3) annotation (Line(points={{-55.1,
              -36.5},{-40,-36.5},{-40,-48},{54,-48},{54,-36},{82,-36}}, color={
              255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
                -100},{160,100}}), graphics={Rectangle(
              extent={{-160,100},{160,-100}},
              lineColor={0,0,0},
              fillColor={202,234,243},
              fillPattern=FillPattern.Solid), Text(
              extent={{-58,34},{62,-60}},
              lineColor={0,0,0},
              fillColor={202,234,243},
              fillPattern=FillPattern.Solid,
              textString="Solar circuit 
Controller
")}),                                                                Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,
                100}})),
        experiment(StopTime=604800, Interval=5));
    end SolCirController_TempIrradBased;

    model StgCirController_TempBased
      "Storage circuit controller based on temperatures"

      Modelica.Blocks.Interfaces.BooleanInput OnOffSolPump annotation (Placement(
            transformation(extent={{-126,6},{-86,46}}), iconTransformation(extent=
               {{-106,18},{-82,42}})));
      Modelica.Blocks.Interfaces.RealInput FlowTempSol annotation (Placement(
            transformation(extent={{-126,-20},{-86,20}}), iconTransformation(
              extent={{-106,-14},{-82,10}})));
      Modelica.Blocks.Interfaces.RealInput StgTempBott annotation (Placement(
            transformation(extent={{-126,-48},{-86,-8}}), iconTransformation(
              extent={{-106,-46},{-82,-22}})));
      Modelica.Blocks.Math.Add add1(
                                   k2=-1)
        annotation (Placement(transformation(extent={{-64,-13},{-48,3}})));
      Modelica.Blocks.Logical.And and1
        annotation (Placement(transformation(extent={{16,16},{36,36}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{58,16},{78,36}})));
      Modelica.Blocks.Sources.Constant constMassFlow(k=8)
        annotation (Placement(transformation(extent={{16,48},{36,68}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(
        pre_y_start=false,
        uLow=2,
        uHigh=5) annotation (Placement(transformation(extent={{-32,-13},{-16,3}})));
      Modelica.Blocks.Sources.Constant constMassFlow1(k=0)
        annotation (Placement(transformation(extent={{16,-14},{36,6}})));
      Modelica.Blocks.Interfaces.RealOutput MFStgCirPump annotation (Placement(
            transformation(extent={{92,-16},{124,16}}), iconTransformation(extent=
               {{92,-13},{118,13}})));
      Modelica.Blocks.Interfaces.BooleanOutput OnOffStgCirPump annotation (
          Placement(transformation(extent={{96,36},{124,64}}), iconTransformation(
              extent={{92,18},{118,44}})));
    equation
      connect(FlowTempSol, add1.u1) annotation (Line(points={{-106,0},{-65.6,0},{
              -65.6,-0.2}}, color={0,0,127}));
      connect(StgTempBott, add1.u2) annotation (Line(points={{-106,-28},{-78,-28},
              {-78,-9.8},{-65.6,-9.8}}, color={0,0,127}));
      connect(OnOffSolPump, and1.u1)
        annotation (Line(points={{-106,26},{14,26}}, color={255,0,255}));
      connect(and1.y, switch1.u2)
        annotation (Line(points={{37,26},{46.5,26},{56,26}}, color={255,0,255}));
      connect(constMassFlow.y, switch1.u1) annotation (Line(points={{37,58},{46,
              58},{46,34},{56,34}}, color={0,0,127}));
      connect(add1.y, hysteresis.u)
        annotation (Line(points={{-47.2,-5},{-33.6,-5}}, color={0,0,127}));
      connect(hysteresis.y, and1.u2) annotation (Line(points={{-15.2,-5},{-4,-5},
              {-4,18},{14,18}}, color={255,0,255}));
      connect(constMassFlow1.y, switch1.u3) annotation (Line(points={{37,-4},{46,
              -4},{46,18},{56,18}}, color={0,0,127}));
      connect(MFStgCirPump, MFStgCirPump)
        annotation (Line(points={{108,0},{104.5,0},{108,0}}, color={0,0,127}));
      connect(switch1.y, MFStgCirPump) annotation (Line(points={{79,26},{84,26},{
              84,0},{108,0}}, color={0,0,127}));
      connect(and1.y, OnOffStgCirPump) annotation (Line(points={{37,26},{42,26},{
              42,50},{110,50}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={202,234,243},
              fillPattern=FillPattern.Solid), Text(
              extent={{-44,28},{48,-48}},
              lineColor={0,0,0},
              fillColor={202,234,243},
              fillPattern=FillPattern.Solid,
              textString="Storage Circuit
Controller
")}),                                                                Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end StgCirController_TempBased;

    model ModeBasedController "Mode-Based Controller for the buffer storage"
      Modelica.Blocks.Interfaces.RealInput Stg1TopTemp annotation (Placement(
            transformation(extent={{-203,-6},{-163,34}}), iconTransformation(
              extent={{-191,6},{-163,34}})));
      Modelica.Blocks.Interfaces.RealInput Stg2TopTemp annotation (Placement(
            transformation(extent={{-202,68},{-162,108}}), iconTransformation(
              extent={{-190,80},{-162,108}})));
      Modelica.Blocks.Interfaces.RealInput setPointStg2
        "Setpoint temperature at the top of the storage 2" annotation (Placement(
            transformation(extent={{-202,40},{-162,80}}), iconTransformation(
              extent={{-190,52},{-162,80}})));
      Modelica.Blocks.Logical.OnOffController
                                   less(             pre_y_start=true, bandwidth=
            5)
        annotation (Placement(transformation(extent={{-94,38},{-74,58}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(
        pre_y_start=false,
        uLow=5,
        uHigh=10)
        annotation (Placement(transformation(extent={{-94,-2},{-74,18}})));
      Modelica.Blocks.Math.Add add(k2=-1)
        annotation (Placement(transformation(extent={{-122,-2},{-102,18}})));
      Modelica.Blocks.Logical.And and1
        annotation (Placement(transformation(extent={{-54,16},{-34,36}})));
      Modelica.Blocks.Logical.Switch ValveOpDirSupp
        annotation (Placement(transformation(extent={{56,50},{76,70}})));
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-54,58},{-34,78}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{-12,22},{8,42}})));
      Modelica.Blocks.Logical.And and2
        annotation (Placement(transformation(extent={{-2,-52},{18,-32}})));
      Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-20,-6})));
      Modelica.Blocks.Logical.Switch ValveOpIndirSupp
        annotation (Placement(transformation(extent={{54,-53},{76,-31}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
        annotation (Placement(transformation(extent={{4,-16},{24,4}})));
      Modelica.Blocks.Sources.Constant const3(k=0)
        annotation (Placement(transformation(extent={{-4,-84},{16,-64}})));
      Modelica.Blocks.Interfaces.RealOutput ValveOpDir
        annotation (Placement(transformation(extent={{190,44},{220,74}})));
      Modelica.Blocks.Interfaces.RealOutput ValveOpIndir
        annotation (Placement(transformation(extent={{192,-38},{222,-8}})));
      Modelica.Blocks.Logical.Switch MFDir
        annotation (Placement(transformation(extent={{126,2},{146,22}})));
      Modelica.Blocks.Sources.Constant const4(k=4)
        annotation (Placement(transformation(extent={{84,24},{104,44}})));
      Modelica.Blocks.Sources.Constant const5(k=0)
        annotation (Placement(transformation(extent={{84,-16},{104,4}})));
      Modelica.Blocks.Logical.Switch MFIndir
        annotation (Placement(transformation(extent={{148,-78},{168,-58}})));
      Modelica.Blocks.Sources.Constant const6(k=10)
        annotation (Placement(transformation(extent={{98,-58},{118,-38}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{90,-94},{110,-74}})));
      Modelica.Blocks.Interfaces.RealOutput MFDirSupp
        annotation (Placement(transformation(extent={{190,14},{220,44}})));
      Modelica.Blocks.Interfaces.RealOutput evaMF
        annotation (Placement(transformation(extent={{192,-68},{222,-38}})));
      Modelica.Blocks.Interfaces.BooleanOutput IndirSuppSignal annotation (
          Placement(transformation(
            extent={{-14,-14},{14,14}},
            rotation=270,
            origin={68,-198})));
      Modelica.Blocks.Interfaces.BooleanOutput DirSuppSignal annotation (
          Placement(transformation(
            extent={{-14,-14},{14,14}},
            rotation=270,
            origin={46,-198}), iconTransformation(
            extent={{-14,-14},{14,14}},
            rotation=270,
            origin={34,-198})));
      Modelica.Blocks.Continuous.LimPID setPointSelection(controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMax=80,
        yMin=50,
        Ti=10,
        k=0.005)
        annotation (Placement(transformation(extent={{-112,-142},{-90,-120}})));
      Modelica.Blocks.Logical.Switch RPM "Rotational speed of the compressor"
        annotation (Placement(transformation(extent={{-6,-142},{14,-122}})));
      Modelica.Blocks.Sources.Constant const8(k=0)
        annotation (Placement(transformation(extent={{-42,-172},{-22,-152}})));
      Modelica.Blocks.Interfaces.RealOutput CompRPM
        annotation (Placement(transformation(extent={{188,-194},{220,-162}})));
      Modelica.Blocks.Interfaces.RealInput HPCondTemp annotation (Placement(
            transformation(extent={{-206,-192},{-166,-152}}), iconTransformation(
              extent={{-194,-180},{-166,-152}})));
      Modelica.Blocks.Logical.Switch MFIndir1
        annotation (Placement(transformation(extent={{150,-136},{170,-116}})));
      Modelica.Blocks.Sources.Constant const9(k=10)
        annotation (Placement(transformation(extent={{110,-118},{130,-98}})));
      Modelica.Blocks.Sources.Constant const10(k=0)
        annotation (Placement(transformation(extent={{108,-162},{128,-142}})));
      Modelica.Blocks.Interfaces.RealOutput conMF
        annotation (Placement(transformation(extent={{194,-140},{224,-110}})));
      AixLib.Controls.Continuous.LimPID conPID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMax=3700,
        yMin=800,
        Ti=1,
        k=1)  annotation (Placement(transformation(extent={{-62,-141},{-42,-121}})));
    equation
      connect(Stg1TopTemp, add.u1)
        annotation (Line(points={{-183,14},{-124,14}}, color={0,0,127}));
      connect(add.y, hysteresis.u)
        annotation (Line(points={{-101,8},{-96,8}}, color={0,0,127}));
      connect(less.y, and1.u1) annotation (Line(points={{-73,48},{-70,48},{-70,26},
              {-56,26}}, color={255,0,255}));
      connect(hysteresis.y, and1.u2) annotation (Line(points={{-73,8},{-70,8},{
              -70,18},{-56,18}}, color={255,0,255}));
      connect(and1.y, ValveOpDirSupp.u2) annotation (Line(points={{-33,26},{-20,
              26},{-20,60},{54,60}}, color={255,0,255}));
      connect(const.y, ValveOpDirSupp.u1)
        annotation (Line(points={{-33,68},{54,68}}, color={0,0,127}));
      connect(const1.y, ValveOpDirSupp.u3) annotation (Line(points={{9,32},{12,32},
              {12,52},{54,52}}, color={0,0,127}));
      connect(and2.u2, and1.u1) annotation (Line(points={{-4,-50},{-64,-50},{-64,
              26},{-56,26}}, color={255,0,255}));
      connect(and1.y, not1.u)
        annotation (Line(points={{-33,26},{-20,26},{-20,6}}, color={255,0,255}));
      connect(not1.y, and2.u1) annotation (Line(points={{-20,-17},{-20,-42},{-4,
              -42}}, color={255,0,255}));
      connect(and2.y, ValveOpIndirSupp.u2)
        annotation (Line(points={{19,-42},{51.8,-42}}, color={255,0,255}));
      connect(const2.y, ValveOpIndirSupp.u1) annotation (Line(points={{25,-6},{42,
              -6},{42,-33.2},{51.8,-33.2}}, color={0,0,127}));
      connect(const3.y, ValveOpIndirSupp.u3) annotation (Line(points={{17,-74},{
              44,-74},{44,-50.8},{51.8,-50.8}}, color={0,0,127}));
      connect(ValveOpDirSupp.y, ValveOpDir)
        annotation (Line(points={{77,60},{205,60},{205,59}}, color={0,0,127}));
      connect(MFDir.u2, ValveOpDirSupp.u2) annotation (Line(points={{124,12},{36,
              12},{36,60},{54,60}}, color={255,0,255}));
      connect(const4.y, MFDir.u1) annotation (Line(points={{105,34},{112,34},{112,
              20},{124,20}}, color={0,0,127}));
      connect(const5.y, MFDir.u3) annotation (Line(points={{105,-6},{114,-6},{114,
              4},{124,4}}, color={0,0,127}));
      connect(MFIndir.u2, ValveOpIndirSupp.u2) annotation (Line(points={{146,-68},
              {34,-68},{34,-42},{51.8,-42}}, color={255,0,255}));
      connect(ValveOpIndirSupp.y, ValveOpIndir) annotation (Line(points={{77.1,
              -42},{82,-42},{86,-42},{86,-23},{207,-23}}, color={0,0,127}));
      connect(const6.y, MFIndir.u1) annotation (Line(points={{119,-48},{124,-48},
              {124,-60},{146,-60}}, color={0,0,127}));
      connect(const7.y, MFIndir.u3) annotation (Line(points={{111,-84},{126,-84},
              {126,-76},{146,-76}}, color={0,0,127}));
      connect(MFDir.y, MFDirSupp) annotation (Line(points={{147,12},{158,12},{158,
              29},{205,29}}, color={0,0,127}));
      connect(MFIndir.y, evaMF) annotation (Line(points={{169,-68},{180,-68},{180,
              -53},{207,-53}}, color={0,0,127}));
      connect(IndirSuppSignal, ValveOpIndirSupp.u2) annotation (Line(points={{68,
              -198},{68,-68},{34,-68},{34,-42},{51.8,-42}}, color={255,0,255}));
      connect(DirSuppSignal, ValveOpDirSupp.u2) annotation (Line(points={{46,-198},
              {46,12},{36,12},{36,60},{54,60}}, color={255,0,255}));
      connect(Stg2TopTemp, setPointSelection.u_m) annotation (Line(points={{-182,
              88},{-132,88},{-132,-162},{-101,-162},{-101,-144.2}}, color={0,0,
              127}));
      connect(RPM.u2, ValveOpIndirSupp.u2) annotation (Line(points={{-8,-132},{
              -16,-132},{-16,-104},{68,-104},{68,-68},{34,-68},{34,-42},{51.8,-42}},
            color={255,0,255}));
      connect(const8.y, RPM.u3) annotation (Line(points={{-21,-162},{-14,-162},{
              -14,-140},{-8,-140}},color={0,0,127}));
      connect(RPM.y, CompRPM) annotation (Line(points={{15,-132},{32,-132},{32,
              -178},{204,-178}}, color={0,0,127}));
      connect(MFIndir1.u2, ValveOpIndirSupp.u2) annotation (Line(points={{148,
              -126},{68,-126},{68,-68},{34,-68},{34,-42},{51.8,-42}}, color={255,
              0,255}));
      connect(const9.y, MFIndir1.u1) annotation (Line(points={{131,-108},{138,
              -108},{138,-118},{148,-118}}, color={0,0,127}));
      connect(const10.y, MFIndir1.u3) annotation (Line(points={{129,-152},{136,
              -152},{136,-134},{148,-134}}, color={0,0,127}));
      connect(MFIndir1.y, conMF) annotation (Line(points={{171,-126},{209,-126},{
              209,-125}}, color={0,0,127}));
      connect(Stg2TopTemp, less.u) annotation (Line(points={{-182,88},{-128,88},{
              -128,42},{-96,42}}, color={0,0,127}));
      connect(setPointStg2, less.reference) annotation (Line(points={{-182,60},{
              -112,60},{-112,54},{-96,54}}, color={0,0,127}));
      connect(setPointStg2, setPointSelection.u_s) annotation (Line(points={{-182,
              60},{-140,60},{-140,-131},{-114.2,-131}}, color={0,0,127}));
      connect(Stg2TopTemp, add.u2) annotation (Line(points={{-182,88},{-152,88},{
              -152,2},{-124,2}}, color={0,0,127}));
      connect(setPointSelection.y, conPID.u_s) annotation (Line(points={{-88.9,
              -131},{-78,-131},{-64,-131}}, color={0,0,127}));
      connect(HPCondTemp, conPID.u_m) annotation (Line(points={{-186,-172},{-52,
              -172},{-52,-143}}, color={0,0,127}));
      connect(conPID.y, RPM.u1) annotation (Line(points={{-41,-131},{-26,-131},{
              -26,-124},{-8,-124}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
                -200},{200,100}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-180,-200},{200,
                100}}), graphics={Rectangle(
              extent={{-180,-100},{26,-200}},
              lineColor={28,108,200},
              fillColor={255,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-64,-188},{36,-194}},
              lineColor={28,108,200},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              textString="Cascade controller to control the 
temperature at condensor outlet"),
            Text(
              extent={{-118,96},{-66,78}},
              lineColor={238,46,47},
              textString="Stg1 = Seasonal storage
Stg2 = Buffer storage 
",            horizontalAlignment=TextAlignment.Left)}));
    end ModeBasedController;

    model BackupController "Controller for backup system"
      Modelica.Blocks.Interfaces.RealInput FlowTempSDH annotation (Placement(
            transformation(extent={{-163,-2},{-127,34}}), iconTransformation(
              extent={{-147,-12},{-122,12}})));
      Modelica.Blocks.Interfaces.RealInput buffStgSetpoint annotation (Placement(
            transformation(extent={{-163,34},{-126,72}}),  iconTransformation(
              extent={{-147,44},{-122,70}})));
      AixLib.Controls.Continuous.LimPID conPID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMin=0,
        yMax=1,
        k=0.001,
        Ti=10)
              annotation (Placement(transformation(extent={{-8,-8},{8,8}},
            rotation=0,
            origin={-20,53})));
      Modelica.Blocks.Logical.Switch Switcher annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={26,0})));
      Modelica.Blocks.Sources.Constant ValveOp(k=0) annotation (Placement(
            transformation(
            extent={{-8,-8},{8,8}},
            rotation=0,
            origin={-20,-30})));

      Modelica.Blocks.Interfaces.RealOutput AuxValve annotation (Placement(
            transformation(extent={{136,-32},{160,-8}}), iconTransformation(
              extent={{132,-11},{154,11}})));
      Modelica.Blocks.Logical.Switch Switcher1 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={26,-56})));
      Modelica.Blocks.Sources.Constant ValveOp1(k=0) annotation (Placement(
            transformation(
            extent={{-8,-8},{8,8}},
            rotation=0,
            origin={-20,-84})));
      Modelica.Blocks.Sources.Constant MassFlowCHP(k=0.5)
                                                        annotation (Placement(
            transformation(
            extent={{-8,-8},{8,8}},
            rotation=0,
            origin={-20,-56})));
      Modelica.Blocks.Interfaces.RealOutput MasFlowcHP annotation (Placement(
            transformation(extent={{128,-66},{154,-40}}), iconTransformation(
              extent={{132,-62},{154,-40}})));
      Modelica.Blocks.Logical.OnOffController TempBand(pre_y_start=false,
          bandwidth=5) annotation (Placement(transformation(
            extent={{-9,-9},{9,9}},
            rotation=0,
            origin={-91,-5})));
      Modelica.Blocks.Math.Add add(k2=-1)
        annotation (Placement(transformation(extent={{86,30},{106,50}})));
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{48,54},{64,70}})));
      Modelica.Blocks.Interfaces.RealOutput BypassValve annotation (Placement(
            transformation(extent={{136,27},{162,53}}), iconTransformation(extent=
               {{132,33},{154,56}})));
      Modelica.Blocks.Interfaces.RealInput buffStgTopTemp annotation (Placement(
            transformation(extent={{-163,-46},{-127,-10}}), iconTransformation(
              extent={{-145,-68},{-120,-42}})));
      Modelica.Blocks.Logical.And and1
        annotation (Placement(transformation(extent={{-56,-15},{-36,5}})));
      Modelica.Blocks.Logical.Less and2
        annotation (Placement(transformation(extent={{-100,-44},{-82,-25}})));
      Modelica.Blocks.Sources.Constant lowerLimit(k=2.5) annotation (Placement(
            transformation(
            extent={{-8,-8},{8,8}},
            rotation=0,
            origin={-126,-86})));
      Modelica.Blocks.Math.Add add1(
                                   k2=-1)
        annotation (Placement(transformation(extent={{-100,-78},{-84,-62}})));
    equation
      connect(ValveOp.y, Switcher.u3) annotation (Line(points={{-11.2,-30},{0,-30},
              {0,-8},{14,-8}}, color={0,0,127}));
      connect(buffStgSetpoint, conPID.u_s) annotation (Line(points={{-144.5,53},{
              -72,53},{-29.6,53}},            color={0,0,127}));
      connect(conPID.u_m, FlowTempSDH) annotation (Line(points={{-20,43.4},{-20,
              16},{-145,16}}, color={0,0,127}));
      connect(conPID.y, Switcher.u1) annotation (Line(points={{-11.2,53},{0,53},{
              0,8},{14,8}}, color={0,0,127}));
      connect(Switcher.y, AuxValve) annotation (Line(points={{37,0},{54,0},{54,
              -20},{148,-20}}, color={0,0,127}));
      connect(Switcher1.u2, Switcher.u2) annotation (Line(points={{14,-56},{8,-56},
              {4,-56},{4,0},{14,0}},         color={255,0,255}));
      connect(ValveOp1.y, Switcher1.u3) annotation (Line(points={{-11.2,-84},{4,
              -84},{4,-64},{14,-64}}, color={0,0,127}));
      connect(Switcher1.u1, MassFlowCHP.y) annotation (Line(points={{14,-48},{10,
              -48},{-4,-48},{-4,-56},{-11.2,-56}}, color={0,0,127}));
      connect(Switcher1.y,MasFlowcHP)  annotation (Line(points={{37,-56},{74,-56},
              {74,-53},{141,-53}}, color={0,0,127}));
      connect(const.y, add.u1) annotation (Line(points={{64.8,62},{70,62},{70,46},
              {84,46}}, color={0,0,127}));
      connect(add.u2, AuxValve) annotation (Line(points={{84,34},{54,34},{54,-20},
              {148,-20}}, color={0,0,127}));
      connect(add.y, BypassValve)
        annotation (Line(points={{107,40},{128,40},{149,40}}, color={0,0,127}));
      connect(TempBand.y, and1.u1) annotation (Line(points={{-81.1,-5},{-72,-5},{
              -58,-5}}, color={255,0,255}));
      connect(TempBand.u, buffStgTopTemp) annotation (Line(points={{-101.8,-10.4},
              {-118,-10.4},{-118,-28},{-145,-28}}, color={0,0,127}));
      connect(and2.y, and1.u2) annotation (Line(points={{-81.1,-34.5},{-74,-34.5},
              {-74,-13},{-58,-13}}, color={255,0,255}));
      connect(and1.y, Switcher.u2) annotation (Line(points={{-35,-5},{-28,-5},{
              -28,0},{14,0}}, color={255,0,255}));
      connect(and2.u1, buffStgTopTemp) annotation (Line(points={{-101.8,-34.5},{
              -118,-34.5},{-118,-28},{-145,-28}}, color={0,0,127}));
      connect(TempBand.reference, conPID.u_s) annotation (Line(points={{-101.8,
              0.4},{-110,0.4},{-110,53},{-72,53},{-29.6,53}}, color={0,0,127}));
      connect(lowerLimit.y, add1.u2) annotation (Line(points={{-117.2,-86},{-112,
              -86},{-112,-74.8},{-101.6,-74.8}}, color={0,0,127}));
      connect(add1.u1, conPID.u_s) annotation (Line(points={{-101.6,-65.2},{-110,
              -65.2},{-110,53},{-29.6,53}}, color={0,0,127}));
      connect(add1.y, and2.u2) annotation (Line(points={{-83.2,-70},{-72,-70},{
              -72,-52},{-126,-52},{-126,-42.1},{-101.8,-42.1}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
                -100},{140,100}}), graphics={Rectangle(
              extent={{-140,100},{140,-100}},
              lineColor={0,0,0},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-26,-2},{24,-34}},
              lineColor={255,255,255},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid,
              textString="%name
")}),   Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{
                140,100}})));
    end BackupController;

    model SolarDistrictHeatingController "Controller model for solar district heating "

      AixLib.Fluid.DistrictHeating.Controller.StgCirController_TempBased
        stgCirController_TempBased
        annotation (Placement(transformation(extent={{-8,-4},{22,20}})));
      AixLib.Fluid.DistrictHeating.Controller.SolCirController_TempIrradBased
        solCirController_TempIrradBased
        annotation (Placement(transformation(extent={{-64,16},{-28,42}})));
      Modelica.Blocks.Interfaces.RealInput CurrIrrad "measured irradiation"
        annotation (Placement(transformation(extent={{-124,34},{-88,70}}),
            iconTransformation(extent={{-122,30},{-100,52}})));
      Modelica.Blocks.Interfaces.RealInput SeasStgBotTemp
        "Storage temperature at the bottom" annotation (Placement(transformation(
              extent={{-124,-40},{-88,-4}}), iconTransformation(extent={{-122,-12},
                {-100,10}})));
      Modelica.Blocks.Interfaces.RealInput FlowTempSol
        "Solar flow temperature in C" annotation (Placement(transformation(extent={{-124,
                -14},{-88,22}}),      iconTransformation(extent={{-122,-56},{-100,
                -34}})));
      Modelica.Blocks.Interfaces.RealInput AmbTemp "ambient temperature in C"
        annotation (Placement(transformation(extent={{-124,10},{-88,46}}),
            iconTransformation(extent={{-122,10},{-100,32}})));
      Modelica.Blocks.Interfaces.RealOutput MFSolCirPump annotation (Placement(
            transformation(extent={{176,64},{200,88}}),iconTransformation(extent={{188,62},
                {206,80}})));
      Modelica.Blocks.Interfaces.RealOutput MFStgCirPump annotation (Placement(
            transformation(extent={{176,46},{200,70}}),  iconTransformation(
              extent={{188,44},{206,62}})));
      Modelica.Blocks.Interfaces.BooleanOutput SolColPump annotation (Placement(
            transformation(extent={{-12,-12},{12,12}},
            rotation=90,
            origin={50,82}),                           iconTransformation(extent={{-12,-12},
                {12,12}},
            rotation=90,
            origin={26,80})));
      Modelica.Blocks.Interfaces.BooleanOutput StgCirPump annotation (Placement(
            transformation(extent={{-12,-12},{12,12}},
            rotation=90,
            origin={72,82}),                             iconTransformation(
              extent={{-12,-12},{12,12}},
            rotation=90,
            origin={54,80})));
      Modelica.Blocks.Interfaces.RealInput SeasStgTopTemp
        "Storage temperature at the top" annotation (Placement(transformation(
              extent={{-126,-66},{-88,-28}}), iconTransformation(extent={{-122,
                -34},{-100,-12}})));
      Modelica.Blocks.Interfaces.RealInput setPointBuffStg
        "Set point temperature of buffer storage in [°C]"
                                                  annotation (Placement(
            transformation(extent={{-125,58},{-87,96}}), iconTransformation(
              extent={{-122,52},{-100,74}})));
      Modelica.Blocks.Interfaces.RealOutput ValveOpIndir annotation (Placement(
            transformation(extent={{176,13},{200,37}}),  iconTransformation(
              extent={{188,9},{206,26}})));
      Modelica.Blocks.Interfaces.RealOutput ValveOpDir annotation (Placement(
            transformation(extent={{176,30},{200,54}}),iconTransformation(extent={{188,26},
                {206,44}})));
      AixLib.Fluid.DistrictHeating.Controller.ModeBasedController
        stateMachine
        annotation (Placement(transformation(extent={{-8,-52},{22,-28}})));
      Modelica.Blocks.Interfaces.RealOutput EvaMF
        annotation (Placement(transformation(extent={{176,-2},{200,22}}),
            iconTransformation(extent={{188,-10},{206,8}})));
      Modelica.Blocks.Interfaces.RealOutput ConMF
        annotation (Placement(transformation(extent={{176,-18},{200,6}}),
            iconTransformation(extent={{188,-28},{206,-10}})));
      Modelica.Blocks.Interfaces.RealOutput DirSuppMF
        annotation (Placement(transformation(extent={{176,-34},{200,-10}}),
            iconTransformation(extent={{188,-46},{206,-28}})));
      Modelica.Blocks.Interfaces.RealInput TopTempBuffStg
        "Top temperature of the buffer storage in [°C]" annotation (Placement(
            transformation(
            extent={{-19,-19},{19,19}},
            rotation=90,
            origin={-67,-85}), iconTransformation(
            extent={{-11,-11},{11,11}},
            rotation=270,
            origin={-73,74})));
      Modelica.Blocks.Interfaces.BooleanOutput hpSignal
        "OnOff signal of the heat pump" annotation (Placement(transformation(
            extent={{-12,-12},{12,12}},
            rotation=270,
            origin={16,-86}), iconTransformation(
            extent={{-11,-11},{11,11}},
            rotation=270,
            origin={25,-77})));
      Modelica.Blocks.Interfaces.BooleanOutput DirSupp annotation (Placement(
            transformation(
            extent={{-12,-12},{12,12}},
            rotation=270,
            origin={-2,-86}), iconTransformation(
            extent={{-11,-11},{11,11}},
            rotation=270,
            origin={-1,-77})));
      Modelica.Blocks.Interfaces.RealOutput hpRPM annotation (Placement(
            transformation(
            extent={{-12,-12},{12,12}},
            rotation=270,
            origin={36,-86}), iconTransformation(
            extent={{-11,-11},{11,11}},
            rotation=270,
            origin={51,-77})));
      Modelica.Blocks.Interfaces.RealInput hpCondTemp
        "Flow temperature of condensator in C" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-22,-85}), iconTransformation(
            extent={{-11,-11},{11,11}},
            rotation=0,
            origin={-111,-65})));
      AixLib.Fluid.DistrictHeating.Controller.BackupController
        BackupSystemController
        annotation (Placement(transformation(extent={{62,-26},{104,4}})));
      Modelica.Blocks.Interfaces.RealInput FlowTempSDH
        "Flow temperature of the solar district heating network in [°C]"
        annotation (Placement(transformation(extent={{-127,-94},{-87,-54}}),
            iconTransformation(extent={{-11,-10.5},{11,10.5}},
            rotation=270,
            origin={-49,74.5})));
      Modelica.Blocks.Interfaces.RealOutput valOpBypass annotation (Placement(
            transformation(extent={{176,-56},{200,-32}}), iconTransformation(
              extent={{188,-64},{206,-46}})));
      Modelica.Blocks.Interfaces.RealOutput valOpAux annotation (Placement(
            transformation(extent={{176,-74},{200,-50}}), iconTransformation(
              extent={{188,-82},{206,-64}})));
    equation
      connect(CurrIrrad, solCirController_TempIrradBased.CurrIrradiation)
        annotation (Line(points={{-106,52},{-82,52},{-82,35.89},{-63.8875,35.89}},
            color={0,0,127}));
      connect(AmbTemp, solCirController_TempIrradBased.ambTemp) annotation (Line(
            points={{-106,28},{-82,28},{-82,31.47},{-63.8875,31.47}},
                                                                    color={0,0,
              127}));
      connect(FlowTempSol, solCirController_TempIrradBased.FlowTempSol)
        annotation (Line(points={{-106,4},{-106,10},{-78,10},{-78,26.53},{
              -63.8875,26.53}}, color={0,0,127}));
      connect(SeasStgBotTemp, solCirController_TempIrradBased.StgTempBott)
        annotation (Line(points={{-106,-22},{-72,-22},{-72,21.85},{-63.8875,21.85}},
            color={0,0,127}));
      connect(FlowTempSol, stgCirController_TempBased.FlowTempSol) annotation (
          Line(points={{-106,4},{-40,4},{-40,7.76},{-7.1,7.76}},     color={0,0,
              127}));
      connect(SeasStgBotTemp, stgCirController_TempBased.StgTempBott) annotation (
         Line(points={{-106,-22},{-24,-22},{-24,3.92},{-7.1,3.92}}, color={0,0,
              127}));
      connect(solCirController_TempIrradBased.MFSolColPump, MFSolCirPump)
        annotation (Line(points={{-27.8875,29},{130,29},{130,76},{188,76}},
                                                                          color={
              0,0,127}));
      connect(setPointBuffStg, stateMachine.setPointStg2) annotation (Line(points={{-106,77},
              {-76,77},{-76,-30.72},{-7.68421,-30.72}},           color={0,0,127}));
      connect(SeasStgTopTemp, stateMachine.Stg1TopTemp) annotation (Line(points={{-107,
              -47},{-58,-47},{-58,-34.4},{-7.76316,-34.4}},       color={0,0,127}));
      connect(stateMachine.ValveOpDir, ValveOpDir) annotation (Line(points={{22.3947,
              -31.28},{144,-31.28},{144,42},{188,42}},
                                                     color={0,0,127}));
      connect(stateMachine.ValveOpIndir, ValveOpIndir) annotation (Line(points={{22.5526,
              -37.84},{148,-37.84},{148,25},{188,25}}, color={0,0,127}));
      connect(TopTempBuffStg, stateMachine.Stg2TopTemp) annotation (Line(points={{-67,-85},
              {-67,-60},{-24,-60},{-24,-28.48},{-7.68421,-28.48}},
            color={0,0,127}));
      connect(stateMachine.MFDirSupp, DirSuppMF) annotation (Line(points={{22.3947,
              -33.68},{130,-33.68},{130,-22},{188,-22}},
                                               color={0,0,127}));
      connect(stateMachine.IndirSuppSignal, hpSignal) annotation (Line(points={{11.5789,
              -51.84},{11.5789,-64},{16,-64},{16,-86}},         color={255,0,255}));
      connect(stateMachine.DirSuppSignal, DirSupp) annotation (Line(points={{8.89474,
              -51.84},{8.89474,-64},{-2,-64},{-2,-86}}, color={255,0,255}));
      connect(solCirController_TempIrradBased.OnOffSolPump, SolColPump) annotation (
         Line(points={{-27.8875,36.15},{-27.8875,36},{14,36},{14,62},{50,62},{50,82}},
            color={255,0,255}));
      connect(stgCirController_TempBased.OnOffStgCirPump, StgCirPump) annotation (
          Line(points={{22.75,11.72},{22.75,12},{72,12},{72,82}}, color={255,0,255}));
      connect(stgCirController_TempBased.OnOffSolPump, SolColPump) annotation (Line(
            points={{-7.1,11.6},{-14,11.6},{-14,36},{14,36},{14,62},{50,62},{50,82}},
            color={255,0,255}));
      connect(stateMachine.CompRPM, hpRPM) annotation (Line(points={{22.3158,
              -50.24},{36,-50.24},{36,-86}}, color={0,0,127}));
      connect(hpCondTemp, stateMachine.HPCondTemp) annotation (Line(points={{-22,-85},
              {-22,-49.28},{-8,-49.28}},      color={0,0,127}));
      connect(stateMachine.evaMF, EvaMF) annotation (Line(points={{22.5526,
              -40.24},{156,-40.24},{156,10},{188,10}},
                                               color={0,0,127}));
      connect(stateMachine.conMF, ConMF) annotation (Line(points={{22.7105,-46},
              {150,-46},{150,-6},{188,-6}},color={0,0,127}));
      connect(stgCirController_TempBased.MFStgCirPump, MFStgCirPump) annotation (
          Line(points={{22.75,8},{138,8},{138,58},{188,58}},
                                                           color={0,0,127}));
      connect(setPointBuffStg, BackupSystemController.buffStgSetpoint)
        annotation (Line(points={{-106,77},{-56,77},{-56,44},{52,44},{52,-2.45},{
              62.825,-2.45}}, color={0,0,127}));
      connect(FlowTempSDH, BackupSystemController.FlowTempSDH) annotation (Line(
            points={{-107,-74},{-94,-74},{-84,-74},{-84,-11},{62.825,-11}}, color=
             {0,0,127}));
      connect(TopTempBuffStg, BackupSystemController.buffStgTopTemp) annotation (
          Line(points={{-67,-85},{-67,-19.25},{63.125,-19.25}}, color={0,0,127}));
      connect(BackupSystemController.BypassValve, valOpBypass) annotation (Line(
            points={{104.45,-4.325},{164,-4.325},{164,-44},{188,-44}}, color={0,0,
              127}));
      connect(BackupSystemController.AuxValve, valOpAux) annotation (Line(points=
              {{104.45,-11},{130,-11},{130,-62},{188,-62}}, color={0,0,127}));
      connect(DirSuppMF, DirSuppMF) annotation (Line(points={{188,-22},{184,-22},
              {184,-22},{188,-22}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
                -80},{200,80}}), graphics={Rectangle(
              extent={{-120,80},{200,-80}},
              lineColor={0,0,0},
              fillColor={66,143,244},
              fillPattern=FillPattern.Solid), Text(
              extent={{26,4},{64,-22}},
              lineColor={255,255,255},
              textString="%name
")}),                                           Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-120,-80},{200,80}}), graphics={
              Rectangle(
              extent={{-38,80},{28,72}},
              lineColor={33,130,241},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
              Text(
              extent={{-30,82},{22,64}},
              lineColor={0,0,255},
              fillColor={202,234,243},
              fillPattern=FillPattern.Solid,
              textString="***All temperature inputs should be in Celcius*** 

")}),   Documentation(info="<html>
<h4>Overview</h4>
<p>This model represents a mode-based controller for the heat generation unit. The controller comprises following blocks: </p>
<ol>
<li>&QUOT;Solar circuit controller&QUOT; block which controls the pump in the solar circuit</li>
<li>&QUOT;Storage circuit controller&QUOT; block which controls the pump in the seasonal storage circuit</li>
<li>&QUOT;StateMachine&QUOT; block in which operation modes are defined</li>
<li>&QUOT;BackupSystemController&QUOT; block which controls control vavles after the buffer storage  </li>
</ol>
</html>"));
    end SolarDistrictHeatingController;
  end Controller;

  package BaseClasses
    extends Modelica.Icons.BasesPackage;
    package Functions
      extends Modelica.Icons.Package;
      package Characteristics
        extends Modelica.Icons.Package;
        function BaseFct
          input Real N;
          input Real T_con;
          input Real T_eva;
          input Real mFlow_eva;
          input Real mFlow_con;
          output Real Char[2];
        end BaseFct;

        function VariableNrpm
          "Electrical power calculation dependent on variable rotational speed (rpm)"
          extends
            AixLib.Fluid.DistrictHeating.BaseClasses.Functions.Characteristics.BaseFct(
            N,
            T_con,
            T_eva,
            mFlow_eva,
            mFlow_con);
             parameter Real qualityGrade=0.3 "Constant quality grade";
             parameter Real N_max= 3000 "Maximum speed of compressor in 1/min";
             parameter Modelica.SIunits.Power P_com=23000 "Maximum electric power input for compressor";

        protected
            Real CoP_C "Carnot CoP";
            Real Pel_curr "Current electrical power dependent on rotational speed";
        algorithm
          Pel_curr:=((N/N_max)^3)*P_com;
          CoP_C:=T_con/(T_con - T_eva);
          Char:= {Pel_curr,Pel_curr*CoP_C*qualityGrade};

        end VariableNrpm;
      end Characteristics;
    end Functions;
  end BaseClasses;

  partial model SolarDistrictHeating_BaseClass
    "Base class of a solar district heating  "

    replaceable package Medium = AixLib.Media.Water;

    AixLib.Fluid.DistrictHeating.Components.BuffStorageExtHEx heatStorageSolarColl
      annotation (Placement(transformation(extent={{-330,-56},{-286,-15}})));
    AixLib.Fluid.DistrictHeating.Components.SolarThermal solarCollector(
      Collector=AixLib.DataBase.SolarThermal.FlatCollector(),
      show_T=true,
      redeclare package Medium = Medium,
      MediumVolume=2,
      m_flow_nominal=10,
      T_ref=313.15,
      A=200) annotation (Placement(transformation(
          extent={{-18,-18},{18,18}},
          rotation=180,
          origin={-426,63})));

    AixLib.Fluid.Movers.FlowControlled_m_flow SolarLoopPump(
                                            redeclare package Medium =
          Medium, m_flow_nominal=12)         annotation (Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-377,63})));

    AixLib.Fluid.Sources.FixedBoundary bou(          nPorts=1,
      redeclare package Medium = Medium,
      p=200000)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-356,38})));

    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{326,306},{360,338}})));
    AixLib.Fluid.HeatPumps.HeatPumpDetailed heatPump(
      P_eleOutput=true,
      CoP_output=true,
      HPctrlType=false,
          redeclare package Medium_con =
          Medium,
      redeclare package Medium_eva =
          Medium,
      mFlow_evaNominal=2,
      mFlow_conNominal=2,
      N_min=800,
      volume_eva=0.1,
      volume_con=0.1,
      N_max=3700,
      redeclare replaceable function data_poly =
          AixLib.Fluid.DistrictHeating.BaseClasses.Functions.Characteristics.VariableNrpm
          (N_max=3700, P_com=60000),
      T_startEva=303.15,
      T_startCon=313.15,
      T_conMax=353.15)
      annotation (Placement(transformation(extent={{-206,-48},{-146,-8}})));
    AixLib.Fluid.DistrictHeating.Components.DividerUnit dividerUnit(
        redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-212,53},{-192,73}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort TempCondOut(redeclare package
        Medium =                                                                   Medium,
        m_flow_nominal=10) annotation (Placement(transformation(extent={{-128,2},{
              -108,22}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort FlowTempDirSupp( redeclare package
        Medium =                                                                        Medium,
        m_flow_nominal=10)
      annotation (Placement(transformation(extent={{-148,52},{-126,74}})));
    AixLib.Fluid.Storage.BufferStorage bufferStorage(
      useHeatingRod=false,
      upToDownHC2=false,
      redeclare package Medium = Medium,
      redeclare model HeatTransfer =
          AixLib.Fluid.Storage.BaseClasses.HeatTransferLambdaEff,
      redeclare package MediumHC1 = Medium,
      redeclare package MediumHC2 = Medium,
      n=10,
      useHeatingCoil1=true,
      useHeatingCoil2=false,
      upToDownHC1=true,
      data=AixLib.DataBase.Storage.Generic_New_2000l(
            hTank=2,
            hUpperPorts=1.9,
            hHC1Up=1.9,
            hHC1Low=0.4,
            pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(d_i=0.10, d_o=
            0.11),
            lengthHC1=140),
      TStart=313.15,
      TStartWall=313.15,
      TStartIns=313.15)
      annotation (Placement(transformation(extent={{-24,-30.5},{24,30.5}},
          rotation=0,
          origin={-42,-30.5})));
    AixLib.Fluid.Movers.FlowControlled_m_flow Stg2Hp(redeclare package Medium =
          Medium, m_flow_nominal=20)  annotation (Placement(transformation(
          extent={{-9,-9.5},{9,9.5}},
          rotation=180,
          origin={-125,-68.5})));
    AixLib.Fluid.Sources.FixedBoundary bou5(                   redeclare
        package Medium =
                 Medium,
      p=200000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-116,-38})));
    AixLib.Fluid.Movers.FlowControlled_m_flow HpStg1(redeclare package Medium =
          Medium, m_flow_nominal=12)  annotation (Placement(transformation(
          extent={{-9,-9.5},{9,9.5}},
          rotation=270,
          origin={-202,-62.5})));
    AixLib.Fluid.DistrictHeating.Components.CollectorUnit collectorUnit
      annotation (Placement(transformation(extent={{-213,-134},{-191,-111}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow Stg2Stg1(redeclare package Medium =
          Medium, m_flow_nominal=12)  annotation (Placement(transformation(
          extent={{-9,-9.5},{9,9.5}},
          rotation=180,
          origin={-93,-122.5})));
    AixLib.Fluid.Sensors.TemperatureTwoPort TempEvaIn(redeclare package Medium = Medium,
        m_flow_nominal=10) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-202,8})));
    AixLib.Fluid.Sensors.TemperatureTwoPort TempCondOut1(
                                                        redeclare package
        Medium =                                                                   Medium,
        m_flow_nominal=10) annotation (Placement(transformation(extent={{-7,-7},
              {7,7}},
          rotation=270,
          origin={-86,-45})));
    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable5
      constrainedby AixLib.Fluid.Interfaces.PartialTwoPort(redeclare final
        package Medium = Medium) annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=180,
          origin={292,-122})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable2
      constrainedby AixLib.Fluid.Interfaces.PartialTwoPort(redeclare final
        package Medium = Medium)
      annotation (Placement(transformation(extent={{-18,49},{8,75}})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable3
      constrainedby AixLib.Fluid.Interfaces.PartialTwoPort(redeclare final
        package Medium = Medium) annotation (Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=90,
          origin={-265,13})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable4
      constrainedby AixLib.Fluid.Interfaces.PartialTwoPort(redeclare final
        package Medium = Medium) annotation (Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=90,
          origin={-265,-83})));

    AixLib.Fluid.HeatExchangers.ConstantEffectiveness AuxSystem( redeclare
        package Medium1 =                                                                    Medium, redeclare
        package Medium2 =                                                                                                        Medium,
      m1_flow_nominal=10,
      m2_flow_nominal=10,
      dp1_nominal=10000,
      dp2_nominal=10000)
      "Auxiliary heat exchanger from a CHP unit" annotation (Placement(transformation(
          extent={{20,-18},{-20,18}},
          rotation=180,
          origin={122,73})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable1 constrainedby
      AixLib.Fluid.Interfaces.PartialTwoPort(
     redeclare final package Medium = Medium)
      annotation (Placement(transformation(extent={{278,48},{306,76}})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable6 constrainedby
      AixLib.Fluid.Interfaces.PartialTwoPort(
     redeclare final package Medium = Medium)
     annotation (Placement(transformation(
          extent={{-10.5,-10.5},{10.5,10.5}},
          rotation=270,
          origin={174.5,134.5})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport Replaceable7 constrainedby
      AixLib.Fluid.Interfaces.PartialTwoPort(
     redeclare final package Medium = Medium)
     annotation (Placement(transformation(
          extent={{-10.5,-10.5},{10.5,10.5}},
          rotation=90,
          origin={76.5,133.5})));

    AixLib.Fluid.BoilerCHP.CHP cHP( redeclare package Medium = Medium, m_flow_nominal=10,
      param=AixLib.DataBase.CHP.CHP_FMB_270_GSMK(),
      ctrlStrategy=true,
      minDeltaT=5,
      TFlowRange=2,
      vol(V=5),
      minCapacity=40,
      delayTime=1000,
      Kc=2,
      Tc=200,
      delayUnit=60)  annotation (Placement(transformation(extent={{102,238},{146,282}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort FlowTempSDH(redeclare package
        Medium =                                                                   Medium,
        m_flow_nominal=10) annotation (Placement(transformation(extent={{223,50},
              {250,74}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow CHPPump(redeclare package Medium =
          Medium, m_flow_nominal=12) annotation (Placement(transformation(
          extent={{-15,-15},{15,15}},
          rotation=90,
          origin={76,213})));
    AixLib.Fluid.Sources.FixedBoundary bou1(         nPorts=1,
      redeclare package Medium = Medium,
      p=200000)
      annotation (Placement(transformation(extent={{-11,-11},{11,11}},
          rotation=270,
          origin={147,295})));
    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening AuxValve(
      m_flow_nominal=1,
      redeclare package Medium = Medium,
      dpValve_nominal=10000) annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=0,
          origin={64,62})));
    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening BypassValve(
      m_flow_nominal=1,
      redeclare package Medium = Medium,
      dpValve_nominal=10000) annotation (Placement(transformation(
          extent={{-13.75,-13.75},{13.75,13.75}},
          rotation=0,
          origin={90.25,14.25})));
    AixLib.Fluid.MixingVolumes.MixingVolume HighTempCons(
      nPorts=2,
      m_flow_nominal=10,
      V=0.5, redeclare package Medium = Medium) annotation (Placement(transformation(
          extent={{-14,-14},{14,14}},
          rotation=180,
          origin={120,174})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
      "Prescribed heat flow" annotation (
        Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=90,
          origin={145,163})));
    Modelica.Blocks.Sources.BooleanConstant cHPsignal(k=true) annotation (
        Placement(transformation(
          extent={{-9,-9},{9,9}},
          rotation=180,
          origin={145,223})));
    Modelica.Blocks.Sources.Constant HighTempDemand(k=-50000)
                                                            annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={122,136})));
    Modelica.Blocks.Sources.Constant ConsMasFlow(k=2)
      annotation (Placement(transformation(extent={{16,224},{38,246}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort cHPflowTemp(redeclare package
        Medium = Medium, m_flow_nominal=10) annotation (Placement(
          transformation(
          extent={{-10.5,-10.5},{10.5,10.5}},
          rotation=270,
          origin={174.5,227.5})));
    AixLib.Fluid.Sensors.TemperatureTwoPort cHPreturnTemp(redeclare package
        Medium = Medium, m_flow_nominal=10) annotation (Placement(
          transformation(
          extent={{-9,-10.5},{9,10.5}},
          rotation=90,
          origin={75.5,247})));
    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening heatExValve(
      m_flow_nominal=1,
      redeclare package Medium = Medium,
      dpValve_nominal=10000) annotation (Placement(transformation(
          extent={{-8,-8.5},{8,8.5}},
          rotation=270,
          origin={174.5,164})));
    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening highTempValve(
      m_flow_nominal=1,
      redeclare package Medium = Medium,
      dpValve_nominal=10000) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={158,188})));
    Modelica.Blocks.Sources.Constant masFlowDistcHP(k=0.85)
                                                           annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={219,181})));
    Modelica.Blocks.Sources.Constant masFlowDistHighCons(k=1)   annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={219,212})));
    Modelica.Blocks.Math.Gain CHPelePowerWatt(k=1000) annotation (Placement(
          transformation(
          extent={{-9,-9},{9,9}},
          rotation=180,
          origin={55,287})));
    Modelica.Blocks.Math.Add         masFlowDistHighCons1(k1=-1, k2=+1)
                                                                annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={189,205})));
  equation
    connect(heatStorageSolarColl.port_b, SolarLoopPump.port_a) annotation (Line(
          points={{-330,-27.3},{-330,-27},{-340,-27},{-340,63},{-366,63}},
          color={0,127,255},
        thickness=1));
    connect(SolarLoopPump.port_b, solarCollector.port_a)
      annotation (Line(points={{-388,63},{-408,63}},     color={0,127,255},
        thickness=1));
    connect(solarCollector.port_b, heatStorageSolarColl.port_a) annotation (Line(
          points={{-444,63},{-464,63},{-464,-56},{-464,-124},{-342,-124},{-342,
            -43.7},{-330,-43.7}},   color={0,127,255},
        thickness=1));
    connect(bou.ports[1], SolarLoopPump.port_a) annotation (Line(points={{-356,48},
            {-356,63},{-366,63}},            color={0,127,255}));

    connect(heatPump.port_conOut, TempCondOut.port_a) annotation (Line(
        points={{-150,-14},{-150,-14},{-150,12},{-128,12}},
        color={0,127,255},
        thickness=1));
    connect(dividerUnit.port_b1, FlowTempDirSupp.port_a)
      annotation (Line(points={{-192,63},{-148,63}},
                                                  color={0,127,255},
        thickness=1));
    connect(TempCondOut.port_b, bufferStorage.portHC1In) annotation (Line(
        points={{-108,12},{-108,12},{-86,12},{-86,-13.115},{-66.6,-13.115}},
        color={0,127,255},
        thickness=1));
    connect(Stg2Hp.port_b, heatPump.port_conIn) annotation (Line(
        points={{-134,-68.5},{-150,-68.5},{-150,-42}},
        color={0,127,255},
        thickness=1));
    connect(bou5.ports[1], Stg2Hp.port_a) annotation (Line(
        points={{-116,-48},{-116,-58},{-116,-68.5}},
        color={0,127,255}));
    connect(FlowTempDirSupp.port_b, bufferStorage.fluidportTop1) annotation (
        Line(
        points={{-126,63},{-124,63},{-50.4,63},{-50.4,0.305}},
        color={0,127,255},
        thickness=1));
    connect(bufferStorage.fluidportBottom1, Stg2Stg1.port_a) annotation (Line(
        points={{-50.1,-61.61},{-50.1,-122.5},{-84,-122.5}},
        color={0,127,255},
        thickness=1));
    connect(Stg2Stg1.port_b, collectorUnit.port_b1) annotation (Line(
        points={{-102,-122.5},{-191,-122.5}},
        color={0,127,255},
        thickness=1));
    connect(heatPump.port_evaOut, HpStg1.port_a) annotation (Line(
        points={{-202,-42},{-202,-53.5}},
        color={0,127,255},
        thickness=1));
    connect(HpStg1.port_b, collectorUnit.port_b) annotation (Line(
        points={{-202,-71.5},{-202,-92},{-202,-111}},
        color={0,127,255},
        thickness=1));
    connect(dividerUnit.port_b, TempEvaIn.port_a) annotation (Line(
        points={{-202,53},{-202,18}},
        color={0,127,255},
        thickness=1));
    connect(TempEvaIn.port_b, heatPump.port_evaIn) annotation (Line(
        points={{-202,-2},{-202,-14}},
        color={0,127,255},
        thickness=1));
    connect(TempCondOut1.port_a, bufferStorage.portHC1Out) annotation (Line(
        points={{-86,-38},{-86,-22.57},{-66.3,-22.57}},
        color={0,127,255},
        thickness=1));
    connect(TempCondOut1.port_b, Stg2Hp.port_a) annotation (Line(
        points={{-86,-52},{-86,-68.5},{-116,-68.5}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable2.port_a, bufferStorage.fluidportTop2) annotation (Line(
        points={{-18,62},{-34.5,62},{-34.5,0.305}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable3.port_a, heatStorageSolarColl.port_b1) annotation (Line(
        points={{-265,4},{-265,-27.3},{-286,-27.3}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable4.port_b, heatStorageSolarColl.port_a1) annotation (Line(
        points={{-265,-75.6364},{-265,-44.93},{-286,-44.93}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable4.port_a, collectorUnit.port_a) annotation (Line(
        points={{-265,-92},{-265,-122.5},{-213,-122.5}},
        color={0,127,255},
        thickness=1));
    connect(AuxSystem.port_b2, Replaceable7.port_a) annotation (Line(
        points={{102,83.8},{76.5,83.8},{76.5,123}},
        color={0,127,255},
        thickness=1));
    connect(dividerUnit.port_a, Replaceable3.port_b) annotation (Line(
        points={{-212,63},{-265,63},{-265,20.3636}},
        color={0,127,255},
        thickness=1));
    connect(bou1.ports[1], cHP.port_b) annotation (Line(points={{147,284},{147,260},
            {146,260}},                color={0,127,255}));
    connect(AuxValve.port_b, AuxSystem.port_a1) annotation (Line(
        points={{78,62},{102,62},{102,62.2}},
        color={0,127,255},
        thickness=1));
    connect(AuxSystem.port_b1, FlowTempSDH.port_a) annotation (Line(
        points={{142,62.2},{148,62.2},{148,62},{174,62},{223,62}},
        color={0,127,255},
        thickness=1));
    connect(BypassValve.port_b, FlowTempSDH.port_a) annotation (Line(
        points={{104,14.25},{140,14.25},{140,14},{196,14},{196,62},{210,62},{
            223,62}},
        color={0,127,255},
        thickness=1));
    connect(heater.port, HighTempCons.heatPort) annotation (Line(points={{145,172},
            {145,172},{145,174},{134,174}},           color={191,0,0}));
    connect(cHPsignal.y, cHP.on) annotation (Line(points={{135.1,223},{130.6,223},
            {130.6,240.2}}, color={255,0,255}));
    connect(HighTempDemand.y, heater.Q_flow) annotation (Line(points={{130.8,136},
            {145,136},{145,154}}, color={0,0,127}));
    connect(ConsMasFlow.y, CHPPump.m_flow_in) annotation (Line(points={{39.1,235},
            {50,235},{50,212.7},{58,212.7}},    color={0,0,127}));
    connect(HighTempCons.ports[1], CHPPump.port_a) annotation (Line(
        points={{122.8,188},{76,188},{76,198}},
        color={0,127,255},
        thickness=1));
    connect(cHP.port_b, cHPflowTemp.port_a) annotation (Line(
        points={{146,260},{174.5,260},{174.5,238}},
        color={0,127,255},
        thickness=1));
    connect(CHPPump.port_b, cHPreturnTemp.port_a) annotation (Line(
        points={{76,228},{76,227.5},{75.5,227.5},{75.5,238}},
        color={0,127,255},
        thickness=1));
    connect(cHPreturnTemp.port_b, cHP.port_a) annotation (Line(
        points={{75.5,256},{75.5,260},{102,260}},
        color={0,127,255},
        thickness=1));
    connect(cHPflowTemp.port_b, heatExValve.port_a) annotation (Line(
        points={{174.5,217},{174.5,194},{174.5,172}},
        color={0,127,255},
        thickness=1));
    connect(cHPflowTemp.port_b, highTempValve.port_a) annotation (Line(
        points={{174.5,217},{174.5,188},{166,188}},
        color={0,127,255},
        thickness=1));
    connect(highTempValve.port_b, HighTempCons.ports[2]) annotation (Line(
        points={{150,188},{128.85,188},{117.2,188}},
        color={0,127,255},
        thickness=1));
    connect(masFlowDistcHP.y, heatExValve.y) annotation (Line(points={{211.3,
            181},{196,181},{196,164},{184.7,164}}, color={0,0,127}));
    connect(cHP.electricalPower, CHPelePowerWatt.u) annotation (Line(points={{113,
            279.8},{113,287},{65.8,287}},      color={0,0,127}));
    connect(masFlowDistHighCons.y, masFlowDistHighCons1.u2) annotation (Line(
          points={{211.3,212},{206,212},{206,209.2},{197.4,209.2}}, color={0,0,
            127}));
    connect(masFlowDistcHP.y, masFlowDistHighCons1.u1) annotation (Line(points={{211.3,
            181},{206,181},{206,200.8},{197.4,200.8}},         color={0,0,127}));
    connect(masFlowDistHighCons1.y, highTempValve.y) annotation (Line(points={{
            181.3,205},{170,205},{170,174},{158,174},{158,178.4}}, color={0,0,
            127}));
    connect(Replaceable6.port_b, AuxSystem.port_a2) annotation (Line(
        points={{174.5,124},{174.5,124},{174.5,83.8},{142,83.8}},
        color={0,127,255},
        thickness=1));
    connect(bufferStorage.fluidportBottom2, Replaceable5.port_b) annotation (
        Line(
        points={{-35.1,-61.305},{-36,-61.305},{-36,-122},{280.545,-122}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable1.port_a, FlowTempSDH.port_b) annotation (Line(
        points={{278,62},{272,62},{250,62}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable2.port_b, AuxValve.port_a) annotation (Line(
        points={{8,62},{50,62}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable2.port_b, BypassValve.port_a) annotation (Line(
        points={{8,62},{38,62},{38,14.25},{76.5,14.25}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable7.port_b, CHPPump.port_a) annotation (Line(
        points={{76.5,144},{76,144},{76,150},{76,198}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable6.port_a, heatExValve.port_b) annotation (Line(
        points={{174.5,145},{174,145},{174,156},{174.5,156}},
        color={0,127,255},
        thickness=1));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-500,
              -260},{360,340}}),
                          graphics={
    Rectangle(
            extent={{-500,340},{360,-260}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
                                    Text(
            extent={{-218,84},{84,-108}},
            lineColor={28,108,200},
            textString="%name
")}),                      Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-500,-260},{360,340}})),
      experiment(StopTime=86400, Interval=5),
      Documentation(info="<html>
<h4>Overview</h4>
<p>This initial model represents a base class of a heat generation unit in a district heating network with replaceable components. For the initial model, no control input connectors are included. </p>
</html>", revisions="<html>
<ul>
<li><i>June 19, 2017&nbsp;</i> by Farid Davani:<br/>Initial configuration of the base class<
</ul>
</html>"));
  end SolarDistrictHeating_BaseClass;

  model SolarDistrictHeating
    "Solar district heating model with control input connectors"

     extends
      AixLib.Fluid.DistrictHeating.SolarDistrictHeating_BaseClass(
      redeclare
        AixLib.Fluid.Sensors.ExergyMeterMediumMixed
        Replaceable1,
      redeclare AixLib.Fluid.Movers.FlowControlled_dp Replaceable2(
        m_flow_nominal=10,
        redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2
          per,
        inputType=AixLib.Fluid.Types.InputType.Continuous),
      redeclare
        AixLib.Fluid.Sensors.ExergyMeterMediumMixed
        Replaceable3,
      redeclare
        AixLib.Fluid.Sensors.ExergyMeterMediumMixed
        Replaceable4,
      redeclare
        AixLib.Fluid.Sensors.ExergyMeterMediumMixed
        Replaceable5,
      redeclare AixLib.Fluid.Sensors.TemperatureTwoPort Replaceable6(
          m_flow_nominal=10),
      redeclare AixLib.Fluid.Sensors.TemperatureTwoPort Replaceable7(
          m_flow_nominal=10),
      heatPump(redeclare function data_poly =
            AixLib.Fluid.DistrictHeating.BaseClasses.Functions.Characteristics.VariableNrpm
            (N_max=3700, P_com=60000)),
      cHP(
        m_flow_nominal=10,
        TSetIn=true,
        ctrlStrategy=true,
        minDeltaT=5,
        param=
            AixLib.DataBase.CHP.CHP_FMB_410_GSMK(),
        minCapacity=40,
        Tc=200,
        TFlowRange=2,
        Kc=2,
        delayTime=1000),
      bufferStorage(data=AixLib.DataBase.Storage.Generic_New_2000l(
              hTank=2,
              hUpperPorts=1.9,
              hHC1Up=1.9,
              hHC1Low=0.4,
              pipeHC1=AixLib.DataBase.Pipes.Copper.Copper_22x1_5(d_i=0.10, d_o=
              0.11),
              lengthHC1=140)),
      ConsMasFlow(k=2),
      cHPsignal(k=true));

    Modelica.Blocks.Interfaces.RealInput Irradiation "Solar irradiation on a horizontal plane in [W/m2]"
      annotation (Placement(transformation(extent={{-516,-12},{-476,28}}), iconTransformation(extent={{-516,-12},{-476,28}})));
    Modelica.Blocks.Interfaces.RealInput Toutdoor "ambient temperature in [K]"
      annotation (Placement(transformation(extent={{-516,-52},{-476,-12}}),
                                                                          iconTransformation(extent={{-516,-52},{-476,-12}})));
    Modelica.Blocks.Interfaces.RealInput NetworkPresRise "Pressure rise of the network in [Pa]"
                                     annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=270,
          origin={-67,344}),  iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-54,-243})));
    Modelica.Blocks.Interfaces.RealInput cHPflowTempSetpoint "Set point flow temperature of CHP in [K]" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={94,346}), iconTransformation(
          extent={{-26,-26},{26,26}},
          rotation=270,
          origin={128,330})));
    Modelica.Blocks.Interfaces.RealInput SolarCirPumpMF "Constant mass flow rate of solar circuit pump in [kg/s]" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-295,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-169,-245})));
    Modelica.Blocks.Interfaces.RealInput SeasStgCirPumpMF "Constant mass flow rate of seasonal storage circuit pump in [kg/s]" annotation (Placement(
          transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-265,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-347,-245})));
    Modelica.Blocks.Interfaces.RealInput ValveOpDirSupp "Valve opening for direct supply" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-235,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-229,-245})));
    Modelica.Blocks.Interfaces.RealInput ValveOpIndirSupp "Valve opening for indirect supply" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-208,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={-289,-245})));
    Modelica.Blocks.Interfaces.RealInput HPevaMF "Constant mass flow rate of heat pump evaporator in [kg/s]" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-182,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={121,-243})));
    Modelica.Blocks.Interfaces.RealInput HPcondMF "Constant mass flow rate of heat pump condenser in [kg/s]" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-156,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={63,-243})));
    Modelica.Blocks.Interfaces.RealInput DirSuppMF
      "Constant mass flow rate for direct supply in [kg/s]" annotation (
        Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=90,
          origin={-128,-266}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=90,
          origin={4,-243})));
    Modelica.Blocks.Interfaces.RealInput rpmHP "Constant mass flow rate for direct supply in [kg/s]" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=270,
          origin={-178,346}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=270,
          origin={-181,333})));
    Modelica.Blocks.Interfaces.BooleanInput OnOffHP "On/Off signal of the heat pump"
                                                    annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-206,346}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=270,
          origin={-237,333})));
    Modelica.Blocks.Interfaces.RealOutput HPCondTemp "Condenser temperature of the heat pump in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,293}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,310})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin3 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,293})));
    Modelica.Blocks.Interfaces.RealOutput TopTempBuffStg "Top temperature of the buffer storage in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,329}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,118})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,321})));
    Modelica.Blocks.Interfaces.RealOutput TopTempSeasStg "Top temperature of the seasonal storage in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,255}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,216})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,255})));
    Modelica.Blocks.Interfaces.RealOutput BottTempSeasStg "Bottom temperature of the seasonal storage in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,218}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,166})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin4 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,218})));
    Modelica.Blocks.Interfaces.RealOutput flowTempSolCir "Flow temperature of the solar circuit in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-515,178}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,264})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin5 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,180})));
    Modelica.Blocks.Interfaces.RealOutput flowTempSDH "Flow temperature of the solar circuit in [°C]" annotation (Placement(transformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-517,138}), iconTransformation(
          extent={{-23,-23},{23,23}},
          rotation=180,
          origin={-510,68})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin6 annotation (
        Placement(transformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={-457,138})));
    Modelica.Blocks.Interfaces.RealInput ValveOpAuxValve "Valve opening of the auxiliary valve" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=270,
          origin={-35,343}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=270,
          origin={-43,333})));
    Modelica.Blocks.Interfaces.RealInput ValveOpBypValve "Valve opening of the bypass valve" annotation (Placement(transformation(
          extent={{-19,-19},{19,19}},
          rotation=270,
          origin={-5,343}), iconTransformation(
          extent={{-27,-27},{27,27}},
          rotation=270,
          origin={-99,333})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b( redeclare package Medium =
                 Medium)
      annotation (Placement(transformation(extent={{340,42},{384,82}}),
          iconTransformation(extent={{336,184},{384,228}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a( redeclare package Medium =
                 Medium)
      annotation (Placement(transformation(extent={{340,-142},{386,-100}}),
          iconTransformation(extent={{340,-182},{386,-138}})));
    Modelica.Blocks.Sources.Constant Pressure1(
                                              k=101300)
      annotation (Placement(transformation(extent={{19,19},{-19,-19}},
          rotation=90,
          origin={291,321})));
    Modelica.Blocks.Sources.Constant xRefWater(k=1)
      annotation (Placement(transformation(extent={{-19,-19},{19,19}},
          rotation=270,
          origin={231,321})));
  equation
    connect(Irradiation, solarCollector.Irradiation) annotation (Line(points={{-496,8},{-472,8},{-472,20},{-427.8,20},{-427.8,43.56}}, color={0,0,127}));
    connect(cHPflowTempSetpoint, cHP.TSet) annotation (Line(points={{94,346},{94,246.8},{108.6,246.8}}, color={0,0,127}));
    connect(SolarCirPumpMF, SolarLoopPump.m_flow_in) annotation (Line(points={{-295,-266},{-295,-150},{-376.78,-150},{-376.78,49.8}}, color={0,0,127}));
    connect(SeasStgCirPumpMF, heatStorageSolarColl.MassFlowStgLoop)
      annotation (Line(points={{-265,-266},{-265,-141},{-312.4,-141},{-312.4,-55.18}}, color={0,0,127}));
    connect(ValveOpDirSupp, collectorUnit.ValveOpDir)
      annotation (Line(points={{-235,-266},{-235,-234},{-235,-114.335},{-212.45,-114.335}}, color={0,0,127}));
    connect(ValveOpDirSupp, dividerUnit.ValveOpDir) annotation (Line(points={{-235,-266},{-235,70.1},{-211.5,70.1}}, color={0,0,127}));
    connect(ValveOpIndirSupp, collectorUnit.ValveOpIndir)
      annotation (Line(points={{-208,-266},{-208,-148},{-226,-148},{-226,-117.555},{-212.45,-117.555}}, color={0,0,127}));
    connect(dividerUnit.ValveOpIndir, ValveOpIndirSupp)
      annotation (Line(points={{-211.5,67.3},{-226,67.3},{-226,-148},{-208,-148},{-208,-266}}, color={0,0,127}));
    connect(HPevaMF, HpStg1.m_flow_in) annotation (Line(points={{-182,-266},{-182,-62.32},{-190.6,-62.32}}, color={0,0,127}));
    connect(HPcondMF, Stg2Hp.m_flow_in)
      annotation (Line(points={{-156,-266},{-156,-266},{-156,-232},{-156,-104},{-156,-88},{-124.82,-88},{-124.82,-79.9}}, color={0,0,127}));
    connect(DirSuppMF, Stg2Stg1.m_flow_in) annotation (Line(points={{-128,-266},
            {-128,-266},{-128,-220},{-92.82,-220},{-92.82,-133.9}}, color={0,0,
            127}));
    connect(rpmHP, heatPump.N_in) annotation (Line(points={{-178,346},{-178,-10}}, color={0,0,127}));
    connect(OnOffHP, heatPump.onOff_in) annotation (Line(points={{-206,346},{-206,346},{-206,116},{-186,116},{-186,-10}}, color={255,0,255}));
    connect(NetworkPresRise, Replaceable2.dp_in) annotation (Line(points={{-67,344},{-67,344},{-67,92},{-5.26,92},{-5.26,77.6}}, color={0,0,127}));
    connect(TempCondOut.T, fromKelvin3.Kelvin) annotation (Line(points={{-118,23},{-119,23},{-119,90},{-119,293},{-443.8,293}}, color={0,0,127}));
    connect(fromKelvin3.Celsius, HPCondTemp) annotation (Line(points={{-469.1,293},{-469.1,293},{-515,293}}, color={0,0,127}));
    connect(fromKelvin1.Kelvin, bufferStorage.TTop) annotation (Line(points={{-443.8,321},{-78,321},{-78,-3.66},{-66,-3.66}}, color={0,0,127}));
    connect(heatStorageSolarColl.StgTempTop, fromKelvin2.Kelvin)
      annotation (Line(points={{-285.12,-18.69},{-272,-18.69},{-272,-6},{-290,-6},{-290,255},{-443.8,255}}, color={0,0,127}));
    connect(fromKelvin2.Celsius, TopTempSeasStg) annotation (Line(points={{-469.1,255},{-469.1,255},{-515,255}}, color={0,0,127}));
    connect(fromKelvin4.Celsius, BottTempSeasStg) annotation (Line(points={{-469.1,218},{-469.1,218},{-515,218}}, color={0,0,127}));
    connect(heatStorageSolarColl.StgTempBott, fromKelvin4.Kelvin)
      annotation (Line(points={{-284.68,-51.49},{-278,-51.49},{-278,-10},{-296,-10},{-296,218},{-443.8,218}}, color={0,0,127}));
    connect(fromKelvin1.Celsius, TopTempBuffStg) annotation (Line(points={{-469.1,321},{-478,321},{-478,329},{-515,329}}, color={0,0,127}));
    connect(heatStorageSolarColl.TempSolCollFlow, fromKelvin5.Kelvin)
      annotation (Line(points={{-331.32,-51.9},{-344,-51.9},{-344,180},{-443.8,180}}, color={0,0,127}));
    connect(fromKelvin5.Celsius, flowTempSolCir) annotation (Line(points={{-469.1,180},{-515,180},{-515,178}}, color={0,0,127}));
    connect(fromKelvin6.Celsius, flowTempSDH) annotation (Line(points={{-469.1,138},{-517,138}}, color={0,0,127}));
    connect(FlowTempSDH.T, fromKelvin6.Kelvin) annotation (Line(points={{236.5,75.2},{236.5,100},{-368,100},{-368,138},{-443.8,138}}, color={0,0,127}));
    connect(ValveOpAuxValve, AuxValve.y) annotation (Line(points={{-35,343},{-35,114},{64,114},{64,78.8}}, color={0,0,127}));
    connect(ValveOpBypValve, BypassValve.y) annotation (Line(points={{-5,343},{-5,104},{44,104},{44,38},{90.25,38},{90.25,30.75}}, color={0,0,127}));
    connect(Replaceable5.port_a, port_a) annotation (Line(
        points={{306,-122},{363,-122},{363,-121}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable1.port_b, port_b) annotation (Line(
        points={{303.455,62},{303.455,62},{362,62}},
        color={0,127,255},
        thickness=1));
    connect(Replaceable1.X_ref[1], xRefWater.y);
    connect(Replaceable1.p_ref, Pressure1.y);
    connect(Replaceable1.T_ref, Toutdoor);
    connect(Replaceable3.X_ref[1], xRefWater.y);
    connect(Replaceable3.p_ref, Pressure1.y);
    connect(Replaceable3.T_ref, Toutdoor);
    connect(Replaceable4.X_ref[1], xRefWater.y);
    connect(Replaceable4.p_ref, Pressure1.y);
    connect(Replaceable4.T_ref, Toutdoor);
    connect(Replaceable5.X_ref[1], xRefWater.y);
    connect(Replaceable5.p_ref, Pressure1.y);
    connect(Replaceable5.T_ref, Toutdoor);
    connect(solarCollector.T_air, Toutdoor) annotation (Line(points={{-415.2,43.56},{-416,43.56},{-416,-32},{-496,-32}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<h4>Overview</h4>
<p>This model represents a heat generation unit in a solar district heating network. For the model, required control input connectors are included. The main components of the heat generation unit are:</p>
<ol>
<li>Heat pump</li>
<li>Combined heat and power (CHP) unit</li>
<li>Solar collectors</li>
<li>Seasonal heat storage</li>
<li>Buffer storage</li>
</ol>
<h4>Concept</h4>
<p>The solar heat gained from the solar collectors is supplied to the seasonal heat storage by means of a heat exchanger. The stored heat in the seasonal heat storage is exclusively solar heat from the collectors. The seasonal heat storage is either connected to the buffer storage or to the heat pump, depending on the current operation mode. The heat pump, which is the heart of the heat generation unit, provides heating energy for the heat consumers. For peak shifting purposes, the heat supplied from the top of the seasonal heat storage or from the heat pump are both loaded into the buffer storage and from there the heat is delivered into the district heating network. If the heat pump does not cover the heat demand of the consumers, an auxiliary heat exchanger will be used as a back-up system to compensate the temperature difference between the desired flow temperature and the flow temperature of the heat generation unit.</p>
</html>",   revisions="<html>
<ul>
<li><i>June 19, 2017&nbsp;</i> by Farid Davani:<br/>First implementation of a solar district heating system<
</ul>
</html>"));
  end SolarDistrictHeating;

  package Examples "Collection of models that illustrate model use and test models"
  extends Modelica.Icons.ExamplesPackage;

    model SolarDistrictHeating "Example that illustrates use of solar district heating model"

        replaceable package Medium = AixLib.Media.Water;
        extends Modelica.Icons.Example;

      AixLib.Fluid.DistrictHeating.SolarDistrictHeating solarDistrictHeating
        annotation (Placement(transformation(extent={{-18,4},{30,36}})));
      AixLib.Fluid.DistrictHeating.Controller.SolarDistrictHeatingController solarDistrictHeatingController
        annotation (Placement(transformation(extent={{-46,-46},{-8,-20}})));
      AixLib.Fluid.Sources.Boundary_pT Sink(          redeclare package Medium =
                   Medium, nPorts=1)
                           annotation (Placement(
            transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={60,36})));
      AixLib.Fluid.Sources.Boundary_pT Source(
        redeclare package Medium = Medium,
        nPorts=1,
        T=303.15) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={60,2})));
      Modelica.Blocks.Sources.CombiTimeTable WeatherData(
        tableOnFile=true,
        extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint,
        columns=2:3,
        tableName="WeatherData04150419",
        fileName=
            "N:/Forschung/EBC0155_PtJ_Exergiebasierte_regelung_rsa/Students/pma-fda/Masterarbeit/MonitoringData/WeatherData04150419/WeatherData04150419.mat")
        annotation (Placement(transformation(
            extent={{-9,-9},{9,9}},
            rotation=0,
            origin={-66,9})));
      Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin2 annotation (
          Placement(transformation(
            extent={{4,-4.5},{-4,4.5}},
            rotation=180,
            origin={-28,10.5})));
      Modelica.Blocks.Sources.Step     BuffStgSetpoint(
        startTime=43200,
        offset=50,
        height=10)
        annotation (Placement(transformation(extent={{-72,-28},{-60,-16}})));
      Modelica.Blocks.Sources.Constant flowTempCHP(k=273.15 + 80)
        annotation (Placement(transformation(extent={{-36,42},{-24,54}})));
      Modelica.Blocks.Sources.Constant PressureRise(k=50000) annotation (Placement(
            transformation(
            extent={{-6,-6},{6,6}},
            rotation=180,
            origin={34,-10})));
    equation
      connect(Source.ports[1], solarDistrictHeating.port_a) annotation (Line(points={{52,2},{
              44,2},{44,9.33333},{30.1674,9.33333}},         color={0,127,255}));
      connect(Sink.ports[1], solarDistrictHeating.port_b) annotation (Line(points={{52,36},
              {44,36},{44,28.8533},{30,28.8533}},        color={0,127,255}));
      connect(solarDistrictHeating.flowTempSolCir, solarDistrictHeatingController.FlowTempSol)
        annotation (Line(points={{-18.5581,31.9467},{-86,31.9467},{-86,-40.3125},
              {-44.9312,-40.3125}},
                          color={0,0,127}));
      connect(solarDistrictHeating.TopTempSeasStg, solarDistrictHeatingController.SeasStgTopTemp)
        annotation (Line(points={{-18.5581,29.3867},{-82,29.3867},{-82,-36.7375},
              {-44.9312,-36.7375}},
                          color={0,0,127}));
      connect(solarDistrictHeating.BottTempSeasStg, solarDistrictHeatingController.SeasStgBotTemp)
        annotation (Line(points={{-18.5581,26.72},{-78,26.72},{-78,-33.1625},{
              -44.9312,-33.1625}},
                          color={0,0,127}));
      connect(solarDistrictHeating.TopTempBuffStg, solarDistrictHeatingController.TopTempBuffStg)
        annotation (Line(points={{-18.5581,24.16},{-40.4188,24.16},{-40.4188,
              -20.975}},
            color={0,0,127}));
      connect(solarDistrictHeating.flowTempSDH, solarDistrictHeatingController.FlowTempSDH)
        annotation (Line(points={{-18.5581,21.4933},{-37.5688,21.4933},{
              -37.5688,-20.8937}},
            color={0,0,127}));
      connect(solarDistrictHeating.HPCondTemp, solarDistrictHeatingController.hpCondTemp)
        annotation (Line(points={{-18.5581,34.4},{-90,34.4},{-90,-43.5625},{
              -44.9312,-43.5625}},
                          color={0,0,127}));
      connect(solarDistrictHeatingController.MFSolCirPump, solarDistrictHeating.SolarCirPumpMF)
        annotation (Line(points={{-8.35625,-21.4625},{0.474419,-21.4625},{
              0.474419,4.8}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.MFStgCirPump, solarDistrictHeating.SeasStgCirPumpMF)
        annotation (Line(points={{-8.35625,-24.3875},{-6,-24.3875},{-6,-16},{
              -9.46047,-16},{-9.46047,4.8}},
                                    color={0,0,127}));
      connect(solarDistrictHeatingController.ValveOpDir, solarDistrictHeating.ValveOpDirSupp)
        annotation (Line(points={{-8.35625,-27.3125},{-2.87442,-27.3125},{
              -2.87442,4.8}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.ValveOpIndir, solarDistrictHeating.ValveOpIndirSupp)
        annotation (Line(points={{-8.35625,-30.1563},{4,-30.1563},{4,-2},{
              -6.22326,-2},{-6.22326,4.8}},
                               color={0,0,127}));
      connect(solarDistrictHeatingController.EvaMF, solarDistrictHeating.HPevaMF)
        annotation (Line(points={{-8.35625,-33.1625},{16.6605,-33.1625},{
              16.6605,4.90667}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.ConMF, solarDistrictHeating.HPcondMF)
        annotation (Line(points={{-8.35625,-36.0875},{13.4233,-36.0875},{
              13.4233,4.90667}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.DirSuppMF, solarDistrictHeating.DirSuppMF)
        annotation (Line(points={{-8.35625,-39.0125},{10.1302,-39.0125},{
              10.1302,4.90667}},
            color={0,0,127}));
      connect(solarDistrictHeatingController.valOpBypass, solarDistrictHeating.ValveOpBypValve)
        annotation (Line(points={{-8.35625,-41.9375},{84,-41.9375},{84,52},{
              4.3814,52},{4.3814,35.6267}},
                                 color={0,0,127}));
      connect(solarDistrictHeatingController.valOpAux, solarDistrictHeating.ValveOpAuxValve)
        annotation (Line(points={{-8.35625,-44.8625},{88,-44.8625},{88,56},{
              7.50698,56},{7.50698,35.6267}},
                                      color={0,0,127}));
      connect(solarDistrictHeatingController.hpRPM, solarDistrictHeating.rpmHP)
        annotation (Line(points={{-25.6938,-45.5125},{-25.6938,-52},{94,-52},{
              94,62},{-0.195349,62},{-0.195349,35.6267}},
                                                   color={0,0,127}));
      connect(solarDistrictHeatingController.hpSignal, solarDistrictHeating.OnOffHP)
        annotation (Line(points={{-28.7813,-45.5125},{-28.7813,-56},{98,-56},{
              98,66},{-3.32093,66},{-3.32093,35.6267}},
                                                 color={255,0,255}));
      connect(WeatherData.y[2], solarDistrictHeating.Irradiation) annotation (Line(
            points={{-56.1,9},{-48,9},{-48,18.2933},{-17.7767,18.2933}}, color={0,0,
              127}));
      connect(WeatherData.y[1], toKelvin2.Celsius) annotation (Line(points={{-56.1,9},
              {-36,9},{-36,10.5},{-32.8,10.5}}, color={0,0,127}));
      connect(toKelvin2.Kelvin, solarDistrictHeating.Toutdoor) annotation (Line(
            points={{-23.6,10.5},{-20,10.5},{-20,16.16},{-17.7767,16.16}}, color={0,
              0,127}));
      connect(WeatherData.y[2], solarDistrictHeatingController.CurrIrrad)
        annotation (Line(points={{-56.1,9},{-52,9},{-52,-26.3375},{-44.9312,
              -26.3375}},
            color={0,0,127}));
      connect(WeatherData.y[1], solarDistrictHeatingController.AmbTemp) annotation (
         Line(points={{-56.1,9},{-52,9},{-52,-29.5875},{-44.9312,-29.5875}}, color={
              0,0,127}));
      connect(BuffStgSetpoint.y, solarDistrictHeatingController.setPointBuffStg)
        annotation (Line(points={{-59.4,-22},{-44.9312,-22},{-44.9312,-22.7625}},
            color={0,0,127}));
      connect(flowTempCHP.y, solarDistrictHeating.cHPflowTempSetpoint) annotation (
          Line(points={{-23.4,48},{17.0512,48},{17.0512,35.4667}}, color={0,0,127}));
      connect(PressureRise.y, solarDistrictHeating.NetworkPresRise) annotation (
          Line(points={{27.4,-10},{6.89302,-10},{6.89302,4.90667}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=86400));
    end SolarDistrictHeating;
  end Examples;
end DistrictHeating;
