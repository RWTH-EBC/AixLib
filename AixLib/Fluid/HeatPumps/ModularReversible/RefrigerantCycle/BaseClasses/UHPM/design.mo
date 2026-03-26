within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM;
model Design


    extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.PartialBase;
    extends AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.ParamsUHPM;



  Modelica.Blocks.Math.Division NomPel "Nominal electric Power"
    annotation (Placement(transformation(extent={{46,36},{66,56}})));

  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{80,62},{100,82}})));

  Modelica.Blocks.Sources.RealExpression tSourceNom(y=TEvaInNom)
    annotation (Placement(transformation(extent={{-100,40},{-74,64}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,52})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-56,-58})));
  Modelica.Blocks.Sources.RealExpression qNom(y=QConNom)
    annotation (Placement(transformation(extent={{0,76},{26,96}})));
  Modelica.Blocks.Sources.RealExpression deltaTCon(y=DeltaTCon)
    annotation (Placement(transformation(extent={{12,11},{-12,-11}},
        rotation=180,
        origin={-88,-17})));
  Modelica.Blocks.Routing.Multiplex4 multiplex4_1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-24,-6})));
  SDF.NDTable SDFCOPDesign(
    final nin=4,
    final readFromFile=true,
    final filename=filename_COP,
    final dataset="\COP",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
    "SDF-Table data for COP" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={18,40})));

  Modelica.Blocks.Sources.RealExpression tHotNom(y=TConOutNom)
                                                            annotation (
      Placement(transformation(
        extent={{12,10},{-12,-10}},
        rotation=180,
        origin={-86,-58})));

  Modelica.Blocks.Math.Log log1
    annotation (Placement(transformation(extent={{50,-76},{70,-56}})));
  SDF.NDTable SDF_PI_Design(
    final nin=4,
    final readFromFile=true,
    final filename=filename_PI,
    final dataset="\PI",
    final dataUnit="-",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
    "SDF-Table data for PressureRatio" annotation (Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={20,-80})));

  Modelica.Blocks.Sources.RealExpression NomFrequency1(y=50)
    "Frequency if Modulating=false" annotation (Placement(transformation(
        extent={{11,12},{-11,-12}},
        rotation=180,
        origin={-89,4})));

  SDF.NDTable SDF_T_Design(
    final nin=4,
    final readFromFile=true,
    final filename=filename_T_Comp,
    final dataset="\T_mean_comp",
    final dataUnit="K",
    final scaleUnits={"degC","Hz","K","degC"},
    final interpMethod=SDF.Types.InterpolationMethod.Linear,
    final extrapMethod=SDF.Types.ExtrapolationMethod.Hold)
    "SDF-Table data for mean compressor temperature" annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=0,
        origin={28,-30})));

  Modelica.Blocks.Math.Product product3
    annotation (Placement(transformation(extent={{94,-56},{114,-36}})));

  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Modelica.Blocks.Interfaces.RealOutput QEvaDes(final unit="W", final
      displayUnit="kW") "design evaporator power" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={130,72})));
  Modelica.Blocks.Interfaces.RealOutput PelDes(final unit="W", final
      displayUnit="kW") "design electric power" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={130,0})));
  Modelica.Blocks.Interfaces.RealOutput ComDes
    "compressor operating at design conditions" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={130,-46})));
equation
  connect(tSourceNom.y, fromKelvin3.Kelvin)
    annotation (Line(points={{-72.7,52},{-52,52}}, color={0,0,127}));
  connect(qNom.y, NomPel.u1) annotation (Line(points={{27.3,86},{38,86},{38,52},
          {44,52}}, color={0,0,127}));
  connect(SDFCOPDesign.y, NomPel.u2)
    annotation (Line(points={{31.2,40},{44,40}},  color={0,0,127}));
  connect(multiplex4_1.y, SDFCOPDesign.u)
    annotation (Line(points={{-13,-6},{-2,-6},{-2,40},{3.6,40}},
                                                 color={0,0,127}));
  connect(fromKelvin3.Celsius, multiplex4_1.u1[1]) annotation (Line(points={{-29,52},
          {-18,52},{-18,38},{-64,38},{-64,4},{-36,4},{-36,3}},
                                                  color={0,0,127}));
  connect(deltaTCon.y, multiplex4_1.u3[1])
    annotation (Line(points={{-74.8,-17},{-60,-17},{-60,-9},{-36,-9}},
                                                            color={0,0,127}));
  connect(fromKelvin2.Celsius, multiplex4_1.u4[1])
    annotation (Line(points={{-45,-58},{-38,-58},{-38,-36},{-48,-36},{-48,-16},{
          -36,-16},{-36,-15}},                            color={0,0,127}));
  connect(fromKelvin2.Kelvin, tHotNom.y) annotation (Line(points={{-68,-58},{-72.8,
          -58}},                            color={0,0,127}));
  connect(SDF_PI_Design.y, log1.u)
    annotation (Line(points={{33.2,-80},{44,-80},{44,-66},{48,-66}},
                                                 color={0,0,127}));
  connect(multiplex4_1.y, SDF_PI_Design.u) annotation (Line(points={{-13,-6},{-4,
          -6},{-4,-80},{5.6,-80}},color={0,0,127}));
  connect(qNom.y, add.u1) annotation (Line(points={{27.3,86},{74,86},{74,78},{78,
          78}},                        color={0,0,127}));
  connect(NomPel.y, add.u2) annotation (Line(points={{67,46},{72,46},{72,66},{78,
          66}},      color={0,0,127}));
  connect(multiplex4_1.y, SDF_T_Design.u) annotation (Line(points={{-13,-6},{-4,
          -6},{-4,-30},{13.6,-30}},          color={0,0,127}));
  connect(log1.y, product3.u2)
    annotation (Line(points={{71,-66},{82,-66},{82,-52},{92,-52}},
                                                color={0,0,127}));
  connect(SDF_T_Design.y, toKelvin.Celsius) annotation (Line(points={{41.2,-30},
          {48,-30}},                   color={0,0,127}));
  connect(toKelvin.Kelvin, product3.u1) annotation (Line(points={{71,-30},{86,-30},
          {86,-40},{92,-40}},                                  color={0,0,127}));
  connect(add.y, QEvaDes) annotation (Line(points={{101,72},{130,72}},
                                         color={0,0,127}));
  connect(NomPel.y, PelDes) annotation (Line(points={{67,46},{100,46},{100,0},{130,
          0}},                            color={0,0,127}));
  connect(product3.y, ComDes) annotation (Line(points={{115,-46},{130,-46}},
                                  color={0,0,127}));
  connect(NomFrequency1.y, multiplex4_1.u2[1]) annotation (Line(points={{-76.9,4},
          {-70,4},{-70,-3},{-36,-3}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{120,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{120,
            100}}),     graphics={
        Text(
          extent={{-98,198},{66,188}},
          textColor={28,108,200},
          textString="Design Full-Load & Evap-Power")}),
    Documentation(info="<html><p>
  Auslegung des Betriebspunktes indem die maximale elektrische Leistung
  vorliegt
</p>
</html>"));
end Design;
