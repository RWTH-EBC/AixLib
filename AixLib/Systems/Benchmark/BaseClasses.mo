within AixLib.Systems.Benchmark;
package BaseClasses "Base class package"
  extends Modelica.Icons.BasesPackage;
  expandable connector HighTempSystemBus
    "Data bus for high temperature circuit"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;
    HydraulicModules.BaseClasses.HydraulicBus pumpBoilerBus "Hydraulic circuit of the boiler";
    HydraulicModules.BaseClasses.HydraulicBus pumpChpBus "Hydraulic circuit of the chp";
    Real uRelBoilerSet "Set value for relative power of boiler 1 [0..1]";
    Real fuelPowerBoilerMea "Fuel consumption of boiler 1 [0..1]";
    Real TChpSet "Set temperature for chp";
    Boolean onOffChpSet "On off set point for chp";
    Real fuelPowerChpMea "Fuel consumption of chp [0..1]";
    Real thermalPowerChpMea "Thermal power of chp [0..1]";
    Real electricalPowerChpMea "Electrical power consumption of chp [0..1]";
    SI.Temperature TInMea "Inflow temperature";
    SI.Temperature TOutMea "Inflow temperature";
    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>",   revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
  end HighTempSystemBus;

  expandable connector TabsBus "Data bus for concrete cora activation"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;
    HydraulicModules.BaseClasses.HydraulicBus admixBus "Hydraulic circuit of the boiler";
    Real valSet(min=0, max=1) "Valve opening (0: ports_a1, 1: port_a2)";
    Real valSetAct(min=0, max=1) "Actual valve opening (0: ports_a1, 1: port_a2)";
    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>",   revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
  end TabsBus;

  expandable connector MainBus
    "Data bus for E.ON ERC main building system"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;
    EONERC_MainBuilding.BaseClasses.HeatPumpSystemBus hpSystemBus
      "Heat pump system bus";
    EONERC_MainBuilding.BaseClasses.SwitchingUnitBus swuBus "Switching unit bus";
    HighTempSystemBus htsBus
      "High temoerature system bus";
    EONERC_MainBuilding.BaseClasses.TwoCircuitBus gtfBus "Geothermalfield bus";
    EONERC_MainBuilding.BaseClasses.TwoCircuitBus hxBus
      "Heat exchanger system bus";
    TabsBus2 tabs1Bus "Bus for concrete core activation 1";
    TabsBus2 tabs2Bus "Bus for concrete core activation 2";
    TabsBus2 tabs3Bus "Bus for concrete core activation 3";
    TabsBus2 tabs4Bus "Bus for concrete core activation 4";
    TabsBus2 tabs5Bus "Bus for concrete core activation 5";
    ModularAHU.BaseClasses.GenericAHUBus ahuBus "Bus for AHU";
    ModularAHU.BaseClasses.GenericAHUBus vu1Bus "Ventilation unit 1";
    ModularAHU.BaseClasses.GenericAHUBus vu2Bus "Ventilation unit 2";
    ModularAHU.BaseClasses.GenericAHUBus vu3Bus "Ventilation unit 3";
    ModularAHU.BaseClasses.GenericAHUBus vu4Bus "Ventilation unit 4";
    ModularAHU.BaseClasses.GenericAHUBus vu5Bus "Ventilation unit 5";
    SI.Temperature TRoom1Mea "Temperature in room 1";
    SI.Temperature TRoom2Mea "Temperature in room 2";
    SI.Temperature TRoom3Mea "Temperature in room 3";
    SI.Temperature TRoom4Mea "Temperature in room 4";
    SI.Temperature TRoom5Mea "Temperature in room 5";
    EvaluationBus evaBus
      "Bus for energy consumption measurement";
    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>",   revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
  end MainBus;

  expandable connector EvaluationBus
    "Data bus for KPIs (energy consumption, control quality) of benchmark building"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;

    SI.Energy WelHPMea "Consumed energy of heat pump";
    SI.Energy WelPumpsHPMea "Consumed energy of heat pump pumps";
    SI.Energy WelGCMea "Consumed energy of glycol cooler";
    SI.Energy WelPumpsHXMea "Consumed energy of heat exchanger system pumps";
    SI.Energy WelPumpSWUMea "Consumed energy of switching unit pump";
    SI.Energy WelPumpGTFMea "Consumed energy of geothermal field pump";
    SI.Energy WelPumpsHTSMea "Consumed energy of pumps in high temperature system";
    SI.Energy QbrBoiMea "Consumed energy of boiler";
    SI.Energy QbrCHPMea "Consumed energy of chp";
    SI.Energy WelCPHMea "Produced electricity of chp";
    SI.Energy WelTotalMea "Total consumed electricity";
    SI.Energy QbrTotalMea "Total consumed fuel";
    Real IseRoom1 "ISE of room 1";
    Real IseRoom2 "ISE of room 2";
    Real IseRoom3 "ISE of room 3";
    Real IseRoom4 "ISE of room 4";
    Real IseRoom5 "ISE of room 5";

    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>",   revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
  end EvaluationBus;

  model EnergyCounter "Sums up all consumed energy"
    parameter Modelica.SIunits.Temperature Tset = 273.15+21 "Set Temperature of rooms for ISE calculation";

    MainBus mainBus annotation (Placement(transformation(extent={{-118,-18},{-80,18}}),
          iconTransformation(extent={{-18,-42},{16,-6}})));
    Modelica.Blocks.Continuous.Integrator integrator
      annotation (Placement(transformation(extent={{-10,90},{0,100}})));
    Modelica.Blocks.Continuous.Integrator integrator1
      annotation (Placement(transformation(extent={{-10,74},{0,84}})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{-26,74},{-16,84}})));
    Modelica.Blocks.Continuous.Integrator integrator2
      annotation (Placement(transformation(extent={{-10,56},{0,66}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-26,40},{-16,50}})));
    Modelica.Blocks.Continuous.Integrator integrator3
      annotation (Placement(transformation(extent={{-10,40},{0,50}})));
    Modelica.Blocks.Continuous.Integrator integrator4
      annotation (Placement(transformation(extent={{-10,20},{0,30}})));
    Modelica.Blocks.Continuous.Integrator integrator5
      annotation (Placement(transformation(extent={{-10,4},{0,14}})));
    Modelica.Blocks.Continuous.Integrator integrator6
      annotation (Placement(transformation(extent={{-10,-22},{0,-12}})));
    Modelica.Blocks.Continuous.Integrator integrator7
      annotation (Placement(transformation(extent={{-10,-40},{0,-30}})));
    Modelica.Blocks.Continuous.Integrator integrator9
      annotation (Placement(transformation(extent={{-10,-80},{0,-70}})));
    Modelica.Blocks.Continuous.Integrator integrator10
      annotation (Placement(transformation(extent={{-10,-100},{0,-90}})));
    Modelica.Blocks.Math.Sum sum1(nin=2)
      annotation (Placement(transformation(extent={{-30,-22},{-20,-12}})));
    Modelica.Blocks.Math.Sum sumWel(nin=7)
      annotation (Placement(transformation(extent={{58,4},{68,14}})));
    Modelica.Blocks.Math.Sum sumQbr(nin=2)
      annotation (Placement(transformation(extent={{60,-40},{70,-30}})));
    Modelica.Blocks.Continuous.Integrator integrator11
      annotation (Placement(transformation(extent={{112,88},{122,98}})));
    Modelica.Blocks.Math.Add add2(k2=-1)
      annotation (Placement(transformation(extent={{86,88},{96,98}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{102,90},{108,96}})));
    Modelica.Blocks.Sources.Constant const(k=Tset)
      annotation (Placement(transformation(extent={{74,86},{80,92}})));
    Modelica.Blocks.Continuous.Integrator integrator12
      annotation (Placement(transformation(extent={{112,66},{122,76}})));
    Modelica.Blocks.Math.Add add3(k2=-1)
      annotation (Placement(transformation(extent={{86,66},{96,76}})));
    Modelica.Blocks.Sources.Constant const1(k=Tset)
      annotation (Placement(transformation(extent={{74,64},{80,70}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{102,68},{108,74}})));
    Modelica.Blocks.Continuous.Integrator integrator13
      annotation (Placement(transformation(extent={{114,40},{124,50}})));
    Modelica.Blocks.Math.Add add4(k2=-1)
      annotation (Placement(transformation(extent={{88,40},{98,50}})));
    Modelica.Blocks.Sources.Constant const2(k=Tset)
      annotation (Placement(transformation(extent={{76,38},{82,44}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{104,42},{110,48}})));
    Modelica.Blocks.Continuous.Integrator integrator14
      annotation (Placement(transformation(extent={{114,20},{124,30}})));
    Modelica.Blocks.Math.Add add5(k2=-1)
      annotation (Placement(transformation(extent={{88,20},{98,30}})));
    Modelica.Blocks.Sources.Constant const3(k=Tset)
      annotation (Placement(transformation(extent={{76,18},{82,24}})));
    Modelica.Blocks.Math.Product product3
      annotation (Placement(transformation(extent={{104,22},{110,28}})));
    Modelica.Blocks.Continuous.Integrator integrator8
      annotation (Placement(transformation(extent={{112,106},{122,116}})));
    Modelica.Blocks.Math.Add add6(k2=-1)
      annotation (Placement(transformation(extent={{86,106},{96,116}})));
    Modelica.Blocks.Math.Product product4
      annotation (Placement(transformation(extent={{102,108},{108,114}})));
    Modelica.Blocks.Sources.Constant const4(k=Tset)
      annotation (Placement(transformation(extent={{74,104},{80,110}})));
  equation
    connect(integrator.u, mainBus.hpSystemBus.busHP.Pel) annotation (Line(points={
            {-11,95},{-98.905,95},{-98.905,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add.u2, mainBus.hpSystemBus.busPumpHot.pumpBus.power) annotation (
        Line(points={{-27,76},{-98.905,76},{-98.905,0.09}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add.u1, mainBus.hpSystemBus.busPumpCold.pumpBus.power) annotation (
        Line(points={{-27,82},{-90,82},{-90,84},{-98.905,84},{-98.905,0.09}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add.y, integrator1.u)
      annotation (Line(points={{-15.5,79},{-11,79}}, color={0,0,127}));
    connect(integrator.y, mainBus.evaBus.WelHPMea) annotation (Line(points={{0.5,95},
            {32,95},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator1.y, mainBus.evaBus.WelPumpsHPMea) annotation (Line(points={{0.5,79},
            {32,79},{32,0.09},{-98.905,0.09}},          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator2.u, mainBus.hpSystemBus.PelAirCoolerMea) annotation (Line(
          points={{-11,61},{-98.905,61},{-98.905,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(integrator2.y, mainBus.evaBus.WelGCMea) annotation (Line(points={{0.5,61},
            {32,61},{32,0.09},{-98.905,0.09}},     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(add1.y, integrator3.u) annotation (Line(points={{-15.5,45},{-11,45}},
                                   color={0,0,127}));
    connect(add1.u1, mainBus.hxBus.primBus.pumpBus.power) annotation (Line(points={{-27,48},
            {-98.905,48},{-98.905,0.09}},          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add1.u2, mainBus.hxBus.secBus.pumpBus.power) annotation (Line(points={{-27,42},
            {-98.905,42},{-98.905,0.09}},          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(integrator3.y, mainBus.evaBus.WelPumpsHXMea) annotation (Line(points={{0.5,45},
            {32,45},{32,0.09},{-98.905,0.09}},            color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator4.u, mainBus.swuBus.pumpBus.power) annotation (Line(points={{-11,25},
            {-98.905,25},{-98.905,0.09}},          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(integrator4.y, mainBus.evaBus.WelPumpSWUMea) annotation (Line(points={{0.5,25},
            {32,25},{32,0.09},{-98.905,0.09}},          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator5.u, mainBus.gtfBus.primBus.pumpBus.power) annotation (Line(
          points={{-11,9},{-98.905,9},{-98.905,0.09}},     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(integrator5.y, mainBus.evaBus.WelPumpGTFMea) annotation (Line(points={{0.5,9},
            {32,9},{32,0.09},{-98.905,0.09}},             color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator6.y, mainBus.evaBus.WelPumpsHTSMea) annotation (Line(points={{0.5,-17},
            {32,-17},{32,0.09},{-98.905,0.09}},           color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator7.u, mainBus.htsBus.fuelPowerBoilerMea) annotation (Line(
          points={{-11,-35},{-98.905,-35},{-98.905,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(integrator7.y, mainBus.evaBus.QbrBoiMea) annotation (Line(points={{0.5,-35},
            {32,-35},{32,0.09},{-98.905,0.09}},      color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));

    connect(integrator9.u, mainBus.htsBus.fuelPowerChpMea) annotation (Line(
          points={{-11,-75},{-98.905,-75},{-98.905,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(integrator9.y, mainBus.evaBus.QbrCHPMea) annotation (Line(points={{
            0.5,-75},{32,-75},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator10.u, mainBus.htsBus.electricalPowerChpMea) annotation (
        Line(points={{-11,-95},{-98.905,-95},{-98.905,0.09}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(integrator10.y, mainBus.evaBus.WelCPHMea) annotation (Line(points={{
            0.5,-95},{32,-95},{32,0.09},{-98.905,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sum1.u[1], mainBus.htsBus.pumpBoilerBus.pumpBus.power) annotation (Line(
          points={{-31,-17.5},{-98.905,-17.5},{-98.905,0.09}},       color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sum1.u[2], mainBus.htsBus.pumpChpBus.pumpBus.power) annotation (Line(
          points={{-31,-16.5},{-98.905,-16.5},{-98.905,0.09}},
                                                           color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(sum1.y, integrator6.u) annotation (Line(points={{-19.5,-17},{-14.75,
            -17},{-14.75,-17},{-11,-17}}, color={0,0,127}));
    connect(integrator.y, sumWel.u[1])
      annotation (Line(points={{0.5,95},{57,95},{57,8.14286}}, color={0,0,127}));
    connect(integrator1.y, sumWel.u[2])
      annotation (Line(points={{0.5,79},{57,79},{57,8.42857}}, color={0,0,127}));
    connect(integrator2.y, sumWel.u[3]) annotation (Line(points={{0.5,61},{32,
            61},{32,10},{57,10},{57,8.71429}},
                                           color={0,0,127}));
    connect(integrator3.y, sumWel.u[4]) annotation (Line(points={{0.5,45},{16,
            45},{16,46},{32,46},{32,9},{57,9}},
                                            color={0,0,127}));
    connect(integrator4.y, sumWel.u[5]) annotation (Line(points={{0.5,25},{
            32.25,25},{32.25,9.28571},{57,9.28571}},
                                               color={0,0,127}));
    connect(integrator5.y, sumWel.u[6])
      annotation (Line(points={{0.5,9},{57,9},{57,9.57143}}, color={0,0,127}));
    connect(integrator6.y, sumWel.u[7]) annotation (Line(points={{0.5,-17},{57,
            -17},{57,9.85714}}, color={0,0,127}));
    connect(sumWel.y, mainBus.evaBus.WelTotalMea) annotation (Line(points={{68.5,9},
            {80,9},{80,0.09},{-98.905,0.09}},    color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator7.y, sumQbr.u[1]) annotation (Line(points={{0.5,-35},{21.25,
            -35},{21.25,-35.5},{59,-35.5}},       color={0,0,127}));
    connect(sumQbr.y, mainBus.evaBus.QbrTotalMea) annotation (Line(points={{70.5,
            -35},{76,-35},{76,-36},{80,-36},{80,0.09},{-98.905,0.09}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(product.y, integrator11.u) annotation (Line(points={{108.3,93},{
            109.15,93},{109.15,93},{111,93}}, color={0,0,127}));
    connect(const.y, add2.u2) annotation (Line(points={{80.3,89},{82.15,89},{82.15,
            90},{85,90}},       color={0,0,127}));
    connect(const1.y, add3.u2) annotation (Line(points={{80.3,67},{82.15,67},{82.15,
            68},{85,68}},       color={0,0,127}));
    connect(integrator12.u, product1.y)
      annotation (Line(points={{111,71},{108.3,71}}, color={0,0,127}));
    connect(const2.y, add4.u2) annotation (Line(points={{82.3,41},{84.15,41},{84.15,
            42},{87,42}},       color={0,0,127}));
    connect(integrator13.u, product2.y)
      annotation (Line(points={{113,45},{110.3,45}}, color={0,0,127}));
    connect(const3.y, add5.u2) annotation (Line(points={{82.3,21},{84.15,21},{84.15,
            22},{87,22}},       color={0,0,127}));
    connect(integrator14.u, product3.y)
      annotation (Line(points={{113,25},{110.3,25}}, color={0,0,127}));
    connect(integrator9.y, sumQbr.u[2]) annotation (Line(points={{0.5,-75},{50,-75},
            {50,-34.5},{59,-34.5}}, color={0,0,127}));
    connect(product4.y, integrator8.u)
      annotation (Line(points={{108.3,111},{111,111}}, color={0,0,127}));
    connect(const4.y, add6.u2) annotation (Line(points={{80.3,107},{82.15,107},{82.15,
            108},{85,108}}, color={0,0,127}));
    connect(add6.y, product4.u2) annotation (Line(points={{96.5,111},{99.25,111},
            {99.25,109.2},{101.4,109.2}}, color={0,0,127}));
    connect(add6.y, product4.u1) annotation (Line(points={{96.5,111},{99.25,111},
            {99.25,112.8},{101.4,112.8}}, color={0,0,127}));
    connect(add2.y, product.u1) annotation (Line(points={{96.5,93},{99.25,93},{
            99.25,94.8},{101.4,94.8}}, color={0,0,127}));
    connect(add2.y, product.u2) annotation (Line(points={{96.5,93},{99.25,93},{
            99.25,91.2},{101.4,91.2}}, color={0,0,127}));
    connect(add3.y, product1.u1) annotation (Line(points={{96.5,71},{99.25,71},
            {99.25,72.8},{101.4,72.8}}, color={0,0,127}));
    connect(add3.y, product1.u2) annotation (Line(points={{96.5,71},{99.25,71},
            {99.25,69.2},{101.4,69.2}}, color={0,0,127}));
    connect(add4.y, product2.u1) annotation (Line(points={{98.5,45},{100.25,45},
            {100.25,46.8},{103.4,46.8}}, color={0,0,127}));
    connect(add4.y, product2.u2) annotation (Line(points={{98.5,45},{101.25,45},
            {101.25,43.2},{103.4,43.2}}, color={0,0,127}));
    connect(add5.y, product3.u1) annotation (Line(points={{98.5,25},{100.25,25},
            {100.25,26.8},{103.4,26.8}}, color={0,0,127}));
    connect(add5.y, product3.u2) annotation (Line(points={{98.5,25},{101.25,25},
            {101.25,23.2},{103.4,23.2}}, color={0,0,127}));
    connect(add6.u1, mainBus.TRoom1Mea) annotation (Line(points={{85,114},{-14,
            114},{-14,116},{-98.905,116},{-98.905,0.09}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add2.u1, mainBus.TRoom2Mea) annotation (Line(points={{85,96},{74,96},
            {74,108},{-110,108},{-110,0.09},{-98.905,0.09}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add3.u1, mainBus.TRoom3Mea) annotation (Line(points={{85,74},{64,74},
            {64,124},{-108,124},{-108,-6},{-98.905,-6},{-98.905,0.09}}, color={
            0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add4.u1, mainBus.TRoom4Mea) annotation (Line(points={{87,48},{74,48},
            {74,50},{68,50},{68,124},{-98.905,124},{-98.905,0.09}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(add5.u1, mainBus.TRoom5Mea) annotation (Line(points={{87,28},{66,28},
            {66,128},{-98,128},{-98,0.09},{-98.905,0.09}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(integrator8.y, mainBus.evaBus.IseRoom1) annotation (Line(points={{
            122.5,111},{130,111},{130,130},{-98.905,130},{-98.905,0.09}}, color=
           {0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator11.y, mainBus.evaBus.IseRoom2) annotation (Line(points={{
            122.5,93},{136,93},{136,132},{-98.905,132},{-98.905,0.09}}, color={
            0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator12.y, mainBus.evaBus.IseRoom3) annotation (Line(points={{
            122.5,71},{144,71},{144,128},{-106,128},{-106,0.09},{-98.905,0.09}},
          color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator13.y, mainBus.evaBus.IseRoom4) annotation (Line(points={{
            124.5,45},{150,45},{150,130},{-98.905,130},{-98.905,0.09}}, color={
            0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(integrator14.y, mainBus.evaBus.IseRoom5) annotation (Line(points={{
            124.5,25},{158,25},{158,132},{-98.905,132},{-98.905,0.09}}, color={
            0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-86,80},{94,-20}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{30,36}}, color={0,0,0}),
          Polygon(
            points={{44,48},{-8,2},{2,-6},{44,48}},
            lineColor={0,0,0},
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-74,64},{-56,42}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{-26,70},{-22,46}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{28,70},{22,46}},
            color={0,0,0},
            thickness=1),
          Line(
            points={{86,60},{66,38}},
            color={0,0,0},
            thickness=1)}),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end EnergyCounter;

  expandable connector TabsBus2 "Data bus for concrete cora activation"
    extends Modelica.Icons.SignalBus;
    import SI = Modelica.SIunits;
    HydraulicModules.BaseClasses.HydraulicBus pumpBus  "Hydraulic circuit of concrete core activation";
    HydraulicModules.BaseClasses.HydraulicBus hotThrottleBus  "Hydraulic circuit of hot supply";
    HydraulicModules.BaseClasses.HydraulicBus coldThrottleBus "Hydraulic circuit of cold supply";
    annotation (
      Icon(graphics,
           coordinateSystem(preserveAspectRatio=false)),
      Diagram(graphics,
              coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Definition of a bus connector for the ERC Heatpump System.</p>
</html>",   revisions="<html>
<ul>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>Adaption for hydraulic modules in AixLib.</li>
<li>February 6, 2016, by Peter Matthes:<br/>First implementation. </li>
</ul>
</html>"));
  end TabsBus2;

  record BenchmarkWorkshop "Workshop zone of  benchmark building"
    extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
      T_start=293.15,
      VAir=2700.0,
      AZone=900.0,
      hRad=5,
      lat=0.87266462599716,
      nOrientations=3,
      AWin={60,60,60},
      ATransparent={60,60,60},
      hConWin=12,
      RWin=1/(1.3*180),
      gWin=0.25,
      UWin=1.3,
      ratioWinConRad=0.09,
      AExt={30,30,30},
      hConExt=20,
      nExt=1,
      RExt={1/(0.3*90)},
      RExtRem=0.1,
      CExt={3*30*0.3*2100*880},
      AInt=90,
      hConInt=20,
      nInt=1,
      RInt={1/(0.3*30*3)},
      CInt={30*3*0.3*2100*880},
      AFloor=900,
      hConFloor=10,
      nFloor=1,
      RFloor={1/(0.16*100)},
      RFloorRem=1,
      CFloor={0.001},
      ARoof=900,
      hConRoof=30,
      nRoof=1,
      RRoof={1/(0.1814*900)},
      RRoofRem=1,
      CRoof={30*30*0.3*2100*880},
      nOrientationsRoof=1,
      tiltRoof={0},
      aziRoof={0},
      wfRoof={1},
      aRoof=0.7,
      aExt=0.7,
      TSoil=283.15,
      hConWallOut=20.0,
      hRadWall=5,
      hConWinOut=20.0,
      hConRoofOut=20,
      hRadRoof=5,
      tiltExtWalls={1.5707963267949,1.5707963267949,1.5707963267949},
      aziExtWalls={3.1415926535898,0,1.5707963267949},
      wfWall={0.3,0.3,0.3},
      wfWin={0.333,0.333,0.333},
      wfGro=0.1,
      specificPeople=1/14,
      activityDegree=1.2,
      fixedHeatFlowRatePersons=209/900,
      ratioConvectiveHeatPeople=0.5,
      internalGainsMoistureNoPeople=0.5,
      internalGainsMachinesSpecific=200/900,
      ratioConvectiveHeatMachines=0.6,
      lightingPowerSpecific=4737/900,
      ratioConvectiveHeatLighting=0.6,
      useConstantACHrate=false,
      baseACH=0.2,
      maxUserACH=1,
      maxOverheatingACH={3.0,2.0},
      maxSummerACH={1.0,273.15 + 10,273.15 + 17},
      winterReduction={0.2,273.15,273.15 + 10},
      withAHU=false,
      minAHU=0,
      maxAHU=12,
      hHeat=167500,
      lHeat=0,
      KRHeat=1000,
      TNHeat=1,
      HeaterOn=false,
      hCool=0,
      lCool=-1,
      KRCool=1000,
      TNCool=1,
      CoolerOn=false,
      TThresholdHeater=273.15 + 15,
      TThresholdCooler=273.15 + 22,
      withIdealThresholds=false);                     //not area specific: W_per_person/area => input will be number of persons
    annotation (Documentation(revisions="<html>
 <ul>
  <li>
  February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
  Adapting nrPeople and nrPeopleMachines to area specific approach 
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation.
  </li>
  <li>
  June, 2015, by Moritz Lauster:<br/>
  Implemented.
  </li>
 </ul>
 </html>",   info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &quot;Office&quot; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"));
  end BenchmarkWorkshop;

  record BenchmarkCanteen "Canteen zone of  benchmark building"
    extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
      T_start=293.15,
      VAir=1800.0,
      AZone=600.0,
      hRad=5,
      lat=0.87266462599716,
      nOrientations=2,
      AWin={40,40},
      ATransparent={40,40},
      hConWin=12,
      RWin=1/(1.3*80),
      gWin=0.25,
      UWin=1.3,
      ratioWinConRad=0.09,
      AExt={20,20},
      hConExt=20,
      nExt=1,
      RExt={1/(0.3*40)},
      RExtRem=0.000380773816236,
      CExt={2*20*0.3*2100*880},
      AInt=2*30*3,
      hConInt=20,
      nInt=1,
      RInt={1/(2*0.3*30*3)},
      CInt={2*30*3*0.3*2100*880},
      AFloor=600,
      hConFloor=10,
      nFloor=1,
      RFloor={1/(0.16*600)},
      RFloorRem=1,
      CFloor={0.001},
      ARoof=600,
      hConRoof=30,
      nRoof=1,
      RRoof={1/(0.1814*600)},
      RRoofRem=0.00001,
      CRoof={20*30*0.3*2100*880},
      nOrientationsRoof=1,
      tiltRoof={0},
      aziRoof={0},
      wfRoof={1},
      aRoof=0.7,
      aExt=0.7,
      TSoil=283.15,
      hConWallOut=20.0,
      hRadWall=5,
      hConWinOut=20.0,
      hConRoofOut=20,
      hRadRoof=5,
      tiltExtWalls={1.5707963267949,1.5707963267949},
      aziExtWalls={3.1415926535898,0},
      wfWall={0.45,0.45},
      wfWin={0.5,0.5},
      wfGro=0.1,
      specificPeople=1/14,
      activityDegree=1.2,
      fixedHeatFlowRatePersons=125/600,
      ratioConvectiveHeatPeople=0.5,
      internalGainsMoistureNoPeople=0.5,
      internalGainsMachinesSpecific=213/600,
      ratioConvectiveHeatMachines=0.6,
      lightingPowerSpecific=2210/600,
      ratioConvectiveHeatLighting=0.6,
      useConstantACHrate=false,
      baseACH=0.2,
      maxUserACH=1,
      maxOverheatingACH={3.0,2.0},
      maxSummerACH={1.0,273.15 + 10,273.15 + 17},
      winterReduction={0.2,273.15,273.15 + 10},
      withAHU=false,
      minAHU=0,
      maxAHU=12,
      hHeat=167500,
      lHeat=0,
      KRHeat=1000,
      TNHeat=1,
      HeaterOn=false,
      hCool=0,
      lCool=-1,
      KRCool=1000,
      TNCool=1,
      CoolerOn=false,
          TThresholdHeater=273.15 + 15,
      TThresholdCooler=273.15 + 22,
      withIdealThresholds=false);                     //not area specific: W_per_person/area => input will be number of persons
    annotation (Documentation(revisions="<html>
 <ul>
  <li>
  February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
  Adapting nrPeople and nrPeopleMachines to area specific approach 
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation.
  </li>
  <li>
  June, 2015, by Moritz Lauster:<br/>
  Implemented.
  </li>
 </ul>
 </html>",   info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &quot;Office&quot; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"));
  end BenchmarkCanteen;

  record BenchmarkOpenPlanOffice
    "Open plan office zone of  benchmark building"
    extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
      T_start=293.15,
      VAir=4050.0,
      AZone=1350.0,
      hRad=5,
      lat=0.87266462599716,
      nOrientations=3,
      AWin={80,60,60},
      ATransparent={80,60,60},
      hConWin=12,
      RWin=1/(1.3*200),
      gWin=0.25,
      UWin=1.3,
      ratioWinConRad=0.09,
      AExt={40,30,30},
      hConExt=20,
      nExt=1,
      RExt={1/(0.3*100)},
      RExtRem=1,
      CExt={100*0.3*2100*880},
      AInt=30*3,
      hConInt=20,
      nInt=1,
      RInt={1/(0.3*30*3)},
      CInt={30*3*0.3*2100*880},
      AFloor=1350,
      hConFloor=10,
      nFloor=1,
      RFloor={1/(0.16*1350)},
      RFloorRem=1,
      CFloor={0.001},
      ARoof=1350,
      hConRoof=30,
      nRoof=1,
      RRoof={1/(0.1814*1350)},
      RRoofRem=1,
      CRoof={1350*0.3*2100*880},
      nOrientationsRoof=1,
      tiltRoof={0},
      aziRoof={0},
      wfRoof={1},
      aRoof=0.7,
      aExt=0.7,
      TSoil=283.15,
      hConWallOut=20.0,
      hRadWall=5,
      hConWinOut=20.0,
      hConRoofOut=20,
      hRadRoof=5,
      tiltExtWalls={1.5707963267949,1.5707963267949,1.5707963267949},
      aziExtWalls={3.1415926535898,0, 4.712},
      wfWall={0.3,0.3, 0.3},
      wfWin={0.333,0.333, 0.333},
      wfGro=0.1,
      specificPeople=1/14,
      activityDegree=1.2,
      fixedHeatFlowRatePersons=125/1350,
      ratioConvectiveHeatPeople=0.5,
      internalGainsMoistureNoPeople=0.5,
      internalGainsMachinesSpecific=50/1350,
      ratioConvectiveHeatMachines=0.6,
      lightingPowerSpecific=5684/1350,
      ratioConvectiveHeatLighting=0.6,
      useConstantACHrate=false,
      baseACH=0.2,
      maxUserACH=1,
      maxOverheatingACH={3.0,2.0},
      maxSummerACH={1.0,273.15 + 10,273.15 + 17},
      winterReduction={0.2,273.15,273.15 + 10},
      withAHU=false,
      minAHU=0,
      maxAHU=12,
      hHeat=167500,
      lHeat=0,
      KRHeat=1000,
      TNHeat=1,
      HeaterOn=false,
      hCool=0,
      lCool=-1,
      KRCool=1000,
      TNCool=1,
      CoolerOn=false,
      TThresholdHeater=273.15 + 15,
      TThresholdCooler=273.15 + 22,
      withIdealThresholds=false);                     //not area specific: W_per_person/area => input will be number of persons
    annotation (Documentation(revisions="<html>
 <ul>
  <li>
  February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
  Adapting nrPeople and nrPeopleMachines to area specific approach 
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation.
  </li>
  <li>
  June, 2015, by Moritz Lauster:<br/>
  Implemented.
  </li>
 </ul>
 </html>",   info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &quot;Office&quot; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"));
  end BenchmarkOpenPlanOffice;

  record BenchmarkSharedOffice
    "Shared office zone of  benchmark building"
    extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
      T_start=293.15,
      VAir=300,
      AZone=100.0,
      hRad=5,
      lat=0.87266462599716,
      nOrientations=1,
      AWin={40},
      ATransparent={40},
      hConWin=12,
      RWin=1/(1.3*40),
      gWin=0.1,
      UWin=1.3,
      ratioWinConRad=0.09,
      AExt={20},
      hConExt=20,
      nExt=1,
      RExt={1/(0.3*20)},
      RExtRem=0.000380773816236,
      CExt={20*0.3*2100*880},
      AInt=90,
      hConInt=20,
      nInt=1,
      RInt={1/(0.3*90)},
      CInt={90*0.3*2100*880},
      AFloor=100,
      hConFloor=10,
      nFloor=1,
      RFloor={1/(0.16*100)},
      RFloorRem=1,
      CFloor={1},
      ARoof=100,
      hConRoof=30,
      nRoof=1,
      RRoof={1/(0.1814*100)},
      RRoofRem=0.00001,
      CRoof={100*0.3*2100*880},
      nOrientationsRoof=1,
      tiltRoof={0},
      aziRoof={0},
      wfRoof={1},
      aRoof=0.7,
      aExt=0.7,
      TSoil=283.15,
      hConWallOut=20.0,
      hRadWall=5,
      hConWinOut=20.0,
      hConRoofOut=20,
      hRadRoof=5,
      tiltExtWalls={1.5707963267949},
      aziExtWalls={0},
      wfWall={0.9},
      wfWin={1},
      wfGro=0.1,
      specificPeople=1/14,
      activityDegree=1.2,
      fixedHeatFlowRatePersons=125/100,
      ratioConvectiveHeatPeople=0.5,
      internalGainsMoistureNoPeople=0.5,
      internalGainsMachinesSpecific=20/100,
      ratioConvectiveHeatMachines=0.6,
      lightingPowerSpecific=420/100,
      ratioConvectiveHeatLighting=0.6,
      useConstantACHrate=false,
      baseACH=0.2,
      maxUserACH=1,
      maxOverheatingACH={3.0,2.0},
      maxSummerACH={1.0,273.15 + 10,273.15 + 17},
      winterReduction={0.2,273.15,273.15 + 10},
      withAHU=false,
      minAHU=0,
      maxAHU=12,
      hHeat=167500,
      lHeat=0,
      KRHeat=1000,
      TNHeat=1,
      HeaterOn=false,
      hCool=0,
      lCool=-1,
      KRCool=1000,
      TNCool=1,
      CoolerOn=false,
      TThresholdHeater=273.15 + 15,
      TThresholdCooler=273.15 + 22,
      withIdealThresholds=false);                     //not area specific: W_per_person/area => input will be number of persons
    annotation (Documentation(revisions="<html>
 <ul>
  <li>
  February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
  Adapting nrPeople and nrPeopleMachines to area specific approach 
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation.
  </li>
  <li>
  June, 2015, by Moritz Lauster:<br/>
  Implemented.
  </li>
 </ul>
 </html>",   info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &quot;Office&quot; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"));
  end BenchmarkSharedOffice;

  record BenchmarkConferenceRoom
    "Conference room zone of  benchmark building"
    extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
      T_start=293.15,
      VAir=150,
      AZone=50.0,
      hRad=5,
      lat=0.87266462599716,
      nOrientations=1,
      AWin={20},
      ATransparent={20},
      hConWin=12,
      RWin=1/(1.3*20),
      gWin=0.25,
      UWin=1.3,
      ratioWinConRad=0.09,
      AExt={10},
      hConExt=20,
      nExt=1,
      RExt={1/(0.3*10)},
      RExtRem=1,
      CExt={10*0.3*2100*880},
      AInt=60,
      hConInt=20,
      nInt=1,
      RInt={1/(0.3*60)},
      CInt={60*0.3*2100*880},
      AFloor=50,
      hConFloor=10,
      nFloor=1,
      RFloor={1/(0.16*50)},
      RFloorRem=1,
      CFloor={1},
      ARoof=50,
      hConRoof=30,
      nRoof=1,
      RRoof={1/(0.1814*50)},
      RRoofRem=1,
      CRoof={50*0.3*2100*880},
      nOrientationsRoof=1,
      tiltRoof={0},
      aziRoof={0},
      wfRoof={1},
      aRoof=0.7,
      aExt=0.7,
      TSoil=283.15,
      hConWallOut=20.0,
      hRadWall=5,
      hConWinOut=20.0,
      hConRoofOut=20,
      hRadRoof=5,
      tiltExtWalls={1.5707963267949},
      aziExtWalls={3.1415926535898},
      wfWall={0.9},
      wfWin={1},
      wfGro=0.1,
      specificPeople=1/14,
      activityDegree=1.2,
      fixedHeatFlowRatePersons=125/100,
      ratioConvectiveHeatPeople=0.5,
      internalGainsMoistureNoPeople=0.5,
      internalGainsMachinesSpecific=50/100,
      ratioConvectiveHeatMachines=0.6,
      lightingPowerSpecific=210/100,
      ratioConvectiveHeatLighting=0.6,
      useConstantACHrate=false,
      baseACH=0.2,
      maxUserACH=1,
      maxOverheatingACH={3.0,2.0},
      maxSummerACH={1.0,273.15 + 10,273.15 + 17},
      winterReduction={0.2,273.15,273.15 + 10},
      withAHU=false,
      minAHU=0,
      maxAHU=12,
      hHeat=167500,
      lHeat=0,
      KRHeat=1000,
      TNHeat=1,
      HeaterOn=false,
      hCool=0,
      lCool=-1,
      KRCool=1000,
      TNCool=1,
      CoolerOn=false,
      TThresholdHeater=273.15 + 15,
      TThresholdCooler=273.15 + 22,
      withIdealThresholds=false);                     //not area specific: W_per_person/area => input will be number of persons
    annotation (Documentation(revisions="<html>
 <ul>
  <li>
  February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
  Adapting nrPeople and nrPeopleMachines to area specific approach 
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation.
  </li>
  <li>
  June, 2015, by Moritz Lauster:<br/>
  Implemented.
  </li>
 </ul>
 </html>",   info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &quot;Office&quot; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"));
  end BenchmarkConferenceRoom;

  record Ashrae140_900 "Ashrae140 900 Testcase"
    extends AixLib.DataBase.ThermalZones.ZoneBaseRecord(
      T_start=293.15,
      VAir=129.60000000000002,
      AZone=48,
      hRad=5.13,
      lat=0.87266462599716,
      nOrientations=1,
      AWin={12},
      ATransparent={12},
      hConWin=3.16,
      RWin=0.0133333333333,
      gWin=0.789,
      UWin=1.3,
      ratioWinConRad=0.03,
      AExt={21.6},
      hConExt=3.160000000000001,
      nExt=1,
      RExt={0.000985315078012},
      RExtRem=0.0274795299795,
      CExt={8775985.69078},
      AInt=48.0,
      hConInt=4.130000000000001,
      nInt=1,
      RInt={0.000491103488785},
      CInt={5373300.22817},
      AFloor=0,
      hConFloor=0,
      nFloor=1,
      RFloor={0.17413196439},
      RFloorRem=0.348263868943,
      CFloor={0.0902868158636},
      ARoof=48.0,
      hConRoof=1.0,
      nRoof=1,
      RRoof={0.000550791436374},
      RRoofRem=0.061807839516,
      CRoof={381586.716241},
      nOrientationsRoof=1,
      tiltRoof={0},
      aziRoof={0},
      wfRoof={1},
      aRoof=0.7,
      aExt=0.7,
      TSoil=283.15,
      hConWallOut=20.0,
      hRadWall=5,
      hConWinOut=20.0,
      hConRoofOut=20,
      hRadRoof=5,
      tiltExtWalls={1.5707963267949},
      aziExtWalls={0},
      wfWall={0.9},
      wfWin={1},
      wfGro=0.1,
      specificPeople=1/14,
      activityDegree=1.2,
      fixedHeatFlowRatePersons=125/100,
      ratioConvectiveHeatPeople=0.5,
      internalGainsMoistureNoPeople=0.5,
      internalGainsMachinesSpecific=20/100,
      ratioConvectiveHeatMachines=0.6,
      lightingPowerSpecific=420/100,
      ratioConvectiveHeatLighting=0.6,
      useConstantACHrate=false,
      baseACH=0.2,
      maxUserACH=1,
      maxOverheatingACH={3.0,2.0},
      maxSummerACH={1.0,273.15 + 10,273.15 + 17},
      winterReduction={0.2,273.15,273.15 + 10},
      withAHU=false,
      minAHU=0,
      maxAHU=12,
      hHeat=167500,
      lHeat=0,
      KRHeat=1000,
      TNHeat=1,
      HeaterOn=false,
      hCool=0,
      lCool=-1,
      KRCool=1000,
      TNCool=1,
      CoolerOn=false,
      TThresholdHeater=273.15 + 15,
      TThresholdCooler=273.15 + 22,
      withIdealThresholds=false);                     //not area specific: W_per_person/area => input will be number of persons
    annotation (Documentation(revisions="<html>
 <ul>
  <li>
  February 28, 2019, by Niklas Huelsenbeck, dja, mre:<br/>
  Adapting nrPeople and nrPeopleMachines to area specific approach 
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation.
  </li>
  <li>
  June, 2015, by Moritz Lauster:<br/>
  Implemented.
  </li>
 </ul>
 </html>",   info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Zone &quot;Office&quot; of an example building according to an office building with passive house standard. The building is divided in six zones, this is a typical zoning for an office building. </span></p>
</html>"));
  end Ashrae140_900;
end BaseClasses;
