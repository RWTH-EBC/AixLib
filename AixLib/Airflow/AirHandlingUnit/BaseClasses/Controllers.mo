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
  equation
    if true then
      connect(development.busActors, busActors);
    end if;

    connect(busSensors, development.busSensors) annotation (Line(
        points={{-100,-34},{-56,-34},{-56,37.04},{-11.56,37.04}},
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
      Modelica.Blocks.Continuous.LimPID mWatSteHum_u( yMax=1, yMin=0,
        Td=10,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        Ti=80,
        k=0.06) "nominal water mass flow for steam humidifier"
        annotation (Placement(transformation(extent={{-220,-130},{-200,-110}})));
      Modelica.Blocks.Sources.Constant relHumSetPoi(k=0.5)
        "set point for the relative humidity" annotation (Placement(
            transformation(extent={{-290,-124},{-270,-104}})));
      Modelica.Blocks.Math.Gain gainAbs(k=0.1)
        "gain for absorber water mass flow" annotation (Placement(
            transformation(extent={{-218,-158},{-198,-138}})));
      Modelica.Blocks.Math.Division mFlowAbsPart
        "gives the part of the mass flow rate that goes through the absorber"
        annotation (Placement(transformation(extent={{-296,-184},{-276,-164}})));
      Modelica.Blocks.Sources.Constant mFlowAirNom(k=5.1)
        "nominal mass flow rate of air in supply air vent in kg/s" annotation (
          Placement(transformation(extent={{-354,-196},{-334,-176}})));
      Modelica.Blocks.Sources.Constant valOpeningY02(k=0) "opening of Y02"
        annotation (Placement(transformation(extent={{-222,202},{-202,222}})));
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
            points={{-199,-214},{-68,-214},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflowDes.y, busActors.mWatDesorber) annotation (Line(
            points={{-199,-180},{-68,-180},{-68,-69.64},{101.375,-69.64}},
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
            points={{-199,-248},{101.375,-248},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(mWatSteHum_u.u_m, busSensors.T01_RelHum) annotation (Line(points=
              {{-210,-132},{-346,-132},{-346,-63.61},{-388.575,-63.61}}, color=
              {0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(relHumSetPoi.y, mWatSteHum_u.u_s) annotation (Line(points={{-269,
              -114},{-256,-114},{-256,-120},{-222,-120}}, color={0,0,127}));
      connect(mWatSteHum_u.y, busActors.mWatSteamHumid) annotation (Line(points
            ={{-199,-120},{-32,-120},{-32,-69.64},{101.375,-69.64}}, color={0,0,
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
      connect(mFlowAirNom.y, mFlowAbsPart.u2) annotation (Line(points={{-333,
              -186},{-316,-186},{-316,-180},{-298,-180}}, color={0,0,127}));
      connect(gainAbs.y, busActors.mWatAbsorber) annotation (Line(points={{-197,
              -148},{-197,-148},{-68,-148},{-68,-69.64},{101.375,-69.64}},
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
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-400,
                -240},{100,260}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-400,-240},{100,260}})));
    end development;
  end OperatingModes;
end Controllers;
