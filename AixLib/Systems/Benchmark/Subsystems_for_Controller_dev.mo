within AixLib.Systems.Benchmark;
package Subsystems_for_Controller_dev
  "Contains Subsystem Modells for FMU Export"
  model Heat_Pump_System
    HeatpumpSystem heatpumpSystem(redeclare package Medium = MediumWater)
      annotation (Placement(transformation(extent={{-54,-18},{56,28}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature
      annotation (Placement(transformation(extent={{-36,-58},{-16,-38}})));
  equation
    connect(prescribedTemperature.port, heatpumpSystem.T_outside) annotation (
        Line(points={{-16,-48},{2,-48},{2,-15.4444},{1,-15.4444}}, color={191,0,
            0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Heat_Pump_System;

  model Thermal_Zone
      package MediumWater = AixLib.Media.Water
      annotation (choicesAllMatching=true);
      package MediumAir = AixLib.Media.AirIncompressible
      annotation (choicesAllMatching=true);
    ThermalZones.ReducedOrder.ThermalZone.ThermalZone        thermalZone5(
      redeclare package Medium = MediumAir,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      zoneParam=BaseClasses.BenchmarkOpenPlanOffice(),
      ROM(extWallRC(thermCapExt(each der_T(fixed=true))), intWallRC(thermCapInt(
              each der_T(fixed=true)))),
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      T_start=293.15,
      recOrSep=false,
      Heater_on=false,
      Cooler_on=false,
      nPorts=2)
      "Thermal zone"
      annotation (Placement(transformation(extent={{-8,46},{22,76}})));
    ModularAHU.VentilationUnit                ventilationUnit5(
      redeclare package Medium1 = MediumAir,
      redeclare package Medium2 = MediumWater,
      T_amb=293.15,
      m1_flow_nominal=1,
      m2_flow_nominal=1,
      cooler(redeclare HydraulicModules.Admix hydraulicModule(
          dIns=0.01,
          kIns=0.028,
          d=0.032,
          length=0.5,
          Kv=6.3,
          redeclare
            HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
            PumpInterface(pump(redeclare
                Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
          dp1_nominal=10,
          dp2_nominal=1000,
          dT_nom=10,
          Q_nom=10000)),
      heater(redeclare HydraulicModules.Admix hydraulicModule(
          dIns=0.01,
          kIns=0.028,
          d=0.032,
          length=0.5,
          Kv=6.3,
          redeclare
            HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
            PumpInterface(pump(redeclare
                Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))), dynamicHX(
          dp1_nominal=10,
          dp2_nominal=1000,
          dT_nom=10,
          Q_nom=2000)))
      annotation (Placement(transformation(extent={{-56,18},{-28,50}})));
    Tabs2 tabs4_5(
      redeclare package Medium = MediumWater,
      area=30*45,
      thickness=0.3,
      alpha=15)
      annotation (Placement(transformation(extent={{54,-10},{86,20}})));
    Modelica.Blocks.Sources.CombiTimeTable internalGains(
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      tableName="UserProfiles",
      fileName=Modelica.Utilities.Files.loadResource("modelica://AixLib/Resources/LowOrder_ExampleData/UserProfiles_18599_SIA_Besprechung_Sitzung_Seminar.txt"),
      columns={2,3,4},
      tableOnFile=false,
      table=[0,0,0.1,0,0; 3540,0,0.1,0,0; 3600,0,0.1,0,0; 7140,0,0.1,0,0; 7200,0,0.1,
          0,0; 10740,0,0.1,0,0; 10800,0,0.1,0,0; 14340,0,0.1,0,0; 14400,0,0.1,0,0;
          17940,0,0.1,0,0; 18000,0,0.1,0,0; 21540,0,0.1,0,0; 21600,0,0.1,0,0; 25140,
          0,0.1,0,0; 25200,0,0.1,0,0; 28740,0,0.1,0,0; 28800,0,0.1,0,0; 32340,0,0.1,
          0,0; 32400,0.6,0.6,1,1; 35940,0.6,0.6,1,1; 36000,1,1,1,1; 39540,1,1,1,1;
          39600,0.4,0.4,1,1; 43140,0.4,0.4,1,1; 43200,0,0.1,0,0; 46740,0,0.1,0,0;
          46800,0,0.1,0,0; 50340,0,0.1,0,0; 50400,0.6,0.6,1,1; 53940,0.6,0.6,1,1;
          54000,1,1,1,1; 57540,1,1,1,1; 57600,0.4,0.4,1,1; 61140,0.4,0.4,1,1; 61200,
          0,0.1,0,0; 64740,0,0.1,0,0; 64800,0,0.1,0,0; 68340,0,0.1,0,0; 68400,0,0.1,
          0,0; 71940,0,0.1,0,0; 72000,0,0.1,0,0; 75540,0,0.1,0,0; 75600,0,0.1,0,0;
          79140,0,0.1,0,0; 79200,0,0.1,0,0; 82740,0,0.1,0,0; 82800,0,0.1,0,0; 86340,
          0,0.1,0,0; 86400,0,0.1,0,0; 89940,0,0.1,0,0; 90000,0,0.1,0,0; 93540,0,0.1,
          0,0; 93600,0,0.1,0,0; 97140,0,0.1,0,0; 97200,0,0.1,0,0; 100740,0,0.1,0,0;
          100800,0,0.1,0,0; 104340,0,0.1,0,0; 104400,0,0.1,0,0; 107940,0,0.1,0,0;
          108000,0,0.1,0,0; 111540,0,0.1,0,0; 111600,0,0.1,0,0; 115140,0,0.1,0,0;
          115200,0,0.1,0,0; 118740,0,0.1,0,0; 118800,0.6,0.6,1,1; 122340,0.6,0.6,1,
          1; 122400,1,1,1,1; 125940,1,1,1,1; 126000,0.4,0.4,1,1; 129540,0.4,0.4,1,
          1; 129600,0,0.1,0,0; 133140,0,0.1,0,0; 133200,0,0.1,0,0; 136740,0,0.1,0,
          0; 136800,0.6,0.6,1,1; 140340,0.6,0.6,1,1; 140400,1,1,1,1; 143940,1,1,1,
          1; 144000,0.4,0.4,1,1; 147540,0.4,0.4,1,1; 147600,0,0.1,0,0; 151140,0,0.1,
          0,0; 151200,0,0.1,0,0; 154740,0,0.1,0,0; 154800,0,0.1,0,0; 158340,0,0.1,
          0,0; 158400,0,0.1,0,0; 161940,0,0.1,0,0; 162000,0,0.1,0,0; 165540,0,0.1,
          0,0; 165600,0,0.1,0,0; 169140,0,0.1,0,0; 169200,0,0.1,0,0; 172740,0,0.1,
          0,0; 172800,0,0.1,0,0; 176340,0,0.1,0,0; 176400,0,0.1,0,0; 179940,0,0.1,
          0,0; 180000,0,0.1,0,0; 183540,0,0.1,0,0; 183600,0,0.1,0,0; 187140,0,0.1,
          0,0; 187200,0,0.1,0,0; 190740,0,0.1,0,0; 190800,0,0.1,0,0; 194340,0,0.1,
          0,0; 194400,0,0.1,0,0; 197940,0,0.1,0,0; 198000,0,0.1,0,0; 201540,0,0.1,
          0,0; 201600,0,0.1,0,0; 205140,0,0.1,0,0; 205200,0.6,0.6,1,1; 208740,0.6,
          0.6,1,1; 208800,1,1,1,1; 212340,1,1,1,1; 212400,0.4,0.4,1,1; 215940,0.4,
          0.4,1,1; 216000,0,0.1,0,0; 219540,0,0.1,0,0; 219600,0,0.1,0,0; 223140,0,
          0.1,0,0; 223200,0.6,0.6,1,1; 226740,0.6,0.6,1,1; 226800,1,1,1,1; 230340,
          1,1,1,1; 230400,0.4,0.4,1,1; 233940,0.4,0.4,1,1; 234000,0,0.1,0,0; 237540,
          0,0.1,0,0; 237600,0,0.1,0,0; 241140,0,0.1,0,0; 241200,0,0.1,0,0; 244740,
          0,0.1,0,0; 244800,0,0.1,0,0; 248340,0,0.1,0,0; 248400,0,0.1,0,0; 251940,
          0,0.1,0,0; 252000,0,0.1,0,0; 255540,0,0.1,0,0; 255600,0,0.1,0,0; 259140,
          0,0.1,0,0; 259200,0,0.1,0,0; 262740,0,0.1,0,0; 262800,0,0.1,0,0; 266340,
          0,0.1,0,0; 266400,0,0.1,0,0; 269940,0,0.1,0,0; 270000,0,0.1,0,0; 273540,
          0,0.1,0,0; 273600,0,0.1,0,0; 277140,0,0.1,0,0; 277200,0,0.1,0,0; 280740,
          0,0.1,0,0; 280800,0,0.1,0,0; 284340,0,0.1,0,0; 284400,0,0.1,0,0; 287940,
          0,0.1,0,0; 288000,0,0.1,0,0; 291540,0,0.1,0,0; 291600,0.6,0.6,1,1; 295140,
          0.6,0.6,1,1; 295200,1,1,1,1; 298740,1,1,1,1; 298800,0.4,0.4,1,1; 302340,
          0.4,0.4,1,1; 302400,0,0.1,0,0; 305940,0,0.1,0,0; 306000,0,0.1,0,0; 309540,
          0,0.1,0,0; 309600,0.6,0.6,1,1; 313140,0.6,0.6,1,1; 313200,1,1,1,1; 316740,
          1,1,1,1; 316800,0.4,0.4,1,1; 320340,0.4,0.4,1,1; 320400,0,0.1,0,0; 323940,
          0,0.1,0,0; 324000,0,0.1,0,0; 327540,0,0.1,0,0; 327600,0,0.1,0,0; 331140,
          0,0.1,0,0; 331200,0,0.1,0,0; 334740,0,0.1,0,0; 334800,0,0.1,0,0; 338340,
          0,0.1,0,0; 338400,0,0.1,0,0; 341940,0,0.1,0,0; 342000,0,0.1,0,0; 345540,
          0,0.1,0,0; 345600,0,0.1,0,0; 349140,0,0.1,0,0; 349200,0,0.1,0,0; 352740,
          0,0.1,0,0; 352800,0,0.1,0,0; 356340,0,0.1,0,0; 356400,0,0.1,0,0; 359940,
          0,0.1,0,0; 360000,0,0.1,0,0; 363540,0,0.1,0,0; 363600,0,0.1,0,0; 367140,
          0,0.1,0,0; 367200,0,0.1,0,0; 370740,0,0.1,0,0; 370800,0,0.1,0,0; 374340,
          0,0.1,0,0; 374400,0,0.1,0,0; 377940,0,0.1,0,0; 378000,0.6,0.6,1,1; 381540,
          0.6,0.6,1,1; 381600,1,1,1,1; 385140,1,1,1,1; 385200,0.4,0.4,1,1; 388740,
          0.4,0.4,1,1; 388800,0,0.1,0,0; 392340,0,0.1,0,0; 392400,0,0.1,0,0; 395940,
          0,0.1,0,0; 396000,0.6,0.6,1,1; 399540,0.6,0.6,1,1; 399600,1,1,1,1; 403140,
          1,1,1,1; 403200,0.4,0.4,1,1; 406740,0.4,0.4,1,1; 406800,0,0.1,0,0; 410340,
          0,0.1,0,0; 410400,0,0.1,0,0; 413940,0,0.1,0,0; 414000,0,0.1,0,0; 417540,
          0,0.1,0,0; 417600,0,0.1,0,0; 421140,0,0.1,0,0; 421200,0,0.1,0,0; 424740,
          0,0.1,0,0; 424800,0,0.1,0,0; 428340,0,0.1,0,0; 428400,0,0.1,0,0; 431940,
          0,0.1,0,0; 432000,0,0,0,0; 435540,0,0,0,0; 435600,0,0,0,0; 439140,0,0,0,
          0; 439200,0,0,0,0; 442740,0,0,0,0; 442800,0,0,0,0; 446340,0,0,0,0; 446400,
          0,0,0,0; 449940,0,0,0,0; 450000,0,0,0,0; 453540,0,0,0,0; 453600,0,0,0,0;
          457140,0,0,0,0; 457200,0,0,0,0; 460740,0,0,0,0; 460800,0,0,0,0; 464340,0,
          0,0,0; 464400,0,0,0,0; 467940,0,0,0,0; 468000,0,0,0,0; 471540,0,0,0,0; 471600,
          0,0,0,0; 475140,0,0,0,0; 475200,0,0,0,0; 478740,0,0,0,0; 478800,0,0,0,0;
          482340,0,0,0,0; 482400,0,0,0,0; 485940,0,0,0,0; 486000,0,0,0,0; 489540,0,
          0,0,0; 489600,0,0,0,0; 493140,0,0,0,0; 493200,0,0,0,0; 496740,0,0,0,0; 496800,
          0,0,0,0; 500340,0,0,0,0; 500400,0,0,0,0; 503940,0,0,0,0; 504000,0,0,0,0;
          507540,0,0,0,0; 507600,0,0,0,0; 511140,0,0,0,0; 511200,0,0,0,0; 514740,0,
          0,0,0; 514800,0,0,0,0; 518340,0,0,0,0; 518400,0,0,0,0; 521940,0,0,0,0; 522000,
          0,0,0,0; 525540,0,0,0,0; 525600,0,0,0,0; 529140,0,0,0,0; 529200,0,0,0,0;
          532740,0,0,0,0; 532800,0,0,0,0; 536340,0,0,0,0; 536400,0,0,0,0; 539940,0,
          0,0,0; 540000,0,0,0,0; 543540,0,0,0,0; 543600,0,0,0,0; 547140,0,0,0,0; 547200,
          0,0,0,0; 550740,0,0,0,0; 550800,0,0,0,0; 554340,0,0,0,0; 554400,0,0,0,0;
          557940,0,0,0,0; 558000,0,0,0,0; 561540,0,0,0,0; 561600,0,0,0,0; 565140,0,
          0,0,0; 565200,0,0,0,0; 568740,0,0,0,0; 568800,0,0,0,0; 572340,0,0,0,0; 572400,
          0,0,0,0; 575940,0,0,0,0; 576000,0,0,0,0; 579540,0,0,0,0; 579600,0,0,0,0;
          583140,0,0,0,0; 583200,0,0,0,0; 586740,0,0,0,0; 586800,0,0,0,0; 590340,0,
          0,0,0; 590400,0,0,0,0; 593940,0,0,0,0; 594000,0,0,0,0; 597540,0,0,0,0; 597600,
          0,0,0,0; 601140,0,0,0,0; 601200,0,0,0,0; 604740,0,0,0,0])
      "Table with profiles for internal gains"
      annotation(Placement(transformation(extent={{-14,7},{0,21}})));

    Modelica.Blocks.Interfaces.RealOutput T_Air_out "Indoor air temperature"
      annotation (Placement(transformation(extent={{86,60},{106,80}})));
    Fluid.Sources.Boundary_pT          boundary6(
      redeclare package Medium = MediumWater,
      T=293.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=270,
          origin={86,-76})));
    Fluid.Sources.Boundary_pT          boundary1(
      redeclare package Medium = MediumWater,
      use_T_in=true,
      T=303.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=270,
          origin={54,-62})));
    Fluid.Sources.Boundary_pT          boundary2(
      redeclare package Medium = MediumWater,
      use_T_in=true,
      T=288.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=270,
          origin={64,-78})));
    Fluid.Sources.Boundary_pT          boundary3(
      redeclare package Medium = MediumWater,
      T=293.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=270,
          origin={78,-76})));
    Fluid.FixedResistances.HydraulicDiameter res(
      redeclare package Medium = MediumWater,
      m_flow_nominal=1,
      dh=0.05,
      length=1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},

          rotation=-90,
          origin={76,-32})));
    Fluid.FixedResistances.HydraulicDiameter res1(
      redeclare package Medium = MediumWater,
      m_flow_nominal=1,
      dh=0.05,
      length=1) annotation (Placement(transformation(extent={{10,-10},{-10,10}},

          rotation=90,
          origin={84,-32})));
    Modelica.Blocks.Interfaces.RealInput T_CCA_Hot_in
      "Prescribed boundary temperature"
      annotation (Placement(transformation(extent={{-108,-80},{-88,-60}})));
    Modelica.Blocks.Interfaces.RealInput T_CCA_Cold_in
      "Prescribed boundary temperature"
      annotation (Placement(transformation(extent={{-108,-94},{-90,-76}})));
    Fluid.Sources.Boundary_pT          boundary4(
      redeclare package Medium = MediumWater,
      T=293.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{5,-5},{-5,5}},
          rotation=270,
          origin={-27,-27})));
    Fluid.Sources.Boundary_pT          boundary5(
      redeclare package Medium = MediumWater,
      use_T_in=true,
      T=303.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=270,
          origin={-74,-16})));
    Fluid.Sources.Boundary_pT          boundary7(
      redeclare package Medium = MediumWater,
      use_T_in=true,
      T=288.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=270,
          origin={-38,-40})));
    Fluid.Sources.Boundary_pT          boundary8(
      redeclare package Medium = MediumWater,
      T=293.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=270,
          origin={-48,-20})));
    Fluid.FixedResistances.HydraulicDiameter res3(
      redeclare package Medium = MediumWater,
      m_flow_nominal=1,
      dh=0.05,
      length=1) annotation (Placement(transformation(extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-46,-2})));
    ModularAHU.Controller.CtrVentilationUnitTsetRoom ctrVentilationUnitTsetRoom(
        ctrVentilationUnitBasic=
          ctrVentilationUnitBasicctrVentilationUnitTsetRoom)
      annotation (Placement(transformation(extent={{-74,54},{-62,66}})));
    Controller.CtrTabs2 ctrTabs2_1(useExternalTset=true)
      annotation (Placement(transformation(extent={{-76,70},{-62,86}})));
    Fluid.FixedResistances.HydraulicDiameter res2(
      redeclare package Medium = MediumWater,
      m_flow_nominal=1,
      dh=0.05,
      length=1) annotation (Placement(transformation(extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-26,-2})));
    Modelica.Blocks.Interfaces.RealInput T_AHU_Hot_in
      "Prescribed boundary temperature"
      annotation (Placement(transformation(extent={{-108,-30},{-94,-16}})));
    BoundaryConditions.WeatherData.Bus weaBus1
      "Weather data bus"
      annotation (Placement(transformation(extent={{-96,84},{-76,104}})));
    Modelica.Blocks.Interfaces.RealInput Tset1
      "Connector of second Real input signal"
      annotation (Placement(transformation(extent={{-108,72},{-96,84}})));
    Modelica.Blocks.Interfaces.RealInput T_act1
      "Connector of measurement input signal"
      annotation (Placement(transformation(extent={{-112,50},{-94,68}})));
    Fluid.Sources.Boundary_pT boundaryExhaustAir(redeclare package Medium =
          MediumAir, nPorts=1)
                            annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=180,
          origin={-90,44})));
    Fluid.Sources.MassFlowSource_T     boundary9(
      redeclare package Medium = MediumAir,
      m_flow=10,
      use_T_in=true,
      T=293.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=180,
          origin={-78,26})));
  protected
    Modelica.Blocks.Interfaces.RealInput T_AHU_Cold_In
      "Prescribed boundary temperature"
      annotation (Placement(transformation(extent={{-106,-52},{-92,-38}})));
  equation
    connect(internalGains.y[1], thermalZone5.intGains[1]) annotation (Line(points={{0.7,14},
            {20,14},{20,47.2},{19,47.2}},                                color={0,
            0,127}));
    connect(ventilationUnit5.port_a2, thermalZone5.ports[1]) annotation (Line(
          points={{-28,43.6},{4,43.6},{4,50.2},{3.475,50.2}}, color={0,127,255}));
    connect(ventilationUnit5.port_b1, thermalZone5.ports[2]) annotation (Line(
          points={{-27.72,34},{12,34},{12,50.2},{10.525,50.2}}, color={0,127,255}));
    connect(tabs4_5.heatPort, thermalZone5.intGainsConv) annotation (Line(points={{70,
            21.3636},{70,53.5},{22,53.5}},      color={191,0,0}));
    connect(thermalZone5.TAir, T_Air_out)
      annotation (Line(points={{23.5,70},{96,70}}, color={0,0,127}));
    connect(res.port_b,boundary3. ports[1])
      annotation (Line(points={{76,-42},{76,-70},{78,-70}},
                                                        color={0,127,255}));
    connect(res1.port_b,boundary6. ports[1])
      annotation (Line(points={{84,-42},{84,-70},{86,-70}},
                                                 color={0,127,255}));
    connect(res.port_a, tabs4_5.port_b2) annotation (Line(points={{76,-22},{76,
            -9.72727},{76.4,-9.72727}}, color={0,127,255}));
    connect(res1.port_a, tabs4_5.port_b1) annotation (Line(points={{84,-22},{84,
            -9.72727},{82.8,-9.72727}}, color={0,127,255}));
    connect(boundary2.ports[1], tabs4_5.port_a2) annotation (Line(points={{64,
            -72},{64,-45},{63.6,-45},{63.6,-10}}, color={0,127,255}));
    connect(boundary1.ports[1], tabs4_5.port_a1) annotation (Line(points={{54,
            -56},{58,-56},{58,-10},{57.2,-10}}, color={0,127,255}));
    connect(boundary1.T_in, T_CCA_Hot_in) annotation (Line(points={{56.4,-69.2},
            {-34,-69.2},{-34,-70},{-98,-70}}, color={0,0,127}));
    connect(boundary2.T_in, T_CCA_Cold_in) annotation (Line(points={{66.4,-85.2},
            {-99,-85.2},{-99,-85}}, color={0,0,127}));
    connect(res3.port_b, boundary8.ports[1]) annotation (Line(points={{-46,-10},
            {-46,-14},{-48,-14}}, color={0,127,255}));
    connect(ctrVentilationUnitTsetRoom.genericAHUBus, ventilationUnit5.genericAHUBus)
      annotation (Line(
        points={{-61.88,59.94},{-61.88,53.95},{-42,53.95},{-42,53.36}},
        color={255,204,51},
        thickness=0.5));
    connect(ctrTabs2_1.tabsBus, tabs4_5.tabsBus) annotation (Line(
        points={{-62,78},{-14,78},{-14,3.77273},{53.84,3.77273}},
        color={255,204,51},
        thickness=0.5));
    connect(res2.port_a, ventilationUnit5.port_b4) annotation (Line(points={{
            -26,6},{-32,6},{-32,18},{-33.88,18}}, color={0,127,255}));
    connect(res2.port_b, boundary4.ports[1]) annotation (Line(points={{-26,-10},
            {-26,-22},{-27,-22}}, color={0,127,255}));
    connect(boundary5.ports[1], ventilationUnit5.port_a3) annotation (Line(
          points={{-74,-10},{-76,-10},{-76,10},{-50,10},{-50,18},{-50.4,18}},
          color={0,127,255}));
    connect(boundary7.T_in, T_AHU_Cold_In) annotation (Line(points={{-35.6,
            -47.2},{-99,-47.2},{-99,-45}}, color={0,0,127}));
    connect(res3.port_a, ventilationUnit5.port_b3) annotation (Line(points={{
            -46,6},{-46,12},{-46,18},{-44.8,18}}, color={0,127,255}));
    connect(boundary7.ports[1], ventilationUnit5.port_a4) annotation (Line(
          points={{-38,-34},{-38,18},{-39.2,18}}, color={0,127,255}));
    connect(boundary5.T_in, T_AHU_Hot_in) annotation (Line(points={{-71.6,-23.2},
            {-83.8,-23.2},{-83.8,-23},{-101,-23}}, color={0,0,127}));
    connect(thermalZone5.weaBus, weaBus1) annotation (Line(
        points={{-8,61},{-48,61},{-48,94},{-86,94}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(ctrTabs2_1.Tset, Tset1)
      annotation (Line(points={{-77.4,78},{-102,78}}, color={0,0,127}));
    connect(ctrVentilationUnitTsetRoom.T_act, T_act1) annotation (Line(points={
            {-75.2,60},{-92,60},{-92,59},{-103,59}}, color={0,0,127}));
    connect(ventilationUnit5.port_b2, boundaryExhaustAir.ports[1]) annotation (
        Line(points={{-55.72,43.6},{-81.86,43.6},{-81.86,44},{-84,44}}, color={
            0,127,255}));
    connect(boundary9.ports[1], ventilationUnit5.port_a1) annotation (Line(
          points={{-72,26},{-72,34},{-56,34}}, color={0,127,255}));
    connect(boundary9.T_in, weaBus1.TDryBul) annotation (Line(points={{-85.2,
            23.6},{-85.2,94},{-86,94}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Thermal_Zone;
end Subsystems_for_Controller_dev;
