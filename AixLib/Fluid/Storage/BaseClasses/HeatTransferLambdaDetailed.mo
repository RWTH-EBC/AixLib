within AixLib.Fluid.Storage.BaseClasses;
model HeatTransferLambdaDetailed
  "Enhanced heat transfer model with buoyancy, effective conductivity and switchable heat transfer of HC, falling-film and fittings losses"
 extends AixLib.Fluid.Storage.BaseClasses.PartialHeatTransferLayers;

  Modelica.Units.SI.HeatFlowRate[n - 1] qFlow
    "Heat flow rate from segment i+1 to i";
  Modelica.Units.SI.HeatFlowRate[n - 1] qFall
    "enthalpy flow as heat flow from falling water at storage wall";
  Modelica.Units.SI.HeatFlowRate[n - 1] qHC1lambda
    "Heat flow rate through steel HC1";
  Modelica.Units.SI.Temperature TOut=293.15;

  Modelica.Units.SI.HeatFlowRate[3] qFitting
    "enthalpy flow as heat flow from falling water at pipe fittings";

  // Integer parameters for sweeping (1=true, 0=false)
  parameter Integer enableHC_int      = 1 "Toggle vertical heat transfer mechanism via HC (1=true, 0=false)";
  parameter Integer enableFalling_int = 0 "Toggle falling-film mechanism (1=true, 0=false)";
  parameter Integer enableFitting_int = 0 "Toggle heat entrainment at fittings mechanism (1=true, 0=false)";

  // Convert integers to booleans within the model
  final Boolean enableHC      = (enableHC_int == 1);
  final Boolean enableFalling = (enableFalling_int == 1);
  final Boolean enableFitting = (enableFitting_int == 1);

protected
  parameter Real kappa=0.41 "Karman constant";
  parameter Modelica.Units.SI.Length height=data.hTank/n
    "Height of fluid layers";
  parameter Real beta=350e-6 "Thermal expansion coefficient in 1/K";
  parameter Modelica.Units.SI.Area A=Modelica.Constants.pi/4*data.dTank^2
    "Area of heat transfer between layers";
  parameter Modelica.Units.SI.Density rho=1000
    "Density, used to compute fluid mass";
  parameter Modelica.Units.SI.SpecificHeatCapacity c_p=4180
    "Specific heat capacity";
                              //
  Modelica.Units.SI.TemperatureDifference dT[n - 1]
    "Temperature difference between adjoining volumes";
  Modelica.Units.SI.ThermalConductance[n - 1] k
    "Effective heat transfer coefficient";
  Modelica.Units.SI.ThermalConductivity[n - 1] lambda
    "Effective heat conductivity";
  parameter Modelica.Units.SI.ThermalConductivity lambdaWater=0.64
    "Thermal conductivity of water";
  parameter Modelica.Units.SI.ThermalConductivity lambdaHC=65
    "Thermal conductivity of heating coil (steel)";
  parameter Modelica.Units.SI.Area A_HC=0.005112
    "Area of heating coil in m2, here diameter of ~8 cm";

  Modelica.Units.SI.TemperatureDifference dF[n - 1]
    "Temperature difference layer[i]-layer[1]";
  Modelica.Units.SI.TemperatureDifference dGr[n - 1]
    "no zero Temperature difference layer[i]-layer[1]";

  parameter Modelica.Units.SI.CoefficientOfHeatTransfer pFall=0.5013
    "Heat loss rate at storage Wall [W/(m^2K)]";
  parameter Modelica.Units.SI.Length sFall=0.008
    "Thickness of water fall at the storage wall";
  parameter Modelica.Units.SI.Area AFall=Modelica.Constants.pi*data.dTank*sFall
    "Area from water fall along the storage wall";
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer pFitting=3.5
    "Heat loss at fittings";
  parameter Modelica.Units.SI.Area AFitting=0.0055
    "Area of fittings";

