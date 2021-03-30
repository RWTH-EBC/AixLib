within AixLib.ThermalZones.ReducedOrder.Validation.VDI6007;
package VDI6007AnhangC1 "Validation according to VDI 6007-1 Anhang C1"
  extends Modelica.Icons.ExamplesPackage;

annotation (Documentation(info="<html><p>
  This package contains validation cases for Reduced Order Models
  according to Guideline VDI 6007 Part 1 Anhang C1 (VDI, 2016). The guideline
  defines five test cases in different variants that consecutively test 
  different aspects of building pyhsics behaviour. All tests are based on a 
  simple test room from VDI 2078, either in a medium version (M) or a in 
  heavy version (S). Testcase 14 and 14.1 are based on the heavy version (S) 
  test room from VDI 2078 (1996) and VDI 6020 Part 1 (2001) that is used in 
  some of the test cases from VDI 6007 Part 1, too.
</p>
<p>
  // Comparative results are supplied with the guideline and have been
  calculated using two different programs for electrical circuit
  calculations (for day 1, 10 and 60 in hourly steps). The validation
  procedure is originally thought to verifiy the correct implementation
  of an analytical calculation algorithm defined in the guideline. For
  that, a range of max 0.1 K or max 1 W deviation is allowed. As the
  implementation cannot reflect all aspects of the algorithm, the
  implemented model exceeds these values in some cases.
</p>
<h4>
  References
</h4>
<p>
  VDI. German Association of Engineers Guideline VDI 6007-1 Anhang C1 June 2016.
  Calculation of transient thermal response of rooms and buildings -
  modelling of rooms.
</p>
<p>
  VDI. German Association of Engineers Guideline VDI 6020 September 2016.
  Requirements to be met by calculation methods for the simulation of 
  thermal-energy efficiency of buildings and building installations.
</p>
<p>
  VDI. German Association of Engineers Guideline VDI 2078 June 2015.
  Calculation of thermal loads and room temperatures
  (design cooling load and annual simulation).
</p>
</html>"));
end VDI6007AnhangC1;
