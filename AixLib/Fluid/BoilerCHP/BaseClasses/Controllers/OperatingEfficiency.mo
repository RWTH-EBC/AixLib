within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model OperatingEfficiency

   parameter Modelica.Units.SI.Temperature TColdNom=273.15 + 35
                                                              "Nominal TCold";
   parameter Modelica.Units.SI.HeatFlowRate QNom=50000 "Nominal thermal power";
  parameter
    AixLib.DataBase.Boiler.NotManufacturer.EtaTExhaust.EtaTExhaustBaseDataDefinition
    paramEta=AixLib.DataBase.Boiler.NotManufacturer.EtaTExhaust.Ambient1();
   parameter Real EtaTable[:,2]=paramEta.EtaTable;
   parameter Modelica.Units.SI.TemperatureDifference dTWaterNom=20 "Nominal temperature difference heat circuit";

package Medium=AixLib.Media.Water;


  SDF.NDTable boilerEffciency(
    nin=5,
    readFromFile=true,
    filename=Filename,
    dataset="/ETA_Kennfeld",
    dataUnit="-",
    scaleUnits={"degC","-","-","K","K"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    annotation (Placement(transformation(extent={{2,12},{22,32}})));

  Modelica.Blocks.Sources.RealExpression Dim_1(y=TColdNom)
    "Nominal return temperature"
    annotation (Placement(transformation(extent={{-238,106},{-192,126}})));

  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
    annotation (Placement(transformation(extent={{-96,106},{-76,126}})));

  Modelica.Blocks.Routing.Multiplex5 multiplex5_1
    annotation (Placement(transformation(extent={{-38,12},{-18,32}})));
  Modelica.Blocks.Sources.RealExpression Dim4(y=dTWaterNom) "Nominal heat flow"
    annotation (Placement(transformation(extent={{-178,6},{-128,28}})));
  Modelica.Blocks.Math.Add Dim5(k1=-1, k2=1)
                                       "RetrunTempDiff"
    annotation (Placement(transformation(extent={{-170,-58},{-150,-38}})));
  Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-8,90},{12,110}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-154,70},{-134,90}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{-240,24},{-220,44}})));
  Modelica.Blocks.Sources.RealExpression Dim1(y=m_flow_nominal)
                                                            "Nominal heat flow"
    annotation (Placement(transformation(extent={{-326,14},{-276,42}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{-242,64},{-222,84}})));
protected
  parameter String Filename="D:/mzu-sciebo/mzu/Dissertation/Paper/boiler-paper/Data/Eta_Boiler.sdf";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=QNom/(Medium.cp_const*dTWaterNom);
equation

  connect(Dim_1.y, fromKelvin.Kelvin)
    annotation (Line(points={{-189.7,116},{-98,116}},
                                                    color={0,0,127}));
  connect(Dim_1.y, Dim5.u1) annotation (Line(points={{-189.7,116},{-182,116},{-182,
          -42},{-172,-42}},                                  color={0,0,127}));
  connect(boilerEffciency.u, multiplex5_1.y)
    annotation (Line(points={{0,22},{-17,22}}, color={0,0,127}));
  connect(fromKelvin.Celsius, multiplex5_1.u1[1]) annotation (Line(points={{-75,
          116},{-66,116},{-66,112},{-56,112},{-56,32},{-40,32}}, color={0,0,127}));
  connect(Dim4.y, multiplex5_1.u4[1]) annotation (Line(points={{-125.5,17},{-40,
          17}},                                           color={0,0,127}));
  connect(Dim5.y, multiplex5_1.u5[1]) annotation (Line(points={{-149,-48},{-64,-48},
          {-64,12},{-40,12}}, color={0,0,127}));
  connect(boilerControlBus.TReturnMea, Dim5.u2) annotation (Line(
      points={{2.05,100.05},{2.05,52},{-200,52},{-200,-54},{-172,-54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add2.y, division1.u1) annotation (Line(points={{-133,80},{-128,80},{-128,
          76},{-122,76}}, color={0,0,127}));
  connect(Dim4.y, division1.u2) annotation (Line(points={{-125.5,17},{-118,17},{
          -118,50},{-132,50},{-132,64},{-122,64}}, color={0,0,127}));
  connect(division1.y, multiplex5_1.u3[1]) annotation (Line(points={{-99,70},{-90,
          70},{-90,22},{-40,22}}, color={0,0,127}));
  connect(boilerControlBus.m_flow, division2.u1) annotation (Line(
      points={{2.05,100.05},{-286,100.05},{-286,40},{-242,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Dim1.y, division2.u2)
    annotation (Line(points={{-273.5,28},{-242,28}}, color={0,0,127}));
  connect(Dim_1.y, add2.u2) annotation (Line(points={{-189.7,116},{-170,116},{-170,
          74},{-156,74}}, color={0,0,127}));
  connect(boilerControlBus.TSupplySet, add2.u1) annotation (Line(
      points={{2.05,100.05},{-162,100.05},{-162,86},{-156,86}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(boilerEffciency.y, boilerControlBus.Efficiency) annotation (Line(
        points={{23,22},{30,22},{30,28},{34,28},{34,100.05},{2.05,100.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(division2.y, limiter.u) annotation (Line(points={{-219,34},{-212,34},
          {-212,54},{-260,54},{-260,74},{-244,74}}, color={0,0,127}));
  connect(limiter.y, multiplex5_1.u2[1]) annotation (Line(points={{-221,74},{
          -74,74},{-74,27},{-40,27}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model estimates the exhaust temperature. The adiabatic efficiency is a function of the exhaust temperature. The power demand is the sum of the ambient losses, the given thermal power of the setpoint and the exhaust losses.</p>
<p><img src=\"modelica://AixLib/../../../Diagramme AixLib/Boiler/Kennfeld_TAG_PLRvar_20K_mNom.png\"/></p>
</html>"));
end OperatingEfficiency;
