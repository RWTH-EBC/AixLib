within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model OperatingEfficiency

   parameter Modelica.Units.SI.Temperature T_cold_nom=273.15 + 35
                                                              "Nominal return temperature";
   parameter Modelica.Units.SI.HeatFlowRate Q_nom=50000 "Nominal firing power";
  parameter
    AixLib.DataBase.Boiler.NotManufacturer.EtaTExhaust.EtaTExhaustBaseDataDefinition
    paramEta=AixLib.DataBase.Boiler.NotManufacturer.EtaTExhaust.Ambient1();
   parameter Real EtaTable[:,2]=paramEta.EtaTable;
   parameter Modelica.Units.SI.TemperatureDifference dT_w_nom=20 "Nominal temperature difference between flow and return";

package Medium=AixLib.Media.Water;


  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
    annotation (Placement(transformation(extent={{-26,38},{-8,56}})));

  Modelica.Blocks.Sources.RealExpression DeltaTWaterNominal(y=dT_w_nom) "Nominal temperature difference of flow and return temperature"
    annotation (Placement(transformation(extent={{-100,-80},{-42,-44}})));
  Systems.ModularEnergySystems.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{-8,90},{12,110}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-48,16},{-30,34}})));
  Modelica.Blocks.Math.Division division2
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Blocks.Sources.RealExpression M_flowNominal(y=m_flow_nom) "Nominal mass flow rate"
    annotation (Placement(transformation(extent={{-96,-30},{-46,-2}})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1
    annotation (Placement(transformation(extent={{24,12},{44,32}})));
  SDF.NDTable boilerEffciency2(
    nin=4,
    readFromFile=true,
    filename=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/DataBase/Boiler/General/Boiler_Eta_4D.sdf"),
    dataset="/ETA_Kennfeld",
    dataUnit="-",
    scaleUnits={"degC","K","-","K"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
    annotation (Placement(transformation(extent={{60,12},{80,32}})));
  Modelica.Blocks.Sources.RealExpression t_cold_nom(y=T_cold_nom)
    "Nominal return Temperature"
    annotation (Placement(transformation(extent={{-82,34},{-42,60}})));
protected
  parameter String Filename="D:/mzu-sciebo/mzu/Dissertation/Paper/boiler-paper/Data/Temperaturen/Eta_Boiler_Temperaturen.sdf";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nom=Q_nom/(Medium.cp_const*dT_w_nom);
equation

  connect(boilerControlBus.m_flowMea, division2.u1) annotation (Line(
      points={{2.05,100.05},{-100,100.05},{-100,-4},{-22,-4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(M_flowNominal.y, division2.u2)
    annotation (Line(points={{-43.5,-16},{-22,-16}}, color={0,0,127}));
  connect(fromKelvin.Celsius, multiplex4_1.u1[1])
    annotation (Line(points={{-7.1,47},{22,47},{22,31}}, color={0,0,127}));
  connect(boilerControlBus.TColdMea, add2.u2) annotation (Line(
      points={{2.05,100.05},{2.05,100},{-100,100},{-100,19.6},{-49.8,19.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(add2.y, multiplex4_1.u2[1])
    annotation (Line(points={{-29.1,25},{22,25}}, color={0,0,127}));
  connect(division2.y, multiplex4_1.u3[1]) annotation (Line(points={{1,-10},{16,
          -10},{16,19},{22,19}}, color={0,0,127}));
  connect(DeltaTWaterNominal.y, multiplex4_1.u4[1])
    annotation (Line(points={{-39.1,-62},{22,-62},{22,13}}, color={0,0,127}));
  connect(boilerControlBus.TSupplyMea, add2.u1) annotation (Line(
      points={{2.05,100.05},{-100,100.05},{-100,30.4},{-49.8,30.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(multiplex4_1.y, boilerEffciency2.u)
    annotation (Line(points={{45,22},{58,22}}, color={0,0,127}));
  connect(boilerEffciency2.y, boilerControlBus.Efficiency) annotation (Line(
        points={{81,22},{96,22},{96,68},{2.05,68},{2.05,100.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fromKelvin.Kelvin, t_cold_nom.y)
    annotation (Line(points={{-27.8,47},{-40,47}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                      Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255})}),                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: Arial;\">This model calculates the efficiency for operation to estimate the transferred heat flow from exhaust to water flow.</span></p>
</html>"));
end OperatingEfficiency;
