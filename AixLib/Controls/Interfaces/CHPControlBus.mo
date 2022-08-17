within AixLib.Controls.Interfaces;
expandable connector CHPControlBus
  "Connector used for modular CHP models"
  extends Modelica.Icons.SignalBus;

  type RotationSpeed=Real(final unit="1/s", min=0);
  type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);

 // Definition of variables describing combustion engines
  //
  RotationSpeed meaRotEng "Measured engines' speed"
    annotation(Dialog(tab="Operation point",
                                         group="Combustion Engine"));
  Modelica.Units.SI.Power meaFuePowEng
    "Needed fuel power at combustion engines'"
    annotation (Dialog(tab="Operation point", group="Combustion Engine"));
  Modelica.Units.SI.Power meaThePowEng
    "Thermal power output at combustion engines'"
    annotation (Dialog(tab="Operation point", group="Combustion Engine"));
  Modelica.Units.SI.Torque meaTorEng "Engine torque at combustion engines'"
    annotation (Dialog(tab="Operation point", group="Combustion Engine"));
  Modelica.Units.SI.MassFlowRate meaMasFloFueEng
    "Fuel consumption at engines' inlets"
    annotation (Dialog(tab="Operation point", group="Combustion Engine"));
  Modelica.Units.SI.MassFlowRate meaMasFloAirEng
    "Air consumption at engines' inlets"
    annotation (Dialog(tab="Operation point", group="Combustion Engine"));
  Modelica.Units.SI.MassFlowRate meaMasFloCO2Eng
    "CO2 mass flow rates at engines' exhaust outlets"
    annotation (Dialog(tab="Operation point", group="Combustion Engine"));
  Modelica.Units.SI.SpecificHeatCapacity calMeaCpExh
    "Calculated mean specific heat capacity of the exhaust gas flow"
    annotation (Dialog(tab="Operation point", group="Combustion Engine"));
  Modelica.Units.SI.Temperature meaTemInEng
    "Measured coolant temperature at engines' inlets"
    annotation (Dialog(tab="Operation point", group="Combustion Engine"));
  Modelica.Units.SI.Temperature meaTemOutEng
    "Measured coolant temperature at engines' outlets"
    annotation (Dialog(tab="Operation point", group="Combustion Engine"));

  // Definition of variables describing generators
  //
  Modelica.Units.SI.Power meaElPowGen "Electric power at generators' clamps"
    annotation (Dialog(tab="Operation point", group="Generator"));
  Modelica.Units.SI.Current meaCurGen "Electric current at generators' clamps"
    annotation (Dialog(tab="Operation point", group="Generator"));
  Modelica.Units.SI.Torque meaTorGen "Generators' torque"
    annotation (Dialog(tab="Operation point", group="Generator"));
  Real calEtaGen(unit="1")
    "Calculated generators' efficiency"
    annotation(Dialog(tab="Operation point",
                                         group="Generator"));
  Modelica.Units.SI.Power calThePowGen "Thermal loss power"
    annotation (Dialog(tab="Operation point", group="Generator"));

  // Definition of variables describing exhaust heat exchangers
  //
  Modelica.Units.SI.Temperature meaTemExhHexOut
    "Measured exhaust gas temperatures at exhaust heat exchangers' outlets"
    annotation (Dialog(tab="Operation point", group="Exhaust Heat Exchanger"));
  Modelica.Units.SI.Temperature meaTemExhHexIn
    "Measured exhaust gas temperatures at exhaust heat exchangers' inlets"
    annotation (Dialog(tab="Operation point", group="Exhaust Heat Exchanger"));
  Modelica.Units.SI.Power meaThePowOutHex
    "Measured thermal power of exhaust heat exchangers'"
    annotation (Dialog(tab="Operation point", group="Exhaust Heat Exchanger"));
  Modelica.Units.SI.MassFlowRate meaMasFloConHex
    "Measured condensed water mass flow rates at exhaust heat exchangers' outlets"
    annotation (Dialog(tab="Operation point", group="Exhaust Heat Exchanger"));
  Modelica.Units.SI.Temperature meaTemInHex
    "Measured coolant temperature at exhaust heat exchangers' inlets"
    annotation (Dialog(tab="Operation point", group="Exhaust Heat Exchanger"));
  Modelica.Units.SI.Temperature meaTemOutHex
    "Measured coolant temperature at exhaust heat exchangers' outlets"
    annotation (Dialog(tab="Operation point", group="Exhaust Heat Exchanger"));

  // Definition of variables describing CHP units in general
  //
  Modelica.Units.SI.Power meaThePowChp
    "Measured thermal power at CHP units' outlets"
    annotation (Dialog(tab="Operation point", group="CHP Unit"));
  Modelica.Units.SI.Temperature meaTemRetCooChp
    "Measured temperatures at CHP units' coolant return flow"
    annotation (Dialog(tab="Operation point", group="CHP Unit"));
  Modelica.Units.SI.Temperature meaTemSupCooChp
    "Measured temperatures at CHP units' coolant supply flow"
    annotation (Dialog(tab="Operation point", group="CHP Unit"));
  Modelica.Units.SI.VolumeFlowRate preVolFloHea
    "Prescribed coolant volume flow rate inside primary cooling circuit"
    annotation (Dialog(tab="Operation point", group="CHP Unit"));
  SpecificEmission calEmiCO2Chp
    "Calculated specific CO2 emissions of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  SpecificEmission calFueChp
    "Calculated specific fuel consumption of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Real calEtaTheChp(unit="1")
    "Calculated thermal efficiency of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Real calEtaElChp(unit="1")
    "Calculated electric efficiency of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Real calFueUtiChp(unit="1")
    "Calculated fuel utilization rate of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Real modFac(unit="1")
    "Modulation factor of CHP units"
    annotation (Dialog(tab="Operation point", group="CHP Unit"));
  Boolean isOn
    "Indicator if Chp unit is in operation or not (true=On, false=Off)"
    annotation (Dialog(tab="Operation point", group="CHP Unit"));
  Boolean isOnPump
    "Indicator if Chp pump inside the primary cooling circuit is in operation or not (true=On, false=Off)"
    annotation (Dialog(tab="Operation point", group="CHP Unit"));
  Boolean volFlowControlHeating
    "= false to use a prescibed heating circuit mass flow, = true to use a prescribed volume flow"
    annotation (Dialog(tab="Operation point", group="CHP Unit"));

  annotation (Documentation(revisions="<html><ul>
  <li>January, 2019, by Julian Matthes:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">issue
    6</a><u><span style=\"color: #0000ff;\">67</span></u>).
  </li>
</ul>
</html>", info="<html>
<p>
  This connector is a base connector used forcombined heat and power
  units and contains typical variables that may be measured in the
  modular Chp models.
</p>
<p>
  Typically, a Chp unit consists of three main components: Combustion
  engine, a exhaust heat exchanger and a generator. The controlled
  parameters are listed below.
</p>
</html>"));

end CHPControlBus;
