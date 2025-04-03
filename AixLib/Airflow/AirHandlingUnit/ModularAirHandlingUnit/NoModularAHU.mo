within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit;
model NoModularAHU "No Modular AHU (dummy model)"
  extends AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.BaseClasses.PartialModularAHU;
  // dummys
  Modelica.Blocks.Sources.Constant dummyT_supplyAirOut(k=293)
    annotation (Placement(transformation(extent={{100,-38},{118,-20}})));
  Modelica.Blocks.Sources.Constant dummyPhi_supply(k=0.5)
    annotation (Placement(transformation(extent={{104,-70},{122,-52}})));
  Modelica.Blocks.Sources.Constant dummyZeroPower(k=0)
    annotation (Placement(transformation(extent={{-12,-94},{-30,-76}})));

equation
  connect(dummyPhi_supply.y, phiSup) annotation (Line(points={{122.9,-61},{141.45,
          -61},{141.45,-60},{160,-60}}, color={0,0,127}));
  connect(dummyT_supplyAirOut.y, TSup) annotation (Line(points={{118.9,-29},{146,
          -29},{146,-27},{159,-27}}, color={0,0,127}));
  connect(dummyZeroPower.y, Pel) annotation (Line(points={{-30.9,-85},{-60,-85},
          {-60,-100}}, color={0,0,127}));
  connect(dummyZeroPower.y, QHum_flow) annotation (Line(points={{-30.9,-85},{-60,
          -85},{-60,-86},{-90,-86},{-90,-100}}, color={0,0,127}));
  connect(dummyZeroPower.y, QHea_flow) annotation (Line(points={{-30.9,-85},{-60,
          -85},{-60,-86},{-120,-86},{-120,-100}}, color={0,0,127}));
  connect(dummyZeroPower.y, QCoo_flow) annotation (Line(points={{-30.9,-85},{-60,
          -85},{-60,-86},{-150,-86},{-150,-100}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},
            {160,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,100}})),
    Documentation(info="<html><p>
  This model represnts a central air handling unit.
  It can be configured in modular way. Depending on the desired functionalities it will inherit a heat recovery system, a heater, a cooler and a humidifier.
  The type of hmumidifier can be chosen by the user. It will be either steam or adiabatic humidification.
  Dehumidification is realized by sub-cooling only. Hence, if no cooling and heating is implemented, dehumidification will be disabled.
</p>
</html>", revisions="<html>
<ul>
  <li>April, 2020 by Martin Kremer:<br/>
    First Implementation.
  </li>
  <li>February, 2025 by Martin Kremer:<br/>
    Impleted some controler and minor bug fixes.
  </li>
</ul>
</html>"));
end NoModularAHU;
