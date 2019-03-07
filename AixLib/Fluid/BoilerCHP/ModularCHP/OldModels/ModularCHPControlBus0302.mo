within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
expandable connector ModularCHPControlBus0302
  "Connector used for modular CHP models"
  extends Modelica.Icons.SignalBus;

  type RotationSpeed=Real(final unit="1/s", min=0);
  type SpecificEmission=Real(final unit="g/(kW.h)", min=0.0001);

  // Definition of parameters describing modular approach in general
  //
  parameter Integer nEngSen=1 "Number of combustion engines"
    annotation(Dialog(              group="Modular approach"),
               HideResult=true);
  parameter Integer nGenSen=1 "Number of generators"
    annotation(Dialog(              group="Modular approach"),
               HideResult=true);
  parameter Integer nExhHexSen=1 "Number of exhaust heat exchanger"
    annotation(Dialog(              group="Modular approach"),
               HideResult=true);
  parameter Integer nChpSen=1 "Number of CHP units"
    annotation(Dialog(              group="Modular approach"),
               HideResult=true);

  // Definition of variables describing combustion engines
  //
  RotationSpeed meaRotEng[nEngSen] "Array of measured engines' speed"
    annotation(Dialog(tab="Operation point",
                                         group="Combustion Engine"));
  Modelica.SIunits.Power meaFuePowEng[nEngSen]
    "Array of needed fuel power at combustion engines'"
    annotation(Dialog(tab="Operation point",
                                         group="Combustion Engine"));
  Modelica.SIunits.Power meaThePowEng[nEngSen]
    "Array of thermal power output at combustion engines'"
    annotation(Dialog(tab="Operation point",
                                         group="Combustion Engine"));
  Modelica.SIunits.Torque meaTorEng[nEngSen]
    "Array of engine torque at combustion engines'"
    annotation(Dialog(tab="Operation point",
                                         group="Combustion Engine"));
  Modelica.SIunits.MassFlowRate meaMasFloFueEng[nEngSen]
    "Array of calculated fuel consumption at engines' inlets"
    annotation(Dialog(tab="Operation point",
                                         group="Combustion Engine"));
  Modelica.SIunits.MassFlowRate meaMasFloAirEng[nEngSen]
    "Array of calculated air consumption at engines' inlets"
    annotation(Dialog(tab="Operation point",
                                         group="Combustion Engine"));
  Modelica.SIunits.MassFlowRate meaMasFloCO2Eng[nEngSen]
    "Array of measured CO2 mass flow rates at engines' exhaust outlets"
    annotation(Dialog(tab="Operation point",
                                         group="Combustion Engine"));
  Modelica.SIunits.Temperature meaTemOutEng[nEngSen]
    "Array of measured coolant temperature at engines' outlets"
    annotation(Dialog(tab="Operation point",
                                         group="Combustion Engine"));

  // Definition of variables describing generators
  //
  Modelica.SIunits.Power meaElPowGen[nGenSen]
    "Array of electric power at generators'"
    annotation(Dialog(tab="Operation point",
                                         group="Generator"));
  Modelica.SIunits.Current meaCurGen[nGenSen]
    "Array of electric current at generators'"
    annotation(Dialog(tab="Operation point",
                                         group="Generator"));
  Modelica.SIunits.Torque meaTorGen[nGenSen]
    "Array of generators' torque"
    annotation(Dialog(tab="Operation point",
                                         group="Generator"));
  Real calEtaGen[nGenSen](unit="1")
    "Array of calculated generators' efficiency"
    annotation(Dialog(tab="Operation point",
                                         group="Generator"));

  // Definition of variables describing exhaust heat exchangers
  //
  Modelica.SIunits.Temperature meaTemExhOutHex[nExhHexSen]
    "Array of measured exhaust gas temperatures at exhaust heat exchangers' outlets"
    annotation (Dialog(tab="Operation point",
                                           group="Exhaust Heat Exchanger"));
  Modelica.SIunits.Temperature meaTemExhInHex[nExhHexSen]
    "Array of measured exhaust gas temperatures at exhaust heat exchangers' inlets"
    annotation (Dialog(tab="Operation point",
                                           group="Exhaust Heat Exchanger"));
  Modelica.SIunits.Power meaThePowOutHex[nExhHexSen]
    "Array of measured thermal power of exhaust heat exchangers'"
    annotation (Dialog(tab="Operation point",
                                           group="Exhaust Heat Exchanger"));
  Modelica.SIunits.MassFlowRate meaMasFloConHex[nExhHexSen]
    "Array of measured condensed water mass flow rates at exhaust heat exchangers' outlets"
    annotation (Dialog(tab="Operation point",
                                           group="Exhaust Heat Exchanger"));

  // Definition of variables describing CHP units in general
  //
  Modelica.SIunits.Power meaThePowChp[nChpSen]
    "Array of measured thermal power at CHP units' outlets"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Modelica.SIunits.Temperature meaTemRetChp[nChpSen]
    "Array of measured temperatures at CHP units' return flow"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Modelica.SIunits.Temperature meaTemSupChp[nChpSen]
    "Array of measured temperatures at CHP units' supply flow"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  SpecificEmission calEmiCO2Chp[nChpSen]
    "Array of calculated specific CO2 emissions of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  SpecificEmission calFueChp[nChpSen]
    "Array of calculated specific fuel consumption of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Real calEtaTheChp[nChpSen](unit="1")
    "Array of calculated thermal efficiency of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Real calEtaElChp[nChpSen](unit="1")
    "Array of calculated electric efficiency of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Real calFueUtiChp[nChpSen](unit="1")
    "Array of calculated fuel utilization rate of CHP units"
    annotation(Dialog(tab="Operation point",
                                         group="CHP Unit"));
  Real modFac[nChpSen](unit="1")
    "Modulation factor of CHP units"
  annotation (Dialog(tab="Operation point", group="CHP Unit"));
  Boolean isOn[nChpSen]
    "Indicator if Chp unit is in operation or not (true=On, false=Off)"
  annotation (Dialog(tab="Operation point", group="CHP Unit"));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 25, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/479\">issue 479</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This connector is a base connector used for modular heat pumps and contains 
typical variables that may be measured in the modular heat pump models.
</p>
<h4>Overview of sensors' positions</h4>
<p>
Typically, a heat pump consists of four main components: A compressor, a
condenser, an expansion valve and an evaporator. Furthermore, considering the 
perspective of the refrigerant used in the heat pump, the evaporator is the 
source and the condenser is the sink. Therefore, it is assumed that the heat 
pump has six sensor positions:
</p>
<ol>
<li>Compressor's outlet</li>
<li>Condenser's outlet</li>
<li>Expansion valve's outlet</li>
<li>Evaporator's outlet</li>
<li>Source's inlet and outlet</li>
<li>Sink's inlet and outlet</li>
</ol>
<h4>Overview of variables</h4>
<p>
Four different sensors are proposed at refrigerant's side:
</p>
<ol>
<li>Absolute pressure</li>
<li>Temperature</li>
<li>Mass flow rate</li>
<li>Quality</li>
</ol>
<p>
Three different sensors are proposed at source's and sink's sides:
</p>
<ol>
<li>Absolute pressure</li>
<li>Temperature</li>
<li>Mass flow rate</li>
</ol>
</html>"));

end ModularCHPControlBus0302;
