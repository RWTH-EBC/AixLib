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
        annotation (Placement(transformation(extent={{-222,214},{-202,234}})));
      Modelica.Blocks.Sources.Constant valOpeningY02(k=0) "opening of Y02"
        annotation (Placement(transformation(extent={{-222,182},{-202,202}})));
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
      Modelica.Blocks.Sources.Constant InletFlow_mflow1(k=1)
        "nominal mass flow in steamHumidifier"
        annotation (Placement(transformation(extent={{-220,-128},{-200,-108}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow2(k=0.1)
        "water mass flow in absorber"
        annotation (Placement(transformation(extent={{-220,-160},{-200,-140}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow3(k=0.1)
        "water mass flow in absorber"
        annotation (Placement(transformation(extent={{-220,-224},{-200,-204}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflowDes(k=0.1)
        "water mass flow in desorber"
        annotation (Placement(transformation(extent={{-220,-190},{-200,-170}})));
    equation
      connect(valOpeningY01.y, busActors.openingY01) annotation (Line(points={{
              -201,224},{-68,224},{-68,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY02.y, busActors.openingY02) annotation (Line(points={{
              -201,192},{-68,192},{-68,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
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
      connect(InletFlow_mflow1.y, busActors.mWatSteamHumid) annotation (Line(
            points={{-199,-118},{-68,-118},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow2.y, busActors.mWatAbsorber) annotation (Line(
            points={{-199,-150},{-68,-150},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
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
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-400,
                -240},{100,260}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-400,-240},{100,260}})));
    end FixedValues;

    model development "development mode with simple PID controllers"
      BusActors busActors "Bus connector for actor signals"
        annotation (Placement(transformation(extent={{26,-142},{176,2}})));
      Modelica.Blocks.Sources.Constant valOpeningY01(k=1) "opening of Y01"
        annotation (Placement(transformation(extent={{-222,214},{-202,234}})));
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
      Modelica.Blocks.Sources.Constant InletFlow_mflow1(k=1)
        "nominal mass flow in steamHumidifier"
        annotation (Placement(transformation(extent={{-220,-128},{-200,-108}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow2(k=0.1)
        "water mass flow in absorber"
        annotation (Placement(transformation(extent={{-220,-160},{-200,-140}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflow3(k=0.2)
        "water mass flow in absorber"
        annotation (Placement(transformation(extent={{-220,-224},{-200,-204}})));
      Modelica.Blocks.Sources.Constant InletFlow_mflowDes(k=0.1)
        "water mass flow in desorber"
        annotation (Placement(transformation(extent={{-220,-190},{-200,-170}})));
      BusSensors busSensors
        annotation (Placement(transformation(extent={{-474,-142},{-304,14}})));
      Modelica.Blocks.Continuous.LimPID valOpeningY02(yMax=1, yMin=0)
        "opening for damper Y02"
        annotation (Placement(transformation(extent={{-222,182},{-202,202}})));
      Modelica.Blocks.Sources.Constant T01_Set(k=293.15) "Setpoint of T01"
        annotation (Placement(transformation(extent={{-306,176},{-286,196}})));
      Modelica.Blocks.Sources.Constant constOne(k=1)
        annotation (Placement(transformation(extent={{-340,194},{-320,214}})));
      Modelica.Blocks.Math.Add add(k2=-1)
        annotation (Placement(transformation(extent={{-136,188},{-116,208}})));
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
      connect(InletFlow_mflow1.y, busActors.mWatSteamHumid) annotation (Line(
            points={{-199,-118},{-68,-118},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(InletFlow_mflow2.y, busActors.mWatAbsorber) annotation (Line(
            points={{-199,-150},{-68,-150},{-68,-69.64},{101.375,-69.64}},
            color={0,0,127}), Text(
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
      connect(valOpeningY02.u_m, busSensors.T01) annotation (Line(points={{-212,
              180},{-272,180},{-272,166},{-342,166},{-342,-63.61},{-388.575,
              -63.61}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(T01_Set.y, valOpeningY02.u_s) annotation (Line(points={{-285,186},
              {-254,186},{-254,192},{-224,192}}, color={0,0,127}));
      connect(constOne.y, add.u1) annotation (Line(points={{-319,204},{-250,204},
              {-138,204}}, color={0,0,127}));
      connect(valOpeningY02.y, add.u2)
        annotation (Line(points={{-201,192},{-138,192}}, color={0,0,127}));
      connect(add.y, busActors.openingY02) annotation (Line(points={{-115,198},
              {-115,198},{-68,198},{-68,-69.64},{101.375,-69.64}}, color={0,0,
              127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(valOpeningY02.y, busActors.openingY01) annotation (Line(points={{
              -201,192},{-150,192},{-150,218},{-68,218},{-68,-69.64},{101.375,
              -69.64}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-400,
                -240},{100,260}})), Diagram(coordinateSystem(preserveAspectRatio=
                false, extent={{-400,-240},{100,260}})));
    end development;
  end OperatingModes;
end Controllers;
