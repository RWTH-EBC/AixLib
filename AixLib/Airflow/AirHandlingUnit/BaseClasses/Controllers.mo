within AixLib.Airflow.AirHandlingUnit.BaseClasses;
package Controllers "contains all the control models"
  extends Modelica.Icons.VariantsPackage;
  model MenergaController
    "contains the control modes for the menerga model"


    BusController busController annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=0,
          origin={98,2})));
    fixedValues fixedValues1
      annotation (Placement(transformation(extent={{-10,64},{10,84}})));
  equation
    if true then
      connect(fixedValues1.busController, busController);
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end MenergaController;

  model fixedValues "development mode parameter"
    BusController busController
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
    connect(valOpeningY01.y, busController.openingY01) annotation (Line(points={{-201,
            224},{-68,224},{-68,-69.64},{101.375,-69.64}},
                                                         color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valOpeningY02.y, busController.openingY02) annotation (Line(points={{-201,
            192},{-68,192},{-68,-69.64},{101.375,-69.64}},
                                                        color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valOpeningY03.y, busController.openingY03) annotation (Line(points={{-201,
            160},{-68,160},{-68,-69.64},{101.375,-69.64}},
                                                         color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valOpeningY04.y, busController.openingY04) annotation (Line(points={{-199,
            126},{-68,126},{-68,-69.64},{101.375,-69.64}},
                                                      color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valOpeningY05.y, busController.openingY05) annotation (Line(points={{-199,94},
            {-68,94},{-68,-69.64},{101.375,-69.64}},   color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valOpeningY06.y, busController.openingY06) annotation (Line(points={{-199,64},
            {-68,64},{-68,-69.64},{101.375,-69.64}},   color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valOpeningY07.y, busController.openingY07) annotation (Line(points={{-199,34},
            {-68,34},{-68,-69.64},{101.375,-69.64}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(valOpeningY08.y, busController.openingY08) annotation (Line(points={{-199,2},
            {-68,2},{-68,-69.64},{101.375,-69.64}},      color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(InletFlow_mflow.y, busController.outsideFan) annotation (Line(
          points={{-199,-28},{-68,-28},{-68,-69.64},{101.375,-69.64}},
                                                              color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(RegenAir_mflow.y, busController.regenerationFan) annotation (Line(
          points={{-199,-58},{-68,-58},{-68,-69.64},{101.375,-69.64}},
                                                              color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(exhaust_mflow.y, busController.exhaustFan) annotation (Line(points={{-199,
            -88},{-68,-88},{-68,-69.64},{101.375,-69.64}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(InletFlow_mflow1.y, busController.mWatSteamHumid) annotation (Line(
          points={{-199,-118},{-68,-118},{-68,-69.64},{101.375,-69.64}},
                                                                color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(InletFlow_mflow2.y, busController.mWatAbsorber) annotation (Line(
          points={{-199,-150},{-68,-150},{-68,-69.64},{101.375,-69.64}},
                                                                color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(InletFlow_mflow3.y, busController.mWatEvaporator) annotation (Line(
          points={{-199,-214},{-68,-214},{-68,-69.64},{101.375,-69.64}}, color=
            {0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    connect(InletFlow_mflowDes.y, busController.mWatDesorber) annotation (Line(
          points={{-199,-180},{-68,-180},{-68,-69.64},{101.375,-69.64}}, color=
            {0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-400,
              -240},{100,260}})), Diagram(coordinateSystem(preserveAspectRatio=
              false, extent={{-400,-240},{100,260}})));
  end fixedValues;
end Controllers;
