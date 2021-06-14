within AixLib.Fluid.Examples;
package ERCBuilding
  extends Modelica.Icons.ExamplesPackage;

  model HeatingCircuit
  import DataBase;
  import HVAC;

  //Parameter

    parameter Modelica.SIunits.ThermodynamicTemperature Temp_Hot_Ini=304.700000000000
      "Init temperature Hot";

      parameter Modelica.SIunits.ThermodynamicTemperature Temp_Cold_Ini1[4]={280.307093000000, 280.340261000000, 280.475571000000, 281.960418000000};

     parameter Modelica.SIunits.ThermodynamicTemperature Temp_Cold_Ini=282.600000000000
      "Init temperature Cold";

    parameter Modelica.SIunits.ThermodynamicTemperature Temp_Hot_Ini1[4]={301.920000000000, 304.751250000000, 304.880000000000, 304.777500000000};

     parameter Real Vol=0.01 "compensating volume ";
     parameter Real Vol1=0.542 "compensating volume Heatpump Hot";

    parameter String resultFileName="result.txt"
      "File on which data is present";
    parameter String header="Objective function value" "Header for result file";

     parameter Modelica.SIunits.ThermodynamicTemperature T_start=293.15;
    //   parameter Modelica.SIunits.Pressure P_reference=101325;
    parameter Modelica.SIunits.Pressure P_reference=3*100000;

    parameter Modelica.SIunits.MassFlowRate mFlowNomIn=1
      "Nominal cold mass flow rate";

    replaceable package Water = AixLib.Media.Water annotation (Dialog(group="Medium"));
    replaceable package Air = Modelica.Media.Air.DryAirNasa annotation (Dialog(group="Medium"));

    inner Modelica.Blocks.Interfaces.RealOutput T_ref_outer;
    inner Modelica.Blocks.Interfaces.RealOutput p_ref_outer;
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-622,364},{-564,424}})));

      // Inputs

    parameter Boolean useExternValues=true
      "switch to true if external values should be used in simulation. Add filenames for CombiTimeTables below.";

      // internal Input

    //set path for external Inputs (if used)

      //General

    Modelica.Blocks.Sources.CombiTimeTable Toutdoor(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      tableName="Toutdoor",
      table=[0,273.15; 31536000,273.15],
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/Toutdoor.mat",
      tableOnFile=useExternValues)
      annotation (Placement(transformation(extent={{-534,264},{-580,310}})));

      //Consumers Cooling

      Modelica.Blocks.Sources.CombiTimeTable QCold(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      table=[0,20000; 31536000,20000],
      tableName="QCold",
      tableOnFile=useExternValues,
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/QCold.mat")
                                       annotation (Placement(transformation(
          extent={{24,-24},{-24,24}},
          rotation=0,
          origin={864,74})));

      Modelica.Blocks.Sources.CombiTimeTable TreturnCold(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      table=[0,273.15 + 15; 31536000,273.15 + 15],
      tableName="TreturnCold",
      tableOnFile=useExternValues,
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/TreturnCold.mat")
                                                   annotation (Placement(
          transformation(
          extent={{25,-25},{-25,25}},
          rotation=0,
          origin={861,-31})));
    Modelica.Blocks.Sources.CombiTimeTable Tgeo(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      table=[0,273.15 + 13; 31536000,273.15 + 13],
      tableName="Tgeo",
      tableOnFile=useExternValues,
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/Tgeo.mat")
      annotation (Placement(transformation(extent={{29,29},{-29,-29}},
          rotation=0,
          origin={765,-21})));
    Modelica.Blocks.Sources.CombiTimeTable QMediumCold(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      table=[0,20000; 31536000,20000],
      tableName="QMediumCold",
      tableOnFile=useExternValues,
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/QMediumCold.mat")
      annotation (Placement(transformation(extent={{27,-27},{-27,27}},
          rotation=0,
          origin={1049,-47})));
    Modelica.Blocks.Sources.CombiTimeTable TreturnMediumCold(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      table=[0,273.15 + 20; 31536000,273.15 + 20],
      tableName="TreturnMediumCold",
      tableOnFile=useExternValues,
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/TreturnMediumCold.mat")
                                                   annotation (Placement(
          transformation(
          extent={{25,25},{-25,-25}},
          rotation=0,
          origin={1047,87})));

      //FVU

      Modelica.Blocks.Sources.CombiTimeTable Troomset(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      table=[0,293.15; 31536000,293.15],
      tableName="Troomset",
      tableOnFile=useExternValues,
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/Troomset.mat")
      annotation (Placement(transformation(extent={{-574,-158},{-520,-104}})));

      Modelica.Blocks.Sources.CombiTimeTable co2room(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      table=[0,600; 31536000,600],
      tableName="co2room",
      tableOnFile=useExternValues,
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/co2room.mat")
                                   annotation (Placement(transformation(
          extent={{-26,-26},{26,26}},
          rotation=0,
          origin={-542,-38})));

      //Heating Consumers

    HeattransferHT heattransferHT(redeclare package Water = Water) annotation (Placement(transformation(
            rotation=0, extent={{-198,-168},{-76,-228}})));
    Modelica.Blocks.Sources.CombiTimeTable TreturnHot(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      table=[0,273.15 + 27; 31536000,273.15 + 27],
      tableName="TreturnHot",
      tableOnFile=useExternValues,
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/TreturnHot.mat")
      annotation (Placement(transformation(extent={{-354,-38},{-400,8}})));

      Modelica.Blocks.Sources.CombiTimeTable QHot(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      table=[0,20000; 31536000,20000],
      tableName="QHot",
      tableOnFile=useExternValues,
      fileName="D:/Git/Publications/Bericht Geothermie/Quellen/Dymola/InputData/Qhot.mat")
                                       annotation (Placement(transformation(
          extent={{23,-23},{-23,23}},
          rotation=0,
          origin={-381,135})));

  // Subsystems

     //Control Strategy

      Control.SupervisoryControl.MainControllerLTC mainControllerLTC(n_cold=4,
        n_warm=4)
      annotation (Placement(transformation(extent={{94,112},{406,258}})));

      //FVU

    FVU fVU1(
      redeclare package Water = Water,
      redeclare package Air = Air,
      T_start=T_start) annotation (Placement(transformation(rotation=0, extent={{122,
              -618},{290,-514}})));

      // Heatpump

    Heatpump heatpump(
      redeclare package Water = Water,
      heatStorage(layer(T_start= Temp_Hot_Ini1)),
      coldStorage(layer(T_start=Temp_Cold_Ini1)),
      volHPHotIn(V=Vol1, T_start=Temp_Hot_Ini),
      volHPColdIn(V=Vol, T_start=Temp_Cold_Ini),
      volHPColdOut(V=Vol, T_start=Temp_Cold_Ini),
      Vol=Vol) annotation (Placement(transformation(rotation=0, extent={{134,-414},
              {294,-318}})));

       // Glycol Cooler
    GlycolCooler glycolCooler annotation (Placement(transformation(
          rotation=0,
          extent={{-81,-53},{81,53}},
          origin={215,-143})));
    Modelica.Fluid.Vessels.ClosedVolume volume(redeclare package Medium =
                 Water,use_portsData=false,nPorts=3, V=Vol) annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={46,-466})));

       //GTF

     GTF GeothermalField(redeclare package Water = Water) annotation (Placement(transformation(
            rotation=0, extent={{-37,36},{37,-36}},
          origin={647,-176})));

  //Consumer Modell (Varios)

    BaseClasses.ConsumerModel lowTempConsumer_cold(
      T_flow_Initial=Temp_Cold_Ini,
      Type_of_Consumer=true,
      m_flow_min=0.0031,
      n=1,
      m_flow_max=6) annotation (Placement(transformation(
          extent={{-51,-49},{51,49}},
          rotation=90,
          origin={819,-271})));

    BaseClasses.SwitchingUnit switchingUnit
      annotation (Placement(transformation(extent={{-45,42},{45,-42}},
          rotation=90,
          origin={810,-539})));
    BaseClasses.ConsumerModel mediumLowTempConsumer_cold(
      T_flow_Initial=Temp_Cold_Ini,
      Type_of_Consumer=true,
      m_flow_min=0.0031,
      n=1,
      m_flow_max=5) annotation (Placement(transformation(
          extent={{-68,45},{68,-45}},
          rotation=270,
          origin={755,-644})));

  // Components

    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening
     HK11Y2(redeclare package Medium =
          Water,
      m_flow_nominal=2,
      dpValve_nominal=6000)           annotation (Placement(transformation(
          extent={{15,-14.5},{-15,14.5}},
          rotation=0,
          origin={469,-147.5})));

       Modelica.Fluid.Sensors.TemperatureTwoPort LTC_flow_Temp(redeclare
      package   Medium =
                 Water) annotation (Placement(transformation(
          extent={{-5,4},{5,-4}},
          rotation=180,
          origin={-301,-238})));

     // Pipe volume
    Modelica.Fluid.Vessels.ClosedVolume vol_Cons_Hot_Out(
      redeclare package Medium = Water,
      use_portsData=false,
      V=Vol,
      T_start=Temp_Hot_Ini,
      nPorts=4)
      annotation (Placement(transformation(extent={{-232,-266},{-220,-254}})));
    Modelica.Fluid.Vessels.ClosedVolume vol_Cons_Cold_In(
      redeclare package Medium = Water,
      use_portsData=false,
      V=Vol,
      nPorts=7,
      T_start=Temp_Cold_Ini)
      annotation (Placement(transformation(extent={{532,-280},{544,-268}})));
    Modelica.Fluid.Vessels.ClosedVolume vol_Cons_Cold_Out(
      redeclare package Medium = Water,
      use_portsData=false,
      V=Vol,
      nPorts=5,
      T_start=Temp_Cold_Ini)
      annotation (Placement(transformation(extent={{6,-6},{-6,6}},
          rotation=0,
          origin={684,-310})));

    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening
    HK12Y2(redeclare package Medium =
          Water,
      m_flow_nominal=2,
      dpValve_nominal=6000)           annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={476,-393})));
    Modelica.Fluid.Vessels.ClosedVolume vol_Cons_Cold_Out1(
      redeclare package Medium = Water,
      use_portsData=false,
      V=Vol,
      nPorts=3,
      T_start=Temp_Cold_Ini)
      annotation (Placement(transformation(extent={{6,-6},{-6,6}},
          rotation=-90,
          origin={880,-368})));

    AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance(
      redeclare package Medium = Water,
      m_flow_nominal=5,
      dp_nominal=30000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={868,-342})));
    AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance1(
      redeclare package Medium = Water,
      m_flow_nominal=5,
      dp_nominal=30000) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={736,-412})));
    AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance2(
      redeclare package Medium = Water,
      m_flow_nominal=5,
      dp_nominal=30000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={800,-560})));
    AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance4(
      redeclare package Medium = Water,
      m_flow_nominal=5,
      dp_nominal=30000) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={638,-576})));
    AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance3(
      redeclare package Medium = Water,
      m_flow_nominal=0.1,
      dp_nominal=10000)
             annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={328,-534})));
     AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance5(
      redeclare package Medium = Water,
      m_flow_nominal=0.1,
      dp_nominal=10000)
             annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={328,-556})));
    BaseClasses.ConsumerConnection consumerConnection
      annotation (Placement(transformation(extent={{458,-586},{350,-484}})));
    AixLib.Fluid.Sources.Boundary_pT expansionVessel(
      redeclare package Medium = Water,
      nPorts=1,
      p=200000) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={504,-270})));
    AixLib.Fluid.Sources.Boundary_pT expansionVessel1(
      redeclare package Medium = Water,
      p=200000,
      nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-216,-298})));
     AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance6(
      redeclare package Medium = Water,
      m_flow_nominal=0.1,
      dp_nominal=10000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={494,-514})));
     AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance7(
      redeclare package Medium = Water,
      m_flow_nominal=0.1,
      dp_nominal=10000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={690,-434})));
     AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance12(
      redeclare package Medium = Water,
      m_flow_nominal=0.1,
      dp_nominal=10000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=90,
          origin={-228,-468})));
     AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance13(
      redeclare package Medium = Water,
      m_flow_nominal=0.1,
      dp_nominal=10000) annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=180,
          origin={88,-546})));
    BaseClasses.ConsumerModel mediumLowTempConsumer_cold1(
      T_flow_Initial=Temp_Cold_Ini,
      m_flow_min=0.0031,
      n=1,
      m_flow_max=5,
      Type_of_Consumer=false) annotation (Placement(transformation(
          extent={{-53,-69},{53,69}},
          rotation=180,
          origin={-373,-265})));

       //Outputs
    output Boolean Start=mainControllerLTC.stateMachine.active_state[1];
    output Boolean coolingMode1=mainControllerLTC.stateMachine.active_state[2];
    output Boolean coolingMode2_1=mainControllerLTC.stateMachine.active_state[3];
    output Boolean coolingMode2_2=mainControllerLTC.stateMachine.active_state[4];
    output Boolean coolingMode3_1=mainControllerLTC.stateMachine.active_state[5];
    output Boolean heatingMode1=mainControllerLTC.stateMachine.active_state[6];
    output Boolean hPCommand=mainControllerLTC.HPCommand;
    output Boolean globalHeatingMode=hold(mainControllerLTC.stateMachine.heatingMode);

    Modelica.Blocks.Interaction.Show.RealValue realValue
      "Reecooling is realized usin one three-way valve instead of two valves (see Heatpump Cycle \"Valve_GC\")"
      annotation (Placement(transformation(extent={{230,76},{250,96}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue1
      "Control of HK12Y2 is outsourced to Glycol Cooler Subsystem. It is controlled in the opposite way depending on opening of HK11 Y2."
      annotation (Placement(transformation(extent={{282,76},{302,96}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue2
      "In the model the geothermic field is connected directly to the consumers. In the real a heatexchanger is used and these pump realises the massflow from the GTF to theGTF- heatexchanger."
      annotation (Placement(transformation(extent={{206,76},{186,96}})));

  equation
    T_ref_outer = Toutdoor.y[1];
    p_ref_outer = P_reference;

    connect(switchingUnit.port_b3, vol_Cons_Cold_In.ports[1]) annotation (Line(
          points={{801.6,-494},{801.6,-404},{782,-404},{782,-384},{538,-384},{538,
            -282},{540,-282},{540,-280},{535.943,-280}},                 color={0,
            127,255}));
    connect(HK12Y2.port_b, vol_Cons_Cold_Out.ports[1]) annotation (Line(points={{482,
            -393},{534,-393},{534,-394},{552,-394},{584,-394},{584,-394},{685.92,-394},
            {685.92,-316}},                           color={0,127,255}));
    connect(switchingUnit.port_b2, vol_Cons_Cold_Out1.ports[1]) annotation (Line(
          points={{835.2,-494},{858,-494},{858,-370},{872,-370},{872,-369.6},{874,
            -369.6}},                                 color={0,127,255}));
    connect(vol_Cons_Cold_Out1.ports[2], vol_Cons_Cold_Out.ports[2]) annotation (
        Line(points={{874,-368},{874,-368},{862,-368},{684,-368},{684,-334},{684.96,
            -334},{684.96,-316}},
          color={0,127,255}));
    connect(vol_Cons_Cold_Out1.ports[3], hydraulicResistance.port_a) annotation (
        Line(points={{874,-366.4},{874,-366.4},{874,-342}},      color={0,127,255}));
    connect(hydraulicResistance.port_b, lowTempConsumer_cold.port_a)
      annotation (Line(points={{862,-342},{862,-342},{838,-342},{838.6,-342},{838.6,
            -322}},                                  color={0,127,255}));
    connect(lowTempConsumer_cold.port_b, hydraulicResistance1.port_a) annotation (
       Line(points={{799.4,-322},{786,-322},{786,-336},{742,-336},{742,-412}},
                                                    color={0,127,255}));
    connect(hydraulicResistance1.port_b, vol_Cons_Cold_In.ports[2]) annotation (
        Line(points={{730,-412},{730,-412},{728,-412},{536.629,-412},{536.629,-280}},
                                                                       color={0,
            127,255}));
    connect(mediumLowTempConsumer_cold.port_a, hydraulicResistance2.port_a)
      annotation (Line(points={{773,-576},{790,-576},{800,-576},{800,-566}},
                                                    color={0,127,255}));
    connect(hydraulicResistance2.port_b, switchingUnit.port_b1)
      annotation (Line(points={{800,-554},{835.2,-554},{835.2,-584}},
                                                     color={0,127,255}));
    connect(mediumLowTempConsumer_cold.port_b, hydraulicResistance4.port_a)
      annotation (Line(points={{737,-576},{644,-576}},        color={0,127,255}));
    connect(hydraulicResistance4.port_b, vol_Cons_Cold_In.ports[3]) annotation (
        Line(points={{632,-576},{632,-576},{630,-576},{538,-576},{538,-426},{537.314,
            -426},{537.314,-280}},                              color={0,127,255}));
    connect(fVU1.Cooler_Return,hydraulicResistance5.port_a) annotation (Line(
          points={{290,-555.6},{340,-555.6},{340,-556},{322,-556}},     color={0,
            127,255}));
    connect(fVU1.port_a1,          hydraulicResistance3.port_b) annotation (Line(
          points={{290,-534.8},{308,-534.8},{308,-534},{326,-534},{322,-534}},
                                                 color={0,127,255}));
    connect(consumerConnection.port_b2, hydraulicResistance3.port_a) annotation (
        Line(points={{350,-514.6},{350,-534},{334,-534}},      color={0,127,255}));
    connect(hydraulicResistance5.port_b, consumerConnection.port_a2) annotation (
        Line(points={{334,-556},{340,-556},{332,-556},{332,-552},{334,-552},{334,
            -554},{342,-554},{342,-555.4},{350,-555.4}},       color={0,127,255}));
    connect(expansionVessel.ports[1], vol_Cons_Cold_In.ports[4]) annotation (Line(
          points={{504,-280},{508,-280},{508,-358},{538,-358},{538,-280}},
                                                            color={0,127,255}));
    connect(consumerConnection.port_b1, hydraulicResistance6.port_b) annotation (
        Line(points={{458,-514.6},{488,-514.6},{488,-514}},
                                                    color={0,127,255}));
    connect(hydraulicResistance6.port_a, vol_Cons_Cold_In.ports[5]) annotation (
        Line(points={{500,-514},{500,-514},{540,-514},{540,-510},{540,-438},{538.686,
            -438},{538.686,-280}},                         color={0,127,255}));
    connect(vol_Cons_Cold_Out.ports[3], hydraulicResistance7.port_b) annotation (
        Line(points={{684,-316},{684,-386},{682,-386},{688,-386},{688,-426},{686,-426},
            {686,-428},{690,-428}},                             color={0,127,255}));
    connect(hydraulicResistance7.port_a, consumerConnection.port_a1) annotation (
        Line(points={{690,-440},{690,-555.4},{458,-555.4}},
                                                     color={0,127,255}));
    connect(hydraulicResistance12.port_b, vol_Cons_Hot_Out.ports[1]) annotation (
        Line(points={{-228,-462},{-228,-462},{-228,-296},{-228,-266},{-227.8,-266}},
                                                                    color={0,127,
            255}));
    connect(expansionVessel1.ports[1], vol_Cons_Hot_Out.ports[2]) annotation (
        Line(points={{-216,-288},{-226,-288},{-226,-280},{-226,-274},{-226,-266},{
            -226.6,-266}},
                  color={0,127,255}));

    connect(mainControllerLTC.massFlowHK13P3, switchingUnit.massFlowHK13P3)
      annotation (Line(points={{409.467,150.933},{680,150.933},{680,150},{912,150},
            {912,-452},{908,-452},{908,-505.7},{852,-505.7}},
                          color={0,0,127}));
    connect(mainControllerLTC.openingHK13K3, switchingUnit.openingHK13K3)
      annotation (Line(points={{409.467,177.213},{688,177.213},{688,178},{868,178},
            {924,178},{924,-474},{898,-474},{898,-525.5},{852,-525.5}}, color={0,0,
            127}));
    connect(switchingUnit.openingHK13Y3, mainControllerLTC.openingHK13Y3)
      annotation (Line(points={{852,-550.7},{852,-498},{934,-498},{934,-415.9},{
            934,203.493},{409.467,203.493}},                                color=
           {0,0,127}));
    connect(switchingUnit.openingHK13Y2, mainControllerLTC.openingHK13Y2)
      annotation (Line(points={{852,-575},{882,-575},{882,-522},{950,-522},{950,
            162},{948,162},{948,228},{668,228},{668,228.8},{409.467,228.8}},
                           color={0,0,127}));
    connect(mainControllerLTC.openingHK13Y1, switchingUnit.openingHK13Y1)
      annotation (Line(points={{411.2,247.293},{411.2,250},{964,250},{964,-544},
            {774,-544},{774,-584},{793.62,-584}},
                          color={0,0,127}));
    connect(hydraulicResistance12.port_a,fVU1.Heater_Return) annotation (Line(
          points={{-228,-474},{-228,-566},{122,-566}},             color={0,127,
            255}));

    connect(LTC_flow_Temp.port_b, mediumLowTempConsumer_cold1.port_a) annotation (
       Line(points={{-306,-238},{-318,-238},{-318,-237.4},{-320,-237.4}},
                                                              color={0,127,255}));
    connect(LTC_flow_Temp.T, mainControllerLTC.LTCFlowTemp) annotation (Line(
          points={{-301,-233.6},{-301,90},{124,90},{124,100},{113.067,100},{113.067,
            112.973}},
          color={0,0,127}));
    connect(Toutdoor.y[1],fVU1.outdoorTemperature)           annotation (Line(
          points={{-582.3,287},{-582.3,-678},{140,-678},{140,-618},{138.8,-618}},
          color={0,0,127}));
    connect(Toutdoor.y[1],heattransferHT.TAmbient)
                                               annotation (Line(points={{-582.3,
            287},{-582.3,198},{-268,198},{-268,-220},{-195.289,-220},{-195.289,-218.4}},
          color={0,0,127}));
    connect(Toutdoor.y[1], mainControllerLTC.outdoorTemperature) annotation (Line(
          points={{-582.3,287},{-582.3,198},{-268,198},{-268,200},{-96,200},{-96,
            200.087},{94.8667,200.087}},
                              color={0,0,127}));
    connect(Troomset.y[1], fVU1.roomSetTemperature) annotation (Line(points={{-517.3,
            -131},{-517.3,-130},{-508,-130},{-508,-612},{-154,-612},{-154,-607.6},
            {122,-607.6}},                                       color={0,0,127}));

    connect(co2room.y[1], fVU1.co2Concentration) annotation (Line(points={{-513.4,
            -38},{-484,-38},{-484,-586},{-314,-586},{-314,-586.8},{122,-586.8}},
                                                            color={0,0,127}));
    connect(glycolCooler.openingValveReCooling, heatpump.openingReCoolingValve)
      annotation (Line(points={{136.531,-189.375},{136.531,-189.375},{114,-189.375},
            {114,-190},{114,-196},{114,-342},{134,-342},{134,-343.6},{132,-343.6}},
                                 color={0,0,127}));
    connect(heatpump.mFlowRecooler, glycolCooler.massFlowGC) annotation (Line(
          points={{136,-365.543},{136,-362},{100,-362},{100,-162},{134.911,-162},
            {134.911,-162.213}},                              color={0,0,127}));

    connect(heatpump.heatStorageTemperature, glycolCooler.heatStorageTemperatures)
      annotation (Line(points={{137.333,-388.4},{137.333,-388.4},{82,-388.4},{82,
            -146},{130,-146},{130,-145.65},{134.81,-145.65}},
                                          color={0,0,127}));
    connect(heatpump.temperatureColdStorage, mainControllerLTC.temperatures_cold)
      annotation (Line(points={{263,-324.4},{263,-296},{264,-296},{264,-268},{-16,
            -268},{-60,-268},{-60,186},{-4,186},{-4,186.947},{92.2667,186.947}},
                                     color={0,0,127}));
    connect(heatpump.heatStorageTemperature, mainControllerLTC.temperatures_warm)
      annotation (Line(points={{137.333,-388.4},{137.333,-384},{136,-384},{136,-386},
            {106,-386},{106,-388},{36,-388},{14,-388},{14,153.367},{89.6667,153.367}},
                                                                         color={0,
            0,127}));
    connect(heatpump.evapTemp, mainControllerLTC.evapTemp) annotation (Line(
          points={{138,-411.257},{138,-410},{58,-410},{30,-410},{30,130},{52,130},
            {91.4,130},{91.4,131.953}},                                     color=
           {0,0,127}));
    connect(mainControllerLTC.openingHK11Y1, glycolCooler.openingHK11Y1)
      annotation (Line(points={{180.667,109.08},{182,109.08},{182,102},{182,60},
            {36,60},{36,-108.219},{135.215,-108.219}},
                       color={0,0,127}));
    connect(heatpump.massFlowHStotal, glycolCooler.massFlowTotal) annotation (
        Line(points={{244,-322.571},{244,-322.571},{244,-300},{70,-300},{70,-98},
            {124,-98},{124,-99.275},{135.62,-99.275}},                    color={0,
            0,127}));
    connect(Toutdoor.y[1], glycolCooler.temperatureOutside) annotation (Line(
          points={{-582.3,287},{-582.3,198},{-268,198},{-268,-116},{22,-116},{80,
            -116},{80,-115.838},{134.81,-115.838}},
          color={0,0,127}));
    connect(hydraulicResistance13.port_a, volume.ports[1]) annotation (Line(
          points={{82,-546},{64,-546},{46,-546},{46,-516},{46,-476},{43.3333,-476}},
                                                                 color={0,127,255}));
    connect(mediumLowTempConsumer_cold1.port_b, volume.ports[2]) annotation (Line(
          points={{-320,-292.6},{-320,-314.8},{-320,-484},{36,-484},{36,-476},{46,
            -476}},                                                    color={0,127,
            255}));
    connect(vol_Cons_Cold_In.ports[6], HK11Y2.port_a) annotation (Line(points={{539.371,
            -280},{536,-280},{536,-284},{526,-284},{526,-160},{528,-160},{528,-147.5},
            {484,-147.5}},                       color={0,127,255}));
    connect(HK11Y2.port_b, glycolCooler.port_a1) annotation (Line(points={{454,-147.5},
            {426,-147.5},{426,-148},{316,-148},{316,-135.713},{296,-135.713}},
                                                      color={0,127,255}));
    connect(glycolCooler.port_b1, vol_Cons_Cold_Out.ports[4]) annotation (Line(
          points={{295.19,-117.825},{295.19,-124},{570,-124},{570,-350},{594,-350},
            {683.04,-350},{683.04,-316}},
                      color={0,127,255}));
    connect(mainControllerLTC.openingHK11Y2, glycolCooler.openingHK11Y2)
      annotation (Line(points={{409.467,134.387},{428,134.387},{428,134},{470,134},
            {470,-102.919},{293.165,-102.919}},
                       color={0,0,127}));
    connect(mainControllerLTC.openingHK11Y2, HK11Y2.y) annotation (Line(points={{409.467,
            134.387},{428,134.387},{428,134},{470,134},{470,-104},{470,-130.1},{
            469,-130.1}},                                  color={0,0,127}));
    connect(TreturnCold.y, lowTempConsumer_cold.Temp_return_in) annotation (Line(
          points={{833.5,-31},{828,-31},{828,-32},{824,-32},{824,-126},{838.6,-126},
            {838.6,-220}}, color={0,0,127}));
    connect(glycolCooler.SignalHK12Y2, HK12Y2.y) annotation (Line(points={{299.24,
            -162.875},{388,-162.875},{388,-162},{476,-162},{476,-164},{476,-385.8}},
                                                                    color={0,0,127}));
    connect(QMediumCold.y[1], mediumLowTempConsumer_cold.Q_dot_in[1]) annotation (
       Line(points={{1019.3,-47},{1019.3,-390},{1014,-390},{1014,-748},{737,-748},
            {737,-712}},                               color={0,0,127}));
    connect(TreturnMediumCold.y[1], mediumLowTempConsumer_cold.Temp_return_in[1])
      annotation (Line(points={{1019.5,87},{998,87},{998,88},{986,88},{986,-114},{
            986,-732},{773,-732},{773,-712}}, color={0,0,127}));
    connect(QCold.y[1], lowTempConsumer_cold.Q_dot_in[1]) annotation (Line(points={{837.6,
            74},{799.4,74},{799.4,-220}},      color={0,0,127}));
    connect(Tgeo.y[1], GeothermalField.TinGTF) annotation (Line(points={{733.1,
            -21},{724,-21},{724,-24},{724,-154},{704,-154},{704,-150.35},{684,
            -150.35}},                                     color={0,0,127}));
    connect(mainControllerLTC.GTFTempReturn, GeothermalField.TreturnGTF)
      annotation (Line(points={{94,250.213},{18,250.213},{18,288},{694,288},{694,
            -180},{694,-175.55},{684,-175.55}}, color={0,0,127}));
    connect(mainControllerLTC.GTFTempFlow, GeothermalField.TflowGTF) annotation (
        Line(points={{94,227.827},{42,227.827},{42,228},{10,228},{8,228},{8,224},
            {8,298},{704,298},{704,-188},{704,-195.35},{684,-195.35}},
                        color={0,0,127}));
    connect(heattransferHT.port_b1, vol_Cons_Hot_Out.ports[3]) annotation (Line(
          points={{-155.526,-228},{-174,-228},{-174,-278},{-224,-278},{-224,-266},
            {-225.4,-266}}, color={0,127,255}));
    connect(vol_Cons_Hot_Out.ports[4], LTC_flow_Temp.port_a) annotation (Line(
          points={{-224.2,-266},{-224,-266},{-224,-272},{-244,-272},{-244,-238},{-296,
            -238}},                                                   color={0,127,
            255}));
    connect(QHot.y[1], mediumLowTempConsumer_cold1.Q_dot_in[1]) annotation (Line(
          points={{-406.3,135},{-460,135},{-460,-290},{-426,-290},{-426,-292.6}},
          color={0,0,127}));
    connect(GeothermalField.port_b, switchingUnit.port_a) annotation (Line(points={{607.886,
            -166.55},{607.886,-174},{586,-174},{586,-522},{598,-522},{738,-522},
            {738,-575},{768,-575}},             color={0,127,255}));
    connect(GeothermalField.port_a, switchingUnit.port_b) annotation (Line(points={{607.886,
            -191.75},{607.886,-196},{596,-196},{596,-478},{594,-478},{734,-478},
            {768,-478},{768,-530}},             color={0,127,255}));
    connect(hydraulicResistance13.port_b, fVU1.port_a) annotation (Line(points={{94,
            -546},{122,-546},{122,-545.2}}, color={0,127,255}));
    connect(TreturnHot.y[1], mediumLowTempConsumer_cold1.Temp_return_in[1])
      annotation (Line(points={{-402.3,-15},{-402.3,-128.5},{-426,-128.5},{-426,-237.4}},
          color={0,0,127}));
    connect(mainControllerLTC.massFlowHK12P2, heatpump.mflowHPCold) annotation (
        Line(points={{392.133,111.027},{392.133,-86},{392,-86},{392,-284},{283,-284},
            {283,-324.4}},       color={0,0,127}));
    connect(mainControllerLTC.HPCommand, heatpump.OnOffHP) annotation (Line(
          points={{345.333,109.08},{345.333,-84},{346,-84},{346,-276},{223,-276},
            {223,-323.486}}, color={255,0,255}));
    connect(mainControllerLTC.mode, heatpump.modeHP) annotation (Line(points={{312.4,
            110.053},{312.4,-68},{312,-68},{312,-246},{197.667,-246},{197.667,-323.486}},
                                color={255,0,255}));
    connect(mainControllerLTC.massFlowHK12P1, heatpump.mflowHPHot) annotation (
        Line(points={{144.267,111.027},{144.267,76},{2,76},{-2,76},{-2,-436},{244,
            -436},{244,-414.914},{244.667,-414.914}}, color={0,0,127}));
    connect(heatpump.fluidportBottom_Cold, HK12Y2.port_a) annotation (Line(points={{292.667,
            -397.543},{382.333,-397.543},{382.333,-393},{470,-393}},
          color={0,127,255}));
    connect(heatpump.fluidportTop_Cold, vol_Cons_Cold_In.ports[7]) annotation (
        Line(points={{295.333,-361.886},{539.667,-361.886},{539.667,-280},{540.057,
            -280}},         color={0,127,255}));
    connect(volume.ports[3], heatpump.fluidportBottom_Hot) annotation (Line(
          points={{48.6667,-476},{206,-476},{206,-414},{205,-414}}, color={0,127,
            255}));
    connect(heatpump.fluidportGC_flow, glycolCooler.port_b) annotation (Line(
          points={{167.333,-323.486},{167.333,-316},{168,-316},{168,-310},{60,-310},
            {60,-136},{134,-136},{134,-136.375}},       color={0,127,255}));
    connect(heatpump.fluidportGC_return, glycolCooler.port_a) annotation (Line(
          points={{147,-323.486},{147,-322},{44,-322},{44,-124},{134,-124},{134,
            -124.45}}, color={0,127,255}));
    connect(mainControllerLTC.openingHK12Y1, realValue.numberPort) annotation (
        Line(points={{227.467,109.08},{227.467,97.54},{228.5,97.54},{228.5,86}},
          color={0,0,127}));
    connect(mainControllerLTC.openingHK12Y2, realValue1.numberPort) annotation (
        Line(points={{276,110.053},{278,110.053},{278,86},{280.5,86}}, color={0,0,
            127}));
    connect(mainControllerLTC.massFlowHK13P1, realValue2.numberPort) annotation (
        Line(points={{210.133,109.08},{210.133,97.54},{207.5,97.54},{207.5,86}},
          color={0,0,127}));
    connect(heatpump.fluidportTop_Hot, heattransferHT.port_a) annotation (Line(
          points={{183.667,-414},{-88,-414},{-88,-227.88},{-83.9074,-227.88}},
          color={0,127,255}));
    connect(mainControllerLTC.HECommand, heattransferHT.WT03Requirement)
      annotation (Line(points={{239.6,260.92},{-227.2,260.92},{-227.2,-177.6},{-196.193,
            -177.6}},          color={255,127,0}));
    connect(heatpump.onOff1, mainControllerLTC.HPComand) annotation (Line(
          points={{130.667,-376.514},{-18,-376.514},{-18,216.147},{92.2667,216.147}},
                       color={255,0,255}));
      annotation (Line(points={{392.133,111.027},{398,111.027},{398,-302},{378,-302},
            {378,-304},{283,-304},{283,-324.4}},
                                color={0,0,127}),
                  Placement(transformation(extent={{-468,-94},{-448,-74}})),
      experiment(
        StopTime=30000,
        Interval=10,
        __Dymola_Algorithm="Esdirk23a"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-660,-800},{1080,460}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-660,-800},{
              1080,460}}),
                      graphics={
          Rectangle(
            extent={{-308,-486},{726,26}},
            lineColor={215,215,215},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-310,24},{726,354}},
            lineColor={215,215,215},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-660,-166},{-672,-798},{208,-798},{208,-454},{-308,-454},{-308,
                -164},{-660,-166}},
            lineColor={255,85,85},
            fillColor={255,85,85},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-196,-736},{158,-786}},
            lineColor={135,0,0},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid,
            textString="Consumers Heating"),
          Polygon(
            points={{1078,-164},{1076,-798},{208,-796},{208,-452},{716,-452},{714,
                -160},{1078,-164}},
            lineColor={85,170,255},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{250,-736},{604,-786}},
            lineColor={28,108,200},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid,
            textString="Consumers Cooling"),
          Text(
            extent={{72,-12},{308,-56}},
            lineColor={106,106,106},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Energy 
Conversion"),
          Text(
            extent={{124,352},{310,302}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="Main Control"),
          Polygon(
            points={{-662,-166},{-666,464},{1076,462},{1074,-164},{708,-160},{
                704,356},{-312,356},{-314,-166},{-662,-166}},
            lineColor={215,215,215},
            fillColor={213,255,170},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{64,440},{320,382}},
            lineColor={0,140,72},
            fillColor={170,255,85},
            fillPattern=FillPattern.Solid,
            textString="Inputs")}));
  end HeatingCircuit;




  model HT_simple
   replaceable package Water = AixLib.Media.Water annotation (Dialog(group="Medium"));

    Modelica.Fluid.Pipes.StaticPipe pipe(
      length=1,
      diameter=0.025,
      redeclare package Medium = Water) "Pressure drop"
      annotation (Placement(transformation(extent={{95,-69},{89,-65}})));
    AixLib.Fluid.BoilerCHP.Boiler boiler(
      redeclare package Medium = Water,
      m_flow_nominal=0.03,
      declination=1.2,
      FA=0,
      riseTime=0,
      TN=0.05,
      paramBoiler=AixLib.DataBase.Boiler.General.Boiler_Vitogas200F_60kW(),
      paramHC(varFlowTempDay=[1,1.5,2; -20,80,80; 40,80,80], varFlowTempNight=[1,
            1.5,2; -20,80,80; 40,80,80])) "Boiler"
      annotation (Placement(transformation(extent={{-17,-11},{3,9}})));
    Modelica.Blocks.Sources.BooleanConstant isNight(k=false) "No night-setback"
      annotation (Placement(transformation(extent={{-49,11},{-45,15}})));

    Modelica.Blocks.Interfaces.RealInput TAmbient(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") annotation (Placement(transformation(rotation=0, extent={{-94.5,
              7.5},{-103.5,10.5}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare final package Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={{96.5,
              -4.5},{105.5,-1.5}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Water)
      annotation (Placement(transformation(rotation=0, extent={{96.5,-64.5},{
              105.5,-61.5}})));
    Modelica.Blocks.Sources.Constant const1(k=0.001)
      annotation (Placement(transformation(extent={{-10,-60},{-16,-54}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{-38,-54},{-48,-44}})));
    Modelica.Blocks.Interfaces.RealInput TFlowNT(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") annotation (Placement(transformation(rotation=0, extent={{-94.5,
              27.5},{-103.5,30.5}})));
    Modelica.Blocks.Sources.Constant T_set_NTflow(k=273.15 + 33)
      annotation (Placement(transformation(extent={{-58,48},{-52,54}})));
    AixLib.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Water)
      annotation (Placement(transformation(extent={{-66,-10},{-60,-2}})));
    Modelica.Blocks.Interfaces.BooleanInput WT03Requirement
      annotation (Placement(transformation(extent={{-110,-82},{-92,-64}})));
    Modelica.Blocks.Continuous.LimPID PID1(Ti=32, Td=365,
      yMax=0.999,
      yMin=0.001)
      annotation (Placement(transformation(extent={{32,34},{52,54}})));
    AixLib.Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium = Water,
      m_flow_nominal=12,
      dpValve_nominal=5800)
      annotation (Placement(transformation(extent={{68,4},{78,14}})));
    AixLib.Fluid.Sources.Boundary_pT expansionVessel1(
      redeclare package Medium = Water,
      p=200000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=270,
          origin={64,-54})));
  AixLib.Obsolete.Year2021.Fluid.Movers.Pump pump(
    V_flow(fixed=false),
    ControlStrategy=2,
    redeclare package Medium = Water,
    m_flow_small=1e-4,
    V_flow_max=9.36,
    MinMaxCharacteristics=
        AixLib.DataBase.Pumps.MinMaxCharacteristicsBaseDataDefinition(
        minMaxHead=[0,3,10; 5,3,10]))
    annotation (Placement(transformation(extent={{18,-70},{4,-56}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{6,-52},{10,-48}})));
  equation
    connect(TAmbient, boiler.TAmbient) annotation (Line(points={{-99,9},{-28,9},{
            -28,6},{-14,6}},                    color={0,0,127}));
    connect(port_a, pipe.port_a)
      annotation (Line(points={{101,-63},{101,-67},{95,-67}},
                                                       color={0,127,255}));
    connect(const1.y, switch1.u3) annotation (Line(points={{-16.3,-57},{-16.3,-53},
            {-37,-53}},           color={0,0,127}));
    connect(WT03Requirement, switch1.u2) annotation (Line(points={{-101,-73},{-101,
            -74},{-8,-74},{-2,-74},{-2,-50},{-34,-50},{-34,-49},{-37,-49}},
          color={255,0,255}));
    connect(T_set_NTflow.y, PID1.u_s) annotation (Line(points={{-51.7,51},{-6.85,
            51},{-6.85,44},{30,44}}, color={0,0,127}));
    connect(TFlowNT, PID1.u_m) annotation (Line(points={{-99,29},{-22.5,29},{
            -22.5,32},{42,32}}, color={0,0,127}));
    connect(PID1.y, switch1.u1) annotation (Line(points={{53,44},{82,44},{82,-45},
            {-37,-45}}, color={0,0,127}));
    connect(switch1.y, val.y) annotation (Line(points={{-48.5,-49},{-86,-49},{-86,
            20},{74,20},{74,15},{73,15}},
                          color={0,0,127}));
    connect(WT03Requirement, boiler.isOn) annotation (Line(points={{-101,-73},{-1.5,
            -73},{-1.5,-10},{-2,-10}}, color={255,0,255}));
    connect(not1.y, pump.IsNight) annotation (Line(points={{10.2,-50},{11,-50},{11,
            -55.86}}, color={255,0,255}));
    connect(WT03Requirement, not1.u) annotation (Line(points={{-101,-73},{-1.5,-73},
            {-1.5,-50},{5.6,-50}}, color={255,0,255}));
    connect(isNight.y, boiler.switchToNightMode) annotation (Line(points={{-44.8,13},
            {-17.4,13},{-17.4,3},{-14,3}}, color={255,0,255}));
    connect(senMasFlo.port_b, boiler.port_a) annotation (Line(points={{-60,-6},{-38,
            -6},{-38,-1},{-17,-1}}, color={0,127,255}));
    connect(pump.port_b, senMasFlo.port_a) annotation (Line(points={{4,-63},{-74,-63},
            {-74,-6},{-66,-6}}, color={0,127,255}));
    connect(pipe.port_b, pump.port_a) annotation (Line(points={{89,-67},{53.5,-67},
            {53.5,-63},{18,-63}}, color={0,127,255}));
    connect(expansionVessel1.ports[1], pump.port_a)
      annotation (Line(points={{64,-62},{18,-62},{18,-63}}, color={0,127,255}));
    connect(boiler.port_b, val.port_a) annotation (Line(points={{3,-1},{35.5,-1},{
            35.5,9},{68,9}}, color={0,127,255}));
    connect(val.port_b, port_b) annotation (Line(points={{78,9},{90,9},{90,-3},
            {101,-3}}, color={0,127,255}));
    annotation (Diagram(coordinateSystem(extent={{-100,-80},{100,60}},
            preserveAspectRatio=false)), Icon(coordinateSystem(extent={{-100,-80},
              {100,60}}), graphics={
                                Rectangle(
            extent={{-80,60},{80,-80}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={170,170,255}),
          Polygon(
            points={{-12.5,-35.5},{-20.5,-19.5},{1.5,24.5},{9.5,-1.5},{31.5,2.5},
                {21.5,-39.5},{3.5,-35.5},{-2.5,-35.5},{-12.5,-35.5}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={255,127,0}),
          Polygon(
            points={{-10.5,-33.5},{-0.5,-13.5},{25.5,-33.5},{-0.5,-33.5},{-10.5,
                -33.5}},
            lineColor={255,255,170},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-20.5,-33.5},{33.5,-41.5}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192})}),
            Documentation(info="<html>
          <p>
          Simplified model of the high temperatur range of the imaged Building Energy System.
          </p>
          </html>"));
  end HT_simple;

  model FVU

    AixLib.Fluid.Movers.FlowControlled_dp pumpFVU_cooler(
      redeclare package Medium = Water,
      nominalValuesDefineDefaultPressureCurve=true,
      m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{88,-76},{72,-60}})));
    Modelica.Blocks.Sources.RealExpression Delta_P_Cooler(y=100000)
      annotation (Placement(transformation(extent={{22,-57},{42,-37}})));
    AixLib.Fluid.Movers.FlowControlled_dp pumpFVU_heater(
      redeclare package Medium = Water,
      nominalValuesDefineDefaultPressureCurve=true,
      m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{-86,-82},{-70,-66}})));
    Modelica.Blocks.Sources.RealExpression Delta_P_Heater(y=100000)
      annotation (Placement(transformation(extent={{4,-57},{-16,-37}})));
    Control.FVUController fVUController
      annotation (Placement(transformation(extent={{-82,-134},{-42,-94}})));
    BaseClasses.FVU fVU(redeclare package Air = Air, redeclare package Water =
          Water)
      annotation (Placement(transformation(extent={{-16,-172},{50,-140}})));
    AixLib.Fluid.Sources.Boundary_pT sink_ExhaustAir(
      redeclare package Medium = Air,
      T=T_start,
      nPorts=1)
      annotation (Placement(transformation(extent={{-70,-160},{-50,-140}})));
    AixLib.Fluid.Sources.Boundary_pT source_FreshAir(
      redeclare package Medium = Air,
      T=T_start,
      use_T_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-68,-190},{-48,-170}})));
    AixLib.Fluid.Sources.Boundary_pT sink_Room(
      redeclare package Medium = Air,
      use_T_in=false,
      T=T_start,
      nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={88,-152})));
    AixLib.Fluid.Sources.Boundary_pT source_Room(
      redeclare package Medium = Air,
      use_T_in=true,
      nPorts=1) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={88,-184})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
      prescribedTemperature2 annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={13,-207})));
    AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance8(
      redeclare package Medium = Water,
      m_flow_nominal=0.1,
      dp_nominal=10000)
              annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=180,
          origin={56,-68})));
    AixLib.Fluid.FixedResistances.PressureDrop        hydraulicResistance9(
      redeclare package Medium = Water,
      m_flow_nominal=0.1,
      dp_nominal=10000)
              annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=0,
          origin={-48,-74})));
    Control.ValveController valveController
      annotation (Placement(transformation(extent={{-90,-54},{-110,-34}})));
    AixLib.Fluid.Actuators.Valves.TwoWayQuickOpening regulationValve(
      redeclare package Medium = Water,
      m_flow_nominal=0.001,
      dpValve_nominal=100000) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={-10,-80})));
    Modelica.Blocks.Sources.RealExpression regulation(y=0.0001)
      annotation (Placement(transformation(extent={{24,-90},{4,-70}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort Temp_FVU_flow(redeclare package
        Medium = Water) annotation (Placement(transformation(
          extent={{5,4},{-5,-4}},
          rotation=180,
          origin={-99,-74})));
    Modelica.Blocks.Sources.CombiTimeTable Troom(
      smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
      columns={2},
      tableName="Toutdoor",
      fileName="T:/fst/Modelica/Dymola/outdoor.mat",
      tableOnFile=false,
      table=[0,273.15; 31536000,273.15])
      annotation (Placement(transformation(extent={{146,-198},{126,-178}})));
    replaceable package Water = AixLib.Media.Water annotation (Dialog(group="Medium"));

    replaceable package Air = Modelica.Media.Air.DryAirNasa annotation (Dialog(group="Medium"));
    parameter Modelica.SIunits.ThermodynamicTemperature T_start=293.15;
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={
              {-154.5,-90},{-125.5,-70}})));
    Modelica.Fluid.Interfaces.FluidPort_b Cooler_Return(redeclare package
        Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={{135.5,
              -110},{164.5,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b Heater_Return(redeclare package
        Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={{-154.5,
              -130},{-125.5,-110}})));
    Modelica.Blocks.Interfaces.RealInput co2Concentration annotation (Placement(
          transformation(rotation=0, extent={{-154.5,-170},{-125.5,-150}})));
    Modelica.Blocks.Interfaces.RealInput outdoorTemperature annotation (Placement(
          transformation(rotation=0, extent={{-125.5,-230},{-96.5,-210}}),
          iconTransformation(
          extent={{-14.5,-10},{14.5,10}},
          rotation=90,
          origin={-111,-220})));
    Modelica.Blocks.Interfaces.RealInput roomSetTemperature annotation (Placement(
          transformation(rotation=0, extent={{-154.5,-210},{-125.5,-190}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare final package
        Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={{135.5,
              -70},{164.5,-50}})));
    AixLib.Fluid.Actuators.Valves.ThreeWayLinear Valve_FVU_Hot(
      redeclare package Medium = Water,
      m_flow_nominal=0.1,
      dpValve_nominal=1000,
      portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Entering,
      portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Entering)
      annotation (Placement(transformation(extent={{-124,-82},{-108,-66}})));
  equation
    connect(fVUController.coolingValveOpening,fVU. coolingValveOpening)
      annotation (Line(points={{-42,-96},{46,-96},{46,-140},{46.37,-140}},
          color={0,0,127}));
    connect(fVUController.heatingValveOpening,fVU. heatingValveOpening)
      annotation (Line(points={{-42,-102},{36.8,-102},{36.8,-140}}, color={0,0,127}));
    connect(fVUController.exhaustFanPower,fVU. InputSignal_Fan_ExhaustAir)
      annotation (Line(points={{-42,-108},{-24,-108},{-6,-108},{-6,-140.48},{-6.925,
            -140.48}},
          color={0,0,127}));
    connect(fVUController.supplyFanPower,fVU. InputSignal_Fan_SupplyAir)
      annotation (Line(points={{-42,-114},{-9,-114},{27,-114},{27,-130},{27.23,-130},
            {27.23,-140.64}},
                       color={0,0,127}));
    connect(fVUController.HRCFlapOpening,fVU. InputSignal_HeatRecoveryFlap)
      annotation (Line(points={{-42,-126},{-30,-126},{-10,-126},{-10,-132},{1.325,
            -132},{1.325,-140.48}},        color={0,0,127}));
    connect(sink_ExhaustAir.ports[1],fVU. exhaustAir) annotation (Line(points={{-50,
            -150},{-16,-150},{-16,-151.84}}, color={0,127,255}));
    connect(source_FreshAir.ports[1],fVU. freshAir) annotation (Line(points={{-48,
            -180},{-34,-180},{-34,-168.8},{-16,-168.8}}, color={0,127,255}));
    connect(fVU.SupplyAir,sink_Room. ports[1]) annotation (Line(points={{50.33,-151.84},
            {78,-151.84},{78,-152}}, color={0,127,255}));
    connect(source_Room.ports[1],fVU. ExhaustAir) annotation (Line(points={{78,-184},
            {70,-184},{70,-166.88},{50.33,-166.88}}, color={0,127,255}));
    connect(fVU.port_a1,prescribedTemperature2. port) annotation (Line(points={{-3.79,
            -172.64},{-3.79,-207},{6,-207}}, color={191,0,0}));
    connect(pumpFVU_cooler.port_b,hydraulicResistance8. port_a)
      annotation (Line(points={{72,-68},{65.6,-68},{62,-68}}, color={0,0,127}));
    connect(hydraulicResistance8.port_b,fVU. Cooler_Flow) annotation (Line(points=
           {{50,-68},{49.67,-68},{49.67,-140}}, color={0,127,255}));
    connect(pumpFVU_heater.port_b,hydraulicResistance9. port_a)
      annotation (Line(points={{-70,-74},{-54,-74}}, color={0,127,255}));
    connect(fVUController.freshAirFlapOpening,fVU. InputSignal_FreshAirFlap)
      annotation (Line(points={{-42,-132},{-18,-132},{10,-132},{10,-136},{9.575,-136},
            {9.575,-140.48}}, color={0,0,127}));
    connect(fVUController.circulationFlapOpening,fVU. InputSignal_CircularAir)
      annotation (Line(points={{-42,-120},{-18,-120},{18,-120},{18,-130},{18.155,-130},
            {18.155,-140.48}}, color={0,0,127}));
    connect(hydraulicResistance9.port_b,regulationValve. port_a)
      annotation (Line(points={{-42,-74},{-10,-74}}, color={0,127,255}));
    connect(regulationValve.port_a,fVU. Heater_Flow) annotation (Line(points={{
            -10,-74},{38,-74},{38,-98},{38,-140},{40.43,-140}}, color={0,127,255}));
    connect(regulationValve.y,regulation. y)
      annotation (Line(points={{-2.8,-80},{0,-80},{3,-80}}, color={0,0,127}));
    connect(Delta_P_Heater.y,pumpFVU_heater. dp_in) annotation (Line(points={{-17,-47},
            {-46.5,-47},{-46.5,-64.4},{-78,-64.4}},         color={0,0,127}));
    connect(Delta_P_Cooler.y,pumpFVU_cooler. dp_in) annotation (Line(points={{43,-47},
            {61.5,-47},{61.5,-58.4},{80,-58.4}},    color={0,0,127}));
    connect(pumpFVU_heater.port_a,Temp_FVU_flow. port_b) annotation (Line(points={{-86,-74},
            {-94,-74}},                      color={0,127,255}));
    connect(Temp_FVU_flow.T,valveController. u_m1) annotation (Line(points={{-99,
            -69.6},{-98.5,-69.6},{-98.5,-54},{-100,-54}},   color={0,0,127}));
    connect(source_Room.T_in, Troom.y[1])
      annotation (Line(points={{100,-188},{125,-188}}, color={0,0,127}));
    connect(Troom.y[1], prescribedTemperature2.T) annotation (Line(points={{125,
            -188},{112,-188},{112,-206},{66,-206},{66,-207},{21.4,-207}}, color={
            0,0,127}));
    connect(Troom.y[1], fVUController.roomTemperature) annotation (Line(points={{
            125,-188},{112,-188},{112,-92},{-90,-92},{-90,-96},{-82,-96}}, color=
            {0,0,127}));
    connect(Cooler_Return, fVU.Cooler_Return) annotation (Line(points={{150,-100},
            {42,-100},{42,-120},{42,-140},{42.74,-140}}, color={0,127,255}));
    connect(Heater_Return, fVU.Heater_Return) annotation (Line(points={{-140,-120},
            {32.18,-120},{32.18,-140}}, color={0,127,255}));
    connect(co2Concentration, fVUController.co2Concentration) annotation (Line(
          points={{-140,-160},{-112,-160},{-112,-132},{-82,-132}}, color={0,0,127}));
    connect(outdoorTemperature, fVUController.outdoorTemperature) annotation (
        Line(points={{-111,-220},{-111,-108},{-82,-108}}, color={0,0,127}));
    connect(roomSetTemperature, fVUController.roomSetTemperature) annotation (
        Line(points={{-140,-200},{-112,-200},{-112,-120},{-82,-120}}, color={0,0,
            127}));
    connect(port_a1, pumpFVU_cooler.port_a) annotation (Line(points={{150,-60},{
            120,-60},{120,-68},{88,-68}}, color={0,127,255}));
    connect(Heater_Return, regulationValve.port_b) annotation (Line(points={{-140,
            -120},{-10,-120},{-10,-86}}, color={0,127,255}));
    connect(port_a, Valve_FVU_Hot.port_1) annotation (Line(points={{-140,-80},{
            -130,-80},{-130,-74},{-124,-74}}, color={0,127,255}));
    connect(Temp_FVU_flow.port_a, Valve_FVU_Hot.port_2)
      annotation (Line(points={{-104,-74},{-108,-74}}, color={0,127,255}));
    connect(valveController.y1, Valve_FVU_Hot.y) annotation (Line(points={{-110,
            -44},{-114,-44},{-114,-64.4},{-116,-64.4}}, color={0,0,127}));
    connect(Valve_FVU_Hot.port_3, Heater_Return) annotation (Line(points={{-116,
            -82},{-126,-82},{-126,-120},{-140,-120}}, color={0,127,255}));
    connect(outdoorTemperature, source_FreshAir.T_in) annotation (Line(points={{
            -111,-220},{-111,-198},{-70,-198},{-70,-176}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(extent={{-140,-220},{150,-20}},
            preserveAspectRatio=false)),                                   Icon(
          coordinateSystem(extent={{-140,-220},{150,-20}}, preserveAspectRatio=
              false), graphics={
          Rectangle(extent={{-140,-24},{-140,-26}}, lineColor={28,108,200}),
          Rectangle(
            extent={{-140,-20},{150,-220}},
            lineColor={28,108,200},
            fillPattern=FillPattern.Solid,
            fillColor={0,0,255}),
          Ellipse(
            extent={{-68,-56},{74,-182}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255}),
                                  Text(
            extent={{-100,-88},{110,-150}},
            lineColor={28,108,200},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="FVU",
            textStyle={TextStyle.Bold},
            lineThickness=0.5)}),
            Documentation(info="<html> Model of a facade ventilation unit. The exemplary fvu is controlled based on roomtemperature, outsidetemperatur and CO2-concentration.
             Fresh and room air are simplified modeled as Volumes. The heatransfer is realized using a heatexchanger from the Buildings library. </html>"));
  end FVU;

  model Heatpump
    import AixLib;
    parameter Real Vol(start=0.01) "Size of the compensation Volumes";
    import HVAC;
    import DataBase;
    ExergyBasedControl.Components.HeatPump.BaseClasses.HeatPump heatPump(
      Cap_calc_type=2,
      redeclare package Medium_Co = Water,
      redeclare package Medium_Ev = Water,
      data_table=AixLib.DataBase.HeatPump.EN14511.StiebelEltron_WPL18(),
      delay_Qdot_Co=true,
      PT1_cycle_Co=true,
      PT1_cycle_Pel=true,
      volume_Ev=0.2041,
      volume_Co=0.2499,
      T_hp_cycle_Co=96.84,
      T_hp_cycle_Pel=66.99,
      delayTime=10.79,
      Pel_ouput=true,
      CoP_output=true,
      T_start_Ev=280.15,
      T_start_Co=313.15)
      annotation (Placement(transformation(extent={{202,36},{170,56}})));
    HVAC.Components.BufferStorage.BufferStorageHeatingcoils heatStorage(
      redeclare package Medium = Water,
      redeclare package MediumHC1 = Water,
      redeclare package MediumHC2 = Water,
      use_heatingCoil1=false,
      use_heatingCoil2=false,
      use_heatingRod=false,
      data=DataBase.BufferStorage.Generic_New_4000l(
          h_Tank=2.264,
          h_lower_ports=0.382,
          h_upper_ports=1.882,
          d_Tank=1.500,
          h_TS1=0.307,
          h_TS2=1.957),
      redeclare model HeatTransfer =
        HVAC.Components.BufferStorage.BaseClasses.HeatTransfer_buoyancy_Wetter,
      n=4) annotation (Placement(transformation(extent={{90,26},{62,62}})));

    HVAC.Components.BufferStorage.BufferStorageHeatingcoils coldStorage(
      redeclare package Medium = Water,
      redeclare package MediumHC1 = Water,
      redeclare package MediumHC2 = Water,
      use_heatingCoil1=false,
      use_heatingCoil2=false,
      use_heatingRod=false,
      data=DataBase.BufferStorage.Generic_New_5000l(
          h_Tank=2.830,
          h_lower_ports=0.365,
          h_upper_ports=2.465,
          d_Tank=1.500,
          h_TS1=0.290,
          h_TS2=2.540),
      redeclare model HeatTransfer =
          HVAC.Components.BufferStorage.BaseClasses.HeatTransfer_OnlyConduction,
      n=4) annotation (Placement(transformation(extent={{290,28},{262,64}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature airTemperature(T=
          298.15)
      annotation (Placement(transformation(extent={{46,42},{54,50}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature airTemperature1(T=
          298.15) annotation (Placement(transformation(extent={{246,42},{254,50}})));
    AixLib.Fluid.Actuators.Valves.ThreeWayLinear Valve_GC(
      redeclare package Medium = Water,
      m_flow_nominal=16,
      dpValve_nominal=5800,
      portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Leaving,
      portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Entering)
      annotation (Placement(transformation(extent={{98,100},{114,84}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow pumpHeatPump_Cold(
      redeclare package Medium = Water,
      m_flow_nominal=10.44,
      nominalValuesDefineDefaultPressureCurve=true)
      annotation (Placement(transformation(extent={{254,68},{238,84}})));
    AixLib.Fluid.Movers.FlowControlled_m_flow pumpHeatPump_Hot(
      redeclare package Medium = Water,
      m_flow_nominal=15.67,
      nominalValuesDefineDefaultPressureCurve=true)
      annotation (Placement(transformation(extent={{146,24},{162,8}})));
    Modelica.Fluid.Vessels.ClosedVolume volHPHotIn(
      redeclare package Medium = Water,
      use_portsData=false,
      nPorts=3,
      V=Vol) annotation (Placement(transformation(extent={{128,6},{140,-6}})));
    Modelica.Fluid.Vessels.ClosedVolume volHPColdIn(
      redeclare package Medium = Water,
      use_portsData=false,
      nPorts=2,
      V=Vol) annotation (Placement(transformation(extent={{210,72},{222,60}})));
    Modelica.Fluid.Vessels.ClosedVolume volHPColdOut(
      redeclare package Medium = Water,
      use_portsData=false,
      nPorts=2,
      V=Vol) annotation (Placement(transformation(extent={{238,-2},{250,10}})));
    Modelica.Blocks.Sources.RealExpression heatStorageTemperatures[heatStorage.n](
       y=heatStorage.layer[:].heatPort.T)
      annotation (Placement(transformation(extent={{-90,16},{-110,36}})));
    Modelica.Blocks.Sources.RealExpression coldStorageTemperatures[coldStorage.n](
       y=coldStorage.layer[:].heatPort.T) annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={250,138})));
    Modelica.Fluid.Sensors.TemperatureTwoPort TempGCreturn(redeclare package
        Medium = Water) annotation (Placement(transformation(
          extent={{5,4},{-5,-4}},
          rotation=180,
          origin={35,134})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate(redeclare package Medium =
          Water) annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={106,120})));
    Modelica.Fluid.Sensors.MassFlowRate massFlowRate1(redeclare package Medium =
          Water) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={132,92})));
    Modelica.Fluid.Sensors.TemperatureTwoPort TFlowHS(redeclare package Medium =
          Water) annotation (Placement(transformation(
          extent={{-3,3},{3,-3}},
          rotation=180,
          origin={33,63})));
    replaceable package Water = AixLib.Media.Water annotation (Dialog(group="Medium"));

    Modelica.Fluid.Interfaces.FluidPort_b fluidportTop_Hot( redeclare package
        Medium = Water) annotation (Placement(transformation(rotation=0, extent={{
              -45.5,-40},{-16.5,-20}})));
    Modelica.Fluid.Interfaces.FluidPort_a fluidportGC_return(redeclare package
        Medium = Water) annotation (Placement(transformation(rotation=0, extent={{
              -155.5,158},{-126.5,178}}), iconTransformation(extent={{-155.5,158},
              {-126.5,178}})));
    Modelica.Blocks.Interfaces.RealInput openingReCoolingValve annotation (
        Placement(transformation(rotation=0, extent={{-200.5,114},{-171.5,134}}),
          iconTransformation(extent={{-200.5,114},{-171.5,134}})));
    Modelica.Fluid.Interfaces.FluidPort_b fluidportBottom_Cold(redeclare final
      package   Medium = Water) annotation (Placement(transformation(rotation=0,
            extent={{281.5,-4},{310.5,16}})));
    Modelica.Fluid.Interfaces.FluidPort_a fluidportTop_Cold(redeclare final
      package   Medium = Water) annotation (Placement(transformation(rotation=0,
            extent={{289.5,74},{318.5,94}}), iconTransformation(extent={{289.5,74},
              {318.5,94}})));
    Modelica.Blocks.Interfaces.RealOutput temperatureColdStorage[4] annotation (
        Placement(transformation(rotation=0, extent={{192.5,156},{221.5,176}}),
          iconTransformation(extent={{192.5,156},{221.5,176}})));
    Modelica.Blocks.Interfaces.BooleanInput OnOffHP annotation (Placement(
          transformation(rotation=270,
                                     extent={{-14.5,-10},{14.5,10}},
          origin={87,180}),
          iconTransformation(extent={{72.5,158},{101.5,178}})));
    Modelica.Blocks.Interfaces.BooleanInput modeHP annotation (Placement(
          transformation(rotation=270,
                                     extent={{-14.5,-10},{14.5,10}},
          origin={11,180}),
          iconTransformation(extent={{-3.5,158},{25.5,178}})));
    Modelica.Blocks.Interfaces.RealOutput heatStorageTemperature[4] annotation (
        Placement(transformation(rotation=0, extent={{-184.5,16},{-155.5,36}}),
          iconTransformation(extent={{-184.5,16},{-155.5,36}})));
    Modelica.Fluid.Interfaces.FluidPort_b fluidportGC_flow(redeclare package
        Medium = Water) annotation (Placement(transformation(rotation=0, extent={{
              -94.5,158},{-65.5,178}}), iconTransformation(extent={{-94.5,158},{-65.5,
              178}})));
    Modelica.Blocks.Interfaces.RealInput mflowHPCold(final unit="kg/s", nominal=
          pumpHeatPump_Cold.m_flow_nominal) annotation (Placement(transformation(
            rotation=0, extent={{252.5,156},{281.5,176}})));
    Modelica.Blocks.Interfaces.RealInput mflowHPHot(final unit="kg/s", nominal=
          pumpHeatPump_Hot.m_flow_nominal) annotation (Placement(transformation(
          rotation=-90,
          extent={{-14.5,-10},{14.5,10}},
          origin={155,-20}), iconTransformation(
          extent={{-14.5,-10},{14.5,10}},
          rotation=-90,
          origin={152,-32})));
    Modelica.Fluid.Interfaces.FluidPort_a fluidportBottom_Hot(redeclare package
        Medium = Water) annotation (Placement(transformation(rotation=0, extent={{
              18.5,-40},{47.5,-20}})));
    Modelica.Blocks.Interfaces.RealOutput mFlowRecooler annotation (Placement(
          transformation(rotation=0, extent={{-188.5,66},{-159.5,86}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=heatPump.T_Ev_out.T)
      annotation (Placement(transformation(extent={{-88,-34},{-108,-14}})));
    Modelica.Blocks.Interfaces.RealOutput evapTemp annotation (Placement(
          transformation(rotation=0, extent={{-182.5,-34},{-153.5,-14}})));
    Modelica.Blocks.Interfaces.RealOutput massFlowHStotal(final unit="kg/s") annotation (Placement(
          transformation(extent={{140,160},{160,180}}), iconTransformation(extent=
             {{140,160},{160,180}})));
    Modelica.Fluid.Vessels.ClosedVolume voHPHotOut(
      redeclare package Medium = Water,
      use_portsData=false,
      nPorts=2,
      V=Vol) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={174,84})));
    Control.HeatPumpController heatPumpController
      annotation (Placement(transformation(extent={{58,90},{82,114}})));
    Modelica.Blocks.Interfaces.BooleanOutput onOff1
      "On/Off command to the heat pump, 'false'=off" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-190,52})));
  equation
    connect(pumpHeatPump_Hot.port_a, volHPHotIn.ports[1]) annotation (Line(points=
           {{146,16},{132.4,16},{132.4,6}}, color={0,127,255}));
    connect(heatPump.port_Co_in,pumpHeatPump_Hot. port_b) annotation (Line(points={{169.787,
            39},{166,39},{166,16},{162,16}},         color={0,127,255}));
    connect(coldStorage.heatport_outside,airTemperature1. port) annotation (Line(
          points={{262.35,47.08},{258,47.08},{258,46},{254,46}},
                                                             color={191,0,0}));
    connect(heatPump.port_Ev_in, volHPColdIn.ports[1]) annotation (Line(points={{202.213,
            53},{206,53},{206,76},{214.8,76},{214.8,72}}, color={0,127,255}));
    connect(heatPump.port_Ev_out, volHPColdOut.ports[1]) annotation (Line(points={
            {202,39},{206,39},{206,-2},{242.8,-2}}, color={0,127,255}));
    connect(coldStorage.fluidport_bottom2, volHPColdOut.ports[2]) annotation (
        Line(points={{271.975,27.82},{271.975,-4},{245.2,-4},{245.2,-2}}, color={0,
            127,255}));
    connect(coldStorage.fluidport_top2,pumpHeatPump_Cold. port_a) annotation (
        Line(points={{271.625,64.18},{271.625,76},{254,76}},
                                                          color={0,127,255}));
    connect(pumpHeatPump_Cold.port_b, volHPColdIn.ports[2]) annotation (Line(
          points={{238,76},{217.2,76},{217.2,72}}, color={0,127,255}));
    connect(airTemperature.port,heatStorage. heatport_outside) annotation (Line(
          points={{54,46},{58,46},{58,45.08},{62.35,45.08}},         color={191,0,
            0}));
    connect(volHPHotIn.ports[2], TempGCreturn.port_b) annotation (Line(points={{134,
            6},{134,8},{136,8},{144,8},{144,134},{40,134}}, color={0,127,255}));
    connect(Valve_GC.port_3,massFlowRate. port_a)
      annotation (Line(points={{106,100},{106,106},{106,110}},
                                                   color={0,127,255}));
    connect(massFlowRate1.port_b,Valve_GC. port_2)
      annotation (Line(points={{122,92},{118,92},{114,92}}, color={0,127,255}));
    connect(fluidportTop_Hot, TFlowHS.port_b) annotation (Line(points={{-31,-30},{
            -31,18},{-32,18},{-32,64},{30,64},{30,63}}, color={0,127,255}));
    connect(fluidportGC_return, TempGCreturn.port_a) annotation (Line(points={{-141,
            168},{-141,136},{14,136},{14,134},{28,134},{30,134}}, color={0,127,255}));
    connect(fluidportBottom_Cold, coldStorage.fluidport_bottom1) annotation (Line(
          points={{296,6},{280.725,6},{280.725,27.64}}, color={0,127,255}));
    connect(fluidportTop_Cold, coldStorage.fluidport_top1) annotation (Line(
          points={{304,84},{280.9,84},{280.9,64.18}}, color={0,127,255}));
    connect(temperatureColdStorage, coldStorageTemperatures.y) annotation (Line(
          points={{207,166},{207,138},{236,138},{240,138},{240,138},{239,138}},
                                                     color={0,0,127}));
    connect(fluidportGC_flow, massFlowRate.port_b) annotation (Line(points={{-80,168},
            {-80,152},{106,152},{106,130}}, color={0,127,255}));
    connect(mflowHPCold, pumpHeatPump_Cold.m_flow_in) annotation (Line(points={{267,166},
            {267,114},{246,114},{246,85.6}},            color={0,0,127}));
    connect(mflowHPHot, pumpHeatPump_Hot.m_flow_in) annotation (Line(points={{155,-20},
            {155,6},{154,6},{154,6},{154,6.4}},                color={0,0,127}));
    connect(fluidportBottom_Hot, fluidportBottom_Hot)
      annotation (Line(points={{33,-30},{33,-30}}, color={0,127,255}));
    connect(openingReCoolingValve, Valve_GC.y) annotation (Line(points={{-186,124},
            {-18,124},{-18,82.4},{106,82.4}},   color={0,0,127}));
    connect(massFlowRate.m_flow, mFlowRecooler) annotation (Line(points={{95,120},
            {52,120},{52,76},{-174,76}},       color={0,0,127}));
    connect(heatStorageTemperature, heatStorageTemperatures.y)
      annotation (Line(points={{-170,26},{-116,26},{-111,26}},
                                                     color={0,0,127}));
    connect(evapTemp, realExpression.y) annotation (Line(points={{-168,-24},{-138,
            -24},{-109,-24}}, color={0,0,127}));
    connect(massFlowRate1.m_flow, massFlowHStotal) annotation (Line(points={{132,103},
            {138,103},{138,170},{150,170}}, color={0,0,127}));
    connect(heatStorage.fluidport_bottom2, fluidportBottom_Hot) annotation (Line(
          points={{71.975,25.82},{71.975,-4.09},{33,-4.09},{33,-30}}, color={0,127,
            255}));
    connect(heatStorage.fluidport_top2, TFlowHS.port_a) annotation (Line(points={{
            71.625,62.18},{53.8125,62.18},{53.8125,63},{36,63}}, color={0,127,255}));
    connect(heatStorage.fluidport_bottom1, volHPHotIn.ports[3]) annotation (Line(
          points={{80.725,25.64},{107.363,25.64},{107.363,6},{135.6,6}}, color={0,
            127,255}));
    connect(heatStorage.fluidport_top1, Valve_GC.port_1) annotation (Line(points={
            {80.9,62.18},{80.9,77.09},{98,77.09},{98,92}}, color={0,127,255}));
    connect(heatPump.port_Co_out, voHPHotOut.ports[1]) annotation (Line(points={{170,
            53},{156,53},{156,86},{164,86}}, color={0,127,255}));
    connect(massFlowRate1.port_a, voHPHotOut.ports[2]) annotation (Line(points={{142,
            92},{154,92},{154,82},{164,82}}, color={0,127,255}));
    connect(heatPumpController.mode, modeHP) annotation (Line(points={{70,114},
            {70,114},{70,142},{11,142},{11,180}}, color={255,0,255}));
    connect(OnOffHP, heatPumpController.clearance) annotation (Line(points={{87,
            180},{87,142},{75.25,142},{75.25,114}}, color={255,0,255}));
    connect(heatPumpController.onOff, heatPump.OnOff_in) annotation (Line(
          points={{69.9625,89.94},{69.9625,70},{191.333,70},{191.333,55}},
          color={255,0,255}));
    connect(heatPump.mode_in, modeHP) annotation (Line(points={{194.533,55},{
            194.533,148},{70,148},{70,142},{11,142},{11,180}}, color={255,0,255}));
    connect(heatPump.condenserTemperature, heatPumpController.condenserTemperature)
      annotation (Line(points={{168.933,37},{112,37},{112,68},{46,68},{46,102},
            {58,102}}, color={0,0,127}));
    connect(heatPump.evaporatorTemperature, heatPumpController.evaporatorTemperature)
      annotation (Line(points={{203.067,36.8},{224,36.8},{224,102},{82,102}},
          color={0,0,127}));
    connect(heatPumpController.onOff, onOff1) annotation (Line(points={{69.9625,
            89.94},{69.9625,72},{-148,72},{-148,52},{-190,52}}, color={255,0,
            255}));
    annotation (Diagram(coordinateSystem(extent={{-180,-30},{300,180}},
            preserveAspectRatio=false)), Icon(coordinateSystem(extent={{-180,-30},
              {300,180}}, preserveAspectRatio=false),
                           graphics={                                                                                Rectangle(extent={{
                -28,150},{172,-14}},                                                                                                   lineColor = {0, 0, 255}, fillColor = {249, 249, 249},
              fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
                170,150},{288,-14}},                                                                                                 lineColor = {0, 0, 255}, fillColor = {170, 213, 255},
              fillPattern =                                                                                                   FillPattern.Solid), Rectangle(extent={{
                -146,150},{-26,-14}},                                                                                                    lineColor = {0, 0, 255}, fillColor = {255, 170, 213},
              fillPattern =                                                                                                   FillPattern.Solid), Text(extent={{
                -26,92},{172,52}},                                                                                                    lineColor=
                {0,0,255},
            textString="Heatpump
Cycle")}),  Documentation(info="<html>
          <p> 
          This subsystem contains the model of a heatpumpsystems consisting of an electrical heatpump, a hot storage and a cold storage. 
          The heatpump can be used to load the satisfy heating or cooling demand. Using a three-way valve the hotside of the heatpump can 
          be recooled if it is getting to hot in the cooling mode.
          </p>
        
 
          </html>"));
  end Heatpump;

  model GlycolCooler

    //Parameter

   replaceable package Water = AixLib.Media.Water;

   //Inputs

     Modelica.Blocks.Tables.CombiTable1D Valve_GC_CharacteristicCurve(
      tableOnFile=true,
      tableName="valve",
      fileName="T:/fst/Modelica/Valve_GC.txt") annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=0,
          origin={-79,-13})));
      Modelica.Blocks.Interfaces.RealInput massFlowGC annotation (Placement(
          transformation(
          rotation=0,
          extent={{-3.5,-2},{3.5,2}},
          origin={-200,-88}), iconTransformation(extent={{-207.5,-48},{-188,-28}})));
    Modelica.Blocks.Interfaces.RealInput heatStorageTemperatures[4] annotation (
        Placement(transformation(
          rotation=0,
          extent={{-3.5,-2},{3.5,2}},
          origin={-202,18}), iconTransformation(extent={{-10,-10},{10,10}},
            origin={-198,12})));
     Modelica.Blocks.Interfaces.RealInput massFlowTotal annotation (Placement(
          transformation(
          rotation=180,
          extent={{3.5,-2},{-3.5,2}},
          origin={-200,158}), iconTransformation(
          extent={{12,-12},{-12,12}},
          rotation=180,
          origin={-196,152})));
    Modelica.Blocks.Interfaces.RealInput openingHK11Y1 annotation (Placement(
          transformation(
          rotation=180,
          extent={{3.5,-2},{-3.5,2}},
          origin={-200,122}), iconTransformation(
          extent={{11,-11},{-11,11}},
          rotation=180,
          origin={-197,125})));
     Modelica.Blocks.Interfaces.RealInput temperatureOutside annotation (Placement(
          transformation(
          rotation=0,
          extent={{-3.5,-2},{3.5,2}},
          origin={-200,104}), iconTransformation(extent={{-10,-10},{10,10}},
            origin={-198,102})));
            Modelica.Blocks.Interfaces.RealInput openingHK11Y2 annotation (Placement(
          transformation(
          rotation=180,
          extent={{-3.5,-2},{3.5,2}},
          origin={200,142}), iconTransformation(
          extent={{-11,-11},{11,11}},
          rotation=180,
          origin={193,141})));

     //Subsystems

      Control.GlycolCoolerController_FC glycolCoolerController_FC
      annotation (Placement(transformation(extent={{28,20},{48,40}})));

       HK12Y2Control hK12Y2Control annotation (Placement(transformation(rotation=0,
       extent={{20,-50},{40,-30}})));

      //Components
    Control.GlycolCoolerController glycolCoolerController(n=4)
      annotation (Placement(transformation(extent={{-161,0},{-141,20}})));
    Control.BackUpCoolerController backUpCoolerController
      annotation (Placement(transformation(extent={{-107,2},{-87,22}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Water)
      annotation (Placement(transformation(extent={{-210,30},{-190,50}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Water)
      annotation (Placement(transformation(extent={{-210,66},{-190,86}}),
          iconTransformation(extent={{-210,66},{-190,86}})));
    Modelica.Fluid.Sensors.TemperatureTwoPort temperatureGCreturn(redeclare
      package   Medium = Water) annotation (Placement(transformation(
          extent={{5,4},{-5,-4}},
          rotation=90,
          origin={-121,58})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(
                                                 redeclare package Medium =
          Water)
      annotation (Placement(transformation(extent={{188,86},{208,106}}),
          iconTransformation(extent={{188,86},{208,106}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1(
                                                 redeclare package Medium =
          Water)
      annotation (Placement(transformation(extent={{190,32},{210,52}}),
          iconTransformation(extent={{190,32},{210,52}})));

    BaseClasses.GlycolCooler_FC glycolCooler_FC
      annotation (Placement(transformation(extent={{120,32},{100,52}})));
    BaseClasses.GlycolCooler glycolCooler
      annotation (Placement(transformation(extent={{-166,64},{-146,84}})));

      //Ouputs

    Modelica.Blocks.Interfaces.RealOutput openingValveReCooling annotation (
        Placement(transformation(
          rotation=0,
          extent={{-3.5,-2},{3.5,2}},
          origin={-198,-128}), iconTransformation(extent={{-205.5,-132},{-182,
              -108}})));
     Modelica.Blocks.Interfaces.RealOutput SignalHK12Y2
      annotation (Placement(transformation(extent={{198,-50},{218,-30}})));
  equation
    connect(massFlowGC, backUpCoolerController.massFlowGC) annotation (Line(
          points={{-200,-88},{-200,-88},{-102,-88},{-102,2},{-102.6,2}},
                                                     color={0,0,127}));
    connect(backUpCoolerController.opening_HK11Y1, Valve_GC_CharacteristicCurve.u[
      1]) annotation (Line(points={{-91.4,3},{-91.4,-14},{-92,-14},{-85,-14},{
            -85,-13}},
          color={0,0,127}));
    connect(Valve_GC_CharacteristicCurve.y[1], openingValveReCooling) annotation (
       Line(points={{-73.5,-13},{-73.5,-128},{-198,-128}},            color={0,0,127}));
    connect(massFlowTotal, backUpCoolerController.massFlowTotal) annotation (Line(
          points={{-200,158},{-68,158},{-68,8},{-87,8}},   color={0,0,127}));
    connect(backUpCoolerController.setPoint, openingHK11Y1) annotation (Line(
          points={{-97,21.9},{-97,24},{-96,24},{-96,120},{-148,120},{-148,122},{
            -200,122}},
          color={0,0,127}));
    connect(temperatureGCreturn.port_b, port_b) annotation (Line(points={{-121,53},
            {-122.5,53},{-122.5,40},{-200,40}}, color={0,127,255}));
    connect(temperatureGCreturn.T, backUpCoolerController.temperatureGCReturn)
      annotation (Line(points={{-116.6,58},{-112,58},{-112,52},{-112,12},{-107,
            12}},       color={0,0,127}));
    connect(heatStorageTemperatures, glycolCoolerController.HeatStorageTemperatures)
      annotation (Line(points={{-202,18},{-161,18},{-161,18.2}}, color={0,0,127}));
    connect(temperatureGCreturn.T, glycolCoolerController.temperature_in)
      annotation (Line(points={{-116.6,58},{-112,58},{-112,-16},{-176,-16},{-176,
            2},{-160.6,2}}, color={0,0,127}));
    connect(port_a, glycolCooler.port_a) annotation (Line(points={{-200,76},{-184,
            76},{-184,74},{-166,74}}, color={0,127,255}));
    connect(temperatureGCreturn.port_a, glycolCooler.port_b) annotation (Line(
          points={{-121,63},{-134,63},{-134,74},{-146,74}}, color={0,127,255}));
    connect(glycolCoolerController.m_flow_out, glycolCooler.m_flow_in)
      annotation (Line(points={{-140.7,18.3},{-140.7,44},{-140,44},{-140,68},{
            -146,68},{-146,67}}, color={0,0,127}));
    connect(temperatureOutside, glycolCooler.Temp_Outdoor) annotation (Line(
          points={{-200,104},{-140,104},{-140,81.3},{-146,81.3}}, color={0,0,127}));
    connect(temperatureOutside, glycolCooler_FC.Temp_Outdoor) annotation (Line(
          points={{-200,104},{74,104},{74,49.3},{100,49.3}}, color={0,0,127}));
    connect(port_a1, glycolCooler_FC.port_a)
      annotation (Line(points={{200,42},{200,42},{120,42}}, color={0,127,255}));
    connect(port_b1, glycolCooler_FC.port_b) annotation (Line(points={{198,96},{54,
            96},{54,42},{100,42}},    color={0,127,255}));
    connect(glycolCoolerController_FC.m_flow_out, glycolCooler_FC.m_flow_in)
      annotation (Line(points={{48.3,38.3},{48,38.3},{48,38},{94,38},{94,36},{100,
            36},{100,35}},                                               color={0,
            0,127}));
    connect(glycolCooler_FC.temperature_out, glycolCoolerController_FC.temperature_in)
      annotation (Line(points={{106.9,31.3},{108,31.3},{108,18},{18,18},{18,22},{28.4,
            22}},      color={0,0,127}));
    connect(openingHK11Y2, glycolCoolerController_FC.FC_Glycol) annotation (Line(
          points={{200,142},{10,142},{10,38},{28,38}}, color={0,0,127}));
    connect(openingHK11Y2, hK12Y2Control.FreeCoolingRequired) annotation (Line(
          points={{200,142},{10,142},{10,-39.4},{19.4,-39.4}}, color={0,0,127}));
    connect(hK12Y2Control.SignalHK12Y2, SignalHK12Y2) annotation (Line(points={{
            40.6,-39.2},{120.3,-39.2},{120.3,-40},{208,-40}}, color={0,0,127}));
    connect(port_b1, port_b1) annotation (Line(points={{198,96},{200,96},{200,96},
            {198,96}}, color={0,127,255}));
    annotation (Diagram(coordinateSystem(extent={{-200,-140},{200,180}},
            preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{0,180},{200,-140}},
            lineColor={0,0,0},
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5),
          Rectangle(
            extent={{-200,180},{0,-140}},
            lineColor={0,0,0},
            fillColor={255,170,170},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5),
          Text(
            extent={{-174,178},{-26,164}},
            lineColor={28,108,200},
            textString="Recooling"),
          Text(
            extent={{14,178},{162,164}},
            lineColor={28,108,200},
            textString="Freecooling")}), Icon(coordinateSystem(extent={{-200,-140},
              {200,180}}, preserveAspectRatio=false), graphics={
          Rectangle(extent={{-200,180},{200,-140}}, lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-176,108},{180,-56}},
            lineColor={215,215,215},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{102,56},{172,-8}},
            lineColor={215,215,215},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{8,56},{78,-8}},
            lineColor={215,215,215},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,56},{-10,-8}},
            lineColor={215,215,215},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-166,56},{-96,-8}},
            lineColor={215,215,215},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-164,-64},{178,-138}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid,
            textString="Glycol Cooler")}),
            Documentation(info="<html>
          <p>
          Simple modell of a controlled Glycol Cooler containing for controlled fans. The Cooler is can be used to directly cool the low temperature side (freecooling) 
          or recool the high temperature side if the temperatures in the hot storage increasing to high if the heatpump is in the cooling mode.
          </P>
          </html>"));
  end GlycolCooler;

  model GTF

    AixLib.Fluid.Sources.Boundary_pT geoSource(
      redeclare package Medium = Water,
      use_T_in=true,
      nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-21,-67})));
    AixLib.Fluid.Sources.Boundary_pT geoSink(redeclare package Medium = Water,
        nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={21,3})));
    Modelica.Fluid.Sensors.TemperatureTwoPort Tflow(redeclare package Medium =
          Medium_Water) annotation (Placement(transformation(
          extent={{-5,4},{5,-4}},
          rotation=180,
          origin={-20,-41})));
    Modelica.Fluid.Sensors.TemperatureTwoPort Treturn(redeclare package Medium =
          Medium_Water) annotation (Placement(transformation(
          extent={{5,4},{-5,-4}},
          rotation=180,
          origin={4,15})));
    replaceable package Water = AixLib.Media.Water annotation (Dialog(group="Medium"));
      replaceable package Medium_Water = AixLib.Media.Water annotation (Dialog(group="Medium"));
    Modelica.Blocks.Interfaces.RealOutput TflowGTF(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      min=0,
      displayUnit="degC") annotation (Placement(transformation(rotation=0, extent={{38.5,
              20.5},{31.5,25.5}}), iconTransformation(extent={{38.5,20.5},{31.5,
              25.5}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium_Water) annotation (Placement(transformation(rotation=0, extent={{-40.5,
              -43.5},{-33.5,-38.5}}), iconTransformation(extent={{-40.5,-43.5},{
              -33.5,-38.5}})));
    Modelica.Blocks.Interfaces.RealOutput TreturnGTF(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      min=0,
      displayUnit="degC") annotation (Placement(transformation(rotation=0, extent={{38.5,
              -23.5},{31.5,-18.5}}), iconTransformation(extent={{38.5,-23.5},{
              31.5,-18.5}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium_Water) annotation (Placement(transformation(rotation=0, extent={{-40.5,
              12.5},{-33.5,17.5}}), iconTransformation(extent={{-40.5,12.5},{
              -33.5,17.5}})));
    Modelica.Blocks.Interfaces.RealInput TinGTF(final unit="K", displayUnit=
          "degC") annotation (Placement(transformation(rotation=0, extent={{38.5,
              -79.5},{31.5,-74.5}}), iconTransformation(extent={{38.5,-79.5},{
              31.5,-74.5}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue
      "Reecooling is realized usin one three-way valve instead of two valves (see Heatpump Cycle \"Valve_GC\")"
      annotation (Placement(transformation(extent={{82,-96},{102,-76}})));
    Modelica.Blocks.Sources.Constant const(k=300)
      annotation (Placement(transformation(extent={{-64,-110},{-44,-90}})));
  equation
    connect(geoSource.ports[1], Tflow.port_a) annotation (Line(points={{-21,-57},
            {-15,-57},{-15,-41}}, color={0,127,255}));
    connect(geoSink.ports[1], Treturn.port_b)
      annotation (Line(points={{21,13},{9,13},{9,15}}, color={0,127,255}));
    connect(TflowGTF, Tflow.T) annotation (Line(points={{35,23},{-20,23},{-20,-36},
            {-20,-36},{-20,-36},{-20,-36.6}},      color={0,0,127}));
    connect(port_b, Tflow.port_b) annotation (Line(points={{-37,-41},{-37,-41},{
            -25,-41}}, color={0,127,255}));
    connect(TreturnGTF, Treturn.T) annotation (Line(points={{35,-21},{35,-20},{-12,
            -20},{-12,-20},{-12,19.4},{4,19.4}},
                       color={0,0,127}));
    connect(port_a, Treturn.port_a) annotation (Line(points={{-37,15},{-2,15},{-2,
            16},{-2,15},{-1,15}}, color={0,127,255}));
    connect(TinGTF, geoSource.T_in) annotation (Line(points={{35,-77},{9.5,-77},
            {9.5,-79},{-17,-79}}, color={0,0,127}));
    connect(const.y, realValue.numberPort) annotation (Line(points={{-43,-100},
            {20,-100},{20,-86},{80.5,-86}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(extent={{-35,-100},{35,60}},
            preserveAspectRatio=false), graphics={Text(
            extent={{-20,56},{22,34}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid,
            textString="Geothermal Field")}), Icon(coordinateSystem(extent={{-35,
              -100},{35,60}}, preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-36,60},{36,-100}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Solid,
            fillColor={255,255,255}),
          Rectangle(
            extent={{-24,-28},{28,-40}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-30,54},{30,28}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,170,170},
            textString="GTF"),
          Rectangle(
            extent={{18,14},{26,-10}},
            lineColor={0,0,0},
            fillColor={255,170,170},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{18,-6},{26,-28}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={85,255,255}),
          Rectangle(
            extent={{4,14},{12,-10}},
            lineColor={0,0,0},
            fillColor={255,170,170},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{4,-6},{12,-28}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={85,255,255}),
          Rectangle(
            extent={{-10,14},{-2,-10}},
            lineColor={0,0,0},
            fillColor={255,170,170},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-10,-6},{-2,-28}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={85,255,255}),
          Rectangle(
            extent={{-22,14},{-14,-10}},
            lineColor={0,0,0},
            fillColor={255,170,170},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-22,-6},{-14,-28}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={85,255,255})}),
            Documentation(info="<html> Simple model of a geothermic field. The field is modelled using watervolumes, the fieldtemperature is given by an table (which is located outside of this submodel). </html>"));
  end GTF;

  model HK12Y2Control

    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.5)
      annotation (Placement(transformation(extent={{66,50},{78,62}})));
    Modelica.Blocks.Interfaces.RealInput FreeCoolingRequired
      annotation (Placement(transformation(extent={{-26,36},{14,76}})));
    Modelica.Blocks.Sources.Constant one(k=1) annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={96,24})));
    Modelica.Blocks.Sources.Constant zero(k=0.001)
                                              annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={92,90})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{150,54},{156,60}})));
    Modelica.Blocks.Interfaces.RealOutput SignalHK12Y2
      annotation (Placement(transformation(extent={{196,48},{216,68}})));
  equation
    connect(FreeCoolingRequired, greaterThreshold.u)
      annotation (Line(points={{-6,56},{64.8,56},{64.8,56}}, color={0,0,127}));
    connect(one.y,switch1. u3) annotation (Line(points={{107,24},{128,24},{128,42},
            {127.6,42},{127.6,54.6},{149.4,54.6}},
                                   color={0,0,127}));
    connect(zero.y,switch1. u1) annotation (Line(points={{103,90},{126,90},{126,
            60},{126,59.4},{149.4,59.4}},
                                   color={0,0,127}));
    connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{78.6,56},{
            114,56},{114,57},{149.4,57}}, color={255,0,255}));
    connect(switch1.y, SignalHK12Y2) annotation (Line(points={{156.3,57},{180.15,
            57},{180.15,58},{206,58}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(extent={{0,-50},{200,150}},
            preserveAspectRatio=false)), Icon(coordinateSystem(extent={{0,-50},{
              200,150}}), graphics={
            Rectangle(
            extent={{0,150},{200,-50}},
            lineColor={0,0,255},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid), Text(
            extent={{58,78},{148,22}},
            lineColor={0,0,255},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid,
            textString="HK12Y2
Controller")}));
  end HK12Y2Control;

  model HeattransferHT

  //Parameter

      replaceable package Water = AixLib.Media.Water annotation (Dialog(group="Medium"));

      Modelica.Blocks.Sources.Constant const(k=0.001)
      annotation (Placement(transformation(extent={{1,29},{9,37}})));

      Modelica.Blocks.Sources.Constant const1(k=0.999)
      annotation (Placement(transformation(extent={{1,47},{9,55}})));

  //Inputs

      Modelica.Blocks.Interfaces.RealInput TAmbient(
      final quantity="ThermodynamicTemperature",
      final unit="K",
      displayUnit="degC") "Outdoor Temperature" annotation (Placement(transformation(rotation=0, extent=
             {{-82.5,38.5},{-71.5,51.5}}), iconTransformation(extent={{-82.5,38.5},
              {-71.5,51.5}})));

      Modelica.Blocks.Interfaces.IntegerInput WT03Requirement
      ">0: Heatexchanger and High Temperature Range has to activated"                                                         annotation (Placement(
      transformation(extent={{-86,-48},{-70,-32}}), iconTransformation(extent=
             {{-86,-48},{-70,-32}})));

  // Subsystems

    WT wT annotation (Placement(transformation(rotation=0, extent={{-3,-15},{17,5}})));
      HT_simple hT_simple(redeclare package Water = Water) annotation (Placement(
          transformation(rotation=0, extent={{-3,-59},{17,-39}})));

    // Components

    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{29,35},{41,47}})));

    Modelica.Fluid.Sensors.TemperatureTwoPort TFlowBoiler(redeclare package
        Medium = Water) annotation (Placement(transformation(
          extent={{-5,4},{5,-4}},
          rotation=180,
          origin={4,-25})));

    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare final package
        Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={{-38.5,58.5},
              {-27.5,71.5}})));
    Modelica.Blocks.Math.IntegerToBoolean integerToBoolean annotation (Placement(
          transformation(
          extent={{-4,-4},{4,4}},
          rotation=0,
          origin={-42,38})));

    Modelica.Fluid.Sensors.TemperatureTwoPort TFlowNT(redeclare package Medium =
          Water) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=90,
          origin={-15,27})));
    AixLib.Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium = Water,
      m_flow_nominal=12,
      dpValve_nominal=5800)
      annotation (Placement(transformation(extent={{30,12},{20,22}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Water)
      annotation (Placement(transformation(rotation=0, extent={{40.5,59.5},{52,70}})));
    AixLib.Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium = Water,
      m_flow_nominal=12,
      dpValve_nominal=5800)                                                          annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=-90,
          origin={45,7})));
    Modelica.Blocks.Math.Add add(k1=+1, k2=-1)
      annotation (Placement(transformation(extent={{48,40},{52,44}})));
      Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{54,47},{49,52}})));
  equation
    connect(const.y,switch2. u3) annotation (Line(points={{9.4,33},{25,33},{25,36.2},
            {27.8,36.2}},                 color={0,0,127}));
    connect(const1.y,switch2. u1) annotation (Line(points={{9.4,51},{19,51},{19,45.8},
            {27.8,45.8}},                 color={0,0,127}));
    connect(wT.port_b2,hT_simple.port_a)
                                     annotation (Line(points={{17,-9.66667},{35,
            -9.66667},{35,-59},{17.1,-59},{17.1,-56.5714}},
                                  color={0,127,255}));
    connect(hT_simple.port_b,TFlowBoiler. port_a) annotation (Line(points={{17.1,-48},
            {17.1,-25},{9,-25}},                            color={0,127,255}));
    connect(TFlowBoiler.port_b,wT. port_a2) annotation (Line(points={{-1,-25},{
            -6,-25},{-6,-24},{-12,-24},{-12,-7},{-4,-7},{-4,-8},{-4,-9.66667},{
            -3,-9.66667}},            color={0,127,255}));
    connect(TAmbient, hT_simple.TAmbient) annotation (Line(points={{-77,45},{
            -77,0},{-68,0},{-68,-46},{-2.9,-46},{-2.9,-46.2857}},
                                                            color={0,0,127}));
    connect(integerToBoolean.y, switch2.u2) annotation (Line(points={{-37.6,38},{-6,
            38},{-6,41},{27.8,41}}, color={255,0,255}));
    connect(integerToBoolean.y, hT_simple.WT03Requirement) annotation (Line(
          points={{-37.6,38},{-32,38},{-32,-58},{-3.1,-58}}, color={255,0,255}));
    connect(integerToBoolean.u, WT03Requirement) annotation (Line(points={{-46.8,38},
            {-56,38},{-56,-40},{-78,-40},{-78,-40}}, color={255,127,0}));

    connect(TFlowNT.T, hT_simple.TFlowNT) annotation (Line(points={{-18.3,27},{
            -18.3,-44},{-2,-44},{-2,-43.4286},{-2.9,-43.4286}}, color={0,0,127}));
    connect(port_a, val.port_a) annotation (Line(points={{46.25,64.75},{46.25,42},
            {46,42},{46,18},{30,18},{30,17}}, color={0,127,255}));
    connect(port_a, val1.port_a) annotation (Line(points={{46.25,64.75},{46.25,38.375},
            {45,38.375},{45,12}}, color={0,127,255}));
    connect(val1.port_b, wT.port_a1)
      annotation (Line(points={{45,2},{17,2},{17,1}}, color={0,127,255}));
    connect(switch2.y, add.u2) annotation (Line(points={{41.6,41},{44,41},{44,40.8},
            {47.6,40.8}}, color={0,0,127}));
    connect(add.y, val1.y) annotation (Line(points={{52.2,42},{54,42},{54,8},{51,8},
            {51,7}}, color={0,0,127}));
    connect(switch2.y, val.y) annotation (Line(points={{41.6,41},{41.6,31.5},{25,31.5},
            {25,23}}, color={0,0,127}));
    connect(const2.y, add.u1) annotation (Line(points={{48.75,49.5},{48.75,46.75},
            {47.6,46.75},{47.6,43.2}}, color={0,0,127}));
    connect(wT.port_b1, TFlowNT.port_a) annotation (Line(points={{-3,1},{-3,
            12.5},{-15,12.5},{-15,24}}, color={0,127,255}));
    connect(val.port_b, TFlowNT.port_a) annotation (Line(points={{20,17},{2,17},
            {2,24},{-15,24}}, color={0,127,255}));
    connect(TFlowNT.port_b, port_b1) annotation (Line(points={{-15,30},{-24,30},
            {-24,65},{-33,65}}, color={0,127,255}));
    annotation (Diagram(coordinateSystem(extent={{-80,-60},{55,65}},
            preserveAspectRatio=false)), Icon(coordinateSystem(extent={{-80,-60},{
              55,65}}, preserveAspectRatio=false), graphics={
                                Rectangle(
            extent={{-72,64},{52,-58}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={170,170,255}),
          Polygon(
            points={{-24.5,8.5},{-32.5,-7.5},{-10.5,-51.5},{-2.5,-25.5},{19.5,-29.5},
                {9.5,12.5},{-8.5,8.5},{-14.5,8.5},{-24.5,8.5}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={255,127,0}),
          Polygon(
            points={{-26.5,12.5},{-16.5,-7.5},{9.5,12.5},{-16.5,12.5},{-26.5,12.5}},
            lineColor={255,255,170},
            fillColor={255,255,170},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-36.5,18.5},{17.5,10.5}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Text(
            extent={{-60,30},{38,48}},
            lineColor={0,0,0},
            fillColor={170,255,85},
            fillPattern=FillPattern.Solid,
            textString="Heattransfer HT")}),
    Documentation(info="<html>
  
  <p>
  <b>HeattransferHT</b>
  </p>
  The real Building energy Systems which is imaged in this modell contains a high temperature range, which is is enable to support the heatgeneration if the heatpump output is insufficient.
  The high temperature range in the modell is simplified as a series connection of three boilers. Assisted by these boilers and a heat generator (WT03) ist is possible to reheat the outcoming 
  fluid from the hot storage if neccesary. The requierement of the heat generation is proved in the maincontrol by comparing the flowtemperature of the hot storage with a nominal value. 
  The stand-by function is not implemented, which means that the heat exchanger is used if the incoming value is greater than 0.
  </p> 
</html>"));
  end HeattransferHT;

  model WT
    replaceable package Water = AixLib.Media.Water;

    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare final package
        Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={{
              13.5,7.5},{16.5,10.5}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare final package
        Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={{-16.5,
              -8.5},{-13.5,-5.5}}), iconTransformation(extent={{-16.5,-8.5},{
              -13.5,-5.5}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare final package
        Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={{-16.5,
              7.5},{-13.5,10.5}}), iconTransformation(extent={{-16.5,7.5},{-13.5,
              10.5}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare final package
        Medium =
          Water) annotation (Placement(transformation(rotation=0, extent={{13.5,
              -8.5},{16.5,-5.5}}), iconTransformation(extent={{13.5,-8.5},{16.5,
              -5.5}})));
    Buildings.Fluid.HeatExchangers.DryCoilCounterFlow heaCoi(
        redeclare package Medium1 = Water,
      redeclare package Medium2 = Water,
      dp1_nominal=5000,
      dp2_nominal=5000,
      allowFlowReversal1=true,
      allowFlowReversal2=true,
      show_T=true,
      m1_flow_nominal=8.4564,
      m2_flow_nominal=0.1597,
      UA_nominal=2800,
      tau1=1,
      tau_m=1)
      annotation (Placement(transformation(extent={{-8,-8},{12,12}})));
  equation
    connect(port_a1, heaCoi.port_b1) annotation (Line(points={{15,9},{13.5,9},{13.5,
            8},{12,8}}, color={0,127,255}));
    connect(port_b1, heaCoi.port_a1) annotation (Line(points={{-15,9},{-11.5,9},{
            -11.5,8},{-8,8}},
                        color={0,127,255}));
    connect(port_a2, heaCoi.port_b2) annotation (Line(points={{-15,-7},{-11.5,-7},
            {-11.5,-4},{-8,-4}}, color={0,127,255}));
    connect(port_b2, heaCoi.port_a2) annotation (Line(points={{15,-7},{13.5,-7},{
            13.5,-4},{12,-4}},
                          color={0,127,255}));
    annotation (Diagram(coordinateSystem(extent={{-15,-15},{15,15}},
            preserveAspectRatio=false)), Icon(coordinateSystem(extent={{-15,-15},
              {15,15}}, preserveAspectRatio=false), graphics={
          Polygon(
            points={{-14,-14},{14,-14},{14,-2},{2,-4},{-6,-2},{-14,-2},{-14,-2},{
                -14,-14}},
            lineColor={238,46,47},
            lineThickness=0.5,
            fillColor={238,46,47},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-14,2},{14,2},{14,-6},{2,-8},{-6,-6},{-14,-6},{-14,2}},
            lineColor={255,170,170},
            lineThickness=0.5,
            fillColor={255,170,170},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-14,10},{14,10},{14,2},{6,0},{-4,2},{-14,0},{-14,10}},
            lineColor={85,170,255},
            lineThickness=0.5,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-14,14},{14,14},{14,8},{8,8},{4,10},{0,8},{-2,8},{-6,10},{
                -10,8},{-10,8},{-14,10},{-14,14}},
            lineColor={0,128,255},
            lineThickness=0.5,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-10,4},{10,-4}},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            pattern=LinePattern.None),
          Text(
            extent={{-8,4},{8,-4}},
            lineColor={0,128,255},
            lineThickness=0.5,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            textString="WT03")}));
  end WT;

  annotation ();
end ERCBuilding;
