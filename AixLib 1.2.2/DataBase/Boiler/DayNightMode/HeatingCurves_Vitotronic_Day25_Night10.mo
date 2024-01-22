within AixLib.DataBase.Boiler.DayNightMode;
record HeatingCurves_Vitotronic_Day25_Night10
  "Heating Curves for Vitotronic Controller, TsetDay = 25degC, TsetNight = 10degC "
  extends HeatingCurvesDayNightBaseDataDefinition(
    name="HC_Vitoronic_Day25_Night10",
    varFlowTempDay=[0,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8; -20,67,71,75,79.5,
        84,88.25,92.5,96.25,100; -15,63,66.5,70,74.5,79,82.5,86,89.5,93; -10,
        59.5,62.5,65.5,69,72.5,76.25,80,83.5,87; -5,55,58,61,64,67,70.25,73.5,
        76.75,80; 0,51,53.5,56,58.75,61.5,64,66.5,69.25,72; 5,47,48.75,50.5,
        53,55.5,57.75,60,62.25,64.5; 10,42.5,43.75,45,47,49,50.75,52.5,54.25,
        56; 15,37.5,38.25,39,40.5,42,43.5,45,46,47; 20,32,32.5,33,34,35,35.5,
        36,36.75,37.5],
    varFlowTempNight=[0,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8; -20,40,43.25,
        46.5,49.75,53,56.25,59.5,62.25,65; -15,36.5,39,41.5,44.25,47,49.75,
        52.5,55.25,58; -10,32,34.25,36.5,38.75,41,43.25,45.5,47.75,50; -5,
        27.5,29.5,31.5,33.25,35,36.5,38,39.75,41.5; 0,23,24,25,26.5,28,29,30,
        31.25,32.5; 5,15,16.5,18,19,20,20.5,21,22,23; 10,10,10,10,10,10,10,10,
        10,10; 15,10,10,10,10,10,10,10,10,10; 20,10,10,10,10,10,10,10,10,10]);

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Collection of Heating Curves for Viessmann Vitotronic Controller
</p>
<ul>
  <li>Set temperature day: 25°C
  </li>
  <li>Set temperature night: 10°C
  </li>
</ul>
<p>
  Source:
</p>
<ul>
  <li>Product: Vitotronic 200
  </li>
  <li>Manufacturer: Viessmann
  </li>
  <li>Broschure: VITOTRONIC 200 - Heizungsanlage mit
  witterungsgefuehrter, digitaler Kessel- und Heizkreisregelung; 7/2002
  </li>
</ul>
</html>",
      revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>July 2, 2013&#160;</i> by Ole Odendahl:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end HeatingCurves_Vitotronic_Day25_Night10;