equation

  for i in 1:n-1 loop
    dT[i] = therm[i].T-therm[i+1].T;
    lambda[i]^2=noEvent(max((9.81*beta*dT[i]/height)*(2/3*rho*c_p*kappa*height^2)^2,0));
    k[i]=(noEvent(smooth(1,if dT[i]>0 then lambda[i] else 0))+lambdaWater)*A/height;
    qFlow[i] = k[i]*dT[i];
  end for;

  // vertical heat transport because of the HC (qHC1lambda)
  for i in 1:n-2 loop
    qHC1lambda[i] = if enableHC then lambdaHC * A_HC * dT[i] / height else 0;
  end for;
  qHC1lambda[n - 1] = 0;

  // enthalpy transport as heat transport from water falling-film at storage wall (qFall)
  for i in 1:n-1 loop
    dF[i] = therm[i+1].T-therm[1].T;
    dGr[i] = noEvent(max(abs(dF[i]), 0.01));
    // dGr[i]^2 = noEvent(max((dF[i])^2,(0.01)^2));
    qFall[i] = if enableFalling then 0.092 * Modelica.Constants.pi * data.dTank * pFall * (therm[i+1].T - TOut) * i * height / dGr[i] else 0;
  end for;

  // enthalpy transport as heat transport from falling water in fittings (qFitting)
  qFitting[1] = if enableFitting then 2 * (therm[1].T-TOut)*pFitting*AFitting else 0; // 2 fittings at lowest layer
  qFitting[2] = if enableFitting then (therm[n-1].T-TOut)*pFitting*AFitting else 0;   // 1 fitting at second upmost layer
  qFitting[3] = if enableFitting then (therm[n].T-TOut)*pFitting*AFitting else 0;     // 1 fitting at upmost layer

// Positive heat flows here mean negative heat flows for the fluid layers
  therm[1].Q_flow = qFlow[1]+qHC1lambda[1]+sum(qFall[i] for i in 1:n-1)+sum(qFitting[i] for i in 1:3);
  for i in 2:n-1 loop
       therm[i].Q_flow = -qFlow[i-1]+qFlow[i]-qHC1lambda[i-1]+qHC1lambda[i]-qFall[i-1];
  end for;
  therm[n].Q_flow = -qFlow[n-1]-qFall[n-1];
annotation (
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics),
  Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>This model is based on HeatTransferLambdaEff and implements the heat transfer mechanisms in buffer storage layers as presented in the Master Thesis of Lennard Simon. It considers three main mechanisms: </p>
<ul>
<li>Vertical heat transfer via heating coil, adapted by Lennard Simon based on the work of Brunotte. </li>
<li>Falling-film mechanism based on Brunotte. </li>
<li>Heat entrainment at fittings mechanism as described by Steinweg et al. (<b>Off per default</b>)</li>
</ul>
<p>An effective heat conductivity is calculated by combining these contributions. All new mechanisms can be switched on/off so that with all three mechanisms switched off it calculates the same as HeatTransferLambdaEffSmooth. </p>
<p><b><span style=\"color: #008000;\">Sources</span></b> </p>
<p><b>Lennard Simon</b>: Master Thesis on heat transfer in buffer storages, 2022.</p>
<p><b>Joachim Brunotte</b>: <i>Dynamische Beschreibung der W&auml;rmeverteilung in Warmwasserspeichern mit innenliegenden W&auml;rme&uuml;bertragern</i>, VDI-Verlag, 1996.</p>
<p><b>Steinweg, Kliem &amp; Rockendorf</b>: <i>Abschlussbericht Einrohrzirkulation an Speicheranschl&uuml;ssen - Bewertung und Vermeidung</i>, Technical report, 2014. </p>
</html>",
  revisions="<html>
  <ul>
    <li><i>March 31, 2025</i> by Ben Kadereit: Implemented new heat transfer mechanisms based on the Master Thesis of Lennard Simon.</li>
    <li><i>October 12, 2016</i> by Marcus Fuchs: Added comments and fixed documentation.</li>
    <li><i>October 11, 2016</i> by Sebastian Stinner: Added to AixLib.</li>
    <li><i>December 10, 2013</i> by Kristian Huchtemann: New implementation in source code. Documentation.</li>
    <li><i>October 2, 2013</i> by Ole Odendahl: Added documentation and formatted appropriately.</li>
  </ul>
</html>"),Icon(graphics={Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,255},
          textString="%name")}),
    experiment(
      StopTime=86400,
      Interval=10,
      __Dymola_Algorithm="Dassl"));
end HeatTransferLambdaDetailed;
