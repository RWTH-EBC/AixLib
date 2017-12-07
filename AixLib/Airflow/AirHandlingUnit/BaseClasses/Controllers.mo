within AixLib.Airflow.AirHandlingUnit.BaseClasses;
package Controllers "contains all the control models"
  extends Modelica.Icons.VariantsPackage;
  model MenergaController
    "contains the control modes for the menerga model"
    parameter Modelica.SIunits.Temperature T_Set = 293.15 "setpoint temperature";
    parameter Boolean RLT21 = true "if true, RLT 21 is simulated, else RLT 22";

    BusActors busActors "Bus Connector for actor signals"
    annotation (Placement(
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
    Modelica.Blocks.Interfaces.BooleanInput OnSignal "On signal of device"
      annotation (Placement(transformation(extent={{-126,4},{-86,44}})));
    OperatingModes.PNControl22 controlTest
      annotation (Placement(transformation(extent={{-24,-54},{26,-12}})));
  equation

    //if RLT21 then
      //connect(pNControl21.busActors, busActors);
      connect(controlTest.busActors, busActors);
    //else
      //connect(pNControl22.busActors, busActors);
      //connect(development.busActors, busActors);
      //connect(fixedValues1.busActors, busActors);
    //end if;

    connect(busSensors, development.busSensors) annotation (Line(
        points={{-100,-34},{-56,-34},{-56,37.04},{-11.56,37.04}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));

    connect(OnSignal, controlTest.OnSignal) annotation (Line(points={{-106,24},
            {-66,24},{-66,-17},{-24.6,-17}},
                                        color={255,0,255}));
    connect(busSensors, controlTest.busSensors) annotation (Line(
        points={{-100,-34},{-62,-34},{-62,-34.4},{-24,-34.4}},
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
        annotation (Placement(transformation(extent={{48,-72},{198,72}})));
      Modelica.Blocks.Sources.Constant valOpeningY01(k=1) "opening of Y01"
        annotation (Placement(transformation(extent={{-220,240},{-200,260}})));
      Modelica.Blocks.Sources.Constant valOpeningY02(k=0) "opening of Y02"
        annotation (Placement(transformation(extent={{-220,208},{-200,228}})));
      Modelica.Blocks.Sources.Constant valOpeningY03(k=0) "opening of damper Y03"
        annotation (Placement(transformation(extent={{-220,176},{-200,196}})));
      Modelica.Blocks.Sources.Constant valOpeningY04(k=1) "opening of damper Y04"
        annotation (Placement(transformation(extent={{-220,144},{-200,164}})));
      Modelica.Blocks.Sources.Constant valOpeningY05(k=1) "opening of damper Y05"
        annotation (Placement(transformation(extent={{-220,112},{-200,132}})));
      Modelica.Blocks.Sources.Constant valOpeningY06(k=1) "opening of damper Y06"
        annotation (Placement(transformation(extent={{-220,82},{-200,102}})));
      Modelica.Blocks.Sources.Constant valOpeningY07(k=1) "opening of damper Y07"
        annotation (Placement(transformation(extent={{-220,50},{-200,70}})));
      Modelica.Blocks.Sources.Constant valOpeningY08(k=1) "opening of damper Y08"
        annotation (Placement(transformation(extent={{-220,18},{-200,38}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow(k=5.1)
        "nominal mass flow rate in outside air fan"
        annotation (Placement(transformation(extent={{-220,-18},{-200,2}})));
      Modelica.Blocks.Sources.Constant RegenAir_mflow(k=1)
        "nominal mass flow for regeneration air fan"
        annotation (Placement(transformation(extent={{-220,-48},{-200,-28}})));
      Modelica.Blocks.Sources.Constant exhaust_mflow(k=5.1)
        "nominal mass flow for exhaust air fan"
        annotation (Placement(transformation(extent={{-220,-78},{-200,-58}})));
      Modelica.Blocks.Sources.Constant valOpeningY9( k=1)
        "opening of damper Y09"
        annotation (Placement(transformation(extent={{-220,-106},{-200,-86}})));
      Modelica.Blocks.Sources.Constant valOpeningY10(k=1)
        "opening of damper Y10"
        annotation (Placement(transformation(extent={{-218,-134},{-198,-114}})));
      Modelica.Blocks.Sources.Constant valOpeningY11(k=1)
        "opening of damper Y11"
        annotation (Placement(transformation(extent={{-218,-162},{-198,-142}})));
      Modelica.Blocks.Sources.Constant pumpN04(k=1)
        "heating coil pump supply air"
        annotation (Placement(transformation(extent={{-218,-246},{-198,-226}})));
      Modelica.Blocks.Sources.BooleanExpression
                                       pumpN05
        "heating coil pump regeneration air"
        annotation (Placement(transformation(extent={{-218,-270},{-198,-250}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN06
        annotation (Placement(transformation(extent={{-218,-284},{-198,-264}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN07
        annotation (Placement(transformation(extent={{-218,-300},{-198,-280}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN08
        annotation (Placement(transformation(extent={{-218,-314},{-198,-294}})));
      Modelica.Blocks.Sources.Constant valOpeningY15(k=0)
        "opening of damper Y15" annotation (Placement(transformation(extent={{
                -218,-188},{-198,-168}})));
      Modelica.Blocks.Sources.Constant valOpeningY16(k=0)
        "opening of damper Y16" annotation (Placement(transformation(extent={{
                -218,-216},{-198,-196}})));
    equation
      connect(valOpeningY01.y, busActors.openingY01) annotation (Line(points={{-199,
              250},{-68,250},{-68,0.36},{123.375,0.36}},          color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY02.y, busActors.openingY02) annotation (Line(points={{-199,
              218},{-68,218},{-68,0.36},{123.375,0.36}},          color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY03.y, busActors.openingY03) annotation (Line(points={{-199,
              186},{-68,186},{-68,0.36},{123.375,0.36}},          color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY04.y, busActors.openingY04) annotation (Line(points={{-199,
              154},{-68,154},{-68,0.36},{123.375,0.36}},          color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY05.y, busActors.openingY05) annotation (Line(points={{-199,
              122},{-68,122},{-68,0.36},{123.375,0.36}},        color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY06.y, busActors.openingY06) annotation (Line(points={{-199,92},
              {-68,92},{-68,0.36},{123.375,0.36}},              color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY07.y, busActors.openingY07) annotation (Line(points={{-199,60},
              {-68,60},{-68,0.36},{123.375,0.36}},              color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY08.y, busActors.openingY08) annotation (Line(points={{-199,28},
              {-68,28},{-68,0.36},{123.375,0.36}},            color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow.y, busActors.outsideFan) annotation (Line(points={{-199,-8},
              {-68,-8},{-68,0.36},{123.375,0.36}},                  color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(RegenAir_mflow.y, busActors.regenerationFan) annotation (Line(
            points={{-199,-38},{-68,-38},{-68,0.36},{123.375,0.36}},     color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(exhaust_mflow.y, busActors.exhaustFan) annotation (Line(points={{-199,
              -68},{-68,-68},{-68,0.36},{123.375,0.36}},          color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY9.y, busActors.openingY09) annotation (Line(points={{-199,
              -96},{-68,-96},{-68,0.36},{123.375,0.36}},     color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY10.y, busActors.openingY10) annotation (Line(points={{-197,
              -124},{-68,-124},{-68,0.36},{123.375,0.36}},             color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY11.y, busActors.openingY11) annotation (Line(points={{-197,
              -152},{-68,-152},{-68,0.36},{123.375,0.36}},             color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN04.y, busActors.pumpN04) annotation (Line(points={{-197,-236},
              {-68,-236},{-68,0.36},{123.375,0.36}},                     color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN05.y, busActors.pumpN05) annotation (Line(points={{-197,-260},
              {-68,-260},{-68,0.36},{123.375,0.36}},         color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN06.y, busActors.pumpN06) annotation (Line(points={{-197,-274},
              {-68,-274},{-68,0.36},{123.375,0.36}},
                                                   color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN07.y, busActors.pumpN07) annotation (Line(points={{-197,-290},
              {-68,-290},{-68,0.36},{123.375,0.36}},
                                                   color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN08.y, busActors.pumpN08) annotation (Line(points={{-197,-304},
              {-68,-304},{-68,0.36},{123.375,0.36}},
                                                   color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY15.y, busActors.openingY15) annotation (Line(points={{
              -197,-178},{-68,-178},{-68,0.36},{123.375,0.36}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY16.y, busActors.openingY16) annotation (Line(points={{
              -197,-206},{-68,-206},{-68,0.36},{123.375,0.36}}, color={0,0,127}),
          Text(
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
      Modelica.Blocks.Sources.Step     valOpeningY01(
        offset=0,
        height=1,
        startTime=1000)                                   "opening of Y01"
        annotation (Placement(transformation(extent={{-222,234},{-202,254}})));
      Modelica.Blocks.Sources.Step     valOpeningY03(
        offset=1,
        startTime=1000,
        height=-0.5)                                      "opening of damper Y03"
        annotation (Placement(transformation(extent={{-222,174},{-202,194}})));
      Modelica.Blocks.Sources.Constant valOpeningY04(k=1) "opening of damper Y04"
        annotation (Placement(transformation(extent={{-220,140},{-200,160}})));
      Modelica.Blocks.Sources.Constant valOpeningY05(k=1) "opening of damper Y05"
        annotation (Placement(transformation(extent={{-220,108},{-200,128}})));
      Modelica.Blocks.Sources.Constant valOpeningY06(k=1) "opening of damper Y06"
        annotation (Placement(transformation(extent={{-220,78},{-200,98}})));
      Modelica.Blocks.Sources.Constant valOpeningY07(k=0) "opening of damper Y07"
        annotation (Placement(transformation(extent={{-220,48},{-200,68}})));
      Modelica.Blocks.Sources.Constant valOpeningY08(k=0) "opening of damper Y08"
        annotation (Placement(transformation(extent={{-220,16},{-200,36}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow(k=1000)
        "nominal mass flow rate in outside air fan"
        annotation (Placement(transformation(extent={{-220,-14},{-200,6}})));
      Modelica.Blocks.Sources.Constant RegenAir_mflow(k=0)
        "nominal mass flow for regeneration air fan"
        annotation (Placement(transformation(extent={{-220,-44},{-200,-24}})));
      Modelica.Blocks.Sources.Constant exhaust_mflow(k=1000)
        "nominal mass flow for exhaust air fan"
        annotation (Placement(transformation(extent={{-220,-74},{-200,-54}})));
      BusSensors busSensors
        annotation (Placement(transformation(extent={{-474,-142},{-304,14}})));
      Modelica.Blocks.Sources.Step     valOpeningY02(
        height=-0.5,
        offset=1,
        startTime=1000)                                   "opening of Y02"
        annotation (Placement(transformation(extent={{-222,202},{-202,222}})));
      Modelica.Blocks.Sources.Constant valOpeningY9(k=0)
        "opening of damper Y09"
        annotation (Placement(transformation(extent={{-106,-90},{-86,-70}})));
      Modelica.Blocks.Sources.Constant valOpeningY10(k=0)
        "opening of damper Y10"
        annotation (Placement(transformation(extent={{-106,-116},{-86,-96}})));
      Modelica.Blocks.Sources.Constant valOpeningY11(k=0)
        "opening of damper Y11"
        annotation (Placement(transformation(extent={{-106,-142},{-86,-122}})));
      Modelica.Blocks.Sources.Constant pumpN04(k=0)
        "heating coil pump supply air"
        annotation (Placement(transformation(extent={{-106,-222},{-86,-202}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN06
        annotation (Placement(transformation(extent={{-106,-254},{-86,-234}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN07
        annotation (Placement(transformation(extent={{-106,-270},{-86,-250}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN08
        annotation (Placement(transformation(extent={{-106,-286},{-86,-266}})));
      Modelica.Blocks.Sources.BooleanExpression pumpN05
        annotation (Placement(transformation(extent={{-106,-238},{-86,-218}})));
      Modelica.Blocks.Sources.Constant valOpeningY15(k=0)
        "opening of damper Y15"
        annotation (Placement(transformation(extent={{-106,-170},{-86,-150}})));
      Modelica.Blocks.Sources.Constant valOpeningY16(k=0)
        "opening of damper Y16"
        annotation (Placement(transformation(extent={{-106,-196},{-86,-176}})));
    equation
      connect(valOpeningY03.y, busActors.openingY03) annotation (Line(points={{-201,
              184},{-68,184},{-68,-69.64},{101.375,-69.64}},      color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY04.y, busActors.openingY04) annotation (Line(points={{-199,
              150},{-68,150},{-68,-69.64},{101.375,-69.64}},      color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY05.y, busActors.openingY05) annotation (Line(points={{-199,
              118},{-68,118},{-68,-69.64},{101.375,-69.64}},    color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY06.y, busActors.openingY06) annotation (Line(points={{-199,88},
              {-68,88},{-68,-69.64},{101.375,-69.64}},          color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY07.y, busActors.openingY07) annotation (Line(points={{-199,58},
              {-68,58},{-68,-69.64},{101.375,-69.64}},          color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY08.y, busActors.openingY08) annotation (Line(points={{-199,26},
              {-68,26},{-68,-69.64},{101.375,-69.64}},        color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY01.y, busActors.openingY01) annotation (Line(points={{-201,
              244},{-68,244},{-68,-69.64},{101.375,-69.64}},
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
      connect(valOpeningY9.y, busActors.openingY09) annotation (Line(points={{-85,-80},
              {-68,-80},{-68,-69.64},{101.375,-69.64}},      color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY10.y, busActors.openingY10) annotation (Line(points={{-85,
              -106},{-68,-106},{-68,-70},{101.375,-70},{101.375,-69.64}},
                                                                       color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY11.y, busActors.openingY11) annotation (Line(points={{-85,
              -132},{-68,-132},{-68,-70},{101.375,-70},{101.375,-69.64}},
                                                                       color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN04.y, busActors.pumpN04) annotation (Line(points={{-85,-212},
              {-68,-212},{-68,-69.64},{101.375,-69.64}},                 color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN06.y, busActors.pumpN06) annotation (Line(points={{-85,-244},
              {-68,-244},{-68,-69.64},{101.375,-69.64}},
                                                   color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN07.y, busActors.pumpN07) annotation (Line(points={{-85,-260},
              {-68,-260},{-68,-69.64},{101.375,-69.64}},
                                                   color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN08.y, busActors.pumpN08) annotation (Line(points={{-85,-276},
              {-68,-276},{-68,-69.64},{101.375,-69.64}},
                                                   color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN05.y, busActors.pumpN05) annotation (Line(points={{-85,-228},
              {-68,-228},{-68,-69.64},{101.375,-69.64}}, color={255,0,255}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY15.y, busActors.openingY15) annotation (Line(points={{
              -85,-160},{-68,-160},{-68,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY16.y, busActors.openingY16) annotation (Line(points={{
              -85,-186},{-68,-186},{-68,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow.y, busActors.outsideFan_dp) annotation (Line(
            points={{-199,-4},{-50,-4},{-50,-69.64},{101.375,-69.64}}, color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(exhaust_mflow.y, busActors.exhaustFan_dp) annotation (Line(points=
             {{-199,-64},{-58,-64},{-58,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(RegenAir_mflow.y, busActors.regenerationFan_dp) annotation (Line(
            points={{-199,-34},{-56,-34},{-56,-69.64},{101.375,-69.64}}, color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-400,
                -240},{100,260}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-400,-240},{100,260}})));
    end development;

    model PNControl22 "PetriNet based control of RLT 22 without absorption"

      parameter Real leak = 0.0001 "leakage before the valve switches";
      parameter Real d = 300 "delay for mode switching in s";
      parameter Modelica.SIunits.Temperature T_Set = 20+273.15 "set value for T01";
      parameter Real phi_Set = 0.5  "set value for phi (relative humidity) at T01";

      parameter Real mFlowNom_outFan = 5  "set value for outside air fan";
      parameter Real mFlowNom_exhFan = 5  "set value for exhaust air fan";
      parameter Real mFlowNom_regFan = 1  "set value for regeneration air fan";

      parameter Real k_y02 = 0.03;  //0.15;
      parameter Real Ti_y02 = 240;  //0.5;
      parameter Real k_y09 = 0.05;  //0.01//0.06 aus Einzelanalyse;
      parameter Real Ti_y09 = 180;  //180
      parameter Real k_phi = 0.28;  //80;  //0.08;
      parameter Real Ti_phi = 27;  //0.7;
      parameter Real k_Fan = 250;
      parameter Real Ti_Fan = 30;

      BusSensors busSensors
        annotation (Placement(transformation(extent={{-264,-54},{-176,46}})));
      BusActors busActors "Bus connector for actor signals"
        annotation (Placement(transformation(extent={{244,-40},{318,40}})));
      PN_Steuerung.PN_Main1_RLT22      pN_Steuerung_Ebene1_1(d=d)
        annotation (Placement(transformation(extent={{-78,140},{-58,160}})));
      PN_Steuerung.regDem regAnforderung
        "True, when there is need for regeneration"
        annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
      PN_Steuerung.Ebene2.DD dD
        annotation (Placement(transformation(extent={{-80,76},{-60,96}})));
      PN_Steuerung.ModeSwitch modeSwitch
        annotation (Placement(transformation(extent={{-14,-12},{24,24}})));
      PN_Steuerung.Ebene2.DB dB
        annotation (Placement(transformation(extent={{-80,46},{-60,66}})));
      PN_Steuerung.Ebene2.DE dE
        annotation (Placement(transformation(extent={{-80,16},{-60,36}})));
      PN_Steuerung.Ebene2.HD hD(d=d, leak=leak)
        annotation (Placement(transformation(extent={{-80,-14},{-60,6}})));
      PN_Steuerung.Ebene2.HB hB(d=d, leak=leak)
        annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
      PN_Steuerung.Ebene2.HE hE
        annotation (Placement(transformation(extent={{-80,-74},{-60,-54}})));
      PN_Steuerung.Ebene2.KD kD
        annotation (Placement(transformation(extent={{-80,-104},{-60,-84}})));
      PN_Steuerung.Ebene2.KB kB
        annotation (Placement(transformation(extent={{-80,-134},{-60,-114}})));
      PN_Steuerung.Ebene2.KE kE
        annotation (Placement(transformation(extent={{-80,-164},{-60,-144}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y01(Y_Close(n=7, modes={1,2,3,4,5,6,7}),
          Y_Open(n=16, modes={8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}))
        "On_Off valve Y01"
        annotation (Placement(transformation(extent={{140,200},{160,220}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y03(Y_Close(n=16, modes={8,9,10,11,12,
              13,14,15,16,17,18,19,20,21,22,23}), Y_Open(n=7, modes={1,2,3,4,5,
              6,7})) "On Off valve Y03"
        annotation (Placement(transformation(extent={{140,160},{160,180}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y04(Y_Close(n=1, modes={1}), Y_Open(n=
             22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,
              23}))
        annotation (Placement(transformation(extent={{140,140},{160,160}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y05(Y_Close(n=1, modes={1}), Y_Open(n=
             22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,
              23}))
        annotation (Placement(transformation(extent={{140,120},{160,140}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y07(Y_Close(n=12, modes={1,2,3,4,8,9,
              10,11,12,13,14,15}), Y_Open(n=11, modes={5,6,7,16,17,18,19,20,21,
              22,23}))
        annotation (Placement(transformation(extent={{140,80},{160,100}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y08(Y_Close(n=12, modes={1,2,3,4,8,9,
              10,11,12,13,14,15}), Y_Open(n=11, modes={5,6,7,16,17,18,19,20,21,
              22,23}))
        annotation (Placement(transformation(extent={{140,60},{160,80}})));
      PN_Steuerung.Aktoren.controlvalve2 valve_Y09(Y_Close(n=19, modes={1,2,3,4,5,6,
              7,8,9,10,11,14,15,16,17,18,19,22,23}), Y_Control(n=4, modes={12,13,20,
              21})) "controlValve"
        annotation (Placement(transformation(extent={{106,40},{126,60}})));
      PN_Steuerung.Auswertemodule.heaCoiEva y09_evaluation(
        k=k_y09,
        Ti=Ti_y09,
        Setpoint=T_Set)
        annotation (Placement(transformation(extent={{140,40},{160,60}})));
      PN_Steuerung.Aktoren.controlvalve2 valve_Y10(Y_Close(n=12, modes={1,2,3,4,8,9,
              10,11,12,13,14,15}), Y_Control(n=11, modes={5,6,7,16,17,18,19,20,21,22,
              23})) "controlValve"
        annotation (Placement(transformation(extent={{106,20},{126,40}})));
      PN_Steuerung.Auswertemodule.heaCoiEva y10_evaluation(
        k=k_y09,
        Ti=Ti_y09,
        Setpoint=60)
        annotation (Placement(transformation(extent={{140,20},{160,40}})));
      PN_Steuerung.Aktoren.controlvalve2 valve_Y11(
                                            Y_Control(n=8, modes={3,6,9,11,13,17,19,
              21}), Y_Close(n=15, modes={1,2,4,5,7,8,10,12,14,15,16,18,20,22,23}))
                    "controlValve"
        annotation (Placement(transformation(extent={{106,0},{126,20}})));
      PN_Steuerung.Auswertemodule.heaCoiEva      y11_evaluation(
        k=k_phi,
        Ti=Ti_phi,
        Setpoint=phi_Set)
        annotation (Placement(transformation(extent={{140,0},{160,20}})));
      PN_Steuerung.Aktoren.Fan_On_Off_PI outsideFan(
        mFlow_Set=mFlowNom_outFan,
        Fan_On(n=22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,
              22,23}),
        Fan_Off(n=1, modes={1}),
        k=k_Fan,
        Ti=Ti_Fan) "mass flow set point signal for outside fan"
        annotation (Placement(transformation(extent={{140,-60},{160,-40}})));
      PN_Steuerung.Aktoren.Fan_On_Off_PI exhaustFan(
        mFlow_Set=mFlowNom_exhFan,
        Fan_Off(n=1, modes={1}),
        Fan_On(n=22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,
              22,23}),
        k=k_Fan,
        Ti=Ti_Fan) "mass flow set point value for exhaust fan"
        annotation (Placement(transformation(extent={{140,-80},{160,-60}})));
      PN_Steuerung.Aktoren.Fan_On_Off_PI regFan(
        mFlow_Set=mFlowNom_regFan,
        Fan_Off(n=12, modes={1,2,3,4,8,9,10,11,12,13,14,15}),
        Fan_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}),
        k=k_Fan,
        Ti=Ti_Fan) "mass flow signal for regeneration fan"
        annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
      PN_Steuerung.Aktoren.Pump_On_Off pumpN04(Pump_Off(n=19, modes={1,2,3,4,5,6,7,8,
              9,10,11,14,15,16,17,18,19,22,23}), Pump_On(n=4, modes={12,13,20,21}))
        "on off signal of pump N04 for heating coil circuit for supply air"
        annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
      PN_Steuerung.Aktoren.Pump_Bool   pumpN05(Pump_Off(n=12, modes={1,2,3,4,8,9,10,
              11,12,13,14,15}), Pump_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}))
        "on off signal for pump N05, regeneration heating coil"
        annotation (Placement(transformation(extent={{140,-140},{160,-120}})));
      PN_Steuerung.Aktoren.Pump_Bool pumpN06(Pump_Off(n=17, modes={1,2,3,4,5,6,7,8,9,
              12,13,14,16,17,20,21,22}), Pump_On(n=6, modes={10,11,15,18,19,23}))
        "pump signal for N06 to activate adiabatic cooling"
        annotation (Placement(transformation(extent={{140,-160},{160,-140}})));
      PN_Steuerung.Aktoren.Pump_Bool pumpN07(Pump_Off(n=17, modes={1,2,3,5,6,8,9,10,
              11,12,13,16,17,18,19,20,21}), Pump_On(n=6, modes={4,7,14,15,22,23}))
        "absorber pump signal"
        annotation (Placement(transformation(extent={{140,-180},{160,-160}})));
      PN_Steuerung.Aktoren.Pump_Bool pumpN08(Pump_Off(n=12, modes={1,2,3,4,8,9,10,11,
              12,13,14,15}), Pump_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}))
        "on off signal for pump N08, regeneration pump for desiccant solution"
        annotation (Placement(transformation(extent={{140,-200},{160,-180}})));
      PN_Steuerung.Auswertemodule.Y02_evaluation y02_evaluation(T_Set=T_Set,
        k=k_y02,
        Ti=Ti_y02,
        k_cool=k_y02,
        Ti_cool=Ti_y02)
        annotation (Placement(transformation(extent={{140,180},{160,200}})));
      PN_Steuerung.Aktoren.controlvalve3 valve_Y02(
        Y_Close(n=4, modes={12,13,20,21}),
        Y_Open(n=7, modes={1,2,3,4,5,6,7}),
        Y_Control(n=12, modes={8,9,10,11,14,15,16,17,18,19,22,23}))
        annotation (Placement(transformation(extent={{106,180},{126,200}})));
      Modelica.Blocks.Interfaces.BooleanInput OnSignal
        "Delivers signal to switch on or off the device"
        annotation (Placement(transformation(extent={{-246,150},{-206,190}})));
      PN_Steuerung.Aktoren.controlvalve2   valve_Y15(Y_Close(n=20, modes={1,2,3,
              4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21}), Y_Control(n=3,
            modes={7,22,23}))
        annotation (Placement(transformation(extent={{106,-20},{126,0}})));
      PN_Steuerung.Aktoren.controlvalve2   valve_Y16(Y_Close(n=20, modes={1,2,3,
              4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21}), Y_Control(n=3,
            modes={7,22,23}))
        annotation (Placement(transformation(extent={{106,-40},{126,-20}})));
      PN_Steuerung.Auswertemodule.Y15_evaluation         eva_Y15
        annotation (Placement(transformation(extent={{140,-20},{160,0}})));
      PN_Steuerung.Auswertemodule.Y16_evaluationSimple   evaY16
        annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
      PN_Steuerung.Auswertemodule.bypassEva y06_evaluation
        annotation (Placement(transformation(extent={{140,100},{160,120}})));
      PN_Steuerung.Aktoren.bypassValve valve_Y06(Y_Open(n=17, modes={1,2,3,5,6,
              8,9,10,11,12,13,16,17,18,19,20,21}), Y_Control(n=6, modes={4,7,14,
              15,22,23}))
        annotation (Placement(transformation(extent={{106,100},{126,120}})));
    equation
      connect(dD.RegAnf, regAnforderung.RegAnf) annotation (Line(points={{-80.6,86},
              {-100,86},{-100,70},{-159.4,70}},   color={255,0,255}));
      connect(regAnforderung.RegAnf, dB.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,56},{-80.6,56}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, dE.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,26},{-80.6,26}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, hD.RegAnf) annotation (Line(points={{-159.4,70},{
              -100,70},{-100,-4},{-80.6,-4}},               color={255,0,255}));
      connect(regAnforderung.RegAnf, hB.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-34},{-80.6,-34}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, hE.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-64},{-80.6,-64}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, kD.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-94},{-80.6,-94}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, kB.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-124},{-80.6,-124}},              color={255,0,
              255}));
      connect(regAnforderung.RegAnf, kE.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-154},{-80.6,-154}},              color={255,0,
              255}));
      connect(dB.DB_Out, modeSwitch.DB) annotation (Line(points={{-59.4,56},{
              -26,56},{-26,19.2},{-15.0556,19.2}},
                                             color={255,127,0}));
      connect(dE.DE_Out, modeSwitch.DE) annotation (Line(points={{-59.4,26},{
              -40,26},{-40,14.9143},{-15.0556,14.9143}},
                                                   color={255,127,0}));
      connect(hD.HD_Out, modeSwitch.HD) annotation (Line(points={{-59.4,-4},{
              -34,-4},{-34,10.8},{-15.0556,10.8}},
                                             color={255,127,0}));
      connect(hB.HB_Out, modeSwitch.HB) annotation (Line(points={{-59.4,-34},{
              -30,-34},{-30,6.85714},{-15.0556,6.85714}},
                                                       color={255,127,0}));
      connect(hE.HE_Out, modeSwitch.HE) annotation (Line(points={{-59.4,-64},{
              -26,-64},{-26,2.4},{-15.0556,2.4}},
                                               color={255,127,0}));
      connect(kD.KD_Out, modeSwitch.KD) annotation (Line(points={{-59.4,-94},{
              -22,-94},{-22,-1.54286},{-15.0556,-1.54286}},
                                                         color={255,127,0}));
      connect(kB.KB_Out, modeSwitch.KB) annotation (Line(points={{-59.4,-124},{
              -18,-124},{-18,-5.82857},{-15.0556,-5.82857}},
                                                          color={255,127,0}));
      connect(kE.KE_Out, modeSwitch.KE) annotation (Line(points={{-59.4,-154},{
              -16,-154},{-16,-10.2857},{-15.0556,-10.2857}},
                                                          color={255,127,0}));
      connect(dD.DD_Out, modeSwitch.DD) annotation (Line(points={{-59.4,86},{
              -22,86},{-22,23.3143},{-15.0556,23.3143}},
                                                  color={255,127,0}));
      connect(hD.Y02_signal, busSensors.Y02_actual) annotation (Line(points={{-80.6,
              4.2},{-101.3,4.2},{-101.3,-3.75},{-219.78,-3.75}},       color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hD.Y09_signal, busSensors.Y09_actual) annotation (Line(points={{-80.6,
              0.2},{-101.3,0.2},{-101.3,-3.75},{-219.78,-3.75}},       color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.Y02_signal, busSensors.Y02_actual) annotation (Line(points={{-80.6,
              -25.8},{-101.3,-25.8},{-101.3,-3.75},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.Y09_signal, busSensors.Y09_actual) annotation (Line(points={{-80.6,
              -29.8},{-101.3,-29.8},{-101.3,-3.75},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.T_Rek, busSensors.T_Rek) annotation (Line(
            points={{-78.6,159},{-219.78,159},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.phi_03, busSensors.T03_RelHum) annotation (
          Line(points={{-78.6,156},{-219.78,156},{-219.78,-3.75}},
                       color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.phi_01, busSensors.T01_RelHum) annotation (
          Line(points={{-78.6,153},{-219.78,153},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.signal_Y06, busSensors.Y06_actual)
        annotation (Line(points={{-78.6,150},{-219.78,150},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y01.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,210},{139.2,210}},
                                                         color={255,127,0}));
      connect(valve_Y01.setValue_Y, busActors.openingY01) annotation (Line(
            points={{160.6,210},{230,210},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y03.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,170},{139.2,170}},
                                     color={255,127,0}));
      connect(valve_Y03.setValue_Y, busActors.openingY03) annotation (Line(
            points={{160.6,170},{230,170},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y04.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,150},{139.2,150}},
            color={255,127,0}));
      connect(valve_Y04.setValue_Y, busActors.openingY04) annotation (Line(
            points={{160.6,150},{230,150},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y05.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,130},{139.2,130}},
                                     color={255,127,0}));
      connect(valve_Y05.setValue_Y, busActors.openingY05) annotation (Line(
            points={{160.6,130},{230,130},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y07.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,90},{139.2,90}},            color={
              255,127,0}));
      connect(valve_Y07.setValue_Y, busActors.openingY07) annotation (Line(
            points={{160.6,90},{230,90},{230,0.2},{281.185,0.2}},   color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y08.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,70},{139.2,70}},            color={
              255,127,0}));
      connect(valve_Y08.setValue_Y, busActors.openingY08) annotation (Line(
            points={{160.6,70},{230,70},{230,0.2},{281.185,0.2}},   color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y09.Close, y09_evaluation.Y_closed)
        annotation (Line(points={{126.8,56},{139.4,56}}, color={255,0,255}));
      connect(valve_Y09.Control, y09_evaluation.Y_control)
        annotation (Line(points={{126.6,50},{139.4,50}}, color={255,0,255}));
      connect(y09_evaluation.MeasuredValue, busSensors.T01) annotation (Line(
            points={{139.4,43},{88,43},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y09.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,50},{105.2,50}}, color={255,127,0}));
      connect(y09_evaluation.y, busActors.openingY09) annotation (Line(points={{160.6,
              50},{230,50},{230,0.2},{281.185,0.2}},        color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y10.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,30},{105.2,30}}, color={255,127,0}));
      connect(valve_Y10.Close, y10_evaluation.Y_closed)
        annotation (Line(points={{126.8,36},{139.4,36}}, color={255,0,255}));
      connect(valve_Y10.Control, y10_evaluation.Y_control)
        annotation (Line(points={{126.6,30},{139.4,30}}, color={255,0,255}));
      connect(y10_evaluation.y, busActors.openingY10) annotation (Line(points={{160.6,
              30},{230,30},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y11.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,10},{105.2,10}}, color={255,127,0}));
      connect(y11_evaluation.y, busActors.openingY11) annotation (Line(points={{160.6,
              10},{230,10},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.y, modeSwitch.Mode_Index) annotation (Line(
            points={{-57.4,150},{5,150},{5,24.8571}},    color={255,127,0}));
      connect(modeSwitch.CurrentMode,outsideFan. M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-50},{139.2,-50}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, exhaustFan.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-70},{139.2,-70}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, regFan.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-90},{139.2,-90}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, pumpN05.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-130},{139.2,-130}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, pumpN08.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-190},{139.2,-190}}, color={255,127,0}));
      connect(pumpN08.signal_pump, busActors.pumpN08) annotation (Line(points={{160.8,
              -190},{230,-190},{230,0.2},{281.185,0.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, pumpN04.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-110},{139.2,-110}}, color={255,127,0}));
      connect(pumpN04.signal_Pump, busActors.pumpN04) annotation (Line(points={{160.6,
              -110},{230,-110},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, pumpN06.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-150},{139.2,-150}}, color={255,127,0}));
      connect(pumpN06.signal_pump, busActors.pumpN06) annotation (Line(points={{160.8,
              -150},{230,-150},{230,0.2},{281.185,0.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, pumpN07.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-170},{139.2,-170}}, color={255,127,0}));
      connect(pumpN07.signal_pump, busActors.pumpN07) annotation (Line(points={{160.8,
              -170},{230,-170},{230,0.2},{281.185,0.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y02.valve_closed, y02_evaluation.Y02_closed) annotation (Line(
            points={{126.6,195},{132,195},{132,199},{139.2,199}}, color={255,0,255}));
      connect(valve_Y02.valve_open, y02_evaluation.Y02_open) annotation (Line(
            points={{126.6,190},{132,190},{132,194},{139.2,194}}, color={255,0,255}));
      connect(valve_Y02.valve_controlled, y02_evaluation.Y02_control) annotation (
          Line(points={{126.6,185},{132,185},{132,189},{139.2,189}}, color={255,0,255}));
      connect(modeSwitch.CurrentMode, valve_Y02.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,190},{105.2,190}}, color={255,127,0}));
      connect(y02_evaluation.T_measure, busSensors.T01) annotation (Line(points={{139.2,
              183},{88,183},{88,118},{-219.78,118},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y02_evaluation.y, busActors.openingY02) annotation (Line(points={{160.6,
              190},{230,190},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN06.signal_pump, y02_evaluation.adiabaticOn) annotation (Line(
            points={{160.8,-150},{230,-150},{230,182},{160.8,182}}, color={255,0,255}));
      connect(pN_Steuerung_Ebene1_1.signal_Y02, busSensors.Y02_actual)
        annotation (Line(points={{-78.6,147},{-219.78,147},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y11.Close, y11_evaluation.Y_closed)
        annotation (Line(points={{126.8,16},{139.4,16}}, color={255,0,255}));
      connect(valve_Y11.Control, y11_evaluation.Y_control)
        annotation (Line(points={{126.6,10},{139.4,10}}, color={255,0,255}));
      connect(y11_evaluation.MeasuredValue, busSensors.T01_RelHum) annotation (
          Line(points={{139.4,3},{88,3},{88,118},{-219.78,118},{-219.78,-3.75}},
                               color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(outsideFan.dp_Fan, busActors.outsideFan_dp) annotation (Line(
            points={{160.6,-50},{230,-50},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(outsideFan.Measure_mFlow, busSensors.mFlowOut) annotation (Line(
            points={{139.4,-57},{88,-57},{88,118},{-219.78,118},{-219.78,-3.75}},
                               color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(OnSignal, modeSwitch.OnSignal) annotation (Line(points={{-226,170},
              {-4,170},{-4,24.8571},{-4.28889,24.8571}},
                                                     color={255,0,255}));
      connect(exhaustFan.dp_Fan, busActors.exhaustFan_dp) annotation (Line(points={{
              160.6,-70},{230,-70},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regFan.dp_Fan, busActors.regenerationFan_dp) annotation (Line(points={
              {160.6,-90},{230,-90},{230,0.2},{281.185,0.2}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(exhaustFan.Measure_mFlow, busSensors.mFlowExh) annotation (Line(
            points={{139.4,-77},{88,-77},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regFan.Measure_mFlow, busSensors.mFlowReg) annotation (Line(points={{139.4,
              -97},{88,-97},{88,118},{-219.78,118},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN05.signal_pump, busActors.pumpN05) annotation (Line(points={
              {160.8,-130},{230,-130},{230,0.2},{281.185,0.2}}, color={255,0,
              255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y15.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-10},{105.2,-10}},          color={
              255,127,0}));
      connect(modeSwitch.CurrentMode, valve_Y16.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-30},{105.2,-30}},          color={
              255,127,0}));
      connect(eva_Y15.y, busActors.openingY15) annotation (Line(points={{160.6,
              -10},{230,-10},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(evaY16.y, busActors.openingY16) annotation (Line(points={{160.6,
              -30},{230,-30},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y10_evaluation.MeasuredValue, busSensors.TDes) annotation (Line(
            points={{139.4,23},{88,23},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regAnforderung.xAbs, busSensors.xAbs) annotation (Line(points={{-180.8,
              74},{-219.78,74},{-219.78,-3.75}},                  color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regAnforderung.xDes, busSensors.xDes) annotation (Line(points={{-180.8,
              66},{-219.78,66},{-219.78,-3.75}},                  color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y06_evaluation.phi_zu, busSensors.T01_RelHum) annotation (Line(
            points={{139.4,103},{88,103},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y06_evaluation.y, busActors.openingY06) annotation (Line(points={
              {160.6,110},{230,110},{230,0.2},{281.185,0.2}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y06.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,110},{105.2,110},{105.2,110}},
            color={255,127,0}));
      connect(valve_Y06.Open, y06_evaluation.Y_open)
        annotation (Line(points={{126.6,116},{139.4,116}}, color={255,0,255}));
      connect(valve_Y06.Control, y06_evaluation.Y_control)
        annotation (Line(points={{126.6,110},{139.4,110}}, color={255,0,255}));
      connect(hD.T_out, busSensors.T04) annotation (Line(points={{-80.6,-11},{
              -100.3,-11},{-100.3,-3.75},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.T_out, busSensors.T04) annotation (Line(points={{-80.6,-41},{
              -100.3,-41},{-100.3,-3.75},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y15.Close, eva_Y15.Y_closed)
        annotation (Line(points={{126.8,-4},{139.4,-4}}, color={255,0,255}));
      connect(valve_Y15.Control, eva_Y15.Y_AbsDesControl)
        annotation (Line(points={{126.6,-10},{139.4,-10}}, color={255,0,255}));
      connect(evaY16.tankMassDes, busSensors.mTankDes) annotation (Line(points=
              {{139.4,-37},{88,-37},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(eva_Y15.tankMassAbs, busSensors.mTankAbs) annotation (Line(points=
             {{139.4,-17},{88,-17},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y16.Close, evaY16.Y_closed) annotation (Line(points={{126.8,
              -24},{134,-24},{134,-24},{139.4,-24}}, color={255,0,255}));
      connect(valve_Y16.Control, evaY16.Y_AbsDesControl) annotation (Line(
            points={{126.6,-30},{134,-30},{134,-30},{139.4,-30}}, color={255,0,
              255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-200},
                {280,220}})),            Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-220,-200},{280,220}}),
            graphics={
            Rectangle(
              extent={{-180,220},{44,104}},
              lineColor={0,0,0},
              fillColor={200,88,88},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-180,104},{44,-200}},
              lineColor={0,0,0},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{44,220},{240,-230}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-144,210},{10,184}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid,
              textString="Modiauswahl"),
            Text(
              extent={{-150,-168},{4,-194}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid,
              textString="Aktorsatz"),
            Text(
              extent={{70,-200},{224,-226}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid,
              textString="Aktorregelung")}));
    end PNControl22;

    package PN_Steuerung
      extends Modelica.Icons.BasesPackage;

      model PN_Main1_RLT21 "oberste Ebene der Petri-Netz-Steuerung"

        parameter Real d = 300 "delay in s";

        parameter Modelica.SIunits.Temperature T_Soll = 20+273.15  "Sollwert der Zuluft";
        parameter Real T_h = 3      "Temperaturhysterese der Heiz- und Kuehlschaltung";
        parameter Real phi_min = 0.3   "Minimalwert der relativen Luftfeuchte";
        parameter Real phi_max = 0.7  "Maximalwert der relativen Luftfeuchte";

        PNlib.PDBool
                 Heizen(nIn=1, nOut=1,
          maxTokens=1) "Petri-Stelle für Heizen"                 annotation (
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
          delay=d,
          firingCon=T_Rek >= T_Soll + 1/3*T_h or signal_Y02 >= 0.999)
          "Transition zum Ausschalten der Heizung"
          annotation (Placement(transformation(extent={{-40,74},{-20,94}})));
        PNlib.TD Heizen_an(
          nOut=1,
          nIn=1,
          firingCon=T_Rek <= T_Soll - 2/3*T_h,
          delay=d)
          "Transition zum Anschalten der Heizung"
          annotation (Placement(transformation(extent={{-20,34},{-40,54}})));
        PNlib.TD Kuehlen_an(
          nIn=1,
          nOut=1,
          firingCon=T_Rek >= T_Soll + 2/3*T_h,
          delay=d)
          "Transition zum Anschalten der Kühlung"
          annotation (Placement(transformation(extent={{20,34},{40,54}})));
        PNlib.TD Kuehlen_aus(
          nOut=1,
          nIn=1,
          delay=d,
          firingCon=T_Rek <= T_Soll - 1/3*T_h or signal_Y02 >= 0.999)
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
          firingCon=phi_03 >= 0.35,
          delay=d)
          "Transition zum Ausschalten der Befeuchtung"
          annotation (Placement(transformation(extent={{-40,2},{-20,22}})));
        PNlib.TD Befeuchten_an(nOut=1, nIn=1,
          firingCon=phi_01 <= phi_min,
          delay=d)
          "Transition zum Anschalten der Befeuchtung"
          annotation (Placement(transformation(extent={{-20,-38},{-40,-18}})));
        PNlib.TD Entfeuchten_an(nIn=1, nOut=1,
          delay=d,
          firingCon=phi_01 >= phi_max)
          "Transition zum Anschalten der Entfeuchtung"
          annotation (Placement(transformation(extent={{20,-38},{40,-18}})));
        PNlib.TD Entfeuchten_aus(nOut=1, nIn=1,
          delay=d,
          firingCon=phi_01 <= 0.4 or signal_Y06 >= 0.999)
          "Transition zum Abschalten der Entfeuchtung"
          annotation (Placement(transformation(extent={{40,2},{20,22}})));
        Modelica.Blocks.Interfaces.RealInput T_Rek
          "Temperature Input of Temperature before recuperator after absorber, i.e. T_Rek"
          annotation (Placement(transformation(extent={{-126,70},{-86,110}})));
        Modelica.Blocks.Interfaces.RealInput phi_03
          "relative humidity before steamhumidifier"
          annotation (Placement(transformation(extent={{-126,40},{-86,80}})));
        Modelica.Blocks.Interfaces.RealInput phi_01
          "relative humidity of the supply air after steamhumidifier"
          annotation (Placement(transformation(extent={{-126,10},{-86,50}})));
        Modelica.Blocks.Interfaces.RealInput signal_Y06
          "actual valve signal of Y06"
          annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
        Selector_global selector_global
          annotation (Placement(transformation(extent={{-18,-80},{2,-60}})));
        Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
          nu=9,
          expr={1,2,3,4,5,6,7,8,9},
          y_default=1,
          use_pre_as_default=false)
                annotation (Placement(transformation(extent={{34,-80},{74,-60}})));
        Modelica.Blocks.Interfaces.IntegerOutput y
          annotation (Placement(transformation(extent={{96,-10},{116,10}})));
        Modelica.Blocks.Interfaces.RealInput signal_Y02
          "actual valve signal of Y02"
          annotation (Placement(transformation(extent={{-126,-50},{-86,-10}})));
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

        connect(Heizen.pd_b, selector_global.H) annotation (Line(points={{-71,64},{-76,
                64},{-76,-62},{-18.6,-62}},          color={255,0,255}));
        connect(selector_global.D_HK, Drift_HK.pd_b) annotation (Line(points={{-18.6,-65},
                {-76,-65},{-76,28},{12,28},{12,64},{11,64}},            color={
                255,0,255}));
        connect(Kuehlen.pd_b, selector_global.K) annotation (Line(points={{49,64},{46,
                64},{46,28},{-76,28},{-76,-68},{-18.6,-68}},         color={255,
                0,255}));
        connect(Befeuchten.pd_b, selector_global.B) annotation (Line(points={{-71,-8},
                {-76,-8},{-76,-72},{-18.6,-72}},         color={255,0,255}));
        connect(Drift_BE.pd_b, selector_global.D_BE) annotation (Line(points={{11,-8},
                {14,-8},{14,-50},{-76,-50},{-76,-75},{-18.6,-75}},        color=
               {255,0,255}));
        connect(Entfeuchten.pd_b, selector_global.E) annotation (Line(points={{49,-8},
                {44,-8},{44,-50},{-76,-50},{-76,-78},{-18.6,-78}},        color=
               {255,0,255}));
        connect(selector_global.ModeSelector, multiSwitch1.u[1:9]) annotation (Line(
              points={{2.6,-70},{20,-70},{20,-72.6667},{34,-72.6667}}, color={255,0,255}));
        connect(multiSwitch1.y, y) annotation (Line(points={{75,-70},{88,-70},{88,0},{
                106,0}}, color={255,127,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PN_Main1_RLT21;

      model PN_Main1_RLT22 "oberste Ebene der Petri-Netz-Steuerung"

        parameter Real d = 300 "delay in s";

        parameter Modelica.SIunits.Temperature T_Soll = 20+273.15  "Sollwert der Zuluft";
        parameter Real T_h = 3      "Temperaturhysterese der Heiz- und Kuehlschaltung";
        parameter Real phi_min = 0.3   "Minimalwert der relativen Luftfeuchte";
        parameter Real phi_max = 0.7  "Maximalwert der relativen Luftfeuchte";

        PNlib.PDBool
                 Heizen(nIn=1, nOut=1,
          maxTokens=1) "Petri-Stelle für Heizen"                 annotation (
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
          delay=d,
          firingCon=T_Rek >= T_Soll + 1/3*T_h or signal_Y02 >= 0.999)
          "Transition zum Ausschalten der Heizung"
          annotation (Placement(transformation(extent={{-40,74},{-20,94}})));
        PNlib.TD Heizen_an(
          nOut=1,
          nIn=1,
          firingCon=T_Rek <= T_Soll - 2/3*T_h,
          delay=d)
          "Transition zum Anschalten der Heizung"
          annotation (Placement(transformation(extent={{-20,34},{-40,54}})));
        PNlib.TD Kuehlen_an(
          nIn=1,
          nOut=1,
          firingCon=T_Rek >= T_Soll + 2/3*T_h,
          delay=d)
          "Transition zum Anschalten der Kühlung"
          annotation (Placement(transformation(extent={{20,34},{40,54}})));
        PNlib.TD Kuehlen_aus(
          nOut=1,
          nIn=1,
          delay=d,
          firingCon=T_Rek <= T_Soll - 1/3*T_h or signal_Y02 >= 0.999)
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
          firingCon=phi_03 >= 0.35,
          delay=d)
          "Transition zum Ausschalten der Befeuchtung"
          annotation (Placement(transformation(extent={{-40,2},{-20,22}})));
        PNlib.TD Befeuchten_an(nOut=1, nIn=1,
          firingCon=phi_01 <= phi_min,
          delay=d)
          "Transition zum Anschalten der Befeuchtung"
          annotation (Placement(transformation(extent={{-20,-38},{-40,-18}})));
        PNlib.TD Entfeuchten_an(nIn=1, nOut=1,
          delay=d,
          firingCon=false)
          "Transition zum Anschalten der Entfeuchtung"
          annotation (Placement(transformation(extent={{20,-38},{40,-18}})));
        PNlib.TD Entfeuchten_aus(nOut=1, nIn=1,
          delay=d,
          firingCon=phi_01 <= 0.4 or signal_Y06 >= 0.999)
          "Transition zum Abschalten der Entfeuchtung"
          annotation (Placement(transformation(extent={{40,2},{20,22}})));
        Modelica.Blocks.Interfaces.RealInput T_Rek
          "Temperature Input of Temperature before recuperator after absorber, i.e. T_Rek"
          annotation (Placement(transformation(extent={{-126,70},{-86,110}})));
        Modelica.Blocks.Interfaces.RealInput phi_03
          "relative humidity before steamhumidifier"
          annotation (Placement(transformation(extent={{-126,40},{-86,80}})));
        Modelica.Blocks.Interfaces.RealInput phi_01
          "relative humidity of the supply air after steamhumidifier"
          annotation (Placement(transformation(extent={{-126,10},{-86,50}})));
        Modelica.Blocks.Interfaces.RealInput signal_Y06
          "actual valve signal of Y06"
          annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
        Selector_global selector_global
          annotation (Placement(transformation(extent={{-18,-80},{2,-60}})));
        Modelica.Blocks.MathInteger.MultiSwitch multiSwitch1(
          nu=9,
          expr={1,2,3,4,5,6,7,8,9},
          y_default=1,
          use_pre_as_default=false)
                annotation (Placement(transformation(extent={{34,-80},{74,-60}})));
        Modelica.Blocks.Interfaces.IntegerOutput y
          annotation (Placement(transformation(extent={{96,-10},{116,10}})));
        Modelica.Blocks.Interfaces.RealInput signal_Y02
          "actual valve signal of Y02"
          annotation (Placement(transformation(extent={{-126,-50},{-86,-10}})));
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

        connect(Heizen.pd_b, selector_global.H) annotation (Line(points={{-71,64},{-76,
                64},{-76,-62},{-18.6,-62}},          color={255,0,255}));
        connect(selector_global.D_HK, Drift_HK.pd_b) annotation (Line(points={{-18.6,-65},
                {-76,-65},{-76,28},{12,28},{12,64},{11,64}},            color={
                255,0,255}));
        connect(Kuehlen.pd_b, selector_global.K) annotation (Line(points={{49,64},{46,
                64},{46,28},{-76,28},{-76,-68},{-18.6,-68}},         color={255,
                0,255}));
        connect(Befeuchten.pd_b, selector_global.B) annotation (Line(points={{-71,-8},
                {-76,-8},{-76,-72},{-18.6,-72}},         color={255,0,255}));
        connect(Drift_BE.pd_b, selector_global.D_BE) annotation (Line(points={{11,-8},
                {14,-8},{14,-50},{-76,-50},{-76,-75},{-18.6,-75}},        color=
               {255,0,255}));
        connect(Entfeuchten.pd_b, selector_global.E) annotation (Line(points={{49,-8},
                {44,-8},{44,-50},{-76,-50},{-76,-78},{-18.6,-78}},        color=
               {255,0,255}));
        connect(selector_global.ModeSelector, multiSwitch1.u[1:9]) annotation (Line(
              points={{2.6,-70},{20,-70},{20,-72.6667},{34,-72.6667}}, color={255,0,255}));
        connect(multiSwitch1.y, y) annotation (Line(points={{75,-70},{88,-70},{88,0},{
                106,0}}, color={255,127,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PN_Main1_RLT22;

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
            firingCon=RegAnf == false)
                              "schaltet Regeneration aus"
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
            firingCon=RegAnf == false)
                              "schaltet Regeneration aus"
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
            firingCon=RegAnf == false)
                              "schaltet Regeneration aus"
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

          parameter Real leak = 0.001 "leakage before the valve switches";
          parameter Real d = 300 "delay in s";

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
            firingCon=RegAnf == false)
                              "schaltet Regeneration aus"
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
            firingCon=RegAnf == false)
                              "Schaltet Regeneration ein"
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
            delay=d,
            firingCon=Y02_signal <= leak and T_out <= 293.15)
                                       "activates Heating Coil" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD HeatingCoil_Off(
            nIn=1,
            nOut=1,
            delay=d,
            firingCon=Y09_signal <= leak)
                                       "shuts Heating Coil off" annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={0,52})));
          PNlib.TD HeatingCoil1(
            nIn=1,
            nOut=1,
            delay=d,
            firingCon=Y02_signal <= leak and T_out <= 293.15)
                                       "activates Heating Coil" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={6,-20})));
          PNlib.TD HeatingCoil_Off1(
            nIn=1,
            nOut=1,
            delay=d,
            firingCon=Y09_signal <= leak)
                                       "shuts Heating Coil off" annotation (
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
          Modelica.Blocks.Interfaces.RealInput T_out "outside temperature"
            annotation (Placement(transformation(extent={{-126,-90},{-86,-50}})));
        equation

          connect(M8.outTransition[1], Regeneration_An.inPlaces[1]) annotation (Line(
              points={{-50.8,51.5},{-50.8,52},{-62,52},{-62,12.8}},
              color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_An.outPlaces[1], M16.inTransition[1])
            annotation (Line(points={{-62,3.2},{-62,-18},{-54.8,-19.5}},
                           color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M16.outTransition[1], Regeneration_Aus.inPlaces[1])
            annotation (Line(points={{-33.2,-19.5},{-20,-18},{-20,5.2}},
                         color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_Aus.outPlaces[1],M8. inTransition[1]) annotation (Line(
              points={{-20,14.8},{-20,52},{-29.2,52},{-29.2,51.5}},
              color={0,0,0},
              smooth=Smooth.Bezier));

          connect(multiSwitch1.y,HD_Out)  annotation (Line(points={{21,-92},{94,
                  -92},{94,0},{106,0}},
                               color={255,127,0}));
          connect(M20.outTransition[1], Regeneration_An1.inPlaces[1])
            annotation (Line(points={{72.8,-19.5},{82,-19.5},{82,11.2},{82,11.2}},
                                                                          color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_An1.outPlaces[1], M12.inTransition[1])
            annotation (Line(points={{82,20.8},{82,58},{72.8,58},{72.8,52.5}},
                color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M12.outTransition[1], Regeneration_Aus1.inPlaces[1])
            annotation (Line(points={{51.2,52.5},{51.2,52},{36,52},{36,20.8}},
                color={0,0,0},
              smooth=Smooth.Bezier));
          connect(Regeneration_Aus1.outPlaces[1], M20.inTransition[1])
            annotation (Line(points={{36,11.2},{36,12},{36,12},{36,-19.5},{51.2,
                  -19.5}},                                                color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M8.outTransition[2], HeatingCoil.inPlaces[1]) annotation (
              Line(points={{-50.8,52.5},{-60,52.5},{-60,84},{-4.8,84}}, color={0,0,0},
              smooth=Smooth.Bezier));
          connect(HeatingCoil.outPlaces[1], M12.inTransition[2]) annotation (
              Line(points={{4.8,84},{72.8,84},{72.8,51.5}}, color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M12.outTransition[2], HeatingCoil_Off.inPlaces[1])
            annotation (Line(points={{51.2,51.5},{14,51.5},{14,52},{4.8,52}},
                color={0,0,0},
              smooth=Smooth.Bezier));
          connect(HeatingCoil_Off.outPlaces[1], M8.inTransition[2]) annotation (
             Line(points={{-4.8,52},{-16,52},{-16,52},{-22,52},{-22,52.5},{
                  -29.2,52.5}},                                        color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M16.outTransition[2], HeatingCoil1.inPlaces[1]) annotation (
              Line(points={{-33.2,-20.5},{-16,-20.5},{-16,-20},{1.2,-20}},
                color={0,0,0},
              smooth=Smooth.Bezier));
          connect(HeatingCoil1.outPlaces[1], M20.inTransition[2]) annotation (
              Line(points={{10.8,-20},{40,-20},{40,-20.5},{51.2,-20.5}}, color={0,0,0},
              smooth=Smooth.Bezier));
          connect(M20.outTransition[2], HeatingCoil_Off1.inPlaces[1])
            annotation (Line(points={{72.8,-20.5},{80,-20.5},{80,-52},{10.8,-52}},
                color={0,0,0},
              smooth=Smooth.Bezier));
          connect(HeatingCoil_Off1.outPlaces[1], M16.inTransition[2])
            annotation (Line(points={{1.2,-52},{-60,-52},{-60,-24},{-54.8,-20.5}},
                           color={0,0,0},
              smooth=Smooth.Bezier));
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

          parameter Real leak = 0.001 "leakage before the valve switches";
          parameter Real d = 300 "delay in s";

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
            firingCon=RegAnf == false)
                              "schaltet Regeneration aus"
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
            firingCon=RegAnf == false)
                              "Schaltet Regeneration ein"
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
            delay=d,
            firingCon=Y02_signal <= leak and T_out <= 293.15)
                                       "activates Heating Coil" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD HeatingCoil_Off(
            nIn=1,
            nOut=1,
            delay=d,
            firingCon=Y09_signal <= leak)
                                       "shuts Heating Coil off" annotation (
              Placement(transformation(
                extent={{10,-10},{-10,10}},
                rotation=0,
                origin={0,52})));
          PNlib.TD HeatingCoil1(
            nIn=1,
            nOut=1,
            delay=d,
            firingCon=Y02_signal <= leak and T_out <= 293.15)
                                       "activates Heating Coil" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={6,-20})));
          PNlib.TD HeatingCoil_Off1(
            nIn=1,
            nOut=1,
            delay=d,
            firingCon=Y09_signal <= leak)
                                       "shuts Heating Coil off" annotation (
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
          Modelica.Blocks.Interfaces.RealInput T_out "outside temperature"
            annotation (Placement(transformation(extent={{-126,-90},{-86,-50}})));
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
            firingCon=RegAnf == false)
                              "schaltet Regeneration aus"
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
            firingCon=RegAnf == false)
                              "schaltet Regeneration aus"
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
            firingCon=RegAnf == false)
                              "schaltet Regeneration aus"
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
            firingCon=RegAnf == false)
                              "schaltet Regeneration aus"
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
          parameter Real k = 0.2;
          parameter Real Ti = 300;
          parameter Real k_cool = 0.2;
          parameter Real Ti_cool = 300;


          Modelica.Blocks.Interfaces.BooleanInput Y02_closed
            "Token value of Y02_closed"
            annotation (Placement(transformation(extent={{-128,70},{-88,110}})));
          Modelica.Blocks.Interfaces.BooleanInput Y02_open "Token value of Y02_open"
            annotation (Placement(transformation(extent={{-128,20},{-88,60}})));
          Modelica.Blocks.Interfaces.BooleanInput Y02_control
            "Token value of Y02_control"
            annotation (Placement(transformation(extent={{-128,-30},{-88,10}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{-16,68},{4,88}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{18,38},{38,58}})));
          Modelica.Blocks.Logical.Switch switch3
            annotation (Placement(transformation(extent={{70,10},{90,30}})));
          Modelica.Blocks.Sources.Constant closed(k=0)
            "valve value for closed valve"
            annotation (Placement(transformation(extent={{-64,76},{-44,96}})));
          Modelica.Blocks.Sources.Constant open(k=1) "valve value for open valve"
            annotation (Placement(transformation(extent={{-66,46},{-46,66}})));
          Modelica.Blocks.Continuous.LimPID PID(
            k=k,
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            Ti=Ti,
            yMax=1,
            yMin=0,
            initType=Modelica.Blocks.Types.InitPID.InitialOutput,
            y_start=1)
            annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
          Modelica.Blocks.Sources.Constant T_Soll(k=T_Set)
            "Set value for the measurement for Y02"
            annotation (Placement(transformation(extent={{-74,-6},{-54,14}})));
          Modelica.Blocks.Interfaces.RealInput T_measure
            "Measured value for T01" annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-108,-70})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            "valve is closed when there is no token in the PN"
            annotation (Placement(transformation(extent={{66,54},{46,74}})));
          Modelica.Blocks.Sources.Constant maxSignal(k=1)
            "maximum signal of controller"
            annotation (Placement(transformation(extent={{28,-40},{36,-32}})));
          Modelica.Blocks.Math.Feedback
                                   add
            annotation (Placement(transformation(extent={{44,-28},{60,-44}})));
          Modelica.Blocks.Logical.Switch adiabaticSwitch
            "validates, if adiabatic is on (then the signal for Y02 is proportional, else anti-proportional)"
            annotation (Placement(transformation(extent={{70,-38},{90,-18}})));
          Modelica.Blocks.Interfaces.BooleanInput adiabaticOn
            "signal true, if adiabatic cooling is switched on" annotation (
              Placement(transformation(extent={{128,-100},{88,-60}})));
          Modelica.Blocks.Logical.Switch switch4
            annotation (Placement(transformation(extent={{-72,-44},{-52,-24}})));
          Modelica.Blocks.Continuous.LimPID PID_cool(
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=1,
            yMin=0,
            initType=Modelica.Blocks.Types.InitPID.InitialOutput,
            y_start=1,
            k=k_cool,
            Ti=Ti_cool)
            annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
          Modelica.Blocks.Logical.Switch adiabaticSwitch1
            "validates, if adiabatic is on (then the signal for Y02 is proportional, else anti-proportional)"
            annotation (Placement(transformation(extent={{-52,-78},{-32,-58}})));
        equation
          connect(closed.y, switch1.u1) annotation (Line(points={{-43,86},{-18,86}},
                                 color={0,0,127}));
          connect(open.y, switch2.u1) annotation (Line(points={{-45,56},{16,56}},
                                   color={0,0,127}));
          connect(switch3.y, y) annotation (Line(points={{91,20},{98,20},{98,0},{106,0}},
                               color={0,0,127}));
          connect(switch2.y, switch3.u3) annotation (Line(points={{39,48},{50,48},{50,12},
                  {68,12}},           color={0,0,127}));
          connect(switch1.y, switch2.u3) annotation (Line(points={{5,78},{10,78},{10,40},
                  {16,40}},         color={0,0,127}));
          connect(security_closed.y, switch1.u3) annotation (Line(points={{45,64},{-24,64},
                  {-24,70},{-18,70}},              color={0,0,127}));
          connect(Y02_closed, switch1.u2)
            annotation (Line(points={{-108,90},{-70,90},{-70,78},{-18,78}},
                                                          color={255,0,255}));
          connect(Y02_open, switch2.u2)
            annotation (Line(points={{-108,40},{4,40},{4,48},{16,48}},
                                                       color={255,0,255}));
          connect(Y02_control, switch3.u2)
            annotation (Line(points={{-108,-10},{-80,-10},{-80,20},{68,20}},
                                                           color={255,0,255}));
          connect(T_Soll.y, PID.u_s)
            annotation (Line(points={{-53,4},{-46,4},{-46,-10},{-22,-10}},
                                                           color={0,0,127}));
          connect(adiabaticOn, adiabaticSwitch.u2) annotation (Line(points={{108,-80},{62,
                  -80},{62,-28},{68,-28}},              color={255,0,255}));
          connect(adiabaticSwitch.y, switch3.u1) annotation (Line(points={{91,-28},{94,-28},
                  {94,-8},{60,-8},{60,28},{68,28}}, color={0,0,127}));
          connect(add.y, adiabaticSwitch.u3) annotation (Line(points={{59.2,-36},{68,-36}},
                                               color={0,0,127}));
          connect(switch4.y, PID.u_m) annotation (Line(points={{-51,-34},{-10,-34},{-10,
                  -22}},           color={0,0,127}));
          connect(Y02_control, switch4.u2) annotation (Line(points={{-108,-10},{-80,-10},
                  {-80,-34},{-74,-34}},           color={255,0,255}));
          connect(T_measure, switch4.u1)
            annotation (Line(points={{-108,-70},{-82,-70},{-82,-26},{-74,-26}},
                                                            color={0,0,127}));
          connect(T_Soll.y, switch4.u3) annotation (Line(points={{-53,4},{-46,4},{-46,-50},
                  {-78,-50},{-78,-44},{-74,-44},{-74,-42}},      color={0,0,127}));
          connect(maxSignal.y, add.u1)
            annotation (Line(points={{36.4,-36},{45.6,-36}},
                                                           color={0,0,127}));
          connect(PID.y, add.u2) annotation (Line(points={{1,-10},{52,-10},{52,-29.6}},
                         color={0,0,127}));
          connect(T_measure, adiabaticSwitch1.u1) annotation (Line(points={{-108,-70},{-82,
                  -70},{-82,-60},{-54,-60}}, color={0,0,127}));
          connect(adiabaticOn, adiabaticSwitch1.u2) annotation (Line(points={{108,-80},{
                  -66,-80},{-66,-68},{-54,-68}}, color={255,0,255}));
          connect(T_Soll.y, adiabaticSwitch1.u3) annotation (Line(points={{-53,4},{-46,4},
                  {-46,-50},{-64,-50},{-64,-76},{-54,-76}}, color={0,0,127}));
          connect(adiabaticSwitch1.y, PID_cool.u_m)
            annotation (Line(points={{-31,-68},{-10,-68},{-10,-62}}, color={0,0,127}));
          connect(T_Soll.y, PID_cool.u_s) annotation (Line(points={{-53,4},{-46,4},{-46,
                  -50},{-22,-50}}, color={0,0,127}));
          connect(PID_cool.y, adiabaticSwitch.u1) annotation (Line(points={{1,-50},{20,-50},
                  {20,-20},{68,-20}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false), graphics={
                  Rectangle(
                  extent={{32,98},{96,80}},
                  lineColor={0,0,0},
                  fillColor={244,125,35},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{36,104},{90,74}},
                  lineColor={0,0,0},
                  textString="Technically you can delete this switch"),
                                                  Text(
                  extent={{-70,-82},{-32,-110}},
                  lineColor={0,0,0},
                  textString="prevent the PI controller 
from aggregating a difference,
 when it is noch switched on"),                   Text(
                  extent={{20,-72},{74,-100}},
                  lineColor={0,0,0},
                  textString="PI controller has to switch direction,
when cooling is active")}));
        end Y02_evaluation;

        model heaCoiEva
          "evaluates the PN of Y09 and Y10 (heating coils) and gives output value"

          parameter Real Setpoint = 1;
          parameter Real k = 0.2;
          parameter Real Ti = 300;

          Modelica.Blocks.Interfaces.BooleanInput Y_closed
            "Token value of Y_closed"
            annotation (Placement(transformation(extent={{-126,40},{-86,80}})));
          Modelica.Blocks.Interfaces.BooleanInput Y_control
            "Token value of Y_control" annotation (Placement(transformation(
                  extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
          Modelica.Blocks.Logical.Switch switch3
            annotation (Placement(transformation(extent={{68,-10},{88,10}})));
          Modelica.Blocks.Sources.Constant closed(k=0)
            "valve value for closed valve"
            annotation (Placement(transformation(extent={{-76,70},{-56,90}})));
          Modelica.Blocks.Continuous.LimPID PID(yMax=1, yMin=0,
            k=k,
            Ti=Ti,
            controllerType=Modelica.Blocks.Types.SimpleController.PI)
            annotation (Placement(transformation(extent={{4,-40},{24,-20}})));
          Modelica.Blocks.Sources.Constant SetValue(k=Setpoint)
            "Set value for the PI Control"
            annotation (Placement(transformation(extent={{-56,-40},{-36,-20}})));
          Modelica.Blocks.Interfaces.RealInput MeasuredValue
            "Measured value for PI_Control" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-70})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            "valve is closed when there is no token in the PN"
            annotation (Placement(transformation(extent={{-76,30},{-56,50}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{-14,-88},{6,-68}})));
        equation
          connect(SetValue.y, PID.u_s)
            annotation (Line(points={{-35,-30},{2,-30}}, color={0,0,127}));
          connect(closed.y, switch1.u1) annotation (Line(points={{-55,80},{-46,
                  80},{-46,68},{-32,68}},
                                 color={0,0,127}));
          connect(PID.y, switch3.u1) annotation (Line(points={{25,-30},{38,-30},{38,8},{
                  66,8}},             color={0,0,127}));
          connect(switch3.y, y) annotation (Line(points={{89,0},{106,0}},
                               color={0,0,127}));
          connect(security_closed.y, switch1.u3) annotation (Line(points={{-55,40},
                  {-46,40},{-46,52},{-32,52}},     color={0,0,127}));
          connect(Y_closed, switch1.u2)
            annotation (Line(points={{-106,60},{-32,60}}, color={255,0,255}));
          connect(Y_control, switch3.u2)
            annotation (Line(points={{-106,0},{66,0}}, color={255,0,255}));
          connect(switch1.y, switch3.u3) annotation (Line(points={{-9,60},{30,
                  60},{30,-8},{66,-8}}, color={0,0,127}));
          connect(switch2.y, PID.u_m)
            annotation (Line(points={{7,-78},{14,-78},{14,-42}}, color={0,0,127}));
          connect(Y_control, switch2.u2) annotation (Line(points={{-106,0},{-70,
                  0},{-70,-78},{-16,-78}}, color={255,0,255}));
          connect(MeasuredValue, switch2.u1)
            annotation (Line(points={{-106,-70},{-16,-70}}, color={0,0,127}));
          connect(SetValue.y, switch2.u3) annotation (Line(points={{-35,-30},{-24,-30},{
                  -24,-86},{-16,-86}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end heaCoiEva;

        model Y15_evaluationAdvanced "control evaluation output for Y15"

          parameter Real emptyTank_Set = 100;
          parameter Real halfTank_Set = 500;
          parameter Real k = 0.01;
          parameter Real Ti = 600;

          Modelica.Blocks.Interfaces.BooleanInput Y_closed
            "Token value of Y_closed"
            annotation (Placement(transformation(extent={{-126,50},{-86,90}})));
          Modelica.Blocks.Interfaces.BooleanInput Y_DesControl
            "Token value of Y_DesControl"
            annotation (Placement(transformation(extent={{-126,0},{-86,40}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{60,60},{80,80}})));
          Modelica.Blocks.Logical.Switch switch3
            annotation (Placement(transformation(extent={{24,36},{44,56}})));
          Modelica.Blocks.Sources.Constant closed(k=0)
            "valve value for closed valve"
            annotation (Placement(transformation(extent={{28,76},{48,96}})));
          Modelica.Blocks.Continuous.LimPID PID(yMax=1, yMin=0,
            k=k,
            Ti=Ti,
            controllerType=Modelica.Blocks.Types.SimpleController.PI)
            annotation (Placement(transformation(extent={{-18,40},{2,20}})));
          Modelica.Blocks.Sources.Constant emptyTank(k=emptyTank_Set)
            "Set value for the PI Control"
            annotation (Placement(transformation(extent={{-56,26},{-48,34}})));
          Modelica.Blocks.Interfaces.RealInput tankMassAbs
            "current mass of absorber tank for PI_Control" annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-70})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            "valve is closed when there is no token in the PN"
            annotation (Placement(transformation(extent={{24,-36},{4,-16}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{-54,40},{-34,60}})));
          Modelica.Blocks.Interfaces.BooleanInput Y_AbsDesControl
            "Token value of Y_AbsDesControl"
            annotation (Placement(transformation(extent={{-126,-50},{-86,-10}})));
          Modelica.Blocks.Logical.Switch switch4
            annotation (Placement(transformation(extent={{-8,-8},{12,12}})));
          Modelica.Blocks.Continuous.LimPID PID1(
                                                yMax=1, yMin=0,
            k=k,
            Ti=Ti,
            controllerType=Modelica.Blocks.Types.SimpleController.PI)
            annotation (Placement(transformation(extent={{-38,-26},{-18,-6}})));
          Modelica.Blocks.Sources.Constant fullTank1(k=halfTank_Set)
            "Set value for the PI Control"
            annotation (Placement(transformation(extent={{-92,-10},{-84,-2}})));
          Modelica.Blocks.Logical.Switch switch5
            annotation (Placement(transformation(extent={{-54,-54},{-34,-34}})));
          Modelica.Blocks.Math.Feedback feedback
            annotation (Placement(transformation(extent={{42,58},{52,68}})));
          Modelica.Blocks.Sources.RealExpression realExpression(y=1)
            annotation (Placement(transformation(extent={{16,56},{28,70}})));
          Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(
              threshold=80) annotation (Placement(transformation(extent={{-56,
                    -80},{-36,-60}})));
          Modelica.Blocks.Logical.Switch switch6
            annotation (Placement(transformation(extent={{66,-10},{86,10}})));
        equation
          connect(emptyTank.y, PID.u_s)
            annotation (Line(points={{-47.6,30},{-20,30}}, color={0,0,127}));
          connect(closed.y, switch1.u1) annotation (Line(points={{49,86},{54,86},{54,78},
                  {58,78}},      color={0,0,127}));
          connect(Y_closed, switch1.u2)
            annotation (Line(points={{-106,70},{58,70}},  color={255,0,255}));
          connect(Y_DesControl, switch3.u2)
            annotation (Line(points={{-106,20},{-24,20},{-24,46},{22,46}},
                                                         color={255,0,255}));
          connect(switch2.y, PID.u_m)
            annotation (Line(points={{-33,50},{-8,50},{-8,42}},  color={0,0,127}));
          connect(Y_DesControl, switch2.u2) annotation (Line(points={{-106,20},
                  {-84,20},{-84,50},{-56,50}},
                                    color={255,0,255}));
          connect(tankMassAbs, switch2.u1) annotation (Line(points={{-106,-70},
                  {-72,-70},{-72,58},{-56,58}},
                                              color={0,0,127}));
          connect(emptyTank.y, switch2.u3) annotation (Line(points={{-47.6,30},
                  {-66,30},{-66,42},{-56,42}}, color={0,0,127}));
          connect(Y_AbsDesControl, switch4.u2)
            annotation (Line(points={{-106,-30},{-46,-30},{-46,2},{-10,2}},
                                                           color={255,0,255}));
          connect(switch5.y, PID1.u_m)
            annotation (Line(points={{-33,-44},{-28,-44},{-28,-28}}, color={0,0,127}));
          connect(fullTank1.y, PID1.u_s)
            annotation (Line(points={{-83.6,-6},{-52,-6},{-52,-16},{-40,-16}},
                                                             color={0,0,127}));
          connect(fullTank1.y, switch5.u3) annotation (Line(points={{-83.6,-6},
                  {-66,-6},{-66,-52},{-56,-52}},
                                        color={0,0,127}));
          connect(tankMassAbs, switch5.u1)
            annotation (Line(points={{-106,-70},{-72,-70},{-72,-36},{-56,-36}},
                                                            color={0,0,127}));
          connect(Y_AbsDesControl, switch5.u2) annotation (Line(points={{-106,
                  -30},{-68,-30},{-68,-44},{-56,-44}},
                                             color={255,0,255}));
          connect(PID.y, switch3.u1) annotation (Line(points={{3,30},{6,30},{6,
                  54},{22,54}},
                        color={0,0,127}));
          connect(PID1.y, switch4.u1) annotation (Line(points={{-17,-16},{-16,
                  -16},{-16,10},{-10,10}},
                             color={0,0,127}));
          connect(security_closed.y, switch4.u3)
            annotation (Line(points={{3,-26},{-10,-26},{-10,-6}}, color={0,0,127}));
          connect(switch4.y, switch3.u3) annotation (Line(points={{13,2},{16,2},
                  {16,38},{22,38}},           color={0,0,127}));
          connect(switch3.y, feedback.u2) annotation (Line(points={{45,46},{47,
                  46},{47,59}}, color={0,0,127}));
          connect(feedback.y, switch1.u3) annotation (Line(points={{51.5,63},{
                  54,63},{54,62},{58,62}}, color={0,0,127}));
          connect(realExpression.y, feedback.u1)
            annotation (Line(points={{28.6,63},{43,63}}, color={0,0,127}));
          connect(tankMassAbs, lessEqualThreshold.u)
            annotation (Line(points={{-106,-70},{-58,-70}}, color={0,0,127}));
          connect(lessEqualThreshold.y, switch6.u2) annotation (Line(points={{
                  -35,-70},{46,-70},{46,0},{64,0}}, color={255,0,255}));
          connect(security_closed.y, switch6.u1) annotation (Line(points={{3,
                  -26},{-12,-26},{-12,-46},{34,-46},{34,8},{64,8}}, color={0,0,
                  127}));
          connect(switch1.y, switch6.u3) annotation (Line(points={{81,70},{86,
                  70},{86,26},{52,26},{52,-8},{64,-8}}, color={0,0,127}));
          connect(switch6.y, y)
            annotation (Line(points={{87,0},{106,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Y15_evaluationAdvanced;

        model Y16_evaluationAdvanced "control evaluation output for Y16"

          parameter Real fullTank_Set = 900;
          parameter Real x_Set = 0.4;
          parameter Real k_x = 2;
          parameter Real Ti_x = 180;
          parameter Real k_m = 0.01;
          parameter Real Ti_m = 600;

          Modelica.Blocks.Interfaces.BooleanInput Y_closed
            "Token value of Y_closed"
            annotation (Placement(transformation(extent={{-126,70},{-86,110}})));
          Modelica.Blocks.Interfaces.BooleanInput Y_AbsControl
            "Token value of Y_AbsControl"
            annotation (Placement(transformation(extent={{-126,30},{-86,70}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{58,60},{78,80}})));
          Modelica.Blocks.Logical.Switch switch3
            annotation (Placement(transformation(extent={{14,48},{34,68}})));
          Modelica.Blocks.Sources.Constant closed(k=0)
            "valve value for closed valve"
            annotation (Placement(transformation(extent={{28,76},{48,96}})));
          Modelica.Blocks.Continuous.LimPID PID(yMax=1, yMin=0,
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            k=k_m,
            Ti=Ti_m)
            annotation (Placement(transformation(extent={{-26,38},{-6,18}})));
          Modelica.Blocks.Sources.Constant fullTank(k=fullTank_Set)
            "Set value for the PI Control"
            annotation (Placement(transformation(extent={{-90,24},{-82,32}})));
          Modelica.Blocks.Interfaces.RealInput tankMassAbs
            "current value of absorber tank mass for PI_Control" annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-30})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            "valve is closed when there is no token in the PN"
            annotation (Placement(transformation(extent={{36,-24},{16,-4}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{-58,34},{-38,54}})));
          Modelica.Blocks.Interfaces.BooleanInput Y_DesControl
            "Token value of Y_DesControl" annotation (Placement(transformation(
                  extent={{-126,-10},{-86,30}})));
          Modelica.Blocks.Logical.Switch switch4
            annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));
          Modelica.Blocks.Continuous.LimPID PID1(
                                                yMax=1, yMin=0,
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            k=k_x,
            Ti=Ti_x)
            annotation (Placement(transformation(extent={{-46,-46},{-26,-26}})));
          Modelica.Blocks.Sources.Constant fullTank1(k=x_Set)
            "Set value for the PI Control"
            annotation (Placement(transformation(extent={{-90,-14},{-82,-6}})));
          Modelica.Blocks.Logical.Switch switch5
            annotation (Placement(transformation(extent={{-60,-78},{-40,-58}})));
          Modelica.Blocks.Interfaces.RealInput xAbs
            "current concentration of absorber tank for PI_Control"
            annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-60})));
          Modelica.Blocks.Logical.Switch switch6
            annotation (Placement(transformation(extent={{64,-10},{84,10}})));
          Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(
              threshold=80)
            annotation (Placement(transformation(extent={{0,-100},{20,-80}})));
          Modelica.Blocks.Interfaces.RealInput tankMassDes
            "current value of desorber tank as safety measure" annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-90})));
        equation
          connect(fullTank.y, PID.u_s)
            annotation (Line(points={{-81.6,28},{-28,28}},
                                                         color={0,0,127}));
          connect(closed.y, switch1.u1) annotation (Line(points={{49,86},{52,86},{52,78},
                  {56,78}},      color={0,0,127}));
          connect(Y_closed, switch1.u2)
            annotation (Line(points={{-106,90},{-26,90},{-26,70},{56,70}},
                                                          color={255,0,255}));
          connect(Y_AbsControl, switch3.u2) annotation (Line(points={{-106,50},
                  {-80,50},{-80,58},{12,58}}, color={255,0,255}));
          connect(switch2.y, PID.u_m)
            annotation (Line(points={{-37,44},{-16,44},{-16,40}},color={0,0,127}));
          connect(Y_AbsControl, switch2.u2) annotation (Line(points={{-106,50},
                  {-84,50},{-84,44},{-60,44}}, color={255,0,255}));
          connect(tankMassAbs, switch2.u1) annotation (Line(points={{-106,-30},
                  {-72,-30},{-72,52},{-60,52}},
                                              color={0,0,127}));
          connect(fullTank.y, switch2.u3) annotation (Line(points={{-81.6,28},{
                  -68,28},{-68,36},{-60,36}},
                                       color={0,0,127}));
          connect(Y_DesControl, switch4.u2) annotation (Line(points={{-106,10},
                  {-60,10},{-60,0},{-28,0}}, color={255,0,255}));
          connect(switch5.y, PID1.u_m)
            annotation (Line(points={{-39,-68},{-36,-68},{-36,-48}}, color={0,0,127}));
          connect(fullTank1.y, PID1.u_s)
            annotation (Line(points={{-81.6,-10},{-56,-10},{-56,-36},{-48,-36}},
                                                             color={0,0,127}));
          connect(fullTank1.y, switch5.u3) annotation (Line(points={{-81.6,-10},
                  {-66,-10},{-66,-76},{-62,-76}},
                                        color={0,0,127}));
          connect(Y_DesControl, switch5.u2) annotation (Line(points={{-106,10},
                  {-68,10},{-68,-68},{-62,-68}}, color={255,0,255}));
          connect(xAbs, switch5.u1) annotation (Line(points={{-106,-60},{-62,
                  -60}},      color={0,0,127}));
          connect(PID.y, switch3.u1) annotation (Line(points={{-5,28},{-2,28},{
                  -2,66},{12,66}},      color={0,0,127}));
          connect(security_closed.y, switch4.u3)
            annotation (Line(points={{15,-14},{-32,-14},{-32,-8},{-28,-8}},
                                                                  color={0,0,127}));
          connect(switch3.y, switch1.u3) annotation (Line(points={{35,58},{48,
                  58},{48,62},{56,62}},     color={0,0,127}));
          connect(switch4.y, switch3.u3) annotation (Line(points={{-5,0},{0,0},
                  {0,50},{12,50}},            color={0,0,127}));
          connect(PID1.y, switch4.u1) annotation (Line(points={{-25,-36},{-22,
                  -36},{-22,-20},{-34,-20},{-34,8},{-28,8}}, color={0,0,127}));
          connect(switch1.y, switch6.u3) annotation (Line(points={{79,70},{82,
                  70},{82,38},{48,38},{48,-8},{62,-8}}, color={0,0,127}));
          connect(lessEqualThreshold.y, switch6.u2) annotation (Line(points={{
                  21,-90},{42,-90},{42,0},{62,0}}, color={255,0,255}));
          connect(security_closed.y, switch6.u1) annotation (Line(points={{15,
                  -14},{8,-14},{8,8},{62,8}}, color={0,0,127}));
          connect(tankMassDes, lessEqualThreshold.u)
            annotation (Line(points={{-106,-90},{-2,-90}}, color={0,0,127}));
          connect(switch6.y, y)
            annotation (Line(points={{85,0},{106,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Y16_evaluationAdvanced;

        model bypassEva "evaluates the PN of bypass valves, Y06"

          parameter Real phi_Set = 0.5;
          parameter Real k = 5;
          parameter Real Ti = 180;

          Modelica.Blocks.Interfaces.BooleanInput Y_open "Token value of Y_open"
            annotation (Placement(transformation(extent={{-126,40},{-86,80}})));
          Modelica.Blocks.Interfaces.BooleanInput Y_control
            "Token value of Y_control" annotation (Placement(transformation(
                  extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{66,8},{86,28}})));
          Modelica.Blocks.Logical.Switch switch3
            annotation (Placement(transformation(extent={{36,-10},{56,10}})));
          Modelica.Blocks.Sources.Constant open(k=1)
            "valve value for closed valve"
            annotation (Placement(transformation(extent={{18,24},{38,44}})));
          Modelica.Blocks.Continuous.LimPID PID(yMax=1, yMin=0,
            k=k,
            Ti=Ti,
            controllerType=Modelica.Blocks.Types.SimpleController.PI)
            annotation (Placement(transformation(extent={{-4,-40},{16,-20}})));
          Modelica.Blocks.Sources.Constant SetValue(k=phi_Set)
            "Set value for the PI Control"
            annotation (Placement(transformation(extent={{-62,-40},{-42,-20}})));
          Modelica.Blocks.Interfaces.RealInput phi_zu "Measured value for PI_Control" annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-70})));
          Modelica.Blocks.Sources.Constant security_open(k=1)
            "valve is open when there is no token in the PN"
            annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{-26,-88},{-6,-68}})));
        equation
          connect(SetValue.y, PID.u_s)
            annotation (Line(points={{-41,-30},{-6,-30}},color={0,0,127}));
          connect(open.y, switch1.u1) annotation (Line(points={{39,34},{50,34},
                  {50,26},{64,26}}, color={0,0,127}));
          connect(Y_open, switch1.u2)
            annotation (Line(points={{-106,60},{-70,60},{-70,18},{64,18}},
                                                          color={255,0,255}));
          connect(Y_control, switch3.u2)
            annotation (Line(points={{-106,0},{34,0}}, color={255,0,255}));
          connect(switch2.y, PID.u_m)
            annotation (Line(points={{-5,-78},{6,-78},{6,-42}},  color={0,0,127}));
          connect(Y_control, switch2.u2) annotation (Line(points={{-106,0},{-70,
                  0},{-70,-78},{-28,-78}}, color={255,0,255}));
          connect(phi_zu, switch2.u1)
            annotation (Line(points={{-106,-70},{-28,-70}}, color={0,0,127}));
          connect(SetValue.y, switch2.u3) annotation (Line(points={{-41,-30},{
                  -34,-30},{-34,-86},{-28,-86}},
                                       color={0,0,127}));
          connect(security_open.y, switch3.u3) annotation (Line(points={{39,-30},
                  {30,-30},{30,-8},{34,-8}}, color={0,0,127}));
          connect(PID.y, switch3.u1) annotation (Line(points={{17,-30},{26,-30},
                  {26,8},{34,8},{34,8}}, color={0,0,127}));
          connect(switch3.y, switch1.u3) annotation (Line(points={{57,0},{58,0},
                  {58,10},{64,10}}, color={0,0,127}));
          connect(switch1.y, y) annotation (Line(points={{87,18},{92,18},{92,0},
                  {106,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end bypassEva;

        model Y15_evaluation "control evaluation output for Y15"

          parameter Real halfTank_Set = 500;
          parameter Real k = 0.01;
          parameter Real Ti = 600;

          Modelica.Blocks.Interfaces.BooleanInput Y_closed
            "Token value of Y_closed"
            annotation (Placement(transformation(extent={{-126,40},{-86,80}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{60,50},{80,70}})));
          Modelica.Blocks.Sources.Constant closed(k=0)
            "valve value for closed valve"
            annotation (Placement(transformation(extent={{20,70},{40,90}})));
          Modelica.Blocks.Interfaces.RealInput tankMassAbs
            "current mass of absorber tank for PI_Control" annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-70})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            "valve is closed when there is no token in the PN"
            annotation (Placement(transformation(extent={{-16,-36},{4,-16}})));
          Modelica.Blocks.Interfaces.BooleanInput Y_AbsDesControl
            "Token value of Y_AbsDesControl"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Logical.Switch switch4
            annotation (Placement(transformation(extent={{16,20},{36,40}})));
          Modelica.Blocks.Continuous.LimPID PID1(
                                                yMax=1, yMin=0,
            k=k,
            Ti=Ti,
            controllerType=Modelica.Blocks.Types.SimpleController.PI)
            annotation (Placement(transformation(extent={{-34,28},{-14,48}})));
          Modelica.Blocks.Sources.Constant fullTank1(k=halfTank_Set)
            "Set value for the PI Control"
            annotation (Placement(transformation(extent={{-84,34},{-76,42}})));
          Modelica.Blocks.Logical.Switch switch5
            annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
          Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=80)
            annotation (Placement(transformation(extent={{-56,-80},{-36,-60}})));
          Modelica.Blocks.Logical.Switch switch6
            annotation (Placement(transformation(extent={{66,-10},{86,10}})));
          Modelica.Blocks.Math.Feedback feedback
            annotation (Placement(transformation(extent={{36,46},{48,58}})));
          Modelica.Blocks.Sources.RealExpression realExpression(y=1)
            annotation (Placement(transformation(extent={{2,44},{18,60}})));
        equation
          connect(closed.y, switch1.u1) annotation (Line(points={{41,80},{54,80},
                  {54,68},{58,68}},
                                 color={0,0,127}));
          connect(Y_closed, switch1.u2)
            annotation (Line(points={{-106,60},{58,60}},  color={255,0,255}));
          connect(Y_AbsDesControl, switch4.u2)
            annotation (Line(points={{-106,0},{-58,0},{-58,30},{14,30}},
                                                           color={255,0,255}));
          connect(switch5.y, PID1.u_m)
            annotation (Line(points={{-27,0},{-24,0},{-24,26}},      color={0,0,127}));
          connect(fullTank1.y, PID1.u_s)
            annotation (Line(points={{-75.6,38},{-36,38}},   color={0,0,127}));
          connect(fullTank1.y, switch5.u3) annotation (Line(points={{-75.6,38},
                  {-66,38},{-66,-8},{-50,-8}},
                                        color={0,0,127}));
          connect(tankMassAbs, switch5.u1)
            annotation (Line(points={{-106,-70},{-72,-70},{-72,8},{-50,8}},
                                                            color={0,0,127}));
          connect(Y_AbsDesControl, switch5.u2) annotation (Line(points={{-106,0},
                  {-50,0}},                  color={255,0,255}));
          connect(PID1.y, switch4.u1) annotation (Line(points={{-13,38},{14,38}},
                             color={0,0,127}));
          connect(security_closed.y, switch4.u3)
            annotation (Line(points={{5,-26},{10,-26},{10,22},{14,22}},
                                                                  color={0,0,127}));
          connect(tankMassAbs, lessEqualThreshold.u)
            annotation (Line(points={{-106,-70},{-58,-70}}, color={0,0,127}));
          connect(lessEqualThreshold.y, switch6.u2) annotation (Line(points={{-35,-70},{
                  46,-70},{46,0},{64,0}}, color={255,0,255}));
          connect(security_closed.y, switch6.u1) annotation (Line(points={{5,-26},
                  {44,-26},{44,8},{64,8}},           color={0,0,127}));
          connect(switch1.y, switch6.u3) annotation (Line(points={{81,60},{86,
                  60},{86,26},{52,26},{52,-8},{64,-8}},
                                            color={0,0,127}));
          connect(switch6.y, y)
            annotation (Line(points={{87,0},{106,0}}, color={0,0,127}));
          connect(realExpression.y, feedback.u1)
            annotation (Line(points={{18.8,52},{37.2,52}}, color={0,0,127}));
          connect(switch4.y, feedback.u2) annotation (Line(points={{37,30},{42,
                  30},{42,47.2}}, color={0,0,127}));
          connect(feedback.y, switch1.u3)
            annotation (Line(points={{47.4,52},{58,52}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Y15_evaluation;

        model Y16_evaluation "control evaluation output for Y16"

          parameter Real x_Set = 0.4;
          parameter Real k_x = 2;
          parameter Real Ti_x = 180;
          parameter Real k_m = 0.01;
          parameter Real Ti_m = 600;

          Modelica.Blocks.Interfaces.BooleanInput Y_closed
            "Token value of Y_closed"
            annotation (Placement(transformation(extent={{-126,60},{-86,100}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{60,60},{80,80}})));
          Modelica.Blocks.Sources.Constant closed(k=0)
            "valve value for closed valve"
            annotation (Placement(transformation(extent={{20,76},{40,96}})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            "valve is closed when there is no token in the PN"
            annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
          Modelica.Blocks.Interfaces.BooleanInput Y_AbsDesControl
            "Token value of Y_AbsDesControl"
            annotation (Placement(transformation(extent={{-126,0},{-86,40}})));
          Modelica.Blocks.Logical.Switch switch4
            annotation (Placement(transformation(extent={{10,34},{30,54}})));
          Modelica.Blocks.Continuous.LimPID PID1(
                                                yMax=1, yMin=0,
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            k=k_x,
            Ti=Ti_x)
            annotation (Placement(transformation(extent={{-26,18},{-6,38}})));
          Modelica.Blocks.Sources.Constant fullTank1(k=x_Set)
            "Set value for the PI Control"
            annotation (Placement(transformation(extent={{-84,-4},{-76,4}})));
          Modelica.Blocks.Logical.Switch switch5
            annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
          Modelica.Blocks.Interfaces.RealInput xAbs
            "current concentration of absorber tank for PI_Control"
            annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-30})));
          Modelica.Blocks.Logical.Switch switch6
            annotation (Placement(transformation(extent={{64,-10},{84,10}})));
          Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=80)
            annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
          Modelica.Blocks.Interfaces.RealInput tankMassDes
            "current value of desorber tank as safety measure" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-70})));
        equation
          connect(closed.y, switch1.u1) annotation (Line(points={{41,86},{52,86},{52,78},
                  {58,78}},      color={0,0,127}));
          connect(Y_closed, switch1.u2)
            annotation (Line(points={{-106,80},{-26,80},{-26,70},{58,70}},
                                                          color={255,0,255}));
          connect(Y_AbsDesControl, switch4.u2) annotation (Line(points={{-106,20},{-60,20},
                  {-60,44},{8,44}}, color={255,0,255}));
          connect(switch5.y, PID1.u_m)
            annotation (Line(points={{-19,-10},{-16,-10},{-16,16}},  color={0,0,127}));
          connect(fullTank1.y, PID1.u_s)
            annotation (Line(points={{-75.6,0},{-66,0},{-66,28},{-28,28}},
                                                             color={0,0,127}));
          connect(fullTank1.y, switch5.u3) annotation (Line(points={{-75.6,0},{-66,0},{-66,
                  -18},{-42,-18}},      color={0,0,127}));
          connect(Y_AbsDesControl, switch5.u2) annotation (Line(points={{-106,20},{-62,20},
                  {-62,-10},{-42,-10}}, color={255,0,255}));
          connect(xAbs, switch5.u1) annotation (Line(points={{-106,-30},{-60,-30},{-60,-2},
                  {-42,-2}},  color={0,0,127}));
          connect(security_closed.y, switch4.u3)
            annotation (Line(points={{-19,-40},{4,-40},{4,36},{8,36}},
                                                                  color={0,0,127}));
          connect(PID1.y, switch4.u1)
            annotation (Line(points={{-5,28},{0,28},{0,52},{8,52}}, color={0,0,127}));
          connect(switch1.y, switch6.u3) annotation (Line(points={{81,70},{84,70},{84,38},
                  {54,38},{54,-8},{62,-8}}, color={0,0,127}));
          connect(lessEqualThreshold.y, switch6.u2) annotation (Line(points={{21,-70},{42,
                  -70},{42,0},{62,0}}, color={255,0,255}));
          connect(security_closed.y, switch6.u1) annotation (Line(points={{-19,-40},{36,
                  -40},{36,8},{62,8}}, color={0,0,127}));
          connect(tankMassDes, lessEqualThreshold.u)
            annotation (Line(points={{-106,-70},{-2,-70}}, color={0,0,127}));
          connect(switch6.y, y)
            annotation (Line(points={{85,0},{106,0}}, color={0,0,127}));
          connect(switch4.y, switch1.u3) annotation (Line(points={{31,44},{42,44},{42,62},
                  {58,62}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Y16_evaluation;

        model Y16_evaluationSimple "control evaluation output for Y16"

          parameter Real x_Set = 0.4;

          Modelica.Blocks.Interfaces.BooleanInput Y_closed
            "Token value of Y_closed"
            annotation (Placement(transformation(extent={{-126,40},{-86,80}})));
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{60,60},{80,80}})));
          Modelica.Blocks.Sources.Constant closed(k=0)
            "valve value for closed valve"
            annotation (Placement(transformation(extent={{20,76},{40,96}})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            "valve is closed when there is no token in the PN"
            annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
          Modelica.Blocks.Interfaces.BooleanInput Y_AbsDesControl
            "Token value of Y_AbsDesControl"
            annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
          Modelica.Blocks.Logical.Switch switch4
            annotation (Placement(transformation(extent={{10,34},{30,54}})));
          Modelica.Blocks.Logical.Switch switch6
            annotation (Placement(transformation(extent={{64,-10},{84,10}})));
          Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=80)
            annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
          Modelica.Blocks.Interfaces.RealInput tankMassDes
            "current value of desorber tank as safety measure" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-70})));
          Modelica.Blocks.Sources.RealExpression realExpression(y=0.8)
            annotation (Placement(transformation(extent={{-34,42},{-14,62}})));
        equation
          connect(closed.y, switch1.u1) annotation (Line(points={{41,86},{52,86},{52,78},
                  {58,78}},      color={0,0,127}));
          connect(Y_closed, switch1.u2)
            annotation (Line(points={{-106,60},{-24,60},{-24,70},{58,70}},
                                                          color={255,0,255}));
          connect(Y_AbsDesControl, switch4.u2) annotation (Line(points={{-106,0},{-60,0},
                  {-60,44},{8,44}}, color={255,0,255}));
          connect(security_closed.y, switch4.u3)
            annotation (Line(points={{-19,-40},{4,-40},{4,36},{8,36}},
                                                                  color={0,0,127}));
          connect(switch1.y, switch6.u3) annotation (Line(points={{81,70},{84,70},{84,38},
                  {54,38},{54,-8},{62,-8}}, color={0,0,127}));
          connect(lessEqualThreshold.y, switch6.u2) annotation (Line(points={{21,-70},{42,
                  -70},{42,0},{62,0}}, color={255,0,255}));
          connect(security_closed.y, switch6.u1) annotation (Line(points={{-19,-40},{36,
                  -40},{36,8},{62,8}}, color={0,0,127}));
          connect(tankMassDes, lessEqualThreshold.u)
            annotation (Line(points={{-106,-70},{-2,-70}}, color={0,0,127}));
          connect(switch6.y, y)
            annotation (Line(points={{85,0},{106,0}}, color={0,0,127}));
          connect(switch4.y, switch1.u3) annotation (Line(points={{31,44},{42,44},{42,62},
                  {58,62}}, color={0,0,127}));
          connect(realExpression.y, switch4.u1)
            annotation (Line(points={{-13,52},{8,52}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Y16_evaluationSimple;
      end Auswertemodule;

      package Aktoren
        extends Modelica.Icons.InterfacesPackage;

        model Y_On_Off
          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Y_closed(
            nOut=1,
            nIn=1,
            startTokens=1) "valve closed, output value 0" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool Y_open(nIn=1, nOut=1) "valve open, output value 1" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=Y_Open.y == true) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(
            nOut=1,
            nIn=1,
            firingCon=Y_Close.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          Modelica.Blocks.Interfaces.RealOutput setValue_Y "set value for valve Y"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modes.Evaluator.iselement Y_Close(n=22, modes={1,2,3,4,5,6,7,8,9,10,
                11,12,13,14,15,17,18,19,20,21,22,23})
                                            annotation (Placement(transformation(extent=
                   {{-96,66},{-86,76}})), Dialog(group="PN Configuration On->Off",
                enable=true));
          Modes.Evaluator.iselement Y_Open(n=1, modes={16})
                                           annotation (Placement(transformation(extent={
                    {-96,80},{-86,90}})), Dialog(group="PN Configuration Off->On",
                enable=true));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{34,-32},{54,-12}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{-14,0},{6,20}})));
          Modelica.Blocks.Sources.Constant closed(k=0)
            annotation (Placement(transformation(extent={{-40,14},{-30,24}})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            annotation (Placement(transformation(extent={{-40,-4},{-30,6}})));
          Modelica.Blocks.Sources.Constant open(k=1)
            annotation (Placement(transformation(extent={{40,-6},{30,4}})));
        equation
          connect(Y_closed.outTransition[1], T1.inPlaces[1])
            annotation (Line(points={{-44,78.8},{-44,84},{-4.8,84}}, color={0,0,0}));
          connect(T1.outPlaces[1], Y_open.inTransition[1])
            annotation (Line(points={{4.8,84},{48,84},{48,78.8}}, color={0,0,0}));
          connect(T2.outPlaces[1], Y_closed.inTransition[1])
            annotation (Line(points={{-4.8,52},{-44,52},{-44,57.2}}, color={0,0,0}));
          connect(Y_open.outTransition[1], T2.inPlaces[1])
            annotation (Line(points={{48,57.2},{48,52},{4.8,52}}, color={0,0,0}));
          connect(M_in, Y_Close.u) annotation (Line(points={{-108,0},{-102,0},{-102,74.5},
                  {-96,74.5}}, color={255,127,0}));
          connect(M_in, Y_Open.u) annotation (Line(points={{-108,0},{-102,0},{-102,88.5},
                  {-96,88.5}}, color={255,127,0}));
          connect(closed.y, switch2.u1) annotation (Line(points={{-29.5,19},{-26,19},{-26,
                  18},{-16,18}}, color={0,0,127}));
          connect(security_closed.y, switch2.u3)
            annotation (Line(points={{-29.5,1},{-29.5,2},{-16,2}}, color={0,0,127}));
          connect(Y_closed.pd_b, switch2.u2) annotation (Line(points={{-55,68},{-58,68},
                  {-58,10},{-16,10}}, color={255,0,255}));
          connect(Y_open.pd_b, switch1.u2) annotation (Line(points={{59,68},{64,68},{64,
                  18},{20,18},{20,-22},{32,-22}}, color={255,0,255}));
          connect(switch2.y, switch1.u3) annotation (Line(points={{7,10},{12,10},{12,-30},
                  {32,-30}}, color={0,0,127}));
          connect(open.y, switch1.u1) annotation (Line(points={{29.5,-1},{24.25,-1},{24.25,
                  -14},{32,-14}}, color={0,0,127}));
          connect(switch1.y, setValue_Y) annotation (Line(points={{55,-22},{78,-22},{78,
                  0},{106,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end Y_On_Off;

        model controlvalve2 "control valve with 2 states"
          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Y_closed(
            nOut=1,
            nIn=1,
            startTokens=1) "valve closed, output value 0" annotation (Placement(
                transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-2,70})));
          PNlib.PDBool Y_control(nIn=1, nOut=1)
            "Y is in controlled modus with a PID controller" annotation (
              Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=0,
                origin={0,20})));
          PNlib.TD T5(
            nIn=1,
            nOut=1,
            firingCon=Y_Close.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={60,44})));
          PNlib.TD T6(
            nOut=1,
            nIn=1,
            firingCon=Y_Control.y == true) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=90,
                origin={-58,44})));
          Modes.Evaluator.iselement Y_Close(n=22, modes={1,2,3,4,5,6,7,8,9,10,
                11,12,13,14,15,16,17,18,19,20,22,23})       annotation (
              Placement(transformation(extent={{-96,66},{-86,76}})), Dialog(
                group="PN Configuration On->Off", enable=true));
          Modes.Evaluator.iselement Y_Control(n=1, modes={21})
                                             annotation (Placement(
                transformation(extent={{-96,46},{-86,56}})), Dialog(group=
                  "PN Configuration Off->On", enable=true));
          Modelica.Blocks.Interfaces.BooleanOutput Close
            annotation (Placement(transformation(extent={{98,50},{118,70}})));
          Modelica.Blocks.Interfaces.BooleanOutput Control
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
        equation
          connect(T6.outPlaces[1], Y_control.inTransition[1]) annotation (Line(
                points={{-58,39.2},{-58,20},{-10.8,20}}, color={0,0,0}));
          connect(Y_control.outTransition[1], T5.inPlaces[1]) annotation (Line(
                points={{10.8,20},{60,20},{60,39.2}}, color={0,0,0}));
          connect(T5.outPlaces[1], Y_closed.inTransition[1]) annotation (Line(
                points={{60,48.8},{60,70},{8.8,70}}, color={0,0,0}));
          connect(Y_closed.outTransition[1], T6.inPlaces[1]) annotation (Line(
                points={{-12.8,70},{-58,70},{-58,48.8}}, color={0,0,0}));
          connect(M_in, Y_Close.u) annotation (Line(points={{-108,0},{-102,0},{
                  -102,74.5},{-96,74.5}}, color={255,127,0}));
          connect(M_in, Y_Control.u) annotation (Line(points={{-108,0},{-102,0},
                  {-102,54.5},{-96,54.5}}, color={255,127,0}));
          connect(Y_closed.pd_b, Close) annotation (Line(points={{-2,81},{-2,90},
                  {80,90},{80,60},{108,60}}, color={255,0,255}));
          connect(Y_control.pd_b, Control) annotation (Line(points={{0,9},{0,9},
                  {0,0},{106,0}}, color={255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end controlvalve2;

        model Fan_On_Off "on off control for fan"

          parameter Real mFlow_Set = 5 "Setpoint for Mass flow of fan";
          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Fan_off(
            nOut=1,
            nIn=1,
            startTokens=1) "Fan is switched off, signal 0" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool Fan_on(nIn=1, nOut=1)
            "Fan is switched on, runs on nominal value" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=Fan_On.y == true) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(
            nOut=1,
            nIn=1,
            firingCon=Fan_Off.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          Modelica.Blocks.Interfaces.RealOutput massFlow_Fan
            "set value for mass Flow of Fan"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modes.Evaluator.iselement Fan_Off(n=22, modes={1,2,3,4,6,7,8,9,10,11,
                12,13,14,15,16,17,18,19,20,21,22,23})
                                            annotation (Placement(transformation(extent=
                   {{-96,66},{-86,76}})), Dialog(group="PN Configuration On->Off",
                enable=true));
          Modes.Evaluator.iselement Fan_On(n=1, modes={5})
                                           annotation (Placement(transformation(extent={
                    {-96,80},{-86,90}})), Dialog(group="PN Configuration Off->On",
                enable=true));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{44,14},{24,34}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{24,-30},{44,-10}})));
          Modelica.Blocks.Sources.Constant off(k=0)
            annotation (Placement(transformation(extent={{0,-14},{10,-4}})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            annotation (Placement(transformation(extent={{64,6},{54,16}})));
          Modelica.Blocks.Sources.Constant On(k=mFlow_Set)
            annotation (Placement(transformation(extent={{64,32},{54,42}})));
        equation
          connect(Fan_off.outTransition[1], T1.inPlaces[1])
            annotation (Line(points={{-44,78.8},{-44,84},{-4.8,84}}, color={0,0,0}));
          connect(T1.outPlaces[1], Fan_on.inTransition[1]) annotation (Line(
                points={{4.8,84},{48,84},{48,78.8}}, color={0,0,0}));
          connect(T2.outPlaces[1], Fan_off.inTransition[1])
            annotation (Line(points={{-4.8,52},{-44,52},{-44,57.2}}, color={0,0,0}));
          connect(Fan_on.outTransition[1], T2.inPlaces[1]) annotation (Line(
                points={{48,57.2},{48,52},{4.8,52}}, color={0,0,0}));
          connect(M_in, Fan_Off.u) annotation (Line(points={{-108,0},{-102,0},{-102,74.5},
                  {-96,74.5}}, color={255,127,0}));
          connect(M_in, Fan_On.u) annotation (Line(points={{-108,0},{-102,0},{-102,88.5},
                  {-96,88.5}}, color={255,127,0}));
          connect(off.y, switch2.u1) annotation (Line(points={{10.5,-9},{14,-9},
                  {14,-12},{22,-12}}, color={0,0,127}));
          connect(Fan_off.pd_b, switch2.u2) annotation (Line(points={{-55,68},{
                  -68,68},{-68,-20},{22,-20}},
                                     color={255,0,255}));
          connect(Fan_on.pd_b, switch1.u2) annotation (Line(points={{59,68},{70,
                  68},{70,40},{70,40},{70,24},{46,24}}, color={255,0,255}));
          connect(On.y, switch1.u1) annotation (Line(points={{53.5,37},{52,37},
                  {52,32},{46,32}}, color={0,0,127}));
          connect(security_closed.y, switch1.u3) annotation (Line(points={{53.5,
                  11},{51.75,11},{51.75,16},{46,16}}, color={0,0,127}));
          connect(switch1.y, switch2.u3) annotation (Line(points={{23,24},{-18,
                  24},{-18,-28},{22,-28}}, color={0,0,127}));
          connect(switch2.y, massFlow_Fan) annotation (Line(points={{45,-20},{
                  72,-20},{72,0},{106,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end Fan_On_Off;

        model Pump_On_Off "on off control for pump"

          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Pump_off(
            nOut=1,
            nIn=1,
            startTokens=1) "Fan is switched off, signal 0" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool Pump_on(nIn=1, nOut=1)
            "Pump is switched on, runs on nominal value with output signal 1"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=Pump_On.y == true) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(
            nOut=1,
            nIn=1,
            firingCon=Pump_Off.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          Modelica.Blocks.Interfaces.RealOutput signal_Pump
            "set value for pump"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modes.Evaluator.iselement Pump_Off(n=22, modes={1,2,3,4,5,6,7,8,9,10,
                11,12,13,14,15,16,17,18,19,21,22,23}) annotation (Placement(
                transformation(extent={{-96,66},{-86,76}})), Dialog(group=
                  "PN Configuration On->Off", enable=true));
          Modes.Evaluator.iselement Pump_On(n=1, modes={20}) annotation (
              Placement(transformation(extent={{-96,80},{-86,90}})), Dialog(
                group="PN Configuration Off->On", enable=true));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{44,14},{24,34}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{24,-30},{44,-10}})));
          Modelica.Blocks.Sources.Constant off(k=0)
            annotation (Placement(transformation(extent={{0,-14},{10,-4}})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            annotation (Placement(transformation(extent={{64,6},{54,16}})));
          Modelica.Blocks.Sources.Constant On(k=1)
            annotation (Placement(transformation(extent={{64,32},{54,42}})));
        equation
          connect(Pump_off.outTransition[1], T1.inPlaces[1]) annotation (Line(
                points={{-44,78.8},{-44,84},{-4.8,84}}, color={0,0,0}));
          connect(T1.outPlaces[1], Pump_on.inTransition[1]) annotation (Line(
                points={{4.8,84},{48,84},{48,78.8}}, color={0,0,0}));
          connect(T2.outPlaces[1], Pump_off.inTransition[1]) annotation (Line(
                points={{-4.8,52},{-44,52},{-44,57.2}}, color={0,0,0}));
          connect(Pump_on.outTransition[1], T2.inPlaces[1]) annotation (Line(
                points={{48,57.2},{48,52},{4.8,52}}, color={0,0,0}));
          connect(M_in, Pump_Off.u) annotation (Line(points={{-108,0},{-102,0},
                  {-102,74.5},{-96,74.5}}, color={255,127,0}));
          connect(M_in, Pump_On.u) annotation (Line(points={{-108,0},{-102,0},{
                  -102,88.5},{-96,88.5}}, color={255,127,0}));
          connect(off.y, switch2.u1) annotation (Line(points={{10.5,-9},{14,-9},
                  {14,-12},{22,-12}}, color={0,0,127}));
          connect(Pump_off.pd_b, switch2.u2) annotation (Line(points={{-55,68},
                  {-68,68},{-68,-20},{22,-20}}, color={255,0,255}));
          connect(Pump_on.pd_b, switch1.u2) annotation (Line(points={{59,68},{
                  70,68},{70,40},{70,40},{70,24},{46,24}}, color={255,0,255}));
          connect(On.y, switch1.u1) annotation (Line(points={{53.5,37},{52,37},{52,32},{
                  46,32}}, color={0,0,127}));
          connect(security_closed.y, switch1.u3) annotation (Line(points={{53.5,11},{51.75,
                  11},{51.75,16},{46,16}}, color={0,0,127}));
          connect(switch1.y, switch2.u3) annotation (Line(points={{23,24},{-18,24},{-18,
                  -28},{22,-28}}, color={0,0,127}));
          connect(switch2.y, signal_Pump) annotation (Line(points={{45,-20},{72,
                  -20},{72,0},{106,0}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end Pump_On_Off;

        model Pump_Bool "on off control for pump using boolean signal"

          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Pump_off(
            nOut=1,
            nIn=1,
            startTokens=1) "Fan is switched off, signal 0" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool Pump_on(nIn=1, nOut=1)
            "Pump is switched on, runs on nominal value with output signal 1"
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=Pump_On.y == true) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(
            nOut=1,
            nIn=1,
            firingCon=Pump_Off.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          Modes.Evaluator.iselement Pump_Off(n=22, modes={1,2,3,4,5,6,7,8,9,10,
                11,12,13,14,15,16,17,18,19,20,21,22}) annotation (Placement(
                transformation(extent={{-96,66},{-86,76}})), Dialog(group=
                  "PN Configuration On->Off", enable=true));
          Modes.Evaluator.iselement Pump_On(n=1, modes={23}) annotation (
              Placement(transformation(extent={{-96,80},{-86,90}})), Dialog(
                group="PN Configuration Off->On", enable=true));
          Modelica.Blocks.Interfaces.BooleanOutput signal_pump
            annotation (Placement(transformation(extent={{98,-10},{118,10}})));
        equation
          connect(Pump_off.outTransition[1], T1.inPlaces[1]) annotation (Line(
                points={{-44,78.8},{-44,84},{-4.8,84}}, color={0,0,0}));
          connect(T1.outPlaces[1], Pump_on.inTransition[1]) annotation (Line(
                points={{4.8,84},{48,84},{48,78.8}}, color={0,0,0}));
          connect(T2.outPlaces[1], Pump_off.inTransition[1]) annotation (Line(
                points={{-4.8,52},{-44,52},{-44,57.2}}, color={0,0,0}));
          connect(Pump_on.outTransition[1], T2.inPlaces[1]) annotation (Line(
                points={{48,57.2},{48,52},{4.8,52}}, color={0,0,0}));
          connect(M_in, Pump_Off.u) annotation (Line(points={{-108,0},{-102,0},
                  {-102,74.5},{-96,74.5}}, color={255,127,0}));
          connect(M_in, Pump_On.u) annotation (Line(points={{-108,0},{-102,0},{
                  -102,88.5},{-96,88.5}}, color={255,127,0}));
          connect(Pump_on.pd_b, signal_pump) annotation (Line(points={{59,68},{
                  64,68},{64,0},{108,0}}, color={255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end Pump_Bool;

        model controlvalve3 "control valve with 3 modes"
          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Y_closed(
            nOut=2,
            nIn=2,
            startTokens=1) "valve Y closed, output value 0" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool Y_open(nIn=2, nOut=2) "valve Y open, output value 1" annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.PDBool Y_control(nIn=2, nOut=2)
            "Y is in controlled modus with a PID controller" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={0,-12})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=Y_Open.y == true) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(
            nOut=1,
            nIn=1,
            firingCon=Y_Close.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          PNlib.TD T3(
            nIn=1,
            nOut=1,
            firingCon=Y_Control.y == true) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={68,14})));
          PNlib.TD T4(
            nIn=1,
            nOut=1,
            firingCon=Y_Open.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={28,14})));
          PNlib.TD T5(
            nIn=1,
            nOut=1,
            firingCon=Y_Close.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={-28,14})));
          PNlib.TD T6(
            nOut=1,
            nIn=1,
            firingCon=Y_Control.y == true) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=90,
                origin={-66,14})));
          Modes.Evaluator.iselement Y_Close(n=4, modes={12,13,20,21})
                                                            annotation (Placement(
                transformation(extent={{-96,78},{-86,88}})), Dialog(group="PN Configuration On->Off",
                enable=true));
          Modes.Evaluator.iselement Y_Open(n=7, modes={1,2,3,4,5,6,7})
                                                                     annotation (
              Placement(transformation(extent={{-96,62},{-86,72}})), Dialog(group="PN Configuration Off->On",
                enable=true));
          Modes.Evaluator.iselement Y_Control(n=12, modes={8,9,10,11,14,15,16,
                17,18,19,22,23}) annotation (Placement(transformation(extent={{-96,46},{
                    -86,56}})), Dialog(group="PN Configuration Off->On", enable=true));
          Modelica.Blocks.Interfaces.BooleanOutput valve_closed
            annotation (Placement(transformation(extent={{96,40},{116,60}})));
          Modelica.Blocks.Interfaces.BooleanOutput valve_open
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Interfaces.BooleanOutput valve_controlled
            annotation (Placement(transformation(extent={{96,-60},{116,-40}})));
        equation
          connect(Y_closed.outTransition[1], T1.inPlaces[1]) annotation (Line(points={{-43.5,
                  78.8},{-43.5,84},{-4.8,84}}, color={0,0,0}));
          connect(T1.outPlaces[1], Y_open.inTransition[1])
            annotation (Line(points={{4.8,84},{47.5,84},{47.5,78.8}}, color={0,0,0}));
          connect(T2.outPlaces[1], Y_closed.inTransition[1]) annotation (Line(points={{-4.8,
                  52},{-43.5,52},{-43.5,57.2}}, color={0,0,0}));
          connect(Y_open.outTransition[1], T3.inPlaces[1]) annotation (Line(points={{47.5,
                  57.2},{47.5,38},{68,38},{68,18.8}}, color={0,0,0}));
          connect(T3.outPlaces[1], Y_control.inTransition[1]) annotation (Line(points={{
                  68,9.2},{68,-26},{0.5,-26},{0.5,-22.8}}, color={0,0,0}));
          connect(Y_control.outTransition[1], T4.inPlaces[1]) annotation (Line(points={{
                  0.5,-1.2},{0.5,4},{28,4},{28,9.2}}, color={0,0,0}));
          connect(T4.outPlaces[1], Y_open.inTransition[2]) annotation (Line(points={{28,
                  18.8},{28,92},{48,92},{48.5,78.8}}, color={0,0,0}));
          connect(T6.outPlaces[1], Y_control.inTransition[2]) annotation (Line(points={{
                  -66,9.2},{-66,-26},{-0.5,-26},{-0.5,-22.8}}, color={0,0,0}));
          connect(Y_control.outTransition[2], T5.inPlaces[1]) annotation (Line(points={{
                  -0.5,-1.2},{-0.5,4},{-28,4},{-28,9.2}}, color={0,0,0}));
          connect(T5.outPlaces[1], Y_closed.inTransition[2]) annotation (Line(points={{-28,
                  18.8},{-28,18.8},{-28,40},{-44.5,40},{-44.5,57.2}}, color={0,0,0}));
          connect(Y_closed.outTransition[2], T6.inPlaces[1]) annotation (Line(points={{-44.5,
                  78.8},{-44.5,82},{-66,82},{-66,18.8}}, color={0,0,0}));
          connect(Y_open.outTransition[2], T2.inPlaces[1])
            annotation (Line(points={{48.5,57.2},{48.5,52},{4.8,52}}, color={0,0,0}));
          connect(M_in, Y_Close.u) annotation (Line(points={{-108,0},{-102,0},{-102,86.5},
                  {-96,86.5}}, color={255,127,0}));
          connect(M_in, Y_Open.u) annotation (Line(points={{-108,0},{-102,0},{-102,70.5},
                  {-96,70.5}}, color={255,127,0}));
          connect(M_in, Y_Control.u) annotation (Line(points={{-108,0},{-102,0},{-102,54.5},
                  {-96,54.5}}, color={255,127,0}));
          connect(Y_closed.pd_b, valve_closed) annotation (Line(points={{-55,68},{-70,68},
                  {-70,98},{90,98},{90,50},{106,50}}, color={255,0,255}));
          connect(Y_open.pd_b, valve_open) annotation (Line(points={{59,68},{86,68},{86,
                  24},{86,24},{86,0},{106,0}}, color={255,0,255}));
          connect(Y_control.pd_b, valve_controlled) annotation (Line(points={{-11,-12},{
                  -20,-12},{-20,-50},{106,-50}}, color={255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end controlvalve3;

        model Fan_On_Off_fix "on off control for fan with pressure control"

          parameter Real mFlow_Set = 5 "Setpoint for Mass flow of fan";
          parameter Real dP_Set = 500 "Setpoint for differential pressure of fan";

          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Fan_off(
            nOut=1,
            nIn=1,
            startTokens=0,
            maxTokens=1)   "Fan is switched off, signal 0" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool Fan_on(nIn=1, nOut=1,
            startTokens=1,
            maxTokens=1)
            "Fan is switched on, runs on nominal value" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=Fan_On.y == true) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(
            nOut=1,
            nIn=1,
            firingCon=Fan_Off.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          Modelica.Blocks.Interfaces.RealOutput dp_Fan
            "set value for pressure difference of Fan"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modes.Evaluator.iselement Fan_Off(n=22, modes={1,2,3,4,6,7,8,9,10,11,
                12,13,14,15,16,17,18,19,20,21,22,23})
                                            annotation (Placement(transformation(extent=
                   {{-96,66},{-86,76}})), Dialog(group="PN Configuration On->Off",
                enable=true));
          Modes.Evaluator.iselement Fan_On(n=1, modes={5})
                                           annotation (Placement(transformation(extent={
                    {-96,80},{-86,90}})), Dialog(group="PN Configuration Off->On",
                enable=true));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{24,-30},{44,-10}})));
          Modelica.Blocks.Sources.Constant off(k=0)
            annotation (Placement(transformation(extent={{0,-14},{10,-4}})));
          Modelica.Blocks.Sources.Constant On1(k=dP_Set)
            annotation (Placement(transformation(extent={{2,-34},{12,-24}})));
        equation
          connect(Fan_off.outTransition[1], T1.inPlaces[1])
            annotation (Line(points={{-44,78.8},{-44,84},{-4.8,84}}, color={0,0,0}));
          connect(T1.outPlaces[1], Fan_on.inTransition[1]) annotation (Line(
                points={{4.8,84},{48,84},{48,78.8}}, color={0,0,0}));
          connect(T2.outPlaces[1], Fan_off.inTransition[1])
            annotation (Line(points={{-4.8,52},{-44,52},{-44,57.2}}, color={0,0,0}));
          connect(Fan_on.outTransition[1], T2.inPlaces[1]) annotation (Line(
                points={{48,57.2},{48,52},{4.8,52}}, color={0,0,0}));
          connect(M_in, Fan_Off.u) annotation (Line(points={{-108,0},{-102,0},{-102,74.5},
                  {-96,74.5}}, color={255,127,0}));
          connect(M_in, Fan_On.u) annotation (Line(points={{-108,0},{-102,0},{-102,88.5},
                  {-96,88.5}}, color={255,127,0}));
          connect(off.y, switch2.u1) annotation (Line(points={{10.5,-9},{14,-9},
                  {14,-12},{22,-12}}, color={0,0,127}));
          connect(Fan_off.pd_b, switch2.u2) annotation (Line(points={{-55,68},{
                  -68,68},{-68,-20},{22,-20}},
                                     color={255,0,255}));
          connect(switch2.y, dp_Fan) annotation (Line(points={{45,-20},{72,-20},
                  {72,0},{106,0}}, color={0,0,127}));
          connect(On1.y, switch2.u3) annotation (Line(points={{12.5,-29},{16.25,
                  -29},{16.25,-28},{22,-28}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end Fan_On_Off_fix;

        model sorptionControl "sorption control valve with 2 control modes"
          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Y_closed(
            nOut=2,
            nIn=2,
            startTokens=1) "valve Y closed, output value 0" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool Y_AbsControl(nIn=2, nOut=2)
            "only one valve is controlled by PID controller" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.PDBool Y_DesControl(nIn=2, nOut=2)
            "both valves are controlled with a PID controller" annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={0,-12})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=Y_ConSingle.y == true) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(
            nOut=1,
            nIn=1,
            firingCon=Y_Close.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          PNlib.TD T3(
            nIn=1,
            nOut=1,
            firingCon=Y_ConAbsDes.y == true) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={68,14})));
          PNlib.TD T4(
            nIn=1,
            nOut=1,
            firingCon=Y_ConSingle.y == true) annotation (Placement(
                transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={28,14})));
          PNlib.TD T5(
            nIn=1,
            nOut=1,
            firingCon=Y_Close.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={-28,14})));
          PNlib.TD T6(
            nOut=1,
            nIn=1,
            firingCon=Y_ConAbsDes.y == true) annotation (Placement(
                transformation(
                extent={{10,10},{-10,-10}},
                rotation=90,
                origin={-66,14})));
          Modes.Evaluator.iselement Y_Close(n=4, modes={12,13,20,21})
                                                            annotation (Placement(
                transformation(extent={{-96,78},{-86,88}})), Dialog(group="PN Configuration On->Off",
                enable=true));
          Modes.Evaluator.iselement Y_ConSingle(n=7, modes={1,2,3,4,5,6,7})
            annotation (Placement(transformation(extent={{-96,62},{-86,72}})),
              Dialog(group="PN Configuration Off->On", enable=true));
          Modes.Evaluator.iselement Y_ConAbsDes(n=12, modes={8,9,10,11,14,15,16,
                17,18,19,22,23}) annotation (Placement(transformation(extent={{
                    -96,46},{-86,56}})), Dialog(group=
                  "PN Configuration Off->On", enable=true));
          Modelica.Blocks.Interfaces.BooleanOutput valve_closed
            annotation (Placement(transformation(extent={{96,40},{116,60}})));
          Modelica.Blocks.Interfaces.BooleanOutput valve_Single
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modelica.Blocks.Interfaces.BooleanOutput valve_AbsDes
            annotation (Placement(transformation(extent={{96,-60},{116,-40}})));
        equation
          connect(Y_closed.outTransition[1], T1.inPlaces[1]) annotation (Line(points={{-43.5,
                  78.8},{-43.5,84},{-4.8,84}}, color={0,0,0}));
          connect(T1.outPlaces[1], Y_AbsControl.inTransition[1]) annotation (
              Line(points={{4.8,84},{47.5,84},{47.5,78.8}}, color={0,0,0}));
          connect(T2.outPlaces[1], Y_closed.inTransition[1]) annotation (Line(points={{-4.8,
                  52},{-43.5,52},{-43.5,57.2}}, color={0,0,0}));
          connect(Y_AbsControl.outTransition[1], T3.inPlaces[1]) annotation (
              Line(points={{47.5,57.2},{47.5,38},{68,38},{68,18.8}}, color={0,0,
                  0}));
          connect(T3.outPlaces[1], Y_DesControl.inTransition[1]) annotation (
              Line(points={{68,9.2},{68,-26},{0.5,-26},{0.5,-22.8}}, color={0,0,
                  0}));
          connect(Y_DesControl.outTransition[1], T4.inPlaces[1]) annotation (
              Line(points={{0.5,-1.2},{0.5,4},{28,4},{28,9.2}}, color={0,0,0}));
          connect(T4.outPlaces[1], Y_AbsControl.inTransition[2]) annotation (
              Line(points={{28,18.8},{28,92},{48,92},{48.5,78.8}}, color={0,0,0}));
          connect(T6.outPlaces[1], Y_DesControl.inTransition[2]) annotation (
              Line(points={{-66,9.2},{-66,-26},{-0.5,-26},{-0.5,-22.8}}, color=
                  {0,0,0}));
          connect(Y_DesControl.outTransition[2], T5.inPlaces[1]) annotation (
              Line(points={{-0.5,-1.2},{-0.5,4},{-28,4},{-28,9.2}}, color={0,0,
                  0}));
          connect(T5.outPlaces[1], Y_closed.inTransition[2]) annotation (Line(points={{-28,
                  18.8},{-28,18.8},{-28,40},{-44.5,40},{-44.5,57.2}}, color={0,0,0}));
          connect(Y_closed.outTransition[2], T6.inPlaces[1]) annotation (Line(points={{-44.5,
                  78.8},{-44.5,82},{-66,82},{-66,18.8}}, color={0,0,0}));
          connect(Y_AbsControl.outTransition[2], T2.inPlaces[1]) annotation (
              Line(points={{48.5,57.2},{48.5,52},{4.8,52}}, color={0,0,0}));
          connect(M_in, Y_Close.u) annotation (Line(points={{-108,0},{-102,0},{-102,86.5},
                  {-96,86.5}}, color={255,127,0}));
          connect(M_in, Y_ConSingle.u) annotation (Line(points={{-108,0},{-102,
                  0},{-102,70.5},{-96,70.5}}, color={255,127,0}));
          connect(M_in, Y_ConAbsDes.u) annotation (Line(points={{-108,0},{-102,
                  0},{-102,54.5},{-96,54.5}}, color={255,127,0}));
          connect(Y_closed.pd_b, valve_closed) annotation (Line(points={{-55,68},{-70,68},
                  {-70,98},{90,98},{90,50},{106,50}}, color={255,0,255}));
          connect(Y_AbsControl.pd_b, valve_Single) annotation (Line(points={{59,
                  68},{86,68},{86,24},{86,24},{86,0},{106,0}}, color={255,0,255}));
          connect(Y_DesControl.pd_b, valve_AbsDes) annotation (Line(points={{-11,
                  -12},{-20,-12},{-20,-50},{106,-50}}, color={255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end sorptionControl;

        model bypassValve "control valve for bypass feature"
          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Y_open(
            nOut=1,
            nIn=1,
            startTokens=1) "valve closed, output value 0" annotation (Placement(
                transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={-2,70})));
          PNlib.PDBool Y_control(nIn=1, nOut=1)
            "Y is in controlled modus with a PID controller" annotation (
              Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=0,
                origin={0,20})));
          PNlib.TD T5(
            nIn=1,
            nOut=1,
            firingCon=Y_Open.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=90,
                origin={60,44})));
          PNlib.TD T6(
            nOut=1,
            nIn=1,
            firingCon=Y_Control.y == true) annotation (Placement(transformation(
                extent={{10,10},{-10,-10}},
                rotation=90,
                origin={-58,44})));
          Modes.Evaluator.iselement Y_Open(n=22, modes={1,2,3,4,5,6,7,8,9,10,11,
                12,13,14,15,16,17,18,19,20,22,23}) annotation (Placement(
                transformation(extent={{-96,66},{-86,76}})), Dialog(group=
                  "PN Configuration On->Off", enable=true));
          Modes.Evaluator.iselement Y_Control(n=1, modes={21})
                                             annotation (Placement(
                transformation(extent={{-96,46},{-86,56}})), Dialog(group=
                  "PN Configuration Off->On", enable=true));
          Modelica.Blocks.Interfaces.BooleanOutput Open
            annotation (Placement(transformation(extent={{96,50},{116,70}})));
          Modelica.Blocks.Interfaces.BooleanOutput Control
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
        equation
          connect(T6.outPlaces[1], Y_control.inTransition[1]) annotation (Line(
                points={{-58,39.2},{-58,20},{-10.8,20}}, color={0,0,0}));
          connect(Y_control.outTransition[1], T5.inPlaces[1]) annotation (Line(
                points={{10.8,20},{60,20},{60,39.2}}, color={0,0,0}));
          connect(T5.outPlaces[1], Y_open.inTransition[1]) annotation (Line(
                points={{60,48.8},{60,70},{8.8,70}}, color={0,0,0}));
          connect(Y_open.outTransition[1], T6.inPlaces[1]) annotation (Line(
                points={{-12.8,70},{-58,70},{-58,48.8}}, color={0,0,0}));
          connect(M_in, Y_Open.u) annotation (Line(points={{-108,0},{-102,0},{-102,
                  74.5},{-96,74.5}}, color={255,127,0}));
          connect(M_in, Y_Control.u) annotation (Line(points={{-108,0},{-102,0},
                  {-102,54.5},{-96,54.5}}, color={255,127,0}));
          connect(Y_open.pd_b, Open) annotation (Line(points={{-2,81},{-2,90},{
                  80,90},{80,60},{106,60}}, color={255,0,255}));
          connect(Y_control.pd_b, Control) annotation (Line(points={{0,9},{0,9},
                  {0,0},{106,0}}, color={255,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end bypassValve;

        model Fan_On_Off_PI "on off control for fan with pressure control"

          parameter Real mFlow_Set = 5 "Setpoint for Mass flow of fan";
          parameter Real dP_Set = 500 "Setpoint for differential pressure of fan";
          parameter Real k = 1000;
          parameter Real Ti = 60;
          Modelica.Blocks.Interfaces.IntegerInput M_in "input of current Modus"
            annotation (Placement(transformation(extent={{-128,-20},{-88,20}})));

          PNlib.PDBool Fan_off(
            nOut=1,
            nIn=1,
            startTokens=0,
            maxTokens=1)   "Fan is switched off, signal 0" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={-44,68})));
          PNlib.PDBool Fan_on(nIn=1, nOut=1,
            startTokens=1,
            maxTokens=1)
            "Fan is switched on, runs on nominal value" annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={48,68})));
          PNlib.TD T1(
            nIn=1,
            nOut=1,
            firingCon=Fan_On.y == true) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={0,84})));
          PNlib.TD T2(
            nOut=1,
            nIn=1,
            firingCon=Fan_Off.y == true) annotation (Placement(transformation(
                extent={{-10,10},{10,-10}},
                rotation=180,
                origin={0,52})));
          Modelica.Blocks.Interfaces.RealOutput dp_Fan
            "set value for pressure difference of Fan"
            annotation (Placement(transformation(extent={{96,-10},{116,10}})));
          Modes.Evaluator.iselement Fan_Off(n=22, modes={1,2,3,4,6,7,8,9,10,11,
                12,13,14,15,16,17,18,19,20,21,22,23})
                                            annotation (Placement(transformation(extent=
                   {{-96,66},{-86,76}})), Dialog(group="PN Configuration On->Off",
                enable=true));
          Modes.Evaluator.iselement Fan_On(n=1, modes={5})
                                           annotation (Placement(transformation(extent={
                    {-96,80},{-86,90}})), Dialog(group="PN Configuration Off->On",
                enable=true));
          Modelica.Blocks.Logical.Switch switch1
            annotation (Placement(transformation(extent={{44,16},{24,36}})));
          Modelica.Blocks.Logical.Switch switch2
            annotation (Placement(transformation(extent={{24,-30},{44,-10}})));
          Modelica.Blocks.Sources.Constant off(k=0)
            annotation (Placement(transformation(extent={{0,-14},{10,-4}})));
          Modelica.Blocks.Sources.Constant security_closed(k=0)
            annotation (Placement(transformation(extent={{64,6},{54,16}})));
          Modelica.Blocks.Sources.Constant On(k=mFlow_Set)
            annotation (Placement(transformation(extent={{64,34},{54,44}})));
          Modelica.Blocks.Continuous.LimPID PID(        yMin=0,
            k=k,
            Ti=Ti,
            controllerType=Modelica.Blocks.Types.SimpleController.PI,
            yMax=1500,
            initType=Modelica.Blocks.Types.InitPID.InitialOutput,
            y_start=300)
            annotation (Placement(transformation(extent={{-26,-60},{-6,-40}})));
          Modelica.Blocks.Interfaces.RealInput Measure_mFlow
            "Measured value of mass flow for PI control" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-106,-70})));
        equation
          connect(Fan_off.outTransition[1], T1.inPlaces[1])
            annotation (Line(points={{-44,78.8},{-44,84},{-4.8,84}}, color={0,0,0}));
          connect(T1.outPlaces[1], Fan_on.inTransition[1]) annotation (Line(
                points={{4.8,84},{48,84},{48,78.8}}, color={0,0,0}));
          connect(T2.outPlaces[1], Fan_off.inTransition[1])
            annotation (Line(points={{-4.8,52},{-44,52},{-44,57.2}}, color={0,0,0}));
          connect(Fan_on.outTransition[1], T2.inPlaces[1]) annotation (Line(
                points={{48,57.2},{48,52},{4.8,52}}, color={0,0,0}));
          connect(M_in, Fan_Off.u) annotation (Line(points={{-108,0},{-102,0},{-102,74.5},
                  {-96,74.5}}, color={255,127,0}));
          connect(M_in, Fan_On.u) annotation (Line(points={{-108,0},{-102,0},{-102,88.5},
                  {-96,88.5}}, color={255,127,0}));
          connect(off.y, switch2.u1) annotation (Line(points={{10.5,-9},{14,-9},
                  {14,-12},{22,-12}}, color={0,0,127}));
          connect(Fan_off.pd_b, switch2.u2) annotation (Line(points={{-55,68},{
                  -68,68},{-68,-20},{22,-20}},
                                     color={255,0,255}));
          connect(Fan_on.pd_b, switch1.u2) annotation (Line(points={{59,68},{70,68},{70,
                  26},{46,26}},                         color={255,0,255}));
          connect(security_closed.y, switch1.u3) annotation (Line(points={{53.5,11},{51.75,
                  11},{51.75,18},{46,18}},            color={0,0,127}));
          connect(switch2.y, dp_Fan) annotation (Line(points={{45,-20},{72,-20},
                  {72,0},{106,0}}, color={0,0,127}));
          connect(Measure_mFlow, PID.u_m) annotation (Line(points={{-106,-70},{-16,-70},
                  {-16,-62}}, color={0,0,127}));
          connect(On.y, switch1.u1) annotation (Line(points={{53.5,39},{50.75,39},{50.75,
                  34},{46,34}}, color={0,0,127}));
          connect(switch1.y, PID.u_s) annotation (Line(points={{23,26},{-56,26},{-56,-50},
                  {-28,-50}}, color={0,0,127}));
          connect(PID.y, switch2.u3) annotation (Line(points={{-5,-50},{12,-50},
                  {12,-28},{22,-28}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
              Diagram(coordinateSystem(preserveAspectRatio=false)));
        end Fan_On_Off_PI;
      end Aktoren;

      model Selector_global "selects the active mode"

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
          ModeSelector[1] = false; end if;
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
      end Selector_global;

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
        Modelica.Blocks.Interfaces.IntegerInput Mode_Index annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={0,190})));
        Modelica.Blocks.Interfaces.BooleanInput OnSignal( start = true)
          "gives the signal true when the device is switched on" annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-88,190})));
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
        CurrentMode = if OnSignal
          then ModeArray[Mode_Index]
          else 1;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
                  -240},{180,180}})),
                                Diagram(coordinateSystem(preserveAspectRatio=false,
                extent={{-180,-240},{180,180}})));
      end ModeSwitch;

      model regDem "regeneration demand, activates the regeneration of the AHU"
        Modelica.Blocks.Interfaces.BooleanOutput RegAnf
          "Boolean, True, if the HVAC should regenerate"
          annotation (Placement(transformation(extent={{96,-10},{116,10}})));
        PNlib.PDBool
                 RegOff(nIn=1, nOut=1,
          maxTokens=1,
          startTokens=1) "PN for deactivated regeneration of brine"
                                                                  annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-50,0})));
        PNlib.PDBool RegOn(
          nIn=1,
          nOut=1,
          maxTokens=1) "PN for activated regeneration of brine" annotation (
            Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={50,0})));
        PNlib.TD RegAus(
          nIn=1,
          nOut=1,
          delay=300,
          firingCon=xAbs >= 0.30 and xDes >= 0.4)
          "Transition zum Ausschalten der Regeneration"
          annotation (Placement(transformation(extent={{8,20},{-12,40}})));
        PNlib.TD RegAn(
          nIn=1,
          nOut=1,
          delay=300,
          firingCon=xAbs <= 0.30)
          "Transition zum Anschalten der Regeneration"
          annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
        Modelica.Blocks.Interfaces.RealInput xDes
          "solution concentration in desorber tank"
          annotation (Placement(transformation(extent={{-128,-60},{-88,-20}})));
        Modelica.Blocks.Interfaces.RealInput xAbs
          "solution concentration in absorber tank"
          annotation (Placement(transformation(extent={{-128,20},{-88,60}})));
      equation
        connect(RegOn.pd_b, RegAnf)
          annotation (Line(points={{61,0},{106,0}}, color={255,0,255}));
        connect(RegOn.outTransition[1], RegAus.inPlaces[1])
          annotation (Line(points={{50,10.8},{50,30},{2.8,30}}, color={0,0,0}));
        connect(RegAus.outPlaces[1], RegOff.inTransition[1]) annotation (Line(
              points={{-6.8,30},{-50,30},{-50,10.8}}, color={0,0,0}));
        connect(RegOff.outTransition[1], RegAn.inPlaces[1]) annotation (Line(
              points={{-50,-10.8},{-50,-30},{-4.8,-30}}, color={0,0,0}));
        connect(RegAn.outPlaces[1], RegOn.inTransition[1]) annotation (Line(
              points={{4.8,-30},{50,-30},{50,-10.8}}, color={0,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                                     Diagram(coordinateSystem(preserveAspectRatio=
                 false)));
      end regDem;
    end PN_Steuerung;

    model ControlTest "test version of controller for sorption"

      parameter Real leak = 0.0001 "leakage before the valve switches";
      parameter Real d = 300 "delay for mode switching in s";
      parameter Modelica.SIunits.Temperature T_Set = 20+273.15 "set value for T01";
      parameter Modelica.SIunits.Temperature THot_Set = 64+273.15 "set value for regeneration temperature";
      parameter Real phi_Set = 0.5  "set value for phi (relative humidity) at T01";

      parameter Real mFlowNom_outFan = 5  "set value for outside air fan";
      parameter Real mFlowNom_exhFan = 5  "set value for exhaust air fan";
      parameter Real mFlowNom_regFan = 1  "set value for regeneration air fan";

      parameter Real dP_outFan = 1356 "or 1300, set value for dP of outside air fan";
      parameter Real dP_exhFan = 665  "set value for dP of exhaust air fan";
      parameter Real dP_regFan = 543  "set value for dP of regeneration air fan";

      parameter Real k_y02 = 0.03;  //0.15;
      parameter Real Ti_y02 = 240;  //0.5;
      parameter Real k_y09 = 0.05;  //0.01//0.06 aus Einzelanalyse;
      parameter Real Ti_y09 = 180;  //180
      parameter Real k_phi = 0.28;  //80;  //0.08;
      parameter Real Ti_phi = 27;  //0.7;
      //parameter Real k_Fan = 100;  //250
      //parameter Real Ti_Fan = 120;  //30
      //parameter Real k_x = 0.15;
      //parameter Real Ti_x = 300;
      parameter Real k_m = 0.005;
      parameter Real Ti_m = 300;

      BusSensors busSensors
        annotation (Placement(transformation(extent={{-264,-54},{-176,46}})));
      BusActors busActors "Bus connector for actor signals"
        annotation (Placement(transformation(extent={{244,-40},{318,40}})));
      PN_Steuerung.PN_Main1_RLT21      pN_Steuerung_Ebene1_1(d=d)
        annotation (Placement(transformation(extent={{-78,140},{-58,160}})));
      PN_Steuerung.regDem regAnforderung
        "True, when there is need for regeneration"
        annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
      PN_Steuerung.Ebene2.DD dD
        annotation (Placement(transformation(extent={{-80,76},{-60,96}})));
      PN_Steuerung.ModeSwitch modeSwitch
        annotation (Placement(transformation(extent={{-14,-12},{24,24}})));
      PN_Steuerung.Ebene2.DB dB
        annotation (Placement(transformation(extent={{-80,46},{-60,66}})));
      PN_Steuerung.Ebene2.DE dE
        annotation (Placement(transformation(extent={{-80,16},{-60,36}})));
      PN_Steuerung.Ebene2.HD hD(d=d, leak=leak)
        annotation (Placement(transformation(extent={{-80,-14},{-60,6}})));
      PN_Steuerung.Ebene2.HB hB(d=d, leak=leak)
        annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
      PN_Steuerung.Ebene2.HE hE
        annotation (Placement(transformation(extent={{-80,-74},{-60,-54}})));
      PN_Steuerung.Ebene2.KD kD
        annotation (Placement(transformation(extent={{-80,-104},{-60,-84}})));
      PN_Steuerung.Ebene2.KB kB
        annotation (Placement(transformation(extent={{-80,-134},{-60,-114}})));
      PN_Steuerung.Ebene2.KE kE
        annotation (Placement(transformation(extent={{-80,-164},{-60,-144}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y01(Y_Close(n=7, modes={1,2,3,4,5,6,7}),
          Y_Open(n=16, modes={8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}))
        "On_Off valve Y01"
        annotation (Placement(transformation(extent={{140,200},{160,220}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y03(Y_Close(n=16, modes={8,9,10,11,12,
              13,14,15,16,17,18,19,20,21,22,23}), Y_Open(n=7, modes={1,2,3,4,5,
              6,7})) "On Off valve Y03"
        annotation (Placement(transformation(extent={{140,160},{160,180}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y04(Y_Close(n=1, modes={1}), Y_Open(n=
             22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,
              23}))
        annotation (Placement(transformation(extent={{140,140},{160,160}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y05(Y_Close(n=1, modes={1}), Y_Open(n=
             22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,
              23}))
        annotation (Placement(transformation(extent={{140,120},{160,140}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y07(Y_Close(n=12, modes={1,2,3,4,8,9,
              10,11,12,13,14,15}), Y_Open(n=11, modes={5,6,7,16,17,18,19,20,21,
              22,23}))
        annotation (Placement(transformation(extent={{140,80},{160,100}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y08(Y_Close(n=12, modes={1,2,3,4,8,9,
              10,11,12,13,14,15}), Y_Open(n=11, modes={5,6,7,16,17,18,19,20,21,
              22,23}))
        annotation (Placement(transformation(extent={{140,60},{160,80}})));
      PN_Steuerung.Aktoren.controlvalve2 valve_Y09(Y_Close(n=19, modes={1,2,3,4,5,6,
              7,8,9,10,11,14,15,16,17,18,19,22,23}), Y_Control(n=4, modes={12,13,20,
              21})) "controlValve"
        annotation (Placement(transformation(extent={{106,40},{126,60}})));
      PN_Steuerung.Auswertemodule.heaCoiEva y09_evaluation(
        k=k_y09,
        Ti=Ti_y09,
        Setpoint=T_Set)
        annotation (Placement(transformation(extent={{140,40},{160,60}})));
      PN_Steuerung.Aktoren.controlvalve2 valve_Y10(Y_Close(n=12, modes={1,2,3,4,8,9,
              10,11,12,13,14,15}), Y_Control(n=11, modes={5,6,7,16,17,18,19,20,21,22,
              23})) "controlValve"
        annotation (Placement(transformation(extent={{106,20},{126,40}})));
      PN_Steuerung.Auswertemodule.heaCoiEva y10_evaluation(
        k=k_y09,
        Ti=Ti_y09,
        Setpoint=THot_Set)
        annotation (Placement(transformation(extent={{140,20},{160,40}})));
      PN_Steuerung.Aktoren.controlvalve2 valve_Y11(
                                            Y_Control(n=8, modes={3,6,9,11,13,17,19,
              21}), Y_Close(n=15, modes={1,2,4,5,7,8,10,12,14,15,16,18,20,22,23}))
                    "controlValve"
        annotation (Placement(transformation(extent={{106,0},{126,20}})));
      PN_Steuerung.Auswertemodule.heaCoiEva      y11_evaluation(
        k=k_phi,
        Ti=Ti_phi,
        Setpoint=phi_Set)
        annotation (Placement(transformation(extent={{140,0},{160,20}})));
      PN_Steuerung.Aktoren.Fan_On_Off_fix exhaustFan(
        Fan_Off(n=1, modes={1}),
        Fan_On(n=22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}),
        mFlow_Set=mFlowNom_exhFan,
        dP_Set=dP_exhFan) "mass flow set point value for exhaust fan"
        annotation (Placement(transformation(extent={{140,-80},{160,-60}})));

      PN_Steuerung.Aktoren.Fan_On_Off_fix regFan(
        Fan_Off(n=12, modes={1,2,3,4,8,9,10,11,12,13,14,15}),
        Fan_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}),
        dP_Set=dP_regFan,
        mFlow_Set=mFlowNom_regFan) "mass flow signal for regeneration fan"
        annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
      PN_Steuerung.Aktoren.Pump_On_Off pumpN04(Pump_Off(n=19, modes={1,2,3,4,5,6,7,8,
              9,10,11,14,15,16,17,18,19,22,23}), Pump_On(n=4, modes={12,13,20,21}))
        "on off signal of pump N04 for heating coil circuit for supply air"
        annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
      PN_Steuerung.Aktoren.Pump_Bool   pumpN05(Pump_Off(n=12, modes={1,2,3,4,8,9,10,
              11,12,13,14,15}), Pump_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}))
        "on off signal for pump N05, regeneration heating coil"
        annotation (Placement(transformation(extent={{140,-140},{160,-120}})));
      PN_Steuerung.Aktoren.Pump_Bool pumpN06(Pump_Off(n=17, modes={1,2,3,4,5,6,7,8,9,
              12,13,14,16,17,20,21,22}), Pump_On(n=6, modes={10,11,15,18,19,23}))
        "pump signal for N06 to activate adiabatic cooling"
        annotation (Placement(transformation(extent={{140,-160},{160,-140}})));
      PN_Steuerung.Aktoren.Pump_Bool pumpN07(Pump_Off(n=17, modes={1,2,3,5,6,8,9,10,
              11,12,13,16,17,18,19,20,21}), Pump_On(n=6, modes={4,7,14,15,22,23}))
        "absorber pump signal"
        annotation (Placement(transformation(extent={{140,-180},{160,-160}})));
      PN_Steuerung.Aktoren.Pump_Bool pumpN08(Pump_Off(n=12, modes={1,2,3,4,8,9,10,11,
              12,13,14,15}), Pump_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}))
        "on off signal for pump N08, regeneration pump for desiccant solution"
        annotation (Placement(transformation(extent={{140,-200},{160,-180}})));
      PN_Steuerung.Auswertemodule.Y02_evaluation y02_evaluation(T_Set=T_Set,
        k=k_y02,
        Ti=Ti_y02,
        k_cool=k_y02,
        Ti_cool=Ti_y02)
        annotation (Placement(transformation(extent={{140,180},{160,200}})));
      PN_Steuerung.Aktoren.controlvalve3 valve_Y02(
        Y_Close(n=4, modes={12,13,20,21}),
        Y_Open(n=7, modes={1,2,3,4,5,6,7}),
        Y_Control(n=12, modes={8,9,10,11,14,15,16,17,18,19,22,23}))
        annotation (Placement(transformation(extent={{106,180},{126,200}})));
      Modelica.Blocks.Interfaces.BooleanInput OnSignal
        "Delivers signal to switch on or off the device"
        annotation (Placement(transformation(extent={{-246,150},{-206,190}})));
      PN_Steuerung.Aktoren.controlvalve2   valve_Y15(Y_Close(n=20, modes={1,2,3,4,5,
              6,8,9,10,11,12,13,14,15,16,17,18,19,20,21}), Y_Control(n=3, modes={7,22,
              23}))
        annotation (Placement(transformation(extent={{106,-20},{126,0}})));
      PN_Steuerung.Aktoren.controlvalve2   valve_Y16(Y_Close(n=20, modes={1,2,3,4,5,
              6,8,9,10,11,12,13,14,15,16,17,18,19,20,21}), Y_Control(n=3, modes={7,22,
              23}))
        annotation (Placement(transformation(extent={{106,-40},{126,-20}})));
      PN_Steuerung.Auswertemodule.Y15_evaluation eva_Y15(k=k_m, Ti=Ti_m)
        annotation (Placement(transformation(extent={{140,-20},{160,0}})));
      PN_Steuerung.Auswertemodule.Y16_evaluationSimple
                                                 evaY16    annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
      PN_Steuerung.Auswertemodule.bypassEva y06_evaluation(k=k_phi, Ti=Ti_phi)
        annotation (Placement(transformation(extent={{140,100},{160,120}})));
      PN_Steuerung.Aktoren.bypassValve valve_Y06(Y_Open(n=17, modes={1,2,3,5,6,
              8,9,10,11,12,13,16,17,18,19,20,21}), Y_Control(n=6, modes={4,7,14,
              15,22,23}))
        annotation (Placement(transformation(extent={{106,100},{126,120}})));
      PN_Steuerung.Aktoren.Fan_On_Off_fix outsideFan(
        mFlow_Set=mFlowNom_outFan,
        Fan_Off(n=1, modes={1}),
        Fan_On(n=22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}),
        dP_Set=dP_outFan)
        annotation (Placement(transformation(extent={{140,-60},{160,-40}})));

    equation
      connect(dD.RegAnf, regAnforderung.RegAnf) annotation (Line(points={{-80.6,86},
              {-100,86},{-100,70},{-159.4,70}},   color={255,0,255}));
      connect(regAnforderung.RegAnf, dB.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,56},{-80.6,56}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, dE.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,26},{-80.6,26}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, hD.RegAnf) annotation (Line(points={{-159.4,70},{
              -100,70},{-100,-4},{-80.6,-4}},               color={255,0,255}));
      connect(regAnforderung.RegAnf, hB.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-34},{-80.6,-34}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, hE.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-64},{-80.6,-64}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, kD.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-94},{-80.6,-94}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, kB.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-124},{-80.6,-124}},              color={255,0,
              255}));
      connect(regAnforderung.RegAnf, kE.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-154},{-80.6,-154}},              color={255,0,
              255}));
      connect(dB.DB_Out, modeSwitch.DB) annotation (Line(points={{-59.4,56},{
              -26,56},{-26,19.2},{-15.0556,19.2}},
                                             color={255,127,0}));
      connect(dE.DE_Out, modeSwitch.DE) annotation (Line(points={{-59.4,26},{
              -40,26},{-40,14.9143},{-15.0556,14.9143}},
                                                   color={255,127,0}));
      connect(hD.HD_Out, modeSwitch.HD) annotation (Line(points={{-59.4,-4},{
              -34,-4},{-34,10.8},{-15.0556,10.8}},
                                             color={255,127,0}));
      connect(hB.HB_Out, modeSwitch.HB) annotation (Line(points={{-59.4,-34},{
              -30,-34},{-30,6.85714},{-15.0556,6.85714}},
                                                       color={255,127,0}));
      connect(hE.HE_Out, modeSwitch.HE) annotation (Line(points={{-59.4,-64},{
              -26,-64},{-26,2.4},{-15.0556,2.4}},
                                               color={255,127,0}));
      connect(kD.KD_Out, modeSwitch.KD) annotation (Line(points={{-59.4,-94},{
              -22,-94},{-22,-1.54286},{-15.0556,-1.54286}},
                                                         color={255,127,0}));
      connect(kB.KB_Out, modeSwitch.KB) annotation (Line(points={{-59.4,-124},{
              -18,-124},{-18,-5.82857},{-15.0556,-5.82857}},
                                                          color={255,127,0}));
      connect(kE.KE_Out, modeSwitch.KE) annotation (Line(points={{-59.4,-154},{
              -16,-154},{-16,-10.2857},{-15.0556,-10.2857}},
                                                          color={255,127,0}));
      connect(dD.DD_Out, modeSwitch.DD) annotation (Line(points={{-59.4,86},{
              -22,86},{-22,23.3143},{-15.0556,23.3143}},
                                                  color={255,127,0}));
      connect(modeSwitch.CurrentMode, valve_Y01.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,210},{139.2,210}},
                                                         color={255,127,0}));
      connect(valve_Y01.setValue_Y, busActors.openingY01) annotation (Line(
            points={{160.6,210},{230,210},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y03.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,170},{139.2,170}},
                                     color={255,127,0}));
      connect(valve_Y03.setValue_Y, busActors.openingY03) annotation (Line(
            points={{160.6,170},{230,170},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y04.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,150},{139.2,150}},
            color={255,127,0}));
      connect(valve_Y04.setValue_Y, busActors.openingY04) annotation (Line(
            points={{160.6,150},{230,150},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y05.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,130},{139.2,130}},
                                     color={255,127,0}));
      connect(valve_Y05.setValue_Y, busActors.openingY05) annotation (Line(
            points={{160.6,130},{230,130},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y07.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,90},{139.2,90}},            color={
              255,127,0}));
      connect(valve_Y07.setValue_Y, busActors.openingY07) annotation (Line(
            points={{160.6,90},{230,90},{230,0.2},{281.185,0.2}},   color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y08.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,70},{139.2,70}},            color={
              255,127,0}));
      connect(valve_Y08.setValue_Y, busActors.openingY08) annotation (Line(
            points={{160.6,70},{230,70},{230,0.2},{281.185,0.2}},   color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y09.Close, y09_evaluation.Y_closed)
        annotation (Line(points={{126.8,56},{139.4,56}}, color={255,0,255}));
      connect(valve_Y09.Control, y09_evaluation.Y_control)
        annotation (Line(points={{126.6,50},{139.4,50}}, color={255,0,255}));
      connect(modeSwitch.CurrentMode, valve_Y09.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,50},{105.2,50}}, color={255,127,0}));
      connect(y09_evaluation.y, busActors.openingY09) annotation (Line(points={{160.6,
              50},{230,50},{230,0.2},{281.185,0.2}},        color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y10.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,30},{105.2,30}}, color={255,127,0}));
      connect(valve_Y10.Close, y10_evaluation.Y_closed)
        annotation (Line(points={{126.8,36},{139.4,36}}, color={255,0,255}));
      connect(valve_Y10.Control, y10_evaluation.Y_control)
        annotation (Line(points={{126.6,30},{139.4,30}}, color={255,0,255}));
      connect(y10_evaluation.y, busActors.openingY10) annotation (Line(points={{160.6,
              30},{230,30},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y11.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,10},{105.2,10}}, color={255,127,0}));
      connect(y11_evaluation.y, busActors.openingY11) annotation (Line(points={{160.6,
              10},{230,10},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.y, modeSwitch.Mode_Index) annotation (Line(
            points={{-57.4,150},{5,150},{5,24.8571}},    color={255,127,0}));
      connect(modeSwitch.CurrentMode, exhaustFan.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-70},{139.2,-70}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, regFan.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-90},{139.2,-90}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, pumpN05.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-130},{139.2,-130}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, pumpN08.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-190},{139.2,-190}}, color={255,127,0}));
      connect(pumpN08.signal_pump, busActors.pumpN08) annotation (Line(points={{160.8,
              -190},{230,-190},{230,0.2},{281.185,0.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, pumpN04.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-110},{139.2,-110}}, color={255,127,0}));
      connect(pumpN04.signal_Pump, busActors.pumpN04) annotation (Line(points={{160.6,
              -110},{230,-110},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, pumpN06.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-150},{139.2,-150}}, color={255,127,0}));
      connect(pumpN06.signal_pump, busActors.pumpN06) annotation (Line(points={{160.8,
              -150},{230,-150},{230,0.2},{281.185,0.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, pumpN07.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-170},{139.2,-170}}, color={255,127,0}));
      connect(pumpN07.signal_pump, busActors.pumpN07) annotation (Line(points={{160.8,
              -170},{230,-170},{230,0.2},{281.185,0.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y02.valve_closed, y02_evaluation.Y02_closed) annotation (Line(
            points={{126.6,195},{132,195},{132,199},{139.2,199}}, color={255,0,255}));
      connect(valve_Y02.valve_open, y02_evaluation.Y02_open) annotation (Line(
            points={{126.6,190},{132,190},{132,194},{139.2,194}}, color={255,0,255}));
      connect(valve_Y02.valve_controlled, y02_evaluation.Y02_control) annotation (
          Line(points={{126.6,185},{132,185},{132,189},{139.2,189}}, color={255,0,255}));
      connect(modeSwitch.CurrentMode, valve_Y02.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,190},{105.2,190}}, color={255,127,0}));
      connect(y02_evaluation.y, busActors.openingY02) annotation (Line(points={{160.6,
              190},{230,190},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN06.signal_pump, y02_evaluation.adiabaticOn) annotation (Line(
            points={{160.8,-150},{230,-150},{230,182},{160.8,182}}, color={255,0,255}));
      connect(valve_Y11.Close, y11_evaluation.Y_closed)
        annotation (Line(points={{126.8,16},{139.4,16}}, color={255,0,255}));
      connect(valve_Y11.Control, y11_evaluation.Y_control)
        annotation (Line(points={{126.6,10},{139.4,10}}, color={255,0,255}));
      connect(OnSignal, modeSwitch.OnSignal) annotation (Line(points={{-226,170},
              {-4,170},{-4,24.8571},{-4.28889,24.8571}},
                                                     color={255,0,255}));
      connect(pumpN05.signal_pump, busActors.pumpN05) annotation (Line(points={
              {160.8,-130},{230,-130},{230,0.2},{281.185,0.2}}, color={255,0,
              255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y15.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-10},{105.2,-10}},          color={
              255,127,0}));
      connect(modeSwitch.CurrentMode, valve_Y16.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-30},{105.2,-30}},          color={
              255,127,0}));
      connect(eva_Y15.y, busActors.openingY15) annotation (Line(points={{160.6,
              -10},{230,-10},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(evaY16.y, busActors.openingY16) annotation (Line(points={{160.6,-30},{
              230,-30},{230,0.2},{281.185,0.2}},       color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y06.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,110},{105.2,110}},          color={
              255,127,0}));
      connect(valve_Y06.Open, y06_evaluation.Y_open)
        annotation (Line(points={{126.6,116},{139.4,116}}, color={255,0,255}));
      connect(valve_Y06.Control, y06_evaluation.Y_control)
        annotation (Line(points={{126.6,110},{139.4,110}}, color={255,0,255}));
      connect(regAnforderung.xDes, busSensors.xDes) annotation (Line(points={{-180.8,
              66},{-219.78,66},{-219.78,-3.75}},                  color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regAnforderung.xAbs, busSensors.xAbs) annotation (Line(points={{-180.8,
              74},{-220,74},{-219.78,-3.75}},                     color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hD.Y02_signal, busSensors.Y02_actual) annotation (Line(points={{
              -80.6,4.2},{-108,4.2},{-108,-3.75},{-219.78,-3.75}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hD.Y09_signal, busSensors.Y09_actual) annotation (Line(points={{
              -80.6,0.2},{-107.3,0.2},{-107.3,-3.75},{-219.78,-3.75}}, color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hD.T_out, busSensors.T04) annotation (Line(points={{-80.6,-11},{
              -108.3,-11},{-108.3,-3.75},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.Y02_signal, busSensors.Y02_actual) annotation (Line(points={{
              -80.6,-25.8},{-107.3,-25.8},{-107.3,-3.75},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.Y09_signal, busSensors.Y09_actual) annotation (Line(points={{
              -80.6,-29.8},{-108.3,-29.8},{-108.3,-3.75},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.T_out, busSensors.T04) annotation (Line(points={{-80.6,-41},{
              -108.3,-41},{-108.3,-3.75},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.T_Rek, busSensors.T_Rek) annotation (Line(
            points={{-78.6,159},{-220,159},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.phi_03, busSensors.T03_RelHum) annotation (
          Line(points={{-78.6,156},{-220,156},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.phi_01, busSensors.T01_RelHum) annotation (
          Line(points={{-78.6,153},{-220,153},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.signal_Y06, busSensors.Y06_actual)
        annotation (Line(points={{-78.6,150},{-220,150},{-219.78,-3.75}}, color=
             {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.signal_Y02, busSensors.Y02_actual)
        annotation (Line(points={{-78.6,147},{-220,147},{-219.78,-3.75}}, color=
             {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y02_evaluation.T_measure, busSensors.T01) annotation (Line(points=
             {{139.2,183},{90,183},{90,122},{-220,122},{-219.78,-3.75}}, color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y06_evaluation.phi_zu, busSensors.T01_RelHum) annotation (Line(
            points={{139.4,103},{90,103},{90,122},{-220,122},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y06_evaluation.y, busActors.openingY06) annotation (Line(points={
              {160.6,110},{230,110},{230,0.2},{281.185,0.2}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y09_evaluation.MeasuredValue, busSensors.T01) annotation (Line(
            points={{139.4,43},{90,43},{90,122},{-220,122},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y10_evaluation.MeasuredValue, busSensors.TDes) annotation (Line(
            points={{139.4,23},{90,23},{90,122},{-220,122},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y11_evaluation.MeasuredValue, busSensors.T01_RelHum) annotation (
          Line(points={{139.4,3},{90,3},{90,122},{-219.78,122},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y15.Close, eva_Y15.Y_closed)
        annotation (Line(points={{126.8,-4},{139.4,-4}}, color={255,0,255}));
      connect(valve_Y15.Control, eva_Y15.Y_AbsDesControl)
        annotation (Line(points={{126.6,-10},{139.4,-10}}, color={255,0,255}));
      connect(valve_Y16.Close, evaY16.Y_closed) annotation (Line(points={{126.8,-24},
              {132,-24},{132,-24},{139.4,-24}}, color={255,0,255}));
      connect(valve_Y16.Control, evaY16.Y_AbsDesControl) annotation (Line(points={{126.6,
              -30},{132,-30},{132,-30},{139.4,-30}}, color={255,0,255}));
      connect(eva_Y15.tankMassAbs, busSensors.mTankAbs) annotation (Line(points={{139.4,
              -17},{90,-17},{90,122},{-219.78,122},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(evaY16.tankMassDes, busSensors.mTankDes) annotation (Line(points={{139.4,
              -37},{90,-37},{90,122},{-220,122},{-219.78,-3.75}},    color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(outsideFan.dp_Fan, busActors.outsideFan_dp) annotation (Line(points={{
              160.6,-50},{230,-50},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(exhaustFan.dp_Fan, busActors.exhaustFan_dp) annotation (Line(points={{
              160.6,-70},{230,-70},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regFan.dp_Fan, busActors.regenerationFan_dp) annotation (Line(points={
              {160.6,-90},{230,-90},{230,0.2},{281.185,0.2}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(outsideFan.M_in, modeSwitch.CurrentMode) annotation (Line(points={{139.2,
              -50},{100,-50},{100,8.57143},{24.6333,8.57143}}, color={255,127,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-200},
                {280,220}})),            Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-220,-200},{280,220}}),
            graphics={
            Rectangle(
              extent={{-180,220},{44,104}},
              lineColor={0,0,0},
              fillColor={200,88,88},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-180,104},{44,-200}},
              lineColor={0,0,0},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{44,220},{240,-230}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-144,210},{10,184}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid,
              textString="Modiauswahl"),
            Text(
              extent={{-150,-168},{4,-194}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid,
              textString="Aktorsatz"),
            Text(
              extent={{70,-200},{224,-226}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid,
              textString="Aktorregelung")}));
    end ControlTest;

    model PNControl21 "PetriNet based control of RLT 21"

      parameter Real leak = 0.0001 "leakage before the valve switches";
      parameter Real d = 300 "delay for mode switching in s";
      parameter Modelica.SIunits.Temperature T_Set = 20+273.15 "set value for T01";
      parameter Real phi_Set = 0.5  "set value for phi (relative humidity) at T01";

      parameter Real mFlowNom_outFan = 5  "set value for outside air fan";
      parameter Real mFlowNom_exhFan = 5  "set value for exhaust air fan";
      parameter Real mFlowNom_regFan = 0  "set value for regeneration air fan";

      parameter Real k_y02 = 0.03;  //0.15;
      parameter Real Ti_y02 = 240;  //0.5;
      parameter Real k_y09 = 0.05;  //0.01//0.06 aus Einzelanalyse;
      parameter Real Ti_y09 = 180;  //180
      parameter Real k_phi = 0.28;  //80;  //0.08;
      parameter Real Ti_phi = 27;  //0.7;
      parameter Real k_Fan = 250;
      parameter Real Ti_Fan = 30;

      BusSensors busSensors
        annotation (Placement(transformation(extent={{-264,-54},{-176,46}})));
      BusActors busActors "Bus connector for actor signals"
        annotation (Placement(transformation(extent={{244,-40},{318,40}})));
      PN_Steuerung.PN_Main1_RLT21      pN_Steuerung_Ebene1_1(d=d)
        annotation (Placement(transformation(extent={{-78,140},{-58,160}})));
      PN_Steuerung.regDem regAnforderung
        "True, when there is need for regeneration"
        annotation (Placement(transformation(extent={{-180,60},{-160,80}})));
      PN_Steuerung.Ebene2.DD dD
        annotation (Placement(transformation(extent={{-80,76},{-60,96}})));
      PN_Steuerung.ModeSwitch modeSwitch
        annotation (Placement(transformation(extent={{-14,-12},{24,24}})));
      PN_Steuerung.Ebene2.DB dB
        annotation (Placement(transformation(extent={{-80,46},{-60,66}})));
      PN_Steuerung.Ebene2.DE dE
        annotation (Placement(transformation(extent={{-80,16},{-60,36}})));
      PN_Steuerung.Ebene2.HD hD(d=d, leak=leak)
        annotation (Placement(transformation(extent={{-80,-14},{-60,6}})));
      PN_Steuerung.Ebene2.HB hB(d=d, leak=leak)
        annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
      PN_Steuerung.Ebene2.HE hE
        annotation (Placement(transformation(extent={{-80,-74},{-60,-54}})));
      PN_Steuerung.Ebene2.KD kD
        annotation (Placement(transformation(extent={{-80,-104},{-60,-84}})));
      PN_Steuerung.Ebene2.KB kB
        annotation (Placement(transformation(extent={{-80,-134},{-60,-114}})));
      PN_Steuerung.Ebene2.KE kE
        annotation (Placement(transformation(extent={{-80,-164},{-60,-144}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y01(Y_Close(n=7, modes={1,2,3,4,5,6,7}),
          Y_Open(n=16, modes={8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}))
        "On_Off valve Y01"
        annotation (Placement(transformation(extent={{140,200},{160,220}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y03(Y_Close(n=16, modes={8,9,10,11,12,
              13,14,15,16,17,18,19,20,21,22,23}), Y_Open(n=7, modes={1,2,3,4,5,
              6,7})) "On Off valve Y03"
        annotation (Placement(transformation(extent={{140,160},{160,180}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y04(Y_Close(n=1, modes={1}), Y_Open(n=
             22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,
              23}))
        annotation (Placement(transformation(extent={{140,140},{160,160}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y05(Y_Close(n=1, modes={1}), Y_Open(n=
             22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,
              23}))
        annotation (Placement(transformation(extent={{140,120},{160,140}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y07(Y_Close(n=12, modes={1,2,3,4,8,9,
              10,11,12,13,14,15}), Y_Open(n=11, modes={5,6,7,16,17,18,19,20,21,
              22,23}))
        annotation (Placement(transformation(extent={{140,80},{160,100}})));
      PN_Steuerung.Aktoren.Y_On_Off valve_Y08(Y_Close(n=12, modes={1,2,3,4,8,9,
              10,11,12,13,14,15}), Y_Open(n=11, modes={5,6,7,16,17,18,19,20,21,
              22,23}))
        annotation (Placement(transformation(extent={{140,60},{160,80}})));
      PN_Steuerung.Aktoren.controlvalve2 valve_Y09(Y_Close(n=19, modes={1,2,3,4,5,6,
              7,8,9,10,11,14,15,16,17,18,19,22,23}), Y_Control(n=4, modes={12,13,20,
              21})) "controlValve"
        annotation (Placement(transformation(extent={{106,40},{126,60}})));
      PN_Steuerung.Auswertemodule.heaCoiEva y09_evaluation(
        k=k_y09,
        Ti=Ti_y09,
        Setpoint=T_Set)
        annotation (Placement(transformation(extent={{140,40},{160,60}})));
      PN_Steuerung.Aktoren.controlvalve2 valve_Y10(Y_Close(n=12, modes={1,2,3,4,8,9,
              10,11,12,13,14,15}), Y_Control(n=11, modes={5,6,7,16,17,18,19,20,21,22,
              23})) "controlValve"
        annotation (Placement(transformation(extent={{106,20},{126,40}})));
      PN_Steuerung.Auswertemodule.heaCoiEva y10_evaluation(
        k=k_y09,
        Ti=Ti_y09,
        Setpoint=60)
        annotation (Placement(transformation(extent={{140,20},{160,40}})));
      PN_Steuerung.Aktoren.controlvalve2 valve_Y11(
                                            Y_Control(n=8, modes={3,6,9,11,13,17,19,
              21}), Y_Close(n=15, modes={1,2,4,5,7,8,10,12,14,15,16,18,20,22,23}))
                    "controlValve"
        annotation (Placement(transformation(extent={{106,0},{126,20}})));
      PN_Steuerung.Auswertemodule.heaCoiEva      y11_evaluation(
        k=k_phi,
        Ti=Ti_phi,
        Setpoint=phi_Set)
        annotation (Placement(transformation(extent={{140,0},{160,20}})));
      PN_Steuerung.Aktoren.Fan_On_Off_PI outsideFan(
        mFlow_Set=mFlowNom_outFan,
        Fan_On(n=22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,
              22,23}),
        Fan_Off(n=1, modes={1}),
        k=k_Fan,
        Ti=Ti_Fan) "mass flow set point signal for outside fan"
        annotation (Placement(transformation(extent={{140,-60},{160,-40}})));
      PN_Steuerung.Aktoren.Fan_On_Off_PI exhaustFan(
        mFlow_Set=mFlowNom_exhFan,
        Fan_Off(n=1, modes={1}),
        Fan_On(n=22, modes={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,
              22,23}),
        k=k_Fan,
        Ti=Ti_Fan) "mass flow set point value for exhaust fan"
        annotation (Placement(transformation(extent={{140,-80},{160,-60}})));
      PN_Steuerung.Aktoren.Fan_On_Off_PI regFan(
        mFlow_Set=mFlowNom_regFan,
        Fan_Off(n=12, modes={1,2,3,4,8,9,10,11,12,13,14,15}),
        Fan_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}),
        k=k_Fan,
        Ti=Ti_Fan) "mass flow signal for regeneration fan"
        annotation (Placement(transformation(extent={{140,-100},{160,-80}})));
      PN_Steuerung.Aktoren.Pump_On_Off pumpN04(Pump_Off(n=19, modes={1,2,3,4,5,6,7,8,
              9,10,11,14,15,16,17,18,19,22,23}), Pump_On(n=4, modes={12,13,20,21}))
        "on off signal of pump N04 for heating coil circuit for supply air"
        annotation (Placement(transformation(extent={{140,-120},{160,-100}})));
      PN_Steuerung.Aktoren.Pump_Bool   pumpN05(Pump_Off(n=12, modes={1,2,3,4,8,9,10,
              11,12,13,14,15}), Pump_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}))
        "on off signal for pump N05, regeneration heating coil"
        annotation (Placement(transformation(extent={{140,-140},{160,-120}})));
      PN_Steuerung.Aktoren.Pump_Bool pumpN06(Pump_Off(n=17, modes={1,2,3,4,5,6,7,8,9,
              12,13,14,16,17,20,21,22}), Pump_On(n=6, modes={10,11,15,18,19,23}))
        "pump signal for N06 to activate adiabatic cooling"
        annotation (Placement(transformation(extent={{140,-160},{160,-140}})));
      PN_Steuerung.Aktoren.Pump_Bool pumpN07(Pump_Off(n=17, modes={1,2,3,5,6,8,9,10,
              11,12,13,16,17,18,19,20,21}), Pump_On(n=6, modes={4,7,14,15,22,23}))
        "absorber pump signal"
        annotation (Placement(transformation(extent={{140,-180},{160,-160}})));
      PN_Steuerung.Aktoren.Pump_Bool pumpN08(Pump_Off(n=12, modes={1,2,3,4,8,9,10,11,
              12,13,14,15}), Pump_On(n=11, modes={5,6,7,16,17,18,19,20,21,22,23}))
        "on off signal for pump N08, regeneration pump for desiccant solution"
        annotation (Placement(transformation(extent={{140,-200},{160,-180}})));
      PN_Steuerung.Auswertemodule.Y02_evaluation y02_evaluation(T_Set=T_Set,
        k=k_y02,
        Ti=Ti_y02,
        k_cool=k_y02,
        Ti_cool=Ti_y02)
        annotation (Placement(transformation(extent={{140,180},{160,200}})));
      PN_Steuerung.Aktoren.controlvalve3 valve_Y02(
        Y_Close(n=4, modes={12,13,20,21}),
        Y_Open(n=7, modes={1,2,3,4,5,6,7}),
        Y_Control(n=12, modes={8,9,10,11,14,15,16,17,18,19,22,23}))
        annotation (Placement(transformation(extent={{106,180},{126,200}})));
      Modelica.Blocks.Interfaces.BooleanInput OnSignal
        "Delivers signal to switch on or off the device"
        annotation (Placement(transformation(extent={{-246,150},{-206,190}})));
      PN_Steuerung.Aktoren.controlvalve2   valve_Y15(Y_Close(n=20, modes={1,2,3,
              4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21}), Y_Control(n=3,
            modes={7,22,23}))
        annotation (Placement(transformation(extent={{106,-20},{126,0}})));
      PN_Steuerung.Aktoren.controlvalve2   valve_Y16(Y_Close(n=20, modes={1,2,3,
              4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21}), Y_Control(n=3,
            modes={7,22,23}))
        annotation (Placement(transformation(extent={{106,-40},{126,-20}})));
      PN_Steuerung.Auswertemodule.Y15_evaluation         eva_Y15
        annotation (Placement(transformation(extent={{140,-20},{160,0}})));
      PN_Steuerung.Auswertemodule.Y16_evaluationSimple   evaY16
        annotation (Placement(transformation(extent={{140,-40},{160,-20}})));
      PN_Steuerung.Auswertemodule.bypassEva y06_evaluation
        annotation (Placement(transformation(extent={{140,100},{160,120}})));
      PN_Steuerung.Aktoren.bypassValve valve_Y06(Y_Open(n=17, modes={1,2,3,5,6,
              8,9,10,11,12,13,16,17,18,19,20,21}), Y_Control(n=6, modes={4,7,14,
              15,22,23}))
        annotation (Placement(transformation(extent={{106,100},{126,120}})));
    equation
      connect(dD.RegAnf, regAnforderung.RegAnf) annotation (Line(points={{-80.6,86},
              {-100,86},{-100,70},{-159.4,70}},   color={255,0,255}));
      connect(regAnforderung.RegAnf, dB.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,56},{-80.6,56}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, dE.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,26},{-80.6,26}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, hD.RegAnf) annotation (Line(points={{-159.4,70},{
              -100,70},{-100,-4},{-80.6,-4}},               color={255,0,255}));
      connect(regAnforderung.RegAnf, hB.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-34},{-80.6,-34}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, hE.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-64},{-80.6,-64}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, kD.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-94},{-80.6,-94}},              color={255,0,255}));
      connect(regAnforderung.RegAnf, kB.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-124},{-80.6,-124}},              color={255,0,
              255}));
      connect(regAnforderung.RegAnf, kE.RegAnf) annotation (Line(points={{-159.4,70},
              {-100,70},{-100,-154},{-80.6,-154}},              color={255,0,
              255}));
      connect(dB.DB_Out, modeSwitch.DB) annotation (Line(points={{-59.4,56},{
              -26,56},{-26,19.2},{-15.0556,19.2}},
                                             color={255,127,0}));
      connect(dE.DE_Out, modeSwitch.DE) annotation (Line(points={{-59.4,26},{
              -40,26},{-40,14.9143},{-15.0556,14.9143}},
                                                   color={255,127,0}));
      connect(hD.HD_Out, modeSwitch.HD) annotation (Line(points={{-59.4,-4},{
              -34,-4},{-34,10.8},{-15.0556,10.8}},
                                             color={255,127,0}));
      connect(hB.HB_Out, modeSwitch.HB) annotation (Line(points={{-59.4,-34},{
              -30,-34},{-30,6.85714},{-15.0556,6.85714}},
                                                       color={255,127,0}));
      connect(hE.HE_Out, modeSwitch.HE) annotation (Line(points={{-59.4,-64},{
              -26,-64},{-26,2.4},{-15.0556,2.4}},
                                               color={255,127,0}));
      connect(kD.KD_Out, modeSwitch.KD) annotation (Line(points={{-59.4,-94},{
              -22,-94},{-22,-1.54286},{-15.0556,-1.54286}},
                                                         color={255,127,0}));
      connect(kB.KB_Out, modeSwitch.KB) annotation (Line(points={{-59.4,-124},{
              -18,-124},{-18,-5.82857},{-15.0556,-5.82857}},
                                                          color={255,127,0}));
      connect(kE.KE_Out, modeSwitch.KE) annotation (Line(points={{-59.4,-154},{
              -16,-154},{-16,-10.2857},{-15.0556,-10.2857}},
                                                          color={255,127,0}));
      connect(dD.DD_Out, modeSwitch.DD) annotation (Line(points={{-59.4,86},{
              -22,86},{-22,23.3143},{-15.0556,23.3143}},
                                                  color={255,127,0}));
      connect(hD.Y02_signal, busSensors.Y02_actual) annotation (Line(points={{-80.6,
              4.2},{-101.3,4.2},{-101.3,-3.75},{-219.78,-3.75}},       color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hD.Y09_signal, busSensors.Y09_actual) annotation (Line(points={{-80.6,
              0.2},{-101.3,0.2},{-101.3,-3.75},{-219.78,-3.75}},       color={0,
              0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.Y02_signal, busSensors.Y02_actual) annotation (Line(points={{-80.6,
              -25.8},{-101.3,-25.8},{-101.3,-3.75},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.Y09_signal, busSensors.Y09_actual) annotation (Line(points={{-80.6,
              -29.8},{-101.3,-29.8},{-101.3,-3.75},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.T_Rek, busSensors.T_Rek) annotation (Line(
            points={{-78.6,159},{-219.78,159},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.phi_03, busSensors.T03_RelHum) annotation (
          Line(points={{-78.6,156},{-219.78,156},{-219.78,-3.75}},
                       color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.phi_01, busSensors.T01_RelHum) annotation (
          Line(points={{-78.6,153},{-219.78,153},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.signal_Y06, busSensors.Y06_actual)
        annotation (Line(points={{-78.6,150},{-219.78,150},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y01.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,210},{139.2,210}},
                                                         color={255,127,0}));
      connect(valve_Y01.setValue_Y, busActors.openingY01) annotation (Line(
            points={{160.6,210},{230,210},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y03.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,170},{139.2,170}},
                                     color={255,127,0}));
      connect(valve_Y03.setValue_Y, busActors.openingY03) annotation (Line(
            points={{160.6,170},{230,170},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y04.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,150},{139.2,150}},
            color={255,127,0}));
      connect(valve_Y04.setValue_Y, busActors.openingY04) annotation (Line(
            points={{160.6,150},{230,150},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y05.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,130},{139.2,130}},
                                     color={255,127,0}));
      connect(valve_Y05.setValue_Y, busActors.openingY05) annotation (Line(
            points={{160.6,130},{230,130},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y07.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,90},{139.2,90}},            color={
              255,127,0}));
      connect(valve_Y07.setValue_Y, busActors.openingY07) annotation (Line(
            points={{160.6,90},{230,90},{230,0.2},{281.185,0.2}},   color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y08.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,70},{139.2,70}},            color={
              255,127,0}));
      connect(valve_Y08.setValue_Y, busActors.openingY08) annotation (Line(
            points={{160.6,70},{230,70},{230,0.2},{281.185,0.2}},   color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y09.Close, y09_evaluation.Y_closed)
        annotation (Line(points={{126.8,56},{139.4,56}}, color={255,0,255}));
      connect(valve_Y09.Control, y09_evaluation.Y_control)
        annotation (Line(points={{126.6,50},{139.4,50}}, color={255,0,255}));
      connect(y09_evaluation.MeasuredValue, busSensors.T01) annotation (Line(
            points={{139.4,43},{88,43},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y09.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,50},{105.2,50}}, color={255,127,0}));
      connect(y09_evaluation.y, busActors.openingY09) annotation (Line(points={{160.6,
              50},{230,50},{230,0.2},{281.185,0.2}},        color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y10.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,30},{105.2,30}}, color={255,127,0}));
      connect(valve_Y10.Close, y10_evaluation.Y_closed)
        annotation (Line(points={{126.8,36},{139.4,36}}, color={255,0,255}));
      connect(valve_Y10.Control, y10_evaluation.Y_control)
        annotation (Line(points={{126.6,30},{139.4,30}}, color={255,0,255}));
      connect(y10_evaluation.y, busActors.openingY10) annotation (Line(points={{160.6,
              30},{230,30},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y11.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,10},{105.2,10}}, color={255,127,0}));
      connect(y11_evaluation.y, busActors.openingY11) annotation (Line(points={{160.6,
              10},{230,10},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pN_Steuerung_Ebene1_1.y, modeSwitch.Mode_Index) annotation (Line(
            points={{-57.4,150},{5,150},{5,24.8571}},    color={255,127,0}));
      connect(modeSwitch.CurrentMode,outsideFan. M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-50},{139.2,-50}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, exhaustFan.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-70},{139.2,-70}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, regFan.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-90},{139.2,-90}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, pumpN05.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-130},{139.2,-130}}, color={255,127,0}));
      connect(modeSwitch.CurrentMode, pumpN08.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-190},{139.2,-190}}, color={255,127,0}));
      connect(pumpN08.signal_pump, busActors.pumpN08) annotation (Line(points={{160.8,
              -190},{230,-190},{230,0.2},{281.185,0.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, pumpN04.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-110},{139.2,-110}}, color={255,127,0}));
      connect(pumpN04.signal_Pump, busActors.pumpN04) annotation (Line(points={{160.6,
              -110},{230,-110},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, pumpN06.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-150},{139.2,-150}}, color={255,127,0}));
      connect(pumpN06.signal_pump, busActors.pumpN06) annotation (Line(points={{160.8,
              -150},{230,-150},{230,0.2},{281.185,0.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, pumpN07.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-170},{139.2,-170}}, color={255,127,0}));
      connect(pumpN07.signal_pump, busActors.pumpN07) annotation (Line(points={{160.8,
              -170},{230,-170},{230,0.2},{281.185,0.2}}, color={255,0,255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y02.valve_closed, y02_evaluation.Y02_closed) annotation (Line(
            points={{126.6,195},{132,195},{132,199},{139.2,199}}, color={255,0,255}));
      connect(valve_Y02.valve_open, y02_evaluation.Y02_open) annotation (Line(
            points={{126.6,190},{132,190},{132,194},{139.2,194}}, color={255,0,255}));
      connect(valve_Y02.valve_controlled, y02_evaluation.Y02_control) annotation (
          Line(points={{126.6,185},{132,185},{132,189},{139.2,189}}, color={255,0,255}));
      connect(modeSwitch.CurrentMode, valve_Y02.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,190},{105.2,190}}, color={255,127,0}));
      connect(y02_evaluation.T_measure, busSensors.T01) annotation (Line(points={{139.2,
              183},{88,183},{88,118},{-219.78,118},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y02_evaluation.y, busActors.openingY02) annotation (Line(points={{160.6,
              190},{230,190},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN06.signal_pump, y02_evaluation.adiabaticOn) annotation (Line(
            points={{160.8,-150},{230,-150},{230,182},{160.8,182}}, color={255,0,255}));
      connect(pN_Steuerung_Ebene1_1.signal_Y02, busSensors.Y02_actual)
        annotation (Line(points={{-78.6,147},{-219.78,147},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y11.Close, y11_evaluation.Y_closed)
        annotation (Line(points={{126.8,16},{139.4,16}}, color={255,0,255}));
      connect(valve_Y11.Control, y11_evaluation.Y_control)
        annotation (Line(points={{126.6,10},{139.4,10}}, color={255,0,255}));
      connect(y11_evaluation.MeasuredValue, busSensors.T01_RelHum) annotation (
          Line(points={{139.4,3},{88,3},{88,118},{-219.78,118},{-219.78,-3.75}},
                               color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(outsideFan.dp_Fan, busActors.outsideFan_dp) annotation (Line(
            points={{160.6,-50},{230,-50},{230,0.2},{281.185,0.2}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(outsideFan.Measure_mFlow, busSensors.mFlowOut) annotation (Line(
            points={{139.4,-57},{88,-57},{88,118},{-219.78,118},{-219.78,-3.75}},
                               color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(OnSignal, modeSwitch.OnSignal) annotation (Line(points={{-226,170},
              {-4,170},{-4,24.8571},{-4.28889,24.8571}},
                                                     color={255,0,255}));
      connect(exhaustFan.dp_Fan, busActors.exhaustFan_dp) annotation (Line(points={{
              160.6,-70},{230,-70},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regFan.dp_Fan, busActors.regenerationFan_dp) annotation (Line(points={
              {160.6,-90},{230,-90},{230,0.2},{281.185,0.2}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(exhaustFan.Measure_mFlow, busSensors.mFlowExh) annotation (Line(
            points={{139.4,-77},{88,-77},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regFan.Measure_mFlow, busSensors.mFlowReg) annotation (Line(points={{139.4,
              -97},{88,-97},{88,118},{-219.78,118},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(pumpN05.signal_pump, busActors.pumpN05) annotation (Line(points={
              {160.8,-130},{230,-130},{230,0.2},{281.185,0.2}}, color={255,0,
              255}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y15.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-10},{105.2,-10}},          color={
              255,127,0}));
      connect(modeSwitch.CurrentMode, valve_Y16.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,-30},{105.2,-30}},          color={
              255,127,0}));
      connect(eva_Y15.y, busActors.openingY15) annotation (Line(points={{160.6,
              -10},{230,-10},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(evaY16.y, busActors.openingY16) annotation (Line(points={{160.6,
              -30},{230,-30},{230,0.2},{281.185,0.2}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y10_evaluation.MeasuredValue, busSensors.TDes) annotation (Line(
            points={{139.4,23},{88,23},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regAnforderung.xAbs, busSensors.xAbs) annotation (Line(points={{-180.8,
              74},{-219.78,74},{-219.78,-3.75}},                  color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(regAnforderung.xDes, busSensors.xDes) annotation (Line(points={{-180.8,
              66},{-219.78,66},{-219.78,-3.75}},                  color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y06_evaluation.phi_zu, busSensors.T01_RelHum) annotation (Line(
            points={{139.4,103},{88,103},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(y06_evaluation.y, busActors.openingY06) annotation (Line(points={
              {160.6,110},{230,110},{230,0.2},{281.185,0.2}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(modeSwitch.CurrentMode, valve_Y06.M_in) annotation (Line(points={{24.6333,
              8.57143},{100,8.57143},{100,110},{105.2,110},{105.2,110}},
            color={255,127,0}));
      connect(valve_Y06.Open, y06_evaluation.Y_open)
        annotation (Line(points={{126.6,116},{139.4,116}}, color={255,0,255}));
      connect(valve_Y06.Control, y06_evaluation.Y_control)
        annotation (Line(points={{126.6,110},{139.4,110}}, color={255,0,255}));
      connect(hD.T_out, busSensors.T04) annotation (Line(points={{-80.6,-11},{
              -100.3,-11},{-100.3,-3.75},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(hB.T_out, busSensors.T04) annotation (Line(points={{-80.6,-41},{
              -100.3,-41},{-100.3,-3.75},{-219.78,-3.75}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y15.Close, eva_Y15.Y_closed)
        annotation (Line(points={{126.8,-4},{139.4,-4}}, color={255,0,255}));
      connect(valve_Y15.Control, eva_Y15.Y_AbsDesControl)
        annotation (Line(points={{126.6,-10},{139.4,-10}}, color={255,0,255}));
      connect(evaY16.tankMassDes, busSensors.mTankDes) annotation (Line(points=
              {{139.4,-37},{88,-37},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(eva_Y15.tankMassAbs, busSensors.mTankAbs) annotation (Line(points=
             {{139.4,-17},{88,-17},{88,118},{-219.78,118},{-219.78,-3.75}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valve_Y16.Close, evaY16.Y_closed) annotation (Line(points={{126.8,
              -24},{134,-24},{134,-24},{139.4,-24}}, color={255,0,255}));
      connect(valve_Y16.Control, evaY16.Y_AbsDesControl) annotation (Line(
            points={{126.6,-30},{134,-30},{134,-30},{139.4,-30}}, color={255,0,
              255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-200},
                {280,220}})),            Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-220,-200},{280,220}}),
            graphics={
            Rectangle(
              extent={{-180,220},{44,104}},
              lineColor={0,0,0},
              fillColor={200,88,88},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-180,104},{44,-200}},
              lineColor={0,0,0},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{44,220},{240,-230}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-144,210},{10,184}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid,
              textString="Modiauswahl"),
            Text(
              extent={{-150,-168},{4,-194}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid,
              textString="Aktorsatz"),
            Text(
              extent={{70,-200},{224,-226}},
              lineColor={0,0,0},
              fillColor={170,255,170},
              fillPattern=FillPattern.Solid,
              textString="Aktorregelung")}));
    end PNControl21;
  end OperatingModes;
end Controllers;
