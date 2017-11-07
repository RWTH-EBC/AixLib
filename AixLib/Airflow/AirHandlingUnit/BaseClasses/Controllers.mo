within AixLib.Airflow.AirHandlingUnit.BaseClasses;
package Controllers "contains all the control models"
  extends Modelica.Icons.VariantsPackage;
  model MenergaController
    "contains the control modes for the menerga model"


    BusActors busActors "Bus Connector for actor signals" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={98,-58}), iconTransformation(extent={{80,-56},{120,-16}})));
    OperatingModes.FixedValues fixedValues1
      annotation (Placement(transformation(extent={{-12,64},{8,84}})));
    BusSensors busSensors "Bus connector between controllers and sensor signals"
      annotation (Placement(transformation(extent={{-120,-54},{-80,-14}}),
          iconTransformation(extent={{-120,-54},{-80,-14}})));
    OperatingModes.development development
      annotation (Placement(transformation(extent={{-12,30},{8,50}})));
    OperatingModes.PN_intern_optimal pN_intern_optimal
      annotation (Placement(transformation(extent={{-26,-36},{24,14}})));
  equation
    if true then
      connect(pN_intern_optimal.busActors, busActors);
      //connect(development.busActors, busActors);
    end if;

    connect(busSensors, development.busSensors) annotation (Line(
        points={{-100,-34},{-56,-34},{-56,37.04},{-11.56,37.04}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(busSensors, pN_intern_optimal.busSensors) annotation (Line(
        points={{-100,-34},{-64,-34},{-64,-12.8},{-26.8,-12.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-107,-100},{-33,-40}},
            lineColor={0,0,0},
            textString="Sensors"),
          Text(
            extent={{38,-100},{102,-40}},
            lineColor={0,0,0},
            textString="Actors"),
          Text(
            extent={{-76,68},{76,-16}},
            lineColor={0,0,0},
            textString="Controller
model")}),                                                         Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end MenergaController;

  package OperatingModes
    "Package that contains the operating modes of the Menerga model"
    extends Modelica.Icons.UtilitiesPackage;
    model FixedValues "development mode parameter"
      BusActors busActors "Bus connector for actor signals"
        annotation (Placement(transformation(extent={{26,-142},{176,2}})));
      Modelica.Blocks.Sources.Constant valOpeningY01(k=1) "opening of Y01"
        annotation (Placement(transformation(extent={{-222,234},{-202,254}})));
      Modelica.Blocks.Sources.Constant valOpeningY02(k=0) "opening of Y02"
        annotation (Placement(transformation(extent={{-222,202},{-202,222}})));
      Modelica.Blocks.Sources.Constant valOpeningY03(k=0) "opening of damper Y03"
        annotation (Placement(transformation(extent={{-222,170},{-202,190}})));
      Modelica.Blocks.Sources.Constant valOpeningY04(k=1) "opening of damper Y04"
        annotation (Placement(transformation(extent={{-220,136},{-200,156}})));
      Modelica.Blocks.Sources.Constant valOpeningY05(k=1) "opening of damper Y05"
        annotation (Placement(transformation(extent={{-220,104},{-200,124}})));
      Modelica.Blocks.Sources.Constant valOpeningY06(k=1) "opening of damper Y06"
        annotation (Placement(transformation(extent={{-220,74},{-200,94}})));
      Modelica.Blocks.Sources.Constant valOpeningY07(k=1) "opening of damper Y07"
        annotation (Placement(transformation(extent={{-220,44},{-200,64}})));
      Modelica.Blocks.Sources.Constant valOpeningY08(k=1) "opening of damper Y08"
        annotation (Placement(transformation(extent={{-220,12},{-200,32}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow(k=5.1)
        "nominal mass flow rate in outside air fan"
        annotation (Placement(transformation(extent={{-220,-18},{-200,2}})));
      Modelica.Blocks.Sources.Constant RegenAir_mflow(k=1)
        "nominal mass flow for regeneration air fan"
        annotation (Placement(transformation(extent={{-220,-48},{-200,-28}})));
      Modelica.Blocks.Sources.Constant exhaust_mflow(k=5.1)
        "nominal mass flow for exhaust air fan"
        annotation (Placement(transformation(extent={{-220,-78},{-200,-58}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow1(k=1)
        "nominal mass flow in steamHumidifier"
        annotation (Placement(transformation(extent={{-220,-108},{-200,-88}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow2(k=0.1)
        "water mass flow in absorber"
        annotation (Placement(transformation(extent={{-220,-140},{-200,-120}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow3(k=0.1)
        "water mass flow in absorber"
        annotation (Placement(transformation(extent={{-220,-204},{-200,-184}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflowDes(k=0.1)
        "water mass flow in desorber"
        annotation (Placement(transformation(extent={{-220,-170},{-200,-150}})));
      Modelica.Blocks.Sources.Constant openValveHeatCoil(k=0.2)
        "opening of the three way valve in the heating coil circuit"
        annotation (Placement(transformation(extent={{-220,-238},{-200,-218}})));
    equation
      connect(valOpeningY01.y, busActors.openingY01) annotation (Line(points={{-201,
              244},{-68,244},{-68,-69.64},{101.375,-69.64}},      color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY02.y, busActors.openingY02) annotation (Line(points={{-201,
              212},{-68,212},{-68,-69.64},{101.375,-69.64}},      color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY03.y, busActors.openingY03) annotation (Line(points={{-201,
              180},{-68,180},{-68,-69.64},{101.375,-69.64}},      color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY04.y, busActors.openingY04) annotation (Line(points={{-199,
              146},{-68,146},{-68,-69.64},{101.375,-69.64}},      color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY05.y, busActors.openingY05) annotation (Line(points={{-199,
              114},{-68,114},{-68,-69.64},{101.375,-69.64}},    color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY06.y, busActors.openingY06) annotation (Line(points={{-199,84},
              {-68,84},{-68,-69.64},{101.375,-69.64}},          color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY07.y, busActors.openingY07) annotation (Line(points={{-199,54},
              {-68,54},{-68,-69.64},{101.375,-69.64}},          color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY08.y, busActors.openingY08) annotation (Line(points={{-199,22},
              {-68,22},{-68,-69.64},{101.375,-69.64}},        color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow.y, busActors.outsideFan) annotation (Line(points={{-199,-8},
              {-68,-8},{-68,-69.64},{101.375,-69.64}},              color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(RegenAir_mflow.y, busActors.regenerationFan) annotation (Line(
            points={{-199,-38},{-68,-38},{-68,-69.64},{101.375,-69.64}}, color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(exhaust_mflow.y, busActors.exhaustFan) annotation (Line(points={{-199,
              -68},{-68,-68},{-68,-69.64},{101.375,-69.64}},      color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow1.y, busActors.mWatSteamHumid) annotation (Line(
            points={{-199,-98},{-68,-98},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow2.y, busActors.mWatAbsorber) annotation (Line(
            points={{-199,-130},{-68,-130},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow3.y, busActors.mWatEvaporator) annotation (Line(
            points={{-199,-194},{-68,-194},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflowDes.y, busActors.mWatDesorber) annotation (Line(
            points={{-199,-160},{-68,-160},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(openValveHeatCoil.y, busActors.openValveHeatCoil) annotation (
          Line(points={{-199,-228},{-134,-228},{-68,-228},{-68,-69.64},{101.375,
              -69.64}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-400,
                -240},{100,260}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-400,-240},{100,260}})));
    end FixedValues;

    model development "development mode with simple PID controllers"
      BusActors busActors "Bus connector for actor signals"
        annotation (Placement(transformation(extent={{26,-142},{176,2}})));
      Modelica.Blocks.Sources.Constant valOpeningY01(k=1) "opening of Y01"
        annotation (Placement(transformation(extent={{-222,236},{-202,256}})));
      Modelica.Blocks.Sources.Constant valOpeningY03(k=0) "opening of damper Y03"
        annotation (Placement(transformation(extent={{-222,150},{-202,170}})));
      Modelica.Blocks.Sources.Constant valOpeningY04(k=1) "opening of damper Y04"
        annotation (Placement(transformation(extent={{-220,116},{-200,136}})));
      Modelica.Blocks.Sources.Constant valOpeningY05(k=1) "opening of damper Y05"
        annotation (Placement(transformation(extent={{-220,84},{-200,104}})));
      Modelica.Blocks.Sources.Constant valOpeningY06(k=1) "opening of damper Y06"
        annotation (Placement(transformation(extent={{-220,54},{-200,74}})));
      Modelica.Blocks.Sources.Constant valOpeningY07(k=1) "opening of damper Y07"
        annotation (Placement(transformation(extent={{-220,24},{-200,44}})));
      Modelica.Blocks.Sources.Constant valOpeningY08(k=1) "opening of damper Y08"
        annotation (Placement(transformation(extent={{-220,-8},{-200,12}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow(k=5.1)
        "nominal mass flow rate in outside air fan"
        annotation (Placement(transformation(extent={{-220,-38},{-200,-18}})));
      Modelica.Blocks.Sources.Constant RegenAir_mflow(k=1)
        "nominal mass flow for regeneration air fan"
        annotation (Placement(transformation(extent={{-220,-68},{-200,-48}})));
      Modelica.Blocks.Sources.Constant exhaust_mflow(k=5.1)
        "nominal mass flow for exhaust air fan"
        annotation (Placement(transformation(extent={{-220,-98},{-200,-78}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow3(k=0.2)
        "water mass flow in absorber"
        annotation (Placement(transformation(extent={{-220,-224},{-200,-204}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflowDes(k=0.1)
        "water mass flow in desorber"
        annotation (Placement(transformation(extent={{-220,-190},{-200,-170}})));
      BusSensors busSensors
        annotation (Placement(transformation(extent={{-474,-142},{-304,14}})));
      Modelica.Blocks.Continuous.LimPID valOpeningConY02(yMax=1, yMin=0)
        "controlled opening for damper Y02"
        annotation (Placement(transformation(extent={{-364,156},{-344,176}})));
      Modelica.Blocks.Sources.Constant T01_Set(k=293.15) "Setpoint of T01"
        annotation (Placement(transformation(extent={{-498,-258},{-478,-238}})));
      Modelica.Blocks.Sources.Constant constOne(k=1)
        annotation (Placement(transformation(extent={{-388,220},{-368,240}})));
      Modelica.Blocks.Math.Add add(k2=-1)
        annotation (Placement(transformation(extent={{-302,208},{-282,228}})));
      Modelica.Blocks.Continuous.LimPID valOpeHeaCoi( yMax=1, yMin=0,
        Td=10,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        Ti=80,
        k=0.06) "opening of the three way valve in the heating coil circuit"
        annotation (Placement(transformation(extent={{-220,-258},{-200,-238}})));
      Modelica.Blocks.Sources.Constant relHumSet(k=0.5)
        "set point for the rel humidity"
        annotation (Placement(transformation(extent={{-298,-128},{-278,-108}})));
      Modelica.Blocks.Math.Gain gainAbs(k=0.1)
        "gain for absorber water mass flow" annotation (Placement(
            transformation(extent={{-218,-158},{-198,-138}})));
      Modelica.Blocks.Math.Division mFlowAbsPart
        "gives the part of the mass flow rate that goes through the absorber"
        annotation (Placement(transformation(extent={{-296,-184},{-276,-164}})));
      Modelica.Blocks.Sources.Constant mFlowAirNom(k=5.1)
        "nominal mass flow rate of air in supply air vent in kg/s" annotation (
          Placement(transformation(extent={{-362,-190},{-342,-170}})));
      Modelica.Blocks.Sources.Constant valOpeningY02(k=0) "opening of Y02"
        annotation (Placement(transformation(extent={{-222,202},{-202,222}})));
      Modelica.Blocks.Continuous.LimPID PID(
        yMin=0,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yMax=1,
        Ti=80,
        k=0.2)                                                    annotation (
          Placement(transformation(extent={{-220,-128},{-200,-108}})));
      relToAbsHum absHumSet1 annotation (Placement(transformation(extent={{-134,
                -128},{-114,-108}})));
    equation
      connect(valOpeningY03.y, busActors.openingY03) annotation (Line(points={{
              -201,160},{-68,160},{-68,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY04.y, busActors.openingY04) annotation (Line(points={{
              -199,126},{-68,126},{-68,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY05.y, busActors.openingY05) annotation (Line(points={{
              -199,94},{-68,94},{-68,-69.64},{101.375,-69.64}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY06.y, busActors.openingY06) annotation (Line(points={{
              -199,64},{-68,64},{-68,-69.64},{101.375,-69.64}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY07.y, busActors.openingY07) annotation (Line(points={{
              -199,34},{-68,34},{-68,-69.64},{101.375,-69.64}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY08.y, busActors.openingY08) annotation (Line(points={{
              -199,2},{-68,2},{-68,-69.64},{101.375,-69.64}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow.y, busActors.outsideFan) annotation (Line(points=
              {{-199,-28},{-68,-28},{-68,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(RegenAir_mflow.y, busActors.regenerationFan) annotation (Line(
            points={{-199,-58},{-68,-58},{-68,-69.64},{101.375,-69.64}}, color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(exhaust_mflow.y, busActors.exhaustFan) annotation (Line(points={{
              -199,-88},{-68,-88},{-68,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow3.y, busActors.mWatEvaporator) annotation (Line(
            points={{-199,-214},{-68,-214},{-68,-70},{101,-70}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflowDes.y, busActors.mWatDesorber) annotation (Line(
            points={{-199,-180},{-68,-180},{-68,-70},{101,-70}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(T01_Set.y, valOpeningConY02.u_s) annotation (Line(points={{-477,
              -248},{-446,-248},{-446,166},{-366,166}}, color={0,0,127}));
      connect(constOne.y, add.u1) annotation (Line(points={{-367,230},{-367,224},
              {-304,224}}, color={0,0,127}));
      connect(valOpeningConY02.y, add.u2) annotation (Line(points={{-343,166},{
              -322,166},{-322,212},{-304,212}}, color={0,0,127}));
      connect(valOpeningY01.y, busActors.openingY01) annotation (Line(points={{
              -201,246},{-201,238},{-32,238},{-32,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeHeaCoi.u_m, busSensors.T01) annotation (Line(points={{-210,
              -260},{-312,-260},{-312,-226},{-388.575,-226},{-388.575,-63.61}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(T01_Set.y, valOpeHeaCoi.u_s) annotation (Line(points={{-477,-248},
              {-477,-248},{-222,-248}}, color={0,0,127}));
      connect(valOpeHeaCoi.y, busActors.openValveHeatCoil) annotation (Line(
            points={{-199,-248},{101,-248},{101,-70}},            color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(mFlowAbsPart.y, gainAbs.u) annotation (Line(points={{-275,-174},{
              -250,-174},{-250,-148},{-220,-148}}, color={0,0,127}));
      connect(mFlowAbsPart.u1, busSensors.mFlowAbs) annotation (Line(points={{
              -298,-168},{-336,-168},{-336,-63.61},{-388.575,-63.61}}, color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(mFlowAirNom.y, mFlowAbsPart.u2) annotation (Line(points={{-341,
              -180},{-298,-180}},                         color={0,0,127}));
      connect(gainAbs.y, busActors.mWatAbsorber) annotation (Line(points={{-197,
              -148},{-197,-148},{-68,-148},{-68,-70},{101,-70}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY02.y, busActors.openingY02) annotation (Line(points={{
              -201,212},{-201,214},{-68,214},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningConY02.u_m, busSensors.T01) annotation (Line(points={{
              -354,154},{-362,154},{-362,-63.61},{-388.575,-63.61}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(PID.y, absHumSet1.relHum)
        annotation (Line(points={{-199,-118},{-134.6,-118}}, color={0,0,127}));
      connect(relHumSet.y, PID.u_s)
        annotation (Line(points={{-277,-118},{-222,-118}}, color={0,0,127}));
      connect(PID.u_m, busSensors.T01_RelHum) annotation (Line(points={{-210,
              -130},{-210,-130},{-210,-134},{-210,-134},{-210,-134},{-336,-134},
              {-336,-63.61},{-388.575,-63.61}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(absHumSet1.Tem, busSensors.T01) annotation (Line(points={{-134.6,
              -112},{-336,-112},{-336,-63.61},{-388.575,-63.61}},     color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(absHumSet1.absHum, busActors.mWatSteamHumid) annotation (Line(
            points={{-113.4,-118},{-68,-118},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(absHumSet1.p_In, busSensors.P01) annotation (Line(points={{-134.6,
              -124},{-336,-124},{-336,-63.61},{-388.575,-63.61}},     color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-400,
                -240},{100,260}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-400,-240},{100,260}})));
    end development;

    model PN_intern_optimal

      parameter Real T_Set = 20 "set value for T01";
      BusSensors busSensors
        annotation (Placement(transformation(extent={{-272,-58},{-184,42}})));
      BusActors busActors "Bus connector for actor signals"
        annotation (Placement(transformation(extent={{246,-38},{320,42}})));
      PN_Steuerung.PN_Steuerung_Ebene1 pN_Steuerung_Ebene1_1
        annotation (Placement(transformation(extent={{-142,170},{-122,190}})));
      RegAnforderung regAnforderung "True, when there is need for regeneration"
        annotation (Placement(transformation(extent={{-146,122},{-126,142}})));
      PN_Steuerung.Ebene2.DD dD
        annotation (Placement(transformation(extent={{-80,76},{-60,96}})));
      PN_Steuerung.Aktoren.Y02 valve_Y02(T_Set=T_Set)
                                         "valve Output for valve Y02"
        annotation (Placement(transformation(extent={{150,200},{170,220}})));
      PN_Steuerung.ModeSwitch modeSwitch
        annotation (Placement(transformation(extent={{40,-10},{78,26}})));
      PN_Steuerung.Ebene2.DB dB
        annotation (Placement(transformation(extent={{-80,46},{-60,66}})));
      PN_Steuerung.Ebene2.DE dE
        annotation (Placement(transformation(extent={{-80,16},{-60,36}})));
      PN_Steuerung.Ebene2.HD hD
        annotation (Placement(transformation(extent={{-80,-14},{-60,6}})));
      PN_Steuerung.Ebene2.HB hB
        annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
      PN_Steuerung.Ebene2.HE hE
        annotation (Placement(transformation(extent={{-80,-74},{-60,-54}})));
      PN_Steuerung.Ebene2.KD kD
        annotation (Placement(transformation(extent={{-80,-104},{-60,-84}})));
      PN_Steuerung.Ebene2.KB kB
        annotation (Placement(transformation(extent={{-80,-134},{-60,-114}})));
      PN_Steuerung.Ebene2.KE kE
        annotation (Placement(transformation(extent={{-80,-164},{-60,-144}})));
      Modelica.Blocks.Sources.Constant valOpeningY01(k=1) "opening of Y01"
        annotation (Placement(transformation(extent={{136,232},{156,252}})));
      Modelica.Blocks.Sources.Constant valOpeningY03(k=0) "opening of damper Y03"
        annotation (Placement(transformation(extent={{148,170},{168,190}})));
      Modelica.Blocks.Sources.Constant valOpeningY04(k=1) "opening of damper Y04"
        annotation (Placement(transformation(extent={{146,136},{166,156}})));
      Modelica.Blocks.Sources.Constant valOpeningY05(k=1) "opening of damper Y05"
        annotation (Placement(transformation(extent={{144,98},{164,118}})));
      Modelica.Blocks.Sources.Constant valOpeningY06(k=1) "opening of damper Y06"
        annotation (Placement(transformation(extent={{144,66},{164,86}})));
      Modelica.Blocks.Sources.Constant valOpeningY07(k=1) "opening of damper Y07"
        annotation (Placement(transformation(extent={{148,30},{168,50}})));
      Modelica.Blocks.Sources.Constant valOpeningY08(k=1)
        "opening of damper Y08"
        annotation (Placement(transformation(extent={{146,-8},{166,12}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow(k=5.1)
        "nominal mass flow rate in outside air fan"
        annotation (Placement(transformation(extent={{144,-52},{164,-32}})));
      Modelica.Blocks.Sources.Constant RegenAir_mflow(k=1)
        "nominal mass flow for regeneration air fan"
        annotation (Placement(transformation(extent={{144,-88},{164,-68}})));
      Modelica.Blocks.Sources.Constant exhaust_mflow(k=5.1)
        "nominal mass flow for exhaust air fan"
        annotation (Placement(transformation(extent={{144,-126},{164,-106}})));
      Modelica.Blocks.Sources.Constant valOpeningY9( k=1)
        "opening of damper Y09"
        annotation (Placement(transformation(extent={{190,-148},{210,-128}})));
      Modelica.Blocks.Sources.Constant valOpeningY10(k=1)
        "opening of damper Y10"
        annotation (Placement(transformation(extent={{192,-182},{212,-162}})));
      Modelica.Blocks.Sources.Constant valOpeningY11(k=1)
        "opening of damper Y11"
        annotation (Placement(transformation(extent={{192,-214},{212,-194}})));
      Modelica.Blocks.Sources.Constant pumpN04(k=1)
        "heating coil pump supply air"
        annotation (Placement(transformation(extent={{192,-250},{212,-230}})));
      Modelica.Blocks.Sources.Constant pumpN05(k=1)
        "heating coil pump regeneration air"
        annotation (Placement(transformation(extent={{192,-284},{212,-264}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN06
        annotation (Placement(transformation(extent={{192,-316},{212,-296}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN07
        annotation (Placement(transformation(extent={{192,-344},{212,-324}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN08
        annotation (Placement(transformation(extent={{192,-372},{212,-352}})));
    equation
      connect(dD.RegAnf, regAnforderung.RegAnf) annotation (Line(points={{-80.6,
              86},{-100,86},{-100,132},{-125.4,132}},
                                                  color={255,0,255}));
      connect(modeSwitch.CurrentMode, valve_Y02.M_in) annotation (Line(points={{78.6333,
              10.5714},{100,10.5714},{100,210},{149.2,210}},          color={
              255,127,0}));
      connect(valve_Y02.T_measure, busSensors.T01) annotation (Line(points={{149.2,
              202.2},{120,202.2},{120,202},{-227.78,202},{-227.78,-7.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y02.setValue_Y02, busActors.openingY02) annotation (Line(
            points={{170.6,210},{230,210},{230,2.2},{283.185,2.2}},     color={
              0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.ModeSelector, modeSwitch.BooleanModeIn)
        annotation (Line(points={{-121.4,180},{59,180},{59,25.8286}}, color={
              255,0,255}));
      connect(regAnforderung.RegAnf, dB.RegAnf) annotation (Line(points={{
              -125.4,132},{-100,132},{-100,56},{-80.6,56}}, color={255,0,255}));
      connect(regAnforderung.RegAnf, dE.RegAnf) annotation (Line(points={{
              -125.4,132},{-100,132},{-100,26},{-80.6,26}}, color={255,0,255}));
      connect(regAnforderung.RegAnf, hD.RegAnf) annotation (Line(points={{
              -125.4,132},{-100,132},{-100,-4},{-80.6,-4}}, color={255,0,255}));
      connect(regAnforderung.RegAnf, hB.RegAnf) annotation (Line(points={{
              -125.4,132},{-100,132},{-100,-34},{-80.6,-34}}, color={255,0,255}));
      connect(regAnforderung.RegAnf, hE.RegAnf) annotation (Line(points={{
              -125.4,132},{-100,132},{-100,-64},{-80.6,-64}}, color={255,0,255}));
      connect(regAnforderung.RegAnf, kD.RegAnf) annotation (Line(points={{
              -125.4,132},{-100,132},{-100,-94},{-80.6,-94}}, color={255,0,255}));
      connect(regAnforderung.RegAnf, kB.RegAnf) annotation (Line(points={{
              -125.4,132},{-100,132},{-100,-124},{-80.6,-124}}, color={255,0,
              255}));
      connect(regAnforderung.RegAnf, kE.RegAnf) annotation (Line(points={{
              -125.4,132},{-100,132},{-100,-154},{-80.6,-154}}, color={255,0,
              255}));
      connect(dB.DB_Out, modeSwitch.DB) annotation (Line(points={{-59.4,56},{10,
              56},{10,21.2},{38.9444,21.2}}, color={255,127,0}));
      connect(dE.DE_Out, modeSwitch.DE) annotation (Line(points={{-59.4,26},{12,
              26},{12,16.9143},{38.9444,16.9143}}, color={255,127,0}));
      connect(hD.HD_Out, modeSwitch.HD) annotation (Line(points={{-59.4,-4},{20,
              -4},{20,12.8},{38.9444,12.8}}, color={255,127,0}));
      connect(hB.HB_Out, modeSwitch.HB) annotation (Line(points={{-59.4,-34},{
              22,-34},{22,8.85714},{38.9444,8.85714}}, color={255,127,0}));
      connect(hE.HE_Out, modeSwitch.HE) annotation (Line(points={{-59.4,-64},{
              24,-64},{24,4.4},{38.9444,4.4}}, color={255,127,0}));
      connect(kD.KD_Out, modeSwitch.KD) annotation (Line(points={{-59.4,-94},{
              26,-94},{26,0.457143},{38.9444,0.457143}}, color={255,127,0}));
      connect(kB.KB_Out, modeSwitch.KB) annotation (Line(points={{-59.4,-124},{
              30,-124},{30,-3.82857},{38.9444,-3.82857}}, color={255,127,0}));
      connect(kE.KE_Out, modeSwitch.KE) annotation (Line(points={{-59.4,-154},{
              34,-154},{34,-8.28571},{38.9444,-8.28571}}, color={255,127,0}));
      connect(dD.DD_Out, modeSwitch.DD) annotation (Line(points={{-59.4,86},{8,
              86},{8,25.3143},{38.9444,25.3143}}, color={255,127,0}));
      connect(valOpeningY03.y, busActors.openingY03) annotation (Line(points={{169,180},
              {230,180},{230,2.2},{283.185,2.2}},                 color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY04.y, busActors.openingY04) annotation (Line(points={{167,146},
              {230,146},{230,2.2},{283.185,2.2}},                 color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY05.y, busActors.openingY05) annotation (Line(points={{165,108},
              {230,108},{230,2.2},{283.185,2.2}},               color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY06.y, busActors.openingY06) annotation (Line(points={{165,76},
              {230,76},{230,2.2},{283.185,2.2}},                color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY07.y, busActors.openingY07) annotation (Line(points={{169,40},
              {230,40},{230,2.2},{283.185,2.2}},                color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY08.y, busActors.openingY08) annotation (Line(points={{167,2},
              {230,2},{230,2.2},{283.185,2.2}},               color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow.y, busActors.outsideFan) annotation (Line(points={{165,-42},
              {230,-42},{230,2.2},{283.185,2.2}},                   color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(RegenAir_mflow.y, busActors.regenerationFan) annotation (Line(
            points={{165,-78},{230,-78},{230,2.2},{283.185,2.2}},        color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(exhaust_mflow.y, busActors.exhaustFan) annotation (Line(points={{165,
              -116},{230,-116},{230,2.2},{283.185,2.2}},          color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY01.y, busActors.openingY01) annotation (Line(points={{157,242},
              {157,240},{230,240},{230,2.2},{283.185,2.2}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY9.y, busActors.openingY09) annotation (Line(points={{
              211,-138},{230,-138},{230,2.2},{283.185,2.2}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY10.y, busActors.openingY10) annotation (Line(points={{
              213,-172},{230,-172},{230,2},{283.185,2},{283.185,2.2}}, color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY11.y, busActors.openingY11) annotation (Line(points={{
              213,-204},{230,-204},{230,2},{283.185,2},{283.185,2.2}}, color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN04.y, busActors.pumpN04) annotation (Line(points={{213,-240},
              {224,-240},{224,-238},{230,-238},{230,2.2},{283.185,2.2}}, color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN05.y, busActors.pumpN05) annotation (Line(points={{213,-274},
              {230,-274},{230,2},{283.185,2},{283.185,2.2}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN06.y, busActors.pumpN06) annotation (Line(points={{213,-306},
              {230,-306},{230,2.2},{283.185,2.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN07.y, busActors.pumpN07) annotation (Line(points={{213,-334},
              {230,-334},{230,2.2},{283.185,2.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN08.y, busActors.pumpN08) annotation (Line(points={{213,-362},
              {230,-362},{230,2.2},{283.185,2.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hD.Y02_signal, busSensors.Y02_actual) annotation (Line(points={{
              -80.6,4.2},{-151.3,4.2},{-151.3,-7.75},{-227.78,-7.75}}, color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hD.Y09_signal, busSensors.Y09_actual) annotation (Line(points={{
              -80.6,0.2},{-151.3,0.2},{-151.3,-7.75},{-227.78,-7.75}}, color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.Y02_signal, busSensors.Y02_actual) annotation (Line(points={{
              -80.6,-25.8},{-151.3,-25.8},{-151.3,-7.75},{-227.78,-7.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.Y09_signal, busSensors.Y09_actual) annotation (Line(points={{
              -80.6,-29.8},{-151.3,-29.8},{-151.3,-7.75},{-227.78,-7.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.T_Rek, busSensors.T_Rek) annotation (Line(
            points={{-142.6,187},{-142.6,188},{-227.78,188},{-227.78,-7.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.phi_03, busSensors.T03_RelHum) annotation (
          Line(points={{-142.6,183},{-142.6,183.5},{-227.78,183.5},{-227.78,
              -7.75}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.phi_01, busSensors.T01_RelHum) annotation (
          Line(points={{-142.6,179},{-142.6,180},{-227.78,180},{-227.78,-7.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.signal_Y06, busSensors.Y06_actual)
        annotation (Line(points={{-142.6,175},{-227.78,175},{-227.78,-7.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
                -240},{280,260}})),      Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-220,-240},{280,260}})));
    end PN_intern_optimal;

    package PN_Steuerung
      extends Modelica.Icons.BasesPackage;
      model PN_Steuerung_Ebene1 "oberste Ebene der Petri-Netz-Steuerung"

        parameter Real T_Soll = 20  "Sollwert der Zuluft";
        parameter Real T_h = 3      "Temperaturhysterese der Heiz- und Kuehlschaltung";
        parameter Real phi_min = 0.3   "Minimalwert der relativen Luftfeuchte";
        parameter Real phi_max = 0.7  "Maximalwert der relativen Luftfeuchte";


        PNlib.PDBool
                 Heizen(nIn=1, nOut=1,
          maxTokens=1)                 "Petri-Stelle für Heizen" annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,64})));
        PNlib.PDBool
                 Kuehlen(nIn=1, nOut=1,
          maxTokens=1)                  "Petri-Stelle für Kühlen" annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,64})));
        PNlib.PDBool
                 Drift_HK(
          startTokens=1,
          nIn=2,
          nOut=2,
          maxTokens=1)
                  "Petri-Stelle für den Drift-Zustand, weder heizen noch kühlen"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={0,64})));
        PNlib.TD Heizen_aus(
          nIn=1,
          nOut=1,
          firingCon=T_Rek >= T_Soll + 1/3*T_h)
          "Transition zum Ausschalten der Heizung"
          annotation (Placement(transformation(extent={{-40,74},{-20,94}})));
        PNlib.TD Heizen_an(
          nOut=1,
          nIn=1,
          firingCon=T_Rek <= T_Soll - 2/3*T_h)
          "Transition zum Anschalten der Heizung"
          annotation (Placement(transformation(extent={{-20,34},{-40,54}})));
        PNlib.TD Kuehlen_an(
          nIn=1,
          nOut=1,
          firingCon=T_Rek >= T_Soll + 2/3*T_h)
          "Transition zum Anschalten der Kühlung"
          annotation (Placement(transformation(extent={{20,34},{40,54}})));
        PNlib.TD Kuehlen_aus(
          nOut=1,
          nIn=1,
          firingCon=T_Rek <= T_Soll - 1/3*T_h)
          "Transition zum Ausschalten der Kühlung"
          annotation (Placement(transformation(extent={{40,74},{20,94}})));
        PNlib.PDBool
                 Befeuchten(nIn=1, nOut=1,
          maxTokens=1)                     "Petri-Stelle für das Befeuchten"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,-8})));
        PNlib.PDBool
                 Entfeuchten(nIn=1, nOut=1,
          maxTokens=1)                      "Petri-Stelle für das Entfeuchten"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,-8})));
        PNlib.PDBool
                 Drift_BE(
          startTokens=1,
          nIn=2,
          nOut=2,
          maxTokens=1)
                  "Petri-Stelle für den Drift-Zustand, weder be- noch entfeuchten"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={0,-8})));
        PNlib.TD Befeuchten_aus(nIn=1, nOut=1,
          firingCon=phi_03 >= 0.4)
          "Transition zum Ausschalten der Befeuchtung"
          annotation (Placement(transformation(extent={{-40,2},{-20,22}})));
        PNlib.TD Befeuchten_an(nOut=1, nIn=1,
          firingCon=phi_01 >= phi_min)
          "Transition zum Anschalten der Befeuchtung"
          annotation (Placement(transformation(extent={{-20,-38},{-40,-18}})));
        PNlib.TD Entfeuchten_an(nIn=1, nOut=1,
          firingCon=phi_01 >= phi_max)
          "Transition zum Anschalten der Entfeuchtung"
          annotation (Placement(transformation(extent={{20,-38},{40,-18}})));
        PNlib.TD Entfeuchten_aus(nOut=1, nIn=1,
          firingCon=phi_01 <= 0.4 or signal_Y06 >= 1)
          "Transition zum Abschalten der Entfeuchtung"
          annotation (Placement(transformation(extent={{40,2},{20,22}})));
        Modelica.Blocks.Interfaces.RealInput T_Rek
          "Temperature Input of Temperature before recuperator after absorber, i.e. T_Rek"
          annotation (Placement(transformation(extent={{-126,50},{-86,90}})));
        Modelica.Blocks.Interfaces.RealInput phi_03
          "relative humidity before steamhumidifier"
          annotation (Placement(transformation(extent={{-126,10},{-86,50}})));
        Modelica.Blocks.Interfaces.RealInput phi_01
          "relative humidity of the supply air after steamhumidifier"
          annotation (Placement(transformation(extent={{-126,-30},{-86,10}})));
        Modelica.Blocks.Interfaces.RealInput signal_Y06 "actual valve signal of Y06"
          annotation (Placement(transformation(extent={{-126,-70},{-86,-30}})));
        Selector_global2 selector_global
          annotation (Placement(transformation(extent={{-12,-88},{8,-68}})));
        Modelica.Blocks.Interfaces.BooleanOutput ModeSelector[9]
          annotation (Placement(transformation(extent={{96,-10},{116,10}})));
      equation

        connect(Heizen_an.outPlaces[1], Heizen.inTransition[1])
          annotation (Line(points={{-34.8,44},{-60,44},{-60,53.2}}, color={0,0,0}));
        connect(Heizen.outTransition[1], Heizen_aus.inPlaces[1])
          annotation (Line(points={{-60,74.8},{-60,84},{-34.8,84}}, color={0,0,0}));
        connect(Heizen_aus.outPlaces[1], Drift_HK.inTransition[1]) annotation (Line(
              points={{-25.2,84},{-0.5,84},{-0.5,74.8}}, color={0,0,0}));
        connect(Kuehlen_aus.outPlaces[1], Drift_HK.inTransition[2])
          annotation (Line(points={{25.2,84},{0.5,84},{0.5,74.8}}, color={0,0,0}));
        connect(Drift_HK.outTransition[1], Heizen_an.inPlaces[1]) annotation (Line(
              points={{-0.5,53.2},{-0.5,44},{-25.2,44}}, color={0,0,0}));
        connect(Drift_HK.outTransition[2], Kuehlen_an.inPlaces[1])
          annotation (Line(points={{0.5,53.2},{0.5,44},{25.2,44}}, color={0,0,0}));
        connect(Kuehlen_an.outPlaces[1], Kuehlen.inTransition[1])
          annotation (Line(points={{34.8,44},{60,44},{60,53.2}}, color={0,0,0}));
        connect(Kuehlen.outTransition[1], Kuehlen_aus.inPlaces[1])
          annotation (Line(points={{60,74.8},{60,84},{34.8,84}}, color={0,0,0}));
        connect(Befeuchten_an.outPlaces[1], Befeuchten.inTransition[1]) annotation (
            Line(points={{-34.8,-28},{-60,-28},{-60,-18.8}}, color={0,0,0}));
        connect(Befeuchten.outTransition[1], Befeuchten_aus.inPlaces[1]) annotation (
            Line(points={{-60,2.8},{-60,12},{-34.8,12}},     color={0,0,0}));
        connect(Befeuchten_aus.outPlaces[1], Drift_BE.inTransition[1]) annotation (
            Line(points={{-25.2,12},{-0.5,12},{-0.5,2.8}},     color={0,0,0}));
        connect(Entfeuchten_aus.outPlaces[1], Drift_BE.inTransition[2]) annotation (
            Line(points={{25.2,12},{0.5,12},{0.5,2.8}},     color={0,0,0}));
        connect(Drift_BE.outTransition[1], Befeuchten_an.inPlaces[1]) annotation (
            Line(points={{-0.5,-18.8},{-0.5,-28},{-25.2,-28}}, color={0,0,0}));
        connect(Drift_BE.outTransition[2], Entfeuchten_an.inPlaces[1]) annotation (
            Line(points={{0.5,-18.8},{0.5,-28},{25.2,-28}}, color={0,0,0}));
        connect(Entfeuchten_an.outPlaces[1], Entfeuchten.inTransition[1])
          annotation (Line(points={{34.8,-28},{60,-28},{60,-18.8}}, color={0,0,0}));
        connect(Entfeuchten.outTransition[1], Entfeuchten_aus.inPlaces[1])
          annotation (Line(points={{60,2.8},{60,12},{34.8,12}},     color={0,0,0}));

        connect(Heizen.pd_b, selector_global.H) annotation (Line(points={{-71,
                64},{-76,64},{-76,-70},{-12.6,-70}}, color={255,0,255}));
        connect(selector_global.D_HK, Drift_HK.pd_b) annotation (Line(points={{
                -12.6,-73},{-76,-73},{-76,28},{12,28},{12,64},{11,64}}, color={
                255,0,255}));
        connect(Kuehlen.pd_b, selector_global.K) annotation (Line(points={{49,
                64},{46,64},{46,28},{-76,28},{-76,-76},{-12.6,-76}}, color={255,
                0,255}));
        connect(Befeuchten.pd_b, selector_global.B) annotation (Line(points={{
                -71,-8},{-76,-8},{-76,-80},{-12.6,-80}}, color={255,0,255}));
        connect(Drift_BE.pd_b, selector_global.D_BE) annotation (Line(points={{
                11,-8},{14,-8},{14,-50},{-76,-50},{-76,-83},{-12.6,-83}}, color=
               {255,0,255}));
        connect(Entfeuchten.pd_b, selector_global.E) annotation (Line(points={{
                49,-8},{44,-8},{44,-50},{-76,-50},{-76,-86},{-12.6,-86}}, color=
               {255,0,255}));
        connect(selector_global.ModeSelector, ModeSelector) annotation (Line(
              points={{8.6,-78},{86,-78},{86,0},{106,0}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PN_Steuerung_Ebene1;

      package Ebene2
        extends Modelica.Icons.VariantsPackage;
        model DD
          PNlib.PDBool
                   M2(
            nOut=1,
            nIn=1,
            startTokens=1,
            maxTokens=1) "Modus 2: Outside Air is Suppy Air"  annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-50,42})));
          PNlib.PDBool
                   M5(
            nIn=1,
            nOut=1,
            maxTokens=1) "Modus 5: Outside Air is Supply Air and Regeneration"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,42})));
          PNlib.TD Regeneration_An(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,72},{10,92}})));
          PNlib.TD Regeneration_Aus(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-8},{-10,12}})));
          Modelica.Blocks.Interfaces.BooleanInput RegAnf
            "Boolean Input fuer die Regenerationsanforderung"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.IntegerOutput DD_Out "Current Mode for DD"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
            y_default=2,
            expr={2,5},
            nu=2) annotation (Placement(transformation(extent={{-18,-58},{22,-38}})));
        equation

          connect(M2.outTransition[1], Regeneration_An.inPlaces[1]) annotation (Line(
              points={{-50,52.8},{-50,52.8},{-50,66},{-50,82},{-4.8,82}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_An.outPlaces[1], M5.inTransition[1]) annotation (Line(
              points={{4.8,82},{50,82},{50,66},{50,52},{50,52.8}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M5.outTransition[1], Regeneration_Aus.inPlaces[1]) annotation (Line(
              points={{50,31.2},{50,31.2},{50,2},{4.8,2}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_Aus.outPlaces[1], M2.inTransition[1]) annotation (Line(
              points={{-4.8,2},{-50,2},{-50,31.2}},
              color={0,0,0},
              smooth=Smooth.Bezier));

          connect(multiSwitch1.y, DD_Out) annotation (Line(points={{23,-48},{78,-48},{78,
                  0},{106,0}}, color={255,127,0}));
          connect(M2.pd_b, multiSwitch1.u[1]) annotation (Line(points={{-61,42},
                  {-64,42},{-64,-46.5},{-18,-46.5}}, color={255,0,255}));
          connect(M5.pd_b, multiSwitch1.u[2]) annotation (Line(points={{61,42},
                  {66,42},{66,-28},{-38,-28},{-38,-49.5},{-18,-49.5}}, color={
                  255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end DD;

        model DB "only humidification"
          PNlib.PDBool
                   M3(
            nOut=1,
            nIn=1,
            startTokens=1,
            maxTokens=1) "Mode 3: Humidification"             annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-50,42})));
          PNlib.PDBool
                   M6(
            nIn=1,
            nOut=1,
            maxTokens=1) "Mode 6: Humidification and Regeneration"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,42})));
          PNlib.TD Regeneration_An(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,72},{10,92}})));
          PNlib.TD Regeneration_Aus(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-8},{-10,12}})));
          Modelica.Blocks.Interfaces.BooleanInput RegAnf
            "Boolean Input fuer die Regenerationsanforderung"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.IntegerOutput DB_Out "Current Mode in DB"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
            nu=2,
            expr={3,6},
            y_default=3)
                  annotation (Placement(transformation(extent={{-18,-58},{22,-38}})));
        equation

          connect(M3.outTransition[1], Regeneration_An.inPlaces[1]) annotation (Line(
              points={{-50,52.8},{-50,52.8},{-50,66},{-50,82},{-4.8,82}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_An.outPlaces[1],M6. inTransition[1]) annotation (Line(
              points={{4.8,82},{50,82},{50,66},{50,52},{50,52.8}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M6.outTransition[1], Regeneration_Aus.inPlaces[1]) annotation (Line(
              points={{50,31.2},{50,31.2},{50,2},{4.8,2}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_Aus.outPlaces[1],M3. inTransition[1]) annotation (Line(
              points={{-4.8,2},{-50,2},{-50,31.2}},
              color={0,0,0},
              smooth=Smooth.Bezier));

          connect(multiSwitch1.y,DB_Out)  annotation (Line(points={{23,-48},{78,-48},{78,
                  0},{106,0}}, color={255,127,0}));
          connect(M3.pd_b, multiSwitch1.u[1]) annotation (Line(points={{-61,42},
                  {-64,42},{-64,-46.5},{-18,-46.5}}, color={255,0,255}));
          connect(M6.pd_b, multiSwitch1.u[2]) annotation (Line(points={{61,42},
                  {66,42},{66,-28},{-38,-28},{-38,-49.5},{-18,-49.5}}, color={
                  255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end DB;

        model DE "Dehumidification"
          PNlib.PDBool
                   M4(
            nOut=1,
            nIn=1,
            startTokens=1,
            maxTokens=1) "Mode 4: Dehumidification"           annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-50,42})));
          PNlib.PDBool
                   M7(
            nIn=1,
            nOut=1,
            maxTokens=1) "Mode 7: Dehumidification and Regeneration"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,42})));
          PNlib.TD Regeneration_An(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,72},{10,92}})));
          PNlib.TD Regeneration_Aus(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-8},{-10,12}})));
          Modelica.Blocks.Interfaces.BooleanInput RegAnf
            "Boolean Input fuer die Regenerationsanforderung"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.IntegerOutput DE_Out "Current Mode in DE"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
            nu=2,
            expr={4,7},
            y_default=4)
                  annotation (Placement(transformation(extent={{-18,-58},{22,-38}})));
        equation

          connect(M4.outTransition[1], Regeneration_An.inPlaces[1]) annotation (Line(
              points={{-50,52.8},{-50,52.8},{-50,66},{-50,82},{-4.8,82}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_An.outPlaces[1],M7. inTransition[1]) annotation (Line(
              points={{4.8,82},{50,82},{50,66},{50,52},{50,52.8}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M7.outTransition[1], Regeneration_Aus.inPlaces[1]) annotation (Line(
              points={{50,31.2},{50,31.2},{50,2},{4.8,2}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_Aus.outPlaces[1],M4. inTransition[1]) annotation (Line(
              points={{-4.8,2},{-50,2},{-50,31.2}},
              color={0,0,0},
              smooth=Smooth.Bezier));

          connect(multiSwitch1.y,DE_Out)  annotation (Line(points={{23,-48},{78,-48},{78,
                  0},{106,0}}, color={255,127,0}));
          connect(M4.pd_b, multiSwitch1.u[1]) annotation (Line(points={{-61,42},
                  {-64,42},{-64,-46.5},{-18,-46.5}}, color={255,0,255}));
          connect(M7.pd_b, multiSwitch1.u[2]) annotation (Line(points={{61,42},
                  {66,42},{66,-28},{-38,-28},{-38,-49.5},{-18,-49.5}}, color={
                  255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end DE;

        model HD "heating"
          PNlib.PDBool
                   M8(
            nOut=2,
            nIn=2,
            startTokens=1,
            maxTokens=1) "Mode 8: Heating with Recuperation"  annotation (Placement(
                transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-40,52})));
          PNlib.PDBool M16(
            nIn=2,
            nOut=2,
            maxTokens=1) "Mode 16: Heating with Recuperator plus Regeneration"
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=0,
                origin={-44,-20})));
          PNlib.TD Regeneration_An(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-62,8})));
          PNlib.TD Regeneration_Aus(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-20,10})));
          Modelica.Blocks.Interfaces.BooleanInput RegAnf
            "Boolean Input fuer die Regenerationsanforderung"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.IntegerOutput HD_Out "Current Mode for HD"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
            expr={8,12,16,20},
            y_default=8,
            nu=4) annotation (Placement(transformation(extent={{-20,-102},{20,
                    -82}})));
          PNlib.PDBool M20(
            nOut=2,
            nIn=2,
            maxTokens=1,
            startTokens=0)
            "Mode 20: Heating with Regeneration and Heating Coil plus Regeneration"
            annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={62,-20})));
          PNlib.PDBool M12(
            nIn=2,
            nOut=2,
            maxTokens=1) "Mode 12: Heating with Recuperation and Heating Coil"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={62,52})));
          PNlib.TD Regeneration_An1(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,10},{10,-10}},
                rotation=90,
                origin={82,16})));
          PNlib.TD Regeneration_Aus1(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,10},{-10,-10}},
                rotation=90,
                origin={36,16})));
          PNlib.TD HeatingCoil(
            nIn=1,
            nOut=1,
            firingCon=Y02_signal <= 0) "activates Heating Coil" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD HeatingCoil_Off(
            nIn=1,
            nOut=1,
            firingCon=Y09_signal <= 0) "shuts Heating Coil off" annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={0,52})));
          PNlib.TD HeatingCoil1(
            nIn=1,
            nOut=1,
            firingCon=Y02_signal <= 0) "activates Heating Coil" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={6,-20})));
          PNlib.TD HeatingCoil_Off1(
            nIn=1,
            nOut=1,
            firingCon=Y09_signal <= 0) "shuts Heating Coil off" annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={6,-52})));
          Modelica.Blocks.Interfaces.RealInput Y02_signal
            "actual position of Y02" annotation (Placement(transformation(
                  extent={{-126,62},{-86,102}})));
          Modelica.Blocks.Interfaces.RealInput Y09_signal
            "actual position of valve Y09"
            annotation (Placement(transformation(extent={{-126,22},{-86,62}})));
        equation

          connect(M8.outTransition[1], Regeneration_An.inPlaces[1]) annotation (Line(
              points={{-50.8,51.5},{-50.8,52},{-62,52},{-62,12.8}},
              color={0,0,0}));
          connect(Regeneration_An.outPlaces[1], M16.inTransition[1])
            annotation (Line(points={{-62,3.2},{-62,-18},{-54.8,-18},{-54.8,
                  -19.5}}, color={0,0,0}));
          connect(M16.outTransition[1], Regeneration_Aus.inPlaces[1])
            annotation (Line(points={{-33.2,-19.5},{-33.2,-18},{-20,-18},{-20,
                  5.2}}, color={0,0,0}));
          connect(Regeneration_Aus.outPlaces[1],M8. inTransition[1]) annotation (Line(
              points={{-20,14.8},{-20,52},{-29.2,52},{-29.2,51.5}},
              color={0,0,0}));

          connect(multiSwitch1.y,HD_Out)  annotation (Line(points={{21,-92},{94,
                  -92},{94,0},{106,0}},
                               color={255,127,0}));
          connect(M20.outTransition[1], Regeneration_An1.inPlaces[1])
            annotation (Line(points={{72.8,-19.5},{72.8,11.2},{82,11.2}}, color=
                 {0,0,0}));
          connect(Regeneration_An1.outPlaces[1], M12.inTransition[1])
            annotation (Line(points={{82,20.8},{82,58},{72.8,58},{72.8,52.5}},
                color={0,0,0}));
          connect(M12.outTransition[1], Regeneration_Aus1.inPlaces[1])
            annotation (Line(points={{51.2,52.5},{51.2,52},{36,52},{36,20.8}},
                color={0,0,0}));
          connect(Regeneration_Aus1.outPlaces[1], M20.inTransition[1])
            annotation (Line(points={{36,11.2},{51.2,11.2},{51.2,-19.5}}, color=
                 {0,0,0}));
          connect(M8.outTransition[2], HeatingCoil.inPlaces[1]) annotation (
              Line(points={{-50.8,52.5},{-60,52.5},{-60,84},{-4.8,84}}, color={
                  0,0,0}));
          connect(HeatingCoil.outPlaces[1], M12.inTransition[2]) annotation (
              Line(points={{4.8,84},{72.8,84},{72.8,51.5}}, color={0,0,0}));
          connect(M12.outTransition[2], HeatingCoil_Off.inPlaces[1])
            annotation (Line(points={{51.2,51.5},{14,51.5},{14,52},{4.8,52}},
                color={0,0,0}));
          connect(HeatingCoil_Off.outPlaces[1], M8.inTransition[2]) annotation (
             Line(points={{-4.8,52},{-14,52},{-14,52.5},{-29.2,52.5}}, color={0,
                  0,0}));
          connect(M16.outTransition[2], HeatingCoil1.inPlaces[1]) annotation (
              Line(points={{-33.2,-20.5},{-16,-20.5},{-16,-20},{1.2,-20}},
                color={0,0,0}));
          connect(HeatingCoil1.outPlaces[1], M20.inTransition[2]) annotation (
              Line(points={{10.8,-20},{40,-20},{40,-20.5},{51.2,-20.5}}, color=
                  {0,0,0}));
          connect(M20.outTransition[2], HeatingCoil_Off1.inPlaces[1])
            annotation (Line(points={{72.8,-20.5},{72,-20.5},{72,-52},{10.8,-52}},
                color={0,0,0}));
          connect(HeatingCoil_Off1.outPlaces[1], M16.inTransition[2])
            annotation (Line(points={{1.2,-52},{-66,-52},{-66,-20.5},{-54.8,
                  -20.5}}, color={0,0,0}));
          connect(M8.pd_b, multiSwitch1.u[1]) annotation (Line(points={{-40,63},
                  {-40,72},{-78,72},{-78,-89.75},{-20,-89.75}}, color={255,0,
                  255}));
          connect(M12.pd_b, multiSwitch1.u[2]) annotation (Line(points={{62,41},
                  {62,28},{-82,28},{-82,-91.25},{-20,-91.25}}, color={255,0,255}));
          connect(M16.pd_b, multiSwitch1.u[3]) annotation (Line(points={{-44,
                  -31},{-44,-92.75},{-20,-92.75}}, color={255,0,255}));
          connect(M20.pd_b, multiSwitch1.u[4]) annotation (Line(points={{62,-31},
                  {62,-72},{-46,-72},{-46,-94.25},{-20,-94.25}}, color={255,0,
                  255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end HD;

        model HB "heating and humidification"
          PNlib.PDBool
                   M9(
            nOut=2,
            nIn=2,
            startTokens=1,
            maxTokens=1) "Mode 9: Heating with Recuperation and Humidification"
                                                              annotation (Placement(
                transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-40,52})));
          PNlib.PDBool M17(
            nIn=2,
            nOut=2,
            maxTokens=1)
            "Mode 17: Heating with Recuperator plus Regeneration and Humidification"
            annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=0,
                origin={-44,-20})));
          PNlib.TD Regeneration_An(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-62,8})));
          PNlib.TD Regeneration_Aus(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                rotation=270,
                origin={-20,10})));
          Modelica.Blocks.Interfaces.BooleanInput RegAnf
            "Boolean Input fuer die Regenerationsanforderung"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.IntegerOutput HB_Out "Current Mode for HB"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
            nu=4,
            expr={9,13,17,21},
            y_default=9)
                  annotation (Placement(transformation(extent={{-20,-102},{20,
                    -82}})));
          PNlib.PDBool M21(
            nOut=2,
            nIn=2,
            maxTokens=1,
            startTokens=0)
            "Mode 21: Heating with Regeneration and Heating Coil plus Regeneration and Humidification"
            annotation (Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=180,
                origin={62,-20})));
          PNlib.PDBool M13(
            nIn=2,
            nOut=2,
            maxTokens=1)
            "Mode 13: Heating with Recuperation and Heating Coil and Humidification"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={62,52})));
          PNlib.TD Regeneration_An1(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={82,16})));
          PNlib.TD Regeneration_Aus1(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-10},{-10,10}},
                rotation=90,
                origin={36,16})));
          PNlib.TD HeatingCoil(
            nIn=1,
            nOut=1,
            firingCon=Y02_signal <= 0) "activates Heating Coil" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD HeatingCoil_Off(
            nIn=1,
            nOut=1,
            firingCon=Y09_signal <= 0) "shuts Heating Coil off" annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={0,52})));
          PNlib.TD HeatingCoil1(
            nIn=1,
            nOut=1,
            firingCon=Y02_signal <= 0) "activates Heating Coil" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={6,-20})));
          PNlib.TD HeatingCoil_Off1(
            nIn=1,
            nOut=1,
            firingCon=Y09_signal <= 0) "shuts Heating Coil off" annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={6,-52})));
          Modelica.Blocks.Interfaces.RealInput Y02_signal
            "actual position of Y02" annotation (Placement(transformation(
                  extent={{-126,62},{-86,102}})));
          Modelica.Blocks.Interfaces.RealInput Y09_signal
            "actual position of valve Y09"
            annotation (Placement(transformation(extent={{-126,22},{-86,62}})));
        equation

          connect(M9.outTransition[1], Regeneration_An.inPlaces[1]) annotation (Line(
              points={{-50.8,51.5},{-50.8,52},{-62,52},{-62,12.8}},
              color={0,0,0}));
          connect(Regeneration_An.outPlaces[1], M17.inTransition[1])
            annotation (Line(points={{-62,3.2},{-62,-18},{-54.8,-18},{-54.8,
                  -19.5}}, color={0,0,0}));
          connect(M17.outTransition[1], Regeneration_Aus.inPlaces[1])
            annotation (Line(points={{-33.2,-19.5},{-33.2,-18},{-20,-18},{-20,
                  5.2}}, color={0,0,0}));
          connect(Regeneration_Aus.outPlaces[1],M9. inTransition[1]) annotation (Line(
              points={{-20,14.8},{-20,52},{-29.2,52},{-29.2,51.5}},
              color={0,0,0}));

          connect(multiSwitch1.y,HB_Out)  annotation (Line(points={{21,-92},{94,
                  -92},{94,0},{106,0}},
                               color={255,127,0}));
          connect(M21.outTransition[1], Regeneration_An1.inPlaces[1])
            annotation (Line(points={{72.8,-19.5},{72.8,11.2},{82,11.2}}, color=
                 {0,0,0}));
          connect(Regeneration_An1.outPlaces[1], M13.inTransition[1])
            annotation (Line(points={{82,20.8},{82,58},{72.8,58},{72.8,52.5}},
                color={0,0,0}));
          connect(M13.outTransition[1], Regeneration_Aus1.inPlaces[1])
            annotation (Line(points={{51.2,52.5},{51.2,52},{36,52},{36,20.8}},
                color={0,0,0}));
          connect(Regeneration_Aus1.outPlaces[1], M21.inTransition[1])
            annotation (Line(points={{36,11.2},{51.2,11.2},{51.2,-19.5}}, color=
                 {0,0,0}));
          connect(M9.outTransition[2], HeatingCoil.inPlaces[1]) annotation (
              Line(points={{-50.8,52.5},{-60,52.5},{-60,84},{-4.8,84}}, color={
                  0,0,0}));
          connect(HeatingCoil.outPlaces[1], M13.inTransition[2]) annotation (
              Line(points={{4.8,84},{72.8,84},{72.8,51.5}}, color={0,0,0}));
          connect(M13.outTransition[2], HeatingCoil_Off.inPlaces[1])
            annotation (Line(points={{51.2,51.5},{14,51.5},{14,52},{4.8,52}},
                color={0,0,0}));
          connect(HeatingCoil_Off.outPlaces[1], M9.inTransition[2]) annotation (
             Line(points={{-4.8,52},{-14,52},{-14,52.5},{-29.2,52.5}}, color={0,
                  0,0}));
          connect(M17.outTransition[2], HeatingCoil1.inPlaces[1]) annotation (
              Line(points={{-33.2,-20.5},{-16,-20.5},{-16,-20},{1.2,-20}},
                color={0,0,0}));
          connect(HeatingCoil1.outPlaces[1], M21.inTransition[2]) annotation (
              Line(points={{10.8,-20},{40,-20},{40,-20.5},{51.2,-20.5}}, color=
                  {0,0,0}));
          connect(M21.outTransition[2], HeatingCoil_Off1.inPlaces[1])
            annotation (Line(points={{72.8,-20.5},{72,-20.5},{72,-52},{10.8,-52}},
                color={0,0,0}));
          connect(HeatingCoil_Off1.outPlaces[1], M17.inTransition[2])
            annotation (Line(points={{1.2,-52},{-66,-52},{-66,-20.5},{-54.8,
                  -20.5}}, color={0,0,0}));
          connect(M9.pd_b, multiSwitch1.u[1]) annotation (Line(points={{-40,63},
                  {-40,72},{-78,72},{-78,-89.75},{-20,-89.75}}, color={255,0,
                  255}));
          connect(M13.pd_b, multiSwitch1.u[2]) annotation (Line(points={{62,41},
                  {62,28},{-82,28},{-82,-91.25},{-20,-91.25}}, color={255,0,255}));
          connect(M17.pd_b, multiSwitch1.u[3]) annotation (Line(points={{-44,
                  -31},{-44,-92.75},{-20,-92.75}}, color={255,0,255}));
          connect(M21.pd_b, multiSwitch1.u[4]) annotation (Line(points={{62,-31},
                  {62,-72},{-46,-72},{-46,-94.25},{-20,-94.25}}, color={255,0,
                  255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end HB;

        model HE "Heating and Dehumidification"
          PNlib.PDBool M14(
            nOut=1,
            nIn=1,
            startTokens=1,
            maxTokens=1) "Mode 14: Heating and Dehumidification" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-50,42})));
          PNlib.PDBool M22(
            nIn=1,
            nOut=1,
            maxTokens=1)
            "Mode 22: Heating and Dehumidification and Regeneration"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,42})));
          PNlib.TD Regeneration_An(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,72},{10,92}})));
          PNlib.TD Regeneration_Aus(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-8},{-10,12}})));
          Modelica.Blocks.Interfaces.BooleanInput RegAnf
            "Boolean Input fuer die Regenerationsanforderung"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.IntegerOutput HE_Out "Current Mode for HE"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
            nu=2,
            expr={14,22},
            y_default=14)
                  annotation (Placement(transformation(extent={{-18,-58},{22,-38}})));
        equation

          connect(M14.outTransition[1], Regeneration_An.inPlaces[1])
            annotation (Line(
              points={{-50,52.8},{-50,52.8},{-50,66},{-50,82},{-4.8,82}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_An.outPlaces[1], M22.inTransition[1])
            annotation (Line(
              points={{4.8,82},{50,82},{50,66},{50,52},{50,52.8}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M22.outTransition[1], Regeneration_Aus.inPlaces[1])
            annotation (Line(
              points={{50,31.2},{50,31.2},{50,2},{4.8,2}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_Aus.outPlaces[1], M14.inTransition[1])
            annotation (Line(
              points={{-4.8,2},{-50,2},{-50,31.2}},
              color={0,0,0},
              smooth=Smooth.Bezier));

          connect(multiSwitch1.y,HE_Out)  annotation (Line(points={{23,-48},{78,-48},{78,
                  0},{106,0}}, color={255,127,0}));
          connect(M14.pd_b, multiSwitch1.u[1]) annotation (Line(points={{-61,42},
                  {-64,42},{-64,-46.5},{-18,-46.5}}, color={255,0,255}));
          connect(M22.pd_b, multiSwitch1.u[2]) annotation (Line(points={{61,42},
                  {66,42},{66,-28},{-38,-28},{-38,-49.5},{-18,-49.5}}, color={
                  255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end HE;

        model KD "Cooling"
          PNlib.PDBool M10(
            nOut=1,
            nIn=1,
            startTokens=1,
            maxTokens=1) "Mode 10: Cooling" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-50,42})));
          PNlib.PDBool M18(
            nIn=1,
            nOut=1,
            maxTokens=1) "Mode 18: Cooling and Regeneration" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,42})));
          PNlib.TD Regeneration_An(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,72},{10,92}})));
          PNlib.TD Regeneration_Aus(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-8},{-10,12}})));
          Modelica.Blocks.Interfaces.BooleanInput RegAnf
            "Boolean Input fuer die Regenerationsanforderung"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.IntegerOutput KD_Out "Current Mode for KD"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
            nu=2,
            expr={10,18},
            y_default=10)
                  annotation (Placement(transformation(extent={{-18,-58},{22,-38}})));
        equation

          connect(M10.outTransition[1], Regeneration_An.inPlaces[1])
            annotation (Line(
              points={{-50,52.8},{-50,52.8},{-50,66},{-50,82},{-4.8,82}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_An.outPlaces[1], M18.inTransition[1])
            annotation (Line(
              points={{4.8,82},{50,82},{50,66},{50,52},{50,52.8}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M18.outTransition[1], Regeneration_Aus.inPlaces[1])
            annotation (Line(
              points={{50,31.2},{50,31.2},{50,2},{4.8,2}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_Aus.outPlaces[1], M10.inTransition[1])
            annotation (Line(
              points={{-4.8,2},{-50,2},{-50,31.2}},
              color={0,0,0},
              smooth=Smooth.Bezier));

          connect(multiSwitch1.y,KD_Out)  annotation (Line(points={{23,-48},{78,-48},{78,
                  0},{106,0}}, color={255,127,0}));
          connect(M10.pd_b, multiSwitch1.u[1]) annotation (Line(points={{-61,42},
                  {-64,42},{-64,-46.5},{-18,-46.5}}, color={255,0,255}));
          connect(M18.pd_b, multiSwitch1.u[2]) annotation (Line(points={{61,42},
                  {66,42},{66,-28},{-38,-28},{-38,-49.5},{-18,-49.5}}, color={
                  255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end KD;

        model KB "Cooling and Humidification"
          PNlib.PDBool M11(
            nOut=1,
            nIn=1,
            startTokens=1,
            maxTokens=1) "Mode 11: Cooling and Humidification" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-50,42})));
          PNlib.PDBool M19(
            nIn=1,
            nOut=1,
            maxTokens=1) "Mode 19: Cooling, Humidification and Regeneration"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,42})));
          PNlib.TD Regeneration_An(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,72},{10,92}})));
          PNlib.TD Regeneration_Aus(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-8},{-10,12}})));
          Modelica.Blocks.Interfaces.BooleanInput RegAnf
            "Boolean Input fuer die Regenerationsanforderung"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.IntegerOutput KB_Out "Current Mode for KB"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
            nu=2,
            expr={11,19},
            y_default=11)
                  annotation (Placement(transformation(extent={{-18,-58},{22,-38}})));
        equation

          connect(M11.outTransition[1], Regeneration_An.inPlaces[1])
            annotation (Line(
              points={{-50,52.8},{-50,52.8},{-50,66},{-50,82},{-4.8,82}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_An.outPlaces[1], M19.inTransition[1])
            annotation (Line(
              points={{4.8,82},{50,82},{50,66},{50,52},{50,52.8}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M19.outTransition[1], Regeneration_Aus.inPlaces[1])
            annotation (Line(
              points={{50,31.2},{50,31.2},{50,2},{4.8,2}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_Aus.outPlaces[1], M11.inTransition[1])
            annotation (Line(
              points={{-4.8,2},{-50,2},{-50,31.2}},
              color={0,0,0},
              smooth=Smooth.Bezier));

          connect(multiSwitch1.y,KB_Out)  annotation (Line(points={{23,-48},{78,-48},{78,
                  0},{106,0}}, color={255,127,0}));
          connect(M11.pd_b, multiSwitch1.u[1]) annotation (Line(points={{-61,42},
                  {-64,42},{-64,-46.5},{-18,-46.5}}, color={255,0,255}));
          connect(M19.pd_b, multiSwitch1.u[2]) annotation (Line(points={{61,42},
                  {66,42},{66,-28},{-38,-28},{-38,-49.5},{-18,-49.5}}, color={
                  255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end KB;

        model KE "Cooling and Dehumidification"
          PNlib.PDBool M15(
            nOut=1,
            nIn=1,
            startTokens=1,
            maxTokens=1) "Mode 15: Cooling and Dehumidification" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-50,42})));
          PNlib.PDBool M23(
            nIn=1,
            nOut=1,
            maxTokens=1) "Mode 23: Cooling, Dehumidification and Regeneration"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,42})));
          PNlib.TD Regeneration_An(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "Schaltet Regeneration ein"
            annotation (Placement(transformation(extent={{-10,72},{10,92}})));
          PNlib.TD Regeneration_Aus(
            nIn=1,
            nOut=1,
            firingCon=RegAnf) "schaltet Regeneration aus"
            annotation (Placement(transformation(extent={{10,-8},{-10,12}})));
          Modelica.Blocks.Interfaces.BooleanInput RegAnf
            "Boolean Input fuer die Regenerationsanforderung"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.IntegerOutput KE_Out "Current Mode for KE"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
            nu=2,
            expr={15,23},
            y_default=15)
                  annotation (Placement(transformation(extent={{-18,-58},{22,-38}})));
        equation

          connect(M15.outTransition[1], Regeneration_An.inPlaces[1])
            annotation (Line(
              points={{-50,52.8},{-50,52.8},{-50,66},{-50,82},{-4.8,82}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_An.outPlaces[1], M23.inTransition[1])
            annotation (Line(
              points={{4.8,82},{50,82},{50,66},{50,52},{50,52.8}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M23.outTransition[1], Regeneration_Aus.inPlaces[1])
            annotation (Line(
              points={{50,31.2},{50,31.2},{50,2},{4.8,2}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_Aus.outPlaces[1], M15.inTransition[1])
            annotation (Line(
              points={{-4.8,2},{-50,2},{-50,31.2}},
              color={0,0,0},
              smooth=Smooth.Bezier));

          connect(multiSwitch1.y,KE_Out)  annotation (Line(points={{23,-48},{78,-48},{78,
                  0},{106,0}}, color={255,127,0}));
          connect(M15.pd_b, multiSwitch1.u[1]) annotation (Line(points={{-61,42},
                  {-64,42},{-64,-46.5},{-18,-46.5}}, color={255,0,255}));
          connect(M23.pd_b, multiSwitch1.u[2]) annotation (Line(points={{61,42},
                  {66,42},{66,-28},{-38,-28},{-38,-49.5},{-18,-49.5}}, color={
                  255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end KE;
      end Ebene2;

      package Auswertemodule
        extends Modelica.Icons.UtilitiesPackage;
        model Y02_evaluation "evaluates the PN of Y02 and gives output value"

          parameter Real T_Set = 20;

          Modelica.Blocks.Interfaces.BooleanInput Y02_closed
            "Token value of Y02_closed"
            annotation (Placement(transformation(extent={{-128,40},{-88,80}})));
          Modelica.Blocks.Interfaces.BooleanInput Y02_open "Token value of Y02_open"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
          Modelica.Blocks.Interfaces.BooleanInput Y02_control
            "Token value of Y02_control"
            annotation (Placement(transformation(extent={{-126,-80},{-86,-40}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{-16,50},{4,70}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{24,-10},{44,10}})));
          Modelica.Blocks.Logical.Switch switch3
            annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
          Modelica.Blocks.Sources.Constant closed(k=0)
            "valve value for closed valve"
            annotation (Placement(transformation(extent={{-46,74},{-26,94}})));
          Modelica.Blocks.Sources.Constant open(k=1)
            "valve value for open valve"
            annotation (Placement(transformation(extent={{-72,22},{-52,42}})));
          Modelica.Blocks.Continuous.LimPID PID(yMax=1, yMin=0)
            annotation (Placement(transformation(extent={{-42,-40},{-22,-20}})));
          Modelica.Blocks.Sources.Constant T_Soll(k=T_Set)
            "Set value for the measurement for Y02"
            annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
          Modelica.Blocks.Interfaces.RealInput T_measure
            "Measured value for T01" annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=90,
                origin={-32,-104})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            "valve is closed when there is no token in the PN"
            annotation (Placement(transformation(extent={{44,30},{24,50}})));
        equation
          connect(T_Soll.y, PID.u_s)
            annotation (Line(points={{-51,-30},{-44,-30}}, color={0,0,127}));
          connect(T_measure, PID.u_m)
            annotation (Line(points={{-32,-104},{-32,-42}}, color={0,0,127}));
          connect(closed.y, switch1.u1) annotation (Line(points={{-25,84},{-18,
                  84},{-18,68}}, color={0,0,127}));
          connect(open.y, switch2.u1) annotation (Line(points={{-51,32},{-26,32},
                  {-26,8},{22,8}}, color={0,0,127}));
          connect(PID.y, switch3.u1) annotation (Line(points={{-21,-30},{30,-30},
                  {30,-52},{58,-52}}, color={0,0,127}));
          connect(switch3.y, y) annotation (Line(points={{81,-60},{84,-60},{84,
                  0},{106,0}}, color={0,0,127}));
          connect(switch2.y, switch3.u3) annotation (Line(points={{45,0},{50,0},
                  {50,-68},{58,-68}}, color={0,0,127}));
          connect(switch1.y, switch2.u3) annotation (Line(points={{5,60},{10,60},
                  {10,-8},{22,-8}}, color={0,0,127}));
          connect(security_closed.y, switch1.u3) annotation (Line(points={{23,
                  40},{-24,40},{-24,52},{-18,52}}, color={0,0,127}));
          connect(Y02_closed, switch1.u2)
            annotation (Line(points={{-108,60},{-18,60}}, color={255,0,255}));
          connect(Y02_open, switch2.u2)
            annotation (Line(points={{-108,0},{22,0}}, color={255,0,255}));
          connect(Y02_control, switch3.u2)
            annotation (Line(points={{-106,-60},{58,-60}}, color={255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false), graphics={
                  Rectangle(
                  extent={{12,76},{76,58}},
                  lineColor={0,0,0},
                  fillColor={244,125,35},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{16,82},{70,52}},
                  lineColor={0,0,0},
                  textString="Technically you can delete this switch")}));
        end Y02_evaluation;
      end Auswertemodule;

      package Aktoren
        extends Modelica.Icons.InterfacesPackage;

        model Y02
          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
          parameter Real T_Set = 20 "Temperature set value for T01";


          PNlib.PDBool
                   Y02_closed(
            nOut=2,
            nIn=2,
            startTokens=1) "valve Y02 closed, output value 0" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool
                   Y02_open(nIn=2, nOut=2) "valve Y02 open, output value 1" annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.PDBool
                   Y02_control(nIn=2, nOut=2)
            "Y02 is in controlled modus with a PID controller" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={0,-12})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=M_in == 1 or M_in == 2 or M_in == 3
            or M_in == 4 or M_in == 5 or M_in == 6 or M_in == 7) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(       nOut=1,
            nIn=1,
            firingCon=M_in == 1)     annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          PNlib.TD T3(nIn=1, nOut=1,
            firingCon=M_in == 8 or M_in == 9 or M_in == 10 or M_in == 11 or M_in == 12
                 or M_in == 13 or M_in == 14 or M_in == 15 or M_in == 16 or M_in == 17
                 or M_in == 18 or M_in == 19 or M_in == 20 or M_in == 21 or M_in == 22
                 or M_in == 23)      annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={68,14})));
          PNlib.TD T4(nIn=1, nOut=1,
            firingCon=M_in == 1 or M_in == 2 or M_in == 3 or M_in == 4 or M_in == 5 or
                M_in == 6 or M_in == 7)
                                     annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={28,14})));
          PNlib.TD T5(nIn=1, nOut=1,
            firingCon=M_in == 1)     annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={-28,14})));
          PNlib.TD T6(nOut=1, nIn=1,
            firingCon=M_in == 8 or M_in == 9 or M_in == 10 or M_in == 11 or M_in == 12 or M_in == 13 or M_in == 14 or M_in == 15 or M_in == 16 or M_in == 17 or M_in == 18 or M_in == 19 or M_in == 20 or M_in == 21 or M_in == 22 or M_in == 23)     annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=90,
                origin={-66,14})));
          Modelica.Blocks.Interfaces.RealOutput setValue_Y02 "set value for valve Y02"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Auswertemodule.Y02_evaluation y02_evaluation(T_Set=T_Set)
            annotation (Placement(transformation(extent={{-40,-72},{-20,-52}})));
          Modelica.Blocks.Interfaces.RealInput T_measure
            "Measured value for T01" annotation (Placement(transformation(
                  extent={{-128,-98},{-88,-58}})));
        equation
          connect(Y02_closed.outTransition[1], T1.inPlaces[1]) annotation (Line(
              points={{-43.5,78.8},{-43.5,84},{-4.8,84}},
              color={0,0,0}));
          connect(T1.outPlaces[1], Y02_open.inTransition[1]) annotation (Line(
              points={{4.8,84},{47.5,84},{47.5,78.8}},
              color={0,0,0}));
          connect(T2.outPlaces[1], Y02_closed.inTransition[1]) annotation (Line(
              points={{-4.8,52},{-43.5,52},{-43.5,57.2}},
              color={0,0,0}));
          connect(Y02_open.outTransition[1], T3.inPlaces[1]) annotation (Line(
              points={{47.5,57.2},{47.5,38},{68,38},{68,18.8}},
              color={0,0,0}));
          connect(T3.outPlaces[1], Y02_control.inTransition[1]) annotation (Line(
              points={{68,9.2},{68,-26},{0.5,-26},{0.5,-22.8}},
              color={0,0,0}));
          connect(Y02_control.outTransition[1], T4.inPlaces[1]) annotation (Line(
              points={{0.5,-1.2},{0.5,4},{28,4},{28,9.2}},
              color={0,0,0}));
          connect(T4.outPlaces[1], Y02_open.inTransition[2]) annotation (Line(
              points={{28,18.8},{28,92},{48,92},{48.5,78.8}},
              color={0,0,0}));
          connect(T6.outPlaces[1], Y02_control.inTransition[2]) annotation (Line(
              points={{-66,9.2},{-66,-26},{-0.5,-26},{-0.5,-22.8}},
              color={0,0,0}));
          connect(Y02_control.outTransition[2], T5.inPlaces[1]) annotation (Line(
              points={{-0.5,-1.2},{-0.5,4},{-28,4},{-28,9.2}},
              color={0,0,0}));
          connect(T5.outPlaces[1], Y02_closed.inTransition[2]) annotation (Line(
              points={{-28,18.8},{-28,18.8},{-28,40},{-44.5,40},{-44.5,57.2}},
              color={0,0,0}));
          connect(Y02_closed.outTransition[2], T6.inPlaces[1]) annotation (Line(
              points={{-44.5,78.8},{-44.5,82},{-66,82},{-66,18.8}},
              color={0,0,0}));
          connect(Y02_open.outTransition[2], T2.inPlaces[1]) annotation (Line(
              points={{48.5,57.2},{48.5,52},{4.8,52}},
              color={0,0,0}));
          connect(y02_evaluation.y, setValue_Y02) annotation (Line(points={{
                  -19.4,-62},{94,-62},{94,0},{106,0}}, color={0,0,127}));
          connect(T_measure, y02_evaluation.T_measure) annotation (Line(points=
                  {{-108,-78},{-33.2,-78},{-33.2,-72.4}}, color={0,0,127}));
          connect(Y02_closed.pd_b, y02_evaluation.Y02_closed) annotation (Line(
                points={{-55,68},{-70,68},{-70,-56},{-40.8,-56}}, color={255,0,
                  255}));
          connect(Y02_open.pd_b, y02_evaluation.Y02_open) annotation (Line(
                points={{59,68},{86,68},{86,-94},{-56,-94},{-56,-62},{-40.8,-62}},
                color={255,0,255}));
          connect(Y02_control.pd_b, y02_evaluation.Y02_control) annotation (
              Line(points={{-11,-12},{-52,-12},{-52,-68},{-40.6,-68}}, color={
                  255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end Y02;

        model Y03 "valve opening output of valve Y03"
          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));
          parameter Real T_Set = 20 "Temperature set value for T01";

          PNlib.PDBool
                   Y02_closed(
            nOut=2,
            nIn=2,
            startTokens=1) "valve Y02 closed, output value 0" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool
                   Y02_open(nIn=2, nOut=2) "valve Y02 open, output value 1" annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.PDBool
                   Y02_control(nIn=2, nOut=2)
            "Y02 is in controlled modus with a PID controller" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={0,-12})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=M_in == 1 or M_in == 2 or M_in == 3
            or M_in == 4 or M_in == 5 or M_in == 6 or M_in == 7) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(       nOut=1,
            nIn=1,
            firingCon=M_in == 1)     annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          PNlib.TD T3(nIn=1, nOut=1,
            firingCon=M_in == 8 or M_in == 9 or M_in == 10 or M_in == 11 or M_in == 12
                 or M_in == 13 or M_in == 14 or M_in == 15 or M_in == 16 or M_in == 17
                 or M_in == 18 or M_in == 19 or M_in == 20 or M_in == 21 or M_in == 22
                 or M_in == 23)      annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={68,14})));
          PNlib.TD T4(nIn=1, nOut=1,
            firingCon=M_in == 1 or M_in == 2 or M_in == 3 or M_in == 4 or M_in == 5 or
                M_in == 6 or M_in == 7)
                                     annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={28,14})));
          PNlib.TD T5(nIn=1, nOut=1,
            firingCon=M_in == 1)     annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={-28,14})));
          PNlib.TD T6(nOut=1, nIn=1,
            firingCon=M_in == 8 or M_in == 9 or M_in == 10 or M_in == 11 or M_in == 12 or M_in == 13 or M_in == 14 or M_in == 15 or M_in == 16 or M_in == 17 or M_in == 18 or M_in == 19 or M_in == 20 or M_in == 21 or M_in == 22 or M_in == 23)     annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=90,
                origin={-66,14})));
          Modelica.Blocks.Interfaces.RealOutput setValue_Y02 "set value for valve Y02"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Auswertemodule.Y02_evaluation y02_evaluation(T_Set=T_Set)
            annotation (Placement(transformation(extent={{-40,-72},{-20,-52}})));
          Modelica.Blocks.Interfaces.RealInput T_measure
            "Measured value for T01" annotation (Placement(transformation(
                  extent={{-128,-98},{-88,-58}})));
        equation
          connect(Y02_closed.outTransition[1], T1.inPlaces[1]) annotation (Line(
              points={{-43.5,78.8},{-43.5,84},{-4.8,84}},
              color={0,0,0}));
          connect(T1.outPlaces[1], Y02_open.inTransition[1]) annotation (Line(
              points={{4.8,84},{47.5,84},{47.5,78.8}},
              color={0,0,0}));
          connect(T2.outPlaces[1], Y02_closed.inTransition[1]) annotation (Line(
              points={{-4.8,52},{-43.5,52},{-43.5,57.2}},
              color={0,0,0}));
          connect(Y02_open.outTransition[1], T3.inPlaces[1]) annotation (Line(
              points={{47.5,57.2},{47.5,38},{68,38},{68,18.8}},
              color={0,0,0}));
          connect(T3.outPlaces[1], Y02_control.inTransition[1]) annotation (Line(
              points={{68,9.2},{68,-26},{0.5,-26},{0.5,-22.8}},
              color={0,0,0}));
          connect(Y02_control.outTransition[1], T4.inPlaces[1]) annotation (Line(
              points={{0.5,-1.2},{0.5,4},{28,4},{28,9.2}},
              color={0,0,0}));
          connect(T4.outPlaces[1], Y02_open.inTransition[2]) annotation (Line(
              points={{28,18.8},{28,92},{48,92},{48.5,78.8}},
              color={0,0,0}));
          connect(T6.outPlaces[1], Y02_control.inTransition[2]) annotation (Line(
              points={{-66,9.2},{-66,-26},{-0.5,-26},{-0.5,-22.8}},
              color={0,0,0}));
          connect(Y02_control.outTransition[2], T5.inPlaces[1]) annotation (Line(
              points={{-0.5,-1.2},{-0.5,4},{-28,4},{-28,9.2}},
              color={0,0,0}));
          connect(T5.outPlaces[1], Y02_closed.inTransition[2]) annotation (Line(
              points={{-28,18.8},{-28,18.8},{-28,40},{-44.5,40},{-44.5,57.2}},
              color={0,0,0}));
          connect(Y02_closed.outTransition[2], T6.inPlaces[1]) annotation (Line(
              points={{-44.5,78.8},{-44.5,82},{-66,82},{-66,18.8}},
              color={0,0,0}));
          connect(Y02_open.outTransition[2], T2.inPlaces[1]) annotation (Line(
              points={{48.5,57.2},{48.5,52},{4.8,52}},
              color={0,0,0}));
          connect(y02_evaluation.y, setValue_Y02) annotation (Line(points={{
                  -19.4,-62},{94,-62},{94,0},{106,0}}, color={0,0,127}));
          connect(T_measure, y02_evaluation.T_measure) annotation (Line(points=
                  {{-108,-78},{-33.2,-78},{-33.2,-72.4}}, color={0,0,127}));
          connect(Y02_closed.pd_b, y02_evaluation.Y02_closed) annotation (Line(
                points={{-55,68},{-70,68},{-70,-56},{-40.8,-56}}, color={255,0,
                  255}));
          connect(Y02_open.pd_b, y02_evaluation.Y02_open) annotation (Line(
                points={{59,68},{86,68},{86,-94},{-56,-94},{-56,-62},{-40.8,-62}},
                color={255,0,255}));
          connect(Y02_control.pd_b, y02_evaluation.Y02_control) annotation (
              Line(points={{-11,-12},{-52,-12},{-52,-68},{-40.6,-68}}, color={
                  255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end Y03;
      end Aktoren;

      model Selector_2 "selektiert den aktiven Modus"

        parameter Integer Modus_u1= 1;
        parameter Integer Modus_u2= 1;

        Modelica.Blocks.Interfaces.IntegerInput M_u1 "Input value of modus u1"
          annotation (Placement(transformation(extent={{-124,30},{-84,70}})));
        Modelica.Blocks.Interfaces.IntegerInput M_u2 "Input value of modus u2"
          annotation (Placement(transformation(extent={{-124,-70},{-84,-30}})));
        Modelica.Blocks.Interfaces.IntegerOutput y
          annotation (Placement(transformation(extent={{96,-10},{116,10}})));

      equation

      y = if M_u1 == 1 then Modus_u1
                else if M_u2 == 1 then Modus_u2
                else 1;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Selector_2;

      model Selector_4 "selektiert den aktiven Modus"

        parameter Integer Modus_u1= 1;
        parameter Integer Modus_u2= 1;
        parameter Integer Modus_u3= 1;
        parameter Integer Modus_u4= 1;

        Modelica.Blocks.Interfaces.IntegerInput M_u1 "Input value of modus u1"
          annotation (Placement(transformation(extent={{-124,50},{-84,90}})));
        Modelica.Blocks.Interfaces.IntegerInput M_u2 "Input value of modus u2"
          annotation (Placement(transformation(extent={{-124,10},{-84,50}})));
        Modelica.Blocks.Interfaces.IntegerOutput y
          annotation (Placement(transformation(extent={{96,-10},{116,10}})));
        Modelica.Blocks.Interfaces.IntegerInput M_u3 "Input value of modus u2"
          annotation (Placement(transformation(extent={{-124,-50},{-84,-10}})));
        Modelica.Blocks.Interfaces.IntegerInput M_u4 "Input value of modus u2"
          annotation (Placement(transformation(extent={{-124,-90},{-84,-50}})));

      equation

      y = if M_u1 == 1 then Modus_u1
      else if M_u2 == 1 then Modus_u2
      else if M_u3 == 1 then Modus_u3
        else if M_u4 == 1 then Modus_u4
                else 1;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Selector_4;

      model Selector_global "selektiert den aktiven Modus"


        Modelica.Blocks.Interfaces.BooleanOutput DD
          annotation (Placement(transformation(extent={{94,70},{114,90}})));
        Modelica.Blocks.Interfaces.BooleanOutput DB
          annotation (Placement(transformation(extent={{94,52},{114,72}})));
        Modelica.Blocks.Interfaces.BooleanOutput DE
          annotation (Placement(transformation(extent={{94,34},{114,54}})));
        Modelica.Blocks.Interfaces.BooleanOutput HD
          annotation (Placement(transformation(extent={{94,16},{114,36}})));
        Modelica.Blocks.Interfaces.BooleanOutput HB
          annotation (Placement(transformation(extent={{94,-2},{114,18}})));
        Modelica.Blocks.Interfaces.BooleanOutput HE
          annotation (Placement(transformation(extent={{94,-20},{114,0}})));
        Modelica.Blocks.Interfaces.BooleanOutput KD
          annotation (Placement(transformation(extent={{94,-40},{114,-20}})));
        Modelica.Blocks.Interfaces.BooleanOutput KB
          annotation (Placement(transformation(extent={{94,-60},{114,-40}})));
        Modelica.Blocks.Interfaces.BooleanOutput KE
          annotation (Placement(transformation(extent={{94,-80},{114,-60}})));

        Modelica.Blocks.Interfaces.BooleanInput H
          annotation (Placement(transformation(extent={{-126,60},{-86,100}})));
        Modelica.Blocks.Interfaces.BooleanInput D_HK
          annotation (Placement(transformation(extent={{-126,30},{-86,70}})));
        Modelica.Blocks.Interfaces.BooleanInput K
          annotation (Placement(transformation(extent={{-126,0},{-86,40}})));
        Modelica.Blocks.Interfaces.BooleanInput B
          annotation (Placement(transformation(extent={{-126,-40},{-86,0}})));
        Modelica.Blocks.Interfaces.BooleanInput D_BE
          annotation (Placement(transformation(extent={{-126,-70},{-86,-30}})));
        Modelica.Blocks.Interfaces.BooleanInput E
          annotation (Placement(transformation(extent={{-126,-100},{-86,-60}})));
      equation

      if D_HK and D_BE then
        DD = true; else DD= false; end if;
      if D_HK and B then
        DB = true; else DB= false; end if;
      if D_HK and E then
        DE = true; else DE= false; end if;
      if H and D_BE then
        HD = true; else HD= false; end if;
      if H and B then
        HB = true; else HB= false; end if;
      if H and E then
        HE = true; else HE= false; end if;
      if K and D_BE then
        KD = true; else KD= false; end if;
      if K and B then
        KB = true; else KB= false; end if;
      if K and E then
        KE = true; else KE= false; end if;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Selector_global;

      model Selector_global2 "selektiert den aktiven Modus"

        Modelica.Blocks.Interfaces.BooleanOutput ModeSelector[9]
          annotation (Placement(transformation(extent={{96,-10},{116,10}})));

        Modelica.Blocks.Interfaces.BooleanInput H
          annotation (Placement(transformation(extent={{-126,60},{-86,100}})));
        Modelica.Blocks.Interfaces.BooleanInput D_HK
          annotation (Placement(transformation(extent={{-126,30},{-86,70}})));
        Modelica.Blocks.Interfaces.BooleanInput K
          annotation (Placement(transformation(extent={{-126,0},{-86,40}})));
        Modelica.Blocks.Interfaces.BooleanInput B
          annotation (Placement(transformation(extent={{-126,-40},{-86,0}})));
        Modelica.Blocks.Interfaces.BooleanInput D_BE
          annotation (Placement(transformation(extent={{-126,-70},{-86,-30}})));
        Modelica.Blocks.Interfaces.BooleanInput E
          annotation (Placement(transformation(extent={{-126,-100},{-86,-60}})));
      equation

      if D_HK and D_BE then
          ModeSelector[1] = true;
                   else
          ModeSelector[1] = false;
                                   end if;
      if D_HK and B then
        ModeSelector[2] = true; else ModeSelector[2]= false; end if;
      if D_HK and E then
        ModeSelector[3] = true; else ModeSelector[3]= false; end if;
      if H and D_BE then
        ModeSelector[4] = true; else ModeSelector[4]= false; end if;
      if H and B then
        ModeSelector[5] = true; else ModeSelector[5]= false; end if;
      if H and E then
        ModeSelector[6] = true; else ModeSelector[6]= false; end if;
      if K and D_BE then
        ModeSelector[7] = true; else ModeSelector[7]= false; end if;
      if K and B then
        ModeSelector[8] = true; else ModeSelector[8]= false; end if;
      if K and E then
        ModeSelector[9] = true; else ModeSelector[9]= false; end if;

        connect(ModeSelector, ModeSelector)
          annotation (Line(points={{106,0},{106,0}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false), graphics={Text(
                extent={{-72,84},{86,-86}},
                lineColor={28,108,200},
                textString="PN erstellen")}));
      end Selector_global2;

      model ModeSwitch
        "gives the correct actorsetting according to the chosen mode"

        Integer ModeArray[9];

        Modelica.Blocks.Interfaces.IntegerInput DD
          annotation (Placement(transformation(extent={{-210,152},{-170,192}})));
        Modelica.Blocks.Interfaces.IntegerInput DB
          annotation (Placement(transformation(extent={{-210,104},{-170,144}})));
        Modelica.Blocks.Interfaces.IntegerInput DE
          annotation (Placement(transformation(extent={{-210,54},{-170,94}})));
        Modelica.Blocks.Interfaces.IntegerInput HD
          annotation (Placement(transformation(extent={{-210,6},{-170,46}})));
        Modelica.Blocks.Interfaces.IntegerInput HB
          annotation (Placement(transformation(extent={{-210,-40},{-170,0}})));
        Modelica.Blocks.Interfaces.IntegerInput HE
          annotation (Placement(transformation(extent={{-210,-92},{-170,-52}})));
        Modelica.Blocks.Interfaces.IntegerInput KD
          annotation (Placement(transformation(extent={{-210,-138},{-170,-98}})));
        Modelica.Blocks.Interfaces.IntegerInput KB
          annotation (Placement(transformation(extent={{-210,-188},{-170,-148}})));
        Modelica.Blocks.Interfaces.IntegerInput KE
          annotation (Placement(transformation(extent={{-210,-240},{-170,-200}})));
        Modelica.Blocks.Interfaces.IntegerOutput CurrentMode
          "Gives the value of the current mode"
          annotation (Placement(transformation(extent={{176,-10},{196,10}})));
        Modelica.Blocks.Interfaces.BooleanVectorInput BooleanModeIn[9]
          annotation (Placement(transformation(extent={{-20,158},{20,198}})));
      equation
        ModeArray[1]=DD;
        ModeArray[2]=DB;
        ModeArray[3]=DE;
        ModeArray[4]=HD;
        ModeArray[5]=HB;
        ModeArray[6]=HE;
        ModeArray[7]=KD;
        ModeArray[8]=KB;
        ModeArray[9]=KE;
        CurrentMode = ModeArray[Modelica.Math.BooleanVectors.firstTrueIndex(
          BooleanModeIn)];

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
                  -240},{180,180}})),
                                Diagram(coordinateSystem(preserveAspectRatio=false,
                extent={{-180,-240},{180,180}})));
      end ModeSwitch;

      expandable connector BusMode "Bus connector for the mode booleans"
        extends Modelica.Icons.SignalSubBus;
        import SI = Modelica.SIunits;

        Boolean DD "true, if Mode DD, air only, is active";
        Boolean DB "true, if Mode DB, humidification, is active";
        Boolean DE "true, if Mode DE, dehumidification, is active";
        Boolean HD "true, if Mode HD, heating, is active";
        Boolean HB "true, if Mode HB, heating and humidification, is active";
        Boolean HE "true, if Mode HE, heating and dehumidification, is active";
        Boolean KD "true, if Mode KD, cooling, is active";
        Boolean KB "true, if Mode KB, cooling and humidification, is active";
        Boolean KE "true, if Mode KE, cooling and dehumidification, is active";

      end BusMode;

      model BoolMux "MUX fuer Booleans"
        Modelica.Blocks.Interfaces.BooleanInput u
          annotation (Placement(transformation(extent={{-126,30},{-86,70}})));
        Modelica.Blocks.Interfaces.BooleanInput u1
          annotation (Placement(transformation(extent={{-126,-50},{-86,-10}})));
        Modelica.Blocks.Interfaces.BooleanOutput y[2]
          annotation (Placement(transformation(extent={{96,-10},{116,10}})));
      equation
        connect(y[1], u) annotation (Line(points={{106,-5},{48,-5},{48,0},{-54,
                0},{-54,50},{-106,50}}, color={255,0,255}));
        connect(y[2], u1) annotation (Line(points={{106,5},{48,5},{48,0},{-54,0},
                {-54,-30},{-106,-30}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end BoolMux;
    end PN_Steuerung;

    model RegAnforderung
      Modelica.Blocks.Interfaces.BooleanOutput RegAnf
        "Boolean, True, if the HVAC should regenerate"
        annotation (Placement(transformation(extent={{96,-10},{116,10}})));
      Modelica.Blocks.Sources.BooleanExpression booleanExpression
        annotation (Placement(transformation(extent={{-8,-32},{12,-12}})));
    equation
      connect(booleanExpression.y, RegAnf) annotation (Line(points={{13,-22},{
              68,-22},{68,0},{106,0}}, color={255,0,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Text(
              extent={{-94,86},{96,-104}},
              lineColor={0,0,0},
              textString="WIP")}), Diagram(coordinateSystem(preserveAspectRatio=
               false), graphics={Text(
              extent={{-90,136},{92,-38}},
              lineColor={0,0,0},
              textString="WIP")}));
    end RegAnforderung;
  end OperatingModes;
end Controllers;
